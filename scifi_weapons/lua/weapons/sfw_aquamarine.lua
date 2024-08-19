AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

local cmd_heat = GetConVarNumber( "sfw_fx_heat" )

SWEP.Purpose				= "A modified 'Draco' carbine utilizing different technology to unleash a precise and powerfull energy blast with every shot."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to zoom."
SWEP.ItemRank 				= 21

SWEP.PrintName				= "HS46-VP 'Aquamarine' Carbine"
SWEP.Slot					= 2
SWEP.SlotPos				= 2

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.SciFiSkin				= "models/weapons/saphyre/skin"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_vtsteel.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "AR2"

SWEP.VfxMuzzleParticle	 	= "saphyre_muzzle"
SWEP.VfxMuzzleColor 		= Color( 20, 60, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720

SWEP.SciFiFamily			= { "vtec", "hitscanbullets", "ads" }

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "18, 16",
		DamageAmount = 34,
		DamageBlastRadius = 72,
		DamageType = DMG_SF_VAPOR,
		CritMul = 2,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.6 }
		},
	},
	ClipSize = 20,
	ReloadSpeed = 1.8,
	Recoil = 14,
	PerkSet = { SCIFI_PERK_DISSOLVE_HEAVY, SCIFI_PERK_CURSE_DOUBLEAMMODRAW }
}

SWEP.ReloadSND				= "scifi.vapor.reload"
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadTime 			= 1.8

SWEP.AdsPos 				= Vector(-4.435, 2, 1.155)
SWEP.AdsFov					= 32
SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )

SWEP.ViewModelSprintPos		= Vector( 2, 0.2, -1 )
SWEP.ViewModelSprintAng		= Angle( -8, 30, -15 )

SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.2
SWEP.ViewModelShiftOffset 	= Vector( 0, -0.04, -0.09 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )

SWEP.NPCAccuracy 			= 100 -- 1500
SWEP.NPCSkillLevel 			= 2
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= -0.16

local snd_pfire = Sound( "weapons/vapor/fstar_pfire.wav" )
local snd_pfire_echo = Sound( "weapons/vapor/fstar_sfire_.wav" )

-- Colors for holographic sight --
local color_visor_default = Color( 255, 255, 255, 255 ) 	-- default white
local color_visor_warning = Color( 255, 45, 15, 255 ) 		-- saturated red
local color_visor_error =  Color( 255, 10, 30, 255 )		-- decent yellow

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1.5, 0 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Claw1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Claw2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
--	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 4, 0, 4 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "Base", rel = "", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/lab_flourescentlight002b.mdl", bone = "Base", rel = "", pos = Vector(0.963, 1.616, 10.572), angle = Angle(0, 0, 90), size = Vector(0.112, 0.029, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "Base", rel = "", pos = Vector(5.015, 68.08, -10.5), angle = Angle(180, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/misc/case_rail_2", [1] = "models/weapons/misc/case_stock_2", [2] = "vgui/white", [3] = "vgui/white", [4] = "vgui/white" }, skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt1", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_dispenser.mdl", bone = "Base", rel = "", pos = Vector(0.32, 0.6, 5), angle = Angle(0, 0, 180), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/capacitor", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Base", rel = "", pos = Vector(0.3, 4, 20), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["holo_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 5), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_hexaframe_chroma", skin = 0, bodygroup = {} },
	["holo_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_point", skin = 0, bodygroup = {} },
	["holo_3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_point", skin = 0, bodygroup = {} },
	["holo_4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6.25), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_lines", skin = 0, bodygroup = {} },
