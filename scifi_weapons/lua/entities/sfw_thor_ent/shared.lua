AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "some random shock grenade"
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSSize 		= 2
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 4
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "tbolt_core"
ENT.FxImpact 		= "eml_generic_shock"
ENT.SndImpact 		= "ReallyLoudSpark"
ENT.LifeTime		= 6
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightXplode		= 2
ENT.LightColor		= "110 160 255 255" --"80 10 4 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 300
ENT.LightBrightness	= 2
ENT.LightStyle 		= 1
ENT.LightFlareMat 	= Material( "sprites/light_ignorez" )
ENT.LightFlareColor = nil
ENT.LightFlareAlpha	= 255
ENT.LightFlareSize 	= 0.6
ENT.AttackNext		= 0
ENT.AttackDelay		= 0.1
ENT.TargetEntity 	= NULL
ENT.NextTick 		= 0

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "IsAttached" )
	self:NetworkVar( "Bool", 1, "XPloding" )
	self:NetworkVar( "Bool", 2, "MTarLocked" )
	
end

function ENT:SubInit()

end

function ENT:SetPriorityTarget( target )

	if ( !target:IsNPC() && !target:IsPlayer() ) then return end
	if ( target ~= NULL && target:IsNPC() && self.Owner ~= NULL && target:Disposition( self.Owner ) == D_LI ) then return end

	if ( IsValid( target ) ) and ( target ~= self.Owner ) then
		self.TargetEntity = target
	else
		self.TargetEntity = target
	end

end

function ENT:GetPriorityTarget()

	local target = self.TargetEntity

	if ( IsValid( target ) ) then
		return target
	else
		return false
	end

end

function ENT:Attack()

	if ( game.SinglePlayer() && CLIENT ) then return end

	local pos = self.Entity:GetPos()
	local ang = self.Entity:GetAngles()
	local target = self.Entity:GetPriorityTarget()
	local pOwner = self.Entity:GetValidOwner()
	
	if ( !IsValid( target ) ) then return end
	
	local aimvec = ( ( self.Entity:GetPriorityTarget():EyePos() ) - pos )
	
	if ( aimvec:Length() > 200 ) then return end
	
	local avAng = aimvec:Angle()
	
