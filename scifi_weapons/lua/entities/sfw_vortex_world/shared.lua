AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0

ENT.PrintName 		= "Vortex"
ENT.PhxCGroup 		= COLLISION_GROUP_IN_VEHICLE
ENT.PhxSSize		= 64
ENT.PhxMass 		= 3200
ENT.PhxGrav			= false
ENT.PhxDrag			= true
ENT.PhxDragAmount  	= 16382
ENT.PhxElastic	 	= 0
ENT.LifeTime		= 3
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnImpact 		= PROJECTILE_RULE_IGNORE

if ( GetConVarNumber( "sfw_fx_particles" ) >= 1 ) then
	ENT.FxTracer 	= "zeala_vortex"
else
	ENT.FxTracer 	= "zeala_vortex_cheap"
end

ENT.LightEmit		= true
ENT.LightColor		= "129 135 255 255"
ENT.LightSpotRadius	= 1024
ENT.LightDistance	= 1024
ENT.LightBrightness	= 2
ENT.LightStyle 		= 1
ENT.LightRealistic 	= true
ENT.LightFlareMat 	= Material( "sprites/light_ignorez" )
ENT.LightFlareColor = Color( 107, 111, 182, 255 )
ENT.LightFlareAlpha	= 128
ENT.LightFlareAdd 	= true
ENT.LightFlareSize 	= 1
ENT.LightXplode 	= 8

ENT.VortexRange 	= 384
ENT.VortexPower 	= 0.03 -- 0.3 -- 0.14
ENT.VortexAutoKill  = true

local cmd_sk_autokill = GetConVarNumber( "sfw_sk_vortex_autokillthreshold" )

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * ( self.PhxSSize + 4 )
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	return ent
	
end

function ENT:VortexDrag( target )

	if ( !IsValid( self ) ) then 
		DevMsg( "!Error; Invalid source\n" )
		return 
	end
	
	if ( !IsValid( target ) && !target:IsWorld() ) then 
		DevMsg( "!Error; Invalid target ("..tostring(target)..")\n" )
		return 
	end
	
	if ( target == self ) then return end
	
	local own_pos = self:GetPos()
	local tar_pos = target:GetPos()
	local t_class = target:GetClass()
	
	local dist = tar_pos:Distance( own_pos )
	local dir = ( tar_pos - own_pos ) * -1
	local acc = math.max( self.VortexRange * 1.05 - dir:Length(), 0 ) * self.VortexPower
	acc = math.Round( acc )
	acc = acc * acc
	
	local fDamageScale = 1 - dir:Length() / self.VortexRange
	local fDamageAmp = GetConVar( "sfw_damageamp" ):GetFloat()

	if ( CLIENT ) then
		local phys = target:GetPhysicsObject()
		
		if ( IsValid ( target ) && IsValid( phys ) ) then
			local velo = ( dir * acc )
			if ( target:IsRagdoll() ) then
				velo = ( dir * acc ) * ( 1.1 + mass )
			else
				velo = ( dir * acc ) * mass
			end
			
			phys:ApplyForceOffset( velo, tar_pos )
		end
	end
	
	if ( SERVER ) then
		if ( !self:Visible( target ) ) then return end

		local dmgType
		if ( dist < self.VortexRange * 0.24 ) then
			dmgType = DMG_GENERIC
		else
			dmgType = bit.bor( DMG_DIRECT, DMG_NEVERGIB, DMG_PREVENT_PHYSICS_FORCE )
		end

		--self:DealDirectDamage( dmgType, 8 * fDamageScale * fDamageAmp, target )
		
		local phys = target:GetPhysicsObject()

		if ( target:IsNPC() ) then
			local t_health_max = target:GetMaxHealth()
			
			if ( IsValid( phys ) ) then
				local velo = ( dir * acc )
				phys:ApplyForceOffset( velo, tar_pos )
				target:SetVelocity( dir * acc * 0.01 )
			else
				if ( t_health_max < 250 ) then
					target:SetPos( tar_pos + dir * 0.02 )
				end
			end

			if ( t_health_max < 349 ) && ( t_class == "npc_strider" ) && ( dist <= ( self.VortexRange * 0.12 ) ) then
				target:Fire( "explode", "", 0 )
			end

			if ( t_health_max > 99 ) && ( t_class == "npc_combinegunship" ) && ( dist <= ( self.VortexRange * 0.5 ) ) then
				self:DealDirectDamage( DMG_BLAST, 100 * fDamageScale * fDamageAmp, target )
			end
			
			if ( t_health_max > 599 ) && ( t_class == "npc_helicopter" ) && ( dist <= ( self.VortexRange * 0.48 ) ) then
				self:DealDirectDamage( DMG_AIRBOAT, 40 * fDamageScale * fDamageAmp, target )
			end
			
			return 
		end
		
		if ( !IsValid( phys ) ) then 
		--	DevMsg( "!Error; Invalid physics object @ "..tostring(target).."\n" ) 
			return 
		end
		phys:EnableMotion(true)
		local mass = math.abs( phys:GetMass() / 50 )
		
		if ( t_class == "sfw_vortex_world" ) then
			DevMsg( "!Error; Vortex conflict" )
			return 
		end
		
		if ( IsValid ( target ) ) then
			if ( target:IsPlayer() ) then
				local velo = ( dir * acc ) * 0.012
				target:SetVelocity( velo )
			else
				local velo = ( dir * acc )
				if ( target:IsRagdoll() ) then
					velo = ( dir * acc ) * ( 1.1 + mass )
				else
					velo = ( dir * acc ) --* mass
				end
				phys:ApplyForceOffset( velo, tar_pos )
			end
		end

		if ( t_class == "prop_physics" ) && ( dist <= 128 ) then
			target:TakeDamage( 10 * fDamageScale * fDamageAmp )
		end
		
		if ( self.VortexAutoKill ) then
			if ( IsValid( phys ) && phys:IsPenetrating()  ) && ( dist <= 64 ) then
			--	DevMsg( "!Error; interpenetrating physics objects... Removing!" )
				self:VortexDissolve( target, phys )
			end
			
			if ( IsValid( target ) ) && ( t_class == "prop_physics" || target:IsRagdoll() ) && ( dist <= 48 ) then
				target:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
			end
			
			if ( IsValid( target ) ) && ( t_class == "prop_physics" || target:IsRagdoll() ) && ( dist <= 24 ) then
				self:VortexDissolve( target, phys )
			end
		end
	end
	
