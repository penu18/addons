AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.ItemRank 				= 0

SWEP.Purpose 				= "A disruptive blast that overcharges energy signatures, both of biological and technological origin and causes targets to explode."
SWEP.Instructions 			= "Mouse1 to fire, Mouse2 to aim down sights. Shots cause NPCs and Players to explode, dealing massive damage to them and nearby targets."

SWEP.ViewModel				= "models/weapons/c_scifihc.mdl"
SWEP.WorldModel				= "models/weapons/w_357.mdl"
SWEP.SciFiSkin 				= "dev/hide" -- "models/weapons/helios/skin"
SWEP.SciFiWorld				= "dev/hide"
SWEP.ViewModelFOV 			= 60
SWEP.HoldType 				= "pistol" -- "revolver"
SWEP.HoldTypeSprint 		= "normal"
SWEP.DeploySpeed			= 1.6

SWEP.DefaultSwayScale		= 1
SWEP.DefaultBobScale		= 1
--SWEP.SprintSwayScale		= 2.0
--SWEP.SprintBobScale			= 3.0

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_phurt.vmt" )
end

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"

SWEP.PrintName				= "Helios"
SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.VfxMuzzleParticle 		= "ngen_muzzle"
SWEP.VfxMuzzleColor 		= Color( 210, 100, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 720

SWEP.SciFiMeleeASpeed		= 0.5
SWEP.SciFiMeleeRange		= 46
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.ReloadTime				= 2.8
SWEP.ReloadPlaybackRate 	= 0.9
SWEP.ReloadLegacy 			= false
SWEP.ReloadAnimEndIdle  	= true

SWEP.ViewModelSprintPos 	= Vector( -1, 8, -18 )
SWEP.ViewModelSprintAng		= Angle( 50, 0, 5 )
SWEP.ViewModelSwayDirection = Vector( -0.5, 4, 1 )

SWEP.SprintAnimSpeed		= 14

SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 3

SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( 0.05, -0.1, -0.15 )
SWEP.ViewModelShiftRotation = Vector( 0.8, 0.1, 0 )

SWEP.ViewModelMeleePos		= Vector( 10, 12, -19 )
SWEP.ViewModelMeleeAng		= Angle( 50, 35, -4 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -4, 3, -12 )
SWEP.ViewModelReloadAng		= Angle( 35, -25, -5 )

SWEP.AdsPos 				= Vector(-4.74, 8, 0.24)
SWEP.AdsAng 				= Angle( 0, 0, 0 )
SWEP.AdsFov					= 40
SWEP.AdsTransitionSpeed 	= 24

SWEP.SciFiACCRecoverRate	= 0.215

SWEP.FeelGoodEnabled 		= true
SWEP.FeelGoodHullEnabled 	= true
SWEP.FeelGoodHullSize 		= 2
SWEP.FeelGoodRatio 			= 0.25
SWEP.FeelGoodPunchPower 	= 0.0125
SWEP.FeelGoodScaleHip		= 0.75
SWEP.FeelGoodScaleAir 		= 0.4

SWEP.NPCAccuracy 			= 1
SWEP.NPCSkillLevel 			= 0
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= -0.1

-- SWEP.SciFiWorldStats		= { 
	-- ["1"] = { text = "Damage: 				 24 + 18, 24", color = Color( 180, 180, 180 ) },
	-- ["1a"] = { text = "Crit. mul.: 				2x", color = Color( 180, 180, 180 ) },
	-- ["3"] = { text = "Damage type: 	Crush, Radiation", color = Color( 85, 255, 220 ) },
	-- ["4"] = { text = "Fire rate: 				1.5 (semi-auto)", color = Color( 180, 180, 180 ) },
	-- ["5"] = { text = "Clip size: 					5", color = Color( 180, 180, 180 ) },
	-- ["6"] = { text = "4 consecutive hits or a fatal hit will cause targets to explode.", color = Color( 180, 180, 180 ) },
	-- ["6"] = { text = "Explosions can chain their effect to nearby targets once.", color = Color( 180, 180, 180 ) },
	-- ["7"] = { text = "This machine is not an angel, this disease is not a demon...", color = Color( 255, 20, 20 ) },
	-- ["7a"] = { text = "Their power is not unfathomable, I will not bow to false gods and I will take back our home.", color = Color( 255, 20, 20 ) },
	-- ["7c"] = { text = "Don't you dare to stand in my way.", color = Color( 255, 20, 20 ) },
	-- ["7d"] = { text = "~ The God-slayer.", color = Color( 255, 20, 20 ) },
-- }

local fFireRateDelay = 0.5

SWEP.SciFiWorldStats = {
	Primary = {
		DamageComposition = "24, 12; 50",
		DamageAmount = 36,
		DamageBlastRadius = 64,
		DamageType = { DMG_CRUSH, DMG_RADIATION },
		CritMul = 2,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = fFireRateDelay }, 
		}
	},
	ClipSize = SWEP.Primary.ClipSize,
	ReloadSpeed = 2.8,
	Recoil = 12,
	PerkSet = { SCIFI_PERK_ELEMENTAL_GRAVRIFLE_ONKILL, SCIFI_PERK_ELEMENTAL_GRAVRIFLE_OVERCHARGE, SCIFI_PERK_AMMO_RADIATION, { PerkTitle = "No More Gods", PerkDescription = "'This machine is not an angel,\n this disease is not a demon.'\n~ First of the Helios Knights", PerkPanelHeight = 4, PerkColor = Color( 255, 20, 20 ) } }
}

