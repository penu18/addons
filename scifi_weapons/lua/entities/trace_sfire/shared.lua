AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Charged Trace Projectile"
ENT.PhxSSize		= 1
ENT.PhxMass 		= 4
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "trace_projectile_pws"
ENT.LifeTime		= 3
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.OnImpact 		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "255 80 180 255"
ENT.LightSpotRadius	= 170
ENT.LightDistance	= 217
ENT.LightBrightness	= 2
ENT.BounceSound 	= Sound( "FX_RicochetSound.Ricochet" )
ENT.trace_curchilds = 0
ENT.trace_maxchilds = 6

function ENT:SubInit( ent )
	
	self.trace_curchilds = 0
	
	ParticleEffectAttach( "trace_trace", 1, self, 1 )	
	
	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 							-- parent
				0, 									-- attachment ID
				Color( 255, 80, 180, 255 ), 		-- Color
				1, 									-- force additive rendering
				24, 								-- start width
				0, 									-- end width
				0.2,								-- lifetime
				32,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
	end
	
end

function ENT:RecoBullet( amp )

	local ent = ents.Create( "trace_pfire" )
	if ( !IsValid( ent ) ) then return end
	ent:SetPos( self:GetPos() )
	ent:SetOwner( self.Owner )
	ent:Spawn()
	ent:Activate()
	
	--ent:EmitSound( self.BounceSound, ent:GetPos(), 5, CHAN_ITEM )	
	ParticleEffectAttach( "trace_trace", 1, ent, 1 )

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	phys:ApplyForceCenter( self:GetPos() * 34000 )
	
--	SafeRemoveEntityDelayed( ent, 0.8 )
--	SafeRemoveEntityDelayed( fx, 0.8 )

end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	if ( pCollisionData.HitSky ) || ( self.OnImpact == PROJECTILE_RULE_KILLME ) then
		self:KillSilent()
		
		return
	end
	
	local amp = GetConVarNumber( "sfw_damageamp" )

	local phys = self:GetPhysicsObject()
	if (  !IsValid( phys ) ) then self:Remove() return end
	phys:ApplyForceCenter( phys:GetVelocity() * 34000 )
	
	self:DealAoeDamage( bit.bor( DMG_CRUSH, DMG_VEHICLE ), 70 * amp, self:GetPos(), 100 )
	
	if ( self.trace_curchilds < self.trace_maxchilds ) then
		self:RecoBullet( amp )
		self.trace_curchilds = self.trace_curchilds + 1
	end
	
	if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
		ParticleEffect( "trace_sparks_new", self:GetPos(), Angle( 1, 2, 3 ), self.Owner )
	end
	
	self:EmitSound( self.BounceSound ) --, self:GetPos(), 5, CHAN_ITEM )
	
end

function ENT:XPlode()


end