end

local perfcount = 0

function ENT:VortexDissolve( tEntity, tPhys )

	local IsVaporizing = tEntity:GetNWBool( "IsVaporizing" )

	if ( IsVaporizing ) then return end
	
	tEntity:SetNWBool( "IsVaporizing", true )
	
	local tOrigin = tEntity:GetPos()
	tEntity:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	
	if ( IsValid( tPhys ) ) then
		tPhys:EnableGravity( false )
	end
	
	if ( perfcount < cmd_sk_autokill ) then
		ParticleEffectAttach( "celest_dissolve", 1, tEntity, 1 )
		
		local ed = EffectData()
		ed:SetOrigin( tOrigin )
		ed:SetEntity( tEntity )
		util.Effect( "celest_dissolve", ed, true, true )
	end
	
	tEntity:Fire( "kill", "", 0.8 )
	
	perfcount = perfcount + 1

end

function ENT:SubInit( ent )

	if ( SERVER || !game.SinglePlayer() ) then
		self:EmitSound( "scifi.zeala.vortex" )
	end

end

function ENT:SubThink( ent )

	local src = self:GetPos()
	local range = self.VortexRange
	
	if ( SERVER ) then
		local pcn = 0
	
		for k,v in pairs ( ents.FindInSphere( src, range ) ) do
			self:VortexDrag( v )
			
			local t_class = v:GetClass()
			
			if ( t_class == "prop_physics" || v:IsRagdoll() ) then
				if ( pcn >= cmd_sk_autokill ) then
					v:SetCollisionGroup( COLLISION_GROUP_DEBRIS ) 
				end
				
				if ( v:IsOnFire() ) then 
					v:Extinguish()
				end
				
				pcn = pcn + 1
			end
		end
		
		local amp = GetConVarNumber( "sfw_damageamp" )
		local dmgtype = bit.bor( DMG_DIRECT, DMG_NEVERGIB, DMG_PREVENT_PHYSICS_FORCE )
		local dmgrange_1 = range * 0.56
		local dmgrange_2 = range * 0.24
		local att = self:GetValidOwner()
		
		self:DealAoeDamage( dmgtype, 1 * amp, src, dmgrange_1, att, 0 )
		self:DealAoeDamage( DMG_GENERIC, 32 * amp, src, dmgrange_2, att, 0 )
		
		debugoverlay.Sphere( src, range, 0, Color( 120, 130, 255, 20 ), false )
		util.ScreenShake( src, 16, 8, 0.1, 512 )
	end
	
end

function ENT:PhysicsCollide( data, phys )

end

function ENT:OnRemove()

	if ( SERVER ) then
		self:EmitSound( "scifi.zeala.burst.intro" )
		self:EmitSound( "scifi.zeala.burst" )
	
		local pos = self:GetPos()
		local ang = self:GetAngles()

		ParticleEffect( "zeala_burst", pos, ang )

		local fx1 = EffectData()
		fx1:SetOrigin( pos )
		fx1:SetAngles( Angle( 0, 0, 0 ) )
		fx1:SetRadius( 100 )
		fx1:SetScale( 0.2 )
		fx1:SetNormal( Vector( 0.01, 0.02, 0.5 ) )
		util.Effect( "scifi_aftershock", fx1 )
		
		local fx2 = ents.Create( "light_dynamic" )
		if ( !IsValid( fx2 ) ) then return end
		fx2:SetKeyValue( "_light", "210 190 255 255" )
		fx2:SetKeyValue( "spotlight_radius", self.VortexRange )
		fx2:SetKeyValue( "distance", self.VortexRange * 2 )
		fx2:SetKeyValue( "brightness", 3 )
		fx2:SetPos( pos )
		fx2:Spawn()
		fx2:Fire( "kill", "", 0.115 )
			
		local amp = GetConVarNumber( "sfw_damageamp" )
		local att = self:GetValidOwner()
		
		self:DealAoeDamage( bit.bor( DMG_CLUB, DMG_SLASH ), 10 * amp, pos, self.VortexRange * 2, att, 12000000 )
		util.ScreenShake( pos, 2048, 8, 1, self.VortexRange * 4 )
		
		-- for k, v in pairs( player.GetAll() ) do
			-- local vPlayerOrigin = v:GetPos()
			-- local iDist = vPlayerOrigin:Distance( pos )
			-- if ( iDist > self.VortexRange * 3 ) then continue end
			
			-- local vNormal = vPlayerOrigin - pos
			-- vNormal:Normalize()
			
			-- local vPunch = vNormal - v:GetAimVector()
			-- vPunch:Normalize()
			-- print( vPunch )
			-- v:ViewPunch( vPunch:Angle() * 0.01 * iDist / self.VortexRange * 3 )
		-- end
	end
	
end