AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "effects/led_glow" ) --"effects/redflare" )

ENT.PrintName 		= "fathom grenade"
ENT.SvThinkDelay 	= 0
ENT.RMdl 			= "models/catalyst/items/biocontainer.mdl"
ENT.RMat 			= "models/weapons/fathom/biocontainer_azure" 
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSProp 		= "Metal"
ENT.PhxSSize 		= nil
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 5
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "nrg_heat"
ENT.LifeTime		= 2
ENT.KillSilentDelay = 0.1
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightExplode 	= 24
ENT.LightColor		= "29 80 255 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 32
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = nil --Color( 255, 255, 255 )
ENT.LightFlareAlpha	= 160
ENT.LightFlareSize 	= 0.24
ENT.LauncherMode 	= false

function ENT:SubInit( ent )

	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 								-- parent
				1, 									-- attachment ID
				string.ToColor( self.LightColor ), 	-- Color
				1, 									-- force additive rendering
				2, 									-- start width
				0, 									-- end width
				0.2,								-- lifetime
				16,									-- texture resulution
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
	local master = self:GetValidOwner()

	if ( SERVER ) then
		self:DealAoeDamage( bit.bor( DMG_ENERGYBEAM, DMG_ALWAYSGIB ), 72 * amp, pos, 128 ) -- Remember: This 33540137 is the ultimate damage type...
		DoElementalEffect( { Element = EML_DISSOLVE_VAPOR, Attacker = master, Origin = pos, Range = 86, Ticks = 25, DslvMaxMass = 500 } ) 
		
		ParticleEffect( "vapornade_explosion", pos, Angle( 0, 0, 0 ) )
		
		self:EmitSound( "scifi.vapor.nade.explo" )
		
		util.ScreenShake( pos, 32, 512, 0.4, 620 )

		self:KillSilent()
	end
	
end