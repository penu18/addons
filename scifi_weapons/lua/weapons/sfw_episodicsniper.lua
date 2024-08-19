AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false

SWEP.ItemRank 				= 20

SWEP.PrintName				= "Pulse Sniper"
SWEP.Purpose 				= "[PLACEHOLDER]"
SWEP.Instructions 			= "[PLACEHOLDER]"

SWEP.IhlExplicit 		= true
SWEP.IhlModel 			= "models/weapons/w_combine_sniper.mdl"
SWEP.IhlMaterialOverride = ""
SWEP.IhlSkin 			= 0
SWEP.IhlBodyGroups 		= {}
SWEP.IhlHolsterPosition = Vector( -14, -4, 3 )
SWEP.IhlHolsterRotation = Angle( 20, -10, 0 )

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel				= "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel				= "models/weapons/w_snip_g3sg1.mdl"
SWEP.SciFiSkin 				= "dev/hide"
SWEP.SciFiSkin_1 			= "dev/hide"
SWEP.SciFiWorld 			= "dev/hide"
SWEP.ViewModelFOV 			= 52
SWEP.HoldType 				= "ar2"
SWEP.HoldTypeNPC 			= "ar2"
SWEP.HoldTypeSprint 		= "passive"
SWEP.DeploySpeed			= 1.2

SWEP.DefaultSwayScale		= 1
SWEP.DefaultBobScale		= 1

SWEP.Primary.ClipSize		= 4
SWEP.Primary.DefaultClip	= 4
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "XBowBolt"

SWEP.VfxMuzzleParticle 		= "ngen_muzzle_2"
SWEP.VfxMuzzleColor 		= Color( 130, 160, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 720

SWEP.ReloadTime				= 2.8
SWEP.ReloadPlaybackRate 	= 1
SWEP.ReloadLegacy 			= false
SWEP.ReloadAnimEndIdle  	= true
SWEP.ReloadModels 			= false
SWEP.ReloadSND 				= "scifi.corruptor.reload.begin"
SWEP.ReloadGib 				= "models/weapons/corruptor_ammo.mdl"
SWEP.ReloadGibParentBone	= "ValveBiped.Bip01_R_Hand"
SWEP.ReloadGibOrigin		= Vector( -6, -1, 8 )
SWEP.ReloadGibDelay 		= 1.4
SWEP.ReloadGibSize 			= 1.25

SWEP.DepletedSND			= "scifi.solaris.bback"

SWEP.ViewModelSprintPos 	= Vector( 4, 0, -2 )
SWEP.ViewModelSprintAng		= Angle( -4, 30, -30 )
-- SWEP.ViewModelSwayDirection = Vector( -0.75, 5, 1 )
-- SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.125 )
SWEP.ViewModelSwayDirection = Vector( -0.75, 6, 1 )
SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.2 )
SWEP.ViewModelSprintRatio 	= 0.6
SWEP.ViewModelSprintSway 	= 4
SWEP.SprintAnimSpeed		= 12
SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.0

SWEP.ViewModelMeleePos		= Vector( 10, 12, -19 )
SWEP.ViewModelMeleeAng		= Angle( 50, 35, -4 )
SWEP.ViewModelReloadAnim 	= false
SWEP.ViewModelReloadPos		= Vector( -4, 3, -6 )
SWEP.ViewModelReloadAng		= Angle( 15, -20, -5 )

SWEP.AdsPos 				= Vector(-7.58, -12, 0.72)
SWEP.AdsAng 				= Angle( 0, 0, 0 )
SWEP.AdsFov					= 4
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.sprint.ready"
SWEP.AdsSoundDisable		= "scifi.sprint.holster"
SWEP.AdsTransitionSpeed		= 8

SWEP.AdsRTScopeEnabled 		= true
SWEP.AdsRTScopeSizeX 		= 512
SWEP.AdsRTScopeSizeY 		= 512
SWEP.AdsRTScopeScaling 		= false
SWEP.AdsRTScopeScaleX 		= 1
SWEP.AdsRTScopeScaleY 		= 1
if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 6
	SWEP.AdsBlurSize			= ScrH() / 2
	SWEP.AdsMSpeedScale			= GetConVar( "sfw_adsmspeedscale" ):GetFloat() * 0.4
end
SWEP.AdsRTToneMapBalance 	= 1.2
SWEP.AdsRecoilMul			= 1
SWEP.SciFiACCRecoverRate	= 0.1

SWEP.ChargeMax				= 100
SWEP.ChargeAdd				= 1.15
SWEP.ChargeDrain			= 10

