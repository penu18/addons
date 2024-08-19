AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "This sniper rifle releases a powerful energy blast upon charged. BOOM!"
SWEP.Instructions			= "Hold 'mouse1' to charge. Release 'mouse1' to fire. Zoom by pressing 'mouse2'. Press Use (def. 'E') + Mouse2 to change the firemode."
SWEP.ItemRank 				= 28

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.DeploySpeed 			= 3.4
SWEP.SciFiSkin				= "/models/weapons/pulsar/skin_alphatest.vmt"
SWEP.SciFiSkin_1			= "/models/weapons/pulsar/vapor_core.vmt"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_edit.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_pulsar.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "SciFiEnergy"

SWEP.VfxMuzzleParticle 		= "pulsar_charge"
SWEP.VfxMuzzleColor 		= Color( 0, 80, 255, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 120
SWEP.VfxMuzzleFarZ 			= 720

SWEP.PrintName				= "ALX-V1 'Pulsar' sniper"
SWEP.Slot					= 3
SWEP.SlotPos				= 3

if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 10
	SWEP.AdsBlurSize			= ScrH() / 2
end

SWEP.SciFiFamily			= { "vtec", "enerbow", "hitscanbullets", "ads", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 70, +50", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				   x2", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		75", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Energy, Radiation", color = Color( 120, 255, 220 ) },
	["5"] = { text = "Fire rate: 				 0.8 (semi-auto)", color = Color( 180, 180, 180 ) },
	["5a"] = { text = "Recharge rate: 70", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Alt. Damage: 			12", color = Color( 180, 180, 180 ) },
	["6a"] = { text = "Alt. Crit. mul.: 				  x2", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Alt. Damage type: Shock", color = Color( 60, 80, 255 ) },
	["8"] = { text = "Alt. Fire rate: 			 0.4 (charge)", color = Color( 180, 180, 180 ) },
	["9a"] = { text = "Shots can punch through thin surfaces.", color = Color( 180, 180, 180 ) },
	["9b"] = { text = "Radiation damage bypasses shields.", color = Color( 180, 180, 180 ) },
	["9c"] = { text = "Has to charge up before the actual shot.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "70, 50",
		DamageAmount = 120,
		DamageBlastRadius = 75,
		DamageType = DMG_SF_VAPOR,
		CritMul = 2,
		ChargeRate = 120
	},
	Secondary = {
		DamageAmount = 240,
		DamageBlastRadius = 400,
		DamageType = DMG_SHOCK,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.1 },
		},
	},
	CoreRechargeRate = 120,
	Recoil = 30,
	PerkSet = { SCIFI_PERK_ELEMENTAL_SHOCK, SCIFI_PERK_AMMO_RADIATION, SCIFI_PERK_AMMO_PUNCHTRHOUGH_HEAVY }
}

SWEP.SciFiMeleeASpeed		= 0.8
SWEP.SciFiMeleeRange		= 55
SWEP.SciFiMeleeDamage		= 10
SWEP.SciFiMeleeSound		= "scifi.melee.swing.heavy"

SWEP.AdsPos 				= Vector(-5.992, 9.14, 0.804)
SWEP.AdsAng 				= Vector( 0, 0, 0 ) --Vector(-1.14, 0.6, -4.111)
SWEP.AdsFov					= 27

