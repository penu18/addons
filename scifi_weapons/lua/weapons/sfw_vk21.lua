AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.PrintName				= "Z-27A 'Fang' Combat Rifle" -- "vk21 combat rifle"
SWEP.Slot					= 2
SWEP.SlotPos				= 2
SWEP.ItemRank 				= 16

SWEP.Purpose 				= "Preferred by Union special forces, the Z-27A delivers reliability and stunning performance in a light-weight frame with little to no emissions. It features full-auto and 3-round burst, the barrel can be equipped with a CovertAction suppressor."
SWEP.Instructions 			= "Mouse1 to fire, Mouse2 to aim down sights. E + Mouse1 to toggle suppressor, E + Mouse2 to toggle fire modes."

if ( CLIENT ) then
	SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_obsidian.vmt" )
end

SWEP.ViewModel				= "models/weapons/c_vk21_anim.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_famas.mdl"
SWEP.HoldType 				= "ar2"
SWEP.HoldTypeNPC 			= "ar2"

SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"
SWEP.ViewModelFOV 			= 54

SWEP.IhlExplicit 		= true
SWEP.IhlModel 			= "models/weapons/v_w_vk21.mdl"
SWEP.IhlSkin 			= 0
SWEP.IhlBodyGroups 		= {[1]=0, [2]=1, [3]=0}
SWEP.IhlHolsterPosition = Vector( -6, -7, -2 )
SWEP.IhlHolsterRotation = Angle( -10, 180, 0 )

SWEP.DeploySpeed 			= 2

SWEP.Primary.ClipSize		= 36
SWEP.Primary.DefaultClip	= 36
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.VfxMuzzleParticle	 	= "umbra_muzzle"
SWEP.VfxMuzzleAttachment 	= "1"
SWEP.VfxMuzzleColor 		= Color( 250, 50, 35, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 420
SWEP.VfxHeatParticle 		= "gunsmoke"

SWEP.ReloadTime 			= 1
SWEP.ReloadPlaybackRate 	= 1.8
SWEP.ReloadRealisticClips 	= false
SWEP.ReloadLegacy 			= false
SWEP.ReloadSND 				= ""
SWEP.DepletedSND			= "Weapon_AR2.Empty"
SWEP.ReloadModels 			= true
SWEP.ReloadGib 				= "models/weapons/v_w_vk21_mag.mdl"
SWEP.ReloadGibParentBone	= "ValveBiped.Bip01_R_Hand"
SWEP.ReloadGibOrigin		= Vector( -6, -1, 8 )
SWEP.ReloadGibDelay 		= 0.5

SWEP.AdsPos 				= Vector (-5.37, 0, 0.315 )
SWEP.AdsFov					= 38
SWEP.AdsTransitionSpeed		= 36

SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.fang.zoomin"
SWEP.AdsSoundDisable		= "scifi.fang.zoomout"

SWEP.DefaultSwayScale		= 2.6
SWEP.DefaultBobScale		= 3

SWEP.ViewModelSprintPos 	= Vector( 5, 1, -2 ) -- Vector( 5, 1.5, 1 )
SWEP.ViewModelSprintAng		= Angle( -4, 30, -30 ) -- Angle( -17.5, 25, -15 )
SWEP.ViewModelSwayDirection = Vector( -0.75, 6, 2 ) -- Vector( -0.25, 4, 0.6 )
SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.15 )
SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 4.25
SWEP.SprintAnimSpeed		= 10
SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.0

SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelDuckPos		= Vector( -3, -3, -1 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -20 )
SWEP.ViewModelMeleePos		= Vector( 16, 4, -7 )
SWEP.ViewModelMeleeAng		= Angle( 30, 70, -20 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -8, -2, -10 )
SWEP.ViewModelReloadAng		= Angle( 60, -12, 14 )
SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.05
SWEP.ViewModelShiftOffset 	= Vector( -0.01, -0.02, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )
SWEP.ViewModelSafeAnim	 	= true
SWEP.ViewModelSafePos 		= Vector( 2, 0, 0 )
SWEP.ViewModelSafeAng 		= Angle( 0, 30, -40 )

local nDamageBase = 8
local nFireRateDelay = 0.08

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = nDamageBase,
		DamageComposition = nil,
		DamageBlastRadius = nil,
		DamageAttackRange = nil,
		DamageType = DMG_BULLET,
		CritMul = 3,
		StatusChance = nil,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = nFireRateDelay }, 
			{ RateTitle = "burst", RateDelay = 0.14 }
		},
		ChargeRate = nil
	},
	-- Secondary = {
		-- DamageAmount = 240,
		-- DamageComposition = nil,
		-- DamageBlastRadius = 400,
		-- DamageType = DMG_BLAST,
		-- CritMul = nil,
		-- StatusChance = nil,
		-- FireRate = { 
			-- { RateTitle = "semi-auto", RateDelay = 1.2 },
		-- },
		-- ChargeRate = nil
	-- },
	CoreRechargeRate = nil,
	ClipSize = 36,
	ReloadSpeed = 1.8,
	Recoil = 2,
	PerkSet = { SCIFI_PERK_FANG_TRIPPLETAP, SCIFI_PERK_BARREL_STEALTH, SCIFI_PERK_AMMO_PUNCHTHROUGH_LIGHT, SCIFI_PERK_ACCESSORY_RECOIL }
}

