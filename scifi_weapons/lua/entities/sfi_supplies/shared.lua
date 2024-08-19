AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true
ENT.Category		= "Darken217's Scifi Items"
ENT.Purpose			= "Restores a small amount of health and shield to the player and gives a decent amount of the currently used ammo type."

ENT.PrintName 		= "Supply Orb"
ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxSSize		= 12
ENT.PhxSProp 		= "item"
ENT.PhxMass 		= 4
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxElastic	 	= 16384
ENT.PhxBuoyancy 	= 0.5
ENT.PhxUseFlags	 	= true
ENT.LifeTime		= 0
ENT.OnWater			= PROJECTILE_RULE_IGNORE

if ( GetConVarNumber( "sfw_fx_particles" ) == 0 ) then
	ENT.FxTracer = "ngen_core_small_cheap"
else
	ENT.FxTracer = "ngen_core_small"
end

ENT.FxRemove		= "ngen_hit"

ENT.SndImpact 		= "scifi.stinger.explode"
ENT.SndCollide		= "scifi.item.orb.bounce"
ENT.SndSnack		= "scifi.stinger.attach"

ENT.LightEmit		= true
ENT.LightColor		= "220 200 255 255"
ENT.LightSpotRadius	= 72
ENT.LightDistance	= 200
ENT.LightBrightness	= 0.8
ENT.LightFlareScale = 1.2

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

	local proxy = ents.FindInSphere( ent:GetPos(), self.PhxSSize * 4 )
	
	for k, v in pairs( proxy ) do 
		if ( v:IsPlayer() ) then
			self:Snack( v )
		end
	end

end

function ENT:PhysicsCollide( data, phys )
	
	if ( SERVER ) then
	
	if ( !IsValid( self ) ) then DevMsg( "!Error; Attempted call on non-existing entity! Removing!" ) self:Remove() end

	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx2 ) ) then return end
	fx2:SetKeyValue( "_light", self.LightColor )
	fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius * 1.2 )
	fx2:SetKeyValue( "distance", self.LightDistance * 1.2 )
	fx2:SetKeyValue( "brightness", 1 )
	fx2:SetPos( self:GetPos() )
	fx2:SetAngles( self:GetAngles() )
	fx2:Spawn()
	fx2:Fire( "kill", "", 0.115 )

	--ParticleEffect( "ngen_hit_lgtning", fx2:GetPos(), self:GetAngles() )

	self:EmitSound( self.SndCollide )
	
	if ( IsValid( data.HitEntity ) ) && ( data.HitEntity:IsPlayer() ) then
		self:Snack( data.HitEntity )
	end
	
	if ( data.Speed > 100 ) then
		self:GetPhysicsObject():ApplyForceCenter( data.HitNormal * ( data.Speed * -0.05 )  )
	end
	
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
	
		player:GiveAmmo( math.random( 20, 40 ), player:GetActiveWeapon():GetPrimaryAmmoType() )
		player:GiveAmmo( math.random( 1, 3 ), player:GetActiveWeapon():GetSecondaryAmmoType() )

	end
	
	local healthamt = math.Clamp( player:Health() + math.random( 2, 10 ), 0, 100 )
	local shieldamt = math.Clamp( player:Armor() + math.random( 2, 10 ), 0, 100 )
	
	if ( healthamt > 0 ) and ( player:Health() <= 100 ) then
	player:SetHealth( healthamt )
	else
	player:SetHealth( player:Health() + math.random( 2, 10 ) )
	end
	
	if ( shieldamt > 0 ) and ( player:Armor() <= 100 ) then
	player:SetArmor( shieldamt )
	else
	player:SetArmor( player:Armor() + math.random( 2, 10 ) )
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

	self:DealAoeDamage( 1, 64 * amp, self:GetPos(), 128, attacker )

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

	ParticleEffect( "ngen_explosion_energy", fx2:GetPos(), self:GetAngles() )

	util.ScreenShake( fx2:GetPos(), 2, 4, 0.25, 256 )
	self:EmitSound( self.SndImpact )
	
	self:Remove()
	
	end
	
end