AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

local cmd_heat = GetConVarNumber( "sfw_fx_heat" )
local snd_scopein = Sound( "weapons/usp/usp_draw.wav" )

SWEP.Spawnable 				= false
SWEP.AdminSpawnable 		= false
SWEP.ItemRank 				= 29

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.DeploySpeed 			= 1.6
SWEP.SciFiSkin				= "models/weapons/asa6/skin"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_edit.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 24
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.Ammo			= "AR2AltFire"

SWEP.VfxMuzzleParticle 		= "ngen_muzzle"
SWEP.VfxMuzzleColor 		= Color( 70, 80, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 600
SWEP.VfxHeatForce 			= true
SWEP.VfxHeatParticle 		= "gunsmoke"
SWEP.VfxHeatDelay 			= 0.8

SWEP.PrintName				= "ASA-6 EBR"
SWEP.Purpose				= "weapon for testing purposes"
SWEP.Instructions			= "Mouse1 = fire, Mouse2 = zoom, E + Mouse1 = Charge altifre, E + Mouse2 = Semi-auto/Full-auto, Melee (if bound) = change zoom level (while zooming!)"
SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.SciFiFamily			= { "custom", "phys", "ads" }

SWEP.ReloadSND				= "scifi.hwave.reload_new" 
SWEP.ReloadACT				= ACT_VM_IDLE_TO_LOWERED
SWEP.ReloadTime 			= 1.2
SWEP.ReloadModels 			= true
SWEP.ReloadGib 				= "models/items/battery.mdl"
SWEP.ReloadGibMaterial 		= "models/weapons/moby/moby_core"
SWEP.ReloadGibMass 			= 50
SWEP.ReloadGibSize 			= 0.4

SWEP.AdsRTScopeMaterial		= Material( "models/weapons/asa6/rt_scope.vmt" )
SWEP.AdsRTScopeOffline		= "models/weapons/asa6/rt_scope_offline_baset.vtf"
SWEP.AdsFov 				= 6
SWEP.AdsTransitionSpeed		= 10
SWEP.AdsRTScopeEnabled 		= true
SWEP.AdsRTScopeCompensate 	= false
SWEP.AdsRTScopeSizeX 		= 256
SWEP.AdsRTScopeSizeY 		= 256
SWEP.AdsRTScopeScaling 		= true
SWEP.AdsRTScopeScaleX 		= -0.5
SWEP.AdsRTScopeScaleY 		= -0.5
SWEP.AdsPos 				= Vector(-3.961, -10.1, 0.895)
SWEP.AdsSounds 				= false
SWEP.AdsSoundEnable 		= snd_scopein
SWEP.AdsSoundDisable		= "scifi.melee.swing.light"
if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 6
	SWEP.AdsBlurSize			= ScrH() / 2
	SWEP.AdsMSpeedScale			= GetConVarNumber( "sfw_adsmspeedscale" ) * 0.7
end
SWEP.AdsRecoilMul 			= 0.5

SWEP.SprintAnimIdle 		= false
SWEP.SprintAnimSpeed		= 8
SWEP.SprintSwayScale		= 0
SWEP.SprintBobScale			= 0

SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelDuckPos		= Vector( -2, -6, 3 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -10 )
SWEP.ViewModelMeleePos		= Vector( 20, 11, -4 )
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -60 )
-- SWEP.ViewModelReloadAnim 	= true
-- SWEP.ViewModelReloadPos		= Vector( -8, 1, -1 )
-- SWEP.ViewModelReloadAng		= Angle( 6, -12, 14 )
SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( -0.02, -0.02, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )

SWEP.ViewModelSprintPos 	= Vector( 4, -0.2, -0.6 )
SWEP.ViewModelSprintAng		= Angle( -4, 30, -30 )
SWEP.ViewModelSwayDirection = Vector( -1, 8, 2 )
SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 3
SWEP.SprintAnimSpeed		= 10
SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.0

SWEP.ChargeMax				= 100
SWEP.ChargeAdd				= 2
SWEP.ChargeDrain			= 25
SWEP.ChargeDeltaCompensate 	= true

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				     32", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				   x4", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	   Energy, Slash", color = Color( 190, 180, 250 ) },
	["4"] = { text = "Fire rate: 		         1.2 (semi-auto), 6 (full-auto)", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Alt. Damage: 			120", color = Color( 180, 180, 180 ) },
	["7b"] = { text = "Alt. Damage type: Energy, Blast", color = Color( 215, 215, 255 ) },
	["8"] = { text = "Alt. Fire rate: 			 0.4 (charge)", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 32,
		DamageType = { DMG_SLASH, DMG_ENERGY },
		CritMul = 4,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.08 }, 
			{ RateTitle = "burst", RateDelay = 0.14 }
		}
	},
	Secondary = {
		DamageAmount = 40,
		DamageType = { DMG_IMPACT, DMG_RADIATION },
		ChargeRate = 2
	},
	ClipSize = 24,
	ReloadSpeed = 1.2,
	Recoil = 12,
	PerkSet = { SCIFI_PERK_AMMO_HIGHCAL, SCIFI_PERK_ELEMENTAL_GRAVRIFLE_ONKILL, SCIFI_PERK_AMMO_PUNCHTHROUGH_LIGHT, SCIFI_PERK_AMMO_RICOCHET_HEAVY }
}

