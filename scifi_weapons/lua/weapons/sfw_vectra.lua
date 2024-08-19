AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.NpcSpawnFlags 			= {}

SWEP.Purpose				= "This energy-based rifle-shotgun-hybrid is a formidable energy weapon for short to mid-range combat."
SWEP.Instructions			= "Mouse1 to fire. Mouse2 to aim down sights. Hold Mouse1 to charge the weapon and increase the projectile count for the cost of fire rate. Hold 'reload' while releasing the trigger to discharge safely. Shock damage may stun NPCs or blind players."
SWEP.ItemRank 				= 26

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.DeploySpeed 			= 1.85
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.ViewModelFOV = 62

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

SWEP.VfxMuzzleParticle 		= "spectra_muzzle_2"
SWEP.VfxMuzzleColor 		= Color( 120, 130, 255, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720
SWEP.VfxHeatParticle 		= "spectra_muzzle_overheat"
SWEP.VfxHeatThreshold 		= 0.6
SWEP.VfxHeatDelay 			= 0

SWEP.PrintName				= "C-CS Vectra"
SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.AdsPos 				= Vector(-5.1, -1, 2.24)
SWEP.AdsFov					= 52
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.ancient.sight.turnon"
SWEP.AdsSoundDisable		= "scifi.ancient.sight.turnoff"

SWEP.SafeModeOnSnd 	 		= "scifi.ancient.safety.on"
SWEP.SafeModeOffSnd 		= "scifi.ancient.safety.off"

SWEP.ViewModelSprintPos		= Vector( 2, -2, -1 )
SWEP.ViewModelSprintAng		= Angle( -10, 25, -15 )
SWEP.ViewModelMeleePos		= Vector( 18, 8, -5 )
SWEP.ViewModelMeleeAng		= Angle( -10, 90, -85 )

SWEP.SprintSwayScale		= 1
SWEP.SprintBobScale			= 0
SWEP.SprintAnimSpeed		= 16

SWEP.ViewModelSwayDirection = Vector( -0.5, 4, 0.1 )
SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 5
SWEP.ViewModelShift 		= true

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8

SWEP.MidairRecoilMul		= 1

SWEP.ChargeMax				= 100
SWEP.ChargeAdd				= 1.2
SWEP.ChargeDrain			= 1
SWEP.ChargeDeltaCompensate 	= true
SWEP.ChargeDeltaFactor 		= 0.32

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.52
SWEP.SciFiMeleeRange		= 54
SWEP.SciFiMeleeDamage		= 6
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"

SWEP.DepletedSND			= ""

SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( 5, -4, -4 )
SWEP.ViewModelReloadAng		= Angle( 10, 5, 15 )

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.15

SWEP.SciFiFamily			= { "custom", "phys", "ads", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 10 + 2", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x1.5", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Bullet, Shock", color = Color( 135, 120, 255 ) },
	["3a"] = { text = "Status Chance: 10%", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				8.3 (semi-auto / charge)", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Energy drain: 	 2 (per shot)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate: 60", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Projectile count scales with charge.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Charging the weapon adds bonus damage.", color = Color( 180, 180, 180 ) },
	["9c"] = { text = "... Neither fear nor pain ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "10, 2",
		DamageAmount = 12,
		DamageType = { DMG_BULLET, DMG_SHOCK },
		CritMul = 1.5,
		StatusChance = 10,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.1 }
		},
		ChargeRate = 1.2
	},

	CoreRechargeRate = 60,
	Recoil = 6,
	PerkSet = { SCIFI_PERK_RELOAD_RECHARGEAMMO, SCIFI_PERK_VECTRA_MULTISHOT, SCIFI_PERK_ELEMENTAL_SHOCK, { PerkTitle = "Neither fear nor pain", PerkDescription = "", PerkPanelHeight = 3, PerkColor = Color( 255, 20, 20 ) } }
}

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0.8, -2.4 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0.5, -2, -0.5), angle = Angle(-2, -2, 5) }
}

