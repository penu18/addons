AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "A standard issue alien smg, featuring a moderate accuracy and damage."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to aim down sights. Will overheat on continuous firing."
SWEP.ItemRank 				= 26

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "smg"
SWEP.DeploySpeed 			= 2.8
SWEP.SciFiSkin				= "dev/hide"
SWEP.SciFiSkin_1			= "dev/hide"
SWEP.SciFiWorld 			= "dev/hide"

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

SWEP.PrintName				= "C-CE Prisma"
SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.ViewModelFOV 			= 54

SWEP.MidairRecoilMul		= 1

SWEP.AdsPos 				= Vector(-3.67, -2, 1.99)
SWEP.AdsFov					= 56
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.ancient.sight.turnon"
SWEP.AdsSoundDisable		= "scifi.ancient.sight.turnoff"

SWEP.SafeModeOnSnd 	 		= "scifi.ancient.safety.on"
SWEP.SafeModeOffSnd 		= "scifi.ancient.safety.off"

SWEP.ViewModelMeleePos		= Vector( 18, 10, -7 )
SWEP.ViewModelMeleeAng		= Angle( 30, 70, -40 )

SWEP.DefaultSwayScale		= 1.2
SWEP.DefaultBobScale		= 1.6

SWEP.SprintSwayScale		= 0
SWEP.SprintBobScale			= 0
SWEP.SprintAnimSpeed		= 12

SWEP.ViewModelSprintPos		= Vector( 2, -2, 0 )
SWEP.ViewModelSprintAng		= Angle( -10, 25, -15 )
SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( -0.025, -0.02, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )
SWEP.ViewModelSwayDirection = Vector( -0.5, 4, 0.2 )
SWEP.ViewModelSprintRatio 	= 0.82
SWEP.ViewModelSprintSway 	= 4

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8

SWEP.ChargeOverheat			= 120
SWEP.ChargeMax				= 150
SWEP.ChargeAdd				= 0.8
SWEP.ChargeDrain			= 0.8
SWEP.ChargeDeltaCompensate 	= true

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.45
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"

SWEP.NPCAccuracy 			= 200
SWEP.NPCSkillLevel 			= 1.4
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.4

SWEP.DepletedSND			= ""

