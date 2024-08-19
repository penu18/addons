AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_sprites = GetConVar( "sfw_fx_sprites" )
ENT.ProjectileImpactLogic = bit.bor( PROJECTILE_IMPACT_PHYSICS, PROJECTILE_IMPACT_TRIGGER )
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.NewHitMechanic 	= false
ENT.PrintName 		= "Spectral charge"
ENT.PhxCGroup 		= COLLISION_GROUP_NONE --COLLISION_GROUP_DEBRIS
ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "spectra_core_evensmaller" 
ENT.SndImpact 		= "scifi.spectra.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "120 140 255 255"
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 300
ENT.LightBrightness	= 1
ENT.LightDieTime	= 0.4
ENT.LightDecay		= 1768
ENT.LightFlareColor	= Color( 110, 130, 220 )
ENT.LightFlareSize 	= 0.8
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.spectra.flyby"

ENT.MeteorEnabled 			= true
ENT.MeteorAlwaysTrack 		= false
ENT.MeteorDetectionRange 	= 24
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInital 	= 0
ENT.MeteorVelocityScale 	= 0
ENT.MeteorHomingFactor 		= 0.125
ENT.MeteorSwayScale 		= 0
ENT.MeteorVelocityDecay 	= true
ENT.MeteorNeverForget 		= true
ENT.MeteorPreserveInitial 	= true

function ENT:SubInit()

	self:SetXPloding( false )

	if ( SERVER ) then
		if ( cmd_sprites:GetBool() ) then
			util.SpriteTrail( 
				self, 								-- parent
				1, 									-- attachment ID
				self.LightFlareColor, 				-- Color
				1, 									-- force additive rendering
				6, 									-- start width
				0, 									-- end width
				0.04,								-- lifetime
				16,									-- texture resulution
				"particle/beam_fire_nocolor_add.vmt" 			-- texture
			)
		end
	self:SetTrigger( false )
	end
end
--[[
function ENT:SubThink()

	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	local trData = {}
	local trResult = {}
	local trSize = Vector( 4, 4, 4 )

	trData.start 		= eOrigin - eOffset * 24
	trData.endpos 		= eOrigin + eOffset * 24
	trData.filter 		= { self, self.Owner }
	trData.mins 		= trSize * -1
	trData.maxs 		= trSize
	trData.mask 		= MASK_SHOT_HULL
	trData.ignoreworld 	= true
	trData.output 		= trResult
	
	util.TraceHull( trData )

--	if ( CLIENT ) then
--		debugoverlay.Box( trData.start, trData.mins, trData.maxs, 0.1, Color( 255, 128, 0, 6 ) ) 
--	end
	
	if ( SERVER ) && ( trResult.Hit ) then
		if ( trResult.HitSky ) then
			self:KillSilent()
			return
		end
	
		self:XPlode( trResult )
		
--		debugoverlay.Box( trData.start, trData.mins, trData.maxs, 0.25, Color( 0, 128, 128, 6 ) ) 
	end

end
]]--
function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 0.75
	end

	return mul

end

function ENT:OnImpactDealDamage( pos )
	
	local dmg_1 = 8 * GetConVar( "sfw_damageamp" ):GetFloat()
	
	if ( !pos ) then
		pos = self:GetPos()
	end
	
	if ( self:GetNWInt( "Elemental" ) == 0 ) then
		self:DealPointDamage( bit.bor( DMG_BULLET, DMG_NEVERGIB ), dmg_1, pos, 128, 4, 32 )
		self:DealAoeDamage( bit.bor( DMG_BUCKSHOT, DMG_NEVERGIB ), dmg_1 / 2, pos, 32 )
		return
	end
	
	if ( self:GetNWInt( "Elemental" ) == 1 ) then
		self:DealAoeDamage( bit.bor( DMG_BULLET, DMG_SLASH, DMG_NEVERGIB ), dmg_1, pos, 32 )
		ParticleEffect( "xplo_hit_cheap", pos, self:GetAngles() )
		self:EmitSound( "scifi.hwave.hit" )
		return
	end
	
	if ( self:GetNWInt( "Elemental" ) == 2 ) then
		self:DealAoeDamage( DMG_ACID, dmg_1, pos, 32 )
		ParticleEffect( "pest_hit", pos, self:GetAngles() )
		self:EmitSound( "cat.pest.hit" )
		return
	end
	
	if ( self:GetNWInt( "Elemental" ) == 3 ) then
		self:DealAoeDamage( DMG_SF_ICE, dmg_1, pos, 32 )
		ParticleEffect( "eml_generic_cryo_small", pos, self:GetAngles() )
		self:EmitSound( "scifi.bliz.hit" )
		return
	end
	
	if ( self:GetNWInt( "Elemental" ) == 4 ) then
		self:DealPointDamage( DMG_SF_BLIGHT, dmg_1, pos, 64 )			
		self:DealAoeDamage( DMG_SF_BLIGHT, dmg_1 / 2, pos, 32 )
		ParticleEffect( "fstar_hit", pos, self:GetAngles() )
		return
	end
	
end

function ENT:OnImpactDealElemental( pos )
	
	if ( !pos ) then
		pos = self:GetPos()
	end

	if ( self:GetNWInt( "Elemental" ) == 1 ) then
		for k,v in pairs ( ents.FindInSphere( pos, 40 ) ) do
			if ( GetRelChance( 20 ) ) && ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) then
				DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 2, Attacker = self.Owner } )
			end
		end
		return
	end
	
	if ( self:GetNWInt( "Elemental" ) == 2 ) then
		for k,v in pairs ( ents.FindInSphere( pos, 40 ) ) do
			if ( GetRelChance( 20 ) ) && ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) then
				DoElementalEffect( { Element = EML_CORROSIVE, Target = v, Attacker = self.Owner, Inflictor = self.Owner:GetActiveWeapon() } )
			end
		end
		return
	end
	
	if ( self:GetNWInt( "Elemental" ) == 3 ) then
		for k,v in pairs ( ents.FindInSphere( pos, 40 ) ) do
			if ( GetRelChance( 20 ) ) && ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) then
				DoElementalEffect( { Element = EML_ICE, Target = v, Duration = 2, Attacker = self.Owner } )
			end
		end
		return
	end
	
	if ( self:GetNWInt( "Elemental" ) == 4 ) then
		for k,v in pairs ( ents.FindInSphere( pos, 40 ) ) do
			if ( GetRelChance( 20 ) ) && ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) then
				DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 1, Attacker = self.Owner } )
			end
		end
		return
	end
	
end

function ENT:XPlode( trResult )
	
	if ( !trResult ) then return end
	if ( self:GetXPloding() ) then DevMsg( "@sfw_alchemy : !Error; Unintended multi-hit damage infliction!" ) return end
	
	self:SetXPloding( true ) 
	
	local pos = trResult.HitPos -- trResult.HitNormal * 4 || self:GetPos()
	local ang = self:GetAngles()
	
	if ( SERVER ) then
		local phys = self:GetPhysicsObject()
		if ( phys ) then
			phys:EnableMotion( false )
		end
		
		self:OnImpactDealDamage( pos )
		self:OnImpactDealElemental( pos )

		ParticleEffect( "spectra_hit", pos, ang )
		if ( self:WaterLevel() > 0 ) then
			ParticleEffect( "event_onwater_remove", pos, ang )
		end 
		
		util.ScreenShake( pos, 4, 4, 0.25, 256 )
		
		self:EmitSound( self.SndImpact )
		self:KillSilent()
	end
	
end

function ENT:DoImpactEffect( tTrace, iDamageType )
	
--	util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
    return true
	
end