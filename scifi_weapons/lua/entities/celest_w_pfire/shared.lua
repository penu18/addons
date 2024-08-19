AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_pfx = GetConVarNumber( "sfw_fx_particles" )
local cmd_sprites = GetConVarNumber( "sfw_fx_sprites" )
local cmd_bloom = GetConVarNumber( "sfw_allow_bloomtest" )

ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0

-- ENT.NewHitMechanic = true

ENT.PrintName 		= "Spectral wrath charge"
ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 1
ENT.PhxMaxVelocity  = 8000	
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "celest_wrath_tracer" 
ENT.SndImpact 		= "scifi.spectra.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "255 20 0 255"
ENT.LightSpotRadius	= 80
ENT.LightDistance	= 210
ENT.LightBrightness	= 1
ENT.LightDieTime	= 1
ENT.LightDecay		= 1024
ENT.LightFlareColor	= Color( 200, 80, 20 )
ENT.LightFlareAlpha	= 6
ENT.LightFlareSize 	= 0.8
ENT.UseChargeMode 	= false
ENT.UseElemental 	= true
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.spectra.flyby"

ENT.MeteorEnabled 			= false
ENT.MeteorDetectionRange 	= 128
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInital 	= 32
ENT.MeteorVelocityScale 	= 2
ENT.MeteorHomingFactor 		= 32
ENT.MeteorAlwaysTrack  		= false
ENT.MeteorSwayScale 		= 0
ENT.MeteorVelocityDecay 	= false
ENT.MeteorNeverForget 		= true

function ENT:SubInit()

	self:SetXPloding( false )
	
	if ( self.UseChargeMode ) then
		ParticleEffectAttach( "celest_wrath_nade", 1, self, 1 )
		self.MeteorEnabled = true
	end
	
end

function ENT:SubThink()

	if ( self.UseChargeMode && !self.MeteorEnabled ) then
		self.MeteorEnabled = true
	end

end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 1.3
	end
	
	if ( hgroup == HITGROUP_CHEST || hgroup == HITGROUP_STOMACH ) then
		mul = 1.2
	end
	
	return mul

end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	local IsXploding = self:GetXPloding()

	if ( !IsXploding ) then
		self:XPlode( pCollisionData )
	end
		
end