--	self.Entity:SetAngles( avAng )
		
	ParticleEffectAttach( "tbolt_hit", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
	
	local bullet = {}
	bullet.Num = 2
	bullet.Distance = 200
	bullet.Src = pos + Vector( 0, 0, 2 )
	bullet.Dir = aimvec - Vector( 0, 0, 2 )
	bullet.Spread = Vector( 0, 0 )
	bullet.Tracer = 1
	bullet.Force = 1
	bullet.HullSize = 16
	bullet.Damage = 1 * GetConVarNumber( "sfw_damageamp" )
	bullet.TracerName = "nrg_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetAttacker( pOwner )
		dmginfo:SetDamageType( DMG_ENERGYBEAM )
		
		if ( math.random( 0, 100 ) > 90 ) then
			DoElementalEffect( { Element = EML_SHOCK, Target = tr.Entity, Attacker = pOwner } )
		end
	end
	
	self.Entity:FireBullets( bullet, false )

end

function ENT:SubThink()

	if ( CLIENT ) then
		local rng = math.random( 0.2, 0.8 )
		local sine = math.sin( CurTime() ) + 2
		
		self.LightBrightness = 1 * sine * rng
		self.LightFlareAlpha = 128 * sine * rng
	end
	
	if ( self:GetXPloding() ) then return end
	
	local tars = ents.FindInSphere( self.Entity:GetPos(), 512 )
	
	if ( !self:GetPriorityTarget() && SERVER ) then
		for k,v in pairs( tars ) do
			if ( v ~= self.Owner && IsVisibleToEntity( v, self.Entity ) ) then
				self.Entity:SetPriorityTarget( v )
			end
		end
	else
		if ( self.AttackNext <= CurTime() ) then
			self:Attack()
			self.AttackNext = CurTime() + self.AttackDelay
		end
	end
	
	if ( SERVER ) then
		if ( self:GetIsAttached() ) && ( self.NextTick == 0 ) then
			self.NextTick = CurTime() + 4
		end
		
		if ( self.NextTick > 0 && CurTime() >= self.NextTick ) then
			self:XPlode()
		end
	end
	
end

function ENT:Touch( otherEntity )
	
	if ( CLIENT ) || ( self:GetIsAttached() ) then return end

	self.Entity:SetAbsVelocity( Vector( 0, 0, 0 ) )
	
	local tr = self:GetTouchTrace()
	local hitPos = tr.HitPos
	
	if ( tr.HitSky ) then
		self.Entity:Remove() 
	end
		
	if ( tr.HitWorld ) then return end
	
	if ( tr.HitNonWorld ) then
		if ( !IsValid( tr.Entity ) ) then return end
		if ( !IsValid( tr.Entity:GetPhysicsObject() ) ) then return end
		if ( string.StartWith( tr.Entity:GetClass(), "func_" ) || string.StartWith( tr.Entity:GetClass(), "phys_" ) ) then self.Entity:Remove() end -- this is sooo cheesy...
		if ( tr.Entity:IsPlayer() ) then self.Entity:Remove() end
		
		if ( !self:GetIsAttached() ) && ( tr.Entity ~= self.Entity && tr.Entity:GetClass() ~= self.Entity:GetClass() ) then
			self.Entity:SetParent( tr.Entity )
			
			self.Entity:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
			
			self:SetIsAttached( true )
			self.DeathMoment = CurTime() + 4
			self.PhysGrav = false
		end
	end
	
	self.Entity:SetAbsVelocity( Vector( 0, 0, 0 ) )

end

function ENT:PhysicsCollide( data, phy )

	local surf = data.HitEntity

	if ( surf:IsWorld() ) then
		ParticleEffectAttach( "tbolt_hit", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
--		self:EmitSound( self.SoundHitWorld )
		self:GetPhysicsObject():EnableMotion( false )
		self:SetIsAttached( true )
		self.DeathMoment = CurTime() + 4
	end
			
end

function ENT:OnRemove()

	self.Entity:EmitSound( "common/Null.wav", SNDLVL_GUNFIRE, PTICH_NORM, 1, CHAN_ITEM ) 

	if ( !self:GetXPloding() )then
		self.Entity:XPlode()
	end

end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end

	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	local pos = self.Entity:GetPos()
	local ang = self.Entity:GetAngles()
	local pOwner = self.Entity:GetValidOwner()
	
	if ( SERVER ) then
		self.Entity:DealAoeDamage( DMG_SHOCK, 16 * amp, pos, 128 )

		ParticleEffect( self.FxImpact, pos, ang, pOwner )
		
		self.Entity:EmitSound( self.SndImpact )

		util.ScreenShake(pos, 32, 512, 0.4, 620 )
		
		self.Entity:KillSilent()
		
		ParticleEffectAttach( "tbolt_hit", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
	end

end

function ENT:ImpactTrace( tr, dmgtype )
	
	if ( tr.HitSky ) then return end
	if ( SERVER ) then return end
	
	ParticleEffect( "tbolt_hit", tr.HitPos, tr.Normal:Angle(), self )
	sound.Play( "LoudSpark", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
	
	if ( tr.MatType == MAT_GLASS ) then 
		return true 
	end
	
	local dlight = DynamicLight( -1 ) 
	if ( dlight ) then
		dlight.pos = tr.HitPos 
		dlight.r = 100
		dlight.g = 130
		dlight.b = 255
		dlight.brightness = 2
		dlight.Decay = 2048
		dlight.Size = 512
		dlight.DieTime = CurTime() + 0.5
	end
	
	return true
	
end