SWEP.SciFiFamily			= { "custom", "phys", "ads", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 8", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				x1.5", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Bullet", color = Color( 185, 180, 160 ) },
	["5"] = { text = "Fire rate: 				 11.1 (full-auto)", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Energy drain: 	 2 (per shot)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate: 60", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Overheats on continuous fire.", color = Color( 180, 180, 180 ) },
	["9c"] = { text = "... They ask for your allegiance, and you shall give it ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 8,
		DamageType = DMG_BULLET,
		CritMul = 1.5,
		StatusChance = nil,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.08 }
		},
		ChargeRate = nil
	},
	CoreRechargeRate = 60,
	Recoil = 3,
	PerkSet = { SCIFI_PERK_RELOAD_RECHARGEAMMO, SCIFI_PERK_RELOAD_OVERHEAT, { PerkTitle = "Unbroken Loyalty", PerkDescription = "Shots have minor target acquisition and\ndeal a small fraction of splash damage.", PerkPanelHeight = 3, PerkColor = Color( 255, 20, 20 ) } }
}

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 2, -0.4 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, -1, -1), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, -0.4), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(0, 0, 0, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(18, -0.5, -2.8), angle = Angle(12.473, 94.843, 12), size = Vector(0.625,0.815, 0.611), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(19.0, -1.38, -5.3), angle = Angle(-171, 97.27, -3.25), size = Vector(0.572, 1.175, 0.63), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(5.501, -0.7, -0.738), angle = Angle(37.598, -163.959, -11.36), size = Vector(0.291, 0.31, 0.573), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(5.587, 2.214, -1.397), angle = Angle(5.843, -160.482, -113.377), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["1a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(4.586, 0.356, -4.532), angle = Angle(10.685, -176.204, 93.075), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["1c"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(3.457, 0.358, -2.921), angle = Angle(8.51, -179.655, 95.981), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(6.403, 1.667, -2.631), angle = Angle(5.843, -167.542, -131.265), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(5.277, 2.157, 1.333), angle = Angle(134.783, 19.944, -11.235), size = Vector(0.218, 0.184, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(1.725, 2.7, -3), angle = Angle(174.811, 8.178, -9.08), size = Vector(0.37, 0.279, 0.37), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(6, 0, -1.4), angle = Angle(0, 0, 90), size = Vector(0.12, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
--	["4a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 0, -1.4), angle = Angle(0, 0, 90), size = Vector(0.14, 0.14, 0.14), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf_aftershock", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "3", pos = Vector(-4, -1.45, 3.435), angle = Angle(82.703, 9.536, -1.053), size = Vector(0.004, 0.004, 0.004), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["5a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "3", pos = Vector(0, -1.434, 3.525), angle = Angle(82.703, 9.536, -1.053), size = Vector(0.005, 0.005, 0.005), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "3", pos = Vector(-1, -2, 3.2), angle = Angle(80, 20, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["7a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "7", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 40), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "3", pos = Vector(-1, -0.9, 2.99), angle = Angle(80, -20, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["8a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "8", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18, -0.5, -4.2), angle = Angle(12.473, 94.843, 11), size = Vector(0.625,0.815, 0.611), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.0, -0.38, -7), angle = Angle(-171, 94, -5.25), size = Vector(0.572, 1.175, 0.63), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.501, -0.7, -1.738), angle = Angle(37.598, -163.959, -11.36), size = Vector(0.291, 0.31, 0.573), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.587, 2.214, -2.397), angle = Angle(5.843, -160.482, -113.377), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["1a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.586, 0.356, -5.532), angle = Angle(10.685, -176.204, 93.075), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["1c"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.457, 0.358, -3.921), angle = Angle(8.51, -179.655, 95.981), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.403, 1.667, -3.631), angle = Angle(5.843, -167.542, -131.265), size = Vector(0.351, 0.203, 0.204), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.277, 2.157, 2.333), angle = Angle(134.783, 19.944, -11.235), size = Vector(0.218, 0.184, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.725, 2.7, -4), angle = Angle(174.811, 8.178, -9.08), size = Vector(0.37, 0.279, 0.37), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- resource.AddSingleFile( "common/NULL.wav" )
util.PrecacheSound( "common/NULL.wav" )

local snd_unstable = Sound( "weapons/ancient/spectra_flyby.wav" )

local limb_1_hpos = Vector(3.457, 0.358, -2.8)
local limb_2_hpos = Vector(4.586, -0.12, -4.2)
local limb_3_hpos = Vector(5.587, 2.4, -1.1)
local limb_4_hpos = Vector(6.403, 2.2, -2.631)
local barrel_1_hpos = Vector(18, -0.5, -2.8)
local barrel_2_hpos = Vector(19.0, -1.38, -5.3)
local limb_1_hang = Angle(8.51, -179.655, 95.981)
local limb_2_hang = Angle(10.685, -180.204, 95.075)
local limb_3_hang = Angle(5.843, -160.482, -113.377)
local limb_4_hang = Angle(5.843, -160.542, -131.265)
local core_hpos = Vector(6, 0.6, -3.2)
local core_hscale = Vector( 0.001, 0.001, 0.001 )

local mymat = Material( "models/weapons/spectra/spectra_bone_rtedit.vmt" )
local matCore = Material( "models/weapons/misc/energy_surf" )

local core_color_default = Color( 120, 130, 255 ) -- Color( 190, 215, 255 )
local core_color_actual = core_color_default
local bone_color_default = Vector( 1, 1, 2 ) -- Vector( 0.7, 0.8, 1 ) -- Vector( 2, 2, 2 )

function SWEP:SubInit()

	self:SetCharge( 0 )
	self.ScifiRegenNext = 0
	
end

function SWEP:Think()

	if ( IsValid( self.Owner ) && self.Owner:InVehicle() ) then return end

	local vm = self.Owner:GetViewModel()
	local sine0 = math.sin( CurTime() * 8 ) / 16
	local sine1 = math.sin( CurTime() * 4 ) / 20
	local sine2 = math.sin( CurTime() * 4 ) / 40
	local cmod = self:GetCharge() / 250
	local cmod2 = self:GetCharge() - self.ChargeOverheat
	
	local iClip1 = self:Clip1()

	if ( SERVER ) then
		if( self.ScifiRegenNext <= CurTime() ) && ( !bIsTriggerHeld ) then
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
		cmod2 = 0
		iClip1 = 0
	end
	
	self.VElements[ "1c" ].pos = limb_1_hpos + Vector( sine0, sine1 - cmod, sine2 )
	self.VElements[ "1a" ].pos = limb_2_hpos + Vector( sine0, sine1 - cmod, -sine2 - cmod )
	self.VElements[ "1b" ].pos = limb_3_hpos + Vector( sine0, -sine1 + cmod, sine2 )
	self.VElements[ "1+" ].pos = limb_4_hpos + Vector( -sine0, -sine1 + cmod, sine2 - cmod )
	self.VElements[ "0" ].pos = barrel_1_hpos + Vector( 0 , 0, sine2 + cmod )
	
	self.VElements[ "1c" ].angle = limb_1_hang + Angle( -sine0, sine1, sine2 ) * cmod
	self.VElements[ "1a" ].angle = limb_2_hang + Angle( sine0, sine1, -sine2) * cmod
	self.VElements[ "1b" ].angle = limb_3_hang + Angle( sine0, -sine1, sine2 ) * cmod
	self.VElements[ "1+" ].angle = limb_4_hang + Angle( -sine0, -sine1, sine2 ) * cmod

	self.VElements[ "4" ].pos = core_hpos + Vector( sine0, -sine1, sine2 )
--	self.VElements[ "4" ].angle = self.VElements[ "4" ].angle + Angle( sine0, sine1, sine2 ) * 16
	self.VElements[ "4" ].size = core_hscale * ( 15 + iClip1 * 0.85 ) * ( 1 + cmod )
	
	
	if ( CLIENT ) then
		if ( game.SinglePlayer() ) || ( !game.SinglePlayer() && IsFirstTimePredicted() ) then
			local fAnimSpeedFast, fAnimSpeedMedium = FrameTime() * 8, FrameTime() * 6
			
			if ( !game.SinglePlayer() ) then
				fAnimSpeedFast = fAnimSpeedFast * 1.6
				fAnimSpeedMedium = fAnimSpeedMedium * 1.6
			end
			
			if ( self.SciFiState == SCIFI_STATE_ADS ) then
				self.VElements[ "7" ].pos = LerpVector( fAnimSpeedMedium, self.VElements[ "7" ].pos, Vector(-1, -2, 3.2 ) )
				self.VElements[ "8" ].pos = LerpVector( fAnimSpeedMedium, self.VElements[ "8" ].pos, Vector(-1, -0.9, 3.2 ) )
				
				self.VElements[ "5" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "5" ].color.a, 255 )
				self.VElements[ "5a" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "5a" ].color.a, 255 )
				self.VElements[ "7" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "7" ].color.a, 255 )
				self.VElements[ "7a" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "7a" ].color.a, 40 )
				self.VElements[ "8" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "8" ].color.a, 255 )
				self.VElements[ "8a" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "8a" ].color.a, 255 )
				
				self.VElements[ "7a" ].size = Vector( 0.004, 0.004, 0.001 ) * ( iClip1 * 0.01 )
				self.VElements[ "8a" ].size = Vector( 0.004, 0.004, 0.001 ) * ( cmod * 1.7 )
				
				self.VElements[ "0+" ].pos = barrel_2_hpos + Vector( 0, 0, -sine2 - ( cmod / 4 ) )
			else
				self.VElements[ "7" ].pos = LerpVector( FrameTime() * 4, self.VElements[ "7" ].pos, Vector(-4, -1.45, 3.435) )
				self.VElements[ "8" ].pos = LerpVector( FrameTime() * 4, self.VElements[ "8" ].pos, Vector(-4, -1.45, 3.435) )
				
				self.VElements[ "5" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "5" ].color.a, 0 )
				self.VElements[ "5a" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "5a" ].color.a, 0 )
				self.VElements[ "7" ].color.a = Lerp( fAnimSpeedMedium, self.VElements[ "7" ].color.a, 0 )
				self.VElements[ "7a" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "7a" ].color.a, 0 )
				self.VElements[ "8" ].color.a = Lerp( fAnimSpeedMedium, self.VElements[ "8" ].color.a, 0 )
				self.VElements[ "8a" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "8a" ].color.a, 0 )
				
				self.VElements[ "0+" ].pos = barrel_2_hpos + Vector( 0, 0, -sine2 - cmod )
			end
		end
		
		local pOwnerEA = self.Owner:EyeAngles()
		local lightorigin = self:GetProjectileSpawnPos() + pOwnerEA:Forward() * 24 + pOwnerEA:Up() * 4
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			lightorigin = self.Owner:GetShootPos() + pOwnerEA:Forward() * 24 + pOwnerEA:Up() * -6
		end
		
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = lightorigin
			dlight.r = core_color_actual.r
			dlight.g = core_color_actual.g
			dlight.b = core_color_actual.b
			dlight.brightness = 0.1 + cmod
			dlight.Decay = 2048
			dlight.Size = 0.6 * iClip1 + 128 * cmod
			dlight.Style = 1				
			dlight.DieTime = CurTime() + 1
			dlight.noworld = false
			dlight.nomodel = false
		end

		if ( self:GetCharge() >= self.ChargeOverheat ) then
			mymat:SetVector( "$selfillumtint", Vector( 1, 1, 1 ) + ( Vector( 2.4, 0.44, 0.12 ) * cmod2 ) )
			dlight.brightness = 1 + cmod
			core_color_actual.r = Lerp( FrameTime() * 8, core_color_actual.r, 255 )
			core_color_actual.g = Lerp( FrameTime() * 8, core_color_actual.g, 120 )
			core_color_actual.b = Lerp( FrameTime() * 8, core_color_actual.b, 120 )
		else
			mymat:SetVector( "$selfillumtint", bone_color_default )
			core_color_actual.r = Lerp( FrameTime() * 6, core_color_actual.r, 120 )
			core_color_actual.g = Lerp( FrameTime() * 6, core_color_actual.g, 130 )
			core_color_actual.b = Lerp( FrameTime() * 6, core_color_actual.b, 255 )
		end
	end

	local bIsTriggerHeld = self.Owner:KeyDown( IN_ATTACK )

	if ( bIsTriggerHeld && iClip1 > 0 && self.Owner:WaterLevel() < 3 && !( self:GetSciFiState() == SCIFI_STATE_SPRINT ) ) then
		if ( self:GetCharge() < self.ChargeMax ) then
			self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end
	
	if ( CLIENT ) then
		local scale = 0.05 * ( iClip1 * 0.01 ) * ( 1 + cmod )

		matCore:SetFloat( "$FleshBorderWidth", scale )
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
	
	if ( self.Owner:IsNPC() ) then
		self:SetClip1( self.Primary.ClipSize )
	end
	
	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( IsValid( self.Owner ) ) && ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	mymat:SetVector( "$selfillumtint", bone_color_default )
	
	self:ResetDeployment()
	self:SetSciFiACC( 4 )
	return true

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	-- if ( self:GetNextPrimaryFire() > CurTime() ) then return end

	local vmEntity = self:GetViewModelEnt()
	local vmAttach = vmEntity:LookupAttachment( "muzzle" )
	local IsAds = self.SciFiState == SCIFI_STATE_ADS
	
	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		if ( self:GetCharge() >= 130 ) then
			self:SetNextPrimaryFire( CurTime() + 0.6 )
			self.ScifiRegenNext = CurTime() + 2

	--		self.Charge = 50
	
			self:EmitSound( "scifi.ancient.overheat" )
			return
		end
	end
	
	local vSpread = self:GetProjectileSpreadVector()
	
	if ( SERVER ) then
		local pOwnerAV = self.Owner:GetAimVector()
		
		if ( self.Owner:IsNPC() ) then
			pOwnerAV = self.NPCAimVectorOverride
			self.Owner:SetSaveValue( "m_flLastAttackTime", ( CurTime() + 0.04 ) * -1 )
			self.Owner:SetSaveValue( "m_flNextAttack", 0.04 )
			self:SetNextPrimaryFire( CurTime() + 0.04 )
			
			if ( !timer.Exists( "prisma_bfire"..self:EntIndex() ) ) then
				timer.Create( "prisma_bfire"..self:EntIndex(), 0.1, 4, function() 
					if ( !IsValid( self ) || !IsValid( self.Owner ) || !self:CanPrimaryAttack( 0, true ) ) then return end
					if ( !IsValid( self.Owner:GetEnemy() ) ) then return end
					
					self:PrimaryAttack()
				end )
				
				return
			end
		end
			
		local ent = ents.Create( "spectra_pfire" )
		if ( !IsValid( ent ) ) then return end
		if ( !IsAds ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( self.Owner:EyePos() + ( pOwnerAV * 20 ) )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * 32000 + vSpread * ( 56 + self:GetSciFiACC() * 16 ) )
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
			
	self:EmitSound( "scifi.spectra.fire1.nosilence" )
	-- self:EmitSound( "scifi.spectra.fire2" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
		-- self.Owner:ViewPunch( vSpread:Angle() * -( 0.0001 + self:GetSciFiACC() * 0.0001 ) )
		self.Owner:ViewPunch( Angle( math.random( -50, -60 ), math.random( -20, 20 ), 0 ) * ( 0.004 + self:GetSciFiACC() * 0.001 ) )
		
		local drain = math.Clamp( self:Clip1(), 0, 2 )
		local delay = math.min( 1.6 / ( drain * 0.1 ), 1 )
		
		self:TakePrimaryAmmo( drain )
		self.ScifiRegenNext = CurTime() + delay
	
		self:SetNextPrimaryFire( CurTime() + 0.08 )
		
		self:AddSciFiACC( 3 )
	end
	
end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()
	
end

function SWEP:DoImpactEffect( tTrace, iDamageType )

	-- if ( tr.HitSky ) then return end

	return true

end