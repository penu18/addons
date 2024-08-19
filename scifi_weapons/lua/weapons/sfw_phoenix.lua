AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "The HS107 fires an accelerated plasma bolt which melts through flesh and armor."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to zoom. 'Use' (def. E) while zooming to change zoom level.\n Energy beam has a decent punch-through and deals additional critical damage. Has a chance to ignite targets."
SWEP.ItemRank 				= 18

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.SciFiSkin				= "models/weapons/hornet/skin"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_edit.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_phurt.vmt" )
end

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "XBowBolt"

SWEP.VfxMuzzleParticle 		= "pele_muzzle"
SWEP.VfxMuzzleColor 		= Color( 255, 130, 100, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720
SWEP.VfxHeatThreshold 		= 0

SWEP.ReloadTime				= 2
SWEP.ReloadSND				= "scifi.hwave.reload_new"
SWEP.SciFiACCRecoverRate	= 0.225

SWEP.PrintName				= "HS107 'Phoenix' sniper rifle"
SWEP.Slot					= 3
SWEP.SlotPos				= 3

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 40, +6", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x3", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Plasma, Slash", color = Color( 255, 120, 110 ) },
	["3a"] = { text = "Status Chance: 25%", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Clip size: 					8", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 3.1 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Shots punch through enemies and thinner walls.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Has a chance ignite enemies or props.", color = Color( 180, 180, 180 ) },
--	["8"] = { text = "... They demand a sacrifice ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "40, 6",
		DamageAmount = 46,
		DamageType = { DMG_SLASH, DMG_SF_HWAVE },
		CritMul = 3,
		StatusChance = 25,
		FireRate = {
			{ RateTitle = "semi-auto", RateDelay = 0.8 }
		},
	},
	ClipSize = 8,
	ReloadSpeed = 2,
	Recoil = 12,
	PerkSet = { SCIFI_PERK_ELEMENTAL_FIRE, SCIFI_PERK_AMMO_PUNCHTHROUGH_LIGHT, SCIFI_PERK_AMMO_HIGHCAL }
}

SWEP.AdsRTScopeOffline		= "models/weapons/misc/rt_scope_offline_baset.vtf"
SWEP.AdsFov 				= 6
SWEP.AdsTransitionSpeed		= 16
SWEP.AdsRTScopeEnabled 		= true
SWEP.AdsRTScopeSizeX 		= 512
SWEP.AdsRTScopeSizeY 		= 512
SWEP.AdsRTScopeScaling 		= false
SWEP.AdsPos 				= Vector( -3.939, -13.2, 1.202 )
if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 6
	SWEP.AdsBlurSize			= ScrH() / 2
	SWEP.AdsMSpeedScale			= GetConVar( "sfw_adsmspeedscale" ):GetFloat() * 0.4
end
SWEP.AdsRecoilMul			= 0.45
SWEP.AdsRTToneMapBalance 	= 1.5
SWEP.AdsRT = nil

SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( 2, -2, -2 )
SWEP.ViewModelReloadAng		= Angle( 2, 5, 5  )

SWEP.NPCAccuracy 			= 300
SWEP.NPCSkillLevel 			= 2

SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelSprintPos		= Vector( 4, 1, -1 )
SWEP.ViewModelSprintAng		= Angle( -4, 32, -30 )
SWEP.ViewModelSwayDirection = Vector( -1, 6, 4 )
SWEP.ViewModelSwayStrength 	= Vector( -1, 0.1 )
SWEP.ViewModelSprintSway 	= 4
SWEP.ViewModelSprintRatio 	= 0.6
SWEP.ViewModelMeleePos		= Vector( 18, 12, -3 )
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -60 )
SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( -0.045, 0.035, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.8, 1.2 )

local color_visor_default = Color( 255, 255, 255, 255 )
local color_visor_warning = Color( 255, 180, 100, 255 )
local color_visor_error =  Color( 255, 0, 30, 255 )

