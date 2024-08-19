AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Forged of ancient alien relics, this weapon offers access to multiple elemental weapon systems at once.\n The Spectra offers fire, corrosive and ice projectiles as well as a blight-shock."
SWEP.Instructions			= "Press Mouse1 to fire, Hold and release Mouse1 to charge and fire a blight-shock. Press 'Use' (def. E) + Mouse1 or Mouse2 to switch elements. Press R to safely release a charged shot."
SWEP.ItemRank 				= 25

SWEP.ViewModel				= "models/weapons/c_scifip.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"
SWEP.HoldType 				= "pistol"
SWEP.HoldTypeNPC 			= "pistol"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 2
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.ViewModelFOV = 70

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "SciFiEnergy"

SWEP.VfxMuzzleParticle 		= "spectra_muzzle" 
SWEP.VfxMuzzleColor 		= Color( 200, 170, 255, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 560
SWEP.VfxHeatParticle 		= "spectra_muzzle_overheat"
SWEP.VfxHeatThreshold 		= 0.8
SWEP.VfxHeatDelay 			= 0

SWEP.PrintName				= "C-EP Spectra"
SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.AdsPos 				= Vector( 4.85, -4, 7 )
SWEP.AdsAng					= Angle( -1, 4, 22 )
SWEP.AdsFov 				= 55
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.ancient.sight.turnon"
SWEP.AdsSoundDisable		= "scifi.ancient.sight.turnoff"

SWEP.SafeModeOnSnd 	 		= "scifi.ancient.safety.on"
SWEP.SafeModeOffSnd 		= "scifi.ancient.safety.off"

SWEP.ViewModelHomePos		= Vector( 0, 0, 0 )

SWEP.ViewModelSprintPos		= Vector( 4, 2, 0.8 )
SWEP.ViewModelSprintAng		= Angle( -15, -10, 20 ) -- Angle( -5, -10, 20 )
--SWEP.SprintAnim				= false
SWEP.ViewModelShift = false

SWEP.MidairRecoilMul		= 1

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8
SWEP.ChargeMax				= 150
SWEP.ChargeAdd				= 2
SWEP.ChargeDrain			= 2
SWEP.ChargeDeltaCompensate 	= true

SWEP.ViewModelMeleePos		= Vector( 6, 1, -6 )
SWEP.ViewModelMeleeAng		= Angle( 18, 40, -45 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.45
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.DepletedSND			= ""

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.15

SWEP.SciFiFamily			= { "custom", "phys", "enerbow_cbeam", "modes_bfire", "nodas", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 8", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "AOE Range:		64", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Fire or Corrosive or Ice", color = Color( 220, 220, 220 ) },
	["3a"] = { text = "Status Chance: 20%", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 8.3 (semi-auto / charge)", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Energy drain: 	 2 (per shot)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate: 60", color = Color( 180, 180, 180 ) },
	["7"] = { text = "The projectile's element depends on the current firemode.", color = Color( 180, 180, 180 ) },
	["7+"] = { text = "Weapon can be charged if the trigger is held down.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Alt. damage: 		24", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Alt. damage-type: Entangling Blight", color = Color( 215, 160, 255 ) },
	["9a"] = { text = "Alt. range: 			220 units (in cone)", color = Color( 180, 180, 180 ) },
	["9b"] = { text = "Status Chance: 100%", color = Color( 180, 180, 180 ) },
	["9c"] = { text = "... Their return is to be feared ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 8,
		DamageType = { DMG_BURN, DMG_SF_CORROSIVE, DMG_SF_ICE },
		StatusChance = 20,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.1 },
		},
		ChargeRate = nil
	},
	Secondary = {
		DamageAmount = 24,
		DamageComposition = nil,
		DamageAttackRange = 220,
		DamageType = DMG_SF_BLIGHT,
		StatusChance = 100,
		ChargeRate = 2
	},
	CoreRechargeRate = 60,
	Recoil = 3,
	PerkSet = { SCIFI_PERK_RELOAD_RECHARGEAMMO, SCIFI_PERK_ELEMENTAL_FIRE, SCIFI_PERK_ELEMENTAL_CORROSIVE, SCIFI_PERK_ELEMENTAL_ICE, SCIFI_PERK_ELEMENTAL_BLIGHT, { PerkTitle = "Their return is to be feared", PerkDescription = "Primary attack can shift \nbetween elements.", PerkPanelHeight = 3, PerkColor = Color( 255, 20, 20 ) } }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.muzzle"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 10, -80) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5, -20, -40) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -10, 0) }
}

