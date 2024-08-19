AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "ice damage proc"
ENT.Phx 			= SOLID_NONE
ENT.PhxMType 		= MOVETYPE_FLY
ENT.PhxCGroup 		= COLLISION_GROUP_IN_VEHICLE
ENT.PhxSSize		= 1
ENT.PhxSProp 		= "item"
ENT.PhxMass 		= 0
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.PhxElastic 		= 0
ENT.LifeTime		= 2
ENT.TargetCycle 	= 0
ENT.FreezeLevel = 0
ENT.dFreezeLevel = 0

local tDestructables = {
	["npc_turret_ceiling"] = true,
	["npc_turret_floor"] = true,
	["npc_rollermine"] = true
}

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "LifeTime" )
	self:NetworkVar( "Int", 1, "DieTime" )

end

local snd_breakfree = Sound( "/effects/ice_hit.wav" )

if ( SERVER ) then
	util.AddNetworkString( "SciFiBreakableIce" )
	util.PrecacheSound( snd_breakfree )
end

net.Receive( "SciFiBreakableIce", function( iMessageLength, entPlayer )

	local bMashingSpaceBar = net.ReadBool()
	local entTarget = entPlayer
	local entStatus = net.ReadEntity()
	
	if !( bMashingSpaceBar && IsValid( entTarget ) && entTarget:Alive() && IsValid( entStatus ) ) then return end
	
	entStatus:SetDieTime( entStatus:GetDieTime() - 0.2 )
			
	local fFraction = 1 - ( entStatus:GetDieTime() - CurTime() ) / entStatus.LifeTime
	
	util.ScreenShake( entTarget:EyePos(), 12 * fFraction, 2 * fFraction, 0.25 * fFraction, 512 * fFraction )
	
	-- entTarget:EmitSound( snd_breakfree, 50 + 20 * fFraction, 80 + 40 * fFraction, 1, CHAN_STATIC ) 
	-- EmitSound( snd_breakfree, entTarget:EyePos(), entStatus:EntIndex(), CHAN_STATIC, 1, 50 + 20 * fFraction, SND_NOFLAGS, 80 + 40 * fFraction )
	
end )

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

		self:SetDieTime( CurTime() + self.LifeTime )
		self:SetLifeTime( self.LifeTime )
		
		ParticleEffectAttach( "ice_crystals_3", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), 1 )
		
		-- self:FreezeTarget( self:GetParent() )
	end
	
	if ( CLIENT ) then
		self.FreezeLevel = 100
	end
	
	self:GetParent().m_hFreezeDamageEntity = self

end

function ENT:FreezeTarget()

	local entTarget = self:GetParent()

	if ( !IsValid( entTarget ) ) then return end
	
	-- if ( entTarget:GetMaxHealth() < 150 ) then
		-- entTarget:SetNWBool( "bliz_frozen", true )
	-- end
	
	local nLT = self:GetDieTime() - CurTime()
	
	if ( entTarget:IsNPC() ) then
		entTarget:StopMoving()
		entTarget:SetSchedule( SCHED_FAIL )
		if ( !entTarget:IsCurrentSchedule( SCHED_NPC_FREEZE ) ) then
			entTarget:SetSchedule( SCHED_NPC_FREEZE )
		end
		entTarget:SetCycle( self.TargetCycle ) 
		entTarget:SetPlaybackRate( 0 )
		entTarget:SetArrivalSpeed( 0 )
		entTarget:NextThink( CurTime() + nLT + 0.016 )
	elseif ( entTarget:IsPlayer() ) then
		entTarget:AddFlags( FL_FROZEN )
	end
	
	local ed = EffectData()
	ed:SetOrigin( entTarget:GetPos() )
	ed:SetEntity( entTarget )
	ed:SetScale( nLT )
	util.Effect( "cryon_frozen", ed, true, true )
	
	local ed2 = EffectData()
	ed2:SetOrigin( entTarget:GetPos() )
	ed2:SetEntity( entTarget )
	ed2:SetScale( nLT )
	util.Effect( "cryon_hull", ed2, true, true )
	
	ParticleEffectAttach( "ice_freezing", PATTACH_ABSORIGIN_FOLLOW, entTarget, 1 )
	self:EmitSound( "scifi.cryo.freeze" ) --"scifi.bliz.freeze" )
	
	self.entTargetCycle = entTarget:GetCycle()

end

