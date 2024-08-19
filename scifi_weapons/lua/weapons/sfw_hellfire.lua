AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "The RK-22 'HellFire' is an efficient chemical smg which offers a high fire-rate pared with good damage while being fairly accurate. It can set everything on fire."
SWEP.Instructions			= "Mouse1 to fire. Mouse1 + 'Use' (e) to deploy a blaze-charge. Beware of igniting yourself!, Mouse2 to aim down sights."
SWEP.ItemRank 				= 20

SWEP.PrintName				= "RK22 'HellFire' smg"
SWEP.Slot					= 2
SWEP.SlotPos				= 2

SWEP.ViewModel				= "models/weapons/c_sfmp.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.HoldType 				= "smg"
SWEP.SciFiSkin_1			= "/models/weapons/hfire/skin.vmt"
SWEP.SciFiSkin_2			= "/models/weapons/hfire/sight.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_hfire.vmt" )
end

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.VfxMuzzleParticle 		= "ngen_muzzle_4" --"hellfire_muzzle"
SWEP.VfxMuzzleColor 		= Color( 255, 80, 20, 120 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 120
SWEP.VfxMuzzleFarZ 			= 500

SWEP.AdsPos 				= Vector(-6.545, 0, 1.075)
SWEP.AdsAng 				= Vector(0, 0, 0)
SWEP.AdsFov					= 50
SWEP.ViewModelMeleePos		= Vector( 16, 8, -8 )
SWEP.ViewModelMeleeAng		= Angle( -5, 90, -95 )
-- SWEP.ViewModelSprintPos		= Vector( 6, 0.2, -0.6 )

SWEP.ViewModelSprintPos 	= Vector( 4, 0, -2 ) -- Vector( 5, 1.5, 1 )
SWEP.ViewModelSprintAng		= Angle( -4, 30, -30 ) -- Angle( -17.5, 25, -15 )
SWEP.ViewModelSwayDirection = Vector( -0.75, 6, 1 ) -- Vector( -0.25, 4, 0.6 )
SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.15 )
SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelSprintSway 	= 4.25
SWEP.SprintAnimSpeed		= 10
SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.0

SWEP.SciFiFamily			= { "elemental", "phys", "phys_legacy", "base", "noads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 10", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		60", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: Heat", color = Color( 255, 80, 40 ) },
	["3a"] = { text = "Status Chance: 100%", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Clip size: 				 30", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				6 (full-auto)", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Alt. damage: 	 5, +3 for 5sec", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Alt. range: 			256, 176 units", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Alt. damage type: Heat", color = Color( 255, 80, 40 ) },
	["9a"] = { text = "Status Chance: 100%", color = Color( 180, 180, 180 ) },
	["9b"] = { text = "Lights everything on fire. Everything...", color = Color( 180, 180, 180 ) },
	["9c"] = { text = "Altfire consumes 5 ammo.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 10,
		DamageBlastRadius = 60,
		DamageType = bit.bor( DMG_BULLET, DMG_BURN ),
		StatusChance = 100,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.1 }, 
		},
	},
	Secondary = {
		DamageComposition = "5, 3 over time",
		DamageAmount = 5,
		DamageBlastRadius = 176,
		DamageType = DMG_BURN,
		StatusChance = 100,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.4 },
		},
	},
	ClipSize = 30,
	ReloadSpeed = 1.8,
	Recoil = 2.6,
	PerkSet = { SCIFI_PERK_ELEMENTAL_FIRE }
} 


