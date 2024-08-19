AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false

SWEP.PrintName				= "Z-86M 'Talon' Machine Pistol"
SWEP.ItemRank 				= 8

SWEP.Slot					= 1
SWEP.SlotPos				= 2

if ( CLIENT ) then
	SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_obsidian.vmt" )
end

SWEP.ViewModel				= "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_tmp.mdl"
SWEP.HoldType 				= "pistol"
SWEP.HoldTypeNPC 			= "pistol"
SWEP.HoldTypeSprint 		= "normal"

-- SWEP.SciFiSkin 				= "dev/hide"

SWEP.DeploySpeed 			= 2.5

SWEP.Primary.ClipSize		= 28
SWEP.Primary.DefaultClip	= 28
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "pistol"

SWEP.VfxMuzzleParticle	 	= "umbra_muzzle"
SWEP.VfxMuzzleAttachment 	= "1"
SWEP.VfxMuzzleAttachment2 	= "Muzzle"
SWEP.VfxMuzzleColor 		= Color( 250, 60, 45, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720
SWEP.VfxHeatParticle 		= "gunsmoke"

--SWEP.ReloadSND				= "weapons/vapor/vapor_reload.wav" 
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadRealisticClips 	= false
SWEP.ReloadLegacy 			= false
SWEP.ReloadTime 			= 0.9
SWEP.ReloadPlaybackRate 	= 2

SWEP.SciFiMeleeASpeed		= 0.8
SWEP.SciFiMeleeRange		= 50
SWEP.SciFiMeleeDamage		= 20
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.SprintAnimSpeed		= 14
SWEP.ViewModelSprintPos 	= Vector( -5, 1, 0 )
SWEP.ViewModelSprintAng		= Angle( -16, 2, -5 )
SWEP.ViewModelSwayDirection = Vector( 1, 5, 0 )
SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 3
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( 0.05, -0.1, -0.15 )
SWEP.ViewModelShiftRotation = Vector( 0.4, 0.1, 0 )

SWEP.ViewModelMeleePos		= Vector( 10, 12, -19 )
SWEP.ViewModelMeleeAng		= Angle( 50, 35, -4 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -4, 3, -12 )
SWEP.ViewModelReloadAng		= Angle( 35, -10, 5 )

SWEP.AdsPos 				= Vector(-7, 6, 2.3)
SWEP.AdsFov					= 48

SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.fang.zoomin"
SWEP.AdsSoundDisable		= "scifi.fang.zoomout"

local WEAPON_COMBO_NONE = 0
local WEAPON_COMBO_MELEE = 1
local WEAPON_COMBO_RANGED = 2

SWEP.DataTables = {
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Bool", dName = "Silenced" },
	{ dType = "Int", dName = "Combo" },
	{ dType = "Float", dName = "ComboTime" },
	{ dType = "Entity", dName = "ComboTarget" },
	{ dType = "Bool", dName = "AmmoTaking" }
}

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 3", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				3x", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Bullet", color = Color( 185, 180, 160 ) },
	["4"] = { text = "Fire rate: 				 16.6", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Clip size: 					28", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 3,
		DamageType = DMG_BULLET,
		CritMul = 3,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.05 }
		},
	},
	ClipSize = 28,
	ReloadSpeed = 0.9,
	Recoil = 3,
	PerkSet = { SCIFI_PERK_TALON_SWITCHBLADE, SCIFI_PERK_BARREL_STEALTH, SCIFI_PERK_AMMO_PUNCHTHROUGH_LIGHT }
}

SWEP.FeelGoodEnabled = true
SWEP.FeelGoodRatio = 0.5

SWEP.NPCAccuracy 			= 100
SWEP.NPCSkillLevel 			= 0

local m_custom = Material( "models/weapons/v_models/smg_tmp/smg_tmp" )

local c_hud_bg = Color( 255, 50, 50, 0 )
local c_hud_fg = Color( 255, 70, 60, 0 )

local m_pi 	= math.pi
local m_abs = math.abs
local m_rad = math.rad
local m_sin = math.sin
local m_cos = math.cos

