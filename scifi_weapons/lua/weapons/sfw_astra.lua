AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "An alien hybrid rifle, featuring aspects of two rifles types in one weapon."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to aim down sights. Carbine-mode during hip-fire, sniper-mode when aiming down sights. Will overheat on continuous fire."
SWEP.ItemRank 				= 27

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.DeploySpeed 			= 1.8
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SciFiEnergy"

SWEP.VfxMuzzleParticle 		= "spectra_muzzle_2"
SWEP.VfxMuzzleColor 		= Color( 200, 170, 255, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720
SWEP.VfxHeatParticle 		= "spectra_muzzle_overheat"
SWEP.VfxHeatThreshold 		= 0.3
SWEP.VfxHeatDelay 			= 0

SWEP.PrintName				= "C-CA Astra"
SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModelFOV 			= 54

SWEP.AdsPos 				= Vector(-3.95, 32, 2.23)
SWEP.AdsFov					= 25
if ( CLIENT ) then
	SWEP.AdsMSpeedScale			= GetConVar( "sfw_adsmspeedscale" ):GetFloat() * 0.75
end

SWEP.AdsFovTransitionTime	= 0.2
SWEP.AdsTransitionSpeed		= 14
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.astra.zoomin"
SWEP.AdsSoundDisable		= "scifi.astra.zoomout"

SWEP.SafeModeOnSnd 	 		= "scifi.ancient.safety.on"
SWEP.SafeModeOffSnd 		= "scifi.ancient.safety.off"

SWEP.MidairRecoilMul		= 1

SWEP.DefaultSwayScale		= 1.2
SWEP.DefaultBobScale		= 1.6

SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.2
SWEP.ViewModelShiftOffset 	= Vector( 0, -0.04, -0.09 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )
SWEP.ViewModelMoveBob 		= false

SWEP.ViewModelSprintPos 	= Vector( 6, -1, -0.2 )
SWEP.ViewModelSprintAng		= Angle( -4, 30, -30 )
SWEP.ViewModelSwayDirection = Vector( -0.75, 6, 1 )
SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.2 )
SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelSprintSway 	= 4
SWEP.SprintAnimSpeed		= 12
SWEP.SprintSwayScale		= 0
SWEP.SprintBobScale			= 0

SWEP.ViewModelMeleePos		= Vector( 22, 10, -3 )
SWEP.ViewModelMeleeAng		= Angle( -5, 85, -60 )

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8

SWEP.ChargeOverheat			= 120
SWEP.ChargeMax				= 150
SWEP.ChargeAdd				= 18
SWEP.ChargeDrain			= 0.85
SWEP.ChargeDeltaCompensate 	= true

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.6
SWEP.SciFiMeleeRange		= 60
SWEP.SciFiMeleeDamage		= 8
SWEP.SciFiMeleeSound		= "scifi.melee.swing.heavy"

SWEP.NPCAccuracy 			= 100
SWEP.NPCSkillLevel 			= 1.2
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.05

SWEP.DepletedSND			= ""

