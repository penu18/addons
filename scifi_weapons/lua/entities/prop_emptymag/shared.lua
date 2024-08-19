AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= ""
ENT.Purpose			= "maybe we can pick some left-over rounds from this?"

ENT.FxTracer 		= nil
ENT.FxRemove		= nil
ENT.RShadows 		= true

ENT.RMdl 			= "models/Items/battery.mdl"
ENT.RMat			= "models/black"

ENT.Phx 			= SOLID_BBOX -- SOLID_VPHYSICS
ENT.PhxFlag 		= nil
ENT.PhxCGroup 		= COLLISION_GROUP_PASSABLE_DOOR
ENT.PhxSSize		= nil --12
ENT.PhxSProp 		= "weapon"
ENT.PhxMass 		= 5
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxDragAmount	= 1
ENT.PhxElastic		= 12000
ENT.PhxBuoyancy 	= 0
ENT.PhxMType 		= MOVETYPE_VPHYSICS
ENT.PhxUseFlags		= true
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnImpact 		= PROJECTILE_RULE_IGNORE

ENT.LightEmit		= false
ENT.CollisionSounds = true

function ENT:SubInit()

	if ( SERVER ) && !( IsValid( self.Owner ) && self.Owner:IsPlayer() ) then
		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	end
	
	self.NewHitMechanic = false
	
end

function ENT:PhysicsCollide( data, phys )

end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Draw()

	if ( !self.RMdl ) then return end
	
	local fLifeTime = self.DieTime - CurTime()
	
	if ( fLifeTime < 2 ) then
		local fFadeScale = fLifeTime / 2
		
		render.SetBlend( fFadeScale )
		self:DrawModel()
		render.SetBlend( 1 )
	else
		self:DrawModel()
	end
	
end

function ENT:PhysicsCollide( tCollisionData )

	if ( !self.CollisionSounds ) then return end

	local iSpeed = tCollisionData.Speed

	if ( tCollisionData.DeltaTime < 0.05 ) then return end
	if ( iSpeed < 50 ) then return end

	if ( iSpeed > 200 ) then
		self:EmitSound( "weapon.ImpactHard" )
	else
		self:EmitSound( "weapon.ImpactSoft" )
	end

end