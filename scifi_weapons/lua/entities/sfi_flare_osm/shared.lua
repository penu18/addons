AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

--ENT.Spawnable 		= true
--ENT.AdminSpawnable 	= true
ENT.Category		= "Darken217's Scifi Items"
ENT.PrintName 		= "Flare"
ENT.Purpose			= "Summons an air strike"

ENT.RMdl 			= "models/props_junk/flare.mdl"
ENT.PhxSProp 		= "Metal"

ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxUseFlags 	= false
ENT.PhxSSize		= nil --0.01
ENT.PhxMass			= 25
ENT.PhxElastic		= -10000
ENT.FxTracer 		= "item_flare"
ENT.LifeTime		= 3
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "120 255 40 255"
ENT.LightSpotRadius	= 512
ENT.LightDistance	= 786
ENT.LightBrightness	= 1
ENT.LightStyle		= 1
ENT.LightFlareAlpha	= 16
ENT.LightFlareSize 	= 0.3
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

--	if ( SERVER ) && ( IsValid( self ) && self:GetIgnited() ) then
		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_BURN ), 2, self:GetPos(), 16 )
		
		if ( self:WaterLevel() == 3 ) then
			ParticleEffect( "ember_underwater_bubbles", self:GetPos(), Angle( 0, 0, 0 ), self )
		end
	--end
	
	if ( SERVER ) && ( self:GetIgnited() ) && ( self.DeathMoment > 0 && self.DeathMoment <= CurTime() ) then
		self:Remove()
	end

end

function ENT:PhysicsCollide( data, phys )
	
	self:EmitSound( "Grenade.ImpactHard" )
	
	data.PhysObject:SetVelocity( data.PhysObject:GetVelocity() * 0.2 )
		
	if ( self:GetIgnited() ) then
		ParticleEffect( "moby_hit", self:GetPos(), Angle( 0, 0, 0 ), self )
	end
	
end

function ENT:OnRemove()

	self:EmitSound( "BaseGrenade.StopSounds" )
	
	if ( SERVER ) then
		local pos = self:GetPos()
		local ang = self:GetAngles()
		local fw = ang:Forward()
		
		local tr = util.TraceLine( {
			start = pos + Vector( 0, 0, 8 ),
			endpos = pos + Vector( 0, 0, 32786 ),
			filter = {},
			mask = MASK_SHOT
		} )

		if ( tr.HitSky ) then
			local counter = 0
			repeat
				local ent = ents.Create( "sfw_frag_ent" )
				if ( !IsValid( ent ) ) then return end	
				ent:SetModel( "models/weapons/w_eq_decoy_thrown.mdl" )
				ent:SetPos( tr.HitPos + Vector( math.random( -512, 512 ), math.random( -512, 512 ), -512 ) )
				ent:SetOwner( self.Owner )
				ent:Spawn()
				ent:Activate()
				ent.NextTick = CurTime() + 10
				ent.LauncherMode = true
				ent.OnDamaged = PROJECTILE_RULE_IGNORE

				local phys = ent:GetPhysicsObject()
				if (  !IsValid( phys ) ) then ent:Remove() return end
				phys:ApplyForceCenter( ( Vector( 0, 0, -512 ) + fw * ( counter * 32 ) + Vector( math.random( -4, 4 ), math.random( -4, 4 ), -16 * counter ) ) * 32 )
				counter = counter + 1
			until ( counter == 5 )
		end
	end

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