SWEP.NPCAccuracy 			= 800
SWEP.NPCSkillLevel 			= 1
SWEP.NPCBulletSpread 		= 1
SWEP.NPCRestMin 			= 0.3
SWEP.NPCRestMax 			= 0.6
SWEP.NPCBurstMin 			= 1
SWEP.NPCBurstMax 			= 1
SWEP.NPCBurstDelay 			= 0.4

SWEP.Wrath = false

SWEP.LastTargetEnabled = true
SWEP.LastTargetName = nil
SWEP.LastTargetTime = 0
SWEP.LastTargetBuff = 1
SWEP.LastTargetInterval = 2

SWEP.FeelGoodEnabled = true
SWEP.FeelGoodRatio = 0.2

function SWEP:GetNPCRestTimes()
	return 0.01, 0.01
end

function SWEP:GetNPCBurstSettings()
	return 3, 3, 0.3
end

if ( CLIENT ) then
	surface.CreateFont( "vk21AmmoCounterFG", {
		font 		= "HalfLife2",
		extended 	= false,
		size 		= 63,
		weight 		= 0,
		blursize 	= 0,
		scanlines 	= 8,
		antialias 	= true,
		underline 	= false,
		italic 		= false,
		strikeout 	= false,
		symbol 		= false,
		rotary 		= false,
		shadow 		= false,
		additive 	= true,
		outline 	= true,
	} )

	surface.CreateFont( "vk21AmmoCounterBG", {
		font 		= "HalfLife2",
		extended 	= false,
		size 		= 63,
		weight 		= 500,
		blursize 	= 24,
		scanlines 	= 8,
		antialias 	= true,
		underline 	= false,
		italic 		= false,
		strikeout 	= false,
		symbol 		= false,
		rotary 		= false,
		shadow 		= false,
		additive 	= true,
		outline 	= false,
	} )
end

local c_hud_bg = Color( 255, 50, 50, 0 )
local c_hud_fg = Color( 255, 70, 60, 0 )
local c_hud_ammo = Color( 255, 70, 60, 255 )

local m_pi 	= math.pi
local m_abs = math.abs
local m_rad = math.rad
local m_sin = math.sin
local m_cos = math.cos

local fAdsScale = 0
local iClipTime = 0
local iClipDelta = 0

local function fnArc( x, y, radius, linewidth, startangle, endangle, aa )
	aa = math.abs( aa )

--	startangle = math.Clamp( startangle, 0, 360 )
--	endangle = math.Clamp( endangle, 0, 360 )

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
	
	draw.NoTexture()
	for k,v in pairs( arc ) do
		surface.DrawPoly( v )
	end
end

local iRadSmall, iRadMedium, iRadLarge = 96, 128, 192 -- 24, 32, 48
local iWidth = 4

