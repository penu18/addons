AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "dark damage proc"
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
ENT.HauntTime 		= 0
ENT.DecayTime 		= 1.5

function ENT:Initialize()

	local size = self.PhxSSize

	if ( DLib && istable( DLib ) ) then
		self.PhxMass = math.Clamp( self.PhxMass, 1, self.PhxMass )
	end
	
	if ( !game.SinglePlayer() && CLIENT ) || ( SERVER ) then
		local target = self:GetParent()

		if ( IsValid( target ) ) then
			ParticleEffectAttach( "umbra_darken", 1, target, 1 )
			
			local fxData = EffectData()
			fxData:SetEntity( target )
		
			util.Effect( "dark_infect", fxData )
			
			-- target:EmitSound( "scifi.dark.linger" )
			target:EmitSound( "scifi.corruptor.impact0" .. math.random( 1, 6 ) )
			target:EmitSound( "scifi.dark.haunt." .. math.random( 1, 7 ) )
		end
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

		self.DieTime = CurTime() + self.LifeTime
		
		local target = self:GetParent()

		if ( IsValid( target ) ) then
			-- if ( target:GetMaxHealth() < 150 ) then
				-- target:SetNWBool( "dark_haunted", true )
				target:SetNWInt( "dark_haunted_stacks", 1 )
			-- end
		end
	end
	
	self.HauntTime = CurTime() + self.DecayTime

end

function ENT:Think()

	if ( SERVER ) then
		local target = self:GetParent()
		
		if ( !IsValid( target ) ) then
			self:KillSilent()
			return true
		end
	
		if ( self.HauntTime < CurTime() ) then
			local iStacks = target:GetNWInt( "dark_haunted_stacks" )

			if ( iStacks - 1 < 1 ) then
				self:KillSilent()
			else
				target:SetNWInt( "dark_haunted_stacks", iStacks - 1 )
				target:EmitSound( "scifi.dark.haunt." .. math.random( 1, 7 ) )
			end
			
			ParticleEffectAttach( "umbra_darken", PATTACH_ABSORIGIN_FOLLOW, target, 1 )
			
			local fxData = EffectData()
			fxData:SetEntity( target )
		
			util.Effect( "dark_infect", fxData )
			
			self.HauntTime = CurTime() + self.DecayTime
		end

		if ( target:IsPlayer() && !target:Alive() ) then
			self:KillSilent()
--			target:EmitSound( "scifi.dark.succumb" )
		
			return true
		end
		
		if ( target:IsNPC() && target:Health() <= 1 ) then
			target:SetNWBool( "dark_haunted", false )
			
			ParticleEffectAttach( "umbra_darken", PATTACH_ABSORIGIN_FOLLOW, target, 1 )
			
			local fxData = EffectData()
			fxData:SetEntity( target )
		
			util.Effect( "dark_infect", fxData )
			
			local pOwner = self.Owner:GetActiveWeapon()
			if ( IsValid( self.Owner ) && IsValid( pOwner ) ) then
				target:TakeDamage( 5, self.Owner, pOwner )
				
--				target:EmitSound( "scifi.dark.succumb" )
			end
		
			self:KillSilent()
			return true
		end

		self:NextThink( CurTime() + 0 )
		
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

function ENT:OnRemove()

	if ( !SERVER ) then return end

	local parent = self:GetParent()

	if ( !IsValid( parent ) ) then
		return 
	end

	parent:EmitSound( "scifi.corruptor.impact0." .. math.random( 1, 6 ) )
	-- parent:EmitSound( "scifi.dark.release" )
	parent:StopParticles()

	parent:SetNWInt( "dark_haunted_stacks", 0 )
	parent:SetNWBool( "dark_haunted", false )
	
end