SWEP.VElements = {
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.25, -0.6, -1.2), angle = Angle(30, -163, -11), size = Vector(0.291, 0.31, 0.573), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.277, 2.157, 1.333), angle = Angle(134.783, 19.944, -11.235), size = Vector(0.218, 0.184, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.725, 2.427, -4.481), angle = Angle(174.811, 8.178, -9.08), size = Vector(0.37, 0.279, 0.37), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },

	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, -0.5, -7), angle = Angle(-14, -174, 170), size = Vector(1.1, 1.1, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, -1.6, -7), angle = Angle(-30, -174, 170), size = Vector(0.8, 1.1, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, -1.2, -1.5), angle = Angle(35, -174, -6), size = Vector(0.8, 1, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "6", pos = Vector(0.4, 0, 0.14), angle = Angle(0, 0, 0), size = Vector(0.081, 0.081, 0.081), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.4, -0.8, -4), angle = Angle(0, 8, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "6", pos = Vector(1.799, 0.6, 0.6), angle = Angle(180, 0, 133), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["7+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "6", pos = Vector(1.799, -0.601, 0.6), angle = Angle(180, 0, -133), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["7++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "6", pos = Vector(1.799, 0, -0.601), angle = Angle(180, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["1a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.586, 0.356, -4.532), angle = Angle(0, -180, 90), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["1d"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.403, 1.667, -2.631), angle = Angle(0, -160, -120), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },

	["holo7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(-0.4, -1.2, 6.4), angle = Angle(30, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo7a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "holo8", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 40), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(0.4, -1.2, 6.4), angle = Angle(-30, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo8a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "holo7", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },

	["holo_circle_outer_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "Base", rel = "", pos = Vector(-0.42, -4.4, 4), angle = Angle(0, -20, 0), size = Vector(0.01, 0.01, 0.001), color = Color(220, 220, 255, 60), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo_circle_outer_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "Base", rel = "", pos = Vector(0.62, -4.43, 4), angle = Angle(0, 110, 0), size = Vector(0.01, 0.01, 0.001), color = Color(220, 220, 255, 60), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(0.085, -4.4, 12), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.004), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(0.085, -4.4, 12), angle = Angle(0, 0, 0), size = Vector(0.0005, 0.0005, 0.0005), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.581, -0.666, -0.738), angle = Angle(37.598, -163.959, -11.36), size = Vector(0.291, 0.31, 0.573), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.277, 2.157, 1.333), angle = Angle(134.783, 19.944, -11.235), size = Vector(0.218, 0.184, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.725, 2.427, -4.481), angle = Angle(174.811, 8.178, -9.08), size = Vector(0.37, 0.279, 0.37), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, -0.5, -7), angle = Angle(-14, -174, 170), size = Vector(1.1, 1.1, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, -1.6, -7), angle = Angle(-30, -174, 170), size = Vector(0.8, 1.1, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, -1.2, -1.5), angle = Angle(35, -174, -6), size = Vector(0.8, 1, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "6", pos = Vector(0.4, 0, 0.14), angle = Angle(0, 0, 0), size = Vector(0.081, 0.081, 0.081), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.4, -0.8, -4), angle = Angle(0, 8, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "6", pos = Vector(1.799, 0.6, 0.6), angle = Angle(180, 0, 133), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["7+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "6", pos = Vector(1.799, -0.601, 0.6), angle = Angle(180, 0, -133), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["7++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "6", pos = Vector(1.799, 0, -0.601), angle = Angle(180, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	["1a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.586, 0.356, -4.532), angle = Angle(0, -180, 90), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["1d"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.403, 1.667, -2.631), angle = Angle(0, -160, -120), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} }
}

-- resource.AddSingleFile( "weapons/hwave/hwave_charge.wav" )
util.PrecacheSound( "weapons/hwave/hwave_charge.wav" )
-- resource.AddSingleFile( "common/NULL.wav" )
util.PrecacheSound( "common/NULL.wav" )

local mymat = Material( "models/weapons/spectra/spectra_bone_rtedit.vmt" )
local matCore = Material( "models/weapons/misc/energy_surf" )

local core_hpos = Vector(0.4, 0, 0.14)
local core_hscale = Vector( 0.001, 0.001, 0.001 )
local core_color_default = Color( 120, 130, 255 )
local casing_hpos = Vector(9, -0.2, -4)

local barrel1_hpos = Vector(9, -0.6, -6.8)
local barrel2_hpos = Vector(16, -1.7, -6.42)
local barrel3_hpos = Vector(15.5, -1.3, -0.5)

local stock_hpos = Vector(1.7, 2.4, -4.4)
local llimb_hpos = Vector(7, -1.4, -5)
local rlimb_hpos = Vector(9, 2, -3)

SWEP.DataTables = {
	{ dType = "Float", dName = "NextChargeAnim" },
	{ dType = "Float", dName = "NextCoreFxAnim" }
}

function SWEP:SubInit()

	self:SetCharge( 0 )
	self.ScifiRegenNext = 0
	
end

local vWeaponOrigin = Vector( 0, 0, 0 )

function SWEP:Think()

	local animtime = self:GetNextChargeAnim()	
	local vm = self.Owner:GetViewModel()
	local sine0 = math.sin( CurTime() * 8 ) / 8
	local sine1 = math.sin( CurTime() * 4 ) / 10
	local sine2 = math.sin( CurTime() * 4 ) / 20
	local fCharge = self:GetCharge()
	local cmod = fCharge * 0.01
	
	local iClip1 = self:Clip1()
	
	if ( SERVER ) then
		if( self.ScifiRegenNext <= CurTime() )&&( !self.Owner:KeyDown( IN_ATTACK ) ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) then 
				self.Weapon:SetClip1( self.Weapon:Clip1() + 1 ) 
			end
		end
		
		if ( self.Weapon:Clip1() >= self.Primary.ClipSize + 1 ) then
			self.Weapon:SetClip1( self.Primary.ClipSize )
		end
	end
	
	local aChamber = Angle( 0, 0, 1 )
	
	if ( self:GetSafeMode() ) then
		cmod = 0
		iClip1 = 0
		aChamber.roll = 0
	end
	
	if ( CLIENT ) then
		if ( IsValid( self.Owner ) && self.Owner:InVehicle() ) then return end
		
		vWeaponOrigin = self:GetProjectileSpawnPos()
		
		self.VElements[ "5" ].pos = core_hpos + Vector( sine0, -sine1, sine2 )
		self.VElements[ "5" ].angle = self.VElements[ "5" ].angle + aChamber -- Angle( sine0, sine1, sine2 ) * 16
		self.VElements[ "5" ].size = core_hscale * ( 15 + iClip1 * 0.85 ) * ( 1 + 0.2 + cmod )

		self.VElements[ "6" ].pos = casing_hpos + Vector( sine0, sine1, sine2 ) * ( -1 + fCharge* 0.05 )
		self.VElements[ "6" ].angle = self.VElements[ "6" ].angle + aChamber * ( -1 + fCharge* 0.05 )
		
		self.VElements[ "3" ].pos = stock_hpos + Vector( sine0, -sine1, sine2 ) * 0.5
		self.VElements[ "1a" ].pos = llimb_hpos + Vector( sine1, sine0, -sine2 )
		self.VElements[ "1d" ].pos = rlimb_hpos + Vector( -sine1, -sine0, sine2 )
		
		self.VElements[ "4" ].pos = barrel1_hpos + Vector( sine0 + cmod, sine1 - ( cmod / 16 ), sine2 - ( cmod / 16 ) ) * ( 1 + cmod )
		self.VElements[ "4+" ].pos = barrel2_hpos + Vector( sine1 + cmod, 0, sine2 ) * ( 1 + cmod )
		self.VElements[ "4++" ].pos = barrel3_hpos + Vector( sine2 + cmod, 0, -sine2 ) * ( 1 + cmod )
	
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			self.VElements[ "holo7" ].pos = LerpVector( FrameTime() * 6, self.VElements[ "holo7" ].pos, Vector(0.8, -4, 2) )
			self.VElements[ "holo8" ].pos = LerpVector( FrameTime() * 6, self.VElements[ "holo8" ].pos, Vector(-0.6, -4, 2) )
			
			self.VElements[ "holo" ].color.a = Lerp( FrameTime() * 4, self.VElements[ "holo" ].color.a, 255 )
			self.VElements[ "holo++" ].color.a = Lerp( FrameTime() * 6, self.VElements[ "holo++" ].color.a, 255 )
			self.VElements[ "holo_circle_outer_0" ].color.a = Lerp( FrameTime() * 16, self.VElements[ "holo_circle_outer_0" ].color.a, 255 )
			self.VElements[ "holo_circle_outer_1" ].color.a = Lerp( FrameTime() * 16, self.VElements[ "holo_circle_outer_1" ].color.a, 255 )
			self.VElements[ "holo7" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "holo7" ].color.a, 255 )
			self.VElements[ "holo7a" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "holo7a" ].color.a, 40 )
			self.VElements[ "holo8" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "holo8" ].color.a, 255 )
			self.VElements[ "holo8a" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "holo8a" ].color.a, 255 )
			
			self.VElements[ "holo7a" ].size = Vector( 0.004, 0.004, 0.001 ) * ( iClip1 * 0.01 )
			self.VElements[ "holo8a" ].size = Vector( 0.004, 0.004, 0.001 ) * cmod 
		else
			self.VElements[ "holo7" ].pos = LerpVector( FrameTime() * 4, self.VElements[ "holo7" ].pos, Vector(0, -4, 4) )
			self.VElements[ "holo8" ].pos = LerpVector( FrameTime() * 4, self.VElements[ "holo8" ].pos, Vector(0, -4, 4) )
			
			self.VElements[ "holo" ].color.a = Lerp( FrameTime() * 6, self.VElements[ "holo" ].color.a, 0 )
			self.VElements[ "holo++" ].color.a = Lerp( FrameTime() * 6, self.VElements[ "holo++" ].color.a, 0 )
			self.VElements[ "holo_circle_outer_0" ].color.a = Lerp( FrameTime() * 16, self.VElements[ "holo_circle_outer_0" ].color.a, 0 )
			self.VElements[ "holo_circle_outer_1" ].color.a = Lerp( FrameTime() * 16, self.VElements[ "holo_circle_outer_1" ].color.a, 0 )
			self.VElements[ "holo7" ].color.a = Lerp( FrameTime() * 6, self.VElements[ "holo7" ].color.a, 0 )
			self.VElements[ "holo7a" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "holo7a" ].color.a, 0 )
			self.VElements[ "holo8" ].color.a = Lerp( FrameTime() * 6, self.VElements[ "holo8" ].color.a, 0 )
			self.VElements[ "holo8a" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "holo8a" ].color.a, 0 )
		end
		
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetProjectileSpawnPos() + self.Owner:EyeAngles():Forward() * 24 + self.Owner:EyeAngles():Up() * -4
			dlight.r = core_color_default.r
			dlight.g = core_color_default.g
			dlight.b = core_color_default.b
			dlight.brightness = 0.2 + cmod
			dlight.Decay = 2048
			dlight.Size = 0.8 * iClip1 + 128 * cmod
			dlight.Style = 1				
			dlight.DieTime = CurTime() + 1
			dlight.noworld = false
			dlight.nomodel = false
		end	

		mymat:SetVector( "$selfillumtint", Vector( 1, 1, 2 ) + ( Vector( -0.1, 4, 16 ) * cmod ) )

		local scale = 0.065 * ( iClip1 * 0.01 ) * ( 1 + cmod )
		matCore:SetFloat( "$FleshBorderWidth", scale )
		
		if ( fCharge >= self.ChargeMax ) then
			dlight.brightness = 1 + cmod
			core_color_default.r = Lerp( FrameTime() * 6, core_color_default.r, 170 )
			core_color_default.g = 180
			core_color_default.b = Lerp( FrameTime() * 6, core_color_default.b, 255 )
		else
			core_color_default.r = Lerp( FrameTime() * 8, core_color_default.r, 120 )
			core_color_default.g = 130
			core_color_default.b = Lerp( FrameTime() * 8, core_color_default.b, 255 )
		end
	end

	local bParticles = GetConVar( "sfw_fx_particles" ):GetBool()
	if ( bParticles ) then
		if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
			if ( self:GetNextCoreFxAnim() <= CurTime() ) then
				self:SetNextCoreFxAnim( CurTime() + 0.4 )
			end
		end
	end

	if ( self.Owner:KeyReleased( IN_ATTACK ) ) && ( !self.Owner:KeyDown( IN_RELOAD ) ) && ( self:GetNextPrimaryFire() <= CurTime() ) && (self.SciFiState ~= SCIFI_STATE_SPRINT ) then
		if ( SERVER || !game.SinglePlayer() ) then
			self:DefaultAttack()
			self:SetNextPrimaryFire( CurTime() + 0.1 )	
			self:SetCharge( 0 )
		end
	end
	
	if ( CLIENT ) && ( self:GetNextPrimaryFire() > CurTime() ) && (self.SciFiState ~= SCIFI_STATE_SPRINT ) then
		self:SetCharge( 0 )
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && self:Clip1() > 0 ) then
		if ( self:GetCharge() < self.ChargeMax ) then
			self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( fCharge >= 20 ) && ( self:GetNextPrimaryFire() + 0.22 <= CurTime() ) then
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
				if ( fCharge >= self.ChargeMax ) then 
					ParticleEffectAttach( "vectra_charged", 4, vm, vm:LookupAttachment("muzzle") )
				else
					ParticleEffectAttach( "vectra_charging", 4, vm, vm:LookupAttachment("muzzle") )
				end
			end
		end
		
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( SERVER ) then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "shake" ) )
			end
			self:SetNextChargeAnim( CurTime() + 0.4 )
		end
	
		if ( CLIENT ) then
			if ( fCharge >= 0 && fCharge < 50 ) then
				EmitSound( "weapons/hwave/hwave_charge.wav", vWeaponOrigin, self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), 80 )
			elseif ( fCharge >= 50 && fCharge < 70 ) then
				EmitSound( "weapons/hwave/hwave_charge.wav", vWeaponOrigin, self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), 90 )
			elseif ( fCharge >= 70 && fCharge < 100 ) then
				EmitSound( "weapons/hwave/hwave_charge.wav", vWeaponOrigin, self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), 100 )
			elseif ( fCharge >= 100 ) then
				EmitSound( "weapons/hwave/hwave_charge.wav", vWeaponOrigin, self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), 110 )
			end
		end
	end
		
	if ( CLIENT ) && ( self.Owner:KeyReleased( IN_ATTACK ) ) then
		EmitSound( "common/NULL.wav", vWeaponOrigin, self:EntIndex(), CHAN_WEAPON, self.Owner:EntIndex(), 60, bit.bor( SND_IGNORE_NAME, SND_STOP ), 100 )
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:Deploy() 

	self:SetAds( false )
	self:SetCharge( 0 )	
	self.ScifiRegenNext = CurTime() + 1
	
	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT )&&( IsValid(self.Owner) )&&( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	self:ResetDeployment()
	self:SetSciFiACC( 4 )
	return true

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( event == 6001 ) then 
		return true 
	end

	if ( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:DefaultAttack()

	if ( self.Owner:IsPlayer() && !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	
	local fCharge = self:GetCharge()
	
	self.ScifiRegenNext = CurTime() + 1.2 + ( fCharge * 0.005 )
	
	local pOwnerAV 	= self.Owner:GetAimVector()
	local pOwnerEP 	= self.Owner:EyePos()
	local pOwnerEA 	= self.Owner:EyeAngles()
	local up 		= pOwnerEA:Up()
	local rt 		= pOwnerEA:Right()
	local counter 	= 0
	local dir 		= Vector( 0, 0, 0 )
			
	local pos = self:GetProjectileSpawnPos()
	
	if ( self.SciFiState == SCIFI_STATE_ADS ) then
		pos = ( pOwnerEP + ( pOwnerAV * 20 ) )
	end
	
	if ( SERVER ) then
		if ( fCharge >= 0 && fCharge < 50 ) then
			counter = 1
		elseif ( fCharge >= 50 && fCharge < 70 ) then
			counter = 3
		elseif ( fCharge >= 70 && fCharge < 100 ) then
			counter = 5
		elseif ( fCharge >= 100 ) then
			counter = 7
		end
		
		local aim = ( pOwnerAV * 3200 + self:GetProjectileSpreadVector() * ( 1 + self:GetSciFiACC() * 0.5 ) )
		
		for i=1, counter do
			if ( counter == 1 ) then
				dir = up * 0
			end
			
			if ( counter == 2 ) then
				dir = up * 128
			end
			
			if ( counter == 3 ) then
				dir = up * -128
			end
			
			if ( counter == 4 ) then
				dir = rt * 128 + up * 64
			end
			
			if ( counter == 5 ) then
				dir = rt * -128 + up * 64
			end
			
			if ( counter == 6 ) then
				dir = rt * 128 + up * -64
			end
			
			if ( counter == 7 ) then
				dir = rt * -128 + up * -64
			end
			
			local ent = ents.Create( "vectra_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( pos )
			ent:SetAngles( pOwnerEA )
			ent:SetOwner( self.Owner )
	
			if ( fCharge >= 100 ) then
				ent.DieOnTouch = false
			else
				ent.DieOnTouch = true
			end
			
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( ( aim + dir ) * ( 1 + fCharge * 0.5 ) )
			
			if ( self.Owner:IsPlayer() ) then
				self.Owner:ViewPunch( Angle( math.random( -20, -30 ), math.random( -10, 10 ), 0 ) * ( 0.002 + ( self:GetSciFiACC() + self:GetCharge() * 0.2 ) * 0.001 ) )
				self:TakePrimaryAmmo( 2 )
			end
			
			counter = counter - 1
		end
	end
	
	if ( fCharge >= 70 ) then
		self:EmitSound( "scifi.vectra.fire" )
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	else
		self:EmitSound( "scifi.spectra.fire2" )
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	end
	
	if ( CLIENT ) then
		self:SetCharge( 0 )
	end
	
	if ( SERVER ) && ( self.Owner:IsPlayer() ) then
		self:SetCharge( 0 )
	end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	self:DoMuzzleEffect()
	
	if ( self.Owner:IsPlayer() ) then
		self:AddSciFiACC( 6 + counter )
	end

end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsNPC() ) then
		if ( self:GetCharge() < 150 ) then
			self:SetCharge( self:GetCharge() + 50 )
		else
			self:SetCharge( 0 )
		end

		self:DefaultAttack()
	end

end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()
	
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 190
			dlight.g = 205
			dlight.b = 255
			dlight.brightness = 5
			dlight.Decay = 512
			dlight.Size = 256
			dlight.DieTime = CurTime() + 1
		end
	end
	
	return true

end