if ( CLIENT ) then
	local lensring = Material("effects/sight_glass") -- surface.GetTextureID("effects/sight_lens")
	local lenswarp = Material("effects/sight_lens") -- surface.GetTextureID("effects/sight_lens_refract") 
	local lensglass = Material("models/weapons/hwave/holo_dots_arc") -- surface.GetTextureID("effects/sight_glass")
	local lensindicator = Material("models/weapons/hwave/holo_dots") -- surface.GetTextureID("effects/sight_glass")
	
	local disp_font_small = "HudNumbers"
	
	function SWEP.DrawScopeOverlay( ply, wep, vSway, aSway )
		local midx, midy = wep.AdsRTScopeSizeX * 0.5, wep.AdsRTScopeSizeY * 0.5

		local fSway = 128 - wep.AdsFov * 4
		local fOverlayAnchorX, fOverlayAnchorY = 0, 0
		local fOverlaySizeX, fOverlaySizeY = wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY
		
		if ( !GetConVar( "sfw_allow_rtsniperscopes" ):GetBool() ) then
			midx, midy = ScrW() * 0.5, ScrH() * 0.5
		
			fOverlaySizeX, fOverlaySizeY = ScrH() * 0.5, ScrH() * 0.5
			fOverlayAnchorX, fOverlayAnchorY = ScrW() * 0.5 - ScrH() * 0.5, 0
		
			surface.DrawRect( 0, 0, fOverlayAnchorX, fOverlaySizeY * 2 )
			surface.DrawRect( fOverlayAnchorX + fOverlaySizeX * 2, 0, ScrW(), ScrH() )
		else
			fOverlaySizeX, fOverlaySizeY = fOverlaySizeX * 0.5, fOverlaySizeY * 0.5
		end
	
		local plyETrace = ply:GetEyeTrace()
		local clrSight = Color( 200, 15, 10, 128 )
		local lines_start = Vector( midx, midy )
		aSway = wep:GetViewModelSway() * 0.025
		
		cam.Start2D()
			draw.NoTexture()
			surface.SetDrawColor( 0, 0, 0, 255 )
			
			surface.SetMaterial( lenswarp )
			surface.DrawTexturedRect( fOverlayAnchorX, fOverlayAnchorY, fOverlaySizeX * 2, fOverlaySizeY * 2 )
			
			local pOwner = wep:GetOwner()
			local pOwnerSP = pOwner:GetShootPos()
			local pOwnerET = pOwner:GetEyeTrace()
			
			local tardist = pOwnerSP:Distance( pOwnerET.HitPos )
			tardist = math.Round( tardist, 0 )

			local scale = 8 * ( 32786 / tardist )
			
			surface.SetFont( disp_font_small )
			surface.SetTextColor( color_visor_warning )
			
			surface.SetTextPos( midx + 110 - ( string.len( tardist ) * 4 ), midy + 64 )
			if ( pOwnerET.HitSky ) then
				tardist = "--"
			end
			
			surface.DrawText( tardist )
			
			surface.SetTextPos( midx + 94, midy + 96 )
			surface.DrawText( math.Round( wep.AdsFov ) )
			
			local clip = wep:Clip1()
			local ammo = clip .. " / 8"
			
			surface.SetTextPos( midx - 160 + ( string.len( ammo ) * 4 ), midy + 64 )
			surface.DrawText( ammo )
			
			if ( clip < 3 ) && ( math.sin( CurTime() * 6 ) > -0.5 ) then
				surface.SetTextPos( midx - 158 + ( string.len( ammo ) * 4 ), midy + 102 )
				surface.SetFont( "CloseCaption_Normal" )
				
				local text = "reload"
				if ( clip < 1 ) then
					text = "ammo depleted"

					surface.SetTextColor( color_visor_error )
				end
			
				surface.DrawText( text )
			end
			
			surface.SetMaterial( lensglass )
			surface.DrawTexturedRect( fOverlayAnchorX + aSway.yaw * -fSway, fOverlayAnchorY + aSway.pitch * fSway * 0.5, fOverlaySizeX * 2, fOverlaySizeY * 2 )
			
			surface.SetMaterial( lensindicator )
			surface.DrawTexturedRect( fOverlayAnchorX + scale + aSway.yaw * -fSway, fOverlayAnchorY + scale + aSway.pitch * fSway * 0.5, fOverlaySizeX * 2 - scale * 2, fOverlaySizeY * 2 - scale * 2 )
			
			surface.SetMaterial( lensring )
			surface.DrawTexturedRect( fOverlayAnchorX + aSway.yaw * -fSway, fOverlayAnchorY + aSway.pitch * fSway * 0.5, fOverlaySizeX * 2, fOverlaySizeY * 2 )
			
			local fOpticsDistortYaw = math.min( aSway.yaw * -fSway, 64 )
			local fOpticsDistortPitch = math.min( aSway.pitch * fSway, 64 )
			
			surface.SetMaterial( lenswarp )
			surface.DrawTexturedRect( fOverlayAnchorX + fOpticsDistortYaw * 0.5, fOverlayAnchorY + fOpticsDistortPitch * 0.5, fOverlaySizeX * 2 + math.abs( fOpticsDistortYaw ) * 0.5, fOverlaySizeY * 2 + math.abs( fOpticsDistortPitch ) * 0.5 )

			local clrCrosshair = color_visor_default
			
			if ( pOwnerET.Entity ) then
				clrCrosshair = color_visor_warning
				