SWEP.FeelGoodEnabled = true
SWEP.FeelGoodHullEnabled = true
SWEP.FeelGoodHullSize = 2
SWEP.FeelGoodRatio = 0.2

SWEP.LastTargetName = nil
SWEP.LastTargetTime = 0
SWEP.LastTargetBuff = 1

SWEP.NPCAccuracy 			= 1 -- 500
SWEP.NPCSkillLevel 			= 1 -- 1
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= -0.1

SWEP.mat_laser_line = Material( "effects/laser_line_asa.vmt" )
mat_laser_flare = Material( "particle/obnoxiousflare_add.vmt" )

SWEP.DataTables = {
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Int", dName = "Combo" },
	{ dType = "Float", dName = "ComboTime" },
	{ dType = "Float", dName = "PerkTime" },
	{ dType = "Float", dName = "PerkDamage" }
}

SWEP.ViewModelBoneMods = {
	["v_weapon.sg550_Parent"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -2, 0 ), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_combine_sniper.mdl", bone = "v_weapon.sg550_Parent", rel = "", pos = Vector(0, -4, -14), angle = Angle( 90, 0, -90 ), size = Vector( 0.9, 0.9, 0.9 ), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/xqm/panel360.mdl", bone = "v_weapon.sg550_Parent", rel = "", pos = Vector(0, -8.7, 2.5), angle = Angle( -90, 0, 90 ), size = Vector(0.001, 0.04, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/rt_scope", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 110, 140, 225 ), bone = "v_weapon.sg550_Parent", pos = Vector(0, -4, -14), angle = Angle( -90, 0, 0 ), range = 16384, line_size = 0.5, haze_size = 0.2, dot_size = 1 }
}

SWEP.WElements = {
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_combine_sniper.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector( 19, 1, -6 ), angle = Angle( 12, 180, 180 ), size = Vector( 0.9, 0.9, 0.9 ), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 110, 140, 225 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector(22, 1, -9), angle = Angle( -13.5, 0, 0 ), range = 16384, line_size = 1, haze_size = 0.7, dot_size = 1.5 },
	["flare"] = { type = SCIFI_SCK_TYPE_SPRITE, color = Color( 140, 170, 255 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector(22, 1, -11), size = Vector( 2, 2 ), spriteMaterial = mat_laser_flare }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 140,
		DamageComposition = "100 + 40",
		DamageType = { DMG_BULLET, DMG_BLAST },
		CritMul = 2,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 1.2 }, 
		},
		ChargeRate = 1.1
	},
	CoreRechargeRate = nil,
	ClipSize = 4,
	ReloadSpeed = 3,
	Recoil = 20,
	PerkSet = { SCIFI_PERK_AMMO_EXPLOSIVE, SCIFI_PERK_AMMO_HIGHCAL, SCIFI_PERK_CHAMBER_WINDUP }
}

local bAds
local fAdsScale = 1

local c_hud_bg = Color( 20, 20, 70, 120 )
local c_hud_fg = Color( 100, 160, 255, 220 )

local snd_fire = Sound( "/weapons/psr/psr_fire_v2.wav" ) -- Sound( "/npc/sniper/sniper1.wav" )
local snd_echo = Sound( "/weapons/psr/psr_echo.wav" )
local snd_bback = Sound( "/npc/sniper/reload1.wav" )
local snd_fail = Sound( "/weapons/fang/fang_burst_finish.wav" )

local color_visor_default = Color( 255, 255, 255, 255 )
local color_visor_warning = Color( 255, 180, 100, 255 )
local color_visor_error =  Color( 255, 0, 30, 255 )

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

