AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_fx_particles = GetConVarNumber( "sfw_fx_particles" )

ENT.PrintName 		= "Jotunn Arrow"
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0	
ENT.RMdl 			= "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl"
ENT.RMat 			= "models/elemental/frozen_alpha"
ENT.RShadows 		= true
ENT.Phx				= SOLID_CUSTOM
ENT.PhxMaxVelocity 	= 12000
ENT.PhxSSize		= nil
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.PhxDragAmount 	= 4096
ENT.PhxMass 		= 2
ENT.FxTracer 		= nil --"" --"jotunn_trail"
ENT.SndImpact 		= "" --"scifi.hornet.dart.explode"
ENT.LifeTime		= 12
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.LightEmit 		= false
ENT.SoundEmit		= false
ENT.Ricochet 		= false

if ( IsMounted( "ep2" ) ) then
	ENT.SoundFile		= "NPC_Hunter.FlechetteNearmiss"
	ENT.SoundHitEntity 	= "NPC_Hunter.FlechetteHitBody"
	ENT.SoundHitWorld 	= "NPC_Hunter.FlechetteHitWorld"
else
	ENT.SoundFile		= "cat.dart.flyby"
	ENT.SoundHitEntity 	= ""
	ENT.SoundHitWorld 	= ""
end

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "IsAttached" )
	self:NetworkVar( "Bool", 1, "XPloding" )
	self:NetworkVar( "Bool", 2, "MTarLocked" )
	self:NetworkVar( "Int", 0, "charge" )
	
end

function ENT:SubInit( ent, phys )

	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 							-- parent
				0, 								-- attachment ID
				Color( 225, 220, 255, 200 ), 	-- Color
				false, 								-- force additive rendering
				4, 								-- start width
				0, 								-- end width
				0.2,							-- lifetime
				32,								-- texture resulution
				"particle/beam_smoke_02.vmt" 		-- texture
			)
		end

		ent:SetNoDraw( false )
		ent.Ricochet = false
		
		if ( !phys ) then
			phys = self:GetPhysicsObject()
		end

		phys:AddGameFlag( FVPHYSICS_DMG_SLICE )
		phys:AddGameFlag( FVPHYSICS_WAS_THROWN )
	end

end

function ENT:SubThink( pEntity )

	if ( SERVER ) && ( !self:GetIsAttached() ) then
		pEntity:EmitSound( self.SoundFile )
	end
	
	local entOrigin = pEntity:GetPos()
	
	local entAngles = pEntity:GetAngles()
	local fw = entAngles:Forward()
	
	local trData 		= {}
	local trResult 		= {}
	
	trData.start 		= entOrigin + fw * 64
	trData.endpos 		= entOrigin + fw * -64
	trData.filter 		= { pEntity }
	trData.mask			= MASK_ALL
	trData.ignoreworld 	= false
	trData.output  		= trResult
		
	util.TraceLine( trData )

--	debugoverlay.Line( trResult.StartPos, trResult.HitPos, 1, Color( 255, 255, 255, 255 ), true ) 
	
	if ( IsValid( trResult.Entity ) && trResult.Entity:IsRagdoll() ) then
		local tEntity = trResult.Entity
		local tPhysics = tEntity:GetPhysicsObject()
		
		self:CBoltWeld( tEntity, tPhysics )
	end

end

function ENT:CBoltWeld( tEntity, tPhys ) 

	if ( !tEntity:IsRagdoll() ) then return end
	if ( !IsValid( tEntity ) ) then return end
	if ( !IsValid( tPhys ) ) then return end
	if ( !self:GetIsAttached() ) then return end
					
	tEntity:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
					
	if ( IsValid( self ) ) then
		constraint.Weld( tEntity, self, 0, 0, 0, true, false )
	else
		constraint.Weld( tEntity, Entity(0), 0, 0, 0, true, false )
	end
					
	tPhys:SetMass( math.Clamp( tPhys:GetMass() / 4, 10, 50 ) )
	
--	print( "Is attached to " .. tostring( tEntity ) ) 

end

function ENT:Touch( EntOther )
	
	if ( CLIENT ) then return end

	local tr = self:GetTouchTrace()
	
	if ( tr.HitSky ) then
		self:KillSilent() 
	end
	
	if ( tr.HitWorld ) then return end
	
	if ( tr.HitNonWorld ) && ( IsValid( self.Owner ) ) then
		if ( !IsValid( tr.Entity ) ) then return end
		if ( !IsValid( tr.Entity:GetPhysicsObject() ) ) then return end
		
		local tClass = tr.Entity:GetClass()
		
		if ( string.StartWith( tClass, "func_" ) || string.StartWith( tClass, "phys_" ) ) then self:KillSilent() end -- this is sooo cheesy...
