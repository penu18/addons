AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_sprites = GetConVar( "sfw_fx_sprites" )

ENT.PrintName 		= "Vectra Bolt"
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "spectra_core_evensmaller" 
ENT.SndImpact 		= "scifi.spectra.hit"
ENT.LifeTime		= 2
ENT.KillSilentDelay = 0
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "120 140 255 255"
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 300
ENT.LightXplode 	= 2.5
ENT.LightBrightness	= 1
ENT.LightDieTime	= 0.4
ENT.LightDecay		= 3584
ENT.LightFlareColor	= Color( 110, 130, 220 )
ENT.LightFlareSize 	= 0.8
ENT.DieOnTouch 		= true
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.spectra.flyby"

ENT.MeteorEnabled 			= false
ENT.MeteorAlwaysTrack 		= false
ENT.MeteorDetectionRange 	= 32
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInital 	= 0
ENT.MeteorVelocityScale 	= 0
ENT.MeteorHomingFactor 		= 0.4
ENT.MeteorSwayScale 		= 0
ENT.MeteorVelocityDecay 	= false
ENT.MeteorNeverForget 		= true
ENT.MeteorPreserveInitial 	= true

function ENT:SubInit( ent ) 

	if ( SERVER ) then
		if ( cmd_sprites:GetBool() ) then
			util.SpriteTrail( 
				self, 								-- parent
				1, 									-- attachment ID
				self.LightFlareColor, 				-- Color
				1, 									-- force additive rendering
				8, 								-- start width
				0, 									-- end width
				0.04,								-- lifetime
				16,									-- texture resulution
				"particle/beam_fire_nocolor_add.vmt" 			-- texture
			)
		end
	end

end

function ENT:SubThink()

	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	local trData = {}
	local trResult = {}
	local trSize = Vector( 1, 8, 8 )

	trData.start 		= eOrigin - eOffset * 2
	trData.endpos 		= eOrigin + eOffset * 2
	trData.filter 		= function( ent ) 	
							if !( ent || IsValid( ent ) ) then 
								return false
							end
							
							if ( ent:GetClass() == self.ClassName ) then
								return false
							end
							
							if ( ent == self || ent == self.Owner || ent:GetOwner() == self.Owner ) then 
								return false
							end

							return true 
						end
	
	trData.mins 		= trSize * -1
	trData.maxs 		= trSize
	trData.mask 		= MASK_SHOT_HULL
	trData.ignoreworld 	= false --true
	trData.output 		= trResult

	util.TraceHull( trData )

	local lnData = {}
	local lnResult = {}

	lnData.start 		= eOrigin - eOffset * 86
	lnData.endpos 		= eOrigin + eOffset * 86
	lnData.filter 		= trData.filter
	lnData.mask 		= MASK_SHOT_HULL
	lnData.ignoreworld 	= false
	lnData.output 		= lnResult
	
	util.TraceLine( lnData )
	
	if ( SERVER ) && ( trResult.HitSky || lnResult.HitSky ) && ( !self:GetXPloding() ) then
		self:SetXPloding( true )
		self:Remove()
	end

	if ( SERVER ) && ( lnResult.Hit || trResult.Hit ) && ( !self:GetXPloding() ) then
		local data
		if ( trResult.Hit ) then
--			print("hull")
			data = trResult
		else
--			print("line")
			data = lnResult
		end
		
		data.HitEntity = data.Entity
		
		self:XPlode( data )
	end

end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	local IsXploding = self:GetXPloding()

	if ( self.DieOnTouch ) then
		if ( !IsXploding ) then
			self:XPlode( pCollisionData )
		end
	
		self:KillSilent()
	else
		local vOld = pCollisionData.OurOldVelocity
		local vSpeed = vOld:Length() + 20
		local vNormal = vOld:GetNormalized()

		if ( !IsXploding ) then
			self:XPlode( pCollisionData )
		end

		local vNew = ( vNormal - pCollisionData.HitNormal ) * vSpeed
		pPhysicsObject:SetVelocity( vNew )
		
--		debugoverlay.Line( pCollisionData.HitPos, pCollisionData.HitPos + vOld * -32, 4, Color( 0, 128, 255, 255 ), true )
--		debugoverlay.Line( pCollisionData.HitPos, pCollisionData.HitPos + vNew * 32, 4, Color( 255, 128, 0, 255 ), true )
		
		self.DieOnTouch = true
		
		self:SetXPloding( false )
	end
		
end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 0.75
	end

	return mul

end

function ENT:XPlode( pCollisionData )

	if ( self:GetXPloding() ) then return end
	if ( !pCollisionData ) then return end
	
	self:SetXPloding( true ) 
	local proc = math.random( 0, 100 )
	
	if ( CLIENT ) && ( proc >= 80 ) then
		self.LightXplode = 4
	end

	if ( SERVER ) then
		local pos = pCollisionData.HitPos - pCollisionData.HitNormal * 2 || self:GetPos()
		local ang = self:GetAngles()
		local amp = GetConVar( "sfw_damageamp" ):GetFloat()
		local dmg = 10 * amp
		local range = 0
		
		if ( !self.DieOnTouch ) then
			range = 400
		else
			range = 320
		end

		if ( proc >= 80 ) then
			self:DealPointDamage( bit.bor( DMG_BULLET, DMG_NEVERGIB, DMG_ENERGYBEAM, DMG_SHOCK ), dmg, pos, range, 1, 4 )
			
			if ( pCollisionData ) then
				if ( self:WaterLevel() < 3 ) then
					DoElementalEffect( { Element = EML_SHOCK, Target = pCollisionData.HitEntity, Attacker = self.Owner } )
				else
					for k,v in pairs( ents.FindInSphere( pos, 512 ) ) do
						if ( v:WaterLevel() > 0 ) then
							DoElementalEffect( { Element = EML_SHOCK, Target = v, Attacker = self.Owner } )
						end
					end
				end

				ParticleEffect( "eml_generic_shock", pos, ang )
				self:EmitSound( "Scifi.Blade.Hit.Electric03" )
			end
		else
			self:DealPointDamage( bit.bor( DMG_BULLET, DMG_NEVERGIB, DMG_ENERGYBEAM ), dmg, pos, range, 1, 4 )
		end
		
		self:DealAoeDamage( bit.bor( DMG_BULLET, DMG_NEVERGIB, DMG_ENERGYBEAM ), dmg * 0.2, pos, 32 )
	
		ParticleEffect( "astra_hit", pos, ang )
		if ( self:WaterLevel() > 0 ) then
			ParticleEffect( "event_onwater_remove", pos, ang )
		end
		util.ScreenShake( pos, 16, 6, 0.25, 256 )
		
		self:EmitSound( self.SndImpact )
	end
	
end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
    return true
	
end