function ENT:XPlode( pCollisionData )
	
	if ( self:GetXPloding() ) then return end
	if ( !pCollisionData ) then return end
	
	self:SetXPloding( true ) 
	
	local amp = GetConVarNumber( "sfw_damageamp" )
	local dmg_1 = 12 * amp
	local dmg_2 = 4 * amp
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	
	local myeml = {}
	myeml.Element = EML_DISSOLVE_CELESTWRATH
	myeml.Range = 16
	myeml.Origin = pCollisionData.HitPos
	myeml.Target = pCollisionData.Entity

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = pos
			dlight.r = 255
			dlight.g = 80
			dlight.b = 10
			dlight.brightness = 512
			dlight.Decay = 1000
			dlight.Size = self.LightDistance * 3
			dlight.DieTime = CurTime() + 1
		end
	end

	if ( SERVER ) then
		if ( self.UseChargeMode ) then
			self:DealAoeDamage( bit.bor( DMG_CLUB, DMG_SLASH ), dmg_1 * amp, pos, 180 ) 
			self:DealAoeDamage( bit.bor( DMG_CLUB, DMG_SLASH ), dmg_2 * amp, pos, 240 ) 
			
			DoElementalEffect( myeml )

			ParticleEffect( "celest_wrath_explode", pos, ang )
			util.ScreenShake( pos, 4, 16, 0.25, 256 )
			
			local fx2 = ents.Create( "light_dynamic" )
			if ( !IsValid( fx2 ) ) then return end
			fx2:SetKeyValue( "_light", "255 20 10 255" )
			fx2:SetKeyValue( "spotlight_radius", 320 )
			fx2:SetKeyValue( "distance", 640 )
			fx2:SetKeyValue( "brightness", 3 )
			fx2:SetPos( pos )
			fx2:Spawn()
			fx2:Fire( "kill", "", 0.15 )
	
			self:EmitSound( "scifi.supra.parent.hit" )
		
			local chance = math.random( 0, 100 )
			
			if ( self.UseElemental ) then
				if ( chance < 8 ) then
					ParticleEffect( "eml_generic_crsv", pos, ang )
					self:EmitSound( Sound( "weapons/corro/burst.wav" ) )
					self:DealAoeDamage( bit.bor( DMG_ACID, DMG_NERVEGAS ), 24 * amp, pos, 200 )

					local trData = { start = pos + Vector( 0, 0, 64 ), endpos = pos - Vector( 0, 0, 64 ), filter = self, ignoreworld = false }
					local tr = util.TraceEntity( trData, self )
					
					if ( tr.HitWorld ) then
						ParticleEffect( "eml_generic_crsv_splat", tr.HitPos, ang )
					end
					
					for k, v in pairs ( ents.FindInSphere( pos, 180 ) ) do
						if ( v:IsNPC() || v:IsPlayer() ) then
							DoElementalEffect( { Element = EML_CORROSIVE, Target = v, Attacker = self.Owner, Inflictor = self.Owner:GetActiveWeapon() } )
						end
					end
				end
				
				if ( chance > 8 && chance < 16 ) then
					ParticleEffect( "eml_generic_cryo", pos, ang )
					self:EmitSound( "scifi.cryo.explode" )
					self:DealAoeDamage( bit.bor( DMG_CLUB, DMG_RADIATION ), 24 * amp, pos, 200 )
					
					local trData = { start = pos + Vector( 0, 0, 64 ), endpos = pos - Vector( 0, 0, 64 ), filter = self, ignoreworld = false }
					local tr = util.TraceEntity( trData, self )
					
					if ( tr.HitWorld ) then
						ParticleEffect( "eml_generic_cryo_ground", tr.HitPos, ang )
					end
					
					for k, v in pairs ( ents.FindInSphere( pos, 160 ) ) do
						if ( v:IsNPC() || v:IsPlayer() ) then
							DoElementalEffect( { Element = EML_ICE, Target = v, Duration = 3, Attacker = self.Owner } )
						end
						
						if ( v:GetClass() == "prop_physics" || v:GetClass() == "prop_dynamic" ) then
							if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
								ParticleEffectAttach( "ice_freezing_shortlt", 1, v, 1 )
							end
						end
					end
				end
				
				if ( chance > 16 && chance < 24 ) then
					ParticleEffect( "eml_generic_blast", pos, ang )
					self:EmitSound( "BaseExplosionEffect.Sound" )
					self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_BLAST ), 24 * amp, pos, 200 )
				end
				
				if ( chance > 24 && chance < 32 ) then
					ParticleEffect( "eml_generic_shock", pos, ang )
					ParticleEffect( "astra_hit_heavy", pos, ang )
					ParticleEffect( "shk_hit", pos, ang )
					self:EmitSound( "ReallyLoudSpark" )
					self:DealAoeDamage( DMG_ENERGYBEAM, 12 * amp, pos, 200 )
					
					for k, v in pairs ( ents.FindInSphere( pos, 256 ) ) do
						DoElementalEffect( { Element = EML_SHOCK, Target = v, Attacker = self.Owner } )
					end
				end
				
				if ( chance > 32 && chance < 40 ) then
					ParticleEffect( "eml_generic_heat", pos, ang )
					self:EmitSound( "PropaneTank.Burst" )
					self:DealAoeDamage( bit.bor( DMG_CLUB, DMG_SLASH, DMG_NEVERGIB ), 12 * amp, pos, 200 )
					
					for k, v in pairs ( ents.FindInSphere( pos, 128 ) ) do
						DoElementalEffect( { Element = EML_FIRE, Target = v, Attacker = self.Owner, Duration = 4 } )
					end
				end
			end
		else
			self:DealPointDamage( bit.bor( DMG_CLUB, DMG_SLASH ), dmg_1 * amp, pos, 128, 2, 8 )
			self:DealAoeDamage( DMG_BULLET, dmg_2 * amp, pos, 82 ) 
			
			DoElementalEffect( myeml )

			ParticleEffect( "celest_wrath_hit", pos, ang )
			util.ScreenShake( pos, 2, 4, 0.25, 256 )
			
			self:EmitSound( self.SndImpact )
		end

		if ( self:WaterLevel() > 0 ) then
			ParticleEffect( "event_onwater_remove", pos, ang )
		end

		self:KillSilent()
	end
	
end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
    return false
	
end