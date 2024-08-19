AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "effects/led_glow" ) --"effects/redflare" )

ENT.PrintName 		= "ngen grenade"
ENT.RMdl 			= "models/weapons/w_grenade.mdl"
ENT.RMat 			= "models/weapons/w_grenade/w_grenadesheet" 
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSProp 		= "Metal"
ENT.PhxSSize 		= nil
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 5
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "spr_nade_tick"
ENT.SndImpact 		= "BaseExplosionEffect.Sound" --"scifi.seraph.fire1"
ENT.LifeTime		= 6
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "220 40 10 255" --"80 10 4 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 32
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = nil --Color( 255, 255, 255 )
ENT.LightFlareAlpha	= 220
ENT.LightFlareSize 	= 0.32
ENT.LightXplode 	= 14
ENT.LightXplodeSun 	= true
ENT.NextTick 		= 0
ENT.LauncherMode 	= false
ENT.Left4Mode 		= false

function ENT:SubInit( ent )

	if ( SERVER ) then
		if ( self.Left4Mode ) then
			self.NextTick = CurTime() + 6
		else
			self.NextTick = CurTime() + 2
		end
		
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 								-- parent
				1, 									-- attachment ID
				string.ToColor( self.LightColor ), 	-- Color
				1, 									-- force additive rendering
				4, 									-- start width
				0, 									-- end width
				0.2,								-- lifetime
				32,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
		
		ent:SetXPloding( false )
	end
	
end

local tick = 0
function ENT:SubThink()
	
	if ( self.LauncherMode ) then
		self.LightColor = "40 255 40 255"
		
		return
	end
	
	if ( SERVER ) then
		local frac = self.DieTime - CurTime()
		local mul = self.LifeTime - frac
		local step = ( frac / 200 ) * frac

		if ( tick < CurTime() ) then
			self:EmitSound( "buttons/button15.wav", 60, 100 + 20 * mul, 1, CHAN_STATIC )

			tick = CurTime() + step
		end
			
		if ( self.NextTick <= CurTime() ) && ( !self:GetXPloding() ) then
			self:XPlode()
		end

		local tBaitMe = {
			[ CLASS_HACKED_ROLLERMINE ] = true,
			[ CLASS_SCANNER ] = true,
			[ CLASS_BARNACLE ] = true,
			[ CLASS_ZOMBIE ] = true,
			[ CLASS_INSECT ] = true,
			[ CLASS_ALIEN_PREY ] = true,
			[ CLASS_ALIEN_MONSTER ] = true,
			[ CLASS_HEADCRAB ] = true,
			[ CLASS_ANTLION ] = true,
		}
		
		if ( self.Left4Mode ) then
			for k,v in pairs ( ents.FindInSphere( self:GetPos(), 512 ) ) do
				if ( v:IsNPC() && tBaitMe[ v:Classify() ] ) then
					v:SetSaveValue( "m_vecLastPosition", self:GetPos() )
					v:SetSchedule( SCHED_FORCED_GO_RUN )
					v:SetEnemy( self )
					v:SetTarget( self )
				end
			end
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
	
	if ( self.LauncherMode ) && ( !self:GetXPloding() ) then
		self:XPlode()
	end
	
end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )
	
	local fxOwner = self:GetValidOwner()
	local fxOrigin = self:GetPos()
	local fxOffset = Vector( 0, 0, 0 )
	local fxAngle = Angle( 0, 0, 0 )
	
	local amp = GetConVarNumber( "sfw_damageamp" )
	util.Decal( "scorch", self:GetPos(), self:GetPos() - Vector( 0, 0, 8 ) )
	
	if ( CLIENT ) then
		local fxVisiable = util.PixelVisible( fxOrigin, 4, self.PixVis )
		
		if ( fxVisible > 0.2 ) then
			CreateParticleSystem( self, "spr_explosion_large_flash_noz", 0, 0, fxOffset ) 
		end
	end

	if ( SERVER ) then
		self:DealAoeDamage( DMG_BLAST, 160 * amp, self:GetPos(), 256 )
		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_AIRBOAT ), 160 * amp, self:GetPos(), 256 )
		self:DealAoeDamage( DMG_BLAST, 8 * amp, self:GetPos(), 512 )
		
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", "255 170 120 255" )
		fx:SetKeyValue( "spotlight_radius", 1024 )
		fx:SetKeyValue( "distance", 1024 )
		fx:SetKeyValue( "brightness", 4 )
		fx:SetPos( self:GetPos() )
		fx:Spawn()
		fx:Fire( "kill", "", 0.15 )
		
		local fx2 = EffectData()
		fx2:SetOrigin( fxOrigin )
		fx2:SetAngles( fxAngle )
		fx2:SetRadius( 50 )
		fx2:SetScale( 0.2 )
--		fx2:SetEntity( self )
		fx2:SetNormal( Vector( 0.6, 0.6, 0 ) )
		util.Effect( "scifi_aftershock", fx2 )
	
		ParticleEffect( "spr_explosion_large", fx:GetPos(), Angle( 0, 0, 0 ), fxOwner )
		
		if ( IsMounted( "left4dead2" ) ) then
			fx:EmitSound( "weapons/hegrenade/explode3.wav", 100, math.random( 95, 105), 0.6, CHAN_WEAPON )
		else
			fx:EmitSound( "BaseExplosionEffect.Sound" )
		end
	
		fx:EmitSound( "explode_4" )
		util.ScreenShake( fx:GetPos(), 2048, 512, 1.2, 1024 )
		
		self:KillSilent()
	end
	
end