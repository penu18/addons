AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Vapor Grenade"
ENT.Author 			= "Darken217"

ENT.PhxMass 		= 4
ENT.PhxGrav			= true
ENT.FxTracer 		= "vapor_grenade"
ENT.FxImpact 		= "vapornade_explosion"

ENT.SndImpact 		= "scifi.vapor.nade.explo"

ENT.LifeTime		= 120
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightXplode 	= 4
ENT.LightColor		= "20 40 255 255"
ENT.LightSpotRadius	= 256
ENT.LightDistance	= 512
ENT.LightBrightness	= 1

function ENT:SubInit()
	
--	ParticleEffectAttach( "saphyre_hit", 4, self, 0 )

end

function ENT:PhysicsCollide( data, phy )

	self:XPlode()
	
end

function ENT:SubThink()
	
end

function ENT:OnTakeDamage( CTakeDamageInfo )

	if ( self:GetXPloding() ) then return end
	
	self:XPlode()
	
	return true

end

function ENT:XPlode()

	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then
		local pos = self:GetPos()
		
		for k,v in pairs ( ents.FindInSphere( pos, 256 ) ) do
			if ( v:IsNPC() || v:IsPlayer() ) then
				self:DealAoeDamage( DMG_SF_ENERGYSHOCKWAVE, 10 + ( 0.8 * v:Health() ) * amp, v:GetPos(), 256 )
			end
		end

		ParticleEffect( self.FxImpact, pos, Angle( 1, 1, 1 ), self:GetValidOwner() )
		
		self:EmitSound( self.SndImpact )
		util.ScreenShake( pos, 32, 512, 0.4, 620 )
		
		self:KillSilent()
	end

end

function ENT:ImpactTrace( tr, dmgtype )
	
    return true
	
end