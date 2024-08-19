AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "HeatWave grenade"
ENT.RMdl 			= "models/props_bts/rocket.mdl"
ENT.RMat 			= "models/black" 
ENT.RShadows 		= true
ENT.PhxSProp 		= "Metal"
ENT.PhySSize 		= nil

ENT.PhxGrav			= true
ENT.PhxDrag			= false
ENT.PhxMass			= 25
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "pyro_nade"
ENT.SndImpact 		= "scifi.pyre.explode"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "255 120 10 255"
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 300
ENT.LightBrightness	= 1
ENT.NextTick 		= 0

function ENT:SubThink()
	
	if ( SERVER ) then
		if ( self:GetNWBool( "HWNadeArmed" ) == true ) then
			if( self.NextTick <= CurTime() ) and ( !self:GetXPloding() ) then
				self:XPlode()
			end
		end
	end
	
end

function ENT:PhysicsCollide( data, phys )

	if ( self:GetNWBool( "HWNadeArmed" ) ~= true ) then
		self.NextTick = CurTime() + 0.8
		self:SetNWBool( "HWNadeArmed", true )
	end
	
	if ( self:GetNWBool( "HWNadeArmed" ) == true ) then
		if ( data.HitEntity:IsNPC() ) or ( data.HitEntity:IsPlayer() ) then
			self:XPlode()
		end
	end
	
	self:EmitSound( "Grenade.ImpactHard" )
	
	--ParticleEffectAttach( "seraph_hit", 1, self, 1 )

end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end
	
	
	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then

	self:DealAoeDamage( bit.bor( DMG_CLUB, DMG_SLASH ), 120 * amp, self:GetPos(), 180 )
	self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_BURN ), 60 * amp, self:GetPos(), 256 )

	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx2 ) ) then return end
	fx2:SetKeyValue( "_light", "255 110 70 255" )
	fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius * 3 )
	fx2:SetKeyValue( "distance", self.LightDistance * 3 )
	fx2:SetKeyValue( "brightness", 2 )
	fx2:SetPos( self:GetPos() )
	fx2:SetAngles( self:GetAngles() )
	fx2:Spawn()
	fx2:Fire( "kill", "", 0.115 )

	ParticleEffect( "pyro_explode", fx2:GetPos(), self:GetAngles() )

	util.ScreenShake( fx2:GetPos(), 2, 4, 0.25, 256 )
	
	DoElementalEffect( { Element = EML_DISSOLVE_HWAVE, Attacker = self.Owner, Origin = self:GetPos(), Range = 42, Ticks = 25 } )

	self:EmitSound( self.SndImpact )
	self:EmitSound( "BaseExplosionEffect.Sound" )
	
	self:KillSilent()
	
	end
	
end