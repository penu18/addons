AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_pfx = GetConVar( "sfw_fx_particles" )
local cmd_sprites = GetConVar( "sfw_fx_sprites" )
local cmd_damageamp = GetConVar( "sfw_damageamp" )

ENT.NewHitMechanic 	= false
ENT.ProjectileImpactLogic = bit.bor( PROJECTILE_IMPACT_PHYSICS, PROJECTILE_IMPACT_TRACECAST )
ENT.ProjectileImpactTraceLength = 16
--ENT.LagCompensated 	= true
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PrintName 		= "Draco Bolt"
--ENT.PhxCGroup 		= COLLISION_GROUP_DEBRIS
ENT.PhxMType 		= bit.bor( MOVETYPE_FLY, MOVETYPE_CUSTOM )
ENT.PhxSSize		= 0.1
ENT.PhxMaxVelocity 	= 12000
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracerNew 	= true
ENT.FxTracer 		= "gravrifle_nade" 
ENT.SndImpact 		= "scifi.wraithshot.hit"
ENT.LifeTime		= 4
ENT.KillSilentDelay = 0
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= Color( 128, 60, 255, 255 )
ENT.LightDistance	= 128
ENT.LightBrightness	= 1
ENT.LightDieTime	= 1
ENT.LightDecay		= 1024
ENT.LightFlareMat 	= Material( "bloom/halo_static_2.vmt" )
ENT.LightFlareColor	= Color( 150, 100, 255, 255 )
ENT.LightFlareAdd 	= true
ENT.LightFlareAlpha = 180
ENT.LightFlareSize  = 0.7
ENT.LightFlarePos 	= 0
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.wraithshot.flyby"
ENT.SciFi 			= true

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "MTarLocked" ) 		-- Meteor targeting. Is a target locked?
	self:NetworkVar( "Bool", 1, "XPloding" ) 		-- Is the XPlode() function running or was it triggered?
	self:NetworkVar( "Entity", 0, "MTarEntity" ) 	-- If static meteor targeting is enabled, the target entity will not change, once locked.
	self:NetworkVar( "Entity", 0, "Inflictor" )

end

function ENT:SubInit( ent, phys )

	ent:SetXPloding( false )
	ent:NextThink( CurTime() )
	
	phys:AddGameFlag( FVPHYSICS_WAS_THROWN )
	phys:AddGameFlag( FVPHYSICS_DMG_SLICE )

	if ( SERVER ) then
		if ( cmd_sprites:GetBool() ) then
			util.SpriteTrail( 
				self, 								-- parent
				1, 									-- attachment ID
				Color( 255, 60, 80, 255 ), 				-- Color
				1, 									-- force additive rendering
				6, 									-- start width
				0, 									-- end width
				0.08,								-- lifetime
				16,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
	end
	
	if ( !IsValid( self:GetInflictor() ) ) then
		self:SetInflictor( self )
	end
	
end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 2
	end
	
	if ( hgroup == HITGROUP_CHEST ) then
		mul = 1.5
	end
	
	return mul

end

function ENT:XPlode( trResult )

	if ( self:GetXPloding() ) then return end

	self:SetXPloding( true ) 
	
	if ( SERVER ) then
	
		self:GetPhysicsObject():EnableMotion( false )

		local entInflictor = self:GetInflictor()
		
		local vOrigin = trResult.HitPos
		local amp = cmd_damageamp:GetFloat()
			
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self:GetPos()
		bullet.Dir = self:GetAngles():Forward()
		bullet.Spread = Vector( 0, 0 )
		bullet.Tracer = 0
		bullet.Force = 1 * amp
		bullet.HullSize = 1
		bullet.Damage = 24 * amp
		bullet.IgnoreEntity = self
		bullet.Callback = function( attacker, tr, dmginfo )
			if !( IsValid( self.Owner ) && IsValid( entInflictor ) ) then return end
			
			dmginfo:SetAttacker( self.Owner )
			dmginfo:SetDamageType( bit.bor( DMG_CLUB, DMG_BULLET, DMG_NEVERGIB ) )

			if ( IsValid( tr.Entity ) && !tr.HitWorld ) then
				if ( !entInflictor.LastTargetName ) then
					entInflictor.LastTargetName = tr.Entity
				end
				
				if ( tr.Entity == entInflictor.LastTargetName ) && ( entInflictor:GetPerkTime() >= CurTime() ) then
					entInflictor:SetPerkDamage( entInflictor:GetPerkDamage() + 1 )
				else
					entInflictor:SetPerkDamage( 0 )
					entInflictor.LastTargetName = tr.Entity
				end
				
				entInflictor:SetPerkTime( CurTime() + 1 )
					
				local myeml = {}
				if ( entInflictor:GetPerkDamage() < 3 ) then
					myeml.Element = EML_DISSOLVE_GRAVRIFLE
				
					tr.Entity.m_bGravrifleChainingOverride = true
					tr.Entity.m_nGravrifleTime = CurTime()
				else
					myeml.Element = EML_GRAVRIFLE_BLAST
					
					entInflictor:SetPerkDamage( 0 )
					entInflictor:SetPerkTime( 0 )
					
					tr.Entity.m_bGravrifleChainingOverride = false
				end
				myeml.Target = tr.Entity
				myeml.Attacker = self.Owner
				myeml.Inflictor = entInflictor
				myeml.Origin = tr.HitPos
				
				DoElementalEffect( myeml )
				
				-- tr.Entity.m_nGravrifleDamage = 60
				
				if ( tr.Entity.GetMaxHealth ) then
					-- tr.Entity.m_nGravrifleFuseTime = ( 0.25 + tr.Entity:GetMaxHealth() * 0.005 )
					tr.Entity.m_nGravrifleFuseTime = ( 0.5 + tr.Entity:GetMaxHealth() * 0.004 )
				else
					tr.Entity.m_nGravrifleFuseTime = 0.8
				end
			else
				entInflictor.LastTargetName = nil
				entInflictor:SetPerkDamage( 0 )
				entInflictor:SetPerkTime( 0 )
			end
			
			entInflictor:DealAoeDamage( bit.bor( DMG_SHOCK, DMG_RADIATION, DMG_NEVERGIB ), bullet.Damage * 0.5, tr.HitPos, 64, 64 )
		end
		
		entInflictor:FireBullets( bullet, false )
	
		ParticleEffect( "gravrifle_hit", vOrigin, self:GetAngles() )
		util.ScreenShake( vOrigin, 2, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	end
	
end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
	util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
    return true
	
end