local function fnArc( x, y, radius, linewidth, startangle, endangle, aa )
	aa = math.abs( aa )

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

local fAdsScale = 0

local iRadSmall, iRadMedium, iRadLarge = 96, 128, 192 -- 24, 32, 48
local iWidth = 4

local iAnchor = 256

local fnSight = function( entWeapon, vOrigin, aRotation, fScale )

	if ( !IsValid( entWeapon ) ) then return end

	iState = entWeapon:GetSciFiState()
	
	bAds = ( iState == SCIFI_STATE_ADS )
	
	if ( fAdsScale > 0 ) then
		c_hud_fg.a = 255 * fAdsScale
		
		surface.SetDrawColor( c_hud_fg )
		draw.NoTexture()
		
		local aPunch = entWeapon:GetOwner():GetViewPunchAngles()
		local iPunchPower = math.abs( aPunch.pitch + aPunch.yaw + aPunch.roll ) * 4
		
		surface.DrawCircle( iAnchor + 0, iAnchor + 0, 2 + iPunchPower, c_hud_fg.r, c_hud_fg.g, c_hud_fg.b, c_hud_fg.a )

		surface.DrawLine( iAnchor + iRadSmall * 0.5 * ( 1 - fAdsScale ) + iRadMedium - iRadSmall * fAdsScale + iPunchPower, iAnchor, iAnchor + iRadLarge - iRadMedium * fAdsScale, iAnchor )
		surface.DrawLine( iAnchor - iRadSmall * 0.5 * ( 1 - fAdsScale ) - iRadMedium + iRadSmall * fAdsScale - iPunchPower, iAnchor, iAnchor - iRadLarge + iRadMedium * fAdsScale, iAnchor )

		draw.SimpleText( entWeapon:GetCombo(), "vk21AmmoCounterFG", iAnchor, iAnchor, c_hud_fg, 0, 0 )

		local iClip = entWeapon:Clip1()
		
		draw.SimpleText( iClip, "vk21AmmoCounterFG", iAnchor - 32, iAnchor + 96, c_hud_fg, 0, 0 )
		draw.SimpleText( iClip, "vk21AmmoCounterBG", iAnchor - 32, iAnchor + 96, c_hud_fg, 0, 0 )
	end
	
	if ( !bAds ) && ( fAdsScale > 0 ) then
		fAdsScale = math.Approach( fAdsScale, 0, FrameTime() * 4 )
	end

	if ( bAds ) && ( fAdsScale < 1 ) then
		fAdsScale = math.Approach( fAdsScale, 1, FrameTime() * 6 )
	end
	
	-- debugoverlay.Cross( vOrigin, 4 * fAdsScale, FrameTime() * 2, c_hud_fg, true )
	
end

