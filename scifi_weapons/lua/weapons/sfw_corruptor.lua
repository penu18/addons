AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.ItemRank 				= 0

SWEP.PrintName				= "RK56 'Corruptor'"
SWEP.Purpose 				= "The RK56 is a hard-hitting hand cannon, defiled by an Inferiant artifact."
SWEP.Instructions 			= "Mouse1 to fire, Mouse2 to aim down sights. Hold Reload while out of ammo to convert health into ammo. Headshots have increased chance to inflict elemental status. Ammunition will drop from enemies killed with elemental damage."

SWEP.IhlExplicit 		= true
SWEP.IhlModel 			= "models/weapons/v_w_corruptor.mdl"
SWEP.IhlMaterialOverride = ""
SWEP.IhlSkin 			= 0
SWEP.IhlBodyGroups 		= {}
SWEP.IhlHolsterPosition = Vector( 0, 0, -6 )
SWEP.IhlHolsterRotation = Angle( -0, 0, 90 )

SWEP.Slot					= 1
SWEP.SlotPos				= 1

if ( CLIENT ) then
	SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_storm.vmt" )
end

SWEP.ViewModel				= "models/weapons/c_scifi_hc_base.mdl"
SWEP.WorldModel				= "models/weapons/w_357.mdl"
SWEP.SciFiSkin 				= "dev/hide"
SWEP.SciFiWorld 			= "dev/hide"
SWEP.ViewModelFOV 			= 60
SWEP.HoldType 				= "pistol" -- "revolver"
SWEP.HoldTypeNPC 			= "revolver"
SWEP.HoldTypeSprint 		= "normal"
SWEP.DeploySpeed			= 1.6

SWEP.DefaultSwayScale		= 1
SWEP.DefaultBobScale		= 1

SWEP.Primary.ClipSize		= 24
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "InferiantCharge"

SWEP.VfxMuzzleParticle 		= "corruptor_muzzle"
SWEP.VfxMuzzleColor 		= Color( 230, 60, 40, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 720

SWEP.SciFiMeleeASpeed		= 0.5
SWEP.SciFiMeleeRange		= 46
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.ReloadTime				= 2.8
SWEP.ReloadPlaybackRate 	= 1
SWEP.ReloadLegacy 			= false
SWEP.ReloadAnimEndIdle  	= true
SWEP.ReloadModels 			= true
SWEP.ReloadSND 				= "scifi.corruptor.reload.begin"
SWEP.ReloadGib 				= "models/weapons/corruptor_ammo.mdl"
SWEP.ReloadGibParentBone	= "ValveBiped.Bip01_R_Hand"
SWEP.ReloadGibOrigin		= Vector( -8, -1, 2 )
SWEP.ReloadGibDelay 		= 1.5
SWEP.ReloadGibSize 			= 1.25

SWEP.DepletedSND			= "scifi.corruptor.dryfire"

SWEP.ViewModelSprintPos 	= Vector( -1, 6, -16 )
SWEP.ViewModelSprintAng		= Angle( 50, -5, 5 )
SWEP.ViewModelSwayDirection = Vector( 1, 6, 0 )

SWEP.SprintAnimSpeed		= 14

SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 2

SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( 0.05, -0.1, -0.15 )
SWEP.ViewModelShiftRotation = Vector( 0.8, 0.1, 0 )

SWEP.ViewModelMeleePos		= Vector( 10, 12, -19 )
SWEP.ViewModelMeleeAng		= Angle( 50, 35, -4 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -5, 2.5, -7 )
SWEP.ViewModelReloadAng		= Angle( 28, -20, 5 )
SWEP.ViewModelReloadAnimSpeed = 3

SWEP.AdsPos 				= Vector( -4.74, 4, 0.1 )
SWEP.AdsAng 				= Angle( 0, 0, 0 )
SWEP.AdsFov					= 40
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.corruptor.zoomin"
SWEP.AdsSoundDisable		= "scifi.corruptor.zoomout"

SWEP.FeelGoodEnabled = true
SWEP.FeelGoodHullEnabled = true
SWEP.FeelGoodHullSize = 2
SWEP.FeelGoodRatio = 0.2

SWEP.LastTargetName = nil
SWEP.LastTargetTime = 0
SWEP.LastTargetBuff = 1

-- Give NPCs aimbot, lol
SWEP.NPCAccuracy 			= 1 -- 500
SWEP.NPCSkillLevel 			= 0 -- 1
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= -0.05

-- Flag as "umbra style" weapon to enable full compatibilty with dark damage elemental effect
-- Note, can this be done in a more modular / convenient way?
SWEP.CanLeechFromDark = true

SWEP.DataTables = {
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Int", dName = "Combo" },
	{ dType = "Float", dName = "ComboTime" },
	{ dType = "Float", dName = "PerkTime" },
	{ dType = "Float", dName = "PerkDamage" }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/v_w_corruptor.mdl", bone = "Python", rel = "", pos = Vector(0, 0.2, -1), angle = Angle(90, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Python", rel = "", pos = Vector( 0, -2.42, 1 ), angle = Angle( 0, -90, 0 ), size = Vector(0.1, 0.1, 0.001), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/dark/corruptor_holo", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/corruptor_drum.mdl", bone = "Cylinder", rel = "", pos = Vector(0, 0.2, -0.8), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/corruptor_ammo.mdl", bone = "Bullet1", rel = "", pos = Vector(0, 0.9, 0.2), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/v_w_corruptor.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.4, 1.4, -3.8), angle = Angle(-10, 0, 170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/corruptor_drum.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.6, 1.4, -4.1), angle = Angle(-4, -90, 170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/corruptor_ammo.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.2, 1.4, -4), angle = Angle(-4, -90, 170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- New stats-table format --
SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "20, 5",
		DamageAmount = 30,
		DamageType = { DMG_BULLET, DMG_SF_DARK },
		CritMul = 2,
		StatusChance = 25,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.4 }, 
		},
		ChargeRate = nil
	},
	CoreRechargeRate = nil,
	ClipSize = 8,
	ReloadSpeed = 3,
	Recoil = 8,
	PerkSet = { SCIFI_PERK_ELEMENTAL_DARK, SCIFI_PERK_ESCALATINGSTATUS, SCIFI_PERK_RELOAD_RECHARGEAMMO_DARK, SCIFI_PERK_CORRUPTED_IMPURERELOAD }
}