local fnSight = function( entWeapon, vOrigin, aRotation, fScale )

	if ( !IsValid( entWeapon ) ) then return end

	iState = entWeapon:GetSciFiState()
	
	bAds = ( iState == SCIFI_STATE_ADS )
	
	if ( fAdsScale > 0 ) then
		local x, y = 256, 256
		
		c_hud_fg.a = 255 * fAdsScale
		
		surface.SetDrawColor( c_hud_fg )
		draw.NoTexture()
		
		local aPunch = entWeapon:GetOwner():GetViewPunchAngles()
		local iPunchPower = math.abs( aPunch.pitch + aPunch.yaw + aPunch.roll ) * 8
		
		surface.DrawCircle( x, y, 2 + iPunchPower, c_hud_fg.r, c_hud_fg.g, c_hud_fg.b, c_hud_fg.a )
		
		fnArc( x, y, iRadLarge - iRadMedium * fAdsScale + iPunchPower, iWidth * fAdsScale, 90 - 45 * fAdsScale + iPunchPower, 90 + 45 * fAdsScale - iPunchPower, 3 )
		fnArc( x, y, iRadLarge - iRadMedium * fAdsScale + iPunchPower, iWidth * fAdsScale, 270 - 45 * fAdsScale + iPunchPower, 270 + 45 * fAdsScale - iPunchPower, 3 )
		
		if ( entWeapon.LastTargetEnabled ) then
			local fPerkTime = entWeapon:GetPerkTime()
			if ( fPerkTime > CurTime() ) then
				local fDamageBuff = math.Round( entWeapon:GetPerkDamage(), 2 )
				-- draw.SimpleText( fDamageBuff, "vk21AmmoCounterFG", 0, iRadMedium, c_hud_fg, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
				-- draw.SimpleText( fDamageBuff, "vk21AmmoCounterBG", 0, iRadMedium, c_hud_fg, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

				local fPerkDecayScale = ( fPerkTime - CurTime() ) / 1
				fnArc( x, y, 48, ( iWidth * 0.5 ) * fAdsScale, 0, 360 * fPerkDecayScale, 3 )
			end
		end

		local iClip = entWeapon:Clip1()
		
		if ( iClipDelta > iClip ) then
			iClipTime = CurTime() + 1
		end
		
		iClipDelta = iClip
		
		if ( iClipTime > CurTime() ) then
			local iClipScale = ( iClipTime - CurTime() ) / 1
			
			c_hud_bg.a = 200 * fAdsScale * iClipScale
			
			surface.SetDrawColor( c_hud_bg )
			fnArc( x, y, iRadSmall - 4 * iClipScale, ( iWidth * 0.5 ) * fAdsScale, 90 + 180 * ( 1 - iClipDelta / entWeapon.Primary.ClipSize ), 270, 3 )
		end
		
		-- if ( iClip < 10 ) then
			-- iClip = "0"..iClip
		-- end
		
		-- draw.SimpleText( iClip, "vk21AmmoCounterFG", x-30, y+iRadLarge, c_hud_fg, 0, 0 )
		-- draw.SimpleText( iClip, "vk21AmmoCounterBG", x-30, y+iRadLarge, c_hud_fg, 0, 0 )
		
		-- local bMode = entWeapon:GetBurstMode()
		-- local sText = "auto"
		
		-- if ( bMode ) then
			-- sText = "burst"
		-- end
		
		-- draw.SimpleText( sText, "CloseCaption_Bold", x-22, y+iRadLarge + 90, c_hud_fg, 0, 0 )
	end
	
	if ( !bAds ) && ( fAdsScale > 0 ) then
		fAdsScale = math.Approach( fAdsScale, 0, FrameTime() * 4 )
		iClipTime = CurTime()
	end

	if ( bAds ) && ( fAdsScale < 1 ) then
		fAdsScale = math.Approach( fAdsScale, 1, FrameTime() * 6 )
	end

	-- debugoverlay.Cross( vOrigin, 4 * fAdsScale, FrameTime() * 2, c_hud_fg, true )
	
end

local fnAmmo = function( entWeapon, vOrigin, aRotation, fScale )

	if ( !IsValid( entWeapon ) ) then return end
		
		if ( entWeapon.LastTargetEnabled ) then
			local fPerkTime = entWeapon:GetPerkTime()
			if ( fPerkTime > CurTime() ) then
				local fDamageBuff = math.Round( entWeapon:GetPerkDamage(), 2 )
				draw.SimpleText( fDamageBuff, "vk21AmmoCounterFG", 0, iRadMedium, c_hud_fg, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
				draw.SimpleText( fDamageBuff, "vk21AmmoCounterBG", 0, iRadMedium, c_hud_fg, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
			end
		end
	
	-- if ( fAdsScale > 0 ) then
		local iClip = entWeapon:Clip1()
		
		if ( iClip < 10 ) then
			iClip = "0"..iClip
		end
		
		draw.SimpleText( iClip, "vk21AmmoCounterFG", 0, iRadLarge, c_hud_ammo, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		draw.SimpleText( iClip, "vk21AmmoCounterBG", 0, iRadLarge, c_hud_ammo, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		
		local bMode = entWeapon:GetBurstMode()
		local sText = "auto"
		
		if ( bMode ) then
			sText = "burst"
		end
		
		draw.SimpleText( sText, "CloseCaption_Bold", -22, iRadLarge + 90, c_hud_ammo, 0, 0 )
	-- end
	
end

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 3.5, -3, -1.1 ), angle = Angle( 0, -10, 2 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0.8, 1 ), angle = Angle( 0, 0, 0 ) },
	["v_weapon.famas"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0.95, 1, 0.8 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/v_w_vk21.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(0.05,0.6, 16), angle = Angle(90, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "", [1] = "", [2] = "", [3] = "" }, skin = 0, bodygroup = {[1]=0, [2]=1, [3]=1} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/v_w_vk21_mag.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, -0.7, -0.25), angle = Angle(100,- 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, submat = {}, skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(-0.3, 0.4, -0.75), angle = Angle(180, 0, 0), size = Vector(0.08, 0.1, 0.1), color = Color(120, 120, 120, 255), surpresslightning = false, submat = { [0] = "models/weapons/hwave/bbolt" }, skin = 0, bodygroup = {} },
	-- ["8"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "v_weapon.famas", pos = Vector( 0.065, -4.535, 12 ), angle = Angle( 0, 0, 0 ), size = 0.002, draw_func = fnSight }
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "v_weapon.famas", rel = "", pos = Vector( 0.065, -4.535, 14 ), angle = Angle( 0, -90, 0 ), size = Vector(0.0275, 0.0275, 0.001), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/vk21/holo" }, skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "v_weapon.famas", pos = Vector( 0.065, -4.535, 12 ), angle = Angle( 0, 0, 0 ), size = 0.002, draw_func = fnAmmo }
}

SWEP.WElements = {
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/v_w_vk21.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7, 0.8, -3), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, submat = {}, skin = 0, bodygroup = {[1]=0, [2]=1, [3]=0} },
	-- ["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "v_weapon.famas", rel = "5", pos = Vector( -3, 0.1, 5.1 ), angle = Angle( 90, 0, 0 ), size = Vector(0.03, 0.03, 0.001), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "models/weapons/vk21/holo" }, skin = 0, bodygroup = {} }
}

-- local snd_fire = Sound( "/weapons/asa/hybridammo_fire2.wav" )
local snd_fire = Sound( "/weapons/ancient/astra_fire_normal.wav" )
local snd_lowammo = Sound( "/weapons/fang/fang_lowammo.wav" )

SWEP.DataTables = {
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Bool", dName = "CanBurst" },
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Bool", dName = "Silenced" },
	{ dType = "Int", dName = "BurstCount" },
	{ dType = "Int", dName = "PerkInterval" },
	{ dType = "Float", dName = "PerkTime" },
	{ dType = "Float", dName = "PerkDamage" }
}

local function ToggleSilenced( bState, entTarget )
	if !( entTarget.GetSilenced ) then return end
	
	local self = entTarget

	if ( bState ) then
		self.VElements["5"].bodygroup[2]=0
		self.WElements["5"].bodygroup[2]=0
		self.IhlBodyGroups[2]=0
		
		self.VfxMuzzleParticle = "umbra_muzzle_embers" 
		self.VfxMuzzleRule = 0
	else
		self.VElements["5"].bodygroup[2]=1
		self.WElements["5"].bodygroup[2]=1
		self.IhlBodyGroups[2]=1

		self.VfxMuzzleParticle = "umbra_muzzle"
		self.VfxMuzzleRule = 3
	end
end

if ( SERVER ) then
	util.AddNetworkString( "SciFiNetWeaponAttachments" )
end

net.Receive( "SciFiNetWeaponAttachments", function( nLength, pReceiver )
	local entTarget = net.ReadEntity()

	if ( !IsValid( entTarget ) ) then return end
		
	local bState = net.ReadBool()
	
	ToggleSilenced( bState, entTarget )
end )

function SWEP:SubInit()
	if ( IsValid( self.Owner ) && self.Owner:IsNPC() ) && ( self.Owner:GetClass() == "npc_combine_s" ) then
		self:SetSilenced( true )

		if ( CLIENT ) then
			self.VfxMuzzleParticle = "umbra_muzzle_embers" 
			self.VfxMuzzleRule = 0
		end
		
		self.VElements["5"].bodygroup[2]=0
		self.WElements["5"].bodygroup[2]=0
		self.IhlBodyGroups[2]=0
	else
		self:SetSilenced( false )
	end
	
	self:SetBurstMode( false )
	self:SetPerkDamage( 1 )
	self:SetPerkTime( 0 )
	self:SetPerkInterval( 0 )
	
	if ( !self.SequenceDurationLegacy ) then
		self.SequenceDurationLegacy = self.SequenceDuration
		
		self.SequenceDuration = function()
			
			local fDuration = self:SequenceDurationLegacy()
			local fPlaybackRate = self:GetPlaybackRate()
			
			return fDuration * math.max( 2 - fPlaybackRate, 0 ) --  * ( 1 / fPlaybackRate )
		end
	end
	
	if ( CLIENT ) then
		self:DrawShadow( false )
		self:DestroyShadow()
	end
end

local m_holosight = Material( "models/weapons/vk21/holo" )
local SizeX, SizeY = 512, 512
local rtScreen

-- local m_devtest = Material( "models/weapons/chimera/sight_thermal" )
-- local m_heatsignature = Material( "models/shared/heatsignature.vmt" )

function SWEP:AddAcc()
	if !( CLIENT  ) then return end
	
	-- if ( !rtScreen ) then
		-- rtScreen = GetRenderTarget( "_rt_holosight", SizeX, SizeX, false )
	-- end
	
	-- render.PushRenderTarget( rtScreen, 0, 0, 512, 512, false )
	
	-- render.Clear( 0, 0, 0, 255 )
	-- render.OverrideAlphaWriteEnable( true, true )
	
	-- cam.Start3D( EyePos(), EyeAngles(), 25, 0, 0, 512, 512 )
	
	-- render.SuppressEngineLighting( true )
	-- render.SetBlend( 0.2 )
	-- render.MaterialOverride( m_heatsignature )

	-- for k, v in pairs( npcs.GetAll() ) do
		-- render.SetColorModulation( 0.5, 0.2, 0.2 )
		-- v:DrawModel()
	-- end

	-- render.SuppressEngineLighting( false )
	-- render.SetColorModulation( 1, 1, 1 )
	-- render.SetBlend( 1 )
	-- render.MaterialOverride()
	
	-- cam.End3D()
	
	-- render.OverrideAlphaWriteEnable( false, false )
	-- render.PopRenderTarget()
	
	-- m_devtest:SetTexture( "$basetexture", rtScreen )
	-- m_holosight:SetTexture( "$basetexture", rtScreen )
	-- m_holosight:SetTexture( "$emissiveBlendBaseTexture", rtScreen )
	-- m_holosight:SetTexture( "$selfillummask", rtScreen )

	-- if ( true ) then return end

	if ( !rtScreen ) then
		rtScreen = GetRenderTarget( "_rt_holosight", SizeX, SizeY, false )
	end

	render.PushRenderTarget( rtScreen, 0, 0, SizeX, SizeY  )
	render.Clear( 0, 0, 0, 0 )
	render.OverrideAlphaWriteEnable( true, true )

	cam.Start2D()
	
	fnSight( self, Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1 )
	
	cam.End2D()
	
	render.OverrideAlphaWriteEnable( false, false )
	render.PopRenderTarget()
	
	if !( fAdsScale > 0 ) then return end

	m_holosight:SetTexture( "$basetexture", rtScreen )
	m_holosight:SetTexture( "$emissiveBlendBaseTexture", rtScreen )
	m_holosight:SetTexture( "$selfillummask", rtScreen )
	-- m_holosight:SetFloat( "$emissiveBlendStrength", 16 * fAdsScale )
	-- m_holosight:SetVector( "$selfillumtint", c_hud_fg:ToVector() )
end

local dSilent
local bSilent
local bBurst
local dReloading
local dClip1 = 0

function SWEP:Think()

	bSilent = self:GetSilenced()
	bBurst = self:GetBurstMode()
	
	if ( CLIENT ) then
		local bReloading = self:GetSciFiState() == SCIFI_STATE_RELOADING
		local fNextPFire = self:GetNextPrimaryFire() - CurTime()
		
		-- top-axis offset to fix the CS:S famas' shitty firing animation --
		if ( self:GetSciFiState() == SCIFI_STATE_ADS ) && ( !bReloading && fNextPFire > FrameTime() * -1.2 * self.ChargeDeltaFactor && self:Clip1() > 0 ) then
			local vmEntity = self.Owner:GetViewModel()
			
			if ( IsValid( vmEntity ) ) then
				if ( !game.SinglePlayer() ) then
					vmEntity:SetPlaybackRate( 2 )
				end
				
				local seq = vmEntity:GetSequence()

				if ( seq < 4 ) then
					self.AdsPos.z = 0.7
				elseif ( seq == 4 ) then
					self.AdsPos.z = 0.7
				elseif ( seq > 4 ) then
					self.AdsPos.z = 0.85
				end
			end
		else
			self.AdsPos.z = 0.315
		end
		
		if ( bReloading ) && ( !dReloading ) then
			self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
			self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
			self.ViewModelBoneMods["ValveBiped.Bip01_L_Hand"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
			self.ViewModelBoneMods["v_weapon.famas"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
			
			self.ViewModelReloadPos	= Vector( -8, -2, -10 )
			self.ViewModelReloadAng	= Angle( 45, -12, 14 )
		end
		
		if ( !bReloading ) && ( dReloading ) then
			self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 3.5, -3, -1.1 ), angle = Angle( 0, -10, 2 ) }
			self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0.8, 1 ), angle = Angle( 0, 0, 0 ) }
			self.ViewModelBoneMods["ValveBiped.Bip01_L_Hand"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
			self.ViewModelBoneMods["v_weapon.famas"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1, 0.8 ), angle = Angle( 0, 0, 0 ) }
		end
		
		if ( bReloading ) then
			local fReloadScale = math.Clamp( fNextPFire / self.ReloadTime, 0, 1 )

			if ( fReloadScale < 0.5 ) then
				fReloadScale = 1 - ( fReloadScale * 2 )
				local fReloadScaleAdaptive = math.sin( fReloadScale * 2.5 )
				
				self.ViewModelReloadAng.pitch = 45 + 10 * fReloadScale
				self.ViewModelReloadAng.yaw = -12 + 4 * fReloadScale
				self.ViewModelReloadAng.roll = 12 + 24 * fReloadScaleAdaptive
				self.ViewModelReloadPos.x = -8 - 1 * fReloadScale
				self.ViewModelReloadPos.z = -10 + 2 * fReloadScaleAdaptive
			end
		end
		
		dReloading = bReloading
		
		local iSkin = self:GetSkin()
		self.VElements[ "5" ].skin = iSkin
		self.VElements[ "6" ].skin = iSkin
		self.WElements[ "5" ].skin = iSkin
	end

	if ( bBurst ) && ( SERVER || !game.SinglePlayer() ) then
		local fNextPFire = self:GetNextPrimaryFire()
		
		if ( self:CanBFire() ) && ( fNextPFire < CurTime() && fNextPFire > -1 ) then
			if ( self:GetBurstCount() < 3 && self:GetCanBurst() ) && ( fNextPFire > -1 ) then
				self:Attack()
				
				self:SetCanBurst( true )
				self:SetBurstCount( self:GetBurstCount() + 1 )

				self:SetNextPrimaryFire( CurTime() + 0.065 )
			end
			
			if ( self:GetBurstCount() > 2 ) then
				self:SetNextPrimaryFire( CurTime() + 0.25 )
				self:SetCanBurst( false )
				self:SetBurstCount( 0 )
			end
		end	
	end
		
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

