AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.NewHitMechanic 	= false
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PrintName 		= "asa6 powershot"
ENT.LifeTime		= 1
ENT.PhxCGroup 		= COLLISION_GROUP_IN_VEHICLE
ENT.PhxSSize		= 0.001
ENT.PhxMaxVelocity 	= 4800 --9200 --16384
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= true
ENT.FxTracerNew 	= true
ENT.FxTracer 		= "lanka_riv_tracer" 
ENT.SndImpact 		= "cat.ca3.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "80 40 255 255"
ENT.LightSpotRadius	= 256
ENT.LightDistance	= 512
ENT.LightBrightness	= 1
ENT.LightDieTime	= 0.5
ENT.LightDecay		= 4096
ENT.LightFlareMat 	= Material( "bloom/halo_static_2.vmt" )
ENT.LightFlareColor	= Color( 100, 80, 255 )
ENT.LightFlareAdd 	= true
ENT.LightFlareAlpha = 128
ENT.LightFlareSize  = 0.4
ENT.LightFlarePos 	= -32
--ENT.SoundEmit		= true
--ENT.SoundFile 		= "ambient/energy/weld2.wav"
ENT.Charge 			= 1

PrecacheParticleSystem( "lanka_riv_muzzle" )
PrecacheParticleSystem( "lanka_riv_tracer" )
PrecacheParticleSystem( "lanka_hit_riv" )

function ENT:SubInit( ent, phys )

	ent:SetXPloding( false )
	
	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 								-- parent
				0, 									-- attachment ID
				Color( 100, 80, 255, 220 ), 		-- Color
				1, 									-- force additive rendering
				4, 									-- start width
				0, 									-- end width
				0.2,								-- lifetime
				32,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
	end

end

function ENT:SubThink()

	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	local trData = {}
	local trResult = {}
	local trSize = Vector( 16, 10, 10 )

	trData.start 		= eOrigin - eOffset * 24
	trData.endpos 		= eOrigin + eOffset * 24
	trData.filter 		= { self, self.Owner }
	trData.mins 		= trSize * -1
	trData.maxs 		= trSize
	trData.mask 		= MASK_SHOT_HULL
	--trData.ignoreworld 	= true
	trData.output 		= trResult
	
	util.TraceHull( trData )
	
	if ( SERVER ) && ( trResult.Hit ) then
		if ( trResult.HitSky ) then
			self:KillSilent()
			return
		end
	
		self:XPlode( trResult )
	end

end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	self:XPlode( pCollisionData )
		
end

function ENT:XPlode( pCollisionData )

	local target = pCollisionData.Entity

	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	if ( SERVER ) then
		if !( !IsValid( target ) || target:IsWorld() || target == self ) then 
			local amp = GetConVarNumber( "sfw_damageamp" )
			
			local iDamage = 8 * self.Charge * amp
			
			if ( pCollisionData.HitGroup == HITGROUP_HEAD ) then
				iDamage = iDamage * 2
			end
			
			local vForce = eOffset * iDamage * 64
			
			DoElementalEffect( { Element = EML_DISSOLVE_GRAVRIFLE,Target = target, Attacker = self:GetValidOwner(), Origin = pCollisionData.HitPos } )

			self:DealDirectDamage( bit.bor( DMG_GENERIC, DMG_DIRECT, DMG_BLAST, DMG_RADIATION, DMG_AIRBOAT ), iDamage, target, self.Owner, vForce )
			self:DealDirectDamage( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ), iDamage, target, self.Owner, vForce )
--			self:DealDirectDamage( bit.bor( DMG_GENERIC, DMG_DIRECT ), iDamage, target, self.Owner, vForce )

			local tPhys = target:GetPhysicsObject()
			if ( IsValid( tPhys ) ) then
				tPhys:ApplyForceCenter( ( eOffset - pCollisionData.HitNormal ) * 16384 )
			end
		end

		ParticleEffect( "lanka_hit_riv", eOrigin, eAngles )
		util.ScreenShake( eOrigin, 2, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
	
		if ( IsValid( target ) && target:IsWorld() ) then
			self:KillSilent()
		end
	end

end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
end