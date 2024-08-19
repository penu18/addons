AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_pfx = GetConVarNumber( "sfw_fx_particles" )
local cmd_sprites = GetConVarNumber( "sfw_sprites" )

--ENT.Type 			= "point"
-- ENT.NewHitMechanic 	= PROJECTILE_IMPACT_PHYSICS
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PrintName 		= "storm projectile"
ENT.LifeTime		= 3
ENT.PhxCGroup 		= COLLISION_GROUP_PROJECTILE
ENT.PhxSSize		= 0.001
ENT.PhxMaxVelocity 	= 4800
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracerNew 	= true
ENT.FxTracer 		= "_wraithgun_tracer" 
ENT.SndImpact 		= "scifi.wraithshot.hit"
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "10 40 255 255"
ENT.LightDistance	= 180
ENT.LightBrightness	= 1
ENT.LightDieTime	= 1
ENT.LightDecay		= 4096
ENT.LightFlareColor	= Color( 10, 60, 255 )
ENT.LightFlareAdd 	= true
ENT.LightFlareAlpha = 12
ENT.LightFlareSize  = 0.32
ENT.LightFlarePos 	= -32
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.wraithshot.flyby"

ENT.SciFi 			= true

function ENT:SubInit( ent, phys )

	ent:SetXPloding( false )
	
	self.BaseDamage = self.BaseDamage || 10

end

local panicents = {
	storm_pfire = true
}

function ENT:HitFilter( ent )

	if ( CLIENT ) then return true end

	if !( ent || IsValid( ent ) ) then 
		return true 
	end
	
	if ( panicents[ ent:GetClass() ] ) then
		return false
	end
	
	if ( ent == self || ent == self.Owner || ent:GetOwner() == self.Owner ) then 
		return true
	end

	return true

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
							
							if ( ent.SciFi ) then -- ent:GetClass() == self.ClassName ) then
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

	local eOrigin = pCollisionData.HitPos -- self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	if ( IsValid( target ) ) then 
		local amp = GetConVarNumber( "sfw_damageamp" )

--		local fLifeFraction = ( self.DieTime - CurTime() ) / self.LifeTime -- Could be used to create damage falloff over projectile lifetime, but seriously, how needs that...?
--		print( fLifeFraction )
		local iDamage = self.BaseDamage * amp -- * fLifeFraction
		
		if ( pCollisionData.HitGroup == HITGROUP_HEAD ) then
			iDamage = iDamage * 1.5
		end

		if ( pCollisionData.HitGroup == HITGROUP_CHEST || pCollisionData.HitGroup == HITGROUP_STOMACHE ) then
			iDamage = iDamage * 1.25
		end
		
		local vForce = ( eOffset - pCollisionData.HitNormal ) * iDamage

		if ( SERVER ) then
			self:DealDirectDamage( DMG_SF_ENERGYSHOCKWAVE, iDamage, target, self.Owner, vForce, true )
		end
	end
	
	if ( SERVER ) then
		ParticleEffect( "_wraithgun_hit", eOrigin, eAngles )
		util.ScreenShake( eOrigin, 6, 2, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	end

end