AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "effects/blueflare1" )

ENT.PrintName 		= "cryon grenade"
ENT.RMdl 			= "models/items/combine_rifle_ammo01.mdl"
ENT.RMat 			= "/models/weapons/misc/cryo_nade.vmt"
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSProp 		= "weapon"
ENT.PhxSSize 		= nil
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 10
ENT.PhxElastic		= 3200
ENT.FxTracer 		= nil
ENT.SndImpact 		= "scifi.cryo.explode"
ENT.LifeTime		= 6
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.OnImpact 		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "60 50 80 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 32
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = Color( 255, 255, 255 )
ENT.LightFlareAlpha	= 160
ENT.LightFlareSize 	= 0.16
ENT.NextTick 		= 0
ENT.LauncherMode 	= false

function ENT:SubInit( ent )
	
	if ( SERVER ) then
		self.NextTick = CurTime() + 2
		
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
			ent, 
			1, 
			Color( 60, 50, 80, 220 ),
			1, 
			4, 
			0, 
			0.2,
			512,
			"effects/beam_nocolor.vmt" )
		end
	end
	
end

function ENT:SubThink()
	
	if ( SERVER ) then
		if( self.NextTick <= CurTime() ) && ( !self:GetXPloding() ) then
			self:XPlode()
		end
	end
	
end

function ENT:PhysicsCollide( data, phys )
	
	if ( data.Speed > 72 ) then 
		self:EmitSound( "Weapon.ImpactSoft" )
	end
	
	if ( IsValid( data.Entity ) ) && ( !data.Entity:IsWorld() ) then
		data.PhysObject:SetVelocity( data.PhysObject:GetVelocity() * 0.4 )
	end
	
	if ( self.LauncherMode ) && ( !self:GetXPloding() ) then
		self:XPlode()
	end
	
end

function ENT:XPlodeProps()

	local vOrigin = self:GetPos()

	local ice_1 = ents.Create( "prop_physics" )
	if (  !IsValid( ice_1 ) ) then return end
	ice_1:SetModel( "models/props_mining/caverocks_cluster01.mdl" )
	ice_1:SetMaterial( "models/elemental/frozen_alpha" )
	ice_1:SetPos( vOrigin + VectorRand() * 5 )
	ice_1:SetAngles( AngleRand() )
	ice_1:Spawn()
	
	local ice_1_phys = ice_1:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ice_1:Remove() return end
	ice_1_phys:ApplyForceCenter( vOrigin + VectorRand() * 50 )
	ice_1_phys:SetMass( 1 )
	ice_1_phys:SetMaterial( "item" )
	
	local ice_2 = ents.Create( "prop_physics" )
	if (  !IsValid( ice_2 ) ) then return end
	ice_2:SetModel( "models/props_junk/rock001a.mdl" )
	ice_2:SetMaterial( "models/elemental/frozen_alpha" )
	ice_2:SetPos( vOrigin + VectorRand() * 5 )
	ice_2:SetAngles( AngleRand() )
	ice_2:Spawn()
	
	local ice_2_phys = ice_2:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ice_2:Remove() return end
	ice_2_phys:ApplyForceCenter( vOrigin + VectorRand() * 50 )
	ice_2_phys:SetMass( 1 )
	ice_2_phys:SetMaterial( "item" )
	
	local ice_3 = ents.Create( "prop_physics" )
	if (  !IsValid( ice_3 ) ) then return end
	ice_3:SetModel( "models/props_junk/rock001a.mdl" )
	ice_3:SetMaterial( "models/elemental/frozen_alpha" )
	ice_3:SetPos( vOrigin + VectorRand() * 5 )
	ice_3:SetAngles( AngleRand() )
	ice_3:Spawn()
	
	local ice_3_phys = ice_3:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ice_3:Remove() return end
	ice_3_phys:ApplyForceCenter( vOrigin + VectorRand() * 50 )
	ice_3_phys:SetMass( 1 )
	ice_3_phys:SetMaterial( "item" )
	
	SafeRemoveEntityDelayed( ice_1, 10 )
	SafeRemoveEntityDelayed( ice_2, 10 )
	SafeRemoveEntityDelayed( ice_3, 10 )
		