local tEventBlacklist = { 
	[ 20 ] = true, 
	[ 5001 ] = true, 
	[ 5003 ] = true 
}

function SWEP:FireAnimationEvent( pos, ang, event, options )

	local vm = self:GetViewModelEnt() 
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 2 )
	end

	if ( CLIENT ) then
		local ammo = self:Clip1()
		local threshold = self.Primary.ClipSize * 0.3
		
		if ( ammo < threshold ) then
			local offset = threshold - ammo
			offset = offset
				
			local iPitchMin, iPitchMax = 83, 87
			iPitchMin, iPitchMax = iPitchMin + offset, iPitchMax + offset

			local pitch = math.random( iPitchMin, iPitchMax )
			local vol = 0.4 + 0.6 * ( offset * 0.08 )
-- print( offset, vol ) 
			self:EmitSound( snd_lowammo, 50 + offset, pitch, vol, CHAN_STATIC )
		end
	end

	if ( tEventBlacklist[ event ] ) then
		return true
	end

end

function SWEP:CanBFire()

	if ( self.Weapon:Clip1() <= 0 ) then
		self:SetBurstCount( 3 )
		return false
	end

	return true
	
end

local m_exp, m_clamp = math.exp, math.Clamp
local function GetDamageFalloff( base, exponent, n )

	if ( !n ) then 	
		n = 1
	end