SWEP.ViewModelBoneMods = {
	-- ["v_weapon.Deagle_Parent"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	-- ["v_weapon.Deagle_Slide"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	-- ["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/pn03/w_pistol.mdl", bone = "v_weapon.Deagle_Parent", rel = "", pos = Vector( -0.275, -3.7, -0.8 ), angle = Angle( 92.5, -45, -42 ), size = Vector( 1.1, 1.1, 1.1 ), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "dev/hide", [1] = "", [2] = "" }, skin = 0, bodygroup = {} },
	-- ["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/pn03/w_pistol.mdl", bone = "v_weapon.Deagle_Slide", rel = "", pos = Vector( -0.275, 0.3, -2 ), angle = Angle( 92.5, -45, -42 ), size = Vector( 1.1, 1.1, 1.1 ), color = Color(255, 255, 255, 255), surpresslightning = false,  submat = { [0] = "", [1] = "dev/hide", [2] = "dev/hide" },skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "v_weapon.TMP_Parent", rel = "", pos = Vector( 0, -5.5, 4 ), angle = Angle( 0, -90, 0 ), size = Vector(0.06, 0.06, 0.001), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/vk21/holo", skin = 0, bodygroup = {} }
	-- ["0"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "v_weapon.Deagle_Slide", pos = Vector( 0.052, -1.675, 1 ), angle = Angle( 0, 90, 0 ), size = 0.004, draw_func = fnSight },
	-- ["1"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "v_weapon.Deagle_Parent", pos = Vector( 0.052, -5.675, -12 ), angle = Angle( 0, 90, 0 ), size = 0.004, draw_func = fnSight },
	-- ["3"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "v_weapon.Deagle_Parent", pos = Vector( 0.052, -5.675, -12 ), angle = Angle( 0, 0, 0 ), size = 0.004, draw_func = fnSight }
}

SWEP.WElements = {
}


function SWEP:SubInit()

	self:SetCombo( WEAPON_COMBO_NONE )
	-- self:SetSilenced( true )

end

local dSilent
local bSilent

function SWEP:Think()

	bSilent = self:GetSilenced()
	
	if ( CLIENT ) then
		local bReloading = self:GetSciFiState() == SCIFI_STATE_RELOADING
		local fNextPFire = self:GetNextPrimaryFire() - CurTime()
		
		-- if ( self:GetSciFiState() == SCIFI_STATE_ADS ) && ( !bReloading && fNextPFire > FrameTime() * -1.2 ) then
			-- local vmEntity = self.Owner:GetViewModel()
			-- local seq = vmEntity:GetSequence()

			-- if ( seq < 4 ) then
				-- self.AdsPos.z = 0.5
			-- elseif ( seq == 4 ) then
				-- self.AdsPos.z = 0.5
			-- elseif ( seq > 4 ) then
				-- self.AdsPos.z = 0.45
			-- end
		-- else
			-- self.AdsPos.z = 1.5
		-- end
	end
	
	if ( CLIENT || !game.SinglePlayer() ) then
		if !( bSilent == dSilent ) then
			if ( bSilent ) then
				self.VfxMuzzleParticle = "umbra_muzzle_embers" 
				self.VfxMuzzleRule = 0
			else
				self.VfxMuzzleParticle = "umbra_muzzle"
				self.VfxMuzzleRule = 3
			end
		end
	
		dSilent = bSilent
	end
	
	if ( self:GetCombo() != WEAPON_COMBO_NONE ) then
		if ( self:GetComboTime() < CurTime() ) then
			self:SetCombo( WEAPON_COMBO_NONE )
		else
			if ( CLIENT ) then
				if ( self:GetCombo() == WEAPON_COMBO_RANGED ) then
					local fBuffScale = ( self:GetComboTime() - CurTime() ) / 3
					fBuffScale = math.sin( fBuffScale * 2 ) * 4

					m_custom:SetFloat( "$emissiveBlendStrength", fBuffScale )
				end
			end
		end
	else
		if ( CLIENT ) then
			m_custom:SetInt( "$emissiveBlendStrength", 0 )
		end
	end

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:OnAds( adsBool )

	if ( adsBool ) then
		self:SetHoldType( "smg" )
	else
		self:SetHoldType( self.HoldType )
	end

end

local m_holosight = Material( "models/weapons/vk21/holo" )
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
	
	fnSight( self, Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), 1 )
	
	cam.End2D()
	
	render.OverrideAlphaWriteEnable( false, false )
	render.PopRenderTarget()

	m_holosight:SetTexture( "$basetexture", rtScreen )
	m_holosight:SetTexture( "$emissiveBlendBaseTexture", rtScreen )
	m_holosight:SetTexture( "$selfillummask", rtScreen )

end

function SWEP:FireAnimationEvent( pos, ang, event, options )
	
	if ( self.Owner:IsNPC() ) then return end

	local vm = self:GetViewModelEnt() 
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 3 )
	end

	if( event == 5001 || event == 5011 ) then
		return true
	end
	
end

local snd_buff_stack = Sound( "weapons/asa/rev_enable.wav" )

function SWEP:OnKill( entTarget, entAttacker )
	
	self:SetCombo( WEAPON_COMBO_RANGED )
	self:SetComboTime( CurTime() + 3 )
	
	self:EmitSound( snd_buff_stack, 60, 130, 1, CHAN_STATIC )

end