SWEP.DataTables = {
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Int", dName = "PerkDamage" },
	{ dType = "Float", dName = "PerkTime" }
}

SWEP.LastTargetEnabled = true
SWEP.LastTargetName = nil
SWEP.LastTargetTime = 0
SWEP.LastTargetInterval = 2

local bAds
local iState
local fAdsScale = 1
local iClipTime = 0
local iClipDelta = 0

local c_hud_bg = Color( 120, 120, 255, 0 )
local c_hud_fg = Color( 90, 70, 255, 0 )
local c_hud_glow = Color( 120, 90, 255, 0 )

local m_body = Material( "models/weapons/gravrifle/gravrifle_baset" )

local iGlow = 0
local fReload = 0

local vGlowColor = Vector( 0.6, 0.3, 2 ) -- Vector( 0.4, 0.6, 4.8 ) 

local m_pi 	= math.pi
local m_abs = math.abs
local m_rad = math.rad
local m_sin = math.sin
local m_cos = math.cos

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

local txGlow
if ( CLIENT ) then 
	txGlow = Material( "particle/particle_glow_04_additive.vmt" )
end

local fnSight = function( entWeapon, vOrigin, aRotation, fScale, x, y )

	if ( !IsValid( entWeapon ) ) then return end
	
	x = x || 0
	y = y || 0

	iState = entWeapon.SciFiState
	
	bAds = ( iState == SCIFI_STATE_ADS )

	if ( fAdsScale > 0 ) then
		c_hud_fg.a = 255 * fAdsScale
		
		draw.NoTexture()
		
		surface.SetDrawColor( c_hud_fg )
		
		-- local fArcRadius = 48 * ( 1 + entWeapon:GetSciFiACC() / 30 )

		fnArc( x, y, 48 - 32 * fAdsScale, 2, 0, 360, 3 )
		-- fnArc( x, y, fArcRadius - 32 * fAdsScale, 1, 0, 360, 3 )
		
		local c_reticle = Color( 140, 120, 255 )
		
		local trEyes = LocalPlayer():GetEyeTrace()
		if ( trEyes.Entity:IsNPC() || trEyes.Entity:IsPlayer() ) && ( trEyes.HitGroup == HITGROUP_HEAD ) then
			c_reticle = Color( 240, 10, 120 )
		end
		
		surface.DrawCircle( x, y, 1, c_reticle.r, c_reticle.g, c_reticle.b, c_hud_fg.a )
		
		local iClip = math.min( entWeapon:Clip1(), entWeapon.Primary.ClipSize )
		
		if ( iClipDelta > iClip ) then
			iClipTime = CurTime() + 1
		end
		
		iClipDelta = iClip
		
		for i = 1, iClip * fAdsScale do
			surface.SetDrawColor( c_hud_fg )
			
			local fArcScale = ( 360 * ( 1 / entWeapon.Primary.ClipSize ) )
			local fArcStart = fArcScale * ( i - 1 )
			local fArcEnd = fArcStart + ( fArcScale - ( fArcScale * 2 / 10 ) )
			
			fnArc( x, y, 48 - 28 * fAdsScale, 1, fArcStart, fArcEnd, 3 )
	
			if ( iClipTime > CurTime() ) && ( iClipDelta == i + 1 ) then
				local iClipScale = ( iClipTime - CurTime() ) / 1
				
				c_hud_bg.a = 200 * fAdsScale * iClipScale
				surface.SetDrawColor( c_hud_bg )
				
				fnArc( x, y, 48 - 24 * iClipScale, 1, fArcStart + fArcScale * 2, fArcEnd + fArcScale * 2, 3 )
			end
		end
		
		local fTime = entWeapon:GetNextPrimaryFire() - CurTime()
		if ( fTime > 0 ) then
			surface.SetDrawColor( Color( 220, 40, 60, c_hud_fg.a ) )
	
			fnArc( x, y, 14, 2, 0, 360 * ( fTime / 0.5 ), 3 )
		end
	end
	
	if ( !bAds ) && ( fAdsScale > 0 ) then
		fAdsScale = math.Approach( fAdsScale, 0, FrameTime() * 3 )
		iClipTime = CurTime()
	end

	if ( bAds ) && ( fAdsScale < 1 ) then
		fAdsScale = math.Approach( fAdsScale, 1, FrameTime() * 5 )
	end
	
