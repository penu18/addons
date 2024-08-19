AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Pandemic bolt"
ENT.SvThinkDelay	= 0

ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "panda_tracer" 
ENT.SndImpact 		= "cat.pest.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "120 255 60 255"
ENT.LightXplode 	= 3
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 300
ENT.LightBrightness	= 1
ENT.LightFlarePos 	= -12
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.hwave.flyby"

ENT.MeteorEnabled 			= true
ENT.MeteorDetectionRange 	= 64
ENT.MeteorIgnoreworld 		= true 				-- Detect targets through world geometry
ENT.MeteorVelocityInitial 	= 1					-- The projectile's initial, linear acceleration
ENT.MeteorVelocityScale 	= 1 				-- Accelerate the final velocity (inital + homing) by this value
ENT.MeteorHomingFactor 		= 4					-- How hard the projectile should home in on the target. Too large values may make the homing inaccurate.
ENT.MeteorAlwaysTrack  		= true				-- The Projectile will retrieve the flight direction from the owner's aim direction, if it's not locked on to a target.
ENT.MeteorSwayScale 		= 4					-- How much the projectile should sway mid-air. This should simulate a "realistic" flight pattern and artificial inaccuracy. Set to 0 to disable it.
ENT.MeteorNeverForget 		= true				-- If enabled, the projectile will remember the first entity it locked on to and will not override it.
ENT.MeteorSelfDestruct 		= false 			-- Should the projectile prematurely explode when it comes within range of a given target?
ENT.MeteorPreserveInitial 	= true 				-- Adjust the entity's angles according to the desired flight direction. This may cause issues when trying to maintain some of the flight direction you had before locking on to a target.
ENT.MeteorVelocityDecay 	= true 				-- Projectile velocity decays proportional to its life time
ENT.MeteorVelocityDecayRatio = 0.4
ENT.MeteorVelocityDecayExponent = 2

function ENT:XPlode()

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then
	
		self:SetXPloding( true )
	
		self:DealPointDamage( bit.bor( DMG_ACID, DMG_NERVEGAS ), 6 * amp, self:GetPos(), 128 )
		self:DealAoeDamage( bit.bor( DMG_RADIATION, DMG_POISON ), 3 * amp, self:GetPos(), 64 )
		
		-- local fx2 = ents.Create( "light_dynamic" )
		-- if ( !IsValid( fx2 ) ) then return end
		-- fx2:SetKeyValue( "_light", "110 255 70 255" )
		-- fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius * 1.2 )
		-- fx2:SetKeyValue( "distance", self.LightDistance * 1.2 )
		-- fx2:SetKeyValue( "brightness", 2 )
		-- fx2:SetPos( self:GetPos() )
		-- fx2:SetAngles( self:GetAngles() )
		-- fx2:Spawn()
		-- fx2:Fire( "kill", "", 0.115 )
		
		for k, v in pairs( ents.FindInSphere( self:GetPos(), 128 ) ) do
			DoElementalEffect( { Element = EML_CORROSIVE, Target = v, Attacker = self.Owner, Inflictor = self } )
		end

		ParticleEffect( "panda_hit", self:GetPos(), self:GetAngles() )

		util.ScreenShake( self:GetPos(), 4, 2, 0.25, 256 )

		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	
	end
	
end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
	util.Decal( "yellowblood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
    return true
	
end