--				if ( pOwnerET.Entity.Health && pOwnerET.Entity:Health() > 0 ) then
--					halo.Add( { pOwnerET.Entity }, Color( 200, 0, 20, 160 ), 1, 1, 1, true, true )
--				end
			end
			
			if ( pOwnerET.HitGroup ) && ( pOwnerET.HitGroup == HITGROUP_HEAD ) then
				clrCrosshair = color_visor_error
			end
			
			surface.DrawCircle( midx, midy, 1.25, clrCrosshair )
		cam.End2D()
	end
end

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 2, 1, 4 ), angle = Angle( 0, 0, 0 ) },
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( -2, 2, -0.4 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "Base", rel = "", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt1", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(0, 4, 16), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
--	["holo_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.026, -3.05, 5), angle = Angle(0, -90.5, 0), size = Vector(0.018, 0.018, 0.018), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_dots_arc", skin = 0, bodygroup = {} },
--	["holo_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.0275, -3.047, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/weapons/hwave/holo_lines", skin = 0, bodygroup = {} },
--	["holo_3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.029, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.026, 0.026), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_point", skin = 0, bodygroup = {} },
--	["holo_4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.026, -3.05, 6.25), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_dots", skin = 0, bodygroup = {} },
--	["holo_5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.32, -3.35, 8), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "vgui/white", skin = 0, bodygroup = {} },
--	["holo_6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.23, -3.35, 8), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_disp_notify_reload", skin = 0, bodygroup = {} },
--	["holo_glass"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/geometric/hex1x1.mdl", bone = "Base", rel = "", pos = Vector(0.0225, -3, 8), angle = Angle(0, -90, 0), size = Vector(0.01, 0.01, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_sight_glass", skin = 0, bodygroup = {} },
--	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "Base", rel = "", pos = Vector(0.03, -2.65, 5), angle = Angle(0, -90, 180), size = Vector(0.032, 0.032, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "Base", rel = "", pos = Vector(0, 0.181, 16.923), angle = Angle(0, 160.024, 89.082), size = Vector(0.26, 0.56, 0.26), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/barrel", skin = 0, bodygroup = {} },
	["p1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinebuttress.mdl", bone = "Base", rel = "", pos = Vector(-0.129, 2.204, 9.618), angle = Angle(106.917, 90, 0), size = Vector(0.018, 0.034, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_grip", skin = 0, bodygroup = {} },
	["p4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_pipes/pipecluster08d_extender128.mdl", bone = "Base", rel = "", pos = Vector(-0.097, 0.016, 26.778), angle = Angle(0, 0, 0), size = Vector(0.105, 0.105, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["p2a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_tall03a.mdl", bone = "Base", rel = "", pos = Vector(0.025, -3.5, 5.6), angle = Angle(8.819, 124.347, -90), size = Vector(0.009, 0.029, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_case_2", skin = 0, bodygroup = {} },
--	["p2b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_tall04a.mdl", bone = "Base", rel = "", pos = Vector(0.025, -3.5, 5.5), angle = Angle(8.819, 55.606, 90), size = Vector(0.009, 0.029, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_case_2", skin = 0, bodygroup = {} },
--	["p2c"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_tall03a.mdl", bone = "Base", rel = "", pos = Vector(0.025, -3.55, 8.3), angle = Angle(16.819, 124.347, -92), size = Vector(0.009, 0.029, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_case_2", skin = 0, bodygroup = {} },
--	["p2d"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_tall04a.mdl", bone = "Base", rel = "", pos = Vector(0.025, -3.55, 8.2), angle = Angle(16.819, 55.606, 90), size = Vector(0.009, 0.029, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_case_2", skin = 0, bodygroup = {} },
	["p3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_tall02b.mdl", bone = "Base", rel = "", pos = Vector(0.02, -1.8, -0.4), angle = Angle(-0.758, 90, 180), size = Vector(0.017, 0.012, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_case_1", skin = 0, bodygroup = {} },
	["p5a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "Base", rel = "", pos = Vector(-0.2, -1.6, 18), angle = Angle(0, 0, 0), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["p5b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "Base", rel = "", pos = Vector(0.6, 3.5, 16), angle = Angle(0, 180, 5), size = Vector(0.05, 0.05, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "Base", rel = "", pos = Vector(5, 68, -10.5), angle = Angle(180, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/misc/case_rail", [1] = "models/weapons/misc/case_stock", [2] = "vgui/white", [3] = "vgui/white", [4] = "vgui/white" }, skin = 0, bodygroup = {} },
	["optics"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(-0.45, -3.6, 6.8), angle = Angle(180, 0, 0), size = Vector(0.036, 0.036, 0.036), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
--	["sight_lens"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/wood/wood_angle360.mdl", bone = "Base", rel = "optics", pos = Vector(-0.46, 0.2, 3.8), angle = Angle(0, 90, 0), size = Vector(0.013, 0.013, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/rt_scope", skin = 0, bodygroup = {} },
	["sight_lens"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/xqm/panel360.mdl", bone = "Base", rel = "optics", pos = Vector(-0.46, 0.2, 3.8), angle = Angle(-90, 0, 90), size = Vector(0.005, 0.022, 0.022), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/rt_scope", skin = 0, bodygroup = {} },
	["sight_casing"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/wheels/magnetic_large.mdl", bone = "Base", rel = "optics", pos = Vector(-0.45, 0.2, 0.8), angle = Angle(0, 0, 0), size = Vector(0.021, 0.021, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color(255, 80, 40), bone = "Base", pos = Vector( 0.04, -1.2, 24 ), angle = Angle( 90, 0, 0 ), range = 8192, line_size = 0.6, haze_size = 0.2, dot_size = 1 }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.4, 0.1, -3.2), angle = Angle(0, -90, -103), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.25, -5), angle = Angle(165, 10, 8), size = Vector(1.303, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14, 3, -5.5), angle = Angle(105, 180, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 2, -3.8), angle = Angle(0, -90, 75), size = Vector(0.081, 0.081, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19, 0.2, -8), angle = Angle(0, 90, 14), size = Vector(0.404, 0.454, 0.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/barrel", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "parent", pos = Vector(4.95, 67.8, -10.5), angle = Angle(180, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/misc/case_rail", [1] = "models/weapons/misc/case_stock", [2] = "vgui/white", [3] = "vgui/white", [4] = "vgui/white" }, skin = 0, bodygroup = {} },
	["optics"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "parent", pos = Vector(-0.45, -4.1, 7.4), angle = Angle(180, 0, 0), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["sight_lens"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/wood/wood_angle360.mdl", bone = "Base", rel = "optics", pos = Vector(-0.46, 0.3, 4.2), angle = Angle(0, 90, 0), size = Vector(0.015, 0.015, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/rt_scope", skin = 0, bodygroup = {} },
	["sight_casing"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/wheels/magnetic_large.mdl", bone = "Base", rel = "sight_lens", pos = Vector(0, 0, -2.8), angle = Angle(0, 0, 0), size = Vector(0.025, 0.025, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["p3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_tall02b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 0.5, -6.2), angle = Angle(-75, 180, 1), size = Vector(0.017, 0.012, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_case_1", skin = 0, bodygroup = {} },
	["p5a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(21, 1, -4.6), angle = Angle(0, 90, 110), size = Vector(0.045, 0.045, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["p5b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18, 0.025, -9.6), angle = Angle(180, 90, 77), size = Vector(0.05, 0.05, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color(255, 80, 40), bone = "ValveBiped.Bip01_R_Hand", pos = Vector( 22, 0.6, -11 ), angle = Angle( -14, 0, 0 ), range = 8192, line_size = 0.2, haze_size = 0.2, dot_size = 1 }
}

local iAdsFovDesired = 6
local fToggleTime = 0

function SWEP:SubInit()
	if ( SERVER ) then
		local pOwner = self:GetOwner()
		if ( IsValid( pOwner ) && pOwner:IsNPC() ) then
			local tKeyValues = pOwner:GetKeyValues()
			
			pOwner:SetKeyValue( "spawnflags", bit.bor( tKeyValues.spawnflags, SF_NPC_LONG_RANGE ) )
		end
	end
end

function SWEP:Think()

	if ( CLIENT ) && ( self.SciFiState == SCIFI_STATE_ADS ) then
		local fFireTime = self:GetNextPrimaryFire() - CurTime()
		local fFireScale = fFireTime * 0.5 / 0.4
		
		if ( fFireScale > 0 ) then
			self.AdsPos.y = -13.2 + 1.2 * fFireScale
		end

		if ( self.Owner:KeyDown( IN_USE ) && fToggleTime < CurTime() ) then
			local scale = GetConVar( "sfw_adsmspeedscale" ):GetFloat()
			if ( self.AdsFov == 6 ) then
				iAdsFovDesired = 2.5
				-- self.AdsMSpeedScale	= scale * 0.2
			elseif ( self.AdsFov == 2.5 ) then
				iAdsFovDesired = 12
				-- self.AdsMSpeedScale	= scale * 1
			else
				iAdsFovDesired = 6
				-- self.AdsMSpeedScale	= scale * 0.4
			end
				
			self:EmitSound( "Weapon_AR2.Special1" )
			
			fToggleTime = CurTime() + 0.4
		end
		
		if ( fToggleTime >= CurTime() ) then
			local fTimeScale = 0.4 / ( fToggleTime - CurTime() )
			
			if ( fTimeScale < 0.05 ) then
				self.AdsFov = iAdsFovDesired
			else
				self.AdsFov = Lerp( FrameTime() * 32, self.AdsFov, iAdsFovDesired )
				self.AdsFov = math.Truncate( self.AdsFov, 3 )
			end
		end
	end

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:OnAds( bAds ) 

	self.AdsPos.y = -13.2
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end

	-- if ( bAds ) then
		-- self:SetSciFiACC( self:GetSciFiACC() * 0.1 )

		-- if ( self.AdsFov == 6 ) then
			-- iAdsFovDesired = 2.5
		-- elseif ( self.AdsFov == 2.5 ) then
			-- iAdsFovDesired = 12
		-- else
			-- iAdsFovDesired = 6
		-- end
	-- end

	-- if ( bAds ) then
		-- self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	-- end
	
	if ( bAds ) then
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		
		self.DefaultSwayScale = 0
		self.DefaultBobScale = 0
	else
		-- self:SendWeaponAnim( ACT_VM_IDLE )
		
		self:SetAnimNextIdle( CurTime() )
		
		self.DefaultSwayScale = 1.2
		self.DefaultBobScale = 1.6
	end
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 21 || event == 22 ) then
		return true
	end

end

function SWEP:PeleFire()

	local cmdDamage = GetConVarNumber( "sfw_damageamp" )

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	local iDmg = 40 * cmdDamage

	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 0
	-- ptru.HullSize = 1
	ptru.Damage = iDmg / 2
	ptru.Force = 12
	ptru.Distance = 128
	ptru.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_SF_ENERGYBULLET )
	
		ParticleEffect( "hwave_hit_fleks", tr.HitPos, tr.Normal:Angle() )
	end
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() * 0.002 )
	bullet.Tracer = 1
	-- bullet.HullSize = 1
	bullet.TracerName = "pele_tracer"
	bullet.Damage = iDmg
	bullet.Force = 12
	bullet.Spread = Vector( .0021, .0021 ) * ( self:GetSciFiACC() * 1.05 )
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_SF_ENERGYBULLET )
		
		if ( GetRelChance( 25 ) ) && ( IsValid( tr.Entity ) && IsValid( tr.Entity:GetPhysicsObject() ) ) && !( tr.MatType == MAT_METAL ) then
			DoElementalEffect( { Element = EML_FIRE, Target = tr.Entity, Duration = 2 } )
		end
		
		self:DealAoeDamage( bit.bor( DMG_BURN, DMG_GENERIC ), 6 * cmdDamage, tr.HitPos, 64 )
		
		if ( tr.HitSky ) then return end
				
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( iDmg * 1.5 )
		end

		ParticleEffect( "pele_hit", tr.HitPos, Angle( 0, 0, 0 ) )
		ParticleEffect( "gunsmoke", tr.HitPos, Angle( 0, 0, 0 ), tr.Entity )
	
		if ( tr.HitWorld ) then
			ptru.Src = tr.HitPos + pOwnerAV * 8
			ptru.Dir = tr.Normal + pOwnerAV
			
			self.Owner:FireBullets( ptru, false )
		end
	end

	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -2, 0, math.random( 0.001, 0.02 ) ) * ( 1 + self:GetSciFiACC() * 0.15 ) )
		self:AddSciFiACC( 12 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.pele.fire1" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	if ( self.Owner:IsNPC() ) then
		if ( self:GetNextPrimaryFire() > CurTime() ) then return end
		
		self.Owner:SetSaveValue( "m_flLastAttackTime", -2 )
		self.Owner:SetSaveValue( "m_flNextAttack", 2 )
		self:SetNextPrimaryFire( CurTime() + 1 )
	else
		self:SetNextPrimaryFire( CurTime() + 0.8 )	
	end
	
	self:PeleFire()
	
	if ( self:Clip1() > 0 ) then
		self:EmitSound( "scifi.pele.bback" )
	end

end

function SWEP:SecondaryAttack()

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	ParticleEffect( "pele_hit", tr.HitPos, tr.Normal:Angle() )

	sound.Play( "scifi.hwave.hit", tr.HitPos )

	if ( CLIENT ) && ( self.Owner:IsPlayer() ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos 
			dlight.r = 255
			dlight.g = 130
			dlight.b = 100
			dlight.brightness = 1
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.75
		end
	end

end

-- PELÉ DEMANDS A SACRIFICE!!! --