-- Amount of ammo drawn per shot. --
local iHunger = 3

local bAds
local fAdsScale = 1
local iClipTime = 0
local iClipDelta = 0
local iFading = 0
local fClipIndicatorLifeTime = 0.6

local c_hud_bg = Color( 120, 60, 40, 0 )
local c_hud_fg = Color( 180, 80, 60, 0 )

local iGlow = 0
local fReload = 0

local vGlowColor = Vector( 0.6, 0.3, 2 )

local m_abs = math.abs
local m_rad = math.rad
local m_sin = math.sin
local m_cos = math.cos

-- Precache textures and vgui materials used for the holo sights --
local txGlow, txAmmoIndicator
if ( CLIENT ) then 
	txGlow = surface.GetTextureID( "models/weapons/dark/corruptor_holo_base" )
	txAmmoIndicator = surface.GetTextureID( "models/weapons/dark/corruptor_holo_ammo" )
end

local fnSight = function( entWeapon, vOrigin, aRotation, fScale, x, y )

	if ( !IsValid( entWeapon ) ) then return end -- S A N I T Y     C H E C K S --

	x = x || 0
	y = y || 0

	bAds = ( entWeapon:GetSciFiState() == SCIFI_STATE_ADS )

	if ( fAdsScale > 0 ) then
		c_hud_fg.a = 255 * fAdsScale
		
		draw.NoTexture()
		
		surface.SetDrawColor( c_hud_fg )
		
		surface.DrawCircle( x, y, 1, 140, 120, 255, c_hud_fg.a )
		
		-- Convert to defacto ammo count since we're drawing more than one ammo-unit per shot. --
		local iClip = entWeapon:Clip1() / iHunger
		
		if ( iClipDelta > iClip ) then
			iClipTime = CurTime() + fClipIndicatorLifeTime
			iFading = iClipDelta
		end
		
		surface.SetTexture( txAmmoIndicator )
		
		local fArcInitialScale = 120
		local fArcInitialStart = 65
		local fArcRadius = 80 + 20 * ( 1 - fAdsScale )
		
		-- Draw ammo indicators --
		for i = 1, iClip * fAdsScale do
			local fArcScale = fArcInitialScale
			fArcScale = ( fArcScale * ( 1 / ( entWeapon.Primary.ClipSize / iHunger ) ) )
			
			local fArcStart = fArcInitialStart
			if ( i>4 ) then
				fArcStart = fArcStart * 2.5
			end
			fArcStart = 105 + fArcStart + fArcScale * ( i - 1 )
			
			-- Calculate the position along a circle --
			local spin1 = math.rad( fArcStart )
			
			surface.DrawTexturedRectRotated( math.cos( spin1 ) * -fArcRadius + x, math.sin( spin1 ) * -fArcRadius + y, 24, 16, 360 - fArcStart )
		end

		-- Draw fading ammo indicator effect -- 
		if ( iClipTime > CurTime() ) then
			local iClipScale = 1 - ( iClipTime - CurTime() ) / fClipIndicatorLifeTime

			c_hud_bg.a = 200 * fAdsScale * iClipScale
			surface.SetDrawColor( c_hud_bg )	
			
			local fArcScale = fArcInitialScale
			fArcScale = ( fArcScale * ( 1 / ( entWeapon.Primary.ClipSize / iHunger ) ) )
			
			local fArcStart = fArcInitialStart
			if ( iFading > 4 ) then
				fArcStart = fArcStart * 2.5
			end
			fArcStart = 105 + fArcStart + fArcScale * ( iFading - 1 )
			
			local spin1 = math.rad( fArcStart )

			local fArcRadiusModulated = fArcRadius + 16 * iClipScale * iClipScale
			surface.DrawTexturedRectRotated( math.cos( spin1 ) * -fArcRadiusModulated + x, math.sin( spin1 ) * -fArcRadiusModulated + y, 16 + 16 * iClipScale, 16 * ( 1 - iClipScale ), 360 - fArcStart )
		end
		
		iClipDelta = iClip

		surface.SetTexture( txGlow )
		surface.DrawTexturedRect( 128, 128, 256, 256 )
	end
	
	-- fade sight in/out -- 
	-- using math.Approach() instead of Lerp(), because Lerp() isn't reliably approaching 0 within the timeframe I'd expect and I don't want to use math.Round()
	if ( !bAds ) && ( fAdsScale > 0 ) then
		fAdsScale = math.Approach( fAdsScale, 0, FrameTime() * 3 )
		iClipTime = CurTime()
	end

	if ( bAds ) && ( fAdsScale < 1 ) then
		fAdsScale = math.Approach( fAdsScale, 1, FrameTime() * 5 )
	end
	
