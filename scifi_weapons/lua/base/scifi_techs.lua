--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v15 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Alternative weapon systems to be mounted 					--
-- by sfw_custom via the spawn menu								--
-- Each function has to be called by the attack function.		--
-- Some require data like the current SciFiACC from the weapon.	--
------------------------------------------------------------------
-- Has to be included by sfw_custom via AddCSLuaFile()			--
------------------------------------------------------------------

AddCSLuaFile()

-- VPR Binary --

local snd_vp_pfire = Sound( "weapons/vapor/fstar_pfire.wav" )
local snd_vp_pfire_echo = Sound( "weapons/vapor/fstar_sfire_.wav" )

function SWEP:VpBinFire()

	local amp = GetConVarNumber( "sfw_damageamp" )
	local viewmodel = self.Owner:GetViewModel()
	local attachment = viewmodel:LookupAttachment( "muzzle" )
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( 0, 0 )
	bullet.Tracer = 1
	bullet.Force = 2
	bullet.HullSize = 2
	bullet.Damage = 120 * amp
	bullet.TracerName = "vp_binary_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ) )
	end

	if ( self.Owner:IsPlayer() ) then
	
		local tr = self.Owner:GetEyeTrace()
		
		if ( tr.HitGroup == HITGROUP_HEAD ) then -- Critical damage intensifies --
			bullet.Damage = 240 * amp
		end
	
		-- fake punch-through
		local ptru = {}
		ptru.Num = 1
		ptru.Src = tr.HitPos + self.Owner:GetAimVector() * 16
		ptru.Dir = self.Owner:GetAimVector()
		ptru.Distance = 128
		ptru.Tracer = 0
		ptru.HullSize = 0.4
		ptru.Force = 1
		ptru.Damage = 80 * amp
		ptru.Callback = function( attacker, tr, dmginfo )
			dmginfo:SetDamageType( bit.bor( DMG_SLASH, DMG_CLUB ) )
		end
		
		self.Owner:FireBullets( ptru, false )
		
		self.Owner:ViewPunch( Angle( -1, math.random( 0, 0.003 ), math.random( 0, 0.003 ) ) * ( 1 + self:GetSciFiACC() * 0.15 ) )
		self:AddSciFiACC( 9 )
		self:TakePrimaryAmmo( 1 )
	
		if ( SERVER ) then
			DoElementalEffect( { Element = EML_DISSOLVE_VAPOR, Attacker = self.Owner, Origin = tr.HitPos, Range = 24, Ticks = 25, DslvMaxMass = 500 } ) 
			ParticleEffect( "vapor_collapse", tr.HitPos, Angle( 0, 0, 0 ) )
		end
		
	end
	
	self.Owner:FireBullets( bullet, false )
	
	local muzzle = viewmodel:GetAttachment( attachment )

	ParticleEffectAttach( "saphyre_muzzle", 4, viewmodel, attachment )
	ParticleEffectAttach( "saphyre_muzzle_flames_0a", 4, viewmodel, attachment )
	--ParticleEffect( "vp_binary_muzzle", muzzle.Pos, muzzle.Ang, self )
	--ParticleEffect( "saphyre_muzzle_flames_0a", muzzle.Pos, muzzle.Ang, viewmodel )
	
	if ( SERVER ) && ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) then
		ParticleEffectAttach( "nrg_heat", 4, viewmodel, attachment )
	end
	
	self:DrawMuzzleLight( "120 220 255 220", 140, 720, 0.075 )

	self:EmitSound( snd_vp_pfire, 100, math.random( 98, 102 ), 1, CHAN_WEAPON )
	self:EmitSound( snd_vp_pfire_echo, 100, math.random( 98, 102 ), 1, CHAN_STATIC )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
end

