AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

ENT.PrintName 		= "Chroma Orb"
ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxSSize		= 12
ENT.PhxSProp 		= "default_silent"
ENT.PhxMass 		= 4
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxElastic	 	= 16384
ENT.PhxBuoyancy 	= 0.5
ENT.PhxUseFlags	 	= true
ENT.LifeTime		= 8
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.FxTracer 		= "item_orb_chroma"
ENT.FxRemove		= "item_orb_chroma_burst"

ENT.SndImpact 		= "scifi.stinger.explode"
ENT.SndCollide		= "scifi.item.orb.bounce"
ENT.SndSnack		= "scifi.stinger.attach"

ENT.LightEmit		= true
ENT.LightColor		= Color( 255, 255, 255, 255 ) --"255 255 255 255"
ENT.LightSpotRadius	= 72
ENT.LightDistance	= 512
ENT.LightBrightness	= 0.6
ENT.LightXplode 	= 4
ENT.LightFlareMat 	= Material( "bloom/halo_static_2" )
ENT.LightFlareAdd 	= true
ENT.LightFlareAlpha = 32
ENT.LightFlareSize 	= 0.2

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * ( self.PhxSSize + 4 )
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then DevMsg( "@SciFiItems : !Error; Invalid physics object" ) ent:Remove() end
	phys:ApplyForceCenter( VectorRand() * 2 )
	
	return ent
	
end

function ENT:SubInit( ent, phys )
	
	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
			ParticleEffectAttach( "flare_halo_0", 1, ent, 1 )
		end

		phys:SetDragCoefficient( 12 ) 

		constraint.Keepupright( ent, phys:GetAngles(), 0, 4294967296 )
	end
	
end

function ENT:SubThink( ent )

	if ( CLIENT ) then
		self.LightColor = Color( 200 + ( 50 * math.sin( CurTime() * 2 ) ), 200 + ( 50 * math.cos( CurTime() * 2 ) ), 200 + ( 50 * -math.sin( CurTime() * 2 ) ), 255 )
	end

	local proxy = ents.FindInSphere( ent:GetPos(), self.PhxSSize * 4 )
	
	for k, v in pairs( proxy ) do 
		if ( v:IsPlayer() ) then
			self:Snack( v )
		end
	end

end

function ENT:CreateMinion( tEntity )
--[[
	local mModel = tEntity:GetModel()
	local mMat = tEntity:GetMaterial()
	local mOrigin = tEntity:GetPos()
	local mAngles = tEntity:GetAngles()
	
	local npc = ents.Create( "npc_citizen" )
	npc:SetPos( mOrigin + Vector( 0, 0, 4 ) )
	npc:SetAngles( Angle( 0, mAngles.yaw, 0 ) )
	npc:SetKeyValue( "citizentype", 4 )
	npc:SetModel( mModel )
	npc:SetMaterial( mMat )
	npc:Spawn()
	npc:SetMaxHealth( 200 )
	npc:SetHealth( 200 )
	
	npc:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )

	npc:SetKeyValue( "spawnflags", "131072" )
	
	local spawnfx = EffectData()
	spawnfx:SetOrigin( mOrigin )
	spawnfx:SetEntity( tEntity )
	util.Effect( "propspawn", spawnfx, true, true )
]]--	
	local IsVaporizing = tEntity:GetNWBool( "IsVaporizing" )

	if ( IsVaporizing ) then return end
	
	tEntity:SetNWBool( "IsVaporizing", true )
	
	local tOrigin = tEntity:GetPos()
--	tEntity:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	
	local tPhys = tEntity:GetPhysicsObject()
	
	if ( IsValid( tPhys ) ) then
		tPhys:SetMass( 1 )
		tPhys:EnableDrag( true ) 
		tPhys:EnableGravity( false ) 
		tPhys:SetDragCoefficient( 8192 )
		tPhys:SetAngleDragCoefficient( 4096 )
		tPhys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 64 )
	end

	ParticleEffectAttach( "celest_dissolve", 1, tEntity, 1 )
	
	local ed = EffectData()
	ed:SetOrigin( tOrigin )
	ed:SetEntity( tEntity )
	util.Effect( "celest_dissolve", ed, true, true )

	tEntity:Fire( "kill", "", 2 )

end

function ENT:PhysicsCollide( data, phys )

	self:EmitSound( self.SndCollide )
	
	if ( IsValid( data.HitEntity ) ) then 
		if ( data.HitEntity:IsPlayer() ) then
			self:Snack( data.HitEntity )
		end
		
		if ( data.HitEntity:IsNPC() ) then
			self:XPlode( self:GetValidOwner() )
		end
		
		if ( data.HitEntity:IsRagdoll() ) then
			self:CreateMinion( data.HitEntity )
		end
	end
	
	if ( data.Speed > 100 ) then
		self:GetPhysicsObject():ApplyForceCenter( data.HitNormal * ( data.Speed * -0.05 )  )
	end

end

function ENT:Use( activator, caller )

	self:Snack( caller )

end

function ENT:Snack( player )

	if ( SERVER ) then
	
	if ( !IsValid( self ) ) then DevMsg( "!Error; Attempted call on non-existing entity! Removing!" ) self:Remove() end
	
	self:EmitSound( self.SndSnack )
	
	ParticleEffectAttach( "stinger_attach", 1, self, 1 )
	ParticleEffectAttach( "ngen_core_playerfx", 1, player, 1 )
	
	if ( player:GetActiveWeapon() ~= NULL ) then
	
		player:GiveAmmo( 100, player:GetActiveWeapon():GetPrimaryAmmoType() )
		player:GiveAmmo( 100, player:GetActiveWeapon():GetSecondaryAmmoType() )

	end
	
	local healthamt = math.Clamp( player:Health() + 100, 0, 100 )
	local shieldamt = math.Clamp( player:Armor() + 100, 0, 200 )
	
	if ( healthamt > 0 ) and ( player:Health() <= 100 ) then
		player:SetHealth( healthamt )
	else
		player:SetHealth( player:Health() + 100 )
	end
	
	if ( shieldamt > 0 ) and ( player:Armor() <= 100 ) then
		player:SetArmor( shieldamt )
	else
		player:SetArmor( player:Armor() + 100 )
	end
	
	self:Remove()
	
	end
	
end

function ENT:OnTakeDamage( dmginfo )

	if ( self:GetXPloding() ) or ( dmginfo:GetDamageType() == 33540137 ) then return end
	
	self:XPlode( dmginfo:GetAttacker() )
	
	return true
	
end

function ENT:XPlode( attacker )

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then
	
	self:SetXPloding( true )

	self:DealAoeDamage( DMG_GENERIC, 128 * amp, self:GetPos(), 128, attacker, 199999999 )
	ParticleEffect( "ngen_explosion_energy", self:GetPos(), self:GetAngles() )

	util.ScreenShake( self:GetPos(), 2, 24, 1, 512 )
	self:EmitSound( self.SndImpact )
	
	self:KillSilent()
	
	end
	
end