end

-- More precaching
local m_holosight = Material( "models/weapons/dark/corruptor_holo" )
local m_holobase = Material( "models/weapons/dark/corruptor_holo_base" )
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

	-- Create render context --
	cam.Start2D()
	
	fnSight( self, Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1, 256, 256 )
	
	cam.End2D()
	
	-- Blur holo sight texture during ADS transition. --
	-- This DOES break depth sorting, so we'll be only do it while in-transition and pretend it's not an issue. --
	if ( fAdsScale < 1 && fAdsScale > 0 ) then
		local fBlurInitial = 12
		local fBlur = fBlurInitial - fBlurInitial * fAdsScale
		render.BlurRenderTarget( rtScreen, fBlur, fBlur, fBlur )
	end
	
	render.OverrideAlphaWriteEnable( false, false )
	render.PopRenderTarget()
	
	-- Don't bother writing into the material when not actually aiming down sights -- 
	if ( fAdsScale == 0 ) then return end
	
	local vGlowColor = c_hud_fg:ToVector()

	-- Write data into material --
	m_holosight:SetTexture( "$basetexture", rtScreen )
	m_holosight:SetTexture( "$selfillummask", rtScreen )
	m_holosight:SetTexture( "$emissiveBlendBaseTexture", rtScreen )
	
	m_holosight:SetVector( "$color2", vGlowColor * vGlowColor * 8 * fAdsScale )
	m_holosight:SetVector( "$selfillumtint", vGlowColor * 16 * fAdsScale )

end

function SWEP:SubInit()

	self:SetPerkDamage( 20 )
	self:SetPerkTime( 0 )
	
end

SWEP.Primary.AmmoDelta = 0

local m_body, m_ammo = Material( "models/weapons/dark/corruptor_body" ), Material( "models/weapons/dark/corruptor_drum" )

