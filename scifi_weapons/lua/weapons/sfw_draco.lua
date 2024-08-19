AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Popular among union elite forces, the 'Draco' combat rifle is a semi-automatic alternative to the classic HS24 series, trading fire-rate for projectile flight speed and critical damage."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to zoom."
SWEP.ItemRank 				= 17

SWEP.PrintName				= "HS46-C 'Draco' Carbine"
SWEP.Slot					= 2
SWEP.SlotPos				= 2

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.SciFiSkin				= "models/weapons/hornet/skin"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_edit.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_phurt.vmt" )
end

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "AR2"

SWEP.VfxMuzzleParticle 		= "drake_muzzle"
SWEP.VfxMuzzleColor 		= Color( 255, 60, 20, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720

SWEP.ProjectileSpreadY 		= Vector( -1, 1 )
SWEP.ProjectileSpreadZ 		= Vector( -1, 10 )

SWEP.ReloadSND				= "scifi.hwave.reload_new" 
SWEP.ReloadACT				= ACT_VM_IDLE_TO_LOWERED --ACT_VM_RELOAD
SWEP.ReloadTime 			= 1

SWEP.AdsPos 				= Vector(-4.435, 2, 1.155)
SWEP.AdsFov					= 32
SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -1, -1, 1 )
SWEP.ViewModelReloadAng		= Angle( -8, 1, -2 )

SWEP.ViewModelSprintPos		= Vector( 3, -2, 0.5 )
SWEP.ViewModelSprintAng		= Angle( -10, 25, -25 )

SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 2
SWEP.ViewModelSwayDirection = Vector( -0.5, 12, 1 )
SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.2 )
SWEP.SprintAnimSpeed		= 12
SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0

SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.2
SWEP.ViewModelShiftOffset 	= Vector( 0, -0.04, -0.09 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )

SWEP.NPCAccuracy 			= 100
SWEP.NPCSkillLevel 			= 1.1
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.1

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 14", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x4", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Phaseblade", color = Color( 180, 10, 35 ) },
	["4"] = { text = "Clip size: 					20", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 14 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Projectiles have fast travel time.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 14,
		DamageType = DMG_SF_PHASEBLADE,
		CritMul = 4,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.16 }
		},
	},
	ClipSize = 20,
	ReloadSpeed = 1,
	Recoil = 5,
	PerkSet = { SCIFI_PERK_CHAMBER_ACCELERATOR, SCIFI_PERK_BARREL_ACCURACY }
}

SWEP.mat_laser_line = Material( "effects/laser_line2.vmt" )

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
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "Base", rel = "", pos = Vector(5.015, 68.08, -10.5), angle = Angle(180, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/misc/case_rail", [1] = "models/weapons/misc/case_stock", [2] = "vgui/white", [3] = "vgui/white", [4] = "vgui/white" }, skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt1", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "Base", rel = "", pos = Vector(-0.005, 1, 5), angle = Angle(0, 0, 0), size = Vector(0.15, 0.12, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/capac", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Base", rel = "", pos = Vector(0.3, 4, 20), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["holo_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 5), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_dots_arc", skin = 0, bodygroup = {} },
	["holo_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_point", skin = 0, bodygroup = {} },
	["holo_3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_point", skin = 0, bodygroup = {} },
	["holo_4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6.25), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_lines", skin = 0, bodygroup = {} },
--	["holo_5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.32, -2.9, 1.58), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_disp_burst", skin = 0, bodygroup = {} },
	["holo_6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.24, -2.8, 1.58), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_disp_notify_reload", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01a.mdl", bone = "", rel = "10", pos = Vector(-0.76, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "", rel = "10", pos = Vector(0.24, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["13"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "10", pos = Vector(0, -1.2, 13.2), angle = Angle(30, -90, 0), size = Vector(0.02, 0.01, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["15"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/cell_01_supportsb.mdl", bone = "", rel = "10", pos = Vector(-0.24, 6.2, 15), angle = Angle(1, 90, -180), size = Vector(0.012, 0.007, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_railing", skin = 0, bodygroup = {} },
	["17"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-1, 5.4, 8), angle = Angle(0, 0, 180), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["17a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-0.132, 1.8, 8), angle = Angle(180, 0, 0), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["20a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.3, 0.1, 14), angle = Angle(0, 0, 0.1), size = Vector(0.016, 0.002, 0.3), color = Color(255, 215, 225, 255), surpresslightning = true, material = "models/weapons/v_crossbow/rebar_glow", skin = 0, bodygroup = {} },
	["20b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.3, 1, 14), angle = Angle(0, 0, -0.1), size = Vector(0.016, 0.002, 0.3), color = Color(255, 215, 225, 255), surpresslightning = true, material = "models/weapons/v_crossbow/rebar_glow", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "Base", rel = "", pos = Vector(-0.2, -0.4, 13), angle = Angle(0, 140, 90), size = Vector(0.15, 0.2, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/barrel", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 255, 10, 30 ), bone = "Base", pos = Vector( 0, 1, 4 ), angle = Angle( 90, 0, 0 ), range = 8192, line_size = 0.8, haze_size = 0.1, dot_size = 1 }
}

SWEP.WElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.25, -5), angle = Angle(165, 10, 8), size = Vector(1.303, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 5.2, 78), angle = Angle(0, 90, 192), size = Vector(0.8, 1.12, 1.295), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/misc/case_rail", [1] = "models/weapons/misc/case_stock", [2] = "vgui/white", [3] = "vgui/white", [4] = "vgui/white" }, skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.8, -3.8), angle = Angle(0, -90, -103), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/capac", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19, 2, -3.2), angle = Angle(0, -90, 75), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01a.mdl", bone = "", rel = "10", pos = Vector(-0.76, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "", rel = "10", pos = Vector(0.24, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["13"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "10", pos = Vector(0, -1.2, 13.2), angle = Angle(30, -90, 0), size = Vector(0.02, 0.01, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["14"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "", rel = "10", pos = Vector(-0.2, 4.6, 8), angle = Angle(0, 0, 0), size = Vector(0.006, 0.006, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["14a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "", rel = "10", pos = Vector(-0.2, 4.6, 10), angle = Angle(0, 0, 180), size = Vector(0.006, 0.006, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["15"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/cell_01_supportsb.mdl", bone = "", rel = "10", pos = Vector(-0.24, 6.2, 15), angle = Angle(1, 90, -180), size = Vector(0.012, 0.007, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_railing", skin = 0, bodygroup = {} },
	["17"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-1, 5.68, 8), angle = Angle(0, 0, 180), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["17a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-0.132, 2, 8), angle = Angle(180, 0, 0), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, 0.4, -9), angle = Angle(0, 90, 14), size = Vector(0.404, 0.454, 0.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/barrel", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 255, 10, 30 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector( -2, 0, 0 ), angle = Angle( -14, 0, 0 ), range = 8192, line_size = 0.8, haze_size = 0.1, dot_size = 1 }
}


