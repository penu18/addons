AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Inspired by ancient human weaponry, the Jotunn bow, half compound bow, half rail-gun, launches an ice bolt at incredible velocity, puncturing targets. While also being nearly completely silent, this weapon is a perfect tool of assassination."
SWEP.Instructions			= "Hold Mouse1 to charge, Release to fire. Mouse2 to aim down sights. Hold reload (def. 'R') while releasing Mouse1 to safely discharge the bow. Charge duration effects velocity and damage."
SWEP.ItemRank 				= 18

SWEP.ViewModel				= "models/weapons/c_sfmp.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.HoldType 				= "smg"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 1.4
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiSkin_2			= "vgui/white"
SWEP.SciFiSkin_3			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.ViewModelFOV = 72

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_cryon.vmt" )
end

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "XbowBolt"

SWEP.VfxMuzzleAttachment 	= "muzzle"
SWEP.VfxMuzzleAttachment2 	= "muzzle"
SWEP.VfxMuzzleParticle 		= "jotunn_muzzle"
SWEP.VfxMuzzleRule 			= 0

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.08

SWEP.PrintName				= "T3i 'Jotunn' Bow"
SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.AdsPos 				= Vector(-4, 6, -2.2)
SWEP.AdsAng 				= Angle(4, 0, -65)
SWEP.AdsFov					= 30
SWEP.AdsFovTransitionTime	= 0.3
SWEP.AdsTransitionSpeed		= 10
if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 6
	SWEP.AdsBlurSize			= ScrH() / 3.4
end

SWEP.ViewModelSprintPos		= Vector( -4, 2, 1 )
SWEP.ViewModelSprintAng		= Angle( -20, 5, -5 )
SWEP.ViewModelShiftOffset 	= Vector( 0.04, -0.1, -0.2 ) -- Vector( 0.03, -0.075, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.8, -0.2, 0.2 ) -- Vector( 0.6, 0.3, 0.8 )
SWEP.ViewModelSwayDirection = Vector( -2, 5, 4 )

SWEP.ViewModelMeleePos		= Vector( -6, -2, 0 )
SWEP.ViewModelMeleeAng		= Angle( 10, -30, 4 )

SWEP.DefaultSwayScale		= 1.0
SWEP.DefaultBobScale		= 2.0

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8

SWEP.ChargeMax				= 100

SWEP.ChargeAdd				= 1
SWEP.ChargeDrain			= 4

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.4
SWEP.SciFiMeleeRange		= 50
SWEP.SciFiMeleeDamage		= 6
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"

SWEP.ReloadTime 			= 0.08
SWEP.ReloadSND				= ""
SWEP.ReloadACT				= ACT_VM_IDLE_TO_LOWERED

SWEP.DepletedSND			= ""

SWEP.NPCAccuracy 			= 100
SWEP.NPCSkillLevel 			= 2
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= -0.12


SWEP.SciFiFamily			= { "elemental", "phys", "enerbow_cbeam", "ads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 10; 50", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				2.4", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Ice, Slash", color = Color( 160, 170, 180 ) },
	["3a"] = { text = "Status Chance: 5%", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 1.1 (semi-auto / charge)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Arrows have massive physical force.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Charge effects flight speed and damage directly.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Has increased damage on body-hits.", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Has a chance to freeze targets.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "10, 50",
		DamageAmount = 60,
		DamageType = { DMG_SLASH, DMG_SF_ICE },
		CritMul = 2.5,
		StatusChance = 5,
		ChargeRate = 1
	},
	PerkSet = { SCIFI_PERK_ELEMENTAL_ICE, SCIFI_PERK_AMMO_HIGHCAL, SCIFI_PERK_RELOAD_FROMRESERVES }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.base"] = { scale = Vector(1, 1, 1), pos = Vector(3.2, -3.2, -5), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-11, 7.2, -1.6), angle = Angle(-8.674, 12.494, -6.623) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-0.1, 1.2, 2.5), angle = Angle(22.875, 24.621, 17.701) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.2, 0), angle = Angle(-28.369, -9.153, 40.089) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-3, -4.5, -6.6), angle = Angle(-44.431, 13.605, -22.758) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(21.327, 33.988, -16.748) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-12.879, 0.592, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -57.833, -35.309) }
}