SWEP.VElements = {
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 0, -1.4), angle = Angle(0, 0, 90), size = Vector(0.12, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.244, 0.023, 1.475), angle = Angle(-8, -5.855, -90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, 4.375, 0.085), angle = Angle(-10, -5.855, 7.138), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, -0.11, -2.129), angle = Angle(-1, -5.855, 180), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["0+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 3.2, -2.25), angle = Angle(-2, -8, 90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "0+++", pos = Vector(-14, 0.72, 2.72), angle = Angle(50, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "0+++", pos = Vector(-15, 1.2, 3.4), angle = Angle(50, 0, 0), size = Vector(0.005, 0.005, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["7+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "", rel = "7", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 140), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+++", pos = Vector(-4, 3.14, 3.76), angle = Angle(82.703, 9.536, -1.053), size = Vector(0.004, 0.004, 0.004), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["8+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+++", pos = Vector(0, 2.864, 3.88), angle = Angle(82.703, 9.536, -1.053), size = Vector(0.008, 0.008, 0.008), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.244, 0.023, 1.875), angle = Angle(-10, -5.855, -90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, 3.6, 0.085), angle = Angle(-10, -5.855, 7.138), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, -0.11, -2.129), angle = Angle(-10, -5.855, 180), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 3, -2.25), angle = Angle(-2, -10, 90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local cmd_particles = GetConVar( "sfw_fx_particles" )

--local m_sin, m_random = math.sin, math.random

-- resource.AddSingleFile( "weapons/hwave/hwave_charge.wav" )
util.PrecacheSound( "weapons/hwave/hwave_charge.wav" )
-- resource.AddSingleFile( "common/NULL.wav" )
util.PrecacheSound( "common/NULL.wav" )

local limb_1_hpos = Vector(9.244, 0.023, 1.2)
local limb_2_hpos = Vector(8.654, 3.375, 1.085)
local limb_3_hpos = Vector(8.654, -0.11, -2.129)
local limb_1_hang = Angle(-8, -5.855, -80)
local limb_2_hang = Angle(-10, -5.855, 7.138)
local limb_3_hang = Angle(-1, -5.855, 180)

local limb_1_mpos = Vector(10, -1, -1.8)
local limb_2_mpos = Vector(10, 1.4, 3)
local limb_3_mpos = Vector(10, 4.4, -1.5)
local limb_1_mang = Angle(-180, -32, -90)
local limb_2_mang = Angle(20, -180, -12)
local limb_3_mang = Angle(-160, -5, 30)

local hangle

local core_invis = "vgui/white"
local core_vis = "models/weapons/misc/energy_surf"
local core_color_blight = Vector( 8, 6, 16 )
local core_color_fire = Vector( 8, 1, 0.2 ) -- Vector( 3, 0.4, 0.1 )
local core_color_crsv = Vector( 2, 6, 0.2 ) -- Vector( 1.2, 3, 0.2 )
local core_color_ice = Vector( 2, 4, 8 ) 	-- Vector( 2, 1.8, 3 )

local mymat =  Material( "models/weapons/spectra/spectra_bone_rtedit.vmt" )
local matCore = Material( "models/weapons/misc/energy_surf" )

local fNextParticleCast = 0
local dElemental = 0

SWEP.DataTables = {
	{ dType = "Int", dName = "Elemental" },
	{ dType = "Float", dName = "NextChargeAnim" },
	{ dType = "Float", dName = "NextCoreFxAnim" }
}

function SWEP:SubInit()

	self:SetCharge( 0 )
	self.ScifiRegenNext = 0
	self:SetElemental( 1 )

end

