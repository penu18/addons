AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true
ENT.Category		= "Darken217's Scifi Items"
ENT.Purpose			= "A loyal turret."
ENT.ThinkDelay		= 0

ENT.HealthAmount	= 100

ENT.PrintName 		= "Sentinel Turret"
--ENT.Phx 			= SOLID_VPHYSICS
--ENT.PhxMType 		= MOVETYPE_VPHYSICS
ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxSSize		= 12
ENT.PhxSProp 		= "default_silent"
ENT.PhxMass 		= 50
ENT.PhxGrav			= false
ENT.PhxDrag			= true
ENT.PhxDragAmount 	= 16384
ENT.PhxElastic	 	= 0
ENT.PhxBuoyancy 	= 0
ENT.LifeTime		= -1
ENT.FxTracer 		= "spectra_core_small"
ENT.SndImpact 		= "scifi.stinger.explode"

ENT.OnWater 		= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE

ENT.LightEmit		= true
ENT.LightColor		= "140 200 255 255"
ENT.LightSpotRadius	= 160
ENT.LightDistance	= 320
ENT.LightBrightness	= 1
ENT.LightStyle		= 1
--ENT.AttackNext		= 0
ENT.AttackDelay		= 0.11

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * ( self.PhxSSize + 4 )
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetOwner( ply )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:SubInit( ent, phys )

	if ( SERVER ) then 
		ent:SetMaxHealth( self.HealthAmount )
		ent:SetHealth( self.HealthAmount )
		
		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
			ParticleEffectAttach( "flare_halo_0", 1, ent, 1 )
			ParticleEffectAttach( "_ghost_upgrade", 1, ent, 1 )
		end

		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:SetDragCoefficient( 16 )
		
		self.AttackNext = 0
		self.Ammo = 960
	end
	
end

function ENT:SetPriorityTarget( target )

	if ( !target:IsNPC() && !target:IsPlayer() ) then return end
	if ( target ~= NULL && target:IsNPC() && self.Owner ~= NULL && target:Disposition( self.Owner ) == D_LI ) then return end

	if ( IsValid( target ) ) and ( target ~= self.Owner ) then
		self:SetNWEntity( "TargetEnt", target )
	else
		self:SetNWEntity( "TargetEnt", NULL )
	end

end

function ENT:GetPriorityTarget()

	local target = self:GetNWEntity( "TargetEnt" )

	if ( IsValid( target ) ) then
		return target
	else
		return NULL
	end

end

function ENT:SubThink()
	
	if ( SERVER ) then
	
		local tars = ents.FindInSphere( self:GetPos(), 1024 )
	
		if ( self:GetPriorityTarget() == NULL ) or ( !table.HasValue( tars, self:GetPriorityTarget() ) ) then
			for k,v in pairs( tars ) do
				if ( v ~= self.Owner && IsVisibleToEntity( v, self ) ) then
					self:SetPriorityTarget( v )
				end
			end
		else
			if ( self.AttackNext <= CurTime() ) then
				self:Attack()
				self.AttackNext = CurTime() + self.AttackDelay
			end
		end
		
		if ( self.Ammo <= 0 || self:Health() <= 0 ) then
			self:XPlode()
		end
	
	self:SetNWInt( "sent_ammo", self.Ammo )
		
	end
	
end

function ENT:Attack()

	local target = self:GetPriorityTarget()
	local aimvec = ( ( self:GetPriorityTarget():EyePos() ) - self:GetPos() ) --:GetNormalized() -- * -1
	
	if ( target:EyePos() ~= nil ) then
	aimvec = ( ( target:EyePos() ) - self:GetPos() )
	end
	
	self:SetAngles( aimvec:Angle() )
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self:GetPos()
	bullet.Dir = aimvec - Vector( 0, 0, 1 )
	bullet.Spread = Vector( 40, 40, 0 )
	bullet.Tracer = 1
	bullet.Force = 1
	bullet.HullSize = 16
	bullet.Damage = 4 * GetConVarNumber( "sfw_damageamp" )
	bullet.TracerName = "spectra_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetAttacker( self:GetValidOwner() )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamageType( bit.bor( DMG_SLASH, DMG_CLUB ) )
		
		ParticleEffect( "_wrath_hit_sparks", tr.HitPos, Angle( 0, 0, 0 ), self )
	end
	
	self:FireBullets( bullet, false )

	self.Ammo = self.Ammo - 1
	
	ParticleEffect( "sentinel_muzzle", self:GetPos(), self:GetAngles(), self )	
--	ParticleEffectAttach( "spectra_muzzle", 4, self, 0 )
	self:EmitSound( "scifi.spectra.fire1" )

end

function ENT:Use( activator, caller )

end

function ENT:OnTakeDamage( dmginfo )

	self:SetPriorityTarget( dmginfo:GetAttacker() )
	self:SetHealth( self:Health() - dmginfo:GetDamage() )
	
end

function ENT:XPlode()

	if ( self:GetXPloding() ) or ( self:Health() > 0 && self.Ammo > 0 ) then return end

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then
	
	self:SetXPloding( true )

	self:DealAoeDamage( 1, 64 * amp, self:GetPos(), 128 )

	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx2 ) ) then return end
	fx2:SetKeyValue( "_light", self.LightColor )
	fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius * 1.5 )
	fx2:SetKeyValue( "distance", self.LightDistance * 1.5 )
	fx2:SetKeyValue( "brightness", 2 )
	fx2:SetPos( self:GetPos() )
	fx2:SetAngles( self:GetAngles() )
	fx2:Spawn()
	fx2:Fire( "kill", "", 0.115 )

	ParticleEffect( "spectra_explode", fx2:GetPos(), self:GetAngles() )

	util.ScreenShake( fx2:GetPos(), 2, 4, 0.25, 256 )
	self:EmitSound( self.SndImpact )
	
	self:Remove()
	
	end
	
end