function SWEP:Think()
	
	-- Hacky first-person animation fix while aiming down sights --
	-- Note: This also offsets the muzzle position for the local player downwards to about the hight of their knees. --
	-- To counter this, the tracer will offset the effect's start position back to where we want it to be when firing in first person while aiming down sights. --
	-- Like I said, super hacky... --
	if ( ( game.SinglePlayer() || ( !game.SinglePlayer() && CLIENT ) ) && self:GetSciFiState() == SCIFI_STATE_ADS ) then -- && self:Clip1() > 2 ) then
		local fNextPrimaryFire = self:GetNextPrimaryFire() - CurTime()
		
		if ( fNextPrimaryFire > 0 ) then
			local fAnimationScale = fNextPrimaryFire / 0.4

			self.AdsPos.z = 0.06 - 0.80 * fAnimationScale
			self.AdsAng.pitch = -20 * fAnimationScale
			self.AdsAng.roll = 10 * fAnimationScale

			local aPunch = self.Owner:GetViewPunchAngles()
			self.Owner:SetViewPunchAngles( aPunch * ( 0.9 + fAnimationScale * 0.1 ) )
		else 
			self.AdsPos.z = 0.06
			self.AdsAng.pitch = 0
			self.AdsAng.roll = 0
		end
	end

	if ( SERVER ) then
		local iAmmoReserves = self.Owner:GetAmmoCount( self.Primary.Ammo )
		local iClip = self:Clip1()
		
		-- Regenerate ammo when "impure spectrum" has been picked up and added to the inventory. -- 
		-- Idealy, the item_ammo_inferiant entity should check whether or not the weapon held by the player has the dark-reload-perk and refill the mag there, instead of doing it in the weapon, --
		-- but this way will have to suffice until the weapon base has been updated to a truly modular system --
		if !( self:GetSciFiState() == SCIFI_STATE_RELOADING ) && ( iClip < self.Primary.ClipSize ) then
			if ( iAmmoReserves > self.Primary.AmmoDelta ) then
				local iGain = math.min( iHunger * 2, self.Primary.ClipSize - iClip )
				
				self:SetClip1( iClip + iGain )
				self.Owner:RemoveAmmo( iGain, self.Primary.Ammo )
				
				self:SetComboTime( CurTime() + 2 )
				self:SetCombo( self:GetCombo() + 1 )
			end
		end
	
		self.Primary.AmmoDelta = iAmmoReserves
		
		-- Leech player health and convert into ammo --
		if ( iAmmoReserves < 1 ) && ( self.Owner:KeyDown( IN_RELOAD ) ) && ( iClip < self.Primary.ClipSize ) && ( self:GetNextPrimaryFire() < CurTime() ) then
			self.Owner:GiveAmmo( iHunger, self.Primary.Ammo, true )
			
			local LeechInfo = DamageInfo()
			LeechInfo:SetDamage( iHunger * 3 )
			LeechInfo:SetDamageType( bit.bor( DMG_FALL, DMG_PREVENT_PHYSICS_FORCE, DMG_SF_DARK ) ) -- Use a damage type that ignores shields
			LeechInfo:SetAttacker( self.Owner )
			LeechInfo:SetInflictor( self )
			LeechInfo:SetDamageForce( Vector( 0, 0, 0 ) )
			self.Owner:TakeDamageInfo( LeechInfo )
			
			DoElementalEffect( { Element = EML_DARK, Target = self.Owner, Attacker = self.Owner } ) -- Unlike the sfw_umbra, this weapon inflicts dark status when leeching. Remove for consistency?

			local delay = 0.5
			
			-- Just hand over ammo when in god mode, no point in making people wait. --
			if ( self.Owner:HasGodMode() ) then
				delay = 0.01
			end
			
			self:SetNextPrimaryFire( CurTime() + delay )
		end
	end
	
	-- Change hold type while aiming down sights to fake a third person aiming animation --
	if ( self:GetSciFiState() == SCIFI_STATE_ADS && dState != self:GetSciFiState() ) then
		self:SetHoldType( "revolver" )
	end
	
	if ( dState == SCIFI_STATE_ADS && dState != self:GetSciFiState() ) then
		self:SetHoldType( self.HoldType )
	end

	dState = self.SciFiState

	-- Weapon "heart beat" effect when impure spectrum refill the magazine.
	if ( self:GetComboTime() < CurTime() ) then
		self:SetCombo( 0 )
		
		if ( CLIENT ) then
			m_ammo:SetInt( "$emissiveBlendStrength", 0.4 )
			m_ammo:SetFloat( "$FleshBorderWidth", 12 )
			m_body:SetFloat( "$FleshBorderWidth", 12 )
		end
	else
		if ( CLIENT ) then
			local fBuffScale = ( self:GetComboTime() - CurTime() ) * 0.5
			fBuffScale = math.sin( fBuffScale * 3 ) * fBuffScale

			m_ammo:SetFloat( "$emissiveBlendStrength", 0.4 + 600 * fBuffScale )
			m_ammo:SetFloat( "$FleshBorderWidth", 12 - 12 * fBuffScale )
			
			m_body:SetFloat( "$emissiveBlendStrength", 0.4 + 4 * fBuffScale )
			m_body:SetFloat( "$FleshBorderWidth", 12 - 12 * fBuffScale )
		end
	end

	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	self:Anims()