-- Colors for holographic sight --
local color_visor_default = Color( 20, 220, 255, 120 ) 		-- default, light blue tone
local color_visor_accent = Color(180, 220, 255, 200)		-- more saturated light blue.
local color_visor_idle = Color( 180, 220, 255, 20 ) 		-- more saturated light blue with very low transparency values (used for sprint animation)
local color_visor_sublime = Color( 180, 210, 255, 100 ) 	-- white to very light blue tone (used by distance indicator)
local color_visor_warning = Color( 255, 30, 30, 200 ) 		-- saturated red
local color_visor_error =  Color( 255, 180, 10, 120 )		-- decent yellow

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["barrel_case"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "Base", rel = "", pos = Vector(0.26, -0.15, 17.756), angle = Angle(0, 0, 0), size = Vector(0.021, 0.021, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["barrel_hatch"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/mechanics/wheels/wheel_extruded_48.mdl", bone = "Base", rel = "", pos = Vector(0.26, -0.15, 14.756), angle = Angle(0, 6, 180), size = Vector(0.035, 0.035, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel_interior"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/gears/bevel9.mdl", bone = "Base", rel = "", pos = Vector(0.26, -0.15, 17), angle = Angle(0, 0, 180), size = Vector(0.065, 0.065, 0.35), color = Color(200, 220, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel_to_case"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_fence01a.mdl", bone = "Base", rel = "", pos = Vector(-0.2, -2.95, 19.938), angle = Angle(180, 0, 0), size = Vector(0.115, 0.115, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["vapor_barrel_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_fence01b.mdl", bone = "Base", rel = "", pos = Vector(-0.2, -2.95, 22.938), angle = Angle(0, 180, 0), size = Vector(0.115, 0.115, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["vapor_barrel_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_fence01b.mdl", bone = "Base", rel = "", pos = Vector(-2.13, 2.2, 23.513), angle = Angle(0, -45.161, 0), size = Vector(0.115, 0.115, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["vapor_barrel_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_fence01b.mdl", bone = "Base", rel = "", pos = Vector(2.13, 2.4, 26.379), angle = Angle(0, 45.16, 0), size = Vector(0.115, 0.115, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["case_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/breenwindow.mdl", bone = "Base", rel = "", pos = Vector(-0.9, 0.6, 5), angle = Angle(0, 0, 180), size = Vector(0.025, 0.03, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["case_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Base", rel = "", pos = Vector(0.45, -1, 1), angle = Angle(0, -90, -1), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sight_case_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/miniteleportarc.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.35, 14), angle = Angle(0, -90, 180), size = Vector(0.043, 0.043, 0.535), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["sight_case_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/miniteleportarc.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.35, 7), angle = Angle(0, -90, 0), size = Vector(0.043, 0.043, 0.535), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["sight_base_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/phxtended/bar1x45b.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.07, 5), angle = Angle(0, -90, 90), size = Vector(0.092, 0.22, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sight_base_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/phxtended/bar1x45b.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.07 + 0.55, 5), angle = Angle(0, 90, 90), size = Vector(0.092, 0.22, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["holo_circle_outer_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "Base", rel = "", pos = Vector(0.212, -3.395, 7), angle = Angle(0, 134, 0), size = Vector(0.005, 0.005, 0.001), color = Color(20, 220, 255, 120), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo_circle_outer_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "Base", rel = "", pos = Vector(-0.195, -3.3755, 7), angle = Angle(0, 316, 0), size = Vector(0.005, 0.005, 0.001), color = Color(20, 220, 255, 120), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo_circle_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube4x4x05.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.39, 7), angle = Angle(0, 0, 0), size = Vector(0.001, 0.001, 0.001), color = Color(180, 220, 255, 200), surpresslightning = true, material = "models/spawn_effect2", skin = 0, bodygroup = {} },
	["holo_circle_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube4x4x05.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.39, 16), angle = Angle(0, 180, 0), size = Vector(0.001, 0.001, 0.001), color = Color(180, 220, 255, 200), surpresslightning = true, material = "models/spawn_effect2", skin = 0, bodygroup = {} },
	["holo_point"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.39, 7), angle = Angle(0, 0, 0), size = Vector(0.0001, 0.0001, 0.0001), color = Color(180, 220, 255, 200), surpresslightning = true, material = "models/spawn_effect2", skin = 0, bodygroup = {} },
	["holo_chargeindic"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.39, 7), angle = Angle(0, 0, 0), size = Vector(0.002, 0.002, 0.002), color = Color(100, 220, 255, 32), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo_distindic"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube4x4x05.mdl", bone = "Base", rel = "", pos = Vector(0.01, -3.39, 15), angle = Angle(0, 0, 0), size = Vector(0.001, 0.001, 0.001), color = Color(180, 210, 255, 100), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["core_chargefx"] = { type = SCIFI_SCK_TYPE_SPRITE, sprite = "effects/phaz_vapor", bone = "Base", rel = "", pos = Vector(0.26, -0.15, 17), size = { x = 1, y = 1 }, color = Color(180, 220, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["core"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "Base", rel = "", pos = Vector(0, 1.146, 4.013), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.4, 0.1, -3.2), angle = Angle(0, -90, -103), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["barrel_case"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "Base", rel = "parent", pos = Vector(0.26, -0.15, 17.756), angle = Angle(0, 0, 0), size = Vector(0.021, 0.021, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["barrel_hatch"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/mechanics/wheels/wheel_extruded_48.mdl", bone = "Base", rel = "parent", pos = Vector(0.26, -0.15, 14.756), angle = Angle(0, 6, 180), size = Vector(0.035, 0.035, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel_interior"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/gears/bevel9.mdl", bone = "Base", rel = "parent", pos = Vector(0.26, -0.15, 17), angle = Angle(0, 0, 180), size = Vector(0.065, 0.065, 0.35), color = Color(200, 220, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel_to_case"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_fence01a.mdl", bone = "Base", rel = "parent", pos = Vector(-0.2, -2.95, 19.938), angle = Angle(180, 0, 0), size = Vector(0.115, 0.115, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["vapor_barrel_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_fence01b.mdl", bone = "Base", rel = "parent", pos = Vector(-0.2, -2.95, 22.938), angle = Angle(0, 180, 0), size = Vector(0.115, 0.115, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["vapor_barrel_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_fence01b.mdl", bone = "Base", rel = "parent", pos = Vector(-2.13, 2.2, 23.513), angle = Angle(0, -45.161, 0), size = Vector(0.115, 0.115, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["vapor_barrel_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_fence01b.mdl", bone = "Base", rel = "parent", pos = Vector(2.13, 2.4, 23.379), angle = Angle(0, 45.16, 0), size = Vector(0.115, 0.115, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["case_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/breenwindow.mdl", bone = "Base", rel = "parent", pos = Vector(-0.9, 0.6, 5), angle = Angle(0, 0, 180), size = Vector(0.025, 0.03, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["case_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Base", rel = "parent", pos = Vector(0.45, -1, 1), angle = Angle(0, -90, -1), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sight_case_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/miniteleportarc.mdl", bone = "Base", rel = "parent", pos = Vector(0.01, -3.35, 14), angle = Angle(0, -90, 180), size = Vector(0.043, 0.043, 0.535), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["sight_case_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/miniteleportarc.mdl", bone = "Base", rel = "parent", pos = Vector(0.01, -3.35, 7), angle = Angle(0, -90, 0), size = Vector(0.043, 0.043, 0.535), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["sight_base_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/phxtended/bar1x45b.mdl", bone = "Base", rel = "parent", pos = Vector(0.01, -3.07, 5), angle = Angle(0, -90, 90), size = Vector(0.092, 0.22, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sight_base_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/phxtended/bar1x45b.mdl", bone = "Base", rel = "parent", pos = Vector(0.01, -3.07 + 0.55, 5), angle = Angle(0, 90, 90), size = Vector(0.092, 0.22, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["core"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "Base", rel = "parent", pos = Vector(0, 1.146, 4.013), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:SubInit()

	self.Weapon:SetClip1( 0 )
	self:SetNWBool( "AltFire", false )
	
end

function SWEP:Think()

	if ( self.Owner:GetActiveWeapon() ~= self.Weapon ) then return end
	
	if ( self.Owner:IsPlayer() ) then
	
		self.VElements[ "holo_distindic" ].size = Vector(0.001, 0.001, 0.001) * ( self.Owner:GetShootPos():Distance( self.Owner:GetEyeTrace().HitPos ) / 11200 )	
		self.VElements[ "holo_point" ].size = Vector(0.0001, 0.0001, 0.0001)
		
		if ( self.Owner:GetEyeTrace().Entity:IsNPC() ) or ( self.Owner:GetEyeTrace().Entity:IsPlayer() ) then
			self.VElements[ "holo_point" ].size = Vector(0.0003, 0.0003, 0.0003)
			self.VElements[ "holo_point" ].color = color_visor_warning
			self.VElements[ "holo_circle_outer_0" ].color = color_visor_warning
			self.VElements[ "holo_circle_outer_1" ].color = color_visor_warning
		else
			self.VElements[ "holo_point" ].color = color_visor_sublime
			self.VElements[ "holo_circle_outer_0" ].color = color_visor_default
			self.VElements[ "holo_circle_outer_1" ].color = color_visor_default
		end

		if ( self:GetNWBool( "AltFire" ) == false ) then -- Primary Fire
		
			if ( game.SinglePlayer() && SERVER ) then
				self:PuslarCharge()
			elseif ( !game.SinglePlayer() ) then
				self:PuslarCharge()
			end
			
			self.VElements[ "barrel_case" ].angle = self.VElements[ "barrel_case" ].angle + Angle( 0, self.Weapon:Clip1() / 20, 0 )
			self.VElements[ "barrel_interior" ].angle = self.VElements[ "barrel_interior" ].angle + Angle( 0, self.Weapon:Clip1() / 35, 0 )
			self.VElements[ "holo_chargeindic" ].size = Vector(0.001, 0.001, 0.001) * ( self.Weapon:Clip1() / 50 )
			self.VElements[ "holo_chargeindic" ].color = Color( 255 + ( self.Weapon:Clip1() * -1.55 ), ( self.Weapon:Clip1() * 2.20 ), ( self.Weapon:Clip1() * 2.55 ), 24 )
			self.VElements[ "vapor_barrel_0" ].skin = 0
			self.VElements[ "vapor_barrel_1" ].skin = 0
			self.VElements[ "vapor_barrel_2" ].skin = 0
			self.VElements[ "barrel_to_case" ].skin = 0
			
		end
		
		if ( self:GetNWBool( "AltFire" ) == true ) then -- Secondary Fire
		
			self.VElements[ "core_chargefx" ].size = { x = 1, y = 1 }
			
			if ( self.Weapon:Clip1() < 50 ) then 
				self.Weapon:SetClip1( self.Weapon:Clip1() + 1 ) 
			end
			
			self.VElements[ "holo_point" ].size = Vector(0.0005, 0.0005, 0.0005)
			self.VElements[ "barrel_case" ].angle = self.VElements[ "barrel_case" ].angle + Angle( 0, ( self.Weapon:Clip1() / 40 ) * -1, 0 )
			self.VElements[ "barrel_interior" ].angle = self.VElements[ "barrel_interior" ].angle + Angle( 0, self.Weapon:Clip1() / 80, 0 )
			self.VElements[ "holo_chargeindic" ].size = Vector(0.001, 0.001, 0.001) * ( self.Weapon:Clip1() / 25 )
			self.VElements[ "holo_chargeindic" ].color = Color( 255 + ( self.Weapon:Clip1() * -3.10 ), 100, ( self.Weapon:Clip1() * 2.55 ), 24 )
			self.VElements[ "vapor_barrel_0" ].skin = 1
			self.VElements[ "vapor_barrel_1" ].skin = 1
			self.VElements[ "vapor_barrel_2" ].skin = 1
			self.VElements[ "barrel_to_case" ].skin = 1
			
			if ( self.Owner:WaterLevel() == 3 ) then
				self.VElements[ "holo_circle_outer_0" ].color = color_visor_error
				self.VElements[ "holo_circle_outer_1" ].color = color_visor_error
			else
				self.VElements[ "holo_circle_outer_0" ].color = color_visor_default
				self.VElements[ "holo_circle_outer_1" ].color = color_visor_default
			end
			
		end
		
		if ( self.SciFiState == SCIFI_STATE_SPRINT ) then
		
			self.VElements[ "holo_circle_0" ].size = Vector(0.005, 0.005, 0.01)
			self.VElements[ "holo_circle_1" ].size = Vector(0.005, 0.005, 0.01)
			self.VElements[ "holo_circle_0" ].color = color_visor_idle
			self.VElements[ "holo_circle_1" ].color = color_visor_idle
			
		else
		
			self.VElements[ "holo_circle_0" ].size = Vector(0.001, 0.001, 0.001)
			self.VElements[ "holo_circle_1" ].size = Vector(0.001, 0.001, 0.001)
			self.VElements[ "holo_circle_0" ].color = color_visor_accent
			self.VElements[ "holo_circle_1" ].color = color_visor_accent
			
		end
		
		if ( self.Weapon:Clip1() < 0 ) then
			self.Weapon:SetClip1( 0 )
			DevMsg( "@sfw_pulsar : !Error; Force ammo reset" )
		end
		
		self:Ads()
		self:Anims()
		self:SciFiMath()
		self:SciFiMelee()
	
	end

end

function SWEP:PuslarCharge()

	local viewmodel = self:GetViewModelEnt()

	if ( self.Weapon:Clip1() < 100 and self.Owner:KeyDown( IN_ATTACK ) == true ) then 
			self.Weapon:SetClip1( self.Weapon:Clip1() + 2 )
		else
	end 
	
	if self.Owner:KeyReleased(IN_ATTACK) and ( self.Weapon:Clip1() >= 100 ) then
		if ( !self:CanPrimaryAttack() ) then return end
		if ( self:GetNWInt( "NextPulse" ) > CurTime() ) then return end
		if ( self.Owner:KeyDown( IN_RELOAD ) ) then
			self:SetCharge( 0 )
			self:SetClip1( 0 )
			
			ParticleEffectAttach( "pulsar_charge_fail", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
			self:EmitSound( "scifi.pulsar.charge.decrease" )
			return
		end
		
		self:Pulse() 
	end
	
	if ( self.Owner:KeyReleased( IN_ATTACK ) ) and ( self.Weapon:Clip1() > 0 ) and ( self.Weapon:Clip1() < 100 ) then
		ParticleEffectAttach( "pulsar_charge_fail", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.pulsar.charge.decrease" )
	end
	
	if ( self.Owner:KeyDown( IN_ATTACK ) == false ) and ( self.Weapon:Clip1() > 0 ) and ( self.Weapon:Clip1() < 100 ) then
		self.Weapon:SetClip1( self.Weapon:Clip1() - 1 ) 
	end

end

function SWEP:Pulse( amp )

	self:SetNWInt( "NextPulse", CurTime() + 1 )
--[[
	local vmEntity = self.Owner:GetViewModel()
	local vmAttach = vmEntity:LookupAttachment( "muzzle" )
	
	local pOwnerSP = self.Owner:GetShootPos()
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerEA = self.Owner:EyeAngles()
	local fw, rt, up = pOwnerEA:Forward(), pOwnerEA:Right(), pOwnerEA:Up()

	local fScale = 1
	local vHullMin = pOwnerSP + ( rt * fScale + up * fScale )
	local vHullMax = pOwnerSP + pOwnerAV * 8192 + ( rt * fScale + up * fScale )
	
	local tIndex = ents.FindInCone( pOwnerSP, pOwnerAV, 8192, 0 ) --ents.FindInBox( vHullMin, vHullMax )

	local amp = GetConVar( "sfw_damageamp" ):GetFloat()
	local iDmgBase = 72 * amp
	
	for k,v in pairs( tIndex ) do
	--	if ( k > 32 ) then continue end
		if ( v == self.Owner ) || ( v:GetOwner() == self.Owner ) then continue end
		if ( !isnumber( v:Health() ) ) then continue end
		
		local vOrigin = v:GetPos()
		local fFalloff = vOrigin:Distance( vHullMin ) / 256
		local iDmg = math.max( iDmgBase - fFalloff, 8 )
		
		local dmgInfo = DamageInfo()
		dmgInfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_AIRBOAT ) )
		dmgInfo:SetDamage( iDmg )
		dmgInfo:SetDamageForce( pOwnerAV * iDmg * 512 )
		dmgInfo:SetAttacker( self.Owner )
		dmgInfo:SetInflictor( self )
		
		v:TakeDamageInfo( dmgInfo )
		
		self:DealAoeDamage( DMG_RADIATION, iDmg * 0.75, vOrigin, 128 - fFalloff )
		
		if ( CLIENT ) then
			local dlight = DynamicLight( v:EntIndex() * -1 )
			if ( dlight ) then
				dlight.pos = vOrigin
				dlight.r = 140
				dlight.g = 140
				dlight.b = 255
				dlight.brightness = 2
				dlight.Decay = 2048
				dlight.Size = 256
				dlight.DieTime = CurTime() + 0.5
			end
		end
		print( v, iDmg, fFalloff )
		ParticleEffect( "pulsar_hit_weak", vOrigin, Angle( 0, 0, 0 ), self )
	end

	local fx = EffectData()
	fx:SetOrigin( pOwnerAV + fw * 8192 )
	fx:SetStart( vmEntity:GetAttachment( 1 ).Pos )
	fx:SetAttachment( vmAttach )
	fx:SetEntity( vmEntity )
--	fx:SetFlags( TRACER_FLAG_USEATTACHMENT )
	util.Effect( "pulsar_tracer", fx )
]]--
	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( !self:CanPrimaryAttack() ) then return end
	self.Weapon:SetClip1( 0 )
	self:EmitSound( "scifi.pulsar.fire" )
	
	if ( GetConVarNumber( "sfw_sk_pulsar_echosnd" ) == 1 ) then
	self:EmitSound( "scifi.pulsar.echo" )
	end
	
	local viewmodel = self:GetViewModelEnt()
	local tarpos = self.Owner:GetEyeTrace().HitPos
	
	local beam = {}
	beam.Num = 1
	beam.Src = self.Owner:GetShootPos()
	beam.Dir = self.Owner:GetAimVector()
	beam.Tracer = 1
	beam.HullSize = 12
	beam.Force = 30
	beam.Damage = 72 * amp
	beam.AmmoType = "AR2"
	beam.TracerName = "pulsar_tracer"
	beam.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_AIRBOAT ) )
	end
		
	self.Owner:FireBullets( beam, false )
	self:DealAoeDamage( bit.bor( DMG_ENERGYBEAM, DMG_RADIATION ), 50 * amp, tarpos, 75 )
	
	-- fake punch-through
	local beam2 = {}
	beam2.Num = 1
	beam2.Src = tarpos + self.Owner:GetAimVector() * 20
	beam2.Dir = self.Owner:GetAimVector()
	beam2.Tracer = 1
	beam2.HullSize = 12
	beam2.Force = 30
	beam2.Damage = 72 * amp
	beam2.AmmoType = "AR2"
	beam2.TracerName = "pulsar_tracer_noattach"
	beam2.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_AIRBOAT ) )
	end
	
	self.Owner:FireBullets( beam2, false )
	
	if ( SERVER ) then
	
		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then	

			local fx2 = ents.Create( "light_dynamic" )
			fx2:SetKeyValue( "_light", "20 80 255 255" )
			fx2:SetKeyValue( "spotlight_radius", 120 )
			fx2:SetKeyValue( "distance", 210 )
			fx2:SetKeyValue( "brightness", 3 )
			fx2:SetPos( tarpos )
			fx2:Spawn()
			fx2:Fire( "kill", "", 0.115 )
			fx2:EmitSound( "weapons/pulsar/pulsar_hit.wav" )
			
			if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) and ( self:GetSciFiACC() >= ( GetConVarNumber( "sfw_sk_maxacc" ) * 0.82 ) ) then
				ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
			end
		
		end

	end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	ParticleEffectAttach( "pulsar_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	
	self.Owner:ViewPunch( Angle( math.random( -0.4, -2.4 ), math.random( 0, 0.15 ), math.random( 0, 0.15 ) ) )
	
	self:AddSciFiACC( 30 )

end

function SWEP:NPCPulse( amp )

	local amp = GetConVarNumber( "sfw_damageamp" )

	self:EmitSound( "scifi.pulsar.fire" )

	if ( CLIENT ) then return end 	
	local viewmodel = self:GetViewModelEnt()
	local tarpos = self.Owner:GetActiveWeapon():GetAngles():Forward() * 100000
	
	local beam = {}
	beam.Num = 1
	beam.Src = self.Owner:GetShootPos()
	beam.Dir = self.Owner:GetAimVector()
	beam.Tracer = 1
	beam.Force = 1
	beam.Damage = 72
	beam.AmmoType = "AR2"
	beam.TracerName = "pulsar_tracer"
	
	self.Owner:FireBullets( beam, false )

	ParticleEffectAttach( "vapor_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	self:DrawMuzzleLight( "0 80 255 255" , 160, 720, 0.08 )

	if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) then
	ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	end
	
end

function SWEP:CanAltFire()

	if ( self.Weapon:Clip1() < 19 ) then
	return false
	end
	
	if ( self.SciFiState == SCIFI_STATE_SPRINT == true ) then
	return false
	end
	
	return true
	
end

function SWEP:AltFire( amp )

	if (  !self:CanAltFire() ) then return end
	if ( !IsValid( self.Owner ) ) then return end
	
	local viewmodel = self:GetViewModelEnt()
	local tr = self.Owner:GetEyeTrace()
	local amp = GetConVarNumber( "sfw_damageamp" )

	if ( self.Owner:WaterLevel() == 3 ) then
	
		self:EmitSound( "weapons/tbolt/tbolt_fx1.wav" )
		self:DealAoeDamage( DMG_SHOCK, 12 * amp, self:GetPos(), 120 )
			
		if ( GetRelChance( 20 ) ) then
			DoElementalEffect( { Element = EML_SHOCK, Target = self.Owner, Attacker = self.Owner } )
		end
	
	else
	
		self:EmitSound( "scifi.pulsar.altfire" )
		
		local beam = {}
		beam.Num = 1
		beam.Src = self.Owner:GetShootPos()
		beam.Dir = self.Owner:GetAimVector()
		beam.Tracer = 1
		beam.TracerName = "nrg_tracer" 
		beam.Force = 1
		beam.Damage = 12 * amp
		beam.AmmoType = "SciFiAmmo"
		beam.Callback = function( attacker, tr, dmginfo )
			dmginfo:SetDamageType( DMG_SHOCK )
		end	
		
		self.Owner:FireBullets( beam, false )
		
		if ( SERVER ) then

		self:DealAoeDamage( DMG_SHOCK, 6 * amp, tr.HitPos, 75 )
		
		end
	
	end
	
	if ( IsValid( tr.Entity ) ) && ( GetRelChance( 20 ) ) then
		DoElementalEffect( { Element = EML_SHOCK, Target = tr.Entity, Duration = 5, Attacker = self.Owner } )
	end
	
	local viewmodel = self.Owner:GetViewModel()
	ParticleEffectAttach( "vapor_muzzle_evensmaller", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	self:DrawMuzzleLight( "180 210 255 100" , 120, 600, 0.08 )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
	self.Owner:ViewPunch( Angle( -0.4, 0, 0 ) )
	end
	
	self:TakePrimaryAmmo( 18 )
	
	self:AddSciFiACC( 4 )

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	if ( SERVER ) then return end
	
	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
	effectdata:SetNormal( tr.HitNormal )
	
	if ( self:GetNWBool( "AltFire" ) == true ) then
		ParticleEffect( "pulsar_hit_weak", tr.HitPos, Angle( 0, 0, 0 ), self )
		sound.Play( "weapons/tbolt/tbolt_fx2.wav", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
		if ( self.Owner:IsPlayer() ) then
			if ( tr.MatType == MAT_GLASS ) then return end
			local dlight = DynamicLight( self:EntIndex() )
			if ( dlight ) then
				dlight.pos = tr.HitPos
				dlight.r = 140
				dlight.g = 140
				dlight.b = 255
				dlight.brightness = 2
				dlight.Decay = 2048
				dlight.Size = 256
				dlight.DieTime = CurTime() + 0.5
			end
		end
	end

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:PrimaryAttack()

	if ( self:GetNWBool( "AltFire" ) == false ) then --( FireMode == 0 ) then

		if ( self.Owner:IsNPC() ) then
			self:NPCPulse()
			self:SetNextPrimaryFire( CurTime() + 2 )
		end
	
		if ( self.Owner:IsPlayer() ) then
			self.Weapon:SetClip1( 0 )
			if ( self.Owner:KeyDown( IN_ATTACK ) == true ) then
				if ( GetConVarNumber( "sfw_fx_suppressonzoom" ) >= 1 ) then
					if (self.SciFiState ~= SCIFI_STATE_ADS ) then
						self:DoMuzzleEffect()
					end
				else
					self:DoMuzzleEffect()
				end
				self:EmitSound( "scifi.pulsar.charge.increase" )
			end
		end
		self:SetNextPrimaryFire( CurTime() + 1 )
		
	end

	if ( self:GetNWBool( "AltFire" ) == true ) then --( FireMode == 1 ) then

		self:AltFire()
		self:SetNextPrimaryFire( CurTime() + 0.1 )
		
	end

end

function SWEP:CanPrimaryAttack()

	if ( self.Weapon:Clip1() < 99 ) then
	return false
	end

	if ( self.SciFiState == SCIFI_STATE_SPRINT ) then
	return false
	end
	
	return true
	
end

function SWEP:SecondaryAttack()

	local kUse = self.Owner:KeyDown( IN_USE )

	if ( kUse && self:CanSwap() ) then
	
		if( self:GetNWBool( "AltFire" ) == false ) then
			self:SetNWBool( "AltFire", true )
			
			fmchange = 0
			
			timer.Simple( 1, function()
				fmchange = 1
			end )
		elseif( self:GetNWBool( "AltFire" ) == true ) then  
			self:SetNWBool( "AltFire", false )
			
			fmchange = 0
			
			timer.Simple( 1, function()
				fmchange = 1
			end )
		end
	end
	
end

function SWEP:CanSecondaryAttack()

end

function SWEP:Reload()
	
end

function SWEP:CanSwap()

	if ( fmchange == 0 ) then
	return false
	end

	return true

end