AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_pfx = GetConVarNumber( "sfw_fx_particles" )
local cmd_sprites = GetConVarNumber( "sfw_sprites" )

ENT.NewHitMechanic 	= false
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PrintName 		= "wraithshot"
ENT.LifeTime		= 2.5
ENT.RMdl 			= "a/little/something/something.mdl"
ENT.PhxCGroup 		= COLLISION_GROUP_DEBRIS
ENT.PhxSSize		= 0.001
ENT.PhxMaxVelocity 	= 4800
ENT.PhxMass 		= 1
ENT.PhxGrav			= true
ENT.PhxDrag			= false
ENT.FxTracerNew 	= true
ENT.FxTracer 		= "_wraithgun_tracer" 
ENT.SndImpact 		= "scifi.wraithshot.hit"
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "20 40 255 255"
ENT.LightDistance	= 160
ENT.LightBrightness	= 1
ENT.LightDieTime	= 1
ENT.LightDecay		= 4096
ENT.LightFlareColor	= Color( 10, 80, 255 )
ENT.LightFlareAdd 	= true
ENT.LightFlareAlpha = 8
ENT.LightFlareSize  = 0.32
ENT.LightFlarePos 	= -16
ENT.SoundEmit		= false
ENT.SoundFile 		= "scifi.wraithshot.flyby"
ENT.SciFi 			= true

function ENT:SubInit( ent, phys )

	ent:SetXPloding( false )

end

local decaldrawn
function ENT:SubThink()

	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	local trData = {}
	local trResult = {}
	local trSize = Vector( 4, 2, 2 )

	trData.start 		= eOrigin - eOffset * 12
	trData.endpos 		= eOrigin + eOffset * 12
	trData.filter 		= { self, self.Owner }
	trData.mins 		= trSize * -1
	trData.maxs 		= trSize
	trData.mask 		= MASK_SHOT_HULL
	trData.ignoreworld 	= true
	trData.output 		= trResult

	util.TraceHull( trData )

	local lnData = {}
	local lnResult = {}

	lnData.start 		= eOrigin - eOffset * 32
	lnData.endpos 		= eOrigin + eOffset * 128
	lnData.filter 		= trData.filter
	lnData.mask 		= MASK_SHOT_HULL
	lnData.ignoreworld 	= false
	lnData.output 		= lnResult
	
	util.TraceLine( lnData )
	if ( CLIENT ) && ( lnResult.Hit ) && ( !decaldrawn ) then
		util.Decal( "fadingscorch", lnResult.HitPos, lnResult.HitPos + eOffset * 4, false )
	end
	
	if ( SERVER ) && ( trResult.HitSky || lnResult.HitSky ) && ( !self:GetXPloding() ) then
		self:SetXPloding( true )
		self:Remove()
	end

	if ( SERVER ) && ( lnResult.Hit || trResult.Hit ) && ( !self:GetXPloding() ) then
		local data
		if ( trResult.Hit ) then
			data = trResult
--			print( "Hit via hull-trace " .. tostring(data) )
		else
			data = lnResult
--			print( "Hit via line-trace " .. tostring(data) )
		end
		
		self:XPlode( data )
	end

end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	self:XPlode( pCollisionData )
		
end

function ENT:XPlode( pCollisionData )
	
	if ( self:GetXPloding() ) then return end

	local target = pCollisionData.Entity

	if ( target && target.SciFi ) then return end

	self:SetXPloding( true )

	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	if ( IsValid( target ) ) then 
		local amp = GetConVarNumber( "sfw_damageamp" )

		local iDamage = 10 * amp
		
		if ( pCollisionData.HitGroup == HITGROUP_HEAD ) then
			iDamage = iDamage * 2
		end
		
		local vForce = eOffset * iDamage * 2

		if ( SERVER ) then
			self:DealDirectDamage( bit.bor( DMG_BULLET,  DMG_BUCKSHOT ), iDamage, target, self.Owner, vForce )
		end
		
		if ( target:IsRagdoll() ) then
			if ( target:IsConstrained() ) then
				local entParent, entChild = target:GetConstrainedEntities()

				if ( IsValid( entParent ) ) then
					self:FakeKillRagdollPoses( entParent, -pCollisionData.Normal + pCollisionData.HitNormal, vForce )
				end
				
				if ( IsValid( entChild ) ) then
					self:FakeKillRagdollPoses( entChild, -pCollisionData.Normal + pCollisionData.HitNormal, vForce )
				end
				self:FakeKillRagdollPoses( target, pCollisionData.Normal + pCollisionData.HitNormal, vForce )
			else
				self:FakeKillRagdollPoses( target, pCollisionData.Normal + pCollisionData.HitNormal, vForce )
			end
		end
	end
	
	if ( SERVER ) then
	--	ParticleEffect( "_wraithgun_hit", eOrigin, eAngles )
		util.ScreenShake( eOrigin, 2, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	end

end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
end

function ENT:FakeKillRagdollPoses( tEntity, vForceDirection, vForceAmount )

	if ( !IsValid( tEntity ) ) then return end
	
	if ( !isvector( vForceDirection ) ) then 
		vForceDirection = Vector( 0, 0, 1 )
	end

	if ( !isnumber( vForceAmount ) ) then
		vForceAmount = 1000
	end

	local bones = tEntity:GetPhysicsObjectCount()
	
	if ( !isnumber( bones ) ) then print( "no bones" ) return end
	for  i=0, bones-1 do
		local grav = tEntity:GetPhysicsObjectNum( i )
		if ( IsValid( grav ) ) then
			grav:Wake()
			grav:EnableMotion( true )
			grav:ApplyForceOffset( vForceDirection, vForceDirection * -vForceAmount )
		end
	end
	
end