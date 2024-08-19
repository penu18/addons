AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.Spawnable 		= true
ENT.Category		= "Darken217's Scifi Items"

ENT.PrintName 		= "Impure Spectrum"
ENT.NewHitMechanic 	= false
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.LifeTime		= 360
--ENT.RMdl 			= "a/little/something/something.mdl"
ENT.PhxCGroup 		= COLLISION_GROUP_WEAPON
ENT.PhxSSize		= 6
ENT.PhxMaxVelocity 	= 3200 --9200 --16384
ENT.PhxMass 		= 20
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxBuoyancy 	= 4
ENT.FxTracerNew 	= true
ENT.FxTracer 		= "umbra_ammo" 
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightStyle 		= 1
ENT.LightXplode 	= 4
ENT.LightColor		= Color( 230, 60, 40, 255 )
ENT.LightDistance	= 64
ENT.LightBrightness	= 0.2
ENT.LightDieTime	= 0.5
ENT.LightDecay		= 4096
ENT.LightStyle 		= 1
ENT.LightFlareColor	= Color( 255, 95, 75 )
ENT.SoundEmit		= false
ENT.IgnoreTarget 	= nil
ENT.CreationTime 	= nil
ENT.IsConsuming 	= false
ENT.ConsumerDetectionRange = 220
ENT.ConsumerBaseVelocity = 12
ENT.m_hConsumer 	= NULL

local iAmmoID, iAmmoMax = 0, 9999
iAmmoID = game.GetAmmoID( "InferiantCharge" )

--local clrLightColor = Color( 230, 60, 40, 255 )

function ENT:SubInit( ent, phys )
	
	iAmmoID = game.GetAmmoID( "InferiantCharge" )
	iAmmoMax = GetConVarNumber( "gmod_maxammo" ) || game.GetAmmoMax( iAmmoID )

	ent:SetXPloding( false )
	
	if ( SERVER ) && ( IsValid( phys ) ) then
		phys:SetDragCoefficient( 131072 )
		phys:SetAngleDragCoefficient( 32786 )
--		phys:Sleep()
		phys:Wake()
	end
	
	self.CreationTime = CurTime() + 1

end

function ENT:WithinPlayerRange( tPlayers, vOrigin )
	local vOrigin = self:GetPos()
	
	for i=1, #tPlayers do 
		local v = tPlayers[i]
		local pOrigin = v:GetPos()

		if ( vOrigin:DistToSqr( pOrigin ) < (512 * 512) ) then
			return true
		end
	end
	
	return false
end

function ENT:SubThink()

	local vOrigin = self:GetPos()
	
	if ( CLIENT ) then
		local isvisible	= util.PixelVisible( vOrigin, 4, self.PixVis )

		if ( isvisible == 0 ) then
			self.LightEmit = false
			
			return
		else
			self.LightEmit = true
		end
	end

	if ( SERVER ) then
		local phys = self:GetPhysicsObject()
		local tPlayers = player.GetAll()
	
		local bWithinPlayerRange = self:WithinPlayerRange( tPlayers, vOrigin )
		
		if ( !bWithinPlayerRange ) then	
			if ( IsValid( phys ) && !phys:IsAsleep() ) then
				phys:Sleep()
			end
			
			return
		end
		
		if ( IsValid( phys ) && phys:IsAsleep() ) then
			phys:Wake()
		end
			
		if ( self.CreationTime > CurTime() ) then return end

		for k, ply in pairs( tPlayers ) do
			if ( !IsValid( ply ) || !ply:Alive() ) then continue end

			if !( ply:GetAmmoCount( iAmmoID ) < iAmmoMax ) then 
				if ( !phys:IsGravityEnabled() ) then
					phys:EnableGravity( true )
					self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
				end
				
				continue 
			end
			
			local iDistSqr = vOrigin:DistToSqr( ply:GetPos() )
			if ( iDistSqr > ( self.ConsumerDetectionRange * self.ConsumerDetectionRange ) ) then 
				if ( !phys:IsGravityEnabled() ) then
					phys:EnableGravity( true )
					self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
				end
				
				continue 
			end
			
			if ( !IsValid( self.m_hConsumer ) ) then
				self.m_hConsumer = ply
				self.ConsumerDetectionRange = self.ConsumerDetectionRange * 2
			end

			if ( ply != self.m_hConsumer ) then continue end
			
			local tPos = ply:EyePos() - Vector( 0, 0, 10 )
			
			if ( ply != self.Owner ) then
				if ( phys:IsGravityEnabled() ) then
					phys:EnableGravity( false )
					self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
				end

				local mAccel = iDistSqr / ( ( self.ConsumerDetectionRange * self.ConsumerDetectionRange ) * 0.1 )
				mAccel = ( mAccel * mAccel ) * self.ConsumerBaseVelocity * Vector( 1, 1, 1.2 )

				local vVelo = ply:GetVelocity() * 0.6

				phys:ApplyForceCenter( ( ( tPos - vOrigin ) * mAccel ) + vVelo, vOrigin )
				
				util.ParticleTracerEx( 
					"umbra_ammo_pickup", --particle system
					vOrigin, --startpos
					tPos, --endpos
					false, --do whiz effect
					self:EntIndex(), --entity index
					0 --attachment
				)
			end
		end
	end

	local eOrigin = self.Entity:GetPos()
	local eAngles = self.Entity:GetAngles()
	local eOffset = eAngles:Forward()

	local trData = {}
	local trResult = {}
	local trSize = Vector( 2, 2, 2 )

	trData.start 		= eOrigin - eOffset * 64
	trData.endpos 		= eOrigin + eOffset * 64
	trData.filter 		= { self.Entity, self.Owner }
	trData.mins 		= trSize * -1
	trData.maxs 		= trSize
	trData.mask 		= MASK_SHOT_HULL
	trData.ignoreworld 	= true
	trData.output 		= trResult
	
	util.TraceHull( trData )
	
	if ( trResult.Hit ) then
		self.Entity:XPlode( trResult )
	end

end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	self.Entity:XPlode( pCollisionData )
	
	if ( pCollisionData.Speed > 128 ) then
		self:EmitSound( "Flesh_Bloody.ImpactHard" )
	end
		
	local phys = pCollisionData.HitObject
	local vVeloOld = pCollisionData.OurOldVelocity

	phys:SetVelocity( vVeloOld * 0.8 )
	
end

function ENT:AcceptInput( sInput, eActivator, eCaller, sData )

	if ( string.lower( sInput ) == "use" ) && ( eCaller:IsPlayer() ) then
		local tInfo = {}
		tInfo.Entity = eCaller
		
		self:XPlode( tInfo )
	end

end

function ENT:XPlode( pCollisionData )

	if ( !pCollisionData ) then return end
	
	if ( SERVER ) then
		local target = pCollisionData.Entity
		
		if ( !target || !IsValid( target ) || !target:IsPlayer() ) then
			self:SetXPloding( false )

			return
		end
		
		if ( self:GetXPloding() ) then return end
		
		local iAmount = math.random( 6, 10 )
		target:GiveAmmo( iAmount, "InferiantCharge", false )
		
		-- print( table.HasValue( target:GetActiveWeapon().SciFiWorldStats.PerkSet, SCIFI_PERK_CORRUPTED_IMPURERELOAD ) )
	
		ParticleEffectAttach( "umbra_ammo_consumed", PATTACH_POINT_FOLLOW, target, 1 )

		self:StopParticles()
		
		self:EmitSound( "scifi.dark.snack" )
		self.Entity:KillSilent()
	end

	self:SetXPloding( true )

end