AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Vapor projectile"
ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false

if ( GetConVarNumber( "sfw_fx_particles" ) >= 1 ) then 
	ENT.FxTracer = "vapor" 
else
	ENT.FxTracer = "vapor_cheap"
end

ENT.SndImpact 		= "scifi.vapor.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "20 40 255 255"
ENT.LightXplode 	= 3
ENT.LightSpotRadius	= 256
ENT.LightDistance	= 512
ENT.LightDecay 		= 4096
ENT.LightBrightness	= 1
ENT.LightFlareAlpha = 10
ENT.LightFlareSize 	= 1
ENT.SoundEmit		= true
ENT.SoundFile		= "scifi.vapor.idleloop"

function ENT:SubInit()

end

function ENT:SubThink()
	
end

function ENT:XPlode( pCollisionData )

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	self:SetXPloding( true )
	
	if ( SERVER ) then
	
	local pos = self:GetPos()
	if ( pCollisionData ) then
		pos = pCollisionData.HitPos + pCollisionData.HitNormal * -2
	end
	
	local master = self:GetValidOwner()

	DoElementalEffect( { Element = EML_DISSOLVE_VAPOR, Origin = pos, Range = 86, Target = nil } )
	self:DealAoeDamage( bit.bor( DMG_ENERGYBEAM, DMG_AIRBOAT, DMG_NEVERGIB ), 60 * amp, pos, 100 ) -- Remember: This 33540137 is the ultimate damage type...
	
	local bParticles = GetConVar( "sfw_fx_particles" ):GetBool()
	if ( bParticles ) then 
		ParticleEffect( "vapor_collapse", pos, Angle( 0, 0, 0 ) )
	else
		ParticleEffect( "vapor_collapse_cheap", pos, Angle( 0, 0, 0 ) )
	end
	
	util.ScreenShake( pos, 8, 4, 0.25, 256 )
	self:EmitSound( self.SndImpact )
	
	self:KillSilent()
	
	end
	
end

---------------------------------------------------------------------------------------------------------
---##------##----####----------#######-------######------#######-----########----########------#######---
----##----##--------##---------##----##-----##----##-----##----##-------##-------##-----------##---------
-----##--##--------####--------#######-----##------##----#######--------##-------######------##----------
------####--------##--##-##----##-----------##----##-----##---##--------##-------##-----------##---------
-------##--------##----###-----##------------######------##----##-------##-------########------#######---
---------------------------------------------------------------------------------------------------------