if ( CLIENT ) then
	local lensring = Material("effects/sight_glass") -- surface.GetTextureID("effects/sight_lens")
	local lenswarp = Material("effects/sight_lens") -- surface.GetTextureID("effects/sight_lens_refract") 
	local lensglass = Material("models/weapons/hwave/holo_dots_arc") -- surface.GetTextureID("effects/sight_glass")
	local lensindicator = Material("models/weapons/hwave/holo_dots") -- surface.GetTextureID("effects/sight_glass")
	local tex_ui_fadeline = surface.GetTextureID( "vgui/ui_fadeline" )
	local disp_font_small = "HudNumbers"
	
	local iArcRadius, iArcWidth = 280, 4
	
	function SWEP.DrawScopeOverlay( ply, wep, vSway, aSway )
		local midx, midy = wep.AdsRTScopeSizeX * 0.5, wep.AdsRTScopeSizeY * 0.5
		
		local plyETrace = ply:GetEyeTrace()
		local clrSight = Color( 200, 15, 10, 128 )

		local fSway = 128 - wep.AdsFov * 4
		local fOverlayAnchorX, fOverlayAnchorY = 0, 0
		local fOverlaySizeX, fOverlaySizeY = wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY
		
		if ( !GetConVar( "sfw_allow_rtsniperscopes" ):GetBool() ) then
			midx, midy = ScrW() * 0.5, ScrH() * 0.5
		
			fOverlaySizeX, fOverlaySizeY = ScrH(), ScrH()
			fOverlayAnchorX, fOverlayAnchorY = ScrW() * 0.5 - ScrH() * 0.5, 0
		
			surface.DrawRect( 0, 0, fOverlayAnchorX, fOverlaySizeY * 2 )
			surface.DrawRect( fOverlayAnchorX + fOverlaySizeX * 2, 0, ScrW(), ScrH() )
		end
		
		aSway = wep:GetViewModelSway() * 0.025
		
		cam.Start2D()
			c_hud_fg.a = 255 * fAdsScale
			
			draw.NoTexture()
			
			surface.SetDrawColor( Color( 0, 0, 0, 256 - c_hud_fg.a ) )
			-- fnArc( midx, midy, 4 + 512 * fAdsScale, 128 * ( 1 - fAdsScale ), 0, 360, 3 )
			
			surface.SetDrawColor( c_hud_fg )
			
			surface.SetMaterial( lenswarp )
			surface.DrawTexturedRect( fOverlayAnchorX, fOverlayAnchorY, fOverlaySizeX, fOverlaySizeY )
			
			local pOwner = wep:GetOwner()
			local pOwnerSP = pOwner:GetShootPos()
			local pOwnerET = pOwner:GetEyeTrace()
			
			local fSway = 128 - wep.AdsFov * 4
			
			surface.SetMaterial( lensring )
			surface.DrawTexturedRect( fOverlayAnchorX - aSway.yaw * fSway * 2, fOverlayAnchorY + aSway.pitch * fSway * 2, fOverlaySizeX, fOverlaySizeY )
			
			local fOpticsDistortYaw = math.min( aSway.yaw * -fSway, 64 )
			local fOpticsDistortPitch = math.min( aSway.pitch * fSway, 64 )
			
			surface.SetMaterial( lenswarp )
			surface.DrawTexturedRect( fOverlayAnchorX + fOpticsDistortYaw, fOverlayAnchorY + fOpticsDistortPitch, fOverlaySizeX + math.abs( fOpticsDistortYaw ), fOverlaySizeY + math.abs( fOpticsDistortPitch ))

			local clrCrosshair = c_hud_fg
			
			if ( pOwnerET.HitGroup ) && ( pOwnerET.HitGroup == HITGROUP_HEAD ) then
				clrCrosshair = color_visor_error
			end
			
			local aPunch = wep:GetOwner():GetViewPunchAngles()
			local iPunchPower = math.abs( aPunch.pitch + aPunch.yaw + aPunch.roll ) * 8
			
			surface.DrawCircle( midx, midy, 2 + iPunchPower, clrCrosshair.r, clrCrosshair.g, clrCrosshair.b, clrCrosshair.a )
			
			surface.SetDrawColor( c_hud_bg )
			fnArc( midx, midy, iArcRadius - iArcRadius * 0.5 * fAdsScale - iArcWidth, iArcWidth * fAdsScale, 90 - 45 * fAdsScale, 90 + 45 * fAdsScale, 3 )
			fnArc( midx, midy, iArcRadius - iArcRadius * 0.5 * fAdsScale - iArcWidth, iArcWidth * fAdsScale, 270 - 45 * fAdsScale, 270 + 45 * fAdsScale, 3 )
			
			surface.SetDrawColor( c_hud_fg )
			fnArc( midx, midy, iArcRadius - iArcRadius * 0.5 * fAdsScale, iArcWidth * fAdsScale, 90 - 45 * fAdsScale, 90 + 45 * fAdsScale, 3 )
			fnArc( midx, midy, iArcRadius - iArcRadius * 0.5 * fAdsScale, iArcWidth * fAdsScale, 270 - 45 * fAdsScale, 270 + 45 * fAdsScale, 3 )
		
			local iArcLength = 15
			local iArcStart = 204
			local iArcOffset = 21
			for i=0, math.min( 4, wep:Clip1() )-1 do
				-- fnArc( midx, midy, 140, 10, 135, 225, 3 )
				local offset = iArcOffset * i
				fnArc( midx, midy, 140, 5, iArcStart - offset, iArcStart + iArcLength - offset, 3 )
			end
			
			surface.SetTexture( tex_ui_fadeline )
						
			local arc, spin
			local arcRadius = -iArcRadius * 0.5 * fAdsScale + 16
			arc = 45
			spin = math.rad( arc )
			surface.DrawTexturedRectRotated( math.cos( spin ) * arcRadius + midx, math.sin( spin ) * arcRadius + midy, iArcWidth, 32, arc )
			
			arc = 135
			spin = math.rad( arc )
			surface.DrawTexturedRectRotated( math.cos( spin ) * arcRadius + midx, math.sin( spin ) * arcRadius + midy, iArcWidth, 32, 180 + arc )
			
			arc = 225
			spin = math.rad( arc )
			surface.DrawTexturedRectRotated( math.cos( spin ) * arcRadius + midx, math.sin( spin ) * arcRadius + midy, iArcWidth, 32, arc )

			arc = 315
			spin = math.rad( arc )
			surface.DrawTexturedRectRotated( math.cos( spin ) * arcRadius + midx, math.sin( spin ) * arcRadius + midy, iArcWidth, 32, 180 + arc )
			
			local fCharge = wep:GetCharge() * 0.01
			fnArc( midx, midy, 30, 2 + 2 * fCharge, 90 - 90 * fCharge, 90 + 90 * fCharge, 3 )
			fnArc( midx, midy, 30, 2 + 2* fCharge, 270 - 90 * fCharge, 270 + 90 * fCharge, 3 )
		cam.End2D()
	end
