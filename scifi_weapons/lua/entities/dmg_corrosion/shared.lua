AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "corrosive damage proc"
ENT.Phx 			= SOLID_NONE
ENT.PhxMType 		= MOVETYPE_FLY
ENT.PhxCGroup 		= COLLISION_GROUP_IN_VEHICLE
ENT.PhxSSize		= 1
ENT.PhxSProp 		= "item"
ENT.PhxMass 		= 0
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.PhxElastic 		= 0
ENT.LifeTime		= 5

ENT.FxRemove		= "corro_end"

ENT.SndImpact 		= "scifi.dmg.acidburn"
ENT.NextDamageTick = 0

function ENT:Initialize()

	local size = self.PhxSSize

	if ( DLib && istable( DLib ) ) then
		self.PhxMass = math.Clamp( self.PhxMass, 1, self.PhxMass )
	end

	if ( SERVER ) then
		self:SetMoveType( self.PhxMType )
		self:SetMoveCollide( self.PhxMColl )
		self:PhysicsInitSphere( size, self.PhxSProp )
		self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
		self:SetCollisionGroup( self.PhxCGroup )
		self:DrawShadow( false )
		self:SetNoDraw( true )
		self:SetElasticity( self.PhxElastic )
		self:SetModel( "models/dav0r/hoverball.mdl" )
		self:SetMaterial( "vgui/white" )
		
		local phys = self:GetPhysicsObject()
		if ( !IsValid( phys ) ) then DevMsg( "@"..self:GetClass().." : !Error; Invalid physics object. Removing! " ) self:Remove() return end
		phys:EnableGravity( self.PhxGrav )
		phys:EnableDrag( self.PhxDrag )
		phys:SetMass( self.PhxMass )

		self:SetPhysicsAttacker( self.Owner, self.LifeTime )
		self.DieTime = CurTime() + self.LifeTime
	end
	
	if ( !game.SinglePlayer() && SERVER ) || ( CLIENT ) then
		local parent = self:GetParent()
		
		if ( IsValid( parent ) ) then
			ParticleEffectAttach( "corro_proc", 1, parent, 1 )
		end
	end
	
	self.NextDamageTick = 0

end

function ENT:Think()

	if ( SERVER ) then
		self:XPlode()
	end
	
	if ( SERVER ) then
		self:NextThink( CurTime() + self.SvThinkDelay )
		
		if ( IsValid( self ) ) && ( self.LifeTime > 0 ) && ( self.DieTime <= CurTime() ) then
			self:KillSilent( false, 0 )
		end
	end
	
	return true 
	
end

function ENT:PhysicsCollide( data, phys )

end

function ENT:OnTakeDamage( CTakeDamageInfo )

end

function ENT:XPlode()

	if ( self.NextDamageTick > CurTime() ) then return end
	self.NextDamageTick = CurTime() + 0.2

	local parent = self:GetParent()

	local amp = GetConVarNumber( "sfw_damageamp" )

	if ( parent:IsPlayer() && !parent:Alive() ) then
		parent:StopParticles()
		self:KillSilent()
	end
	
	if ( SERVER ) and ( IsValid( parent ) && parent:GetClass() ~= "npc_combinegunship" ) then
		local iDmg = math.random( 0.2, 1.2 ) * amp
		
		if ( parent:IsPlayer() && parent:Armor() > 0 ) then
			iDmg = iDmg * 0.75
		end
		
		DoElementalEffect( { Element = EML_DISSOLVE_CORROSIVE, Attacker = self.Owner, Origin = parent:GetPos(), Target = parent } )
		
		self:DealDirectDamage( bit.band( DMG_DIRECT, DMG_PREVENT_PHYSICS_FORCE, DMG_BLAST ), iDmg, parent )
		parent:EmitSound( self.SndImpact )
		
	end

end

function ENT:OnRemove()

	local parent = self:GetParent()

	if ( !IsValid( parent ) ) then return end

	parent:SetNWBool( "edmg_corrosive", false )
	
	parent:SetColor( Color( 255, 255, 255, 255 ) )
	
end