end

function SWEP:OnAds( bAimingDownSights )
	if ( bAimingDownSights ) then
		-- local entViewModel = self.Owner:GetViewModel()
		-- entViewModel:ResetSequenceInfo() -- Doesn't work on viewmodel entities, lmao
		
		-- hacky "fix" to counter the idle animation's z-axis offset --
		self.AdsPos.z = 0.2
		
		-- Update iClipDelta so the fading ammo indicator animation doesn't play automatically on the last known ammo count --
		iClipDelta = self:Clip1() / 3
	end
end

local tFireSounds = {
	"scifi.corruptor.fire01",
	"scifi.corruptor.fire02",
	"scifi.corruptor.fire03",
}

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( iHunger - 1, true ) ) then return end
	
	local cmd_damageamp = GetConVar( "sfw_damageamp" ):GetFloat()
	local pOwnerAV = self.Owner:GetAimVector()
	
	if ( self.FeelGoodEnabled ) then
		-- Get aim assist --
		pOwnerAV = self:GetFeelGoodVector( pOwnerAV )
	end
	
	-- NPC fire rate hack ... which doesn't work --
	-- if ( self.Owner:IsNPC() ) then
		-- local tSav = self.Owner:GetSaveTable()
		-- print(tSav.m_flNextAttack,tSav.m_flLastAttackTime,tSav.m_nNumShotsFired)
		-- if ( tSav.m_flNextAttack > 0.4 ) then return end
	
		-- self.Owner:SetSaveValue( "m_flNextAttack", 0.4 )
		-- self.Owner:SetSaveValue( "m_flLastAttackTime", CurTime() + 0.4 )
		-- self.Owner:SetSaveValue( "m_nNumShotsFired ", 1 )
	-- end

	if ( self.Owner:IsNPC() ) then
		if ( self:GetNextPrimaryFire() > CurTime() ) then return end
		
		self.Owner:SetSaveValue( "m_flLastAttackTime", -0.4 )
		self.Owner:SetSaveValue( "m_flNextAttack", -0.4 )
	end
	
	self:SetNextPrimaryFire( CurTime() + 0.4 )	

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() / 256 ) -- Vertical recoil pattern --
	bullet.Spread = Vector( .003, .003 ) * self:GetSciFiACC() -- Random spread multiplied by recoil value --
	bullet.Tracer = 1
	bullet.TracerName = "corruptor_tracer"
	bullet.Force = 4
	-- bullet.HullSize = 0.5
	bullet.Damage = 20 * cmd_damageamp
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_SF_DARK )
		dmginfo:SetInflictor( self )
		dmginfo:SetAttacker( self.Owner )
		
		-- Don't make it pure "Dark" damage ... for reasons ... --
		self:DealAoeDamage( DMG_BULLET, bullet.Damage * 0.25, tr.HitPos, 64 )
		
		if ( tr.Entity && !tr.HitWorld ) then
			-- Ensure we actually hit the same target and can't refresh the buff on something else. --
			if ( !self.LastTargetName ) then
				self.LastTargetName = tr.Entity
			end
			
			-- Escalating status perk: We hit the same target multiple again within the 1 second timeframe to add +20% status chance. --
			-- While this technically does scale infinitely, status chance above 100% has no effect. --
			if ( tr.Entity == self.LastTargetName ) && ( self:GetPerkTime() >= CurTime() ) then
				self:SetPerkDamage( self:GetPerkDamage() + 20 )
			else
				self:SetPerkDamage( 20 )
				self.LastTargetName = tr.Entity
			end
			
			-- Refresh perk timer to 1 second --
			self:SetPerkTime( CurTime() + 1 )
		
			local iStatus = math.random( 0 + self:GetPerkDamage(), 100 )
			local iThreshold = 75
			
			-- Hidden perk: Bonus +20% status chance on headshot --
			if ( tr.HitGroup == HITGROUP_HEAD ) then
				-- dmginfo:ScaleDamage( 1.5 )
				iThreshold = 55
			end

			-- Inflict elemental status ---
			if ( iStatus > iThreshold ) then
				local myeml = {}
				myeml.Element = EML_DARK
				myeml.Target = tr.Entity
				myeml.Attacker = attacker
				myeml.Inflictor = self
				myeml.Origin = tr.HitPos
				
				DoElementalEffect( myeml )
			end
			
			-- Default to impact damage when we hit something that can't be effected by dark damage anyway --
			-- We're creating the impression of a hard-hitting weapon firing one hell of a bullet, so it should effect props and environmental entities accordingly --
			if !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) then
				dmginfo:SetDamageType( DMG_CLUB )
			end
		else
			dmginfo:SetDamageType( DMG_CLUB )
			
			-- Reset perk, because we fucking whiffed our shot --
			self.LastTargetName = nil
			self:SetPerkDamage( 1 )
			self:SetPerkTime( 0 )
		end
	end

	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -4, -5 ), math.random( -0.1, 0.1 ), math.random( 0, 0.2 ) ) * ( 0.4 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 8 )
	end

	self:DoMuzzleEffect()


	-- Play one of three firing sounds. Sound.Add does not support randomized sounds like default source soundscripts, so we'll use what we have.
	self:EmitSound( tFireSounds[ math.random( 1, 3 ) ] )
	if ( self.Owner:WaterLevel() < 2 ) then
		-- Play echo sound in CHAN_STATIC channel to create "loud gunshot" effect when above water.
		self:EmitSound( "scifi.solaris.echo" )
	end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( iHunger ) -- Draw 3 ammo, iHunger is defined above.

	-- Super hacky fire-rate animation fix for multiplayer
	if ( !game.SinglePlayer() && self:GetSciFiState() == SCIFI_STATE_ADS ) then
		local vm = self:GetViewModelEnt() 
		if ( IsValid( vm ) ) then 
			vm:SetPlaybackRate( 1 - FrameTime() * 3 )
		end
	end