--		if ( tr.Entity:IsPlayer() || tr.Entity:IsNPC() ) then self:Remove() end
		
		if ( !self:GetIsAttached() ) && ( tr.Entity ~= self && tClass ~= self:GetClass() ) then
			
			if ( GetRelChance( 10 ) ) then
				DoElementalEffect( { Element = EML_ICE, Target = tr.Entity, Duration = 1, Attacker = self.Owner } )
				DoShatterRagdolls( tr.HitPos )
			end

			ParticleEffectAttach( "ice_impact", 1, self, 1 )
			
			self:EmitSound( self.SoundHitEntity )
			if ( tClass == "prop_ragdoll" || tClass == "prop_physics" ) then
				tr.Entity:SetAbsVelocity( self:GetAngles():Forward() * 12800 )
				tr.Entity:SetPhysicsAttacker( self.Owner, 10 )
				
				if ( tr.Entity:IsRagdoll() ) then
					self:CBoltWeld( tr.Entity, tr.Entity:GetPhysicsObject() ) 
				else
					self:CBoltWeld( EntOther, EntOther:GetPhysicsObject() )
				end
			end
			
			self:SetIsAttached( true )
			self.PhysGrav = true
		end
	end

end

function ENT:PhysicsCollide( data, phy )

	self:XPlode( data )

	local charge = self:GetNWInt( "charge" )
	
	local surf = data.HitEntity
	
	ParticleEffectAttach( "ice_impact", 1, self, 1 )
	self:EmitSound( self.SoundHitWorld )

	if ( !self:GetIsAttached() && charge >= 90 && data.HitNormal:Length() >= 0.8 ) then
		if ( !IsValid( data.HitObject ) ) then return end
		
		local bouncer = ( data.OurOldVelocity:GetNormalized() - data.HitNormal )
		bouncer = bouncer:Length()
		-- print( bouncer )
		if ( surf:IsNPC() || surf:IsPlayer() || surf:IsRagdoll() ) then
			data.HitObject:ApplyForceCenter( data.OurOldVelocity ) -- * 4096 )
			data.PhysObject:ApplyForceCenter( data.OurOldVelocity * 4096 )
		elseif ( bouncer > 1 ) then
			data.HitObject:ApplyForceCenter( data.OurOldVelocity - data.HitNormal )
			data.PhysObject:ApplyForceCenter( data.OurOldVelocity - data.HitNormal * ( 256 * charge ) )
		end
	end

	if ( surf:IsWorld() ) && ( self.Ricochet ) then
		self:GetPhysicsObject():EnableMotion( false )
	--	self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
		self:SetIsAttached( true )
	else
		self.Ricochet = true
		data.PhysObject:EnableGravity( true )
		data.PhysObject:EnableDrag( true )
	end
			
end

function ENT:OnTakeDamage( dmginfo )

	return false
	
end

function ENT:OnRemove()

	self:EmitSound( "common/Null.wav", SNDLVL_GUNFIRE, PTICH_NORM, 1, CHAN_ITEM )

end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 1.25
	end
	
	if ( hgroup == HITGROUP_CHEST || hgroup	== HITGROUP_STOMACH ) then
		mul = 1.25
	end
	
	return mul

end

function ENT:XPlode( pCollisionData )

	local amp = GetConVarNumber( "sfw_damageamp" )

	if ( SERVER ) && ( !self:GetXPloding() ) then
	
		local pos = pCollisionData.HitPos -- self:GetPos()
		local ang = self:GetAngles()

		local charge = self:GetNWInt( "charge" )
		local dmg = ( 10 + charge * 0.4 ) * amp
		local dmgtype = bit.bor( DMG_SLASH, DMG_BUCKSHOT, DMG_NEVERGIB )
		
		self:SetXPloding( true )
		
		ParticleEffect( "ice_impact_heavy", pos, ang, self )
		self:EmitSound( "scifi.bliz.hit" )

		self:DealPointDamage( dmgtype, dmg, pos, 256, 2 * charge / 4, 8 )	
		self:DealPointDamage( dmgtype, dmg / 2, pos + ang:Forward() * 4, 256, 2 * charge / 4, 8 )
	end

end