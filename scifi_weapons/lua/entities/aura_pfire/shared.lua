AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Aurora projectile"
ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "cry_tracer" 
ENT.SndImpact 		= "Glass.Strain"
ENT.LifeTime		= 10
ENT.OnWater			= "SFP_REMOVE"
ENT.OnDamaged		= "SFP_IGNORE"
ENT.LightEmit		= true
ENT.LightColor		= "210 220 255 255"
ENT.LightSpotRadius	= 300
ENT.LightDistance	= 400
ENT.LightBrightness	= 1
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.hwave.flyby"

function ENT:SubInit()

end

function ENT:SubThink()

	if ( SERVER ) and ( self.Owner ~= NULL ) then
		
		local phys = self:GetPhysicsObject()
		if ( !IsValid( phys ) ) then return end
		if ( self.Owner:IsPlayer() ) then
			self:SetAngles( self.Owner:EyeAngles() )
			phys:ApplyForceCenter( self.Owner:GetAimVector() * 1000 + self:GetAngles():Forward() * 3400 )
		end
		
	end

end

function ENT:PhysicsCollide( data, phys )
	
	self:XPlode()

end

function ENT:XPlode()

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	local dmg_1 = 14
	local dmg_2 = 4
	
	local tr = {}
	
	util.TraceLine( {
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetAngles():Forward() * 64,
		filter = function( ent ) if ( ent:IsNPC() ) or ( ent:IsPlayer() ) then return true end end,
		ignoreworld = true,
		output = tr
	} )

	if ( tr.HitGroup == HITGROUP_HEAD ) then
		dmg_1 = dmg_1 * 1.3
	end
	
	if ( tr.HitGroup == HITGROUP_CHEST ) or ( tr.HitGroup == HITGROUP_STOMACH ) then
		dmg_1 = dmg_1 * 1.2
	end
	
	if ( SERVER ) then

		self:DealAoeDamage( bit.bor( DMG_RADIATION, DMG_GENERIC ), dmg_2 * amp, self:GetPos(), 64 ) 											-- Three different damage sources actually make this weapon kind of unreliable.
		self:DealPointDamage( bit.bor( DMG_SLASH, DMG_CLUB ), dmg_1 * amp, self:GetPos(), 128 )												-- They also have a measurable but not too heavy negative effect on performance ... ... ...
		self:DealPointDamage( bit.bor( DMG_SLASH, DMG_CLUB ), dmg_2 * amp, self:GetPos() + self:GetAngles():Forward() * 32, 256 )  	-- Fake punch-through mechanic

		for k, v in pairs ( ents.FindInSphere( self:GetPos(), 128 ) ) do
			if ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) and ( v:IsRagdoll() || v:GetClass() == "prop_physics" || v:IsNPC() || v:IsPlayer() ) then
				self:DoFreezeTarget( v )
				
				timer.Create( "freeze" .. self:EntIndex(), 0, 10, function() 
					self:DoFreezeRagdolls( v:GetPos() )
					timer.Remove( "freeze" .. self:EntIndex() )
				end )
			end
		end	
		
		local fx2 = ents.Create( "light_dynamic" )
		if ( !IsValid( fx2 ) ) then return end
		fx2:SetKeyValue( "_light", "70 110 255 255" )
		fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius * 1.2 )
		fx2:SetKeyValue( "distance", self.LightDistance * 1.2 )
		fx2:SetKeyValue( "brightness", 1 )
		fx2:SetPos( self:GetPos() )
		fx2:SetAngles( self:GetAngles() )
		fx2:Spawn()
		fx2:Fire( "kill", "", 0.115 )

		ParticleEffect( "ice_impact_heavy", fx2:GetPos(), self:GetAngles() )

		util.ScreenShake( fx2:GetPos(), 2, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	
	end
	
end

function ENT:ImpactTrace( tr, dmgtype )
	
	util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
    return true
	
end

function ENT:DoFreezeTarget( target )

	if ( SERVER ) then
	
	if ( target:IsNPC() ) then
		if ( target:IsCurrentSchedule( SCHED_NPC_FREEZE ) == true ) or ( target:GetMaxHealth() > 150 ) or ( target:GetNWBool( "bliz_frozen" ) == true ) then return end
		target:SetSchedule( SCHED_NPC_FREEZE )
		target:SetNWBool( "bliz_frozen", true )
	else
		target:AddFlags( FL_FROZEN )
		target:SetNWBool( "bliz_frozen", true )
	end
	
	ParticleEffectAttach( "ice_freezing_shortlt", 1, target, 1 )
	target:EmitSound( "scifi.bliz.freeze" )
	
	timer.Create( "FakeFrozenThink"..target:EntIndex(), 0, 8, function()
		if ( IsValid( target ) ) and ( target:Health() <= 1 ) and ( target:GetNWBool( "bliz_frozen" ) == true ) then
			target:SetNWBool( "bliz_frozen", false )
			if ( target:IsNPC() ) then
			target:SetSchedule( SCHED_WAKE_ANGRY )
			else
			target:RemoveFlags( FL_FROZEN )
			end
			ParticleEffectAttach( "ice_freezing_release", 1, target, 1 )
			target:EmitSound( "scifi.bliz.breakfree" )
			if ( IsValid( self ) ) and ( IsExistent( self ) ) and ( IsExistent( target ) ) then
				target:TakeDamage( 5, self.Owner, self.Owner:GetActiveWeapon() ) 
				--self:DoFreezeRagdolls( target:GetPos() )
			end
			self:DoFreezeRagdolls( target:GetPos() )
		end
	end )
	
	timer.Simple( 2, function()
		timer.Remove( "FakeFrozenThink"..target:EntIndex() )
	end )
	
	timer.Simple( 2, function()
		if ( IsValid( target) ) and ( SERVER ) then
			target:SetNWBool( "bliz_frozen", false )
			if ( target:IsNPC() ) then
			target:SetSchedule( SCHED_WAKE_ANGRY )
			else
			target:RemoveFlags( FL_FROZEN )
			end
			ParticleEffectAttach( "ice_freezing_release", 1, target, 1 )
			target:EmitSound( "scifi.bliz.breakfree" )
		end
	end )
	
	end
	
end

function ENT:DoFreezeRagdolls( pos )

	for k, v in pairs ( ents.FindInSphere( pos, 10 ) ) do
		if ( v:IsRagdoll() and v:GetNWBool( "IsStatue" ) == false ) then
			local bones = v:GetPhysicsObjectCount()
			v.StatueInfo = {}
			for bone = 1, bones-1 do
				local constraint = constraint.Weld( v, v, 0, bone, forcelimit )
				
				if ( constraint ) then
					v.StatueInfo[bone] = constraint
				end
				
				local effectdata = EffectData()
				effectdata:SetOrigin( v:GetPhysicsObjectNum( bone ):GetPos() )
				effectdata:SetScale( 1 )
				effectdata:SetMagnitude( 1 )
				util.Effect( "GlassImpact", effectdata, true, true )
				
				if ( GetConVarNumber( "sfw_particles" ) == 1 ) then
					ParticleEffectAttach( "ice_freezing", 1, v, 1 )
				end
				v:EmitSound( "scifi.cryo.freeze" )
			end
				
			v:SetMaterial( "models/elemental/frozen" )
			v:SetNWBool( "IsStatue", true )
			if ( v:GetPhysicsObject() ~= NULL ) then
				v:GetPhysicsObject():AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
			end
		end
		
		if ( v:GetClass() == "prop_physics" or v:GetClass() == "prop_dynamic" or v:GetClass() == "player" ) then
			if ( GetConVarNumber( "sfw_particles" ) == 1 ) then
				ParticleEffectAttach( "ice_freezing_shortlt", 1, v, 1 )
			end
		end
	end

end