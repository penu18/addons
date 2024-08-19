AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true
ENT.Category		= "Darken217's Scifi Items"
ENT.PrintName 		= "Trick or Treat"
ENT.Purpose			= "Releases a random item upon being destroyed. Maybe even a weapon..."

ENT.FxTracer 		= "item_pkin_amb"
ENT.FxRemove		= "item_pkin_break"
ENT.RShadows 		= true

ENT.RMdl 			= "models/props_outland/pumpkin01.mdl"
ENT.RMat			= "models/festive/pumpkin01.vmt"

ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxSSize		= nil --12
ENT.PhxSProp 		= "watermelon"
ENT.PhxMass 		= 4
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.LifeTime		= 0
ENT.OnWater			= PROJECTILE_RULE_IGNORE

ENT.LightEmit		= true
ENT.LightColor		= "255 80 20 255"
ENT.LightDistance	= 256
ENT.LightBrightness	= 0.8

ENT.DropTable		= {
	"item_battery",
	"item_healthkit",
	"item_healthvial",
	"sfi_supplies",
	"sfi_health",
	"sfi_shield",
	"sfi_upgrade",
	"sfi_flare_osm",
	"sfw_pandemic"
}

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * ( 10 )
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:SubInit()

	if ( SERVER ) then
	
	local ent = ents.Create( "prop_physics" )
	if (  !IsValid( ent ) ) then return end
	ent:SetModel( self.RMdl )
	ent:SetMaterial( self.RMat )
	ent:SetPos( self:GetPos() )
	ent:SetAngles( self:GetAngles() )
	ent:SetParent( self )
	ent:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	ent:Spawn()
	
	self:SetNWEntity( "pumpkin", ent )
	
	end

end

function ENT:PhysicsCollide( data, phys )

end

function ENT:OnTakeDamage( dmginfo )

	if ( self:GetXPloding() ) then return end
	
	self:XPlode( dmginfo:GetAttacker() )
	
	return true
	
end

function ENT:XPlode( attacker )

	if ( SERVER ) then
	
	self:SetXPloding( true )
	
	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( GetRelChance( 90 ) ) then
		local ent = ents.Create( self.DropTable[ math.random( 1, #self.DropTable ) ]  )
		if ( !IsValid( ent ) ) then return end	
		ent:SetPos( self:GetPos() + Vector( 0, 0, 8 ) )
		ent:Spawn()
		ent:Activate()
		if ( ent:IsWeapon() ) then
			ent:SetNWBool( "MobDrop", true )
		end
		
		ent:GetPhysicsObject():ApplyForceCenter( VectorRand() * math.random( 64, 128 ) )
				
		ParticleEffect( self.FxRemove, self:GetPos(), self:GetAngles() )
	else
		local ent = ents.Create( "sfw_frag_ent" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetPos() )
		ent:SetAngles( Angle( math.random( 10, 80 ), 40, 0 ) )
		ent:SetOwner( attacker )
		ent:Spawn()
		ent:Activate()
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( Vector( 0, 0, 32 ) + VectorRand() )
	end
	
	self:Remove()
	
	end
	
end