end

function ENT:XPlodeFreezeRagdolls( v )

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
		
		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
			ParticleEffectAttach( "ice_freezing", 1, v, 1 )
		end

	end
	
	v:EmitSound( "scifi.cryo.freeze" )
	v:SetMaterial( "models/elemental/frozen.vmt" )
	if ( IsValid( v:GetPhysicsObject() ) ) then
		v:GetPhysicsObject():AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
	end
				
end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then
		local vOrigin = self:GetPos()
		local pMaster = self:GetValidOwner()
		
		local tars = ents.FindInSphere( vOrigin, 300 )
			
		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_PREVENT_PHYSICS_FORCE ), 50 * amp, vOrigin + Vector( 0, 0, 1 ), 280 )
		self:DealAoeDamage( DMG_RADIATION, 16 * amp, vOrigin, 320 )
		
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", "190 210 225 255" )
		fx:SetKeyValue( "spotlight_radius", 320 )
		fx:SetKeyValue( "distance", 640 )
		fx:SetKeyValue( "brightness", 5.5 )
		fx:SetPos( vOrigin )
		fx:Spawn()
		
		local pos, ang = fx:GetPos(), Angle( 0, 0, 0 )
		
		ParticleEffect( "cryo_explosion_large", pos, ang, pMaster )
		ParticleEffect( "eml_generic_cryo", pos, ang, pMaster )
		
		local trData = { start = pos + Vector( 0, 0, 64 ), endpos = pos - Vector( 0, 0, 64 ), filter = self, ignoreworld = false }
		local tr = util.TraceEntity( trData, self )
		
		ParticleEffect( "eml_generic_cryo_ground", tr.HitPos, ang )
		--[[
		for k, v in pairs ( ents.FindInSphere( pos, 160 ) ) do
			if ( v:IsNPC() || v:IsPlayer() ) then
				DoElementalEffect( { Element = EML_ICE, Target = v, Duration = 3, Attacker = pMaster } )
			end
			
			if ( v:GetClass() == "prop_physics" || v:GetClass() == "prop_dynamic" ) then
				if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
					ParticleEffectAttach( "ice_freezing_shortlt", 1, v, 1 )
				end
			end
		end
]]--
		fx:EmitSound( self.SndImpact )
		util.ScreenShake( fx:GetPos(), 32, 512, 0.4, 620 )
		
		local bCheckForLos = true
		if ( IsValid( self:GetParent() ) ) then
			bCheckForLos = false
		end
		
		for k, v in pairs ( tars ) do
			local vTargetOrigin = v:EyePos() || v:GetPos()
			
			if ( bCheckForLos ) then
				local vis = self:VisibleVec( vTargetOrigin )
				if ( !vis ) then
					continue
				end
			end
			
			if ( v:IsNPC() || v:IsPlayer() ) then
				DoElementalEffect( { Element = EML_ICE, Target = v, Duration = 4, Damage = 200, Attacker = pMaster } )
			end
			
			if ( v:GetClass() == "prop_physics" || v:GetClass() == "prop_dynamic" ) then
				if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
					ParticleEffectAttach( "ice_freezing_shortlt", PATTACH_ABSORIGIN_FOLLOW, v, 1 )
				end
			end
			
			if ( v:IsRagdoll() && v:GetPos():Distance( vOrigin ) < 150 ) && ( v:GetNWBool( "IsStatue" ) == false ) then
				-- self:XPlodeFreezeRagdolls( v )
				DoFreezeRagdolls( v:GetPos() )
			end
		end

		if ( self:WaterLevel() > 1 ) && ( GetConVar( "sfw_allow_propcreation" ):GetBool() ) then
			self:XPlodeProps()
		end
		
		self:Remove()
		SafeRemoveEntityDelayed( fx, 0.16 )
	end
	
end