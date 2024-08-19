AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "bloom/halo_static_2" ) --"particle/fire" )

ENT.PrintName 		= "ngen missile cheap"
ENT.SvThinkDelay 	= 0
ENT.RMdl 			= "models/weapons/w_missile_launch.mdl"
ENT.RMat 			= "models/weapons/w_missile/w_missile_side" 
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSProp 		= "Metal"
ENT.PhxSSize 		= nil
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.PhxMass			= 1
ENT.PhxElastic		= 3200
ENT.FxTracer 		= nil
ENT.SndImpact 		= "BaseExplosionEffect.Sound" --"scifi.seraph.fire1"
ENT.LifeTime		= 6
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "220 120 80 255" --"80 10 4 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 128
ENT.LightBrightness	= 2
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = Color( 255, 180, 100 )
ENT.LightFlareAlpha	= 210
ENT.LightFlareAdd 	= true 
ENT.LightFlareSize 	= 0.4

ENT.MeteorEnabled 			= true
ENT.MeteorDetectionRange 	= 128
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInitial 	= 512
ENT.MeteorVelocityScale 	= 6
ENT.MeteorHomingFactor 		= 1024
ENT.MeteorAlwaysTrack  		= true
ENT.MeteorSwayScale 		= 0.1
ENT.MeteorVelocityDecay 	= false
ENT.MeteorNeverForget 		= true
ENT.MeteorSelfDestruct 		= true
ENT.MeteorDetectionRange 	= 32

function ENT:SubInit( ent, phys )
	
	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 								-- parent
				0, 									-- attachment ID
				Color( 46, 42, 3, 80 ), 			-- Color
				false, 								-- force additive rendering
				16, 								-- start width
				0, 									-- end width
				0.72,								-- lifetime
				32,									-- texture resulution
				"particle/beam_smoke_02.vmt" 		-- texture
			)
		end

		ent:SetXPloding( false )
	end
	
end

function ENT:PhysicsCollide( data, phys )
	
	if ( data.Speed > 72 ) then 
		self:EmitSound( "Grenade.ImpactHard" )
	end

	if ( !self:GetXPloding() ) then
		self:XPlode()
	end
	
end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	util.Decal( "scorch", self:GetPos(), self:GetPos() - Vector( 0, 0, 8 ) )

	if ( SERVER ) then

		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_AIRBOAT ), 1000 * amp, self:GetPos(), 64 )
		self:DealAoeDamage( DMG_BLAST, 1000 * amp, self:GetPos(), 64 )
		self:DealAoeDamage( DMG_BLAST, 8 * amp, self:GetPos(), 1024 )
		
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", "255 170 120 255" )
		fx:SetKeyValue( "spotlight_radius", 1024 )
		fx:SetKeyValue( "distance", 1024 )
		fx:SetKeyValue( "brightness", 4 )
		fx:SetPos( self:GetPos() )
		fx:Spawn()
		
	--	ParticleEffect( "spr_explosion_large_smoshroom", fx:GetPos() + Vector( 0, 0, 24 ), Angle( 1, 1, 1 ), self:GetValidOwner() )
	--	ParticleEffect( "xplo_hit", fx:GetPos() + Vector( 0, 0, 32 ), Angle( 1, 1, 1 ), self:GetValidOwner() )
		ParticleEffect( "spr_explosion_large", fx:GetPos(), Angle( 1, 1, 1 ), self:GetValidOwner() )
		
		self:EmitSound( "BaseExplosionEffect.Sound" )
		fx:EmitSound( "explode_4" )
		util.ScreenShake( fx:GetPos(), 2048, 512, 1.2, 1024 )
		
		self:KillSilent()
		SafeRemoveEntityDelayed( fx, 0.16 )
		
	end
	
end