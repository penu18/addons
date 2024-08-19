AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_fx_particles = GetConVarNumber( "sfw_fx_particles" )

ENT.PrintName 		= "Morga's Kunai"
ENT.RMdl 			= "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl"
ENT.RMat 			= "models/elemental/frozen_alpha"
ENT.RShadows 		= true
ENT.Phx				= SOLID_CUSTOM
ENT.PhxGrav 		= true
ENT.PhxSSize		= nil
ENT.PhxMass 		= 1
ENT.FxTracer 		= "hornet_trail_cheaper"
ENT.SndImpact 		= "scifi.hornet.dart.explode"
ENT.LifeTime		= 8
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnImpact 		= PROJECTILE_RULE_IGNORE
ENT.LightColor		= "140 150 255 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 64
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= Material( "bloom/halo_static_2.vmt" )
ENT.LightFlareColor	= Color( 120, 130, 255 )
ENT.LightFlareAlpha	= 8
ENT.LightFlareSize 	= 0.4
ENT.LightXplodeSun 	= true
ENT.SoundEmit		= false
ENT.ImpactDamage 	= 2
ENT.FuseTime 		= 1.8

ENT.m_bExplodingFlechette = true

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
	self:NetworkVar( "Int", 0, "Charge" )
	self:NetworkVar( "Int", 1, "DeathTime" )
	self:NetworkVar( "Entity", 0, "MTarEntity" ) 	-- If static meteor targeting is enabled, the target entity will not change, once locked.
	
end

function ENT:SubInit()

	self:SetNoDraw( false )
	self:SetCharge( 0 )
	-- self:SetDeathTime( 0 )

end

function ENT:SubThink()

	if ( CLIENT ) then
		if ( self:GetIsAttached() ) then
			local TimeToDie = 1 - ( self:GetDeathTime() - CurTime() ) / self.FuseTime
			TimeToDie = math.Clamp( TimeToDie, 0, 1 )

			self.LightFlareAlpha = 8 + 64 * TimeToDie * TimeToDie
			self.LightFlareSize  = 0.4 + 0.6 * TimeToDie * TimeToDie
			self.LightDistance	= 32 + 128 * TimeToDie * TimeToDie
		end
	end
	
	if ( SERVER ) && ( self:GetIsAttached() ) && ( self:GetDeathTime() > 0 && self:GetDeathTime() <= CurTime() ) then
		self:Remove()
	end

end

function ENT:Touch()

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
		-- if ( string.StartWith( tr.Entity:GetClass(), "func_" ) || string.StartWith( tr.Entity:GetClass(), "phys_" ) ) then self:Remove() end -- this is sooo cheesy...
		-- if ( tr.Entity:IsPlayer() ) then self:Remove() end
		
		if ( !self:GetIsAttached() ) && ( tr.Entity ~= self && tr.Entity:GetClass() ~= self:GetClass() ) then
			ParticleEffectAttach( "ngen_hit_sparks_2", 1, self, 1 )
			self:EmitSound( "scifi.hornet.dart.charge" )
			self:EmitSound( self.SoundHitEntity )
		
			self:SetParent( tr.Entity )
			self:DealDirectDamage( DMG_GENERIC, self.ImpactDamage, self:GetParent(), self:GetValidOwner() )
			
			self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
			self:SetIsAttached( true )
			self:SetDeathTime( CurTime() + self.FuseTime )
		end
	end
	
	self:SetAbsVelocity( Vector( 0, 0, 0 ) )
end

function ENT:PhysicsCollide( data, phy )

	local surf = data.HitEntity
	
	if ( surf:IsWorld() ) then
		-- if ( data.Speed < 20000 ) then
			ParticleEffectAttach( "ngen_hit_sparks_2", 1, self, 1 )
			self:EmitSound( "scifi.hornet.dart.charge" )
			self:EmitSound( self.SoundHitWorld )
			self:GetPhysicsObject():EnableMotion( false )
			self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
			self:SetIsAttached( true )
			self:SetDeathTime( CurTime() + self.FuseTime )
		-- else
			-- phy:SetVelocity( ( data.OurOldVelocity:GetNormalized() - data.HitNormal ) * data.Speed * 0.6 )
			-- debugoverlay.Cross( data.HitPos, 16, 4, color_white, true )
			-- debugoverlay.Line( data.HitPos, data.HitPos + ( data.OurOldVelocity:GetNormalized() - data.HitNormal ) * 64, 4, Color( 255, 0, 255, 255 ), true )
		-- end
	end
	
end

function ENT:OnTakeDamage( dmginfo )

	if ( dmginfo:GetInflictor().m_bExplodingFlechette ) then
		self:Remove()
	end
	
	return true
	
end

function ENT:OnRemove()

	self:EmitSound( "common/Null.wav", SNDLVL_GUNFIRE, PTICH_NORM, 1, CHAN_ITEM ) 
	self:XPlode()

end

function ENT:XPlode()

	if !( SERVER && !self:GetXPloding() ) then return end
	
	local entParent = self:GetParent()
	local tDarts = {}
	
	if ( IsValid( entParent ) ) then
		for k, v in pairs( entParent:GetChildren() ) do
			if ( !v.m_bExplodingFlechette ) then
				continue
			end
			
			tDarts[ #tDarts + 1 ] = v
		end

		for k, v in pairs( tDarts ) do
			v:SetCharge( math.max( v:GetCharge(), #tDarts ) )
			v:TakeDamage( 9999 )
		end
	end

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	local charge = self:GetCharge()
	
	self:SetXPloding( true )
	
	local vOrigin = self:GetPos()
	
	local dmgBase = 4 * amp
	
	if ( charge == 0 ) then
		self:DealDirectDamage( DMG_GENERIC, dmgBase, entParent, self:GetValidOwner() )
		self:DealAoeDamage( DMG_AIRBOAT, dmgBase * amp, vOrigin, 140 )
	else
		self:DealDirectDamage( DMG_GENERIC, dmgBase + charge * 0.75, entParent, self:GetValidOwner() )
		self:DealAoeDamage( DMG_AIRBOAT, dmgBase + charge * 0.25, vOrigin, 140 )
	end
	
	if ( cmd_fx_particles == 1 ) then
		if ( charge >= 1 ) then
			ParticleEffect( "hornet_blast_charged", vOrigin, Angle( 0, 0, 0 ) )
		else
			ParticleEffect( "hornet_blast", vOrigin, Angle( 0, 0, 0 ) )
		end
	else
		ParticleEffect( "hornet_blast_cheap", vOrigin, Angle( 0, 0, 0 ) )
	end

	self:EmitSound( self.SndImpact )

end