end

SWEP.VElements = {
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_body.mdl", bone = "Python", rel = "", pos = Vector(0, 1.391, 0.887), angle = Angle(90, 0, -90), size = Vector(1.799, 2, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_barrel.mdl", bone = "Python", rel = "", pos = Vector(0, -0.2597, 10), angle = Angle(90, 0, -90), size = Vector(2, 2, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_barrel.mdl", bone = "Python", rel = "", pos = Vector(0, 1.257, 10), angle = Angle(90, 0, 90), size = Vector(2, 2, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_sight.mdl", bone = "Python", rel = "", pos = Vector(0, -1.3, 1.4), angle = Angle(90, 0, -90), size = Vector(3, 2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Bullet1", rel = "", pos = Vector(-0.04, 0.6, 2), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["4a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_sight.mdl", bone = "Python", rel = "4", pos = Vector(0, -0.28, 0), angle = Angle(-90, 0, -90), size = Vector(1, 2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_sight.mdl", bone = "Python", rel = "4", pos = Vector(-0.24, 0.14, 0), angle = Angle(-90, 122, -90), size = Vector(1, 2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4c"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_sight.mdl", bone = "Python", rel = "4", pos = Vector(0.24, 0.14, 0), angle = Angle(-90, -122, -90), size = Vector(1, 2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Python", rel = "", pos = Vector( 0, -2.25, 1 ), angle = Angle( 0, -90, 0 ), size = Vector(0.1, 0.1, 0.001), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/helios/holo", skin = 0, bodygroup = {} }
	-- ["5"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "Python", pos = Vector( 0, -2.25, 1 ), angle = Angle( 0, 0, 0 ), size = 0.01, draw_func = fnSight }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1, -3.5), angle = Angle(0, -90, -100), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "dev/hide", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_body.mdl", bone = "Python", rel = "0", pos = Vector(0, 1.391, 0.887), angle = Angle(90, 0, -90), size = Vector(1.799, 2, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_barrel.mdl", bone = "Python", rel = "0", pos = Vector(0, -0.2597, 10), angle = Angle(90, 0, -90), size = Vector(2, 2, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_barrel.mdl", bone = "Python", rel = "0", pos = Vector(0, 1.257, 10), angle = Angle(90, 0, 90), size = Vector(2, 2, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_sight.mdl", bone = "Python", rel = "0", pos = Vector(0, -1.3, 1.4), angle = Angle(90, 0, -90), size = Vector(3, 2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Bullet1", rel = "0", pos = Vector(-0.04, 0.6, 2), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["4a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_sight.mdl", bone = "Python", rel = "4", pos = Vector(0, -0.28, 0), angle = Angle(-90, 0, -90), size = Vector(1, 2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_sight.mdl", bone = "Python", rel = "4", pos = Vector(-0.24, 0.14, 0), angle = Angle(-90, 122, -90), size = Vector(1, 2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4c"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/gravrifle_sight.mdl", bone = "Python", rel = "4", pos = Vector(0.24, 0.14, 0), angle = Angle(-90, -122, -90), size = Vector(1, 2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

function SWEP:SubInit()

	self:SetHoldType( self.HoldType )

	self:SetPerkTime( 0 )
	self:SetPerkDamage( 0 )

end

local dState = 0

function SWEP:Think()

	if ( game.SinglePlayer() ) || ( !game.SinglePlayer() && CLIENT ) then
		local bReloading = ( self:GetSciFiState() == SCIFI_STATE_RELOADING )
		local bAds = ( self:GetSciFiState() == SCIFI_STATE_ADS )
		local fNextPrimaryFire = self:GetNextPrimaryFire() - CurTime()
		
		if ( bAds ) then
			-- if ( fNextPrimaryFire > 0 ) then
				-- local fAnimationScale = ( fNextPrimaryFire / fFireRateDelay )

				-- fAnimationScale = fAnimationScale * fAnimationScale
		
				-- self.AdsPos.x = -4.74 + 1 * fAnimationScale
				-- self.AdsPos.z = 0.24 - 0.90 * fAnimationScale
				-- self.AdsAng.pitch = -16 * fAnimationScale
				-- self.AdsAng.roll = 14 * fAnimationScale

				-- local aPunch = self.Owner:GetViewPunchAngles()
				-- self.Owner:SetViewPunchAngles( aPunch * ( 0.95 + fAnimationScale * 0.05 ) )
			-- else
				-- self.AdsPos.x = -4.74
				-- self.AdsPos.z = 0.24
				-- self.AdsAng.pitch = 0
				-- self.AdsAng.roll = 0
			-- end

			local fNextPrimaryFire = self:GetNextPrimaryFire() - CurTime()
			
			if ( fNextPrimaryFire > 0 ) then
				local fAnimationScale = fNextPrimaryFire / fFireRateDelay

				self.AdsPos.z = 0.24 - 0.80 * fAnimationScale
				self.AdsAng.pitch = -20 * fAnimationScale
				self.AdsAng.roll = 10 * fAnimationScale

				local aPunch = self.Owner:GetViewPunchAngles()
				self.Owner:SetViewPunchAngles( aPunch * ( 0.9 + fAnimationScale * 0.1 ) )
			else 
				self.AdsPos.z = 0.24
				self.AdsAng.pitch = 0
				self.AdsAng.roll = 0
			end
		end

		if ( bReloading ) then
			local vmCase = self.VElements[ "3" ]
			
			if ( fNextPrimaryFire < 3.5 && fNextPrimaryFire > 3 ) then
				fReload = Lerp( FrameTime() * 4, fReload, 1 )
			end
			
			if ( fNextPrimaryFire < 1 ) then
				fReload = Lerp( FrameTime() * 8, fReload, 0 )
			end
			
			vmCase.pos = Vector( 0, -1.3, 1.4 ) + Vector( 0, -1, 2 ) * fReload
		end

		if ( fNextPrimaryFire > -1 ) then
			local iClip = self:Clip1()
			iGlow = Lerp( FrameTime() * 12, iGlow, iClip )
			
			if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
				iGlow = -10
			end
			
			local vGlow = vGlowColor * iGlow + ( Vector( 1, 0, 0 ) * ( 1 - iGlow / self.Primary.ClipSize ) )

			m_body:SetVector( "$energycolor", vGlow )
			
			if ( !bReloading ) then
				local fSpin = math.max( fNextPrimaryFire + 1, 0 ) * 4
				self.VElements["4"].angle = self.VElements["4"].angle + Angle( 0, fSpin, 0 )
			end
		end
	end

	if ( self.SciFiState == SCIFI_STATE_ADS && dState ~= self.SciFiState ) then
		self:SetHoldType( "revolver" )
	end
	
	if ( dState == SCIFI_STATE_ADS && dState ~= self.SciFiState ) then
		self:SetHoldType( self.HoldType )
	end

	dState = self.SciFiState

	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	self:Anims()

end

local m_holosight = Material( "models/weapons/helios/holo" )
local m_debug = Material( "dev/rtscreen" )
local SizeX, SizeY = 512, 512
local rtScreen

function SWEP:AddAcc()

	if !( CLIENT  ) then return end

	if ( !rtScreen ) then
		rtScreen = GetRenderTarget( "_rt_holosight", SizeX, SizeY, false )
	end

	render.PushRenderTarget( rtScreen, 0, 0, SizeX, SizeY  )
	render.Clear( 0, 0, 0, 0 )
	render.OverrideAlphaWriteEnable( true, true )

	cam.Start2D()
	
	fnSight( self, Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1, 256, 256 )
	
	cam.End2D()
	
	if ( fAdsScale < 1 && fAdsScale > 0 ) then
		local fBlurBase = 12
		local fBlurScale = fBlurBase * fAdsScale
		render.BlurRenderTarget( rtScreen, fBlurBase - fBlurScale, fBlurBase - fBlurScale, fBlurBase - fBlurScale )
	end
	
	render.OverrideAlphaWriteEnable( false, false )
	render.PopRenderTarget()
	
	if ( fAdsScale == 0 ) then return end
	
	local vGlowColor = c_hud_fg:ToVector()

	m_holosight:SetTexture( "$basetexture", rtScreen )
	m_holosight:SetTexture( "$selfillummask", rtScreen )
	m_holosight:SetTexture( "$detail", rtScreen )
	m_holosight:SetTexture( "$emissiveBlendBaseTexture", rtScreen )

	m_holosight:SetFloat( "$detailblendfactor", 0.7 * fAdsScale )
	
	m_holosight:SetVector( "$selfillumtint", vGlowColor * 16 * fAdsScale )
	m_holosight:SetVector( "$emissiveblendtint", vGlowColor * 32 * fAdsScale )

end

function SWEP:PrimaryAttack()
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	local cmd_damageamp = GetConVar( "sfw_damageamp" ):GetFloat()
	local pOwnerAV = self.Owner:GetAimVector()
	
	if ( self.FeelGoodEnabled ) then
		pOwnerAV = self:GetFeelGoodVector( pOwnerAV )
	end
	
	self:SetNextPrimaryFire( CurTime() + fFireRateDelay )

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() * 0.001 )
	bullet.Spread = Vector( .0003, .0003 ) + Vector( .0005, .001 ) * ( self:GetSciFiACC() )
	bullet.Tracer = 1
	bullet.TracerName = "gravrifle_tracer"
	bullet.Force = 1 * cmd_damageamp
	-- bullet.HullSize = 4
	bullet.Damage = 24 * cmd_damageamp
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_CLUB, DMG_BULLET, DMG_NEVERGIB ) )

		if ( IsValid( tr.Entity ) && !tr.HitWorld ) then
			if ( !self.LastTargetName ) then
				self.LastTargetName = tr.Entity
			end
			
			if ( tr.Entity == self.LastTargetName ) && ( self:GetPerkTime() >= CurTime() ) then
				self:SetPerkDamage( self:GetPerkDamage() + 1 )
			else
				self:SetPerkDamage( 0 )
				self.LastTargetName = tr.Entity
			end
			
			self:SetPerkTime( CurTime() + 1 )
				
			local myeml = {}
			if ( self:GetPerkDamage() < 3 ) then
				myeml.Element = EML_DISSOLVE_GRAVRIFLE
			
				tr.Entity.m_bGravrifleChainingOverride = true
				tr.Entity.m_nGravrifleTime = CurTime()
			else
				myeml.Element = EML_GRAVRIFLE_BLAST
				
				self:SetPerkDamage( 0 )
				self:SetPerkTime( 0 )
				
				tr.Entity.m_bGravrifleChainingOverride = false
			end
			myeml.Target = tr.Entity
			myeml.Attacker = attacker
			myeml.Inflictor = self
			myeml.Origin = tr.HitPos
			
			DoElementalEffect( myeml )
			
			if ( tr.Entity.GetMaxHealth ) then
				tr.Entity.m_nGravrifleFuseTime = ( 0.5 + tr.Entity:GetMaxHealth() * 0.004 )
			else
				tr.Entity.m_nGravrifleFuseTime = 0.8
			end
		else
			self.LastTargetName = nil
			self:SetPerkDamage( 0 )
			self:SetPerkTime( 0 )
		end
		
		self:DealAoeDamage( bit.bor( DMG_SHOCK, DMG_RADIATION, DMG_NEVERGIB ), bullet.Damage * 0.5, tr.HitPos, 64, 64 )
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -3, -3.2 ), math.random( -0.1, 0.1 ), math.random( 0, 0.2 ) ) * ( 0.4 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 12 )

		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	end

	self:DoMuzzleEffect()

	self:EmitSound( "scifi.helios.fire" )
	-- self:EmitSound( "scifi.gravrifle.fire" )
	
	self:EmitSound( "scifi.helios.echo" )
	-- self:EmitSound( "scifi.solaris.echo" )
	
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

	if ( !game.SinglePlayer() && self:GetSciFiState() == SCIFI_STATE_ADS ) then
		local vm = self:GetViewModelEnt() 
		if ( IsValid( vm ) ) then 
			vm:SetPlaybackRate( 1 - FrameTime() * 3 )
		end
	end
	
end

function SWEP:PhysPrimaryAttack()
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	local cmd_damageamp = GetConVar( "sfw_damageamp" ):GetFloat()
	local pOwnerAV = self.Owner:GetAimVector()
	
	if ( self.FeelGoodEnabled ) then
		pOwnerAV = self:GetFeelGoodVector( pOwnerAV )
	end
	
	self:SetNextPrimaryFire( CurTime() + fFireRateDelay )
		
	local ent = ents.Create( "helios_physical" )
	if ( !IsValid( ent ) ) then return end
	if ( self:GetSciFiState() != SCIFI_STATE_ADS ) then
		ent:SetPos( self:GetProjectileSpawnPos() )
	else
		ent:SetPos( self.Owner:EyePos() + ( pOwnerAV * 16 ) )
	end
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:SetOwner( self.Owner )
	ent:SetInflictor( self )
	ent:Spawn()
	ent:Activate()
	ent:SetPhysicsAttacker( self.Owner, 10 )
	
	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end
	phys:ApplyForceCenter( pOwnerAV * 32000 + self:GetProjectileSpreadVector() * ( 1 + self:GetSciFiACC() * 8 ) )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -3, -3.2 ), math.random( -0.1, 0.1 ), math.random( 0, 0.2 ) ) * ( 0.4 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 12 )

		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	end

	self:DoMuzzleEffect()

	self:EmitSound( "scifi.helios.fire" )
	self:EmitSound( "scifi.helios.echo" )
	
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

	if ( !game.SinglePlayer() && self:GetSciFiState() == SCIFI_STATE_ADS ) then
		local vm = self:GetViewModelEnt() 
		if ( IsValid( vm ) ) then 
			vm:SetPlaybackRate( 1 - FrameTime() * 3 )
		end
	end
	
end

function SWEP:OnReload()

end

function SWEP:OnReloadFinish()

	self:SetNextPrimaryFire( CurTime() )

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return true end

	ParticleEffect( "lanka_hit_riv", tr.HitPos, tr.Normal:Angle() * -1, self )
	-- ParticleEffect( "gravrifle_hit", tr.HitPos, tr.Normal:Angle(), self )
	
	if ( tr.HitWorld ) then
		util.Decal( "Impact.Sand", tr.HitPos + tr.Normal * -4, tr.HitPos + tr.Normal * 4 )
	end

	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos )
	effectdata:SetNormal( tr.HitNormal )
	util.Effect( "gravrifle_hit", effectdata )
		--[[
		effectdata:SetScale( 4 )
		util.Effect( "waterripple", effectdata )
		]]--

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 195
			dlight.g = 120
			dlight.b = 255
			dlight.brightness = 1
			dlight.Decay = 1024
			dlight.Size = 32
			dlight.DieTime = CurTime() + 2
		end
	end
	
	return true

end