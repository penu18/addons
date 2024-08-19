AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "curse damage proc"
ENT.Phx 			= SOLID_NONE
ENT.PhxMType 		= MOVETYPE_FLY
ENT.PhxCGroup 		= COLLISION_GROUP_IN_VEHICLE
ENT.PhxSSize		= 1
ENT.PhxSProp 		= "item"
ENT.PhxMass 		= 0
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.PhxElastic 		= 0
ENT.LifeTime		= 360

ENT.FxRemove		= "doom_dissolve"

function ENT:Initialize()

	local size = self.PhxSSize

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

end

ENT.HurtTime = 0

function ENT:Think()

	if ( SERVER ) && ( self.HurtTime <= CurTime() ) then
		self:XPlode()
		self.HurtTime = CurTime() + 1
	end
	
	if ( SERVER ) then
		self:NextThink( CurTime() + self.SvThinkDelay )
		
		if ( self:WaterLevel() > 2 ) then
			self:KillSilent()
		end
		
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

	local parent = self:GetParent()
	
	if ( !IsValid( parent ) ) then 
		self:KillSilent( false, 0 )
	end

	local amp = GetConVarNumber( "sfw_damageamp" )

	if ( parent:IsPlayer() && !parent:Alive() ) then
		self.Owner:StopParticles()
		self:KillSilent()
	end
	
	if ( SERVER ) and ( IsValid( parent ) && parent:GetClass() ~= "npc_combinegunship" ) then
		local iDmg = math.random( 1, 4 ) * amp

		ParticleEffectAttach( "dark_dps_fx", 1, parent, 1 )
		
		self:DealDirectDamage( bit.band( DMG_BULLET, DMG_RADIATION, DMG_PREVENT_PHYSICS_FORCE ), iDmg, parent )
	end

end

function ENT:OnRemove()

	local parent = self:GetParent()

	if ( !IsValid( parent ) ) then return end

	parent:SetNWBool( "defiled", false )
	
	parent:SetColor( Color( 255, 255, 255, 255 ) )
	
end