local bSpaceDown, dSpaceDown = false, false
ENT.FreezeTick = 0
function ENT:Think()

	local entTarget = self:GetParent()

	if ( self.FreezeLevel < 100 ) then
		if ( SERVER ) then
			if ( !IsValid( entTarget ) ) then
				self:KillSilent()
				return true
			end
				
			if ( entTarget:IsNPC() ) then
				local nSpeedScale = 1 - self.FreezeLevel * 0.01
				
				entTarget:SetPlaybackRate( nSpeedScale )
				entTarget:SetArrivalSpeed( nSpeedScale )
				
				if ( !self.ParentGroundSpeed ) then
					self.ParentGroundSpeed = entTarget:GetInternalVariable( "m_flGroundSpeed" )
				end
				
				entTarget:SetSaveValue( "m_bSpeedModActive", true )
				entTarget:SetSaveValue( "m_iSpeedModSpeed", 0.1 )
				entTarget:SetSaveValue( "m_iSpeedModRadius", 16384 )
				entTarget:SetSaveValue( "m_flGroundSpeed", nSpeedScale )
				entTarget:SetSaveValue( "speed", nSpeedScale )
				
				-- self.FreezeTick = CurTime() + ( FrameTime() + self.FreezeLevel * 0.01 )
				-- if ( self.FreezeTick < CurTime() ) then
					-- entTarget:NextThink( self.FreezeTick )
				-- end
			end
		end
	else
		if ( SERVER && self.dFreezeLevel < 100 ) then
			self.TargetCycle = entTarget:GetCycle()
			self:FreezeTarget()
		end

		if ( CLIENT ) then
			self:SetNextClientThink( 0 )

			if !( IsValid( entTarget ) && entTarget:IsPlayer() ) then return end

			bSpaceDown = input.IsKeyDown( KEY_SPACE )
			
			if ( bSpaceDown && !dSpaceDown ) then
				net.Start( "SciFiBreakableIce" )
				net.WriteBool( bSpaceDown )
				net.WriteEntity( self )
				net.SendToServer()
				
				local fFraction = 1 - ( self:GetDieTime() - CurTime() ) / self:GetLifeTime()
				entTarget:EmitSound( snd_breakfree, 40 + 20 * fFraction, 80 + 40 * fFraction, 1, CHAN_STATIC ) 
			end
			
			dSpaceDown = bSpaceDown
		end

		if ( SERVER ) then
			if ( !IsValid( entTarget ) ) then
				self:KillSilent()
				return true
			end
				
			if ( entTarget:IsNPC() ) then
				entTarget:SetPlaybackRate( 0 )
				entTarget:SetArrivalSpeed( 0 )
			end

			if ( entTarget:IsPlayer() ) then
				if ( !entTarget:Alive() ) then
					self:KillSilent()
					return true
				end
			end
			
			if ( entTarget:Health() <= 1 ) then
				entTarget:SetNWBool( "bliz_frozen", false )
				
				if ( entTarget:IsNPC() ) then
					entTarget:SetSchedule( SCHED_WAKE_ANGRY )
				end
				
				ParticleEffectAttach( "ice_freezing_release", 1, entTarget, 1 )
	--			entTarget:EmitSound( "scifi.bliz.breakfree" )
						
				local sTargetClass = entTarget:GetClass()
				
				if ( tDestructables[ sTargetClass ] ) then
					entTarget:SetShouldServerRagdoll( false )
				else
					entTarget:SetShouldServerRagdoll( true )
				end
				
				local pOwner, pWeapon
				pOwner = self:GetValidOwner()
				
				if ( pOwner:IsPlayer() || pOwner:IsNPC() ) then
					pWeapon = pOwner:GetActiveWeapon()
				else
					pWeapon = Entity( 0 )
				end
				
				if ( !IsValid( pWeapon ) ) then
					pWeapon = Entity( 0 )
				end
				
				if ( IsValid( pOwner ) ) then
					entTarget:TakeDamage( 5, pOwner, pWeapon )
					
					if ( entTarget:Health() <= entTarget:GetMaxHealth() * -0.25 ) then
						self:EmitSound( "scifi.bliz.shatter" )
						DoShatterRagdolls( entTarget:EyePos() )
					else
						self:EmitSound( "scifi.bliz.freeze" )
						DoFreezeRagdolls( entTarget:EyePos() )
					end
				end
			
				self:KillSilent()
				return true
			end
		end
	end
	
	self.dFreezeLevel = self.FreezeLevel

	self:NextThink( CurTime() + 0 )

	if ( IsValid( self ) ) && ( self.LifeTime > 0 ) && ( self:GetDieTime() <= CurTime() ) then
		self:KillSilent( false, 0 )
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
	
	parent.m_hFreezeDamageEntity = nil
	
	if ( parent:IsNPC() ) then
		parent:NextThink( CurTime() )
		parent:SetSchedule( SCHED_WAKE_ANGRY )
		parent:StopMoving()
	elseif ( parent:IsPlayer() ) then
		parent:RemoveFlags( FL_FROZEN )
	end

	parent:EmitSound( "scifi.bliz.breakfree" )
	parent:StopParticles()

	ParticleEffectAttach( "ice_freezing_release", 1, parent, 1 )
	parent:SetNWBool( "bliz_frozen", false )
	
end