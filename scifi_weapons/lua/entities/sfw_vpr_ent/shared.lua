AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "effects/led_glow" )

PrecacheParticleSystem( "vpr_nade_blast" )
PrecacheParticleSystem( "vpr_nade_tick" )

ENT.PrintName 		= "vapor grenade"
ENT.RMdl 			= "models/w_models/weapons/w_eq_pipebomb.mdl" -- "models/weapons/w_eq_decoy_thrown.mdl"
ENT.RMat 			= "models/w_models/eq_pipebomb/w_eq_pipebomb" -- "models/weapons/w_models/w_eq_grenades/decoy_grenade.vmt"
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSProp 		= "Metal"
ENT.PhxSSize 		= nil
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 20
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "vpr_nade_tick"
ENT.FXAttachId 		= 1
ENT.LifeTime		= 3
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "80 160 255 155"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 32
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = nil
ENT.LightFlareAlpha	= 80
ENT.LightFlareSize 	= 0.32
ENT.LightXplode 	= 6
ENT.LightXplodeSun	= true
ENT.NextTick 		= 0
ENT.LauncherMode 	= false

function ENT:SubInit( ent )

	if ( SERVER ) then
		
		if ( GetConVar( "sfw_fx_sprites" ):GetBool() ) then
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
	
	self.NextTick = CurTime() + self.LifeTime
	
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
		local step = ( frac * 0.06 ) * frac

		if ( tick < CurTime() ) then
			self:EmitSound( "buttons/button15.wav", 80, 100 + 20 * mul, 1, CHAN_STATIC )

			tick = CurTime() + step
		end
			
		if ( self.NextTick <= CurTime() ) && ( !self:GetXPloding() ) then
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
		self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_GENERIC, DMG_RADIATION, DMG_SHOCK, DMG_ALWAYSGIB ), 300 * amp, self:GetPos(), 160, fxOwner, 0.2 )
		self:DealAoeDamage( DMG_BLAST, 300 * amp, self:GetPos(), 160, fxOwner, 0.4 )
		self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_PARALYZE, DMG_RADIATION, DMG_PREVENT_PHYSICS_FORCE ), 8 * amp, self:GetPos(), 320 )
		
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", "40 110 255 255" )
		fx:SetKeyValue( "spotlight_radius", 1024 )
		fx:SetKeyValue( "distance", 1024 )
		fx:SetKeyValue( "brightness", 4 )
		fx:SetPos( self:GetPos() )
		fx:Spawn()
		fx:Fire( "kill", "", 0.1 )
	
		ParticleEffect( "vpr_nade_blast", self:GetPos(), Angle( 0, 0, 0 ) )

		self:EmitSound( "scifi.vapor.explode" )
		
		util.ScreenShake( self:GetPos(), 4096, 2, 1.2, 512 )
		
		self:KillSilent()
	end
	
end