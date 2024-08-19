AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Falling Star"
ENT.RMdl 			= "models/maxofs2d/hover_basic.mdl"
ENT.RMat 			= "vgui/white"
ENT.PhxSSize		= 10
ENT.PhxMass 		= 4
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "fstar_secfire" 
ENT.LifeTime		= 60
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "120 180 255 255"
ENT.LightSpotRadius	= 280
ENT.LightDistance	= 320
ENT.LightBrightness	= 1

function ENT:SubInit()
	
	self:SetNWBool( "IsXPloding", false )

end

function ENT:OnTakeDamage( dmginfo )

	if ( self:GetXPloding() ) then return end
	
	self:XPlode()
	
	return true
	
end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end

	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	local dmg = 50000 * amp
	local dmgtype = DMG_GENERIC
	local range = 300
	
	if ( SERVER ) then

	local fx = ents.Create( "light_dynamic" )
	fx:SetKeyValue( "_light", "235 245 255 255" )
	fx:SetKeyValue( "spotlight_radius", 2048 )
	fx:SetKeyValue( "distance", 4096 + range )
	fx:SetKeyValue( "brightness", 3 )
	fx:SetPos( self:GetPos() )
	fx:Spawn()
	
	fx:EmitSound( "scifi.fstar.altfireboom" )
--	fx:EmitSound( "scifi.vapor.altfireecho" )

	local tars = ents.FindInSphere( fx:GetPos(), range )
	
	util.ScreenShake( fx:GetPos(), 1024, 128, 1, 1512 + range )
			
	for k, w in pairs ( ents.FindInSphere( fx:GetPos(), 1024 ) ) do 
		 if ( w:IsPlayer() ) then
			w:ScreenFade( SCREENFADE.IN, Color( 210, 240, 255, 255 ), 0.09, 0.09 )
		end
	end
	
	for k, v in pairs ( tars ) do
		self:DealDirectDamage( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ), 40 * amp, v, self:GetValidOwner() )
		DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 4, Attacker = self.Owner } )
	end

	ParticleEffect( "fstar_sfire_hit_swave", self:GetPos(), Angle( 0, 0, 0 ) )
		
	SafeRemoveEntityDelayed( fx, 0.2 )
	
	self:KillSilent()
	
	end
	
end

----------------------------------------------------------------------------------------------------------
---##------##----####----------#######-------######------#######-----########----########------########---
----##----##--------##---------##----##-----##----##-----##----##-------##-------##-----------##----------
-----##--##--------####--------#######-----##------##----#######--------##-------######------##-----------
------####--------##--##-##----##-----------##----##-----##---##--------##-------##-----------##----------
-------##--------##----###-----##------------######------##----##-------##-------########------########---
----------------------------------------------------------------------------------------------------------