--	["holo_5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.32, -2.9, 1.58), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_disp_burst", skin = 0, bodygroup = {} },
	["holo_6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.24, -2.8, 1.58), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_disp_notify_reload", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01a.mdl", bone = "", rel = "10", pos = Vector(-0.76, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "", rel = "10", pos = Vector(0.24, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["13"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "10", pos = Vector(0, -1.2, 13.2), angle = Angle(30, -90, 0), size = Vector(0.02, 0.01, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["15"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/cell_01_supportsb.mdl", bone = "", rel = "10", pos = Vector(-0.24, 6.2, 15), angle = Angle(1, 90, -180), size = Vector(0.012, 0.007, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_railing", skin = 0, bodygroup = {} },
	["17"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-1, 5.4, 8), angle = Angle(0, 0, 180), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/case", skin = 0, bodygroup = {} },
	["17a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-0.132, 1.8, 8), angle = Angle(180, 0, 0), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/case", skin = 0, bodygroup = {} },
	["18"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(0.5, -1, 8), angle = Angle(180, -90, 2), size = Vector(0.03, 0.014, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["gs1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gs_barrel.mdl", bone = "Base", rel = "0", pos = Vector(-1, -14, 0), angle = Angle(20, -4, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gs2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gs_barrel.mdl", bone = "Base", rel = "0", pos = Vector(2.6, -14, -2), angle = Angle(-160, 4, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gs3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gs_barrel.mdl", bone = "Base", rel = "0", pos = Vector(2, -14, -2), angle = Angle(-100, 3.2, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gs4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gs_barrel.mdl", bone = "Base", rel = "0", pos = Vector(-1.6, -14, -3), angle = Angle(80, -3.2, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["20a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.3, 0.1, 14), angle = Angle(0, 0, 0.1), size = Vector(0.016, 0.002, 0.3), color = Color(225, 190, 255, 255), surpresslightning = true, material = "models/effects/splodearc_sheet", skin = 0, bodygroup = {} },
	["20b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.3, 1, 14), angle = Angle(0, 0, -0.1), size = Vector(0.016, 0.002, 0.3), color = Color(225, 190, 255, 255), surpresslightning = true, material = "models/effects/splodearc_sheet", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "Base", rel = "", pos = Vector(0, -0.5, 12), angle = Angle(0, 160, 90), size = Vector(0.06, 0.2, 0.06), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/barrel", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.25, -5), angle = Angle(165, 10, 8), size = Vector(1.303, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 5.2, 78), angle = Angle(0, 90, 192), size = Vector(0.8, 1.12, 1.295), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/misc/case_rail_2", [1] = "models/weapons/misc/case_stock_2", [2] = "vgui/white", [3] = "vgui/white", [4] = "vgui/white" }, skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.8, -3.8), angle = Angle(0, -90, -103), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/capac", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19, 2, -3.2), angle = Angle(0, -90, 75), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01a.mdl", bone = "", rel = "10", pos = Vector(-0.76, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "", rel = "10", pos = Vector(0.24, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["13"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "10", pos = Vector(0, -1.2, 13.2), angle = Angle(30, -90, 0), size = Vector(0.02, 0.01, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["14"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "", rel = "10", pos = Vector(-0.2, 4.6, 8), angle = Angle(0, 0, 0), size = Vector(0.006, 0.006, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["14a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "", rel = "10", pos = Vector(-0.2, 4.6, 10), angle = Angle(0, 0, 180), size = Vector(0.006, 0.006, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["15"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/cell_01_supportsb.mdl", bone = "", rel = "10", pos = Vector(-0.24, 6.2, 15), angle = Angle(1, 90, -180), size = Vector(0.012, 0.007, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_railing", skin = 0, bodygroup = {} },
	["17"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-1, 5.68, 8), angle = Angle(0, 0, 180), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/case", skin = 0, bodygroup = {} },
	["17a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-0.132, 2, 8), angle = Angle(180, 0, 0), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/case", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, 0.4, -9), angle = Angle(0, 90, 14), size = Vector(0.404, 0.454, 0.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/barrel", skin = 0, bodygroup = {} }
}


function SWEP:SubInit()

	self:SetCharge( 0 )

end

function SWEP:Think()

	if ( self.Owner:IsPlayer() ) && ( !self.Owner:InVehicle() ) then
		
		local tr = self.Owner:GetEyeTrace()
		local tardist = self.Owner:GetShootPos():Distance( tr.HitPos )
		local clrmod = 255 - ( self.VElements[ "holo_4" ].size.x * 5600 )
		local IsReloading = self.SciFiState == SCIFI_STATE_RELOADING
		
		self.VElements[ "holo_2" ].size = Vector(0.015, 0.015, 0.015) * ( self:GetSciFiACC() / 3 + 1 )
		self.VElements[ "holo_4" ].size = Vector(0.007, 0.007, 0.007) * ( tardist / 4000 )
		self.VElements[ "holo_4" ].color = Color( clrmod, clrmod, clrmod, clrmod )
		
		self.Charge = math.Clamp( self.Charge - 48, 0, 1000 )
		local cmod = self.Charge / 786
		self.VElements[ "gs1" ].pos = Vector(-1, -14, 0) + ( Vector( -1, 0.2, 0.8 ) * cmod )
		self.VElements[ "gs4" ].pos = Vector(-1.6, -14, -3) + ( Vector( -1, 0.2, -0.8 ) * cmod )
		self.VElements[ "gs2" ].pos = Vector(0.2, -14, -3) + ( Vector( 1, 0.2, -0.8 ) * cmod )
		self.VElements[ "gs3" ].pos = Vector(1.4, -14, -0.4) + ( Vector( 1, 0.2, 0.2 ) * cmod )
		
		if ( self.Weapon:Clip1() <= 6 ) && ( !IsReloading ) then
			self.VElements[ "holo_6" ].material = "models/weapons/saphyre/holo_disp_notify_reload"
		else
			self.VElements[ "holo_6" ].material = "vgui/white"
		end
				
		if ( tr.Entity:IsNPC() ) or ( tr.Entity:IsPlayer() ) then
			self.VElements[ "holo_3" ].size = Vector(0.03, 0.03, 0.03)
			if ( tr.HitGroup == HITGROUP_HEAD ) then
				self.VElements[ "holo_3" ].color = color_visor_error
			else
				self.VElements[ "holo_3" ].color = color_visor_default
			end
		else
			self.VElements[ "holo_3" ].size = Vector(0.02, 0.02, 0.02)
			self.VElements[ "holo_3" ].color = color_visor_default
		end
		
		if ( self:GetNextPrimaryFire() - 0.2 > CurTime() && !IsReloading ) then
			if ( CLIENT ) then
				self.Charge = self.Charge + 128
			end
		end
		
	end

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:HwaveFire()

	if ( !IsValid( self.Owner ) ) then return end
	
	local viewmodel = self:GetViewModelEnt()
	local amp = GetConVarNumber( "sfw_damageamp" )
	
	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	if ( self.Owner:IsPlayer() ) then
		bullet.Dir = self.Owner:GetAimVector()
	else
		bullet.Dir = self.NPCAimVectorOverride
	end
	bullet.Spread = Vector( 0.002, 0.003 ) * self:GetSciFiACC()
	bullet.Tracer = 1
	bullet.Force = 4
	bullet.HullSize = 1
	bullet.Damage = 18 * amp
	bullet.TracerName = "aq_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		DoElementalEffect( { Element = EML_DISSOLVE_VAPOR, Attacker = self.Owner, Origin = tr.HitPos, Range = 24, Ticks = 25 } ) 
	
		dmginfo:SetInflictor( self )
		dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_AIRBOAT, DMG_NEVERGIB ) )
		
		self:DealAoeDamage(  bit.bor( DMG_ENERGYBEAM, DMG_AIRBOAT, DMG_NEVERGIB ) , 16 * amp, tr.HitPos, 72 )

		if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
			ParticleEffect( "vapor_collapse", tr.HitPos, Angle( 0, 0, 0 ) )
		end
		
		if ( SERVER ) then
			util.ScreenShake( tr.HitPos, 512, 7, 0.25, 144 )
		end
	end

	self:AddSciFiACC( 14, true )
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1, -1.2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( 1 + self:GetSciFiACC() * 0.1 ) )
	end

	if ( IsValid( viewmodel ) ) then
		ParticleEffectAttach( "saphyre_muzzle_flames_0a", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( SERVER ) && ( cmd_heat == 1 ) then
			ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		end
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.aquam.pfire" )
--	self:EmitSound( snd_pfire, 100, math.random( 98, 102 ), 1, CHAN_WEAPON )
--	self:EmitSound( snd_pfire_echo, 100, math.random( 98, 102 ), 1, CHAN_STATIC )
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self:TakePrimaryAmmo( 2 )

end

function SWEP:PrimaryAttack()
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	self:HwaveFire()
	self:SetNextPrimaryFire( CurTime() + 0.6 )

end

function SWEP:NPCShoot_Primary( ShootPos, ShootDir )
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	
	ParticleEffectAttach( "aquamarine_charge", PATTACH_POINT_FOLLOW, self, 1 )
	self:EmitSound( "scifi.aquam.npcwarning" )
	
	timer.Simple( 0.6, function()
		if ( !IsValid( self ) ) then return end
		
		if ( !IsValid( self.Owner ) ) then
			local muzzle = self:GetAttachment( self:LookupAttachment( "muzzle" ) )

			local bullet = {}
			bullet.Attacker = self
			bullet.Num = 1
			bullet.Src = muzzle.Pos
			bullet.Dir = muzzle.Ang:Forward()
			bullet.Spread = Vector( 0, 0 )
			bullet.Tracer = 1
			bullet.Force = 4
			bullet.HullSize = 1
			bullet.Damage = 18
			bullet.TracerName = "aq_tracer"
			bullet.Callback = function( attacker, tr, dmginfo )
				DoElementalEffect( { Element = EML_DISSOLVE_VAPOR, Attacker = self, Origin = tr.HitPos, Range = 24, Ticks = 25 } ) 
			
				dmginfo:SetInflictor( self )
				dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_AIRBOAT, DMG_NEVERGIB ) )
				
				self:DealAoeDamage(  bit.bor( DMG_ENERGYBEAM, DMG_AIRBOAT, DMG_NEVERGIB ) , 16, tr.HitPos, 72 )

				if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
					ParticleEffect( "vapor_collapse", tr.HitPos, Angle( 0, 0, 0 ) )
				end
				
				if ( SERVER ) then
					util.ScreenShake( tr.HitPos, 512, 7, 0.25, 144 )
				end
			end
			
			self:FireBullets( bullet, false )
			
			self:EmitSound( "scifi.aquam.pfire" )
	
			return 
		end
		
		local entTarget = self.Owner:GetEnemy()
		
		if ( IsValid( entTarget ) && ShootDir ) then
			local HeadBone = self:GetTargetHeadBone( entTarget )
			
			local vBullsEye
			if ( HeadBone ) then
				vBullsEye = entTarget:GetBonePosition( HeadBone )
			else
				vBullsEye = entTarget:EyePos()
			end
			
			local fSkill = self.NPCSkillLevel / self.Owner:GetCurrentWeaponProficiency()
			local vSpread = Vector( 0.1, 0.1, 0.1 ) * math.random( -self.NPCAccuracy, self.NPCAccuracy ) * fSkill

			ShootDir = vBullsEye - self.Owner:GetShootPos() + vSpread
			
			if ( self.NPCLeadTarget ) then
				local vTargetVelo = entTarget:GetVelocity()
				
				ShootDir = ShootDir + ( vTargetVelo:GetNormalized() * vTargetVelo:Length() * self.NPCLeadPower )
			end
			
			self.NPCAimVectorOverride = ShootDir
		end
		
		if ( !ShootDir ) then
			local iParentBone = self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )
			ShootPos, ShootDir = self.Owner:GetBonePosition( iParentBone )
			ShootDir = ( ShootDir:Forward() + self.Owner:GetAimVector() ) * 0.5
		end
		
		self:HwaveFire()
	end )

	self:SetNextPrimaryFire( CurTime() + 1.2 )
	self.Owner:SetSaveValue( "m_flLastAttackTime", ( CurTime() + 1.2 ) * -1 )
	self.Owner:SetSaveValue( "m_flNextAttack", 1.2 )

end

function SWEP:SecondaryAttack()

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )

end