function SWEP:Think()

	local animtime = self:GetNextChargeAnim()	
	local vm = self.Owner:GetViewModel()
	local sine0 = math.sin( CurTime() * 16 ) / 8
	local sine1 = math.sin( CurTime() * 8 ) / math.random( 5, 10 )
	local sine2 = math.sin( CurTime() * 8 ) / math.random( 10, 20 )
	local fCharge = self:GetCharge()
	local cmod = fCharge * 0.01
	
	local fAnimSpeedFast, fAnimSpeedMedium = FrameTime() * 8, FrameTime() * 6

	self.VElements[ "0" ].pos = limb_1_hpos + Vector( -sine0, sine1 - cmod, sine2 )
	self.VElements[ "0+" ].pos = limb_2_hpos + Vector( sine0, sine1, -sine2 + cmod )
	self.VElements[ "0++" ].pos = limb_3_hpos + Vector( sine0, -sine1, sine2 - cmod )
	
	self.VElements[ "0" ].angle = limb_1_hang + Angle( -sine0, sine1, sine2 ) * cmod
	self.VElements[ "0+" ].angle = limb_2_hang + Angle( sine0, sine1, -sine2) * cmod
	self.VElements[ "0++" ].angle = limb_3_hang + Angle( sine0, -sine1, sine2 ) * cmod