SWEP.WorldModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 10, 40 ) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 10, -10 ) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, -10, 0 ) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle( 0, 0, 40 ) }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.185, 1.526, 4.456), angle = Angle(26.625, 77.486, 4.644), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/casing", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.063, 1.292, 0.008), angle = Angle(0, -22.056, -1.935), size = Vector(0.18, 0.18, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/sight", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinebutton.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.772, -0.56, 1.722), angle = Angle(-2.869, 72.374, 90), size = Vector(0.115, 0.115, 0.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(8.434, 2.5, 15.5), angle = Angle(-15, 180, 180), size = Vector(0.029, 0.019, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["3+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(8.602, 2.213, -8.634), angle = Angle(15, 180, 0), size = Vector(0.029, 0.019, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(6.001, 2.105, -2.944), angle = Angle(-90.929, -90, -90), size = Vector(0.3, 0.3, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_emitter01", skin = 0, bodygroup = {} },
	["4+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(6.001, 2.503, 10.449), angle = Angle(90.9, -90, -90), size = Vector(0.3, 0.3, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_emitter01", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(5.6, 2.6, 7.2), angle = Angle(180, -110, 180), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(5.6, 1.4, -0.2), angle = Angle(0, -110, 180), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["arrow"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furniture_vanity01a_gib03.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.14, 3.66, -1.504), angle = Angle(0, -107.158, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/elemental/frozen", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(1, 4, 0), angle = Angle(15, 75, 50), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_cartridge01.mdl", bone = "", rel = "parent", pos = Vector(4.185, 1.526, 4.456), angle = Angle(26.625, 77.486, 4.644), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/casing", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_binocular01.mdl", bone = "", rel = "parent", pos = Vector(3.063, 1.292, 0.008), angle = Angle(0, -22.056, -1.935), size = Vector(0.18, 0.18, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/sight", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinebutton.mdl", bone = "", rel = "parent", pos = Vector(3.772, -0.56, 1.722), angle = Angle(-2.869, 72.374, 90), size = Vector(0.115, 0.115, 0.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "parent", pos = Vector(8.434, 2.5, 15.5), angle = Angle(-15, 180, 180), size = Vector(0.029, 0.019, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["3+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "parent", pos = Vector(8.602, 2.213, -8.634), angle = Angle(15, 180, 0), size = Vector(0.029, 0.019, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_emitter01.mdl", bone = "", rel = "parent", pos = Vector(6.001, 2.105, -2.944), angle = Angle(-90.929, -90, -90), size = Vector(0.3, 0.3, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_emitter01", skin = 0, bodygroup = {} },
	["4+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_emitter01.mdl", bone = "", rel = "parent", pos = Vector(6.001, 2.503, 10.449), angle = Angle(90.9, -90, -90), size = Vector(0.3, 0.3, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_emitter01", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "parent", pos = Vector(5.6, 2.6, 7.2), angle = Angle(180, -110, 180), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "parent", pos = Vector(5.6, 1.4, -0.2), angle = Angle(0, -110, 180), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["arrow"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furniture_vanity01a_gib03.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.14, 3.66, -1.504), angle = Angle(-20, -107.158, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/elemental/frozen", skin = 0, bodygroup = {} }
}

local barrel_1_hpos = Vector(8.434, 2.5, 15.5)
local barrel_2_hpos = Vector(8.602, 2.213, -8.634)
local barrel_1_hang = Angle(-15, 180, 180)
local barrel_2_hang = Angle(15, 180, 0)

local color_visor_warning = Color( 200, 220, 255, 255 )
local color_visor_noti =  Color( 100, 180, 255, 32 )
local color_visor_chair_ally =  Color( 80, 255, 30, 32 )
local color_visor_chair_enemy =  Color( 225, 120, 0, 255 )
local color_visor_chair_enemy_crit =  Color( 255, 0, 30, 255 )
local color_laser = Color( 100, 180, 255, 100 )

if ( CLIENT ) then

	function SWEP:CustomAmmoDisplay()

		self.AmmoDisplay = self.AmmoDisplay or {}
		self.AmmoDisplay.Draw = true
		
		if ( self.Primary.ClipSize > -1 ) then
			self.AmmoDisplay.PrimaryClip = self.Owner:GetAmmoCount( self.Primary.Ammo )
			self.AmmoDisplay.PrimaryAmmo = -1
			self.AmmoDisplay.SecondaryClip = -1
			self.AmmoDisplay.SecondaryAmmo = -1
		end
		
		return self.AmmoDisplay
		
	end

end

SWEP.DataTables = {
	{ dType = "Float", dName = "NextChargeAnim" },
	{ dType = "Float", dName = "NextCoreFxAnim" }
}

function SWEP:SubInit()

	self:SetCharge( 0 )
	
	if ( CLIENT ) && ( GetConVarNumber( "sfw_allow_advanims" ) == 1 ) then
		if ( game.SinglePlayer() ) then
			self.SckAnimDeployed = 60
		else
			self.SckAnimDeployed = 20
		end
	end

end

local function Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 )
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
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

local iSmartScope = 0
local ssRad, ssStart, ssEnd

local cmd_legacydisplay = GetConVar( "sfw_sk_jotunn_uselegacydisplay" )

function SWEP:AddAcc()

	local pEntity = LocalPlayer()
	
	if ( !IsValid( pEntity ) || !pEntity:Alive() ) then return end

	local wep = self
		
	if ( !IsValid( wep ) ) then return end
	
	if ( !wep.SciFiState ) then return end
	
	if ( cmd_legacydisplay:GetBool() ) then
		local viewmodel = self.Owner:GetViewModel()

		local ads = self.SciFiState == SCIFI_STATE_ADS

		if ( ads ) then
			local sine = math.sin( CurTime() * 8 ) + 2
			local hudtrace = pEntity:GetEyeTrace()

			cam.Start2D( Vector( 0, 0, 0 ), 0.2 )
				local indic_pos = hudtrace.HitPos:ToScreen()
				local indic_scale = pEntity:GetPos():Distance( hudtrace.HitPos ) 
				local ent = hudtrace.Entity
				local hgroup = hudtrace.HitGroup
				
				local color_world = render.GetLightColor( hudtrace.HitPos ) * 100
				local color_visor_default = Color( 220 - color_world.r, 220 - color_world.g, 255 - color_world.b, 24 )
				local color_visor_noammo =  Color( 255, 0, 30, 32 )
				
				if ( ent:IsNPC() || ent:IsPlayer() ) then
					if ( hgroup == HITGROUP_HEAD ) then
						surface.SetDrawColor( color_visor_chair_enemy_crit )
					else
						surface.SetDrawColor( color_visor_chair_enemy )
					end
				end
				
				draw.NoTexture()
				Circle( indic_pos.x, indic_pos.y, 4, 3 )
				
				if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
					surface.SetDrawColor( color_visor_default )
				else
					surface.SetDrawColor( color_visor_noammo )
				end
				
				Circle( indic_pos.x, indic_pos.y, 32, 3 )
				Circle( indic_pos.x - 30, indic_pos.y + 18, -32, 3 )
				Circle( indic_pos.x, indic_pos.y - 35, -32, 3 )
				Circle( indic_pos.x, indic_pos.y - 35, -0.32 * ( indic_scale / 86 ), 3 )
				
				if ( self:GetCharge() >= 100 ) then
					surface.SetDrawColor( Color( 100 * sine / 2, 180 * sine / 3, 255 * sine / 3, 32 ) )
				else
					surface.SetDrawColor( color_visor_noti )
				end
		
				Circle( indic_pos.x - 30, indic_pos.y + 18, -6.4 * self:GetCharge() / 20, 3 )
			cam.End2D()
		end

		return
	end

	if ( wep.SciFiState == SCIFI_STATE_ADS ) then
		if ( iSmartScope < 1 ) then
			iSmartScope = math.Approach( iSmartScope, 1, FrameTime() * 8 )
		end
		
		ssRad = 2 * iSmartScope
		ssStart = 45 * iSmartScope
		ssEnd = 45 * iSmartScope + 90 * iSmartScope
	else
		if ( iSmartScope > 0 ) then
			iSmartScope = math.Approach( iSmartScope, 0, FrameTime() * 4 )
		
			ssRad = 2 * iSmartScope
			ssStart = 45 * iSmartScope + 135 * ( 1 - iSmartScope )
			ssEnd = 135 + 45 * ( 1 - iSmartScope )
		end
	end
	
	if ( iSmartScope <= 0 ) then return end

	cam.Start2D( Vector( 0, 0, 0 ), 1 )
		local w, h = ScrW(), ScrH()
		local x, y = w / 2, h / 2
		
		draw.NoTexture()
		
		local tr = pEntity:GetEyeTrace()
	
		local punchmod = pEntity:GetViewPunchAngles()
		punchmod = math.abs( punchmod.pitch + punchmod.yaw + punchmod.roll ) * 12

		local color_world = render.GetLightColor( tr.HitPos ) * 100
		local color_visor_default = Color( 255 - color_world.r, 255 - color_world.g, 255 - color_world.b, 32 )

		surface.SetDrawColor( color_visor_default )
		
		Circle( x, y, 2 * iSmartScope, 12 )
			
		if ( wep.GetSafeMode ) && ( wep:GetSafeMode() ) then
			draw.SimpleText( "safe", "HudHintTextLarge", x - 15, y + 32, color_visor_default, 0, 0 )
		end
		
		local ssColor = Color( 180, 180, 180, 180 * iSmartScope )
		surface.SetDrawColor( ssColor )

		fnArc( x, y, 64, ssRad, ssStart, ssEnd, 2 )
		
		for i = 1, iSmartScope * 3 do
			local angInitial = 120 * i - 90
			local angOffset = -180 * iSmartScope
			
			local angStart, angEnd = math.rad( -angInitial - angOffset * ( 1 - iSmartScope ) ), math.rad( angInitial + angOffset * ( 1 - iSmartScope ) )
			
			local radInner, radOuter = 16 * iSmartScope + punchmod, ( 16 + 16 * iSmartScope + punchmod * 0.5 ) * iSmartScope
			
			local xOff1, xOff2 = math.cos( angStart ) * radInner + x, math.cos( angStart ) * radOuter + x
			local yOff1, yOff2 = math.sin( angEnd ) * radInner + y, math.sin( angEnd ) * radOuter + y

			surface.DrawLine( xOff1, yOff1, xOff2, yOff2 )
		end

		dReloading = IsReloading
		--[[
		local TargetEntity = tr.Entity
		if IsValid( TargetEntity ) && !( tr.HitWorld || tr.HitSky ) && !( IsReloading ) then
			local iHealth = TargetEntity:Health()
			local dist = tr.StartPos:Distance( tr.HitPos )
			dist = math.Round( dist * 0.016933, 2 )
			
			local textOffsetX = 92 - 20 * iSmartScope
			
			draw.SimpleText( dist, "HudHintTextLarge", x + textOffsetX, y - 21, ssColor, 0, 0 )
			
			if ( iHealth > 0 ) then
				local hMax = TargetEntity:GetMaxHealth()
				local perc = ( iHealth / hMax ) * 100
				perc = math.Round( perc, 1 )

				draw.SimpleText( perc .. "%", "HudHintTextLarge", x + textOffsetX, y - 7, ssColor, 0, 0 )
		
				local name
				if ( TargetEntity:IsNPC() ) then
					name = language.GetPhrase( "#" .. TargetEntity:GetClass() )
				end
				
				if ( TargetEntity:IsPlayer() ) then
					name = TargetEntity:Nick()
					
					if ( TargetEntity:IsAdmin() ) then
						name = name .. " (Admin)"
					end
					
					if ( TargetEntity:IsBot() ) then 
						name = name .. " (Bot)"
					end
				end
				
				if ( name ) then	
					draw.SimpleText( name, "HudHintTextLarge", x + textOffsetX, y + 7, ssColor, 0, 0 )
				end
			end
			
			local iClip = wep:Clip1()
			if ( iClip > 0 ) then
			
			end
		end
		]]--
		if ( wep:GetCharge() > 1 ) then	
			surface.SetDrawColor( Color( color_visor_default.r,color_visor_default.g, color_visor_default.b, 64 ) )
			fnArc( x, y, 12 + 4 * iSmartScope, 2 * iSmartScope, 0, 360 * (  wep:GetCharge() / wep.ChargeMax ), 3 )
		end
	cam.End2D()
end

function SWEP:Think()

	local animtime = self:GetNextChargeAnim()	
	local vm = self.Owner:GetViewModel()
	local cmod = self:GetCharge() / 250
	
	self.ViewModelBoneMods[ "ValveBiped.Bip01_R_UpperArm" ].pos = Vector( 0, -0.2, -0.2 ) + ( Vector( 20, -2, -2 ) * cmod )
	self.ViewModelBoneMods[ "ValveBiped.Bip01_L_UpperArm" ].pos = Vector(-11, 5, -2.6) + ( Vector( 0, -3.5, 3.2 ) * cmod )
	self.ViewModelBoneMods[ "ValveBiped.Bip01_L_UpperArm" ].angle = Angle(-8.7, 8, -6.6) + ( Angle( 0, 0, -20 ) * cmod )
	
	self.VElements[ "3" ].pos = barrel_1_hpos + Vector( -4, 0, 4 ) * cmod
	self.VElements[ "3" ].angle = barrel_1_hang + Angle( -66, 0, 0 ) * cmod
	self.VElements[ "3+" ].pos = barrel_2_hpos + Vector( -4, 0, -4 ) * cmod
	self.VElements[ "3+" ].angle = barrel_2_hang + Angle( 56, 0, 0 ) * cmod
	self.VElements[ "arrow" ].color = Color( 255, 255, 255, 355 * cmod )
	self.VElements[ "arrow" ].size = Vector( 1, 1, 1 ) * cmod
	self.VElements[ "arrow" ].angle = Angle(0, -107.158, 90) + ( Angle( 1, 0, 0 ) * cmod )
	
	if ( CLIENT ) && ( self.Owner:ShouldDrawLocalPlayer() || !game.SinglePlayer() ) then
		for k, v in pairs( self.WorldModelBoneMods ) do
			local bone = self.Owner:LookupBone( k )

			if ( !bone ) then continue end
			
			local vBoneScale = Vector( v.scale.x, v.scale.y, v.scale.z )
			local vBoneOrigin = Vector( v.pos.x, v.pos.y, v.pos.z )
			
			local vScaleCurrent = self.Owner:GetManipulateBoneScale( bone )
			
			if ( vScaleCurrent != vBoneScale ) then
				self.Owner:ManipulateBoneScale( bone, vBoneScale )
			end
			
			if ( vScaleCurrent != v.angle ) then
				self.Owner:ManipulateBoneAngles( bone, v.angle )
			end

			if ( vScaleCurrent != vBoneOrigin ) then
				self.Owner:ManipulateBonePosition( bone, vBoneOrigin )
			end
		end
		
		self.WElements[ "3" ].pos = barrel_1_hpos + Vector( -2, 0, 4 ) * cmod
		self.WElements[ "3" ].angle = barrel_1_hang + Angle( -56, 0, 0 ) * cmod
		self.WElements[ "3+" ].pos = barrel_2_hpos + Vector( -2, 0, -4 ) * cmod
		self.WElements[ "3+" ].angle = barrel_2_hang + Angle( 56, 0, 0 ) * cmod
		self.WElements[ "arrow" ].color = Color( 255, 255, 255, 355 * cmod )
		self.WElements[ "arrow" ].size = Vector( 1, 1, 1 ) * cmod
		self.WElements[ "arrow" ].angle = Angle(10, -100, 90) + ( Angle( 1, 0, 0 ) * cmod )
		
		self.WorldModelBoneMods[ "ValveBiped.Bip01_R_UpperArm" ].pos = Vector( 0, 0, 0 ) + ( Vector( 0, 0, 0 ) * cmod )
		self.WorldModelBoneMods[ "ValveBiped.Bip01_R_UpperArm" ].angle = Angle( 0, 0, 0 ) + ( Angle( 4, 100, 20 ) * cmod )
		self.WorldModelBoneMods[ "ValveBiped.Bip01_R_Forearm" ].angle = Angle( 0, 0, 0 ) + ( Angle( 0, -100, 0 ) * cmod )
		self.WorldModelBoneMods[ "ValveBiped.Bip01_R_Hand" ].angle = Angle( 0, 0, 0 ) + ( Angle( 0, 0, -60 ) * cmod )
	end

	if ( CLIENT ) && ( GetConVarNumber( "sfw_allow_advanims" ) == 1 ) && ( self.SckAnimDeployed > 0 ) then
		self.SckAnimDeployed = math.Clamp( self.SckAnimDeployed - 1, 0, 100 )
		
		self.VElements[ "3" ].pos = barrel_1_hpos + Vector( 0, 0, -4 ) * ( self.SckAnimDeployed / 24 )
		self.VElements[ "3" ].angle = barrel_1_hang + Angle( 10, 0, 0 ) * ( self.SckAnimDeployed / 24 )
		self.VElements[ "3+" ].pos = barrel_2_hpos + Vector( 0, 0, 4 ) * ( self.SckAnimDeployed / 24 )
		self.VElements[ "3+" ].angle = barrel_2_hang + Angle( -14, 0, 0 ) * ( self.SckAnimDeployed / 24 )
	end

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			self.ViewModelBoneMods[ "ValveBiped.Bip01_R_Forearm" ].angle = Angle(-44.431, 13.605, 12.758) + ( Angle( 0, 0, 1 ) * cmod )
			self.ViewModelBoneMods[ "ValveBiped.Bip01_R_Hand" ].pos = Vector( 0, 0.8, 0.4 ) + ( Vector( 0, 0, 1 ) * cmod )
			self.ViewModelBoneMods[ "ValveBiped.Bip01_R_Hand" ].angle = Angle(28, 46, 12) + ( Angle( 0, 0, 1 ) * cmod )
		else
			self.ViewModelBoneMods[ "ValveBiped.Bip01_R_Forearm" ].angle = Angle(-44.431, 13.605, -22.758) + ( Angle( 0, 0, 0 ) * cmod )
			self.ViewModelBoneMods[ "ValveBiped.Bip01_R_Hand" ].pos = Vector( 0, 0.8, 0.4 ) + ( Vector( 0, 1, 1 ) * cmod )
			self.ViewModelBoneMods[ "ValveBiped.Bip01_R_Hand" ].angle = Angle(21.327, 33.988, -16.748) + ( Angle( 0, 0, 1 ) * cmod )
		end
	
		if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) ) then
			if ( self:GetCharge() < self.ChargeMax ) then
				self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
			end
		else
			if ( self:GetCharge() > 0 ) then
				self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
			end
		end

		if ( GetConVarNumber( "sfw_fx_particles" ) >= 1 ) then
			if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
				if ( self:GetNextCoreFxAnim() <= CurTime() ) then
					self:SetNextCoreFxAnim( CurTime() + 2 )
				end
			end
		end

		if ( self.Owner:KeyReleased( IN_ATTACK ) ) && ( !self.Owner:KeyDown( IN_RELOAD ) ) && ( self:GetCharge() >= 10 ) && (self.SciFiState ~= SCIFI_STATE_SPRINT ) then
			if ( SERVER || !game.SinglePlayer() ) then
				self:DefaultAttack()
				self:SetCharge( 0 )
			end
			if ( CLIENT ) then
				self:SetCharge( 0 )
			end
		end	
		
		if ( self.Owner:KeyDown( IN_ATTACK ) ) then
			if ( animtime >= 0 && CurTime() > animtime ) then
				if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) && ( self:GetCharge() >= 20 ) then
					ParticleEffectAttach( "jotunn_charging", 4, vm, vm:LookupAttachment("muzzle") )
				end
			end
			
			if ( animtime >= 0 && CurTime() > animtime ) then
				if ( SERVER ) then
					vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )
				end
				self:SetNextChargeAnim( CurTime() + 0.8 )
			end
		end
	else
		self.ViewModelBoneMods[ "ValveBiped.Bip01_R_Forearm" ].angle = Angle(-180, 0, 220)
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( GetConVarNumber( "sfw_allow_advanims" ) == 1 ) then
		if ( game.SinglePlayer() ) then
			self.SckAnimDeployed = 60
		else
			self.SckAnimDeployed = 20
		end
		
		for k, v in pairs( self.WorldModelBoneMods ) do
			local bone = self.Owner:LookupBone( k )

			if ( !bone ) then continue end
			
			local vBoneScale = Vector( v.scale.x, v.scale.y, v.scale.z )
			local vBoneOrigin = Vector( v.pos.x, v.pos.y, v.pos.z )
			
			local vScaleCurrent = self.Owner:GetManipulateBoneScale( bone )
			
			if ( vScaleCurrent != vBoneScale ) then
				self.Owner:ManipulateBoneScale( bone, vBoneScale )
			end
			
			if ( vScaleCurrent != v.angle ) then
				self.Owner:ManipulateBoneAngles( bone, v.angle )
			end

			if ( vScaleCurrent != vBoneOrigin ) then
				self.Owner:ManipulateBonePosition( bone, vBoneOrigin )
			end
		end
		
	--	self:EmitSound( "scifi.jotunn.holster" )
	end
	
	if ( CLIENT ) && ( IsValid(self.Owner) ) && ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
		
		for k, v in pairs( self.WorldModelBoneMods ) do
			local bone = self.Owner:LookupBone( k )

			if ( !bone ) then continue end
			
			local vBoneScale = Vector( v.scale.x, v.scale.y, v.scale.z )
			local vBoneOrigin = Vector( v.pos.x, v.pos.y, v.pos.z )
			
			local vScaleCurrent = self.Owner:GetManipulateBoneScale( bone )
			
			if ( vScaleCurrent != vBoneScale ) then
				self.Owner:ManipulateBoneScale( bone, vBoneScale )
			end
			
			if ( vScaleCurrent != v.angle ) then
				self.Owner:ManipulateBoneAngles( bone, v.angle )
			end

			if ( vScaleCurrent != vBoneOrigin ) then
				self.Owner:ManipulateBonePosition( bone, vBoneOrigin )
			end
		end
		
		self:SetAds( false )
	end

	self:ResetDeployment()
	return true

end

function SWEP:Deploy() 

	if ( GetConVarNumber( "sfw_allow_advanims" ) == 1 ) then
		self:EmitSound( "scifi.jotunn.deploy" )
	end

	self:SetAds( false )
	self:SetCharge( 0 )	
	
	for k,v in pairs( self.WElements ) do
		v.bone = "ValveBiped.Bip01_L_Hand"
	end

	return true
	
end

function SWEP:ResetDeployment()

	self:SetAds( false )
	self:EmitSound( "BaseGrenade.StopSounds" )
	
	local wOwner = self.Owner 

	if ( !wOwner || !IsValid( wOwner ) ) then
		wOwner = self.LastOwner
		
		if ( SERVER ) && ( wOwner && wOwner:IsPlayer() ) then
			net.Start( "SciFiUpdateOwnership" )
			net.WriteEntity( wOwner )
			net.Send( wOwner )
		end
	end

	if ( IsValid( wOwner ) && CLIENT && wOwner:IsPlayer() ) then
		local vm = wOwner:GetViewModel()

		if ( IsValid( vm ) ) then 
			vm:SetSubMaterial( 0, "" )
			vm:SetSubMaterial( 1, "" )
			vm:SetSubMaterial( 2, "" )
			vm:SetSubMaterial( 3, "" )
			vm:SetSubMaterial( 4, "" )
			
--			bSubMat = false
			
			self:ResetBonePositions( vm )
		end
	end
	
	for k,v in pairs( self.WElements ) do
		v.bone = "ValveBiped.Bip01_R_Hand"
	end
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( event == 6001 ) then 
		return true 
	end

	if ( event == 21 || event == 22 ) then
		return true
	end

end

function SWEP:DefaultAttack()
	
	if ( self:IsPlayer() ) && ( self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
	
	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
		
		local ent = ents.Create( "jotunn_arrow" )
		if ( !IsValid( ent ) ) then return end
		if (self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( self.Owner:GetShootPos() + ( self.Owner:GetRight() * 6 + self.Owner:GetUp() * -12 ) )
		else
			ent:SetPos( self.Owner:GetShootPos() )
		end
		ent:SetAngles( self.Owner:EyeAngles() ) --+ Angle( 0, 0, 90 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * ( 256 * self:GetCharge() ) )
		
		ent:SetNWInt( "charge", self:GetCharge() )
		
		if ( self:GetCharge() <= 80 ) then
			phys:EnableGravity( true )
		end
	end

	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( 0.01, 0.02 ), math.random( -0.4, -0.6 ), math.random( 0.4, 0.6 ) ) * ( 0.5 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 2 )
	end
	
--	ParticleEffectAttach( "jotunn_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	self:DoMuzzleEffect()
	
	self:EmitSound( "scifi.jotunn.fire" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:RemoveAmmo( 1, self.Primary.Ammo )
		self:AddSciFiACC( 1 )
	end
	
end

function SWEP:PrimaryAttack()

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
	
	local viewmodel = self:GetViewModelEnt()
	
	ParticleEffectAttach( "jotunn_charge_init", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	
	self:EmitSound( "scifi.jotunn.charge" )

end

function SWEP:NPCShoot_Primary( ShootPos, ShootDir )
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	
	ParticleEffectAttach( "jotunn_charge_init", PATTACH_POINT_FOLLOW, self, 1 )
	self:EmitSound( "scifi.jotunn.charge" )
	
	timer.Simple( 1, function()
		if !( IsValid( self ) && IsValid( self.Owner ) ) then return end
		
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
			
			self:SetCharge( 60 )
			
			self.NPCAimVectorOverride = ShootDir
		end
		
		if ( !ShootDir ) then
			local iParentBone = self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )
			ShootPos, ShootDir = self.Owner:GetBonePosition( iParentBone )
			ShootDir = ( ShootDir:Forward() + self.Owner:GetAimVector() ) * 0.5
		end
		
		self:DefaultAttack()
	end )

	self:SetNextPrimaryFire( CurTime() + 1.2 )
	self.Owner:SetSaveValue( "m_flLastAttackTime", ( CurTime() + 1.2 ) * -1 )
	self.Owner:SetSaveValue( "m_flNextAttack", 1.2 )

end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()

end