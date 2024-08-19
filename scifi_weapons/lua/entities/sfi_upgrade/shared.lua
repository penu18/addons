AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true
ENT.Category		= "Darken217's Scifi Items"
ENT.Purpose			= "Temporarily increases your damage."

ENT.PrintName 		= "Power Orb"
ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxSSize		= 12
ENT.PhxSProp 		= "item"
ENT.PhxMass 		= 4
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxElastic	 	= 16384
ENT.PhxBuoyancy 	= 0.5
ENT.LifeTime		= 0
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.FxTracer 		= "item_orb_upgrade"

ENT.FxRemove		= "item_upg_break"

ENT.SndImpact 		= "scifi.stinger.explode"
ENT.SndCollide		= "scifi.item.orb.bounce"
ENT.SndSnack		= "scifi.stinger.attach"

ENT.LightEmit		= true
ENT.LightColor		= "255 20 0 255"
ENT.LightSpotRadius	= 80
ENT.LightDistance	= 210
ENT.LightBrightness	= 1

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * ( self.PhxSSize + 4 )
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:SubInit( ent, phys )

	if ( SERVER ) then
		ent:RemoveEFlags( EFL_NO_WATER_VELOCITY_CHANGE ) -- This feels a bit weird, but I don't want to make that many exceptions with this ent.
		
		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
			ParticleEffectAttach( "flare_halo_0", 1, ent, 1 )
		end
		
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:SetDragCoefficient( 12 ) 
		phys:ClearGameFlag( FVPHYSICS_WAS_THROWN )
		
		constraint.Keepupright( ent, phys:GetAngles(), 0, 4294967296 )
	end
	
end

function ENT:SubThink( ent, phys )

	if ( SERVER ) then
	
		if ( !IsValid( self ) ) then DevMsg( "!Error; Attempted call on non-existing entity! Removing!" ) self:Remove() end
		
		local proxy = ents.FindInSphere( ent:GetPos(), self.PhxSSize * 4 )
	
		for k, v in pairs( proxy ) do 
			if ( v:IsPlayer() ) then
				self:Snack( v )
			end
		end

		self:GetPhysicsObject():ApplyForceCenter( VectorRand() * 2 )
		
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
	
	if ( IsValid( data.HitEntity ) ) && ( data.HitEntity:IsPlayer() || data.HitEntity:IsNPC() ) then
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
	
	if ( player:GetNWBool( "SciFiDmgBuff" ) == false ) then
	
		self:EmitSound( self.SndSnack )
		
		ParticleEffectAttach( "stinger_attach", 1, self, 1 )
		ParticleEffectAttach( "item_upg_break", 1, player, 1 )
		ParticleEffectAttach( "item_pfx_upgrade", 1, player, 1 )
	
		player:SetNWBool( "SciFiDmgBuff", true )
		
		local weapon = player:GetActiveWeapon()
		
		weapon.Wrath = true
		
		timer.Simple( 10, function()
			if ( IsValid( player ) ) then
				player:SetNWBool( "SciFiDmgBuff", false )
			end
			
			if ( IsValid( weapon ) && weapon.Wrath ) then
				weapon.Wrath = false
			end
		end )
	
		self:Remove()
	end
	
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

	ParticleEffect( "item_upg_break", fx2:GetPos(), self:GetAngles() )

	util.ScreenShake( fx2:GetPos(), 2, 4, 0.25, 256 )
	self:EmitSound( self.SndImpact )
	
	self:Remove()
	
	end
	
end