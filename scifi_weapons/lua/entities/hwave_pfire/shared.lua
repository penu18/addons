AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_pfx = GetConVarNumber( "sfw_fx_particles" )
local cmd_sprites = GetConVarNumber( "sfw_sprites" )
local amp = GetConVarNumber( "sfw_damageamp" )

-- ENT.ClThinkDelay = 0
-- ENT.SvThinkDelay = 0

ENT.NewHitMechanic 	= false
ENT.PrintName 		= "HeatWave projectile"
ENT.PhxSSize		= 0.01
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false

if ( cmd_pfx >= 1 ) then 
	ENT.FxTracer = "hwave_tracer" 
else
	ENT.FxTracer = "hwave_tracer_cheap"
end

ENT.SndImpact 		= "scifi.hwave.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "255 80 10 255"
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 220
ENT.LightBrightness	= 1
ENT.LightDieTime	= 1
ENT.LightDecay		= 1768
ENT.LightFlareColor	= Color( 255, 60, 10 )
ENT.LightFlarePos 	= -24
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.hwave.flyby"
ENT.SoundRate 		= 0.1
ENT.SoundNext 		= 0.1
ENT.SoundDistance 	= 200

function ENT:SubInit()

	self:SetXPloding( false )
	
	if ( cmd_pfx == 0 ) && ( cmd_sprites == 1 ) then
		util.SpriteTrail( 
		self, 
		1, 
		Color( 255, 110, 10, 255 ),
		1, 
		16, 
		0, 
		0.5,
		1024,
		"effects/beam_nocolor.vmt" )
	end
	
end

function ENT:SubThink( ent )
	
	if ( SERVER ) && ( IsValid( self.Owner ) ) then
		local phys = self:GetPhysicsObject()
		if ( !IsValid( phys ) ) then return end
		
		if ( self.Owner:IsPlayer() ) then
			local pOwnerAV = self.Owner:GetAimVector()
			local pOwnerEA = self.Owner:EyeAngles()
			local fw = pOwnerEA:Forward()
		
			ent:SetAngles( pOwnerEA )
			phys:ApplyForceCenter( pOwnerAV * 1000 + fw * 3400 )
		end
	end
	
end

function ENT:PhysicsCollide( pCollisionData, phys )

	if ( pCollisionData.HitEntity:IsNPC() || pCollisionData.HitEntity:IsPlayer() || pCollisionData.HitEntity:GetClass( "prop_ragdoll" ) ) then
		if ( cmd_pfx == 1 ) then 
			ParticleEffect( "hwave_hit_fleks", pCollisionData.HitPos, self:GetAngles() )
		end
	end
	
	self:XPlode( pCollisionData )

end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 1.3
	end
	
	-- if ( hgroup == HITGROUP_CHEST || hgroup == HITGROUP_STOMACH ) then
		-- mul = 1.2
	-- end
	
	return mul

end

function ENT:XPlode( pCollisionData )
	
	if ( self:GetXPloding() ) then DevMsg( "@sfw_hwave : !Error; Unintended multi-hit damage infliction!" ) return end
	
	self:SetXPloding( true ) 
	
	local amp = GetConVarNumber( "sfw_damageamp" )
	local dmg_1 = 10 * amp
	local dmg_2 = 4 * amp

	local pos = pCollisionData.HitPos - pCollisionData.HitNormal * 2
	local ang = self:GetAngles()

	if ( SERVER ) then
		self:DealPointDamage( bit.bor( DMG_CLUB, DMG_SLASH ), dmg_1 * amp, pos, 128, 6, 8 )						-- They also have a measurable but not too heavy negative effect on performance ... ... ...
		-- self:DealPointDamage( bit.bor( DMG_CLUB, DMG_SLASH ), dmg_2 * amp, pos + ang:Forward() * 32, 256 ) 	-- Fake punch-through mechanic
		self:DealAoeDamage( bit.bor( DMG_BURN, DMG_GENERIC ), dmg_2 * amp, pos, 64, self:GetOwner(), 0.5 ) 		-- Three different damage sources actually make this weapon kind of unreliable.

		ParticleEffect( "hwave_hit", pos, ang )
		util.ScreenShake( pos, 8, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	end
	
end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
	util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
    return true
	
end