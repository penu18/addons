AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.ClThinkDelay = 0
ENT.SvThinkDelay = 0

ENT.PrintName 		= "Vapor Grenade"
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
--ENT.PhxSProp 		= "flesh"
ENT.PhxSSize 		= 2
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 4
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "_ghostorb" --"vapor_grenade"
ENT.FxImpact 		= "vapornade_explosion"
ENT.SndImpact 		= "scifi.vapor.nade.explo"
ENT.LifeTime		= 6
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightXplode		= 4
ENT.LightColor		= "60 120 255 255" --"80 10 4 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 96
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= Material( "bloom/halo_static_2.vmt" )
ENT.LightFlareAdd 	= false
ENT.LightFlareColor = nil
ENT.LightFlareAlpha = 64
ENT.LightFlareSize  = 0.5
ENT.NextTick 		= 0

ENT.MeteorEnabled 			= false
ENT.MeteorAlwaysTrack 		= false
ENT.MeteorDetectionRange 	= 64
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInitial 	= 0
ENT.MeteorVelocityScale 	= 4
ENT.MeteorHomingFactor 		= 0.2
ENT.MeteorAlwaysTrack  		= true
ENT.MeteorSwayScale 		= 12
ENT.MeteorVelocityDecay 	= true
ENT.MeteorNeverForget 		= true
ENT.MeteorPreserveInitial 	= true

local snd_charge = Sound( "weapons/vapor/secfire_charge_new.wav" )

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "IsAttached" )
	self:NetworkVar( "Bool", 1, "XPloding" )
	self:NetworkVar( "Bool", 2, "MTarLocked" )
	self:NetworkVar( "Float", 0, "NextTick" )
	self:NetworkVar( "Entity", 0, "MTarEntity" )
	
end

function ENT:SubInit( ent )

	ParticleEffectAttach( "_glight", PATTACH_ABSORIGIN_FOLLOW, self, 0 )

	if ( SERVER ) then
		if ( GetConVar( "sfw_fx_sprites" ):GetBool() ) then
			util.SpriteTrail( 
				ent, 								-- parent
				1, 									-- attachment ID
				string.ToColor( self.LightColor ), 	-- Color
				1, 									-- force additive rendering
				4, 									-- start width
				0, 									-- end width
				0.2,								-- lifetime
				32,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
		
		ent:SetXPloding( false )
	end
	
	self:SetNextTick( 0 )
	
	self.ProjectileImpactLogic = PROJECTILE_IMPACT_PHYSICS

end

ENT.PlayedWarningSound = false

function ENT:SubThink()

	if ( CLIENT ) then
		if ( self:GetIsAttached() ) then
			local TimeToDie = 1 - ( self:GetNextTick() - CurTime() ) / 1.6
			TimeToDie = math.Clamp( TimeToDie, 0, 1 )
			
			self.LightFlareAdd = true
			self.LightFlareAlpha = 64 + 128 * TimeToDie * TimeToDie
			self.LightFlareSize  = 0.5 + 2 * TimeToDie * TimeToDie
			self.LightDistance	= 96 + 32 * TimeToDie * TimeToDie
		end
	end

	if ( SERVER ) then
		if ( self:GetIsAttached() ) then
			if ( self:GetNextTick() == 0 ) then
				self:SetNextTick( CurTime() + 1.6 )
			end

			if ( !self.PlayedWarningSound ) && ( self:GetNextTick() - CurTime() < 0.8 ) then
				self:EmitSound( snd_charge )
				self.PlayedWarningSound = true
			end
		end
		
		if ( self:GetNextTick() > 0 && CurTime() >= self:GetNextTick() ) then
			self:XPlode()
		end
	end

end

function ENT:Touch( otherEntity )
	
	if ( CLIENT ) || ( self:GetIsAttached() ) then return end

	self:SetAbsVelocity( Vector( 0, 0, 0 ) )
	
	local tr = self:GetTouchTrace()
	local hitPos = tr.HitPos
	
	if ( tr.HitSky ) then
		self:Remove() 
	end
		
	if ( tr.HitWorld ) then return end
	
	if ( tr.HitNonWorld ) then
		if ( !IsValid( tr.Entity ) ) then return end
		if ( !IsValid( tr.Entity:GetPhysicsObject() ) ) then return end
		if ( string.StartWith( tr.Entity:GetClass(), "func_" ) || string.StartWith( tr.Entity:GetClass(), "phys_" ) ) then self:Remove() end -- this is sooo cheesy...
		-- if ( tr.Entity:IsPlayer() ) then self:Remove() end
		
		if ( !self:GetIsAttached() ) && ( tr.Entity ~= self && tr.Entity:GetClass() ~= self:GetClass() ) then
			ParticleEffectAttach( "ngen_hit_sparks_2", 1, self, 1 )
--			self:EmitSound( "scifi.hornet.dart.charge" )
--			self:EmitSound( self.SoundHitEntity )
			--DevMsg( tr.Entity )
			--if ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) then
				self:SetParent( tr.Entity )
				self:DealDirectDamage( DMG_GENERIC, 2, self:GetParent(), self:GetValidOwner() )
			--else
			--	local weld = constraint.Weld( tr.Entity, self, tr.PhysicsBone, 0, 0, collision == 0, true )
			--end
			
			self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
			self:SetIsAttached( true )
			self.PhysGrav = true
		end
	end
	
	self:SetAbsVelocity( Vector( 0, 0, 0 ) )
	
end

function ENT:PhysicsCollide( data, phy )

	local surf = data.HitEntity

	if ( surf:IsWorld() ) then
		ParticleEffectAttach( "ngen_hit_sparks_2", 1, self, 1 )
--		self:EmitSound( "scifi.hornet.dart.charge" )
--		self:EmitSound( self.SoundHitWorld )
		self:GetPhysicsObject():EnableMotion( false )
		self:SetIsAttached( true )
	end
			
end

function ENT:OnTakeDamage( CTakeDamageInfo )
	
	self:XPlode()
	
	return true

end

function ENT:OnRemove()

	self:EmitSound( "common/Null.wav", SNDLVL_GUNFIRE, PTICH_NORM, 1, CHAN_ITEM ) 

	self:XPlode()

end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end

	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local pOwner = self:GetValidOwner()
	
	if ( SERVER ) then
		constraint.RemoveAll( self )
		
		if ( IsValid( self:GetParent() ) ) then
			local myeml = {}
			myeml.Element=EML_DISSOLVE_VAPOR
			myeml.Attacker=self:GetValidOwner()
			myeml.Range=24
			myeml.DslvMaxMass=500
			myeml.Origin=pos
			myeml.Target=self:GetParent()
			
			DoElementalEffect(myeml)
			
			local dmg = DamageInfo()
			dmg:SetDamageType( bit.bor( DMG_GENERIC, DMG_BLAST, DMG_RADIATION ) )
			dmg:SetAttacker( self:GetValidOwner() )
			dmg:SetInflictor( self )
			dmg:SetDamageForce( Vector( 0, 0, 1 ) )
			dmg:SetDamage( 120 * amp )
			
			self:GetParent():TakeDamageInfo( dmg )
		end
		
		self:DealAoeDamage( DMG_SF_ENERGY, 60 * amp, pos, 256 )

		ParticleEffect( "vpr_nade_blast", pos, Angle( 0, 0, 0 ), fxOwner )

		self:EmitSound( "scifi.vapor.explode" )
		
		util.ScreenShake( pos, 32, 512, 0.4, 620 )
		
		self:KillSilent()
	end

end

function ENT:ImpactTrace( tr, dmgtype )
	
    return true
	
end