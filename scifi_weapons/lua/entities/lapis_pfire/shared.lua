AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_pfx = GetConVarNumber( "sfw_fx_particles" )
local cmd_sprites = GetConVarNumber( "sfw_sprites" )

--ENT.Type 			= "point"
ENT.NewHitMechanic 	= false
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PrintName 		= "wraithshot"
ENT.LifeTime		= 2.5
ENT.PhxCGroup 		= COLLISION_GROUP_PROJECTILE
ENT.PhxSSize		= 0.001
ENT.PhxMaxVelocity 	= 7200
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracerNew 	= true
ENT.FxTracer 		= "_wraithgun_tracer" 
ENT.SndImpact 		= "scifi.wraithshot.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "10 30 255 255"
ENT.LightDistance	= 180
ENT.LightBrightness	= 1
ENT.LightDieTime	= 1
ENT.LightDecay		= 4096
ENT.LightFlareColor	= Color( 10, 60, 255 )
ENT.LightFlareAdd 	= true
ENT.LightFlareAlpha = 16
ENT.LightFlareSize  = 0.32
ENT.LightFlarePos 	= -32
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.wraithshot.flyby"
ENT.SoundRate 		= 0.1
ENT.SoundNext 		= 0.1
ENT.SoundDistance 	= 200

ENT.SciFi 			= true

function ENT:SubInit( ent, phys )

	ent:SetXPloding( false )

end

function ENT:HitFilter( ent )

	if ( CLIENT ) then return true end

	if !( ent || IsValid( ent ) ) then 
		return true 
	end
	
	if ( ent:GetClass() == "_wraithgun_beam" ) then
		return false
	end
	
	if ( ent == self || ent == self.Owner || ent:GetOwner() == self.Owner ) then 
		return true
	end

	return true

end

ENT.HomingEnabled = false
ENT.HomingTarget = NULL

function ENT:SubThink()

	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	if ( self.HomingEnabled && IsValid( self.HomingTarget ) ) then
		local tOrigin = self.HomingTarget:EyePos()
	
		local dir = ( tOrigin - eOrigin )
		local acc = dir:Length() * 0.01

		local phys = self:GetPhysicsObject()
		phys:ApplyForceOffset( ( dir * acc ), tOrigin )
	end

	local trData = {}
	local trResult = {}
	local trSize = Vector( 2, 2, 2 )

	trData.start 		= eOrigin - eOffset * 4
	trData.endpos 		= eOrigin + eOffset * 4
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
						end --{ self, self.Owner, "_*" }
	
	trData.mins 		= trSize * -1
	trData.maxs 		= trSize
	trData.mask 		= MASK_SHOT_HULL
	trData.ignoreworld 	= true
	trData.output 		= trResult

	util.TraceHull( trData )

	local lnData = {}
	local lnResult = {}

	lnData.start 		= eOrigin - eOffset * 64
	lnData.endpos 		= eOrigin + eOffset * 64
	lnData.filter 		= trData.filter
	lnData.mask 		= MASK_SHOT_HULL
	lnData.ignoreworld 	= true
	lnData.output 		= lnResult
	
	util.TraceLine( lnData )
	
	if ( SERVER ) && ( trResult.HitSky || lnResult.HitSky ) && ( !self:GetXPloding() ) then
		self:SetXPloding( true )
		self:Remove()
	end

	if ( SERVER ) && ( lnResult.Hit || trResult.Hit ) && ( !self:GetXPloding() ) then
		local data
		if ( trResult.Hit ) then
			data = trResults
			-- print( "Hit via hull-trace " .. tostring(data), trResult.Entity )
		else
			data = lnResult
			-- print( "Hit via line-trace " .. tostring(data), lnResult.Entity )
		end
		
		self:XPlode( data )
	end

end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	self:XPlode( pCollisionData )
		
end

function ENT:XPlode( pCollisionData )
	
	if ( !pCollisionData ) then return end
	if ( self:GetXPloding() ) then return end

	local target = pCollisionData.Entity || pCollisionData.HitEntity

	if ( target && target.SciFi ) then return end
	self:SetXPloding( true )

	local eOrigin = pCollisionData.HitPos - pCollisionData.HitNormal * 4
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	if ( IsValid( target ) ) then 
		local amp = GetConVar( "sfw_damageamp" ):GetFloat()

		local iDamage = 10 * amp

		local lnData = {}
		local lnResult = {}

		lnData.start 		= eOrigin - eOffset * 32
		lnData.endpos 		= eOrigin + eOffset * 32
		lnData.filter 		= {self}
--		lnData.mask 		= MASK_SHOT_HULL
		lnData.ignoreworld 	= true
		lnData.output 		= lnResult
		
		util.TraceLine( lnData )
		
--		debugoverlay.Line(lnResult.StartPos, lnResult.HitPos,4, Color(255,0,255,255),true)
		
		if ( pCollisionData.HitGroup == HITGROUP_HEAD ) || ( lnData.HitBoxBone == 6 ) then
			iDamage = iDamage * 2
		end
		
		local vForce = eOffset * iDamage * 2

		if ( SERVER ) then
			self:DealDirectDamage( DMG_SF_ENERGYSHOCKWAVE, iDamage, target, self.Owner, vForce )
		end
--[[
		if ( target:IsRagdoll() ) then
			vForce = vForce / 1
			if ( target:IsConstrained() ) then
				local entParent, entChild = target:GetConstrainedEntities()

				if ( IsValid( entParent ) ) then
					self:FakeKillRagdollPoses( entParent, -eOffset + pCollisionData.HitNormal, vForce )
				end
				
				if ( IsValid( entChild ) ) then
					self:FakeKillRagdollPoses( entChild, -eOffset + pCollisionData.HitNormal, vForce )
				end
				self:FakeKillRagdollPoses( target, eOffset + pCollisionData.HitNormal, vForce )
			else
				self:FakeKillRagdollPoses( target, eOffset + pCollisionData.HitNormal, vForce )
			end
		end
]]--
	end
	
	if ( SERVER ) then
		ParticleEffect( "_wraithgun_hit", eOrigin, eAngles )
		util.ScreenShake( eOrigin, 4, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	end

end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
end