--	local fFallOff = m_exp( -0.69 / exponent ) * n
	local fFallOff = n * ( base ^ exponent )

	fFallOff = m_clamp( fFallOff, 0.001, 1 )
	
	return fFallOff
	
end

function SWEP:Attack( pOwnerAV )
	
	if ( !pOwnerAV ) then
		pOwnerAV = self.Owner:GetAimVector()
	end
	
	if ( self.FeelGoodEnabled ) then
		pOwnerAV = self:GetFeelGoodVector( pOwnerAV )
	end
	
	local iDmg = nDamageBase * GetConVar( "sfw_damageamp" ):GetFloat()

	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 0
	-- ptru.TracerName = "spr_tracer_noattach"
	ptru.Distance = 1024
--	ptru.AmmoType = "smg1"
	ptru.Damage = iDmg * 0.75
	ptru.IgnoreEntity = NULL

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() / 128 )
	bullet.Spread = Vector( .001, .002 ) + Vector( .001, .002 ) * ( self:GetSciFiACC() )
--	bullet.AmmoType = "SMG1"
	bullet.TracerName = "emg_tracer" -- "spr_tracer"
	
	if ( self.Wrath ) then
		bullet.Tracer = 1
		bullet.Force = 2
		bullet.HullSize = 4
		bullet.Damage = iDmg * 1.5
	else
		bullet.Tracer = 0
		bullet.Force = 1
		bullet.HullSize = 0 -- 0.05
		ptru.HullSize = 1
		bullet.Damage = iDmg
	end

	bullet.Callback = function( attacker, tr, dmginfo )
		if ( tr.HitGroup ) && ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:ScaleDamage( 1.5 )
		end
		
		local fScale = 1

		if ( SERVER ) && ( self:GetSilenced() ) then
			fScale = GetDamageFalloff( ( 1 - tr.Fraction ), 4, 1 )

			if ( tr.Entity:IsNPC() ) && ( tr.Entity:GetNPCState() == NPC_STATE_IDLE ) then
				fScale = fScale * 3
			end
			
			dmginfo:ScaleDamage( fScale )
		end

		if ( self.LastTargetEnabled ) then
			if ( tr.Entity && !tr.HitWorld ) then
				if ( !self.LastTargetName ) then
					self.LastTargetName = tr.Entity
				end
				
				if ( tr.Entity == self.LastTargetName ) && ( self:GetPerkTime() >= CurTime() ) then
					self:SetPerkInterval( self:GetPerkInterval() + 1 )
					
					if ( self:GetPerkInterval() > self.LastTargetInterval ) then
						self:SetPerkDamage( self:GetPerkDamage() + 0.1 )
						self:SetPerkInterval( 0 )
						-- self:EmitSound( "scifi.fang.perk" )
					end
				else
					self:SetPerkInterval( 1 )
					self:SetPerkDamage( 1 )
					self.LastTargetName = tr.Entity
				end
				
				self:SetPerkTime( CurTime() + 1 )
				dmginfo:ScaleDamage( self:GetPerkDamage() )
			else
				self.LastTargetName = nil
				self:SetPerkInterval( 0 )
				self:SetPerkDamage( 1 )
				self:SetPerkTime( 0 )
			end
		end
	
		if !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) then
			if ( tr.MatType == MAT_GLASS ) || ( tr.MatType == MAT_WOOD ) then
				ptru.Src = tr.HitPos + tr.Normal * 8
				ptru.Dir = tr.Normal + tr.Normal
				ptru.Damage = ptru.Damage * fScale

				self.Owner:FireBullets( ptru, false )
				ParticleEffect( "umbra_ptru", ptru.Src, ptru.Dir:Angle() )
			end

			if ( ( tr.MatType == MAT_METAL ) || ( tr.MatType == MAT_CONCRETE ) ) then
				local bouncer = ( tr.Normal - tr.HitNormal )
				bouncer = bouncer:Length()
				
				if ( ( bouncer < 1.8 ) ) then
					ptru.Src = tr.HitPos - tr.Normal -- * 16
					ptru.Dir = tr.Normal - 2 * tr.Normal:Dot( tr.HitNormal ) * tr.HitNormal
					
					debugoverlay.Line( ptru.Src, ptru.Src - tr.Normal * 16, 4, color_white, true )
					debugoverlay.Line( ptru.Src, ptru.Src + ptru.Dir * 16, 4, color_white, true )

					self.Owner:FireBullets( ptru, false )
					ParticleEffect( "umbra_ptru", ptru.Src, ptru.Dir:Angle() )
				end
			end
		end
		
		-- if ( !tr.Entity:IsWorld() ) then
			-- DoElementalEffect( {
				-- Element = EML_DISSOLVE_GRAVRIFLE,
				-- Target = tr.Entity,
				-- Attacker = self.Owner,
				-- Inflictor = self,
				-- Origin = tr.HitPos
			-- } )
			
			-- tr.Entity.m_bGravrifleChainingOverride = true
		-- end
		
		if ( self.Wrath ) then
			local myeml = {}
			myeml.Element=EML_DISSOLVE_CELESTWRATH
			myeml.Attacker=self.Owner
			myeml.Range=4
			myeml.Ticks=1
			myeml.DslvMaxMass=500
			myeml.Origin=tr.HitPos
			
			DoElementalEffect(myeml)
			
			dmginfo:SetDamageType( DMG_SF_PHASEBLADE )

			ParticleEffect( "emg_hit", tr.HitPos, tr.Normal:Angle() )
		else
			dmginfo:SetDamageType( DMG_BULLET )
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		if ( game.SinglePlayer && SERVER ) || ( CLIENT && IsFirstTimePredicted() ) then
			self.Owner:ViewPunch( Angle( math.random( -90, -110 ), math.random( -40, 40 ), 0 ) * ( 0.002 + self:GetSciFiACC() * 0.001 ) )
		end
		
		if ( self:GetBurstMode() ) then
			self:AddSciFiACC( 2 - self:GetBurstCount() * 0.5 )
		else
			self:AddSciFiACC( 2 )
		end
	end

	self:DoMuzzleEffect()

	if ( self:GetSilenced() ) then
		self:EmitSound( "scifi.fang.fire.silent" )
	else
		if ( self.Wrath ) then
			local ammo = self:Clip1()
			local iPitchMin, iPitchMax = 98, 102
			
			if ( ammo < 12 ) then
				local offset = 12 - ammo
				
				iPitchMin, iPitchMax = iPitchMin + offset, iPitchMax + offset
			end

			local pitch = math.random( iPitchMin, iPitchMax )

			self:EmitSound( snd_fire, 60, pitch, 1, CHAN_STATIC )
			self:EmitSound( "scifi.fang.fire.default" )
			
			if ( self.Owner:WaterLevel() < 2 ) then
				self:EmitSound( "scifi.fang.fire.echo" )
			end
		else
			self:EmitSound( "scifi.fang.fire.default" )
			
			if ( self.Owner:WaterLevel() < 2 ) then
				self:EmitSound( "scifi.fang.fire.echo" )
			end
		end
	end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
	
	local vm = self:GetViewModelEnt() 
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 2 )
	end
	