-- RNG99 Synergy rifle --
function SWEP:SynBullet()

	if ( CLIENT ) then return end
	
	local ent = ents.Create( "prop_physics" )
	if (  !IsValid( ent ) ) then return end
	ent:SetModel( "models/props_bts/rocket.mdl" )
	ent:SetMaterial( "vgui/white" )
	ent:SetPos( self:GetProjectileSpawnPos( true ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:SetKeyValue( "disableshadows", 1 )
	ent:SetKeyValue( "physdamagescale", 3 )
	ent:Spawn()
	ent:Fire( "DisableFloating", "", 0 )
	ent:SetMoveType( MOVETYPE_VPHYSICS )
	ent:SetPhysicsAttacker( self.Owner, 10 )
	
	util.SpriteTrail( 
	ent, --parent
	1, --attachment ID
	Color( 0, 80, 255, 255 ), --color table
	1, --additive rendering?
	9, --start width
	0, --end width
	0.54, --lifetime
	128, --texel size
	"effects/blueblacklargebeam.vmt" ) --material
	
	local fxf = ents.Create( "env_sprite" )
	if ( !IsValid( fxf ) ) then return end
	fxf:SetKeyValue( "model", "effects/phaz_cinematic.vmt" )
	fxf:SetKeyValue( "renderamt", 255 )
	fxf:SetKeyValue( "Scale", 0.075 )
	fxf:SetPos( ent:GetPos() )
	fxf:SetParent( ent )
	fxf:Spawn()
	
	local fx = ents.Create( "light_dynamic" )
	if ( !IsValid( fx ) ) then return end
	fx:SetKeyValue( "_light", "0 40 255 255" )
	fx:SetKeyValue( "spotlight_radius", 190 )
	fx:SetKeyValue( "distance", 210 )
	fx:SetKeyValue( "brightness", 1.17 )
	fx:SetPos( ent:GetPos() )
	fx:SetParent( ent )
	fx:Spawn()
	
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	
	phys:ApplyForceCenter( self.Owner:GetAimVector() * 10000000000000 + VectorRand() * 361957299999 )
	phys:SetMass( 4.9 )
	phys:EnableGravity( false )
	phys:EnableDrag( false )

	ent:AddCallback( "PhysicsCollide", function( collision )
		
		ent:Fire( "DisableMotion", "", 0 )
		
		local bullet = {}
		bullet.Num = 1
		bullet.Src = ent:GetPos() + ent:GetAngles():Forward() * 10
		bullet.Dir = ent:GetAngles():Forward() 
		bullet.Spread = Vector( 0, 0 )
		bullet.Tracer = 0
		bullet.Force = 5
		bullet.HullSize = 1
		bullet.Damage = 5
		bullet.AmmoType = "SciFiAmmo"
		bullet.Callback = function( attacker, tr, dmginfo )
			dmginfo:SetDamageType( bit.bor( DMG_SHOCK ) )
		end
		
		ent:FireBullets( bullet, false )
	
		fx:SetKeyValue( "spotlight_radius", 220 )
		fx:SetKeyValue( "distance", 250 )
		fx:SetKeyValue( "brightness", 2 )
		
		ParticleEffect( "nrg_hit", ent:GetPos(), Angle( 1, 2, 3 ), self )

		ent:Fire( "break", "", 0.003 ) 
		
	end )
		
	SafeRemoveEntityDelayed( ent, 10 )
	
end

-- D4's RK Bane rifle --
function SWEP:bane( amp )
	
	local amp = GetConVarNumber( "sfw_damageamp" )

	if ( CLIENT ) then return end
	
	local ent = ents.Create( "prop_physics" )
	if ( !IsValid( ent ) ) then return end
	ent:SetModel( "models/spitball_small.mdl" )
	ent:SetMaterial( "models/black.vmt" )
	ent:SetPos( self:GetProjectileSpawnPos() )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:SetKeyValue( "disableshadows", 1 )
	ent:SetOwner( self.Owner )
	ent:Spawn()
	ent:Fire( "DisableFloating", "", 0 )
	ent:SetPhysicsAttacker( self.Owner, 10 )

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	phys:EnableGravity( false )
	phys:SetMass( 3 )
	
	timer.Create( "follow" .. ent:EntIndex(), 0, 0, function()
		phys:ApplyForceCenter( self.Owner:EyeAngles():Forward() * 10000000 )
	end )
		
	local fx = ents.Create( "light_dynamic" )
	if ( !IsValid( fx ) ) then return end
	fx:SetKeyValue( "_light", "64 0 32 255" )
	fx:SetKeyValue( "spotlight_radius", 180 )
	fx:SetKeyValue( "distance", 210 )
	fx:SetKeyValue( "brightness", 1 )
	fx:SetPos( ent:GetPos() )
	fx:SetParent( ent )
	fx:Spawn()

	ParticleEffectAttach( "dark_blob", 1, ent, 1)
		
	ent:AddCallback( "PhysicsCollide", function( boom ) 
		
		ent:AddCallback( "PhysicsCollide", function( boom ) 
			for k, v in pairs( ents.FindInSphere( ent:GetPos(), 128 ) ) do
				if ( v:IsNPC() ) or ( v:IsPlayer() ) then
					if ( v:GetNWBool( "defiled" ) ~= true ) then
						v:SetNWBool( "defiled", true )
						local dps = ents.Create( "bane_hurt" )
						dps:SetPos( v:GetPos() )
						dps:SetOwner( self.Owner )
						dps:SetParent( v )
						dps:Spawn()
						dps:Activate()
					end
				end
			end
			ent:Remove()
		end )
	
		timer.Remove( "follow" .. ent:EntIndex() )
		ent:Fire( "break", "", 0.001 ) 
		
	end )
	
	SafeRemoveEntityDelayed( ent, 10 )
	SafeRemoveEntityDelayed( fx, 10 )
	
end

-- flechette shotgun --
function SWEP:flechgun()
	
	if (!SERVER) then return end
	
	local ent = ents.Create( "hunter_flechette" )
	ent:SetPos( self:GetProjectileSpawnPos( true ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
	ent:SetVelocity( self.Owner:GetAimVector() * 2000 + Vector( math.random( -250, 250 ), math.random( -250, 250 ), math.random( -250, 250 ) ) )
	ent:SetOwner( self.Owner )
	
end

-- MTM Grenade Launcher --
function SWEP:CA3Nade()

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then
	
	local ent = ents.Create( "prop_physics" )
	if (  !IsValid( ent ) ) then return end
	ent:SetModel( "models/props_bts/rocket.mdl" )
	ent:SetMaterial( "models/bullet" )
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
	ent:SetPhysicsAttacker( self.Owner, 10 )

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	
	phys:ApplyForceCenter( self.Owner:EyeAngles():Up() * 5400 + self.Owner:GetAimVector() * 110000 )
	phys:SetMass( 4 )
	
	if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
	ParticleEffectAttach( "gunsmoke", 1, ent, 1)
	end
	
	ent:AddCallback( "PhysicsCollide", function( boom )
	
	ent:Fire( "DisableMotion", "", 0 )
	
	local boom = ents.Create( "env_explosion" )
--	boom:SetKeyValue( "DamageType", DMG_RADIATION )
	boom:SetKeyValue( "iMagnitude", 82 * amp )
	boom:SetKeyValue( "iRadiusOverride", 256 )
--	boom:SetKeyValue( "fireballsprite", "effects/phaz_vapor.vmt" )
	boom:SetKeyValue( "spawnflags", 4 ) --No fireball
--	boom:SetKeyValue( "spawnflags", 8 ) --No smoke
--	boom:SetKeyValue( "spawnflags", 256 ) --No fireball smoke
--	boom:SetKeyValue( "spawnflags", 512 ) --No so called "particles"
--	boom:SetKeyValue( "spawnflags", 8192 ) --Damage is limited by surfaces and world geometry
--	boom:SetKeyValue( "spawnflags", 64 ) --No Sound
--	boom:SetKeyValue( "spawnflags", 1024 ) --No light emission
--	boom:SetKeyValue( "spawnflags", 32 )
	boom:SetPos( ent:GetPos() )
	boom:Spawn()
	boom:Fire( "explode", "", 0 )
	
	ent:Fire( "break", "", 0.0075 )
	
	local fx = ents.Create( "light_dynamic" )
	if ( !IsValid( fx ) ) then return end
	fx:SetKeyValue( "_light", "120 110 255 255" )
	fx:SetKeyValue( "spotlight_radius", 420 )
	fx:SetKeyValue( "distance", 740 )
	fx:SetKeyValue( "brightness", 3 )
	fx:SetPos( boom:GetPos() )
	fx:Spawn()
	
	ParticleEffect( "ngen_explosion", boom:GetPos(), Angle( 1, 1, 1 ), self.Owner )
	
	fx:EmitSound( "scifi.ngen.explosion" )
	--fx:EmitSound( "BaseExplosionEffect.Sound" )
	sound.Play( "weapons/pulsar/pulsar_altfire.wav", fx:GetPos(), SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
	util.ScreenShake( fx:GetPos(), 1024, 16, 0.4, 620 )
	
	SafeRemoveEntityDelayed( boom, 2 )
	SafeRemoveEntityDelayed( fx, 0.1 ) end )
	
	end

	
end

-- CA3 Vk Rifle --
function SWEP:CA3( acc )

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .0021, .0021 ) * ( acc * 2.17 ) --Vector( .032, .032, 0 )
	bullet.Tracer = 1
	bullet.Force = 256
	bullet.HullSize = 1
	bullet.Damage = 14 * GetConVarNumber( "sfw_damageamp" )
	bullet.AmmoType = "SciFiAmmo"
	bullet.TracerName = "ca3_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_GENERIC ) )
	end
	
	self.Owner:FireBullets( bullet, false )
	self:EmitSound( "cat.vk21.pfire" )

end

-- PSD-H Vk Rifle --
function SWEP:PEST( acc )

	local bullet = {}
	bullet.Num = 2
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .03, .03 ) -- * ( acc * 1.12 ) --Vector( .032, .032, 0 )
	bullet.Tracer = 1
	bullet.Force = 128
	bullet.HullSize = 1
	bullet.Damage = 4 * GetConVarNumber( "sfw_damageamp" )
	bullet.AmmoType = "SciFiAmmo"
	bullet.TracerName = "pest_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_NERVEGAS ) )
	end
	
	self.Owner:FireBullets( bullet, false )
	self:EmitSound( "cat.pest.pfire" )
	
	local v = self.Owner:GetEyeTrace().Entity
	
	if ( SERVER ) and ( GetRelChance( 30 ) ) then
		if ( IsValid( v ) ) and ( v:IsNPC() || v:IsPlayer() ) then
			if ( v:GetNWBool( "edmg_corrosive" ) ~= true ) then
				v:SetNWBool( "edmg_corrosive", true )
				local dps = ents.Create( "dmg_corrosion" )
				dps:SetPos( v:GetPos() )
				dps:SetOwner( self.Owner )
				dps:SetParent( v.Entity )
				dps:Spawn()
				dps:Activate()
			end
		end
	end

end

-- CA72 Vk Rifle --
function SWEP:CA72( acc )

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .0021, .0021 ) * ( acc * 2.17 ) --Vector( .032, .032, 0 )
	bullet.Tracer = 1
	bullet.Force = 64
	bullet.HullSize = 1
	bullet.Damage = 14 * GetConVarNumber( "sfw_damageamp" )
	bullet.AmmoType = "SciFiAmmo"
	bullet.TracerName = "nrg_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_SHOCK ) )
	end
	
	self.Owner:FireBullets( bullet, false )
	self:EmitSound( "scifi.vapor.fire1" )

end

-- HLK xplo Vk Rifle --
function SWEP:XPLO( acc )

	local amp = GetConVarNumber( "sfw_damageamp" )

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .0021, .0021 ) * ( acc * 2.3 ) --Vector( .032, .032, 0 )
	bullet.Tracer = 1
	bullet.Force = 512
	bullet.HullSize = 1
	bullet.Damage = 18 * amp
	bullet.AmmoType = "SciFiAmmo"
	bullet.TracerName = "xplo_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		self:DealAoeDamage( DMG_BLAST, 14 * amp, tr.HitPos, 200 )
		dmginfo:SetDamageType( bit.bor( DMG_BLAST, DMG_AIRBOAT, DMG_ALWAYSGIB ) )

		if ( GetRelChance( 40 ) ) then
			ParticleEffect( "xplo_hit_shrapnels", tr.HitPos, Angle( 0, 0, 0 ), self )
		end
		if ( GetRelChance( 60 ) ) then
			ParticleEffect( "xplo_hit_shrapnels", tr.HitPos, Angle( 0, 0, 0 ), self )
		end
		if ( GetRelChance( 80 ) ) then
			ParticleEffect( "xplo_hit_shrapnels", tr.HitPos, Angle( 0, 0, 0 ), self )
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	self:EmitSound( "cat.hlk.pfire" )

end

-- Veho AR2 --
function SWEP:VhAr( acc )

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .0009, .0010 ) * ( self:GetSciFiACC() * 2.17 )
	bullet.Tracer = 1
	bullet.Force = 128
	bullet.HullSize = 1
	bullet.Damage = 18 * GetConVarNumber( "sfw_damageamp" )
	bullet.AmmoType = "SciFiAmmo"
	bullet.TracerName = "vh_tracer"
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
	local viewmodel = self.Owner:GetViewModel()
	ParticleEffectAttach( "vh_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	self.Owner:ViewPunch( Angle( -0.217, 0, 0 ) )
	else end
	
	if ( self.Owner:IsNPC() ) then
	local viewmodel = self.Owner:GetActiveWeapon()
	ParticleEffectAttach( "vh_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	else end
	
	self:EmitSound( "Weapon_AR2.Single" )

	self:AddSciFiACC( 4 )

end

-- ShockGun --
function SWEP:Shk()

	local bullet = {}
	bullet.Num = 8
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .1, .1 ) + Vector( 0.001, 0.001 )
	bullet.Distance = 512
	bullet.Tracer = 1
	bullet.Force = 1
	bullet.HullSize = 1
	bullet.Damage = 5 * GetConVarNumber( "sfw_damageamp" )
	bullet.AmmoType = "SciFiAmmo"
	bullet.TracerName = "shk_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_SHOCK, DMG_ENERGYBEAM ) )
	end
	
	self.Owner:FireBullets( bullet, false )
	
	local viewmodel = self:GetViewModelEnt()
	ParticleEffectAttach( "shk_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	
	if ( self.Owner:IsPlayer() ) then
	self.Owner:ViewPunch( Angle( -0.217, 0, 0 ) )
	end
	
	
	self:EmitSound( "scifi.storm.fire2" )

end