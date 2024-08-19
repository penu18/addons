AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Used by the Celestial's leading caste, the 'Zeala' unites their technology and power into an elegant instrument of mass destruction, creating a gravity vortex upon impact."
SWEP.Instructions			= "Mouse1 to fire. Hold Mouse1 to charge the weapon. This weapon needs to be completely charged in order to fire. Holding the charged weapon will drain your shields."
SWEP.ItemRank 				= 28

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "pistol"
SWEP.HoldTypeSprint			= "normal"
SWEP.HoldTypeNPC 			= "smg"
SWEP.DeploySpeed 			= 1
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
SWEP.Primary.Ammo			= "SciFiEnergy"

SWEP.VfxMuzzleParticle 		= "zeala_charging"
SWEP.VfxMuzzleRule 			= 0

SWEP.PrintName				= "C-AZ Zeala"
SWEP.Slot					= 4
SWEP.SlotPos				= 1

SWEP.AdsPos 				= Vector( -2.7, -4, -0.2 )
SWEP.AdsAng					= Angle( 2, 0.2, -17.5 )
SWEP.AdsFov					= 60
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.ancient.sight.turnon"
SWEP.AdsSoundDisable		= "scifi.ancient.sight.turnoff"

SWEP.SafeModeOnSnd 	 		= "scifi.ancient.safety.on"
SWEP.SafeModeOffSnd 		= "scifi.ancient.safety.off"

--SWEP.ViewModelSprintPos		= Vector( 2, 0, -2 )
--SWEP.ViewModelSprintAng		= Angle( -8, -15, 0 )
SWEP.ViewModelShift = false
SWEP.ViewModelSprintPos		= Vector( 1, -1, -1 )
SWEP.ViewModelSprintAng		= Angle( -15, -15, 0 )
SWEP.ViewModelMeleePos		= Vector( 18, 8, -5 )
SWEP.ViewModelMeleeAng		= Angle( -20, 75, -125 )

SWEP.MidairRecoilMul		= 1

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8

SWEP.ChargeMax				= 100
SWEP.ChargeAdd				= 0.8
SWEP.ChargeDrain			= 1.6
SWEP.ChargeDeltaCompensate 	= true

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.52
SWEP.SciFiMeleeRange		= 60
SWEP.SciFiMeleeDamage		= 6
SWEP.SciFiMeleeSound		= "scifi.melee.swing.heavy"

SWEP.DepletedSND			= ""

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.4

