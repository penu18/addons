AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_pfx = GetConVar( "sfw_fx_particles" )
local cmd_sprites = GetConVar( "sfw_fx_sprites" )
local cmd_damageamp = GetConVar( "sfw_damageamp" )

ENT.NewHitMechanic 	= false
ENT.ProjectileImpactLogic = bit.bor( PROJECTILE_IMPACT_PHYSICS, PROJECTILE_IMPACT_TRACECAST )
ENT.ProjectileImpactTraceLength = 16
--ENT.LagCompensated 	= true
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PrintName 		= "Draco Bolt"
--ENT.PhxCGroup 		= COLLISION_GROUP_DEBRIS
ENT.PhxMType 		= bit.bor( MOVETYPE_FLY, MOVETYPE_CUSTOM )
ENT.PhxSSize		= 0.1
ENT.PhxMaxVelocity 	= 12000
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracerNew 	= true

if ( cmd_pfx:GetBool() ) then 
	ENT.FxTracer = "drake_tracer" 
else
	ENT.FxTracer = "hwave_tracer_cheap"
end

ENT.SndImpact 		= "scifi.hwave.hit"
ENT.LifeTime		= 4
ENT.KillSilentDelay = 0
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.OnImpact 		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "255 30 20 255"
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 300
ENT.LightBrightness	= 1
ENT.LightDieTime	= 0.4
ENT.LightDecay		= 1768
ENT.LightFlareColor	= Color( 255, 20, 40 )
ENT.LightFlareAlpha = 4
ENT.LightFlareSize  = 0.46
ENT.LightFlarePos 	= -64
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.hwave.flyby"

function ENT:SubInit( ent, phys )

	ent:SetXPloding( false )
	ent:NextThink( CurTime() )
	
	phys:AddGameFlag( FVPHYSICS_WAS_THROWN )
	phys:AddGameFlag( FVPHYSICS_DMG_SLICE )

	if ( SERVER ) then
		if ( cmd_sprites:GetBool() ) then
			util.SpriteTrail( 
				self, 								-- parent
				1, 									-- attachment ID
				Color( 255, 60, 80, 255 ), 				-- Color
				1, 									-- force additive rendering
				6, 									-- start width
				0, 									-- end width
				0.08,								-- lifetime
				16,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
	end
	
end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 2
	end
	
	if ( hgroup == HITGROUP_CHEST ) then
		mul = 1.5
	end
	
	return mul

end

function ENT:XPlode( trResult )

	-- PrintTable( trResult )
		
	if ( self:GetXPloding() ) then return end

	-- if ( !trResult ) then
		-- trResult ={
			-- HitPos = self:GetPos()
		-- }
	-- end

	self:SetXPloding( true ) 
	
	if ( SERVER ) then
	
		self:GetPhysicsObject():EnableMotion( false )

		local vOrigin = trResult.HitPos
		
		-- debugoverlay.Cross( vOrigin, 4, 6, color_white, true )

		-- local vNormal = trResult.HitNormal || Vector( 0, 0, 0 )
		-- vNormal = vNormal * -1
		-- vOrigin = vOrigin + vNormal * 12
		
		local amp = cmd_damageamp:GetFloat()
		
		-- self:SetAngles( trResult.HitNormal:Angle() )

		self:DealPointDamage( DMG_SF_PHASEBLADE, 14 * amp, vOrigin, 64, 16, 128 ) -- ( dmgtype, dmgamt, src, range, dmgforce, hullsize ) --

		ParticleEffect( "drake_hit", vOrigin, self:GetAngles() )
		util.ScreenShake( vOrigin, 2, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	end
	
end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
	util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
    return true
	
end