end

function SWEP:SubInit()

	self:SetPerkDamage( 20 )
	self:SetPerkTime( 0 )
	
end

local bTriggerHeld, dTriggerHeld = false, false

function SWEP:Think()

	if ( CLIENT ) then
		bAds = ( self:GetSciFiState() == SCIFI_STATE_ADS )
	
		if ( !bAds ) && ( fAdsScale > 0 ) then
			fAdsScale = math.Approach( fAdsScale, 0, FrameTime() * 12 )
		end

		if ( bAds ) && ( fAdsScale < 1 ) then
			fAdsScale = math.Approach( fAdsScale, 1, FrameTime() * 1 )
		end
	end

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		if ( self:GetNextPrimaryFire() < CurTime() ) then
			if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && self:Clip1() > 0 ) then
				if ( self:GetCharge() < self.ChargeMax ) then
					self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
				end

				bTriggerHeld = true
			else
				if ( self:GetCharge() > 0 ) then
					self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
				end
				
				bTriggerHeld = false
			end
		end
		
		if ( bTriggerHeld && !dTriggerHeld ) then
			if ( self:GetCharge() < self.ChargeMax ) then
				self:EmitSound( snd_bback, 40, math.random( 95, 105 ), 1, CHAN_WEAPON )
			end
		end
		
		if ( !bTriggerHeld && dTriggerHeld ) then
			if ( self:GetCharge() < self.ChargeMax ) then
				self:EmitSound( snd_fail, 40, math.random( 95, 105 ), 1, CHAN_WEAPON )
			end
		end
		
		if ( self:GetCharge() >= self.ChargeMax ) then
			if ( self:CanPrimaryAttack( 0, true ) ) then
				self:SetNextPrimaryFire( CurTime() + 1.2 )
				self:SetCharge( 0 )
				self:Attack()
				bTriggerHeld = false
			end
		end

		dTriggerHeld = bTriggerHeld
	end

	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	self:Anims()

end

function SWEP:AddWAcc()
	if ( IsValid( self.Owner ) && self:GetCharge() ) then
		local fCharge = self:GetCharge() * 0.01

		local clr_laser = Color( 110 * fCharge, 140 * fCharge, 255 * fCharge )

		-- self.WElements[ "point" ].color = clr_laser
		-- self.WElements[ "point" ].line_size = 8 * fCharge * fCharge
		-- self.WElements[ "point" ].haze_size = 0.2 * fCharge * fCharge
		-- self.WElements[ "point" ].dot_size = 8 * fCharge * fCharge
		self.WElements[ "flare" ].size = Vector( 2, 2 ) * ( 48 * fCharge )
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( 0 )
			
			local clr_laser = Color( 110, 140, 255 )

			-- self.WElements[ "point" ].color = clr_laser
			-- self.WElements[ "point" ].line_size = 8
			-- self.WElements[ "point" ].haze_size = 0.2
			-- self.WElements[ "point" ].dot_size = 8
			self.WElements[ "flare" ].size = Vector( 2, 2 )
		end
	end
end