function SWEP:Think()

	if ( self.Owner:IsPlayer() && !self.Owner:InVehicle() ) then
		
		local tr = self.Owner:GetEyeTrace()
		local tardist = self.Owner:GetShootPos():Distance( tr.HitPos )
		local clrmod = 255 - ( self.VElements[ "holo_4" ].size.x * 5600 )
		local IsReloading = self.SciFiState == SCIFI_STATE_RELOADING
	
		self.VElements[ "holo_2" ].size = Vector(0.015, 0.015, 0.015) * ( self:GetSciFiACC() * 0.1 + 1 )
		self.VElements[ "holo_4" ].size = Vector(0.007, 0.007, 0.007) * ( tardist / 4000 )
		self.VElements[ "holo_4" ].color = Color( clrmod, clrmod, clrmod, clrmod )
		
		if ( self.Weapon:Clip1() < 6 ) && ( !IsReloading ) then
			self.VElements[ "holo_6" ].material = "models/weapons/hwave/holo_disp_notify_reload"
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
		
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:GetHwProjectileSpeed()

	if ( SERVER ) then
		local speed = 0
	
		if ( self.Owner:IsPlayer() ) then
			local tr = self.Owner:GetEyeTrace()
			if ( self.Owner:EyePos():Distance( tr.HitPos ) <= 512 ) then
				speed = 3200
			else
				speed = 25600
			end
		else
			speed = 25600
		end

		return speed 
	end
	
end

function SWEP:HwaveFire()

	local viewmodel = self:GetViewModelEnt()
	local vSpread = self:GetProjectileSpreadVector()
	
	if ( SERVER ) then
		local speed = 25600 -- self:GetHwProjectileSpeed()
		local pOwnerAV = self.Owner:GetAimVector()
		
		if ( self.Owner:IsNPC() ) then
			pOwnerAV = self.NPCAimVectorOverride
		end
	
		
		local ent = ents.Create( "drac_pfire" )
		if ( !IsValid( ent ) ) then return end
		if ( self.SciFiState != SCIFI_STATE_ADS ) then
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
		phys:ApplyForceCenter( pOwnerAV * speed + vSpread * ( speed / 2048 + self:GetSciFiACC() ) )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( ( vSpread:Angle() * self:GetSciFiACC() ) * -0.0001 )  -- Angle( math.random( -30, -40 ), math.random( -20, 20 ), 0 ) * ( 0.002 + self:GetSciFiACC() * 0.001 ) )
		self:AddSciFiACC( 5 )
	end

	self:DoMuzzleEffect()

	self:EmitSound( "scifi.drake.fire1" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:PrimaryAttack()
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end

	self:HwaveFire()
	if ( self.Owner:IsPlayer() ) then
		self:SetNextPrimaryFire( CurTime() + 0.16 )
	else
		self:SetNextPrimaryFire( CurTime() + 0.08 )
	end

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )

end