end

function SWEP:PrimaryAttack()
	
	if ( self.Owner:IsNPC() ) then
		if ( self:GetNextPrimaryFire() > CurTime() ) then return end
		
		timer.Create( "fang_bfire_"..self:EntIndex(), nFireRateDelay, 3, function() 
			if ( !IsValid( self ) || !IsValid( self.Owner ) || !self:CanPrimaryAttack( 0, true ) ) then return end
			
			self:Attack()
		end )
		
		self:SetNextPrimaryFire( CurTime() + 0.6 )
		
		return
	end

	if ( self.Owner:KeyDown( IN_USE ) && self:GetNextPrimaryFire() < CurTime() ) then
		local bState
		
		if ( self:GetSilenced() ) then 
			bState = false
		
			if ( !game.SinglePlayer() && CLIENT ) || ( game.SinglePlayer() && SERVER ) then
				self:EmitSound( "scifi.fang.silence.off" )
			end
		else
			bState = true
			
			if ( !game.SinglePlayer() && CLIENT ) || ( game.SinglePlayer() && SERVER ) then
				self:EmitSound( "scifi.fang.silence.on" )
			end
		end
		
		if ( SERVER ) then
			net.Start( "SciFiNetWeaponAttachments" )
			net.WriteEntity( self )
			net.WriteBool( bState )
			net.Broadcast()
			
			ToggleSilenced( bState, self )
		end
		
		self:SetSilenced( bState )

		self:SetNextPrimaryFire( CurTime() + 0.2 )
	
		return
	end

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	if ( self:GetBurstMode() ) && ( self.Owner:IsPlayer() ) then
		if ( self:GetBurstCount() > 2 ) then return end
		
		self:SetCanBurst( true )
	else
		self:Attack()
	
		self:SetNextPrimaryFire( CurTime() + nFireRateDelay )
	end