SWEP.SciFiFamily			= { "custom", "phys", "ads", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				1 + 12", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "AOE Range:		215; 92", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				--", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Blight, Crush", color = Color( 175, 160, 180 ) },
	["5"] = { text = "Fire rate: 				 0.8 (semi-auto / charge)", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Energy drain: 	 100 (per shot)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate: 60", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Weapon needs to be fully charged before being able to fire.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "The vortex created by this weapon deals bonus damage on explosion.", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Holding the weapon's charge drains the owner's shields.", color = Color( 180, 180, 180 ) },
	["9a"] = { text = "... You have their blessing. Now they force your hand ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "1, 12",
		DamageAmount = 12,
		DamageBlastRadius = 384,
		DamageType = { DMG_CRUSH, DMG_BLIGHT },
		ChargeRate = 0.8
	},
	CoreRechargeRate = 60,
	PerkSet = { SCIFI_PERK_RELOAD_RECHARGEAMMO, SCIFI_PERK_ZEALA_UNSTABLECHARGE, { PerkTitle = "Their blessing and their force", PerkDescription = "Lethal vortex draws in everything\nin its range, crushing it within the void.", PerkPanelHeight = 3, PerkColor = Color( 255, 20, 20 ) } }
}

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-8.815, -1.797, -9.773), angle = Angle(-36.896, -28.75, 84.391) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-33.459, 18.086, 87.333) },
	["ValveBiped.Bip01_L_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 23.565, 0) },
	["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 12.454, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-3.74, 3.637, -4.296), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 12.675, -10.202) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(27.454, -2.247, -19.637) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-22.23, 13.864, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -87.527, 0) }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.224, 0.224, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(11.074, -2.707, 1.797), angle = Angle(-171.06, -2.267, -88.044), size = Vector(1.004, 1.004, 1.004), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(-5.651, -0.75, -3.641), angle = Angle(170, -125, 30), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(-8, -0.723, -3), angle = Angle(172, -112, 32), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(-5.301, -1.5, 3.099), angle = Angle(-159, -125, 176), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(-8.5, -2.3, 2.2), angle = Angle(-147, -120, 174), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 0.3, 0.5), angle = Angle(11, -3.701, 0), size = Vector(0.224, 0.224, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+", pos = Vector(1.8, 1.299, 0.4), angle = Angle(0, 0, 0), size = Vector(0.3, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["3+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+", pos = Vector(1.8, -0.5, -1.101), angle = Angle(0, 0, 125), size = Vector(0.3, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["3++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+", pos = Vector(1.8, -1, 1.1), angle = Angle(0, 0, -120), size = Vector(0.3, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 3.2, -3.2), angle = Angle(0, -15.8, 80), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },

	["holo7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(-1, -4, 6.4), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo7a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "holo8", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 40), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(-1, -4, 6.4), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo8a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "holo7", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },

	["holo_circle_outer_0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "Base", rel = "", pos = Vector(3, -3.4, 4), angle = Angle(0, 170, 0), size = Vector(0.02, 0.02, 0.001), color = Color(220, 220, 255, 60), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo_circle_outer_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "Base", rel = "", pos = Vector(1.8, -2.25, 4), angle = Angle(0, 170, 0), size = Vector(0.01, 0.01, 0.001), color = Color(220, 220, 255, 60), surpresslightning = true, material = "models/weapons/pulsar/sight_idle", skin = 0, bodygroup = {} },
	["holo"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "Base", rel = "", pos = Vector(2.46, -2.7, 12), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.004), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["holo++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(2.46, -2.7, 12), angle = Angle(0, 0, 0), size = Vector(0.0005, 0.0005, 0.0005), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(-10, 0, 0), size = Vector(0.224, 0.224, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(12.074, -0.8, 0.9), angle = Angle(-175, -12, -88.044), size = Vector(1.004, 1.004, 1.004), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(-5.651, -0.75, -3.641), angle = Angle(170, -125, 30), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(-8, -0.723, -3), angle = Angle(172, -112, 32), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(-5.301, -1.5, 3.099), angle = Angle(-159, -125, 176), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0", pos = Vector(-8.5, -2.3, 2.2), angle = Angle(-147, -120, 174), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 0.3, 0.5), angle = Angle(-8, -3.701, 0), size = Vector(0.224, 0.224, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+", pos = Vector(1.8, 1.299, 0.4), angle = Angle(0, 0, 0), size = Vector(0.3, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["3+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+", pos = Vector(1.8, -0.5, -1.101), angle = Angle(0, 0, 125), size = Vector(0.3, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["3++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+", pos = Vector(1.8, -1, 1.1), angle = Angle(0, 0, -120), size = Vector(0.3, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 3.2, -3.2), angle = Angle(-8, -15.8, 80), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} }
}

-- resource.AddSingleFile( "weapons/ancient/zeala_charge.wav" )
util.PrecacheSound( "weapons/ancient/zeala_charge.wav" )
-- resource.AddSingleFile( "common/NULL.wav" )
util.PrecacheSound( "common/NULL.wav" )

local mymat = Material( "models/weapons/spectra/spectra_bone_rtedit.vmt" )

local larm_hpos = Vector(-8.8, -1.8, -9.8)
local larm_hang = Angle(-36.5, -29, 85)
local lhand_hang = Angle(-33.5, 18, 86)

local lance_hpos = Vector(13, -2.2, 1.8)
local lance_hang = Angle(-172, -2.27, -88)

local grip_hpos = Vector(4, 3.2, -3.2)
local grip_hang = Angle(0, -15.8, 80)

local grip_1_hpos = Vector(-5.65, -0.75, -3.64)
local grip_2_hpos = Vector(-8, -0.72, -3)
local grip_3_hpos = Vector(-5.3, -1.5, 3)
local grip_4_hpos = Vector(-8.5, -2.3, 2.2)

local barrel_1_hpos = Vector(1.8, 1.3, 0.3)
local barrel_2_hpos = Vector(1.8, -0.5, -1.1)
local barrel_3_hpos = Vector(1.8, -1, 1.1)
local barrel_1_hang = Angle(0, 0, 0)
local barrel_2_hang = Angle(0, 0, 125)
local barrel_3_hang = Angle(0, 0, -120)

local core_color_default = Color( 140, 150, 255 )

SWEP.DataTables = {
	{ dType = "Float", dName = "NextChargeAnim" },
	{ dType = "Float", dName = "NextCoreFxAnim" }
}

function SWEP:SubInit()

--	self:SetCharge( 0 )
	self.ScifiRegenNext = 0
	
	self:SetCharge( 0 )
	
end

local adsmod = 0

function SWEP:Think()

	local charge = self:GetCharge()
	local animtime = self:GetNextChargeAnim()	
	local vm = self.Owner:GetViewModel()
	local sine0 = math.sin( CurTime() * 8 ) / 8
	local sine1 = math.sin( CurTime() * 4 ) / 10
	local sine2 = math.sin( CurTime() * 4 ) / 20
	local cmod = charge * 0.01
	local iClip1 = self:Clip1()
	
	if ( SERVER ) then
		if ( self.ScifiRegenNext <= CurTime() )&&( !self.Owner:KeyDown( IN_ATTACK ) ) then
			if ( iClip1 < self.Primary.ClipSize ) then 
				self:SetClip1( iClip1 + 1 ) 
			end
		end
		
		if ( iClip1 >= self.Primary.ClipSize + 1 ) then
			self:SetClip1( self.Primary.ClipSize )
		end
	end
	
	if ( self:GetSafeMode() ) then
		cmod = 0
		iClip1 = 0
	end
	
	if ( CLIENT ) then
		self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos = larm_hpos + Vector( 2, 0, 2 ) * cmod
		self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = larm_hang + Angle( 16, 20, 0 ) * cmod
		self.ViewModelBoneMods["ValveBiped.Bip01_L_Hand"].angle = lhand_hang + Angle( -40, 0, -20 ) * cmod
		
		self.VElements[ "2" ].pos = grip_1_hpos + Vector( sine0, -sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "2+" ].pos = grip_2_hpos + Vector( sine0, sine1, -sine2 ) * ( 1 + cmod )
		self.VElements[ "2++" ].pos = grip_3_hpos + Vector( -sine0, sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "2+++" ].pos = grip_4_hpos + Vector( -sine0, sine1, sine2 ) * ( 1 + cmod )
		
		self.VElements[ "3" ].pos = barrel_1_hpos + ( Vector( 0, 0, 1 ) * cmod ) + Vector( sine0 - cmod, sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "3+" ].pos = barrel_2_hpos + ( Vector( 0, 0.6, -0.6 ) * cmod ) + Vector( sine0 - cmod, 0, sine2 ) * ( 1 + cmod )
		self.VElements[ "3++" ].pos = barrel_3_hpos + ( Vector( 0, -0.6, -0.6 ) * cmod ) + Vector( sine0 - cmod, 0, -sine2 ) * ( 1 + cmod )
--		self.VElements[ "3" ].angle = barrel_1_hang + ( Angle( 0, -4, 0 ) * cmod )
--		self.VElements[ "3+" ].angle = barrel_2_hang + ( Angle( 0, -4, 0 ) * cmod )
--		self.VElements[ "3++" ].angle = barrel_3_hang + ( Angle( 0, -4, 0 ) * cmod )
		
		self.VElements[ "1" ].pos = lance_hpos + ( Vector( sine0 - 1, sine1 - 2, sine2 ) * cmod )
		self.VElements[ "1" ].angle = lance_hang + ( Angle( 0, 4, 0 ) * cmod )
		
		self.VElements[ "0++" ].pos = grip_hpos + ( Vector( sine0, sine1, sine2 ) * cmod )
		self.VElements[ "0++" ].angle = grip_hang + ( Angle( 0, -4, 0 ) * cmod )
		
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			adsmod = Lerp( FrameTime() * 8, adsmod, 100 )
		else
			adsmod = Lerp( FrameTime() * 10, adsmod, 0 )
		end
		
		if ( adsmod > 1 ) then
			self.VElements[ "holo7" ].pos = LerpVector( FrameTime() * 6, self.VElements[ "holo7" ].pos, Vector(2.5, -2.45, 1.8) )
			self.VElements[ "holo8" ].pos = LerpVector( FrameTime() * 6, self.VElements[ "holo8" ].pos, Vector(1.8, -3.3, 2) )
			
			self.VElements[ "holo" ].color.a = 1.28 * ( adsmod * 2 )
			self.VElements[ "holo++" ].color.a = 1.28 * ( adsmod * 2 )
			self.VElements[ "holo7" ].color.a = 2.55 * adsmod
			self.VElements[ "holo7a" ].color.a = 0.4 * adsmod
			self.VElements[ "holo8" ].color.a = 2.55 * adsmod
			self.VElements[ "holo8a" ].color.a = 2.55 * adsmod
			
			self.VElements[ "holo7a" ].size = Vector( 0.004, 0.004, 0.001 ) * ( iClip1 / 100 )
			self.VElements[ "holo8a" ].size = Vector( 0.004, 0.004, 0.001 ) * cmod
			
			local tr = self.Owner:GetEyeTrace()
			local ETDist = tr.HitPos:Distance( self.Owner:GetPos() )
			
			self.VElements[ "holo_circle_outer_0" ].color.a = 1.28 * ( adsmod * 2 )
			self.VElements[ "holo_circle_outer_0" ].pos = Vector(3.2, -3.55, 4) + ( Vector( 0.36, -0.36, 0.84 ) * cmod )
			self.VElements[ "holo_circle_outer_1" ].pos = Vector(2.8, -3.25, 4) + ( Vector( 0.14, -0.14, 0.6 ) * cmod )
			self.VElements[ "holo_circle_outer_0" ].size = Vector(0.02, 0.02, 0.001) + ( Vector( 0.005, 0.005, 0 ) * cmod )
			self.VElements[ "holo_circle_outer_1" ].size = Vector(0.01, 0.01, 0.001) + ( Vector( 0.002, 0.002, 0 ) * cmod )
			
			if ( ETDist < 460 ) then
				self.VElements[ "holo_circle_outer_1" ].color = Color( 240, 80, 40, 1.28 * ( adsmod * 2 ) )
			else
				self.VElements[ "holo_circle_outer_1" ].color = Color( 220, 220, 255, 1.28 * ( adsmod * 2 ) )
			end
			
			if ( self.Owner:KeyDown( IN_RELOAD ) ) then
				self.VElements[ "holo8a" ].color = Color( 240, 20, 40, 220 )
			else
				self.VElements[ "holo8a" ].color = Color( 220, 220, 255, 255 )
			end

		else
			self.VElements[ "holo7" ].pos = LerpVector( FrameTime() * 6, self.VElements[ "holo7" ].pos, Vector(2.5, -3.45, 0.8) )
			self.VElements[ "holo8" ].pos = LerpVector( FrameTime() * 6, self.VElements[ "holo8" ].pos, Vector(2.5, -3, 1) )
			self.VElements[ "holo_circle_outer_0" ].pos = Vector(1.2, -3.55, 1)
			self.VElements[ "holo_circle_outer_1" ].pos = Vector(0.8, -3.25, 1)
			
			self.VElements[ "holo" ].color.a = 0
			self.VElements[ "holo++" ].color.a = 0
			self.VElements[ "holo_circle_outer_0" ].color.a = 0
			self.VElements[ "holo_circle_outer_1" ].color.a = 0
			self.VElements[ "holo7" ].color.a = 0
			self.VElements[ "holo7a" ].color.a = 0
			self.VElements[ "holo8" ].color.a = 0
			self.VElements[ "holo8a" ].color.a = 0
		end

		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetProjectileSpawnPos() + self.Owner:EyeAngles():Forward() * 32 + self.Owner:EyeAngles():Up() * 2
			dlight.r = core_color_default.r
			dlight.g = core_color_default.g
			dlight.b = core_color_default.b
			dlight.brightness = cmod
			dlight.Decay = 2048
			dlight.Size = 1 * iClip1 + 128 * cmod
			dlight.Style = 1				
			dlight.DieTime = CurTime() + 1
			dlight.noworld = false
			dlight.nomodel = false
		end
		
		mymat:SetVector( "$selfillumtint", Vector( 1, 1, 2 ) + ( Vector( 8, 12, 48 ) * cmod ) )
	end

	-- local bParticles = GetConVar( "sfw_fx_particles" ):GetBool()
	-- if ( bParticles ) then
		-- if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
			-- if ( self:GetNextCoreFxAnim() <= CurTime() ) then
				-- self:SetNextCoreFxAnim( CurTime() + 2 )
			-- end
		-- end
	-- end

	if ( self.Owner:KeyReleased( IN_ATTACK ) ) then
		if ( charge == self.ChargeMax ) && ( self:GetNextPrimaryFire() <= CurTime() ) && ( self.SciFiState ~= SCIFI_STATE_SPRINT ) then
			if ( SERVER || !game.SinglePlayer() ) then
				self:StopParticles()
				self:DefaultAttack()
				self:SetNextPrimaryFire( CurTime() + 0.46 )	
				self:SetCharge( 0 )
			end
		else
			if ( SERVER ) then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )
			end
		end
	end
	
	if ( CLIENT ) && ( self:GetNextPrimaryFire() > CurTime() ) && ( self.SciFiState != SCIFI_STATE_SPRINT ) then
		self:SetCharge( 0 )
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && iClip1 > 0 ) then
		if ( self:CanPrimaryAttack( 0, true ) ) then
			if ( self:GetCharge() < self.ChargeMax ) then
				self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
			end
			
			self.VElements[ "0+" ].angle = self.VElements[ "0+" ].angle + Angle( 0, 0, 1 ) * ( charge * 0.05 )
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
		
		self.VElements[ "0+" ].angle = LerpAngle( FrameTime() * 4, self.VElements[ "0+" ].angle, Angle(11, -3.701, 0) )
	end
	
	if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( charge >= 20 ) && ( self:GetNextPrimaryFire() + 0.22 <= CurTime() ) then
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() && CLIENT ) then
				if ( charge >= self.ChargeMax ) then 
					ParticleEffectAttach( "zeala_charged", 4, vm, vm:LookupAttachment("muzzle") )
				else
					ParticleEffectAttach( "zeala_charging", 4, vm, vm:LookupAttachment("muzzle") )
				end
			end
			
			if ( !game.SinglePlayer() ) then
				self:DoMuzzleEffect()
			end
		end
		
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( SERVER ) then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "shake" ) )
				if ( charge >= self.ChargeMax ) && ( IsValid( self.Owner ) && !self.Owner:HasGodMode() ) then
					local shield = self.Owner:Armor()
					if ( shield > 0 ) then
						self.Owner:SetArmor( shield - 1 )
					end
				end
			end
			self:SetNextChargeAnim( CurTime() + 0.18 )
		end
	
		if ( CLIENT ) then
			if ( charge >= 20 ) then
				EmitSound( "weapons/ancient/zeala_charge.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), math.Clamp( charge * 1.25, 20, 100 ) )
			end
		end
	end
		
	if ( CLIENT ) && ( self.Owner:KeyReleased( IN_ATTACK ) || self.Owner:KeyDown( IN_RELOAD ) ) then
		EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, 1, 60, bit.bor( SND_IGNORE_NAME, SND_STOP ), PITCH_NORM )
	end

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:Deploy() 

	self:SetAds( false, self.Owner )
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

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end

	local pOwnerAV 	= self.Owner:GetAimVector()
	local pOwnerEP 	= self.Owner:EyePos()
	local pOwnerEA 	= self.Owner:EyeAngles()
	local vmEntity 	= self:GetViewModelEnt()
	local vmAttach 	= vmEntity:LookupAttachment( "muzzle" )
	
	local origin = self:GetProjectileSpawnPos()
	
	if ( self.SciFiState == SCIFI_STATE_ADS ) then
		origin = pOwnerEP + ( pOwnerAV * 20 )
	end
	
	if ( SERVER ) then
		self:SetNextPrimaryFire( CurTime() + 0.1 )
		self.ScifiRegenNext = CurTime() + 1

		local ent = ents.Create( "zeala_nade" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( origin )
		ent:SetAngles( pOwnerEA )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * 2048  )
	end
	
	ParticleEffectAttach( "zeala_muzzle", 4, vmEntity, vmAttach )
	
	self:DrawMuzzleLight( "200 170 255 220", 140, 720, 0.075 )

	self:EmitSound( "scifi.zeala.fire" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -2, math.random( 0, 0.02 ), math.random( 0.01, 0.02 ) ) )
		self:AddSciFiACC( 16 )
		
		local drain = math.Clamp( self:Clip1(), 0, 100 )
		local delay = math.min( 32 / ( drain * 0.1 ), 3 )
		
		self:TakePrimaryAmmo( drain )
		self.ScifiRegenNext = CurTime() + delay
	end
	
	self:SetCharge( 0 )
	
	if ( CLIENT ) then
		self:SetCharge( 0 )
	end
	
	if ( SERVER ) then
		self:SetCharge( 0 )
	end
	
end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsNPC() ) then
		self:SetCharge( 100 )
		self:DefaultAttack()
		self:SetNextPrimaryFire( CurTime() + 1 )
		self:SetClip1( 0 )
	end

end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()
	
end