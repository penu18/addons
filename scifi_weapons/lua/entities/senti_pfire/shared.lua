AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Spectral Bolt"
ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "spectra_tracer" 
ENT.SndImpact 		= "cat.ca3.hit"
ENT.LifeTime		= 10
ENT.OnWater			= "SFP_REMOVE"
ENT.OnDamaged		= "SFP_IGNORE"
ENT.LightEmit		= true
ENT.LightColor		= "200 220 255 255"
ENT.LightSpotRadius	= 72
ENT.LightDistance	= 200
ENT.LightBrightness	= 1
ENT.SoundEmit		= false

function ENT:SubInit()
	
end

function ENT:SubThink()
	
end

function ENT:PhysicsCollide( data, phys )
	
	self:XPlode()

end

function ENT:XPlode()

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	local dmg_1 = 6
	
	local tr = {}
	
	util.TraceLine( {
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetAngles():Forward() * 64,
		filter = function( ent ) if ( ent:IsNPC() ) or ( ent:IsPlayer() ) then return true end end,
		ignoreworld = true,
		output = tr
	} )

	if ( tr.HitGroup == HITGROUP_HEAD ) then
		dmg_1 = dmg_1 * 1.3
	end
	
	if ( tr.HitGroup == HITGROUP_CHEST ) or ( tr.HitGroup == HITGROUP_STOMACH ) then
		dmg_1 = dmg_1 * 1.2
	end
	
	if ( SERVER ) then
	
	self:DealPointDamage( bit.bor( DMG_CLUB, DMG_SLASH ), dmg_1 * amp, self:GetPos(), 128 )
	
	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx2 ) ) then return end
	fx2:SetKeyValue( "_light", "255 225 255 255" )
	fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius * 1.2 )
	fx2:SetKeyValue( "distance", self.LightDistance * 1.2 )
	fx2:SetKeyValue( "brightness", 2 )
	fx2:SetPos( self:GetPos() )
	fx2:SetAngles( self:GetAngles() )
	fx2:Spawn()
	fx2:Fire( "kill", "", 0.115 )

	ParticleEffect( "spectra_hit", fx2:GetPos(), self:GetAngles() )

	util.ScreenShake( fx2:GetPos(), 2, 4, 0.25, 256 )

	self:EmitSound( self.SndImpact )
	
	self:KillSilent()
	
	end
	
end