SWEP.mat_laser_line = Material( "effects/laser_line_asa.vmt" )

local sightalpha = 255
local nightvision = false
local zoom_nextsetting = 0
local castshell = false
local emitchargesound = true

-- Colors for holographic sight --
local color_visor_default = Color( 255, 255, 255, 255 ) 	-- default white
local color_visor_warning = Color( 255, 45, 15, 255 ) 		-- saturated red
local color_visor_error =  Color( 255, 10, 30, 255 )		-- decent yellow

if ( CLIENT ) then
	surface.CreateFont( "asaHudSmall",
	{
		font = "Bandal",
		size = 16,
		weight = 0,
		blursize = 0,
		scanlines = 4,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = true,
		outline = false,
	})
	
	local function Circle( x, y, radius, degrees, offset )
		local segmentdist = 360 / ( 2 * math.pi * radius / 2 )

		for a = 90 + offset, ( math.abs( degrees ) + offset ) - segmentdist + 90, segmentdist do
			surface.DrawLine( x + math.cos( math.rad( a ) ) * radius, y - math.sin( math.rad( a ) ) * radius, x + math.cos( math.rad( a + segmentdist ) ) * radius, y - math.sin( math.rad( a + segmentdist ) ) * radius )
		end
	end

	local function fnArc( x, y, radius, linewidth, startangle, endangle, aa )
		aa = math.abs( aa )

		startangle = math.Clamp( startangle, 0, 360 )
		endangle = math.Clamp( endangle, 0, 360 )

		local arc = {}
		
		local pass = 1
		local inner = {}
		local outer = {}
		
		local diff = math.abs( startangle - endangle )
		local smoothness = math.log( diff, 2 ) * 0.5
		local step = diff * ( 1 / math.pow( aa, smoothness ) )
		
		if ( startangle > endangle ) then
			step = math.abs( step ) * -1
		end

		local offset = 1 / aa
		
		for i = startangle, endangle, step do
			local angle = math.rad( i )
			local aSin, aCos = math.sin( angle ), math.cos( angle )
			
			local r = radius - linewidth
				
			local ox, oy = x + ( aSin * r ), y + ( -aCos * r )
			inner[pass] = {
				x=ox,
				y=oy,
				u=(ox-x)/radius + offset,
				v=(oy-y)/radius + offset,
			}
			
			local ox2, oy2 = x + ( aSin * radius ), y + ( -aCos * radius )
			outer[pass] = {
				x=ox2,
				y=oy2,
				u=(ox2-x)/radius + offset,
				v=(oy2-y)/radius + offset,
			}
			
			pass = pass + 1
		end
		
		for node = 1, pass do
			local p1, p2, p3, p4
			local forward = node + 1
			
			p1 = outer[node]
			p2 = outer[forward]
			p3 = inner[forward]
			p4 = inner[node]

			arc[node] = { p1, p2, p3, p4 }
		end
		
		for k,v in pairs( arc ) do
			surface.DrawPoly( v )
		end
	end

	local lensring = surface.GetTextureID("effects/sight_lens")
	local lensglass = surface.GetTextureID("effects/sight_glass")
	local lenswarp = surface.GetTextureID("models/weapons/asa6/sight_lens_refract") 
	local lensline = surface.GetTextureID("models/weapons/asa6/asa_hud_nv")
	
	local disp_font_small = "asaHudSmall"
	
	function SWEP.DrawScopeOverlay( ply, wep, vSway, aSway )

		local disp_color = Color( 110, 140, 220, sightalpha )
		local disp_color_noti = Color( 220, 40, 20, sightalpha )
		local clrSight = Color( 110, 140, 225, sightalpha / 2 )
		
		local midx, midy = wep.AdsRTScopeSizeX / 2, wep.AdsRTScopeSizeY / 2
		local plyETrace = ply:GetEyeTrace()
		
		local fOverlayAnchorX, fOverlayAnchorY = 0, 0
		local fOverlaySizeX, fOverlaySizeY = wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY
	
		local rtReso = ( wep.AdsRTScopeSizeX + wep.AdsRTScopeSizeY ) / 512
		
		if ( !GetConVar( "sfw_allow_rtsniperscopes" ):GetBool() ) then
			midx, midy = ScrW() * 0.5, ScrH() * 0.5
		
			fOverlaySizeX, fOverlaySizeY = ScrH() * 0.5, ScrH() * 0.5
			fOverlayAnchorX, fOverlayAnchorY = ScrW() * 0.5 - ScrH() * 0.5, 0

			rtReso = rtReso * 4
		else
			fOverlaySizeX, fOverlaySizeY = fOverlaySizeX * 0.5, fOverlaySizeY * 0.5
		end
		
		local brtWorld = 0
		if ( wep.AdsRTScopeCompensate ) then
			local clrWorld = render.GetLightColor( plyETrace.HitPos ) * 100
			brtWorld = clrWorld.r + clrWorld.g + clrWorld.b
		end
		
		local lines_start = Vector( midx, midy )
		
		cam.Start2D()
		
			local pOwnerSP = ply:GetShootPos()
			local dist = pOwnerSP:Distance( plyETrace.HitPos )
			
			dist = dist * 0.016933 -- source units to meters --
			
			if ( dist >= 32768 || !isnumber( dist ) ) then
				dist = "error"
			else
				dist = math.Round( dist, 0 )
			end
			
			local ammo = wep:Clip1()
			
			local offset = 16 - ( sightalpha / 16 )
			local rotation = 10 * offset

			local RadialOuter = 24 * rtReso
			local RadialInner = 80 * rtReso
			local LinearSmall = 12 * rtReso
			local LinearMedia = 32 * rtReso
			local LinearMedia2 = 40 * rtReso
			local LinearLarge = 71 * rtReso
			local LinearSpecial = 55 * rtReso
			local SpacingMedia = 36 * rtReso
			
			local punchmod = ply:GetViewPunchAngles()
			punchmod = math.abs( punchmod.pitch + punchmod.yaw + punchmod.roll ) * 4
			LinearSmall = LinearSmall + punchmod

			surface.SetDrawColor( disp_color )
			Circle( midx, midy, RadialInner, 90, 45 )
			Circle( midx, midy, RadialInner, -90, -135 )
			Circle( midx, midy, 2 * rtReso, 360, 0 )

			fnArc( midx, midy, RadialOuter, rtReso, 225 - rotation, 315 - rotation, 2 )
			fnArc( midx, midy, RadialOuter, rtReso, 45 - rotation, 135 - rotation, 2 )

			fnArc( midx, midy, LinearSmall, rtReso, 0, 360 * ( wep.Charge / wep.ChargeMax ), 2 )

			local ammofrac = ammo / 24
			Circle( midx + offset * 2, midy, RadialInner - ( 5 * rtReso ), 90 * ammofrac, 45 )
			
			local text = "--"
			
			if ( plyETrace.Entity ) && ( !plyETrace.HitWorld ) then
				text = "*1"
				
				if ( plyETrace.HitGroup == HITGROUP_HEAD ) then
					text = "*4"
				end
			end

			render.DrawLine( lines_start - Vector( 0, LinearSmall ), lines_start - Vector( 0, RadialOuter ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 0, LinearSmall ), lines_start + Vector( 0, RadialOuter ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( LinearSmall, 0 ), lines_start - Vector( LinearMedia, 0 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( LinearSpecial , 0 ), lines_start - Vector( LinearLarge, 0 ), clrSight, false )
			render.DrawLine( lines_start + Vector( LinearSmall, 0 ), lines_start + Vector( LinearMedia, 0 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( LinearMedia2 + string.len( dist ) * LinearMedia / 4, 0 ), lines_start + Vector( LinearLarge, 0 ), clrSight, false )
			
			local firetime = ( math.max( wep:GetNextPrimaryFire() - CurTime(), 0 ) / 0.48 )
			
			if ( firetime ) then
				surface.SetDrawColor( disp_color_noti )
				Circle( midx, midy, RadialOuter - 6, ( 360 * firetime ) , 0 )
			end
			
			surface.SetFont( disp_font_small )
			surface.SetTextColor( disp_color )
			
			if ( ammo < 10 ) then
				ammo = "0" .. tostring( ammo )
			end
			
			surface.SetTextPos( midx - ( RadialInner - string.len( ammo ) * 14 * rtReso ), midy - LinearMedia / 4 )
			surface.DrawText( ammo )
			
			surface.SetTextPos( midx + SpacingMedia, midy - LinearMedia / 4 )
			surface.DrawText( dist )
			
			surface.SetTextPos( midx + SpacingMedia, midy + LinearMedia / 4 )
			surface.DrawText( text )
			
			surface.SetTextPos( midx - ( 52 * rtReso ), midy + LinearMedia / 4 )
			surface.DrawText( wep.AdsFov )
			
			surface.SetDrawColor( 1, 1, 1, 255 )
			
			-- surface.SetTexture( lenswarp )
			-- surface.DrawTexturedRect( fOverlayAnchorX - aSway.yaw * 6, fOverlayAnchorY + aSway.pitch * 6, fOverlaySizeX - aSway.yaw * 6, fOverlaySizeY + aSway.pitch * 6 )
			
			-- surface.SetTexture( lensglass )
			-- surface.DrawTexturedRect( fOverlayAnchorX, fOverlayAnchorY, fOverlaySizeX, fOverlaySizeY )
			
			-- surface.SetDrawColor( 255 - brtWorld, 255 - brtWorld, 255 - brtWorld, 255 - brtWorld * 316 )
			-- surface.SetTexture( lensring )
			
			-- surface.DrawTexturedRect( fOverlayAnchorX - aSway.yaw * 12, fOverlayAnchorY + aSway.pitch * 12, fOverlaySizeX - aSway.yaw * 12, fOverlaySizeY + aSway.pitch * 12 )
			
			-- surface.SetMaterial( lensindicator )
			-- surface.DrawTexturedRect( fOverlayAnchorX + aSway.yaw * -fSway, fOverlayAnchorY + aSway.pitch * fSway * 0.5, fOverlaySizeX * 2, fOverlaySizeY * 2 )
			
			local fSway = 12
			local fOpticsDistortYaw = math.min( aSway.yaw * -fSway, 64 )
			local fOpticsDistortPitch = math.min( aSway.pitch * fSway, 64 )
			
			surface.SetTexture( lenswarp )
			surface.DrawTexturedRect( fOverlayAnchorX + fOpticsDistortYaw * 0.5, fOverlayAnchorY + fOpticsDistortPitch * 0.5, fOverlaySizeX * 2 + math.abs( fOpticsDistortYaw ) * 0.5, fOverlaySizeY * 2 + math.abs( fOpticsDistortPitch ) * 0.5 )

			surface.SetTexture( lensglass )
			surface.DrawTexturedRect( fOverlayAnchorX + aSway.yaw * -fSway, fOverlayAnchorY + aSway.pitch * fSway * 0.5, fOverlaySizeX * 2, fOverlaySizeY * 2 )
			
			surface.SetTexture( lensring )
			surface.DrawTexturedRect( fOverlayAnchorX + aSway.yaw * -fSway, fOverlayAnchorY + aSway.pitch * fSway * 0.5, fOverlaySizeX * 2, fOverlaySizeY * 2 )

			if ( nightvision  ) then
				render.FogMaxDensity( 0 )
				surface.SetTexture( lensline )
				surface.DrawTexturedRect( fOverlayAnchorX + aSway.yaw * -fSway, fOverlayAnchorY + aSway.pitch * fSway * 0.5, fOverlaySizeX * 2, fOverlaySizeY * 2 )
			end
			
			if ( plyETrace.Entity ) && ( plyETrace.Entity:IsNPC() || plyETrace.Entity:IsPlayer() ) then
				local bones = plyETrace.Entity:GetBoneCount()
				
				for bone = 1, bones-1 do
					local origin, rotation = plyETrace.Entity:GetBonePosition( bone )
					
					surface.DrawRect( origin.x, origin.y, 255, 255 ) 
				end		
			end
		cam.End2D()
	end
end

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( -4, 2, 0 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Claw1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Claw2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 2, 1, 4 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/lab_flourescentlight002b.mdl", bone = "Base", rel = "", pos = Vector(0.963, 1.616, 10.572), angle = Angle(0, 0, 90), size = Vector(0.112, 0.029, 0.112), color = Color(115, 155, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinebutton.mdl", bone = "Base", rel = "", pos = Vector(0.4, -0.6, 3), angle = Angle(0, 5, -90), size = Vector(0.115, 0.115, 0.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "Base", rel = "", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "Base", rel = "", pos = Vector(-0.4, 2, 20), angle = Angle(180, 90, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_core", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt1", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "Base", rel = "", pos = Vector(4.95, 68, -10.5), angle = Angle(180, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/misc/case_rail", [1] = "models/weapons/misc/case_stock", [2] = "vgui/white", [3] = "vgui/white", [4] = "vgui/white" }, skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_binocular01.mdl", bone = "Base", rel = "", pos = Vector(0.4, 0, 2), angle = Angle(0, 180, 0), size = Vector(0.12, 0.16, 0.16), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/sight", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Base", rel = "", pos = Vector(0.3, 4, 20), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01a.mdl", bone = "", rel = "10", pos = Vector(-0.76, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "", rel = "10", pos = Vector(0.24, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["13"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "10", pos = Vector(0, -1.2, 13.2), angle = Angle(30, -90, 0), size = Vector(0.02, 0.01, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["15"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/cell_01_supportsb.mdl", bone = "", rel = "10", pos = Vector(-0.24, 6.2, 15), angle = Angle(1, 90, -180), size = Vector(0.012, 0.007, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_railing", skin = 0, bodygroup = {} },
	["17"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-1, 5.4, 8), angle = Angle(0, 0, 180), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["17a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-0.132, 1.8, 8), angle = Angle(180, 0, 0), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["18"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(0.5, -1, 8), angle = Angle(180, -90, 2), size = Vector(0.03, 0.014, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
	["20a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.3, 0.1, 14), angle = Angle(0, 0, 0.1), size = Vector(0.016, 0.022, 0.3), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["20b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.3, 1, 14), angle = Angle(0, 0, -0.1), size = Vector(0.016, 0.022, 0.3), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["optics"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(-0.347, -3.5, 6.2), angle = Angle(180, 0, 0), size = Vector(0.03, 0.03, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
--	["sight_lens"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/wood/wood_angle360.mdl", bone = "Base", rel = "optics", pos = Vector(-0.34, 0.2, 2.98), angle = Angle(0, 90, 0), size = Vector(0.012, 0.012, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/asa6/rt_scope", skin = 0, bodygroup = {} },
	["sight_lens"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/geometric/hex1x1.mdl", bone = "Base", rel = "optics", pos = Vector(-0.34, 0.2, 2.98), angle = Angle(0, 90, 0), size = Vector(0.012, 0.012, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/asa6/rt_scope", skin = 0, bodygroup = {} },
	["sight_casing"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/wheels/magnetic_large.mdl", bone = "Base", rel = "sight_lens", pos = Vector(0, 0, -2.8), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 110, 140, 225 ), bone = "Base", pos = Vector(-0.4, 2.8, 21), angle = Angle( 90, 0, 0 ), range = 8192, line_size = 0.6, haze_size = 0.2, dot_size = 0.6 }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.4, 0.1, -3.2), angle = Angle(0, -90, -103), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/lab_flourescentlight002b.mdl", bone = "Base", rel = "parent", pos = Vector(0.963, 1.616, 10.572), angle = Angle(0, 0, 90), size = Vector(0.112, 0.029, 0.112), color = Color(115, 155, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinebutton.mdl", bone = "Base", rel = "parent", pos = Vector(0.4, -0.6, 3), angle = Angle(0, 5, -90), size = Vector(0.115, 0.115, 0.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "Base", rel = "parent", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "Base", rel = "parent", pos = Vector(-0.4, 2, 20), angle = Angle(180, 90, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_core", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "Base", rel = "parent", pos = Vector(4.95, 68, -10.5), angle = Angle(180, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/misc/case_rail", [1] = "models/weapons/misc/case_stock", [2] = "vgui/white", [3] = "vgui/white", [4] = "vgui/white" }, skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_binocular01.mdl", bone = "Base", rel = "parent", pos = Vector(0.4, 0, 2), angle = Angle(0, 180, 0), size = Vector(0.12, 0.16, 0.16), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/sight", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Base", rel = "parent", pos = Vector(0.3, 4, 20), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01a.mdl", bone = "", rel = "10", pos = Vector(-0.76, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "", rel = "10", pos = Vector(0.24, 7, 14.6), angle = Angle(0, -90, 0), size = Vector(0.026, 0.02, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_sight", skin = 0, bodygroup = {} },
	["13"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "10", pos = Vector(0, -1.2, 13.2), angle = Angle(30, -90, 0), size = Vector(0.02, 0.01, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["15"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/cell_01_supportsb.mdl", bone = "", rel = "10", pos = Vector(-0.24, 6.2, 15), angle = Angle(1, 90, -180), size = Vector(0.012, 0.007, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_railing", skin = 0, bodygroup = {} },
	["17"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-1, 5.4, 8), angle = Angle(0, 0, 180), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["17a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-0.132, 1.8, 8), angle = Angle(180, 0, 0), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["18"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "parent", pos = Vector(0.5, -1, 8), angle = Angle(180, -90, 2), size = Vector(0.03, 0.014, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
	["20a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "Base", rel = "parent", pos = Vector(-0.3, 0.1, 14), angle = Angle(0, 0, 0.1), size = Vector(0.016, 0.022, 0.3), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["20b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "Base", rel = "parent", pos = Vector(-0.3, 1, 14), angle = Angle(0, 0, -0.1), size = Vector(0.016, 0.022, 0.3), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["optics"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "parent", pos = Vector(-0.347, -3.5, 6.2), angle = Angle(180, 0, 0), size = Vector(0.03, 0.03, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
	["sight_lens"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/gears/bevel36.mdl", bone = "Base", rel = "optics", pos = Vector(-0.34, 0.2, 2.98), angle = Angle(0, 90, 0), size = Vector(0.022, 0.022, 0.012), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/asa6/rt_scope", skin = 0, bodygroup = {} },
	["sight_casing"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/wheels/magnetic_large.mdl", bone = "Base", rel = "sight_lens", pos = Vector(0, 0, -2.8), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 110, 140, 225 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector(19, 0.1, -5), angle = Angle( -14, 0, 0 ), range = 8192, line_size = 0.8, haze_size = 0.1, dot_size = 1 }
}

function SWEP:AsaSight()

	local kUse = self.Owner:KeyDown( IN_USE )
	local kG2 = self.Owner:KeyDown( IN_GRENADE2 )

	if ( kG2 ) then
		if ( kUse ) then
			if ( nightvision ) then
				self.AdsRTScopeMaterial:SetVector( "$selfillumtint", Vector( 0.7, 0.75, 0.8 ) )
				nightvision = false
				sightalpha = 64
				self:EmitSound( "scifi.mamba.zoomout" )
			else
				self.AdsRTScopeMaterial:SetVector( "$selfillumtint", Vector( 32, 2, 4 ) )
				nightvision = true
				sightalpha = 64
				self:EmitSound( "scifi.mamba.zoomin" )
			end
		else
			if ( self.AdsFov == 6 ) then
				self.AdsFov = 2
				self.AdsMSpeedScale	= GetConVarNumber( "sfw_adsmspeedscale" ) * 0.2
			elseif ( self.AdsFov == 2 ) then
				self.AdsFov = 12
				self.AdsMSpeedScale	= GetConVarNumber( "sfw_adsmspeedscale" ) * 1
			else
				self.AdsFov = 6
				self.AdsMSpeedScale	= GetConVarNumber( "sfw_adsmspeedscale" ) * 0.7
			end
			
			self:EmitSound( "Weapon_AR2.Special1" )
		end
	end

end

function SWEP:AsaNightVision()

	if ( !sightalpha || !nightvision ) then return end 

	local nvlight
	local nwentity = self:GetNWEntity( "nvlight" )

	if ( !nwentity || !nwentity:IsValid() ) then
		nvlight = ProjectedTexture()
	else
		nvlight = nwentity
	end
	
	if ( nvlight:IsValid() ) then
		local pOwnerSP = self.Owner:GetShootPos()
		local pOwnerEA = self.Owner:EyeAngles()
		local fw = pOwnerEA:Forward()
		local up = pOwnerEA:Up()
		local pos = pOwnerSP + fw * 16 + up * -4
	
		nvlight:SetEnableShadows( true )
		nvlight:SetColor( Color( 20, 10, 10, 255 ) )
		nvlight:SetBrightness( sightalpha / 200 )
		nvlight:SetFOV( 45 )
		nvlight:SetNearZ( 16 )
		nvlight:SetFarZ( 4096 )
		nvlight:SetTexture( "particle/particle_glow_05" )
		nvlight:SetPos( pos )
		nvlight:SetAngles( pOwnerEA )
		nvlight:Update()

		if ( !nwentity || !nwentity:IsValid() ) then
			self:SetNWEntity( "nvlight", nvlight )
		end
	end

end

function SWEP:AsaCharge()

	if ( self.Owner:KeyDown( IN_USE ) && self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) ) then
		if ( self:GetCharge() < self.ChargeMax ) then
			self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end

end
	
local uBarrelOrigin =  Vector(-1, 5.4, 8)
local lBarrelOrigin = Vector(-0.132, 1.8, 8)

function SWEP:AsaAnims()

	if ( !self.Owner:IsPlayer() ) then return end
	if ( self.Owner:InVehicle() ) then return end

	if ( self:GetCharge() > 0 ) then
		local cmod = self:GetCharge() * 0.01
		
		self.VElements[ "17" ].pos = uBarrelOrigin + ( Vector( 0, 0.24, 0 ) * cmod )
		self.VElements[ "17a" ].pos = lBarrelOrigin - ( Vector( 0, 0.24, 0 ) * cmod )
	end
	
	local IsReloading = self.SciFiState == SCIFI_STATE_RELOADING
	
	if ( IsReloading ) then
		self.VElements[ "17" ].pos = LerpVector( FrameTime() * 16, self.VElements[ "17" ].pos, Vector(-1, 6, 7) )
		self.VElements[ "17a" ].pos = LerpVector( FrameTime() * 16, self.VElements[ "17a" ].pos, Vector(-0.132, 1.2, 7) )
	else
		if ( self.VElements[ "17" ].pos ~= uBarrelOrigin ) then
			self.VElements[ "17" ].pos = LerpVector( FrameTime() * 16, self.VElements[ "17" ].pos, uBarrelOrigin )
			self.VElements[ "17a" ].pos = LerpVector( FrameTime() * 16, self.VElements[ "17a" ].pos, lBarrelOrigin )
		end
	end

end

function SWEP:OnAds( bAds )

	if ( bAds ) then
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	end
		
end

function SWEP:Think()

	if ( CLIENT ) then
		local IsAds = self.SciFiState == SCIFI_STATE_ADS
		local animtime = FrameTime() * 512 * self.ChargeDeltaFactor
		
		if ( !isnumber( sightalpha ) ) then
			sightalpha = 0
		end
		
		if ( IsAds ) then
			if ( zoom_nextsetting <= CurTime() ) then
				self:AsaSight()
				self:AsaNightVision()

				zoom_nextsetting = CurTime() + 0.2
			end
			
			if ( sightalpha < 255 ) then
				sightalpha = math.Approach( sightalpha, 255, animtime )
			end
			
			if ( !self.AdsRTDelta ) then
				self.AdsRTScopeMaterial:SetFloat( "$PhongBoost", 0.8 )
--				self.AdsRTScopeMaterial:SetVector( "$EnvmapTint", Vector( .015, 0.02, .025 ) )
				self.AdsRTScopeMaterial:SetVector( "$envmaptint", Vector( .007, .01, .012 ) )
			end
			
			if ( !nightvision ) then
				local nwentity = self:GetNWEntity( "nvlight" )
				
				if ( IsValid( nwentity ) ) then
					nwentity:Remove()
				end
			end
		else
			if ( sightalpha > 0 ) then
				sightalpha = math.Approach( sightalpha, 0, animtime * 2 )
			end
			
			if ( self.AdsRTDelta ) then
				self.AdsRTScopeMaterial:SetFloat( "$PhongBoost", 4 )
				self.AdsRTScopeMaterial:SetVector( "$EnvmapTint", Vector( .075, .1, .125 ) )
			end
			
			local nwentity = self:GetNWEntity( "nvlight" )
			
			if ( IsValid( nwentity ) ) then
				nwentity:Remove()
			end
		end
	end

	local vmEntity = self:GetViewModelEnt()
	local pAmmoNades = self.Owner:GetAmmoCount( self.Secondary.Ammo )
	
	if ( SERVER || !game.SinglePlayer() ) then 
		if ( self.Owner:KeyDown( IN_USE ) ) then
			
			if ( self.Owner:KeyPressed( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && pAmmoNades > 0 ) then
				local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
				ParticleEffectAttach( "ngen_muzzle_charge", 4, vmEntity, vmAttachMuzzle )
			end
			
			if ( self.Owner:KeyReleased( IN_ATTACK ) ) then
				vmEntity:StopParticles()
				emitchargesound = true
		
				if ( self:GetCharge() >= self.ChargeMax ) && ( self:GetNextPrimaryFire() <= CurTime() && self.SciFiState ~= SCIFI_STATE_SPRINT ) then
					self:StopParticles()
					self:ThrowNade()
					castshell = true
					self:SetCharge( 0 )
				else
					vmEntity:SendViewModelMatchingSequence( vmEntity:LookupSequence( "idle" ) )
					self:EmitSound( "Weapon_AR2.Empty" )
				end
			end
		end

		local NextPFire = self:GetNextPrimaryFire()
		if ( NextPFire >= CurTime() + 0.75 ) && ( NextPFire < CurTime() + 0.8 ) then
			vmEntity:SetSequence( "ir_reload" )
			
			if ( castshell ) then
				local effectdata = EffectData()
				effectdata:SetEntity( self )
				effectdata:SetOrigin( self:GetProjectileSpawnPos() )
				effectdata:SetAttachment( "1" )
				effectdata:SetAngles( self.Owner:EyeAngles() )
				
				util.Effect( "ShotgunShellEject", effectdata )
				
				castshell = false
			end
		end
	end

	if ( pAmmoNades > 0 ) then
		self:AsaCharge()
	end
	
	self:AsaAnims()

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

local tSurfacesWeak = { [ MAT_ALIENFLESH ] = true, [ MAT_ANTLION ] = true, [ MAT_BLOODYFLESH ] = true, [ MAT_COMPUTER ] = true, [ MAT_EGGSHELL ] = true, [ MAT_FLESH ] = true, [ MAT_FOLIAGE ] = true, [ MAT_GLASS ] = true, [ MAT_PLASTIC ] = true, [ MAT_WOOD ] = true }
local tSurfacesStrong = { [ MAT_CONCRETE ] = true, [ MAT_METAL ] = true, [ MAT_TILE ] = true, [ MAT_VENT ] = true, [ MAT_WARPSHIELD ] = true }

function SWEP:HwaveFire()

	local cmdDamage = GetConVarNumber( "sfw_damageamp" )

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	if ( self.Owner:IsNPC() ) then
		pOwnerAV = self.NPCAimVectorOverride
	end
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
	
	local iDmg = 32 * cmdDamage

	local ptru = {}
	ptru.AmmoType = "ar2"
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 1
	ptru.HullSize = 1
	ptru.TracerName = "asa6_tracer_noattach"
	ptru.Damage = iDmg / 2
	ptru.Force = 16
--	ptru.AmmoType = "SniperPenetratedRound"
	ptru.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_SF_HWAVE )
	
--		ParticleEffect( "ngen_hit_sparks_2", tr.HitPos, tr.Normal:Angle(), self )
	end

	local bullet = {}
	bullet.AmmoType = "ar2"
	bullet.Num = 1
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() * ( 1 / 512 ) )
	bullet.Tracer = 1
	bullet.HullSize = 1
	bullet.TracerName = "asa6_tracer"
	bullet.Damage = iDmg
	bullet.Force = 16
--	bullet.AmmoType = "SniperRound"
	bullet.Spread = Vector( .0018, .0018 ) * ( self:GetSciFiACC() * 1 )
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_SF_HWAVE )
		
		if ( tr.HitSky ) then return end
		
--		ParticleEffect( "astra_hit", tr.HitPos, tr.Normal:Angle(), self )
--		ParticleEffect( "asa6_hit", tr.HitPos, tr.Normal:Angle(), self )
				
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( iDmg * 2 )
		end
		
		if ( tSurfacesWeak[ tr.MatType ] ) then
			ptru.Src = tr.HitPos + pOwnerAV * 8
			ptru.Dir = tr.Normal + pOwnerAV

			self.Owner:FireBullets( ptru, false )
		end

		if ( tSurfacesStrong[ tr.MatType ] ) then
			ptru.Src = tr.HitPos - pOwnerAV -- * 16
			ptru.Dir = tr.Normal - 2 * tr.Normal:Dot( tr.HitNormal ) * tr.HitNormal

			self.Owner:FireBullets( ptru, false )
		end
	end

	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -12, -14 ), math.random( -2, 2 ), math.random( -1, 1 ) ) * ( 0.1 + self:GetSciFiACC() * 0.005 ) )
		self:AddSciFiACC( 12 )
	end
	
	self:DoMuzzleEffect()
	
	if ( ( SERVER || !game.SinglePlayer() ) && self:GetSciFiACC() >= 30 ) then
		ParticleEffectAttach( "ngen_muzzle_embers_overheat", PATTACH_POINT_FOLLOW, vmEntity, vmAttachMuzzle )
	end

	self:EmitSound( "scifi.asa6.fire1" )
	self:EmitSound( "scifi.asa6.fire1.echo" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:ThrowNade()

	local cmdDamage = GetConVarNumber( "sfw_damageamp" )

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	local pOwnerEA = self.Owner:EyeAngles()
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
	
	if ( SERVER ) then
		local origin = self:GetProjectileSpawnPos()
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			origin = self.Owner:EyePos() + ( pOwnerAV * 20 )
		end
	
		local ent = ents.Create( "asa6_powershot" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( origin )
		ent:SetAngles( pOwnerEA ) --+ Angle( 90, 0, 0 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		ent.LauncherMode = true
		ent.Charge = 10
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * ( 2048 * self:GetCharge() ) )

		self.Owner:SetVelocity( pOwnerEA:Forward() * -256 + pOwnerEA:Up() * 128 )
	end
	
	if ( self.Owner:IsPlayer() ) then
		vmEntity:StopParticles()
		
		self.Owner:RemoveAmmo( 1, self.Secondary.Ammo )
		self.Owner:ViewPunch( Angle( math.random( -3.6, -4 ), 0, 0 ) * ( 1 + self:GetSciFiACC() * 0.1 ) )
		
		self:AddSciFiACC( 24 )
	end

	ParticleEffectAttach( "ngen_muzzle_2", 4, vmEntity, vmAttachMuzzle )
	ParticleEffectAttach( "gunsmoke", 4, vmEntity, vmAttachMuzzle )
	
	self:EmitSound( "scifi.hybridsniper.fire.silent" )
	self:EmitSound( "scifi.hybridsniper.fire.default" )

	self:SetNextPrimaryFire( CurTime() + 1.1 )
		
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	
	emitchargesound = true
	
end

function SWEP:PrimaryAttack()
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	if ( self.Owner:IsNPC() ) then
		if ( self:GetCharge() > self.ChargeMax ) then
			self:ThrowNade()
			self:SetCharge( 0 )
		else
			self:HwaveFire()
			self:SetCharge( self:GetCharge() + 30 )
		end
		
		self:SetNextPrimaryFire( CurTime() + 0.01 )
		return
	end
	
	if ( self.Owner:IsPlayer() && !self.Owner:KeyDown( IN_USE ) ) then
		self:HwaveFire()
		if ( self.Primary.Automatic ) then
			self:SetNextPrimaryFire( CurTime() + 0.14 )
		else
			self:SetNextPrimaryFire( CurTime() + 0.5 )
		end
	else
		if ( emitchargesound ) then
			local pAmmoNades = self.Owner:GetAmmoCount( self.Secondary.Ammo )
			
			if ( pAmmoNades > 0 ) then
				self:EmitSound( "scifi.stinger.rearm" )
				emitchargesound = false
			else
				self:EmitSound( "Weapon_AR2.Empty" )
				emitchargesound = false
			end
			self:SetNextPrimaryFire( CurTime() + 0.02 )
		end
	end

end

function SWEP:SecondaryAttack()

	self:SetNextSecondaryFire( CurTime() + 0.2 )
	
	if ( self.Owner:KeyDown( IN_ATTACK2 ) ) && ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self.Primary.Automatic ) then
			self.Primary.Automatic = false
		else
			self.Primary.Automatic = true
		end
		self:EmitSound( "Weapon_AR2.Empty" )
	end

	
end

function SWEP:OnReload()

	local vmEntity = self:GetViewModelEnt()
	local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
	
	ParticleEffectAttach( "ngen_muzzle_embers", PATTACH_POINT_FOLLOW, vmEntity, vmAttachMuzzle )
	ParticleEffectAttach( "nrg_heat", PATTACH_POINT_FOLLOW, vmEntity, vmAttachMuzzle )
	
end

function SWEP:OnReloadFinish()

	self:EmitSound( "scifi.asa6.reload.bback" )
	
end

function SWEP:CreateReloadModels()

	if ( !self.ReloadModels ) then return end
	if ( GetConVarNumber( "sfw_allow_propcreation" ) == 0 ) then return end

	if ( SERVER ) then
		local pOwnerSP = self.Owner:GetShootPos()
		local pOwnerEA = self.Owner:EyeAngles()
		local fw = pOwnerEA:Forward()
		local rt = pOwnerEA:Right()
		local up = pOwnerEA:Up()
		
		local ent = ents.Create( "prop_physics" )
		if (  !IsValid( ent ) ) then return end
		ent:SetModel( self.ReloadGib )
		ent:SetMaterial( self.ReloadGibMaterial )
		ent:SetPos( pOwnerSP + ( up * -16 + rt * 4 + fw * 12 ) )
		ent:SetAngles( pOwnerEA + AngleRand() )
		ent:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
		ent:SetModelScale( self.ReloadGibSize )
		ent:Spawn()
			
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		if ( self.ReloadGibMass ) then
			phys:SetMass( self.ReloadGibMass )
		end
		phys:SetMaterial( "weapon" )
		phys:ApplyForceCenter( fw * 128 )
		
		ParticleEffectAttach( "gunsmoke", 1, ent, 1 )
	
		SafeRemoveEntityDelayed( ent, 10 )
	end

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	ParticleEffect( "asa6_hit", tr.HitPos, tr.Normal:Angle(), self )

	if ( CLIENT ) && ( self.Owner:IsPlayer() ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos 
			dlight.r = 110
			dlight.g = 140
			dlight.b = 255
			dlight.brightness = 1
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end

end