--[[
	if ( self.SciFiMeleeCharge  > 0 ) then
		self.VElements[ "0" ].pos = limb_1_hpos + ( limb_1_mpos * self.SciFiMeleeCharge / 60 )
		self.VElements[ "0+" ].pos = limb_2_hpos + ( limb_2_mpos * self.SciFiMeleeCharge / 60 )
		self.VElements[ "0++" ].pos = limb_3_hpos + ( limb_3_mpos * self.SciFiMeleeCharge / 60 )
		
		self.VElements[ "0" ].angle = limb_1_hang + limb_1_mang * ( self.SciFiMeleeCharge / 60 )
		self.VElements[ "0+" ].angle = limb_2_hang + limb_2_mang * ( self.SciFiMeleeCharge / 60 )
		self.VElements[ "0++" ].angle = limb_3_hang + limb_3_mang * ( self.SciFiMeleeCharge / 60 )
	end
]]--
	local iClip = self:Clip1()
	
	if ( SERVER ) then
		if( self.ScifiRegenNext <= CurTime() ) and ( !self.Owner:KeyDown( IN_ATTACK ) ) then
			if ( iClip < self.Primary.ClipSize ) then 
				self:SetClip1( iClip + 1 ) 
			end
		end
		
		if ( iClip >= self.Primary.ClipSize + 1 ) then
			self:SetClip1( self.Primary.ClipSize )
		end
	end
	
	if ( self:GetSafeMode() ) then
		cmod = 0
		iClip = 0
		vm:StopParticles()
	end

	if ( CLIENT ) then
		if ( self.Owner:ShouldDrawLocalPlayer() ) then
			vm = self || self.Owner:GetActiveWeapon()
		end
		
		local pOwnerEA = self.Owner:EyeAngles()
		local fw = pOwnerEA:Forward()
		fw = fw * 26
		
		local dlightOrigin = self:GetProjectileSpawnPos() 
		dlightOrigin = dlightOrigin + fw
		
		local dlightScale = 1.2 * iClip + 128 * cmod
	
		local id = self:EntIndex()
		local dlight = DynamicLight( id )
		if ( dlight ) then
			dlight.pos = dlightOrigin
			dlight.r = 210
			dlight.g = 220
			dlight.b = 255
			dlight.brightness = 1 * cmod
			dlight.Decay = 2048
			dlight.Size = dlightScale
			dlight.Style = 1				
			dlight.DieTime = CurTime() + 1
			dlight.noworld = false
			dlight.nomodel = false
		end
		
		local core_color_actual = mymat:GetVector( "$selfillumtint" ) || Vector( 0, 0, 0 )

		if ( self:GetElemental() < 1 ) || ( fCharge >= 25 ) then
		--	mymat:SetVector( "$selfillumtint", core_color_blight )
			core_color_actual = LerpVector( fAnimSpeedMedium, core_color_actual, core_color_blight )
		elseif ( self:GetElemental() == 1 ) then
		--	mymat:SetVector( "$selfillumtint", core_color_fire )
			core_color_actual = LerpVector( fAnimSpeedMedium, core_color_actual, core_color_fire )
		elseif ( self:GetElemental() == 2 ) then
		--	mymat:SetVector( "$selfillumtint", core_color_crsv )
			core_color_actual = LerpVector( fAnimSpeedMedium, core_color_actual, core_color_crsv )
		elseif ( self:GetElemental() == 3 ) then
		--	mymat:SetVector( "$selfillumtint", core_color_ice )
			core_color_actual = LerpVector( fAnimSpeedMedium, core_color_actual, core_color_ice )
		end
		
		mymat:SetVector( "$selfillumtint", core_color_actual )

		if ( self:GetNextCoreFxAnim() >= CurTime() ) then
			fNextParticleCast = self:GetNextCoreFxAnim()
		end
		
		local bParticles = cmd_particles:GetBool()
		if ( bParticles ) then
			local iElemental = self:GetElemental()
			
			if !( iElemental == dElemental ) then
				vm:StopParticles()
				fNextParticleCast = CurTime()
			end

			if ( fNextParticleCast <= CurTime() ) then
				local att = vm:LookupAttachment( "muzzle" )
	--			debugoverlay.Line( vm:GetAttachment( att ).Pos, self.Owner:EyePos(), 2, Color( 255, 0, 255, 255 ), true )
	
				if ( iElemental < 1 ) || ( fCharge >= 25 ) then
					ParticleEffectAttach( "spectra_core", 4, vm, att )
				elseif ( iElemental == 1 ) then
					ParticleEffectAttach( "spectra_core_fire", 4, vm, att )
				elseif ( iElemental == 2 ) then
					ParticleEffectAttach( "spectra_core_crsv", 4, vm, att )
				elseif ( iElemental == 3 ) then
					ParticleEffectAttach( "spectra_core_ice", 4, vm, att )
				end
			
				fNextParticleCast = CurTime() + 2
		--		self:SetNextCoreFxAnim( CurTime() + 2 )
			end
		
			self.VElements[ "5" ].material = core_invis
		else
			self.VElements[ "5" ].material = core_vis
			self.VElements[ "5" ].pos = Vector(6, 0.4, -1.5) + Vector( sine0, sine1, sine2 )
			self.VElements[ "5" ].angle = self.VElements[ "5" ].angle + Angle( sine0, sine1, sine2 )
			self.VElements[ "5" ].size = Vector( 0.0024, 0.0024, 0.0024 ) * ( iClip ) * ( 1 + cmod )
			self.VElements[ "5" ].color = core_color_actual:ToColor()
		
			local scale = 0.18 + 0.5 * ( fCharge/ self.ChargeMax )
			matCore:SetFloat( "$FleshBorderWidth", scale )
			matCore:SetVector( "$FleshBorderTint", core_color_actual )
			
			--[[
			if ( self:GetElemental() < 1 ) || ( fCharge >= 25 ) then
				self.VElements[ "5" ].color = core_color_blight:ToColor()
			elseif ( self:GetElemental() == 1 ) then
				self.VElements[ "5" ].color = core_color_fire:ToColor()
			elseif ( self:GetElemental() == 2 ) then
				self.VElements[ "5" ].color = core_color_crsv:ToColor()
			elseif ( self:GetElemental() == 3 ) then
				self.VElements[ "5" ].color = core_color_ice:ToColor()
			end
			]]--
		end
		
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			hangle = LerpAngle( fAnimSpeedFast, self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle, Angle(10, 10, -40) )
			self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle = hangle
			self.VElements[ "8" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "8" ].color.a, 255 )
			self.VElements[ "8+" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "8+" ].color.a, 255 )
			self.VElements[ "6" ].color.a = Lerp( fAnimSpeedMedium, self.VElements[ "6" ].color.a, 255 )
			self.VElements[ "6" ].size = Vector(0.005, 0.005, 0.001) * ( 1 + cmod )

			if ( self:GetElemental() < 1 ) || ( fCharge >= 25 ) then
				self.VElements[ "6" ].color = core_color_blight:ToColor()
			elseif ( self:GetElemental() == 1 ) then
				self.VElements[ "6" ].color = core_color_fire:ToColor()
			elseif ( self:GetElemental() == 2 ) then
				self.VElements[ "6" ].color = core_color_crsv:ToColor()
			elseif ( self:GetElemental() == 3 ) then
				self.VElements[ "6" ].color = core_color_ice:ToColor()
			end
			
			self.VElements[ "7" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "7" ].color.a, 220 )
			self.VElements[ "7+" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "7+" ].color.a, 20 )
			self.VElements[ "7+" ].size = self.VElements[ "7" ].size * ( iClip / 100 )
		else
			hangle = LerpAngle( fAnimSpeedFast, self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle, Angle(10, 10, -80) )
			self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle = hangle
			self.VElements[ "8" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "8" ].color.a, 0 )
			self.VElements[ "8+" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "8+" ].color.a, 0 )
			self.VElements[ "6" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "6" ].color.a, 0 )
			self.VElements[ "7" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "7" ].color.a, 0 )
			self.VElements[ "7+" ].color.a = Lerp( fAnimSpeedFast, self.VElements[ "7+" ].color.a, 0 )
		end
		
		dElemental = self:GetElemental()
	end
	
	if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && iClip > 0 ) then
		if ( self:GetCharge() < self.ChargeMax ) then
			self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end

	if ( self.Owner:KeyReleased( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) ) && ( self:GetNextPrimaryFire() <= CurTime() ) && ( self.SciFiState ~= SCIFI_STATE_SPRINT ) then
		if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
			if ( fCharge >= 100 ) then
				self:ChargedAttack()
				self:SetNextPrimaryFire( CurTime() + 0.2 )	
			else
				self:DefaultAttack()
				self:SetNextPrimaryFire( CurTime() + 0.11 )	
			end	
			self:SetCharge( 0 )
		end
	end
	
	if ( CLIENT ) && ( self:GetNextPrimaryFire() > CurTime() ) && ( self.SciFiState ~= SCIFI_STATE_SPRINT ) then
		self:SetCharge( 0 )
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( fCharge >= 25 ) && ( self:GetNextPrimaryFire() + 0.22 <= CurTime() ) then
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) && ( fCharge >= 40 ) then
				ParticleEffectAttach( "spectra_charging", 4, vm, vm:LookupAttachment("muzzle") )
			end
		end
		
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( SERVER ) then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle01" ) )
			end
			self:SetNextChargeAnim( CurTime() + 0.8 )
		end
	
		if ( CLIENT ) then
			if ( fCharge >= 40 ) then
				EmitSound( "weapons/hwave/hwave_charge.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), math.Clamp( fCharge* 0.75, 0, 150 ) )
			end
		end
	end
		
	if ( CLIENT ) && ( self.Owner:KeyReleased( IN_ATTACK ) ) then
		EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, self.Owner:EntIndex(), 60, bit.bor( SND_IGNORE_NAME, SND_STOP ), PITCH_NORM )
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
	
	self.SciFiState = SCIFI_STATE_IDLE
	self.SciFiMeleeCharge = 0
	
	local vm = self:GetViewModelEnt()
	if ( CLIENT ) then
		local fCharge = self:GetCharge()
	
		local bParticles = GetConVar( "sfw_fx_particles" ):GetBool()
		if ( bParticles ) then
			if ( self:GetElemental() < 1 ) || ( fCharge >= 25 ) then
				ParticleEffectAttach( "spectra_core", 4, vm, vm:LookupAttachment("muzzle") )
				mymat:SetVector( "$selfillumtint", core_color_blight )
			elseif ( self:GetElemental() == 1 ) then
				ParticleEffectAttach( "spectra_core_fire", 4, vm, vm:LookupAttachment("muzzle") )
				mymat:SetVector( "$selfillumtint", core_color_fire )
			elseif ( self:GetElemental() == 2 ) then
				ParticleEffectAttach( "spectra_core_crsv", 4, vm, vm:LookupAttachment("muzzle") )
				mymat:SetVector( "$selfillumtint", core_color_crsv )
			elseif ( self:GetElemental() == 3 ) then
				ParticleEffectAttach( "spectra_core_ice", 4, vm, vm:LookupAttachment("muzzle") )
				mymat:SetVector( "$selfillumtint", core_color_ice )
			end
		else
			ParticleEffectAttach( "spectra_core", 4, vm, vm:LookupAttachment("muzzle") )
		end	
		
		if ( self:GetElemental() < 1 ) || ( fCharge >= 25 ) then
			mymat:SetVector( "$selfillumtint", core_color_blight )
		elseif ( self:GetElemental() == 1 ) then
			mymat:SetVector( "$selfillumtint", core_color_fire )
		elseif ( self:GetElemental() == 2 ) then
			mymat:SetVector( "$selfillumtint", core_color_crsv )
		elseif ( self:GetElemental() == 3 ) then
			mymat:SetVector( "$selfillumtint", core_color_ice )
		end
		
		fNextParticleCast = CurTime() + 2
	--	self:SetNextCoreFxAnim( CurTime() + 2 )
	end

	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) and ( IsValid(self.Owner) ) and ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	mymat:SetVector( "$selfillumtint", core_color_blight )
	matCore:SetVector( "$selfillumtint", Vector( 1.2, 1.3, 2 ) )
	matCore:SetVector( "$FleshBorderTint", Vector( 1.2, 1.3, 2 ) )
	
	if ( SERVER ) || ( !game.SinglePlayer() ) then
		self:StopParticles()
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

