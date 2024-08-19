AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "effects/led_glow" ) --"effects/redflare" )

ENT.PrintName 		= "mirv grenade"
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
ENT.FxTracer 		= "gunsmoke"
ENT.SndImpact 		= "BaseExplosionEffect.Sound" --"scifi.seraph.fire1"
ENT.LifeTime		= 2
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "220 160 0 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 32
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = nil --Color( 255, 255, 255 )
ENT.LightFlareAlpha	= 220
ENT.LightFlareSize 	= 0.32

function ENT:SubInit( ent )

	if ( SERVER ) then
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
	
	if ( self.LauncherMode ) && ( !self:GetXPloding() ) then
		self:XPlode()
	end
	
end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	local pos = self:GetPos()
	
	util.Decal( "scorch", self:GetPos(), self:GetPos() - Vector( 0, 0, 8 ) )

	if ( SERVER ) then
		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_AIRBOAT ), 4 * amp, pos, 256 )
		
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", "255 170 120 255" )
		fx:SetKeyValue( "spotlight_radius", 128 )
		fx:SetKeyValue( "distance", 256 )
		fx:SetKeyValue( "brightness", 1 )
		fx:SetPos( pos )
		fx:Spawn()
		
		ParticleEffect( "xplo_hit", fx:GetPos(), Angle( 0, 0, 0 ) )
		
		fx:EmitSound( "Weapon_SMG1.Double" )
		
		util.ScreenShake( fx:GetPos(), 64, 512, 0.8, 256 )
		
		self:KillSilent()
		SafeRemoveEntityDelayed( fx, 0.16 )
	
		local childs = 0
		for i=0, 6 do 
			if ( childs > 6 ) then return end
			
			local child = ents.Create( "sfw_mirv_child" )
			if ( !IsValid( child ) ) then return end
			child:SetPos( pos )
			child:SetOwner( self:GetValidOwner() )
			child:Spawn()
			child:Activate()
			child:SetPhysicsAttacker( self.Owner, 10 )
			
			local cphys = child:GetPhysicsObject()
			if ( !IsValid( cphys ) ) then child:KillSilent() end
			cphys:ApplyForceCenter( Vector( math.random( -2000, 2000 ), math.random( -2000, 2000 ), math.random( 200, 2000 ) ) )

			childs = childs + 1
		end
	end
	
end