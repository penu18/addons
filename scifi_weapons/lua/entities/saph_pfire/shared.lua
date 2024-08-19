AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Saphyre projectile"
ENT.PhxSSize		= 0.01
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "saphyre_tracer" 
ENT.SndImpact 		= "scifi.hwave.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "20 60 255 255"
ENT.LightXplode 	= 3
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 220
ENT.LightBrightness	= 1
ENT.LightDieTime	= 1
ENT.LightDecay		= 1768
ENT.LightFlarePos 	= -24
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.hwave.flyby2"

function ENT:SubInit()

end

function ENT:SubThink()
	
end

function ENT:PhysicsCollide( data, phys )

	if ( data.HitEntity:IsNPC() ) || ( data.HitEntity:IsPlayer() ) || ( data.HitEntity:GetClass( "prop_ragdoll" ) ) then
		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then 
			ParticleEffect( "saphyre_hit_fleks", data.HitPos, self:GetAngles() )
		end
	end

	if ( !self:GetXPloding() ) then
		self:XPlode( data )
	end
	
end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 6
	end
	
	if ( hgroup == HITGROUP_CHEST || hgroup == HITGROUP_STOMACH ) then
		mul = 2
	end
	
	return mul

end

function ENT:XPlode( pCollisionData )
	
	if ( self:GetXPloding() ) then DevMsg( "@sfw_hwave : !Error; Unintended multi-hit damage infliction!" ) return end
	
	self:SetXPloding( true ) 
	
	local amp = GetConVarNumber( "sfw_damageamp" )
	local dmg = 4 * amp
	-- local dmg_2 = 1 * amp
	
	local pos = pCollisionData.HitPos - pCollisionData.HitNormal * 2 -- self:GetPos()
	local ang = self:GetAngles()

	if ( SERVER ) then
		self:DealPointDamage( bit.bor( DMG_SLASH, DMG_CLUB ), dmg, pos, 128, 8, 8 )
		self:DealAoeDamage( bit.bor( DMG_RADIATION, DMG_GENERIC ), dmg, pos, 64 )

		ParticleEffect( "saphyre_hit", pos, ang )
		util.ScreenShake( pos, 2, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	end
	
end


function ENT:ImpactTrace( tr, dmgtype )
	
	util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
    return true
	
end

----------------------------------------------------------------------------------------------------------
---##------##----####----------#######-------######------#######-----########----########------########---
----##----##--------##---------##----##-----##----##-----##----##-------##-------##-----------##----------
-----##--##--------####--------#######-----##------##----#######--------##-------######------##-----------
------####--------##--##-##----##-----------##----##-----##---##--------##-------##-----------##----------
-------##--------##----###-----##------------######------##----##-------##-------########------########---
----------------------------------------------------------------------------------------------------------