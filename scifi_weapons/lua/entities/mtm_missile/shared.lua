AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "MTM guided missile"
ENT.Author 			= "Darken217"
ENT.SvThinkDelay	= 0

ENT.RMdl 			= "models/props_bts/rocket.mdl"
ENT.RMat 			= "models/black" 
ENT.PhxSProp 		= "Metal"
ENT.PhxMass 		= 4
ENT.FxTracer 		= "ngen_missile_smoke"
ENT.FxImpact 		= "ngen_explosion"

ENT.LifeTime		= 120
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "120 110 255 255"
ENT.LightSpotRadius	= 128
ENT.LightDistance	= 180
ENT.LightBrightness	= 1

ENT.MeteorEnabled 			= true
ENT.MeteorDetectionRange 	= 32
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInital 	= 128
ENT.MeteorVelocityScale 	= 12
ENT.MeteorHomingFactor 		= 16
ENT.MeteorAlwaysTrack  		= true
ENT.MeteorSwayScale 		= 1
ENT.MeteorVelocityDecay 	= false
ENT.MeteorNeverForget 		= true
ENT.MeteorSelfDestruct 		= true
ENT.MeteorPreserveInitial 	= true

-- CODENAME: EX-WIFE --

function ENT:SubInit()

	ParticleEffect( "ngen_muzzle", self:GetPos(), self:GetAngles(), self )	
	
	self:EmitSound( "Weapon_RPG.Single" )
--	self:EmitSound( "Missile.Ignite", self:GetPos(), SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0, CHAN_ITEM )

end

function ENT:PhysicsCollide( data, phy )

	self:XPlode()
	
end

function ENT:SubThink( ent, phys )
			--[[
	if ( SERVER ) then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()
		local phys = ent:GetPhysicsObject()

		if ( IsValid( self.Owner ) && self.Owner:IsPlayer() ) then
			if ( !IsValid( phys ) ) then return end
			local tr = self.Owner:GetEyeTrace()

			ent:MeteorTargeting( 180, true, 64, 2 )
			
			if ( !ent:GetMTarLocked() ) then
				local tpos = tr.HitPos
				local direction = ( ( tr.Normal * 4096 ) * ( pos:Distance( tpos ) ) )

				phys:ApplyForceOffset( self:GetAngles():Forward() * 256 + direction, tpos )
			end
		else
			ent:SetAngles( self.Owner:GetAimVector():Angle() )
		end
	end
			]]--
	
	-- print( self:GetMTarEntity() )
	-- debugoverlay.Line( self:GetPos(), self:GetPos() + self:GetAngles():Forward() * 512, FrameTime(), Color( 255, 0, 255, 255 ), true )
end

function ENT:OnTakeDamage( CTakeDamageInfo )
	
	self:XPlode()
	
	return true

end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end

	self:SetXPloding( true )
	
	local amp = GetConVarNumber( "sfw_damageamp" )
	
--	self:EmitSound( "common/NULL.wav", self:GetPos(), SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0, CHAN_ITEM )
	
	if ( SERVER ) then

	self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_AIRBOAT ), 160 * amp, self:GetPos(), 300 )
	self:DealAoeDamage( DMG_BLAST, 160 * amp, self:GetPos(), 300 )
	self:DealAoeDamage( DMG_BLAST, 10 * amp, self:GetPos(), 600 )
	
	local fx = ents.Create( "light_dynamic" )
	if ( !IsValid( fx ) ) then return end
	fx:SetKeyValue( "_light", "220 170 255 255" )
	fx:SetKeyValue( "spotlight_radius", 768 )
	fx:SetKeyValue( "distance", 1024 )
	fx:SetKeyValue( "brightness", 3 )
	fx:SetPos( self:GetPos() )
	fx:Spawn()
	
	ParticleEffect( "ngen_explosion", fx:GetPos(), Angle( 1, 1, 1 ), self:GetValidOwner() )
	
	fx:EmitSound( "BaseExplosionEffect.Sound" )
	fx:EmitSound( "scifi.ngen.explosion" )
	util.ScreenShake( fx:GetPos(), 32, 512, 0.4, 620 )
	
	self:KillSilent()
	SafeRemoveEntityDelayed( fx, 0.1 )
	
	end

end

function ENT:ImpactTrace( tr, dmgtype )
	
    return true
	
end