local tEventBlacklist = { 
	[ 20 ] = true, 
	[ 5001 ] = true, 
	[ 5003 ] = true 
}

function SWEP:FireAnimationEvent( pos, ang, event, options )

	local vm = self:GetViewModelEnt() 
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 0.8 )
	end

	if ( tEventBlacklist[ event ] ) then
		return true
	end

end

function SWEP:OnAds( bAimingDownSights )

end

function SWEP:Attack()
	
	local cmd_damageamp = GetConVar( "sfw_damageamp" ):GetFloat()
	local pOwnerAV = self.Owner:GetAimVector()
	
	if ( self.FeelGoodEnabled ) then
		if ( self.Owner:IsPlayer() ) then
			pOwnerAV  = self:GetFeelGoodVector( pOwnerAV )
		else
			pOwnerAV  = self.NPCAimVectorOverride
		end
	end

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() / 512 ) -- Vertical recoil pattern --
	bullet.Spread = Vector( .003, .003 ) * self:GetSciFiACC() -- Random spread multiplied by recoil value --
	bullet.Tracer = 1
	bullet.TracerName = "asa6_tracer"
	bullet.Force = 8
	bullet.HullSize = 2
	bullet.Damage = 100 * cmd_damageamp
	bullet.Ammo = "SniperRound"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_BULLET )
		dmginfo:SetInflictor( self )
		dmginfo:SetAttacker( self.Owner )
		
		self:DealAoeDamage( bit.bor( DMG_CLUB, DMG_BLAST ), 40 * cmd_damageamp, tr.HitPos, 64 )
		
		ParticleEffect( "ngen_hit", tr.HitPos, tr.Normal:Angle() )
		ParticleEffect( "asa6_hit", tr.HitPos, tr.Normal:Angle() )
		ParticleEffect( "astra_hit", tr.HitPos, tr.Normal:Angle() )
	end

	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -6, -7 ), math.random( -0.1, 0.1 ), math.random( 0, 0.2 ) ) * ( 1 + self:GetSciFiACC() * 1 ) )
		self:AddSciFiACC( 20 )
	end

	self:DoMuzzleEffect()

	-- self:EmitSound( tFireSounds[ math.random( 1, 3 ) ] )
	self:EmitSound( snd_fire, 100, math.random( 95, 105 ), 1, CHAN_STATIC )
	if ( self.Owner:WaterLevel() < 2 ) then
		self:EmitSound( snd_echo, 110, math.random( 95, 105 ), 1, CHAN_STATIC )
	end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
	
end

function SWEP:PrimaryAttack()

	-- if ( self:CanPrimaryAttack( 0 ) ) then
		-- self:Attack()
		-- self:SetNextPrimaryFire( CurTime() + 1.8 )
	-- end
	
	if ( self.Owner:IsNPC() ) then
		
		local sTimerName = "pulsesniper_charge_"..self:EntIndex()
		
		if ( self:GetNextPrimaryFire() > CurTime() || timer.Exists( sTimerName ) ) then
			return
		end
		
		self:SetCharge( 0 )
		self:SetNextPrimaryFire( CurTime() + 2 )
		
		self:EmitSound( snd_bback, 80, math.random( 95, 105 ), 1, CHAN_WEAPON )
	
		timer.Create( sTimerName, 0, 0, function()
			if !( IsValid( self ) && IsValid( self.Owner ) ) then
				timer.Remove( sTimerName )
				return
			end
			
			self:SetCharge( self:GetCharge() + 1 )
		end )
		
		timer.Simple( 1.4, function()
			timer.Remove( sTimerName )
			
			if !( IsValid( self ) && IsValid( self.Owner ) ) then
				return
			end
			
			self:Attack()
			self:SetCharge( 0 )
		end )
	end

end

function SWEP:OnReloadGibCreated( entReloadGib, physReloadGib )

	ParticleEffectAttach( "gunsmoke", PATTACH_ABSORIGIN_FOLLOW, entReloadGib, 0 )

end

function SWEP:OnReload()

	local sTimerName = "pulsesniper_charge_"..self:EntIndex()
	
	if ( timer.Exists( sTimerName ) ) then
		timer.Remove( sTimerName )
		return
	end
	
	self:SetCharge( 0 )

end

function SWEP:OnReloadFinish()

	self:SetNextPrimaryFire( CurTime() )

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return true end

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 130
			dlight.g = 160
			dlight.b = 255
			dlight.brightness = 1
			dlight.Decay = 1024
			dlight.Size = 32
			dlight.DieTime = CurTime() + 0.4
		end
	end
	
	return false

end