SWEP.SciFiFamily			= { "custom", "phys", "hitscanbullets", "ads", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				     12", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				   x2", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	   Energy, Bullet", color = Color( 185, 180, 160 ) },
	["4"] = { text = "Fire rate: 		         7.2 (full-auto)", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Energy drain: 	    8 (per shot)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate:    60", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Alt. Damage: 			24", color = Color( 180, 180, 180 ) },
	["7a"] = { text = "Alt. Crit. mul.: 		x4", color = Color( 180, 180, 180 ) },
	["7b"] = { text = "Alt. Damage type: Blight", color = Color( 215, 160, 255 ) },
	["8"] = { text = "Alt. Fire rate: 			 5 (full-auto)", color = Color( 180, 180, 180 ) },
	["8a"] = { text = "Alt. Energy drain: 32 (per shot)", color = Color( 180, 180, 180 ) },
	["8b"] = { text = "Overheats on continuous fire.", color = Color( 180, 180, 180 ) },
	["9a"] = { text = "Weapon type changes with zooming.", color = Color( 180, 180, 180 ) },
	["9b"] = { text = "Altfire can punch through thin objects.", color = Color( 180, 180, 180 ) },
--	["9c"] = { text = "Melee attacks may destabilize the weapon's energy core.", color = Color( 180, 180, 180 ) },
	["9d"] = { text = "There is stillness within death", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 12,
		DamageType = { DMG_SF_VAPOR, DMG_BULLET },
		CritMul = 2,
		StatusChance = nil,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.16 }
		}
	},
	Secondary = {
		DamageAmount = 24,
		DamageType = DMG_SF_BLIGHT,
		DamageAttackRange = 36000,
		CritMul = 4,
		StatusChance = nil,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.2 }
		}
	},
	CoreRechargeRate = 60,
	Recoil = 8,
	PerkSet = { SCIFI_PERK_AMMO_PUNCHTRHOUGH_HEAVY, SCIFI_PERK_RELOAD_OVERHEAT, SCIFI_PERK_RELOAD_RECHARGEAMMO, { PerkTitle = "There is stillness within death", PerkPanelHeight = 3, PerkDescription = "Aiming down sights switches \nto sniper-mode.", PerkColor = Color( 255, 20, 20 ) } }
}

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 2, 1 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 3, 0, 4 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0 ), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(39.687, 17.166, -20.129) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 2.5, -1.5), angle = Angle(0, -165, -130), size = Vector(0.3, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/spectra/spectra_bone_rtedit.vmt", skin = 0, bodygroup = {} },
	["1+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, -1, -2.5), angle = Angle(7, -182, 70), size = Vector(0.3, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/spectra/spectra_bone_rtedit.vmt", skin = 0, bodygroup = {} },

	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.3, 2.2, 0.34), angle = Angle(134.783, 19.944, -11.235), size = Vector(0.218, 0.184, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.4, 2.2, -3), angle = Angle(185, 11, -10), size = Vector(0.22, 0.16, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/spectra/spectra_bone_rtedit.vmt", skin = 0, bodygroup = {} },

	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_left.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, -2.6, -1.8), angle = Angle(175, 9, 136), size = Vector(1.2, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_right.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, -0.8, -2.2), angle = Angle(175, 7, -136), size = Vector(1.2, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_left.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, -1, -4), angle = Angle(180, 6, -56), size = Vector(1.2, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_right.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, -2.8, -3.6), angle = Angle(180, 8, 36), size = Vector(1.2, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(0, 1.2, 20), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.04), color = Color(180, 220, 255, 200), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
	["3+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(0, 1.2, 18), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.04), color = Color(180, 220, 255, 200), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
	["3++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(0, 1.2, 16), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.04), color = Color(180, 220, 255, 200), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },

	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, 5.12, 11.2), angle = Angle(-90, 180, 87), size = Vector(1.2, 1.2, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, 4, 1), angle = Angle(110, 90, 180), size = Vector(0.7, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, 0.75, 18), angle = Angle(90, 90, 180), size = Vector(0.8, 0.6, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, -0.2, 12), angle = Angle(87.5, -90, 0), size = Vector(0.7, 0.72, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["6+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, 5, 16), angle = Angle(87.5, 90, 0), size = Vector(0.8, 0.8, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_left.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1, -5.45), angle = Angle(-2, 7, -15), size = Vector(0.4, 1, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["7+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_right.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, -0.2, -5.2), angle = Angle(-2, 8, 35), size = Vector(0.4, 1, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/roller.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },

	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "Base", rel = "", pos = Vector(0.4, 1.2, 10), angle = Angle(90, 0, 0), size = Vector(0.14, 0.14, 0.14), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },

	["holo7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(-0.4, -1.2, 6.4), angle = Angle(30, 0, 0), size = Vector(0.003, 0.003, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo7a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "holo7", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.003, 0.003, 0.001), color = Color(220, 220, 255, 40), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(0.4, -1.2, 6.4), angle = Angle(-30, 0, 0), size = Vector(0.003, 0.003, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo8a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "holo8", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.003, 0.003, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },

	["holo_circle_outer_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "Base", rel = "", pos = Vector(0.2, -1, 6), angle = Angle(0, 134, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 60), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo_circle_outer_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "Base", rel = "", pos = Vector(-0.2, -0.985, 6), angle = Angle(0, 316, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 60), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(0, -1, 16), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.004), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(0, -1, 6), angle = Angle(0, 0, 0), size = Vector(0.005, 0.005, 0.005), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(0, -1, 4), angle = Angle(0, 0, 0), size = Vector(0.0001, 0.0001, 0.0001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(8, 2.5, -1.5), angle = Angle(5, -167, -131), size = Vector(0.3, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(8, -1, -2.5), angle = Angle(10, -176, 93), size = Vector(0.3, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(5.3, 2.2, 0.34), angle = Angle(134.783, 19.944, -11.235), size = Vector(0.218, 0.184, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(0.4, 2.2, -3), angle = Angle(185, 11, -10), size = Vector(0.22, 0.16, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_left.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(22, -2.6, -1.8), angle = Angle(175, 9, 136), size = Vector(1.4, 0.8, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_right.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(22, -0.8, -2.2), angle = Angle(175, 7, -136), size = Vector(1.4, 0.8, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_left.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(22, -1, -4), angle = Angle(180, 6, -56), size = Vector(1.4, 0.8, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_right.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(22, -2.8, -3.6), angle = Angle(180, 8, 36), size = Vector(1.4, 0.8, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, 5.12, 11.2), angle = Angle(-90, 180, 87), size = Vector(1.2, 1.2, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, 4, 1), angle = Angle(110, 90, 180), size = Vector(0.7, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, 0.75, 18), angle = Angle(90, 90, 180), size = Vector(0.8, 0.6, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0.5, -0.2, 12), angle = Angle(87.5, -90, 2), size = Vector(0.7, 0.72, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["6+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(0, 5, 16), angle = Angle(87.5, 90, 0), size = Vector(0.8, 0.8, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_left.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(5, 1.2, -4.45), angle = Angle(-2, 7, -25), size = Vector(0.4, 1, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["7+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_barrel_right.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0a", pos = Vector(5, -0.4, -4.2), angle = Angle(-2, 8, 45), size = Vector(0.4, 1, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/roller.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1, 1.4, -3.8), angle = Angle(2, -86, -108), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/roller.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.1, -2), angle = Angle(-8, -2, -20), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} }
}

local snd_unstable = Sound( "weapons/ancient/spectra_flyby.wav" )

local llimb_hpos 		= Vector(7, 2, -2.5)
local rlimb_hpos 		= Vector(8, -1.2, -4.25)

local rlbar_hpos 		= Vector(22, -2.4, -3.2)
local rlbar_hang 		= Angle(175, 8, 136)
local llbar_hpos 		= Vector(22, -0.8, -3)
local llbar_hang 		= Angle(175, 7, -136)
local lubar_hpos 		= Vector(22, -1, -4.6)
local lubar_hang 		= Angle(180, 6, -56)
local rubar_hpos 		= Vector(22, -2.6, -4.4)
local rubar_hang 		= Angle(180, 8, 36)

local rlbar_adspos 		= Vector(20, -3.6, -1.8)
local llbar_adspos 		= Vector(20, 0.6, -2.2)
local lubar_adspos 		= Vector(20, 0.5, -5)
local rubar_adspos 		= Vector(20, -3.75, -4.2)

local lsight_hpos 		= Vector(5, 1, -4.45)
local lsight_hang 		= Angle(-2, 7, -15)
local rsight_hpos 		= Vector(5, -0.2, -4.2)
local rsight_hang 		= Angle(-2, 8, 35)

local lsight_adspos 	= Vector(5, 1, -5.35)
local lsight_adsang 	= Angle(-2, 7.1, -45)
local rsight_adspos 	= Vector(5, -0.5, -5.15)
local rsight_adsang 	= Angle(-2, 8.2, 61)

local stock_hpos 		= Vector(0.4, 2.2, -3)
local stock_hang 		= Angle(184, 6.8, -10)
local stock_adspos 		= Vector(0.4, 1.98, -3.6)

local rail_hpos 		= Vector(0, -0.1, 12)
local rail_adspos 		= Vector(0, 0.4, 8)
--local fgrip_hpos 		= Vector(0, 5, 16)

local core_hpos 		= Vector(6, 0.6, -3.2)
local core_hscale 		= Vector( 0.1, 0.1, 0.1 )

local sight_lbrace 		= Vector(0, -1, 6)
local sight_rbrace 		= Vector(0, -0.985, 6)
local sight_innercircle = Vector(0, -1, 6.4)
local sight_outercircle = Vector(0, -1, 6)
local sight_point 		= Vector(0, -1, 6)
local sight_overheat 	= Vector(-0.4, -1, 6.4)
local sight_ammo 		= Vector(0.4, -1, 6.4)

local mymat = Material( "models/weapons/spectra/spectra_bone_rtedit.vmt" )
local matCore = Material( "models/weapons/misc/energy_surf" )

local bone_color_default = Vector( 2, 2, 2 )
local core_color_default = Color( 120, 130, 255 )

local sight_color_idle  			= Color( 190, 215, 255 )
local sight_color_tarlock_default 	= Color( 225, 180, 40 )
local sight_color_tarlock_headshot 	= Color( 255, 0, 35 )
local sight_color_ammo_idle  		= Color(220, 220, 255)
local sight_color_ammo_negative 	= Color(240, 0, 40)

SWEP.DataTables = {
	{ dType = "Float", dName = "NextChargeAnim" },
	{ dType = "Float", dName = "NextCoreFxAnim" }
}

function SWEP:SubInit()

	self:SetCharge( 0 )
	self.ScifiRegenNext = 0
	
end

function SWEP:Think()

	local animtime = self:GetNextChargeAnim()
	local frametime = FrameTime()
	local gametime = CurTime()
	local vm = self.Owner:GetViewModel()
	local IsAds = self.SciFiState == SCIFI_STATE_ADS
	
	local sine0 = math.sin( gametime * 8 ) / 16
	local sine1 = math.sin( gametime * 4 ) / 20
	local sine2 = math.sin( gametime * 4 ) / 40
	
	local fCharge = self:GetCharge()
	local cmod = fCharge / 250
	local cmod2 = fCharge - self.ChargeOverheat
	local cmod3 = self:Clip1()

	if ( !game.SinglePlayer() && CLIENT ) || ( SERVER ) then
		if( self.ScifiRegenNext <= gametime ) && ( !self.Owner:KeyDown( IN_ATTACK ) ) then
			if ( self:Clip1() < self.Primary.ClipSize ) then 
				self:SetClip1( cmod3 + 1 ) 
			end
		end
	end
	
	if ( self:GetSafeMode() ) then
		cmod = 0
		cmod2 = 0
		cmod3 = 0
		fCharge = 0
	end

	if ( CLIENT ) && ( !self.Owner:InVehicle() ) then
		local nextanim = self:GetNextCoreFxAnim()
	
		local llimb 					= self.VElements[ "1+" ]
		local rlimb 					= self.VElements[ "1+++" ]
--		local fgrip 					= self.VElements[ "6+" ]
		local core 						= self.VElements[ "0+" ]
		
		local sight_lbrace 				= self.VElements[ "holo_circle_outer_0" ]
		local sight_rbrace 				= self.VElements[ "holo_circle_outer_1" ]
		local sight_a 					= self.VElements[ "holo8" ]
		local sight_a_content 			= self.VElements[ "holo8a" ]
		local sight_oheat 				= self.VElements[ "holo7" ]
		local sight_oheat_content 		= self.VElements[ "holo7a" ]
		local sight_chair 				= self.VElements[ "holo++" ]
		local sight_ring_1 				= self.VElements[ "holo" ]
		local sight_ring_2 				= self.VElements[ "holo+" ]
		
		local snipercore_1 				= self.VElements[ "3" ]
		local snipercore_2 				= self.VElements[ "3+" ]
		local snipercore_3 				= self.VElements[ "3++" ]
		
		local rlbar 					= self.VElements[ "4" ]
		local llbar 					= self.VElements[ "4+" ]
		local lubar 					= self.VElements[ "4++" ]
		local rubar 					= self.VElements[ "4+++" ]
	
		llimb.pos = llimb_hpos + Vector( sine0, -sine1 + cmod, sine2 )
		rlimb.pos = rlimb_hpos + Vector( -sine0, -sine1 - cmod, sine2 + cmod )
--		fgrip.pos = fgrip_hpos + Vector( -sine0, -sine1 -cmod, sine2 + cmod )		
		
		local aSway = self:GetViewModelSway()
		local SwayActual = Angle( aSway.pitch * 0.4, 0, aSway.yaw * 0.6 )
		
		if ( cmod3 >= 0 ) then
			core.size = core_hscale * math.Clamp( ( cmod3 / 100 ), 0, 1 )
		end
		
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			sight_oheat.pos = LerpVector( frametime * 4, sight_oheat.pos, sight_overheat )
			sight_a.pos = LerpVector( frametime * 4, sight_a.pos, sight_ammo )
			
			sight_oheat.color.a = Lerp( frametime * 6, sight_oheat.color.a, 220 )
			sight_oheat_content.color.a = Lerp( frametime * 4, sight_oheat_content.color.a, 40 )
			sight_a.color.a = Lerp( frametime * 6, sight_a.color.a, 220 )
			sight_a_content.color.a = Lerp( frametime * 4, sight_a_content.color.a, 40 )
			sight_lbrace.color.a = Lerp( frametime * 8, sight_lbrace.color.a, 60 )
			sight_rbrace.color.a = Lerp( frametime * 2, sight_rbrace.color.a, 60 )
			sight_ring_1.color.a = Lerp( frametime * 8, sight_ring_1.color.a, 220 )
			sight_ring_2.color.a = Lerp( frametime * 6, sight_ring_2.color.a, 220 )
			sight_chair.color.a = Lerp( frametime * 4, sight_chair.color.a, 220 )
			snipercore_1.color.a = Lerp( frametime * 12, snipercore_1.color.a, 255 )
			snipercore_2.color.a = Lerp( frametime * 12, snipercore_2.color.a, 255 )
			snipercore_3.color.a = Lerp( frametime * 12, snipercore_3.color.a, 255 )
			
		--	snipercore_1.pos = barrel_2_hpos + Vector( 0, 0, -sine2 - ( cmod / 4 ) )
			self.VElements[ "7" ].pos = LerpVector( frametime * 4, self.VElements[ "7" ].pos, lsight_adspos )
			self.VElements[ "7" ].angle = LerpAngle( frametime * 6, self.VElements[ "7" ].angle, lsight_adsang + SwayActual )
			self.VElements[ "7+" ].pos = LerpVector( frametime * 4, self.VElements[ "7+" ].pos, rsight_adspos )
			self.VElements[ "7+" ].angle = LerpAngle( frametime * 6, self.VElements[ "7+" ].angle, rsight_adsang + SwayActual )
			self.VElements[ "2+" ].pos = LerpVector( frametime * 4, self.VElements[ "2+" ].pos, stock_adspos )
			self.VElements[ "2+" ].angle = LerpAngle( frametime * 4, self.VElements[ "2+" ].angle, stock_hang + SwayActual )
			self.VElements[ "6" ].pos = LerpVector( frametime * 4, self.VElements[ "6" ].pos, rail_adspos )
			
			rlbar.pos = LerpVector( frametime * 8, rlbar.pos, rlbar_adspos )
			llbar.pos = LerpVector( frametime * 8, llbar.pos, llbar_adspos )
			lubar.pos = LerpVector( frametime * 8, lubar.pos, lubar_adspos )
			rubar.pos = LerpVector( frametime * 8, rubar.pos, rubar_adspos )	
			
			local tr = self.Owner:GetEyeTrace()
			
			if ( cmod3 > 0 ) then
				sight_oheat_content.color = sight_color_ammo_idle
			else
				sight_oheat_content.color = sight_color_ammo_negative
			end
			
			if ( tr.Entity && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) ) then
				if ( tr.HitGroup == HITGROUP_HEAD ) then
					sight_lbrace.color = sight_color_tarlock_headshot
					sight_rbrace.color = sight_color_tarlock_headshot
				else
					sight_lbrace.color = sight_color_tarlock_default
					sight_rbrace.color = sight_color_tarlock_default
				end
			else
				sight_lbrace.color = sight_color_idle
				sight_rbrace.color = sight_color_idle
			end
		
			sight_oheat_content.size = Vector( 0.003, 0.003, 0.001 ) * math.Clamp( ( cmod3 / 100 ), 0, 1 )
			sight_a_content.size = Vector( 0.003, 0.003, 0.001 ) * ( cmod * 1.7 )
		else
			if ( nextanim > gametime ) then
				sight_oheat.pos = LerpVector( frametime * 4, sight_oheat.pos, sight_point )
				sight_a.pos = LerpVector( frametime * 4, sight_a.pos, sight_point )
				
				sight_oheat.color.a = Lerp( frametime * 8, sight_oheat.color.a, 0 )
				sight_oheat_content.color.a = Lerp( frametime * 8, sight_oheat_content.color.a, 0 )
				sight_a.color.a = Lerp( frametime * 8, sight_a.color.a, 0 )
				sight_a_content.color.a = Lerp( frametime * 8, sight_a_content.color.a, 0 )
				sight_lbrace.color.a = Lerp( frametime * 8, sight_lbrace.color.a, 0 )
				sight_rbrace.color.a = Lerp( frametime * 8, sight_rbrace.color.a, 0 )
				sight_ring_1.color.a = Lerp( frametime * 8, sight_ring_1.color.a, 0 )
				sight_ring_2.color.a = Lerp( frametime * 8, sight_ring_2.color.a, 0 )
				sight_chair.color.a = Lerp( frametime * 8, sight_chair.color.a, 0 )
				snipercore_1.color.a = Lerp( frametime * 2, snipercore_1.color.a, 0 )
				snipercore_2.color.a = Lerp( frametime * 2, snipercore_2.color.a, 0 )
				snipercore_3.color.a = Lerp( frametime * 2, snipercore_3.color.a, 0 )
				
			--	snipercore_1.pos = barrel_2_hpos + Vector( 0, 0, -sine2 - cmod )
				self.VElements[ "7" ].pos = LerpVector( frametime * 2, self.VElements[ "7" ].pos, lsight_hpos )
				self.VElements[ "7" ].angle = LerpAngle( frametime * 6, self.VElements[ "7" ].angle, lsight_hang + SwayActual )
				self.VElements[ "7+" ].pos = LerpVector( frametime * 2, self.VElements[ "7+" ].pos, rsight_hpos )
				self.VElements[ "7+" ].angle = LerpAngle( frametime * 6, self.VElements[ "7+" ].angle, rsight_hang + SwayActual )
				self.VElements[ "2+" ].pos = LerpVector( frametime * 6, self.VElements[ "2+" ].pos, stock_hpos + Vector( sine0, sine1 - cmod, sine2 ) )
				self.VElements[ "2+" ].angle = LerpAngle( frametime * 6, self.VElements[ "2+" ].angle, stock_hang + SwayActual )
				self.VElements[ "6" ].pos = LerpVector( frametime * 6, self.VElements[ "6" ].pos, rail_hpos )
				
				rlbar.pos = LerpVector( frametime * 2, rlbar.pos, rlbar_hpos + Vector( sine1 + cmod, -sine0 - cmod, sine2 ) )
				llbar.pos = LerpVector( frametime * 2, llbar.pos, llbar_hpos + Vector( sine0 - cmod, sine1 + cmod, -sine2 ) )
				lubar.pos = LerpVector( frametime * 2, lubar.pos, lubar_hpos + Vector( sine0 - cmod, sine1 + cmod, -sine2 ) )
				rubar.pos = LerpVector( frametime * 2, rubar.pos, rubar_hpos + Vector( sine1 + cmod, -sine0 - cmod, sine2 ) )
			else
				sight_oheat.color.a = 0
				sight_oheat_content.color.a = 0
				sight_a.color.a = 0
				sight_a_content.color.a = 0
				sight_lbrace.color.a = 0
				sight_rbrace.color.a = 0
				sight_ring_1.color.a = 0
				sight_ring_2.color.a = 0
				sight_chair.color.a = 0
				snipercore_1.color.a = 0
				snipercore_2.color.a = 0
				snipercore_3.color.a = 0
				
				rlbar.pos = rlbar_hpos + Vector( sine1 - cmod, -sine0 - cmod, -sine2 )
				llbar.pos = llbar_hpos + Vector( sine0 - cmod, sine1 + cmod, -sine2 )
				lubar.pos = lubar_hpos + Vector( sine0 - cmod, sine1 + cmod, sine2 )
				rubar.pos = rubar_hpos + Vector( sine1 + cmod, -sine0 - cmod, sine2 )
				
				self.VElements[ "7" ].pos = lsight_hpos
				self.VElements[ "7" ].angle = lsight_hang
				self.VElements[ "7+" ].pos = rsight_hpos
				self.VElements[ "7+" ].angle = rsight_hang
			end
		end
		
		local pOwnerEA = self.Owner:EyeAngles()
		local lightorigin = self:GetProjectileSpawnPos() + pOwnerEA:Forward() * 24 + pOwnerEA:Up() * 4
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			lightorigin = self.Owner:GetShootPos() + pOwnerEA:Forward() * 32 + pOwnerEA:Up() * -12
		end
		
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = lightorigin
			dlight.r = core_color_default.r
			dlight.g = core_color_default.g
			dlight.b = core_color_default.b
			dlight.brightness = 1 * cmod
			dlight.Decay = 2048
			dlight.Size = 0.6 * cmod3 + 128 * cmod
			dlight.Style = 1				
			dlight.DieTime = gametime + 1
			dlight.noworld = false
			dlight.nomodel = false
		end

		if ( fCharge >= self.ChargeOverheat ) then
			mymat:SetVector( "$selfillumtint", Vector( 1, 1, 1 ) + ( Vector( 2.4, 0.44, 0.12 ) * cmod2 ) )
			dlight.brightness = 1 + cmod
			core_color_default.r = Lerp( frametime * 8, core_color_default.r, 255 )
			core_color_default.g = 190
		else
			mymat:SetVector( "$selfillumtint", bone_color_default )
			core_color_default.r = Lerp( frametime * 8, core_color_default.r, 190 )
			core_color_default.g = 215
		end

		local scale = 0.02 + 0.5 * ( fCharge / self.ChargeMax )
		matCore:SetFloat( "$FleshBorderWidth", scale )
	end
	
	if ( self:GetNextPrimaryFire() < gametime ) then
		if ( fCharge > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:Deploy() 

	self:SetAds( false, false )
	self:SetCharge( 0 )	
	self.ScifiRegenNext = CurTime() + 1
	
	return true
	
end

function SWEP:Holster( wep )
	
	if ( CLIENT ) && ( IsValid(self.Owner) ) && ( self.Owner:IsPlayer() ) then
		self:ResetBonePositions()
		self:ResetAnimationScale()
	end
	
	mymat:SetVector( "$selfillumtint", bone_color_default )
	
	self:ResetDeployment()
	self:SetSciFiACC( 4 )
	
	return true

end

function SWEP:OnAds( bAds )
	
	if ( bAds ) then
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		
		self.DefaultSwayScale = 0
		self.DefaultBobScale = 0
	else
		-- self:SendWeaponAnim( ACT_VM_IDLE )
		
		self:SetNextCoreFxAnim( CurTime() + 2 )
		
		self.DefaultSwayScale = 1.2
		self.DefaultBobScale = 1.6
	end

end

function SWEP:GetHwProjectileSpeed()

	if ( SERVER ) then
		local speed = 0
	
		if ( self.Owner:IsPlayer() ) then
			local tr = self.Owner:GetEyeTrace()
			if ( self.Owner:EyePos():Distance( tr.HitPos ) <= 512 ) then
				speed = 65536
			else
				speed = 262144
			end
		else
			speed = 262144
		end

		return speed 
	end
	
end

function SWEP:DefaultAttack()
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	
	local fCharge = self:GetCharge()
	
	if ( fCharge >= 130 ) then
		self:EmitSound( "scifi.ancient.overheat" )
		
		self:SetNextPrimaryFire( CurTime() + 0.4 )
		return
	else
		self:SetNextPrimaryFire( CurTime() + 0.16 )
		self.ScifiRegenNext = CurTime() + 1
	end
	
	local cmdDamage = GetConVar( "sfw_damageamp" ):GetFloat()

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	if ( self.Owner:IsNPC() ) then
		pOwnerAV = self.NPCAimVectorOverride
	end
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
	
	if ( SERVER ) then
		local ent = ents.Create( "astra_pfire" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local spread = self:GetProjectileSpreadVector()
		local speed = self:GetHwProjectileSpeed()
		
		local mins = Vector( -24, -24, -24 )
		local maxs = Vector( 24, 24, 24 )
		local tr = util.TraceHull( {
			start = pOwnerSP,
			endpos = pOwnerSP + pOwnerAV * 8192 + spread * ( self:GetSciFiACC() * 2 ) ,
			filter = function( ent ) if ( IsValid( ent ) && ( ent:IsNPC() || ( ent:IsPlayer() && ent ~= self.Owner ) ) && ( ent:GetClass() ~= "astra_pfire" ) ) then return true end end,
			mins = mins,
			maxs = maxs,
			mask = MASK_SHOT_HULL,
			ignoreworld = true
		} )

		ent:SetNWEntity( "target", tr.Entity )
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * speed + spread * ( speed / 2048 + self:GetSciFiACC() * 8 ) )
	end
	
	self:DoMuzzleEffect()

	local iPitchOffset = self:GetCharge()
	if ( iPitchOffset > 75 ) then
		local vol = ( iPitchOffset - 75 ) / 50
		vol = math.min( vol, 1 )

		local iPitchMin, iPitchMax = 98, 100
		iPitchMin, iPitchMax = iPitchMin + iPitchOffset, iPitchMax + iPitchOffset

		local pitch = math.random( iPitchMin, iPitchMax )
		pitch = math.max( pitch * 0.5, 90 )
		
		self:EmitSound( snd_unstable, 50, pitch, vol, CHAN_STATIC )
	end

	self:EmitSound( "scifi.astra.lightfire" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
		local drain = math.Clamp( self:Clip1(), 0, 8 )
		local delay = math.min( 0.8 / ( drain * 0.1 ), 1.6 )
		
		self.Owner:ViewPunch( Angle( math.random( -0.4, -0.6 ), math.random( 0, 0.02 ), math.random( 0.01, 0.02 ) ) * ( 0.5 + self:GetSciFiACC() * 0.1 ) )
		
		self:TakePrimaryAmmo( drain )
		self:AddSciFiACC( 8 )
		
		self.ScifiRegenNext = CurTime() + delay
	end
	
	if ( self:WaterLevel() < 3 ) then
		self:SetCharge( fCharge + self.ChargeAdd )
	end
	
end

function SWEP:ChargedAttack()
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	
	local fCharge = self:GetCharge()

	if ( fCharge >= 120 ) then
		self:SetNextPrimaryFire( CurTime() + 0.4 )
		self.ScifiRegenNext = CurTime() + 2
		self:EmitSound( "scifi.ancient.overheat" )
		return
	else
		self:SetNextPrimaryFire( CurTime() + 0.2 )
	end

	local cmdDamage = GetConVar( "sfw_damageamp" ):GetFloat()

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	if ( self.Owner:IsNPC() ) then
		pOwnerAV = self.NPCAimVectorOverride
		self:SetNextPrimaryFire( CurTime() + 1.2 )
	end
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
		
	local aEyes = self.Owner:EyeAngles()
	local vForward, vRight, vUp = aEyes:Forward(), aEyes:Right(), aEyes:Up()
	local nBoxWidth, nBoxLength = 0.8, 36000

	local vBoxMin = vUp * nBoxWidth - vRight * nBoxWidth
	local vBoxMax = vUp * nBoxWidth + vRight * nBoxWidth
	
	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 0
	ptru.HullSize = nBoxWidth * 2
	ptru.TracerName = "astra_beam_noattach"
	ptru.Damage = 24 * cmdDamage
	ptru.Callback = function( hAttacker, tBulletTrace, dmgInfo )
		local iDmgType = DMG_GENERIC -- bit.bor( DMG_CLUB, DMG_SLASH, DMG_AIRBOAT, DMG_GENERIC )

		dmgInfo:SetDamageType( iDmgType )
						
		if ( tBulletTrace.HitGroup == HITGROUP_HEAD ) then
			dmgInfo:SetDamage( dmgInfo:GetDamage() * 2 )
		end
		
		if ( tBulletTrace.HitGroup == HITGROUP_CHEST ) then
			dmgInfo:SetDamage( dmgInfo:GetDamage() * 1.5 )
		end

		if ( SERVER ) then
			util.ScreenShake( tBulletTrace.HitPos, 8, 4, 0.25, 48 )
		end

		ParticleEffect( "astra_hit_heavy", tBulletTrace.HitPos, tBulletTrace.Normal:Angle() )
	-- PrintTable( tBulletTrace )
	end

	local bullet = {}
	bullet.Num = 1
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV + Vector( 0, 0, 0.001 ) * self:GetSciFiACC()
	bullet.Tracer = 0
	bullet.HullSize = nBoxWidth * 2
	bullet.TracerName = "astra_beam"
	bullet.Damage = 0 * cmdDamage
	bullet.Force = 1
	bullet.Spread = Vector( 0, 0 )
	bullet.Callback = function( hAttacker, tBulletTrace, dmgInfo )
		if ( self:GetOwner():IsNPC() ) then
			dmgInfo:SetDamage( 24 )
			dmgInfo:SetAttacker( self:GetOwner() )
			dmgInfo:SetInflictor( self )
			
			local iDmgType = DMG_GENERIC

			dmgInfo:SetDamageType( iDmgType )
							
			if ( tBulletTrace.HitGroup == HITGROUP_HEAD ) then
				dmgInfo:SetDamage( dmgInfo:GetDamage() * 2 )
			end
			
			if ( tBulletTrace.HitGroup == HITGROUP_CHEST ) then
				dmgInfo:SetDamage( dmgInfo:GetDamage() * 1.5 )
			end
		else
			dmgInfo:SetAttacker( Entity( 0 ) )
		end

		if ( game.SinglePlayer() ) || ( SERVER && !game.SinglePlayer() ) then
			util.ScreenShake( tBulletTrace.HitPos, 8, 4, 0.25, 48 )
		end

		ParticleEffect( "astra_hit_heavy", tBulletTrace.HitPos, tBulletTrace.Normal:Angle() )
	-- PrintTable( tBulletTrace )
	end
	
	vForward = bullet.Dir
	
	local tTargets = ents.FindAlongRay( self.Owner:GetShootPos(), self.Owner:GetShootPos() + vForward * nBoxLength, vBoxMin, vBoxMax )

	for index, entTarget in pairs( tTargets ) do
		if ( !IsValid( entTarget ) ) then continue end
		-- if ( !IsValid( entTarget:GetPhysicsObject() ) ) then print( "@sfw_astra", "skipping", entTarget, "because of their invalid physics object" ) continue end
		if ( entTarget:IsWorld() ) then continue end
		if !( entTarget:IsPlayer() || entTarget:IsNPC() ) then continue end
		if ( entTarget == self.Owner ) then continue end
		
		ptru.Src = pOwnerSP + bullet.Dir * entTarget:EyePos():Distance( pOwnerSP ) - bullet.Dir * 16
		ptru.Dir = bullet.Dir
		self.Owner:FireBullets( ptru, false )

		debugoverlay.Cross( ptru.Src, 16, 4, Color( 255, 128, 0 ), true )
		debugoverlay.Cross( ptru.Src + ptru.Dir * 12, 16, 4, Color( 0, 128, 255 ), true )
		debugoverlay.Line( ptru.Src, ptru.Src + ptru.Dir * 12, 4, Color( 128, 255, 128 ), true )
		
		DevMsg( entTarget )
	end

	local vTracerDestination = pOwnerSP + bullet.Dir * nBoxLength
	local vCorrect
	
	local fScale = 1
	local flt = 1
	local a = 100
	
	local fMax = 16384
	for i=1, 6 do
		local dir = 1
		local iPlaneCoord = i
		
		if ( i > 3 ) then
			dir = -1
			iPlaneCoord = iPlaneCoord - 3
		end
		
		local vPlaneNormal = Vector( 0, 0, 0 )
		vPlaneNormal[ iPlaneCoord ] = 1
		vPlaneNormal = vPlaneNormal * dir
		
		local vBoxSize = Vector( fMax, fMax, fMax )
		vBoxSize[ iPlaneCoord ] = 1
		vBoxSize = vBoxSize * fScale
		
		local vIntersect = util.IntersectRayWithPlane( self.Owner:GetShootPos(), self.Owner:GetAimVector(), vPlaneNormal * fMax * fScale, vPlaneNormal )

		if ( vIntersect ) then
			debugoverlay.Cross( vIntersect, 16, flt, color_white, true )
			
			if ( vIntersect:Distance( Vector( 0, 0, 0 ) ) <= fMax * fScale * 1.4142 ) then
				debugoverlay.Box( Vector( 0, 0, 0 ) + vPlaneNormal * fMax * fScale * 0.95, vBoxSize * -1, vBoxSize, flt, Color( 255, 0, 0, a ), true )
				
				vCorrect = vIntersect
			else
				debugoverlay.Box( Vector( 0, 0, 0 ) + vPlaneNormal * fMax * fScale * 0.975, vBoxSize * -1, vBoxSize, flt, Color( 255, 128, 0, a ), true )
			end
		else
			debugoverlay.Box( Vector( 0, 0, 0 ) + vPlaneNormal * fMax * fScale * 0.99, vBoxSize * -1, vBoxSize, flt, Color( 0, 128, 255, a ), true )
		end
	end
	
	debugoverlay.Cross( Vector( 0, 0, 0 ), fMax * fScale, FrameTime(), color_white, true )

	if ( vCorrect ) then
		vTracerDestination = vCorrect
	end

	local fxData = EffectData()
	fxData:SetEntity( self )
	fxData:SetAttachment( 1 )
	fxData:SetFlags( 0x0002 )
	fxData:SetOrigin( vTracerDestination )
	util.Effect( "astra_beam", fxData ) --, true, true )

	ParticleEffectAttach( "astra_muzzle_heavy", PATTACH_POINT_FOLLOW, vmEntity, vmAttachMuzzle )
	
	if ( SERVER ) && ( cmd_heat == 1 ) && ( self:GetSciFiACC() >= 20 ) then
		ParticleEffectAttach( "nrg_heat", 4, vmEntity, vmAttachMuzzle )
	end
	
	self.Owner:FireBullets( bullet, false )
	
	self:DrawMuzzleLight( "200 170 255 220", 140, 720, 0.075 )

	local iPitchOffset = self:GetCharge()
	if ( iPitchOffset > 75 ) then
		local vol = ( iPitchOffset - 75 ) / 50
		vol = math.min( vol, 1 )

		local iPitchMin, iPitchMax = 98, 100
		iPitchMin, iPitchMax = iPitchMin + iPitchOffset, iPitchMax + iPitchOffset

		local pitch = math.random( iPitchMin, iPitchMax )
		pitch = math.max( pitch * 0.5, 90 )
		
		self:EmitSound( snd_unstable, 50, pitch, vol, CHAN_STATIC )
	end

	self:EmitSound( "scifi.astra.heavyfire" )
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
		local drain = math.Clamp( self:Clip1(), 0, 32 )
		local delay = math.min( 3.2 / ( drain * 0.1 ), 3 )
		
		self.Owner:ViewPunch( Angle( math.random( -2, -2.4 ), math.random( 0, 0.02 ), math.random( 0.01, 0.02 ) ) * ( 0.5 + self:GetSciFiACC() * 0.1 ) )
		
		self:TakePrimaryAmmo( drain )
		self:AddSciFiACC( 16 )
		
		self.ScifiRegenNext = CurTime() + delay
		
		if ( self:WaterLevel() < 3 ) then
			self:SetCharge( fCharge + self.ChargeAdd * 3 )
		end
	end
	
end

function SWEP:PrimaryAttack()
	
	if ( self.Owner:IsPlayer() ) then
		local IsAds = ( self.SciFiState == SCIFI_STATE_ADS )

		if ( IsAds ) then
			self:ChargedAttack()
		else
			self:DefaultAttack()
		end
	else
		self:SetCharge( 30 )
		
		local pTarget = self.Owner:GetEnemy()

		if ( !pTarget || pTarget == NULL ) then
			self:DefaultAttack()
			return
		end
		
		local fTarDist = self.Owner:GetPos():Distance( pTarget:GetPos() )
	
		if ( fTarDist > 600 ) then
			self:ChargedAttack()
			-- self:SetNextPrimaryFire( CurTime() + 2 )
		else
			self:DefaultAttack()
		end
	end

end

-- function SWEP:SecondaryAttack()

-- end

-- function SWEP:Reload()
	
-- end

-- function SWEP:DoImpactEffect( tr, nDamageType )

	-- if ( tr.HitSky ) then return end

	-- if ( CLIENT ) then
		-- local dlight = DynamicLight( self:EntIndex() )
		-- if ( dlight ) then
			-- dlight.pos = tr.HitPos
			-- dlight.r = 190
			-- dlight.g = 205
			-- dlight.b = 255
			-- dlight.brightness = 2
			-- dlight.Decay = 1024
			-- dlight.Size = 256
			-- dlight.DieTime = CurTime() + 1
		-- end
		
		-- ParticleEffect( "astra_hit_heavy", tr.HitPos, tr.Normal:Angle() )
	-- end
	
	-- return true

-- end