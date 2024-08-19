AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Hellfire projectile"
ENT.PhxSSize		= 1
ENT.PhxMass 		= 4
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "hellfire_tracer"
ENT.SndImpact 		= "scifi.hfire.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "255 100 10 255"
ENT.LightSpotRadius	= 120
ENT.LightDistance	= 360
ENT.LightBrightness	= 1
ENT.LightFlareAlpha = 10
ENT.LightFlareSize 	= 1
ENT.LightXplode = 3

function ENT:XPlode( data )

	if ( self:GetXPloding() ) then return end

	if ( SERVER ) then
	
	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	self:DealAoeDamage( bit.bor( DMG_BULLET ), 10 * amp, self:GetPos(), 60 )
	
	-- local fx2 = ents.Create( "light_dynamic" )
	-- if ( !IsValid( fx2 ) ) then return end
	-- fx2:SetKeyValue( "_light", "255 95 10 255" )
	-- fx2:SetKeyValue( "spotlight_radius", 200 )
	-- fx2:SetKeyValue( "distance", 310 )
	-- fx2:SetKeyValue( "brightness", 2 )
	-- fx2:SetPos( self:GetPos() )
	-- fx2:Spawn()
	-- fx2:Fire( "kill", "", 0.115 )

	-- util.Decal( "fadingscorch" , fx2:GetPos(), fx2:GetPos() * -1 )	
	ParticleEffect( "hellfire_blast", self:GetPos(), Angle( 0, 0, 0 ) )

	self:EmitSound( self.SndImpact )

	if ( !data.HitWorld && data.HitEntity && IsValid( data.HitEntity ) ) then
		DoElementalEffect( { Element = EML_FIRE, Target = data.HitEntity, Duration = 5 } )
	end
	
	-- for k, v in pairs ( ents.FindInSphere( self:GetPos(), 75 ) ) do
		-- DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 5 } )
	-- end
	
	self:KillSilent()
	
	end
	
end