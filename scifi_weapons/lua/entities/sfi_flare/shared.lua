AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

--ENT.Spawnable 		= true
--ENT.AdminSpawnable 	= true
ENT.Category		= "Darken217's Scifi Items"
ENT.PrintName 		= "Flare"
ENT.Purpose			= "Emits light for 20 secs."

ENT.RMdl 			= "models/props_junk/flare.mdl"
ENT.RMat 			= "models/props_junk/flare" 
ENT.PhxSProp 		= "Weapon"

ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxUseFlags 	= false
ENT.PhxSSize		= nil --0.01
ENT.PhxMass			= 25
ENT.PhxElastic		= -10000
ENT.FxTracer 		= "item_flare"
ENT.FxAttachType 	= PATTACH_POINT_FOLLOW
ENT.FXAttachId		= 1
ENT.LifeTime		= 20
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightOrigin 	= 1
ENT.LightColor		= "140 255 40 255"
ENT.LightSpotRadius	= 256
ENT.LightDistance	= 786
ENT.LightBrightness	= 1
ENT.LightStyle		= 1
ENT.LightDieTime 	= 2
ENT.LightFlareAlpha	= 6
ENT.LightFlareSize 	= 0.2
ENT.LightFlareAdd 	= true
ENT.DeathMoment 	= 0

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "MTarLocked" )
	self:NetworkVar( "Bool", 1, "XPloding" )
	self:NetworkVar( "Bool", 2, "Ignited" )

end

function ENT:SubInit( ent, phy )

	ent:EmitSound( "Weapon_FlareGun.Burn" )

end

function ENT:SubThink()

	if ( SERVER ) && ( IsValid( self ) && self:GetIgnited() ) then
		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_BURN ), 2, self:GetPos(), 16 )
		
		if ( self:WaterLevel() == 3 ) then
			ParticleEffect( "ember_underwater_bubbles", self:GetPos(), Angle( 0, 0, 0 ), self )
		end
	end
	
	if ( SERVER ) && ( self:GetIgnited() ) && ( self.DeathMoment > 0 && self.DeathMoment <= CurTime() ) then
		self:Remove()
	end

end

function ENT:PhysicsCollide( data, phys )
	
	self:EmitSound( "Grenade.ImpactHard" )
	
	if ( self:GetIgnited() ) then
		ParticleEffect( "moby_hit", self:GetPos(), Angle( 0, 0, 0 ), self )
	end
	
end

function ENT:OnRemove()

	self:EmitSound( "BaseGrenade.StopSounds" )
	
end

--[[
function ENT:OnIgnited()

	if( !self:GetIgnited() ) then return end
	
	if ( SERVER ) then
		ParticleEffectAttach( "item_flare", 1, self, 1 )
		self.DeathMoment = CurTime() + 20
		self:EmitSound( "Weapon_FlareGun.Burn" )
	end
	
end

function ENT:Use( act, cal )

	if ( !IsValid( cal ) || !cal:IsPlayer() ) then return end 

	if ( !self:GetIgnited() ) then
		self:SetIgnited( true )
		self:OnIgnited()
	end

end
]]--