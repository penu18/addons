AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Trace Projectile"
ENT.PhxSSize		= 1
ENT.PhxMass 		= 4
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.PhxElastic		= 4294967296
ENT.FxTracer 		= "trace_projectile"
ENT.LifeTime		= 3
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.OnImpact 		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "255 80 180 255"
ENT.LightSpotRadius	= 210
ENT.LightDistance	= 340
ENT.LightBrightness	= 2
ENT.BounceSound 	= Sound( "FX_RicochetSound.Ricochet" )

function ENT:SubInit( ent )
	
	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 						-- parent
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
	
	if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
		ParticleEffect( "trace_sparks_new", self:GetPos(), Angle( 1, 2, 3 ), self.Owner )
	end
	
	self:EmitSound( self.BounceSound ) -- , 60, math.random( 90, 110 ), 1 )
	
end

function ENT:XPlode()


end