function SWEP:Attack()
	
	local pOwnerAV = self.Owner:GetAimVector()
	
	if ( self.FeelGoodEnabled ) then
		pOwnerAV = self:GetFeelGoodVector( pOwnerAV )
	end
	
	self:SetNextPrimaryFire( CurTime() + 0.05 )

	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 0
	--ptru.TracerName = "ca3_tracer_noattach"
	ptru.HullSize = 1
	ptru.Distance = 256
	-- ptru.AmmoType = "pistol"

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() * 0.002 )
	bullet.Spread = Vector( 0.0125, 0.0172 ) * ( 1 + self:GetSciFiACC() * 0.04 )
	bullet.Tracer = 0
	bullet.TracerName = ""
	if ( self:GetCombo() == WEAPON_COMBO_RANGED ) then
		bullet.Tracer = 1
		bullet.TracerName = "emg_tracer"
	end
	bullet.Force = 1
	bullet.HullSize = 1
	bullet.Damage = 3 * GetConVar( "sfw_damageamp" ):GetFloat()
	-- bullet.AmmoType = "pistol"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_BULLET )
		dmginfo:SetInflictor( self )
		
		if ( self:GetCombo() == WEAPON_COMBO_NONE ) && ( self:GetComboTime() < CurTime() ) then
			if ( IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) ) then
				self:SetCombo( WEAPON_COMBO_MELEE )
				self:SetComboTime( CurTime() + 3 )
				-- self:SetComboTarget( tr.Entity )
			end
		end
		
		if ( self:GetCombo() == WEAPON_COMBO_RANGED ) then
			dmginfo:ScaleDamage( 2 )
		else
			if ( tr.HitGroup == HITGROUP_HEAD ) then
				dmginfo:ScaleDamage( 1.5 )
			end
		end

		if ( tr.MatType == MAT_METAL || tr.MatType == MAT_CONCRETE ) then
			ptru.Src = tr.HitPos - pOwnerAV -- * 16
			ptru.Dir = tr.Normal - 2 * tr.Normal:Dot( tr.HitNormal ) * tr.HitNormal

			self.Owner:FireBullets( ptru, false )
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.8, -1 ), math.random( -0.1, 0.1 ), math.random( -0.1, 0.1 ) ) * ( 0.1 + self:GetSciFiACC() * 0.025 ) )
		self:AddSciFiACC( 3 )
	end

	self:DoMuzzleEffect()

	if ( self:GetSilenced() ) then
		self:EmitSound( "scifi.talon.fire.silent" )
	else
		-- self:EmitSound( "scifi.fang.fire.echo" )
		-- self:EmitSound( "scifi.talon.fire.silent" )
		self:EmitSound( "scifi.talon.fire.default" )
	end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	if ( self:GetAmmoTaking() ) then
		self:TakePrimaryAmmo( 1 )
	end
	
	self:SetAmmoTaking( !self:GetAmmoTaking() )
	
end

function SWEP:PrimaryAttack()
	
	if ( self.Owner:IsNPC() ) then
		if ( self:GetComboTime() <= CurTime() ) then
			self:SetCombo( WEAPON_COMBO_NONE )
		end
		
		timer.Create( "fang_bfire_"..self:EntIndex(), 0.05, 5, function() 
			if ( !IsValid( self ) || !IsValid( self.Owner ) || !self:CanPrimaryAttack( 0, true ) ) then return end
			
			self:Attack()
		end )
		
		return
	end

	if ( self.Owner:IsPlayer() && self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetSilenced() ) then 
			self:SetSilenced( false )
			self:EmitSound( "Weapon_RPG.LaserOn" )
		else
			self:SetSilenced( true )
			self:EmitSound( "Weapon_RPG.LaserOff" )
		end
		
		self:SetNextPrimaryFire( CurTime() + 0.2 )
	
		return
	end
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	self:Attack()

end

function SWEP:SecondaryAttack()

end

function SWEP:OnReloadFinish()
	
	if ( CLIENT ) then
		self:EmitSound( "scifi.fang.reload.finish" )
	end 
	
	self:SendWeaponAnim( ACT_VM_IDLE )

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	ParticleEffect( "umbra_hit", tr.HitPos, tr.Normal:Angle(), self )

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