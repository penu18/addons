AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

-- ENT.NewHitMechanic 	= true
ENT.ProjectileImpactRule = bit.bor( PROJECTILE_IMPACT_PHYSICS, PROJECTILE_IMPACT_TRIGGER, PROJECTILE_IMPACT_TRACECAST )
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PrintName 		= "Vapor Strike"
ENT.RMdl 			= ""
ENT.PhxSSize		= 0.2
ENT.PhxMass 		= 4
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "vapor_secfire_fancyshit" 
ENT.LifeTime		= 120
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.OnImpact		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "0 40 255 255"
ENT.LightSpotRadius	= 280
ENT.LightDistance	= 512
ENT.LightBrightness	= 1
ENT.LightFlareAlpha = 10
ENT.LightFlareSize 	= 1.4
			
local panicents = { 
	"vapor_sfire",
	"beam",
	"bullseye_strider_focus",
	"env_entity_maker",
	"env_explosion",
	"env_lightglow",
	"info_npc_spawn_destination",
	"func_areaportal",
	"func_breakable",
	"func_movelinear",
	"func_physbox",
	"gmod_hands",
	"gmod_legs",
	"light_dynamic",
	"npc_template_maker",
	"phys_bone_follower",
	"player",
	"predicted_viewmodel",
	"point_spotlight",
	"spotlight_end",
	"water_lod_control",
}

function ENT:OnTakeDamage( dmginfo )

	if ( self:GetXPloding() ) then return end
	
	self:XPlode()
	
	return true
	
end

function ENT:XPlode( pCollisionData )

	if ( self:GetXPloding() ) then return end

	self:SetXPloding( true )

	if ( SERVER ) then
		local master = self:GetValidOwner()
		
		local amp = GetConVarNumber( "sfw_damageamp" )
		local dmg = 200 * amp
		local range = math.Clamp( 300 * amp, 300, 1024 )
		local pos 
		if ( pCollisionData && pCollisionData.HitPos ) then
			pos = pCollisionData.HitPos
		else
			pos = self:GetPos()
		end
		
		local flash = ents.Create( "light_dynamic" )
		if ( !IsValid( flash ) ) then return end
		flash:SetKeyValue( "_light", "40 80 255 255" )
		flash:SetKeyValue( "spotlight_radius", 2048 )
		flash:SetKeyValue( "distance", 4096 + range )
		flash:SetKeyValue( "brightness", 3 )
		flash:SetPos( pos )
		flash:Spawn()

		local fx = ents.Create( "light_dynamic" )
		fx:SetKeyValue( "_light", "1 80 255 255" )
		fx:SetKeyValue( "brightness", 5.5 )
		fx:SetPos( pos )
		fx:Spawn() 
		
		DLightFade( fx, 0, 420 + range, 2.2, 3.99 )
			
		fx:EmitSound( "scifi.vapor.altfireboom" )
		fx:EmitSound( "scifi.vapor.altfireecho" )
			
		local fx2 = EffectData()
		fx2:SetOrigin( pos )
		fx2:SetAngles( Angle( 0, 0, 0 ) )
		fx2:SetRadius( 100 )
		fx2:SetScale( 0.5 )
	--		fx2:SetEntity( self )
		fx2:SetNormal( Vector( 0.1, 0.4, 2 ) )
		util.Effect( "scifi_aftershock", fx2 )
		
		-- adding yet another damage instance for directly hit targets, because this weapons isn't overpowered enough as it is --

		if ( pCollisionData && pCollisionData.Entity ) then
			self:DealDirectDamage( bit.bor( DMG_GENERIC ), dmg * 2, pCollisionData.Entity, master )
		end
		
		for i = 0, 3 do
			DoElementalEffect( { Element = EML_DISSOLVE_VAPOR_HEAVY, Attacker = master, Origin = pos, Range = range * 0.7, Ticks = 16, DslvMaxMass = 3000, ForceCheapFX = true } ) -- What the hell does even have 3000 units heavy stuff?
			self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_DIRECT, DMG_BLAST, DMG_AIRBOAT ), dmg, pos, range ) --bit.bor( DMG_GENERIC, DMG_DIRECT, DMG_BLAST, DMG_AIRBOAT, DMG_RADIATION ), dmg, pos, range )
			self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_BURN, DMG_RADIATION, DMG_PREVENT_PHYSICS_FORCE, DMG_ALWAYSGIB ), 4, pos, range * 3 )

			util.ScreenShake( pos, 1024, 64, 2, 1512 + range )	
		end
		
		for k, v in pairs ( ents.FindInSphere( pos, 1024 ) ) do 
			 if ( v:IsPlayer() ) then
				v:ScreenFade( SCREENFADE.IN, Color( 180, 210, 255, 210 ), 0.09, 0.09 )
			end
		end
		
		local astrk = ents.Create( "env_ar2explosion" )
		astrk:SetKeyValue( "material", "effects/phaz_vapor" )
		astrk:SetPos( pos )
		astrk:Spawn()
		astrk:Fire( "explode", "", 0 )

		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
			ParticleEffect( "vsecfire_shockwave", pos, Angle( 1, 2, 3 ) )
			
			local swave = ents.Create( "env_rotorwash_emitter" )
			swave:SetPos( pos + Vector( 0, 0, 16 ) )
			swave:SetParent( fx )
			swave:Spawn()
			
			SafeRemoveEntityDelayed( swave, 0.5 )
		end
		
		if ( GetConVarNumber( "sfw_sk_vapor_enableoverpower" ) == 1 ) then
			ParticleEffect( "vsecfire_shockwave_radiation", pos, Angle( 0, 0, 0 ), fx )
			ParticleEffect( "vsecfire_afterglow", pos, Angle( 0, 0, 0 ), fx )
			ParticleEffect( "vsecfire_nukehalo", pos, Angle( 0, 0, 0 ), fx )
			
			self:DealAoeDamageOverTime( bit.bor( DMG_BLAST, DMG_DISSOLVE ), 16342 * amp, fx:GetPos(), 2048, 1, 0, fx )
			
			local tars = ents.FindInSphere( pos, 2048 )
			tars = table.Add( tars, ents.FindInSphere( fx:GetPos(), range ) )
		
			for k, v in pairs ( tars ) do
				if ( table.HasValue( panicents, v:GetClass() ) ) then
					DevMsg( "@sfw_vapor : !PanicENT; Found " .. v:GetClass() .. " in range! Excluding from dissolve index!\n" )
				else
					v:SetKeyValue( "targetname", "vprze" )
					DevMsg( v )
				end
			end
			
			local vapor = ents.Create( "env_entity_dissolver" )
			vapor:SetKeyValue( "dissolvetype", 3 )
			vapor:SetKeyValue( "magnitude", 100 )
			vapor:SetPos( fx:GetPos() )
			vapor:Spawn()
			vapor:Fire( "Dissolve", "vprze", 0.1 )
			SafeRemoveEntityDelayed( vapor, 5 )
			DevMsg( "@sfw_vapor : Entities have been dissolved." )
			
			for k, v in pairs ( ents.FindByClass( "player" ) ) do
				v:SetKeyValue( "targetname", v:GetClass() )
			end
		end

		SafeRemoveEntityDelayed( flash, 0.08 )
		SafeRemoveEntityDelayed( fx, 4 )
		SafeRemoveEntityDelayed( astrk, 5 )
		
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