function SWEP:DefaultOnIceUnderWater()

	if ( self.Owner:WaterLevel() < 3 ) || ( self:GetElemental() ~= 3 ) then return end
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.12 )
	self.ScifiRegenNext = CurTime() + 1
	
	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
		local ent = ents.Create( "prop_physics" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() + ( self.Owner:GetAimVector() * 32 ) )
		ent:SetModel( "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl" )
		ent:SetMaterial( "models/elemental/frozen_alpha" )
		ent:SetAngles( self.Owner:EyeAngles() + Angle( 180, 0, 10 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:SetMaterial( "gmod_ice" )
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 16000 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 1 + self:GetSciFiACC() ) )
		
		SafeRemoveEntityDelayed( ent, 8 )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 3 )
	end
	
	ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )

	self:EmitSound( "scifi.spectra.fire2" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
		local iClip = self:Clip1()
		local drain = math.Clamp( iClip, 0, 2 )
		local delay = math.min( 1.6 / ( drain * 0.1 ), 1 )
		
		self:TakePrimaryAmmo( drain )
		self.ScifiRegenNext = CurTime() + delay

		self:AddSciFiACC( 1 )
	end
	
end

function SWEP:DefaultAttack()

	self:DefaultOnIceUnderWater()
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.12 )
	
	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
		local ent = ents.Create( "spectra_pfire" )
		if ( !IsValid( ent ) ) then return end

		if (self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 20 ) )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		ent:SetNWInt( "Elemental", self:GetElemental() )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 34000 + self:GetProjectileSpreadVector() * ( 28 + self:GetSciFiACC() * 20 ) )
		
		if ( self.Owner:WaterLevel() == 3 ) then
			phys:EnableDrag( true )
			phys:SetDragCoefficient( 10000 )
		end
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 3 )
	end
	
	--ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	
	self:DoMuzzleEffect()

	if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) && ( self:GetSciFiACC() >= ( GetConVarNumber( "sfw_sk_maxacc" ) * 0.6 ) && self:GetElemental() == 1 ) then
		ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	end

	self:EmitSound( "scifi.spectra.fire2" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
		local iClip = self:Clip1()
		local drain = math.Clamp( iClip, 0, 2 )
		local delay = math.min( 1.6 / ( drain * 0.1 ), 1 )
		
		self:TakePrimaryAmmo( drain )
		self.ScifiRegenNext = CurTime() + delay

		self:AddSciFiACC( 1 )
	end
	
end

function SWEP:ChargedAttack()

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.32 )
	
	local viewmodel = self:GetViewModelEnt()
	local fDamageAmp = GetConVar( "sfw_damageamp" ):GetFloat()
	local bDmg = 24 * fDamageAmp
	
	if ( SERVER ) then
		for k, v in pairs ( ents.FindInCone( self.Owner:EyePos(), self.Owner:GetAimVector(), 220, 0 ) ) do
			if ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) && ( v:VisibleVec( self.Owner:EyePos() ) ) then
				DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 2, Attacker = self.Owner } )
				
				local tPosition = v:EyePos()
				local oPosition = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 12 )
				local tDistance = tPosition:Distance( oPosition )
				
				local iDmg = bDmg - ( tDistance / 10 )
				
				if ( v:IsPlayer() || v:IsNPC() ) then
					self:DealDirectDamage( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ), iDmg, v, self.Owner, self.Owner:GetAimVector() * 24650 )
				else
					v:TakeDamage( iDmg, self.Owner, self )
				end
				
				local phys = v:GetPhysicsObject()
				if ( IsValid( phys ) ) then
					phys:ApplyForceCenter( self.Owner:GetAimVector() * 24650 )
				end
			end
		end
		util.ScreenShake( self:GetPos(), 256, 64, 0.8, 256)
	end
	
	if ( SERVER ) || ( !game.SinglePlayer() ) then
		self:EmitSound( "scifi.ancient.bshock" )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -6, -6 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) )
		self:AddSciFiACC( 12 )
	end
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttach = vmEntity:LookupAttachment( self.VfxMuzzleAttachment )
	local vmOrigin = vmEntity:GetAttachment( vmAttach ).Pos

	local ed = EffectData()
	ed:SetOrigin( vmOrigin )
	ed:SetEntity( self )
	ed:SetAttachment( vmAttach )
	
	util.Effect( "spectra_blast", ed )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	local iClip = self:Clip1()
	local drain = math.Clamp( iClip, 0, 30 )
	local delay = math.min( 8 / ( drain * 0.1 ), 2 )
	
	self:TakePrimaryAmmo( drain )
	self.ScifiRegenNext = CurTime() + delay
		
	self:SetCharge( 0 )
	self:AddSciFiACC( 3 )