end

function SWEP:SecondaryAttack()

	self:SetNextSecondaryFire( CurTime() + 0.4 )
	
	if ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetBurstMode() ) then 
			self:SetBurstMode( false )
		else
			self:SetBurstMode( true )
		end
		
		self:EmitSound( "Weapon_AR2.Empty" )
	end

end

function SWEP:OnReload()

	if ( self:Clip1() > 0 ) then
		self.ReloadTime = 1.2
		self.ReloadPlaybackRate = 1.6
	else
		self.ReloadTime = 1.8
		self.ReloadPlaybackRate = 1.6
	end
	
	if ( CLIENT ) then
		if ( self.Owner:ShouldDrawLocalPlayer() ) then
			self:EmitSound( "scifi.fang.reload.npc" )
		end
	end

end

function SWEP:OnReloadFinish()

	if ( CLIENT ) then
		self:EmitSound( "scifi.fang.reload.finish" )
	end
	
	self:SetSciFiACC( 0 )

	self:SendWeaponAnim( ACT_VM_IDLE )

	self:SetCanBurst( false )
	self:SetBurstCount( 0 )

end

function SWEP:OnSprint( bSprinting )
	
	if ( CLIENT ) then
		if ( bSprinting ) then
			self:EmitSound( "scifi.sprint.holster" )
		else
			self:EmitSound( "scifi.sprint.ready" )
		end
	end
	