SWEP.VElements = {
	["body_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-1.048, 0.72, 5.012), angle = Angle(0, 105.767, 0.004), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/engine", skin = 0, bodygroup = {} },
	["etech_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.076, 1.919, 13.272), angle = Angle(17.76, 90, -180), size = Vector(0.455, 0.455, 0.455), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.479, -0.324, -3.968), angle = Angle(0, 14.581, 0), size = Vector(0.141, 0.141, 0.141), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_junk/propanecanister001a.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, 2.936, 12.093), angle = Angle(-45.696, -40.195, -148.749), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} },
	["pilotlight_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, -0.32, 3.398), angle = Angle(0, 0, 0), size = Vector(0.03, 0.03, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["barrel_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_citizen_tech/steamengine001a.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.157, 0.47, 14.468), angle = Angle(90, 0.081, 0.967), size = Vector(0.035, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.2, 1, -5), angle = Angle(0, -90, -102), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["body_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(-1.048, 0.72, 5.012), angle = Angle(0, 105.767, 0.004), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/engine", skin = 0, bodygroup = {} },
	["etech_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(-0.076, 1.919, 13.272), angle = Angle(17.76, 90, -180), size = Vector(0.455, 0.455, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(0.479, -0.324, -3.968), angle = Angle(0, 14.581, 0), size = Vector(0.141, 0.141, 0.141), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_junk/propanecanister001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(0, 2.936, 12.093), angle = Angle(-45.696, -40.195, -148.749), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} },
	["pilotlight_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(0, -0.32, 3.398), angle = Angle(0, 0, 0), size = Vector(0.03, 0.03, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["barrel_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_citizen_tech/steamengine001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(-0.157, 0.47, 14.468), angle = Angle(90, 0.081, 0.967), size = Vector(0.025, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:PrimaryAttack()

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
	
	local viewmodel = self:GetViewModelEnt()
	
	if ( self.Owner:IsPlayer() ) and ( self.Owner:KeyDown( IN_ATTACK ) && self.Owner:KeyDown( IN_USE ) ) then
	
		if (  !self:CanPrimaryAttack( 9 ) ) then return end
		self:SetNextSecondaryFire( CurTime() + 1 )
		
		if ( self.Owner:IsPlayer() ) then
		local viewmodel = self.Owner:GetViewModel()
		
		self:DoMuzzleEffect()
		self:DrawMuzzleLight( "255 80 20 200" , 120, 500, 0.075 )
		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
			ParticleEffectAttach( "hellfire_muzzle_smoke", 4, viewmodel, viewmodel:LookupAttachment("1") )
		end
		self.Owner:ViewPunch( Angle( -3.5, 0, 0 ) )
		end
		
		self:EmitSound( "scifi.hfire.fire1" )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		self:nade()
		self:TakePrimaryAmmo( 10 )
		self:SetNextPrimaryFire( CurTime() + 0.4 )
	
	else
	
		if ( SERVER ) then
		
			local ent = ents.Create( "hfire_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( self.Owner:GetAimVector() * 7200 + self:GetProjectileSpreadVector() * ( 12 + self:GetSciFiACC() * 6 ) )
			
		end
		
		self:DoMuzzleEffect()
		
		if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) and ( self:GetSciFiACC() >= ( GetConVarNumber( "sfw_sk_maxacc" ) * 0.82 ) ) then
			ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		end
			
		if ( self.Owner:IsPlayer() ) then	
			self.Owner:ViewPunch( Angle( math.random( -1.25, -2.5 ), math.random( 0, 0.8 ), math.random( 0, 0.5 ) ) * ( self:GetSciFiACC() * 0.0051 ) )
			self:AddSciFiACC( 2.6 )
		end
	
		self:EmitSound( "scifi.hfire.fire1" )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self:TakePrimaryAmmo( 1 )
		self:SetNextPrimaryFire( CurTime() + 0.1 )
	
	end
	
end

function SWEP:nade()

	local amp = GetConVarNumber( "sfw_damageamp" )

	self:EmitSound( "scifi.hfire.fire1" )
	
	if ( SERVER ) then
	
	local ent = ents.Create( "prop_physics" )
	if (  !IsValid( ent ) ) then return end
	ent:SetModel( "models/items/AR2_Grenade.mdl" )
	ent:SetPos( self:GetProjectileSpawnPos() )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	
	phys:ApplyForceCenter( self.Owner:GetAimVector() * 6500 )
	phys:SetMass( 4 )
	
	ent:AddCallback( "PhysicsCollide", function( boom )
	
		if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
		if ( ent:GetNWBool( "boom" ) == true ) then return end
		
		ent:SetNWBool( "boom", true )
		ent:Fire( "DisableMotion", "", 0 )
	--	ent:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
		
		-- for k, v in pairs ( ents.FindInSphere( ent:GetPos(), 72 ) ) do
			-- DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 10 } )
		-- end
		
		-- ent:Fire( "kill", "", 0.0075 )
		
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", "255 100 10  255" )
		fx:SetKeyValue( "spotlight_radius", 420 )
		fx:SetKeyValue( "distance", 740 )
		fx:SetKeyValue( "brightness", 3 )
		fx:SetPos( ent:GetPos() )
		fx:Spawn()

		local fx2 = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx2:SetKeyValue( "_light", "255 100 10  255" )
	--	fx2:SetKeyValue( "spotlight_radius", 240 )
	--	fx2:SetKeyValue( "distance", 740 )
		fx2:SetKeyValue( "brightness", 2 )
		fx2:SetKeyValue( "style", 1 )
		fx2:SetPos( ent:GetPos() )
		fx2:Spawn()
		
		DLightFade( fx2, 0, 676, 2.2, 3.99 )

		if ( self ~= NULL && self.Owner ~= NULL && IsExistent( self ) && IsValid( self.Owner ) ) then
			self:DealAoeDamage( DMG_BURN, 5 * amp, ent:GetPos(), 256 )
			self:DealAoeDamageOverTime( bit.bor( 1, DMG_SLOWBURN ), 3 * amp, ent:GetPos(), 176, 2, 0, self )
		end
		
		if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) then
			ParticleEffect( "hellnade_heat", ent:GetPos(), Angle( 1, 1, 1 ), self.Owner )
		end
		
		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
			ParticleEffect( "hellnade_fragments", ent:GetPos(), Angle( 1, 1, 1 ), self.Owner )
		end
		
		ParticleEffect( "hellnade_shockwave", ent:GetPos(), Angle( 1, 1, 1 ), self.Owner )
		
		fx2:EmitSound( "scifi.hfire.altfirehit" )
		
		util.ScreenShake( fx2:GetPos(), 2, 2, 0.5, 1024 )
		util.Decal( "scorch" , fx:GetPos(), fx:GetPos() * 2 )
		
		SafeRemoveEntityDelayed( ent, 0.016 )
		SafeRemoveEntityDelayed( heat, 2 )
		SafeRemoveEntityDelayed( fx, 0.1 )
		SafeRemoveEntityDelayed( fx2, 3 )

	end )

	end
	
end

function SWEP:SecondaryAttack()
	
end

function SWEP:CanSecondaryAttack()

	if ( self.Weapon:Clip1() < 10 ) then
	self:EmitSound( "Weapon_ar2.Empty" )
	return false
	end

	return true
	
end