end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsPlayer() ) then
		if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( self.Owner:KeyDown( IN_USE ) ) then
			if ( self:GetElemental() > 1 ) then 
				self:SetElemental( self:GetElemental() - 1 )
			else
				self:SetElemental( 3 )
			end
			self:SetNextPrimaryFire( CurTime() + 0.2 )
			
			local viewmodel = self:GetViewModelEnt()
			ParticleEffectAttach( "spectra_fmchange", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
			self:EmitSound( "scifi.spectra.fm.dn" )
			
			self:SetNextCoreFxAnim( CurTime() )
		end
	else
		self:SetElemental( math.random( 1, 3 ) )
	
		local tEntity = self.Owner:GetTarget()
		if ( !IsValid( tEntity ) ) then
			tEntity = self.Owner:GetEnemy()
		end
		
		if ( IsValid( tEntity ) ) then
			local tEyes = tEntity:EyePos()
			local tDist = tEyes:Distance( self.Owner:EyePos() )

			if ( tDist <= 200 ) then
				self:ChargedAttack()
			else
				self:DefaultAttack()
			end
		else
			self:DefaultAttack()
		end
		
		self:SetClip1( self.Primary.ClipSize )
	end

end

function SWEP:SecondaryAttack()

	if ( self.Owner:KeyDown( IN_ATTACK2 ) ) && ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetElemental() < 3 ) then 
			self:SetElemental( self:GetElemental() + 1 )
		else
			self:SetElemental( 1 )
		end
		self:SetNextSecondaryFire( CurTime() + 0.2 )
		
		local viewmodel = self:GetViewModelEnt()
		ParticleEffectAttach( "spectra_fmchange", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.spectra.fm.up" )
	
		self:SetNextCoreFxAnim( CurTime() )
	end

end

function SWEP:Reload()

	if ( SERVER ) then
		self:SendWeaponAnim( ACT_VM_IDLE )
	end

--	self:SetNextPrimaryFire( CurTime() + 0.5 )	
--	self:SetNextChargeAnim( CurTime() + 0.5 )
	
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

end