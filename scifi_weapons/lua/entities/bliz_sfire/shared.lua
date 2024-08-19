AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Aurora Blast"
ENT.RMdl 			= "models/dav0r/hoverball.mdl"
ENT.RMat 			= "vgui/white" 
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxMType 		= MOVETYPE_VPHYSICS
ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxSSize		= 2
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "snowcore_small"
ENT.SndImpact 		= "scifi.stinger.explode"
ENT.LifeTime		= 50
ENT.OnWater			= "SFP_XPLODE"
ENT.OnDamaged		= "SFP_IGNORE"
ENT.LightEmit		= true
ENT.LightColor		= "110 190 255 255"
ENT.LightSpotRadius	= 120
ENT.LightDistance	= 256
ENT.LightBrightness	= 0.8

function ENT:XPlode()

	if ( SERVER ) then

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	self:DealAoeDamage( DMG_RADIATION, 75 * amp, self:GetPos(), 140 )
	self:EmitSound( self.SndImpact )
	--self:DoFreezeRagdolls( self:GetPos(), 140 )
	self:CreateIceProps()
	
	if ( GetConVarNumber( "sfw_allow_propcreation" ) == 1 ) then
	
		for k, v in pairs( ents.FindInSphere( self:GetPos(), 128 ) ) do
			
			local ice_0 = ents.Create( "prop_physics" )
			ice_0:SetModel( "models/props_wasteland/rockgranite03a.mdl" )
			ice_0:SetMaterial( "models/elemental/frozen_alpha" )
			ice_0:SetPos( v:GetPos() + VectorRand() * 5 )
			ice_0:SetAngles( AngleRand() )
			ice_0:Spawn()
			
			timer.Simple( 2, function()
				if ( ice_0 == "Null" ) or ( ice_0 == nil ) then return end
				ParticleEffectAttach( "ice_freezing_release_large", 1, ice_0, 1 )
				ice_0:Fire( "kill", "", 0.05 )
			end )
			
			if ( v:IsNPC() ) then
			self:DoFreezeTarget( v )
			end
		
		end
	
	end
	
	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx2 ) ) then return end
	fx2:SetKeyValue( "_light", "110 172 255 255" )
	fx2:SetKeyValue( "spotlight_radius", 280 )
	fx2:SetKeyValue( "distance", 512 )
	fx2:SetKeyValue( "brightness", 2 )
	fx2:SetPos( self:GetPos() )
	fx2:SetParent( self )
	fx2:Spawn()
	fx2:Fire( "kill", "", 0.115 )

	ParticleEffect( "ice_xplode", self:GetPos(), Angle( 0, 0, 0 ) )
	
	self:KillSilent()
	
	end
	
end

function ENT:CreateIceProps()

	if ( self:WaterLevel() >= 2 ) and ( GetConVarNumber( "sfw_allow_propcreation" ) == 1 ) then
		
		local ice_1 = ents.Create( "prop_physics" )
		ice_1:SetModel( "models/props_wasteland/rockgranite02b.mdl" )
		ice_1:SetMaterial( "models/elemental/frozen_alpha" )
		ice_1:SetPos( self:GetPos() + VectorRand() * 5 )
		ice_1:SetAngles( AngleRand() )
		ice_1:Spawn()
		
		local ice_1_phys = ice_1:GetPhysicsObject()
		ice_1_phys:ApplyForceCenter( self:GetPos() + VectorRand() * 50 )
		ice_1_phys:SetMass( 5 )
		ice_1_phys:SetMaterial( "gmod_ice" )
		
		local ice_2 = ents.Create( "prop_physics" )
		ice_2:SetModel( "models/props_junk/rock001a.mdl" )
		ice_2:SetMaterial( "models/elemental/frozen_alpha" )
		ice_2:SetPos( self:GetPos() + VectorRand() * 5 )
		ice_2:SetAngles( AngleRand() )
		ice_2:Spawn()
		
		local ice_2_phys = ice_2:GetPhysicsObject()
		ice_2_phys:ApplyForceCenter( self:GetPos() + VectorRand() * 50 )
		ice_2_phys:SetMass( 5 )
		ice_2_phys:SetMaterial( "gmod_ice" )
		
		local ice_3 = ents.Create( "prop_physics" )
		ice_3:SetModel( "models/props_junk/rock001a.mdl" )
		ice_3:SetMaterial( "models/elemental/frozen_alpha" )
		ice_3:SetPos( self:GetPos() + VectorRand() * 5 )
		ice_3:SetAngles( AngleRand() )
		ice_3:Spawn()
		
		local ice_3_phys = ice_3:GetPhysicsObject()
		ice_3_phys:ApplyForceCenter( self:GetPos() + VectorRand() * 50 )
		ice_3_phys:SetMass( 5 )
		ice_3_phys:SetMaterial( "gmod_ice" )
		
		ice_1:SetPhysicsAttacker( self:GetValidOwner(), 5 )
		ice_2:SetPhysicsAttacker( self:GetValidOwner(), 5 )
		ice_3:SetPhysicsAttacker( self:GetValidOwner(), 5 )
		
		SafeRemoveEntityDelayed( ice_1, 10 )
		SafeRemoveEntityDelayed( ice_2, 10 )
		SafeRemoveEntityDelayed( ice_3, 10 )
		
	end

end

function ENT:DoFreezeTarget( target )

	if ( SERVER ) then
	
	if ( target:Health() < 1 ) then return end
	
	if ( target:IsNPC() ) then
		if ( target:IsCurrentSchedule( SCHED_NPC_FREEZE ) == true ) or ( target:GetMaxHealth() > 250 ) or ( target:GetNWBool( "bliz_frozen" ) == true ) then return end
		target:SetSchedule( SCHED_NPC_FREEZE )
		target:SetNWBool( "bliz_frozen", true )
	else
		target:AddFlags( FL_FROZEN )
		target:SetNWBool( "bliz_frozen", true )
	end
	
	ParticleEffectAttach( "ice_freezing_shortlt", 1, target, 1 )
	target:EmitSound( "scifi.bliz.freeze" )
	
	timer.Create( "FakeFrozenThink"..target:EntIndex(), 0, 1024, function()
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
				self:DealAoeDamage( DMG_GENERIC, 5, target:GetPos(), 40 )
				--self:DoFreezeRagdolls( target:GetPos(), 10 )
			end
			self:DoFreezeRagdolls( target:GetPos(), 10 )
		end
	end )
	
	timer.Simple( 3, function()
		timer.Remove( "FakeFrozenThink"..target:EntIndex() )
	end )
	
	timer.Simple( 3, function()
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

function ENT:DoFreezeRagdolls( pos, range )

	for k, v in pairs ( ents.FindInSphere( pos, range ) ) do
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
			v:GetPhysicsObject():AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
		end
		
		if ( v:GetClass() == "prop_physics" or v:GetClass() == "prop_dynamic" or v:GetClass() == "player" ) then
			if ( GetConVarNumber( "sfw_particles" ) == 1 ) then
				ParticleEffectAttach( "ice_freezing_shortlt", 1, v, 1 )
			end
		end
	end

end