end

function SWEP:Deploy() 

	self:SetAds( false )

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self:SetSciFiState( SCIFI_STATE_IDLE )
		self:SetMeleeCharge( 0 )
		self:SetSciFiACC( 4 )
		
		self:EmitSound( "scifi.sprint.ready" )
	end
	
	self:ResetAnimationScale()
	
	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( IsValid(self.Owner) ) && ( self.Owner:IsPlayer() ) then
		self:ResetBonePositions()
		self:ResetAnimationScale()
	end
	
	self:SetSciFiState( SCIFI_STATE_IDLE )

	self:EmitSound( "scifi.sprint.holster" )

	self:SetAds( false )

	self:ResetDeployment()

	return true

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	ParticleEffect( "umbra_hit", tr.HitPos, tr.Normal:Angle() )

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 255
			dlight.g = 20
			dlight.b = 10
			dlight.brightness = 0.6
			dlight.Decay = 2048
			dlight.Size = 32
			dlight.DieTime = CurTime() + 0.5
		end
	end

end

function SWEP:TranslateActivity( act )

	if ( self.Owner:IsNPC() ) then
		if ( act == ACT_RELOAD ) then
			local iState = self:GetSciFiState()
			local ammo = self:Clip1()
			
			local bReloading = iState == SCIFI_STATE_RELOADING
			
			if ( ammo < self.Primary.ClipSize ) then
				if ( !bReloading ) then
					self:SetSciFiState( SCIFI_STATE_RELOADING )
					self:EmitSound( "scifi.fang.reload.npc" )
				end
			else
				if ( bReloading ) then
					self:SetSciFiState( SCIFI_STATE_IDLE )
				end
			end
		end
		
		if ( act == 2115 || act == 2116 || act == 2117 ) then
			self:NPCShoot_Primary()
		end
		
		if ( self.ActivityTranslateAI[ act ] ) then
			return self.ActivityTranslateAI[ act ]
		end
		
		return -1
	end

	if ( self.ActivityTranslate[ act ] != nil ) then
		return self.ActivityTranslate[ act ]
	end

	return -1

end