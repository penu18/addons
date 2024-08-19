AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "effects/led_glow" ) --"effects/redflare" )

ENT.PrintName 		= "mirv child"
ENT.RMdl 			= "models/Items/AR2_Grenade.mdl"
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSProp 		= "Metal"
ENT.PhxSSize 		= nil
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 5
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "gunsmoke"
ENT.SndImpact 		= "BaseExplosionEffect.Sound" --"scifi.seraph.fire1"
ENT.LifeTime		= 1
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "220 140 10 255" --"80 10 4 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 32
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = nil --Color( 255, 255, 255 )
ENT.LightFlareAlpha	= 220
ENT.LightFlareSize 	= 0.24

function ENT:SubInit( ent )

	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 								-- parent
				1, 									-- attachment ID
				string.ToColor( self.LightColor ), 			-- Color
				true, 								-- force additive rendering
				2, 									-- start width
				0, 									-- end width
				0.6,								-- lifetime
				32,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end

		ent:SetXPloding( false )
	end
	
end

function ENT:SubThink()
	
	if ( SERVER ) then
		if ( self.DieTime <= CurTime() ) && ( !self:GetXPloding() ) then
			self:XPlode()
		end
	end

end

function ENT:PhysicsCollide( data, phys )
	
	if ( data.Speed > 72 ) then 
		self:EmitSound( "Grenade.ImpactHard" )
	end
	
	if ( IsValid( data.Entity ) ) && ( !data.Entity:IsWorld() ) then
		data.PhysObject:SetVelocity( data.PhysObject:GetVelocity() * 0.4 )
	end
	
end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	local pos = self:GetPos()
	util.Decal( "scorch", pos, pos - Vector( 0, 0, 8 ) )

	if ( SERVER ) then

		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_AIRBOAT ), 60 * amp, pos, 128 )
		self:DealAoeDamage( DMG_BLAST, 60 * amp, pos, 128 )
		
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", "255 170 120 255" )
		fx:SetKeyValue( "spotlight_radius", 512 )
		fx:SetKeyValue( "distance", 512 )
		fx:SetKeyValue( "brightness", 4 )
		fx:SetPos( pos )
		fx:Spawn()
		
		ParticleEffect( "eml_generic_blast", fx:GetPos(), Angle( 1, 1, 1 ), self:GetValidOwner() )
		
		fx:EmitSound( "BaseExplosionEffect.Sound" )
	--	fx:EmitSound( "explode_4" )
		
		util.ScreenShake( fx:GetPos(), 2048, 512, 1.2, 512 )
		
		self:KillSilent()
		SafeRemoveEntityDelayed( fx, 0.16 )
		
	end
	
end