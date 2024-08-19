AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "shit's on fire, yo"
ENT.PhxSSize 		= 0.1
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 1
ENT.PhxElastic		= 1
ENT.FxTracer 		= "doom_imp_fireball"
ENT.SndImpact 		= "BaseExplosionEffect.Sound" --"scifi.seraph.fire1"
ENT.LifeTime		= 6
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= Color( 255, 100, 10, 255 )
ENT.LightXPlode 	= 3
ENT.LightStyle 		= 1
ENT.LightDistance	= 320
ENT.LightBrightness	= 1
ENT.LightFlareAlpha	= 8
ENT.LightFlareSize 	= 0.4

function ENT:XPlode( pCollisionData )

	if ( self:GetXPloding() ) then return end
	if ( !pCollisionData ) then return end
	
	self:SetXPloding( true )
	
	if ( SERVER ) then

	local amp = GetConVarNumber( "sfw_damageamp" )
	local xOrigin = self:GetPos()
	local xAngles = self:GetAngles()
	
	util.Decal( "scorch", xOrigin, xOrigin - Vector( 0, 0, 8 ) )
	
	ParticleEffect( "doom_imp_fireblast_impact", xOrigin, xAngles )
	
	self:EmitSound( "PropaneTank.Burst" )
	
	self:DealAoeDamage( bit.bor( DMG_CLUB, DMG_SLASH, DMG_NEVERGIB ), 24, xOrigin, 64 )
	self:DealAoeDamage( bit.bor( DMG_BURN, DMG_DIRECT, DMG_NEVERGIB ), 2, xOrigin, 86 )

	local emlinfo = {
		Element = EML_FIRE,
		Target = pCollisionData.Entity,
		Duration = 5,
		Attacker = self:GetValidOwner()
	}

	DoElementalEffect( emlinfo )
	
	self:KillSilent()
	
	end
	
end