end

function SWEP:OnReloadGibCreated( entReloadGib, physReloadGib )

	ParticleEffectAttach( "gunsmoke", PATTACH_ABSORIGIN_FOLLOW, entReloadGib, 0 )

end

function SWEP:OnReload()

	self:SetHoldType( self.HoldType )
		
end

function SWEP:OnReloadFinish()

	self:SetNextPrimaryFire( CurTime() )

end

local tImpactSounds = {
	Sound( "/weapons/umbra/corruptor_impact_01.wav" ),
	Sound( "/weapons/umbra/corruptor_impact_02.wav" ),
	Sound( "/weapons/umbra/corruptor_impact_03.wav" ),
	Sound( "/weapons/umbra/corruptor_impact_04.wav" ),
	Sound( "/weapons/umbra/corruptor_impact_05.wav" ),
	Sound( "/weapons/umbra/corruptor_impact_06.wav" ),
}

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return true end

	if ( CLIENT ) then
		
		ParticleEffect( "corruptor_impact", tr.HitPos, Angle( 0, 0, 0 ) )
		
		EmitSound( tImpactSounds[ math.random( 1, 6 ) ], tr.HitPos, tr.Entity:EntIndex(), CHAN_STATIC, 1, 60, 0, math.random( 95, 105 ) )
		
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 220
			dlight.g = 90
			dlight.b = 60
			dlight.brightness = 1
			dlight.Decay = 1024
			dlight.Size = 32
			dlight.DieTime = CurTime() + 0.4
		end
	end
	
	return false

end