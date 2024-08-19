AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false

SWEP.PrintName				= "Z-81K 'Talon' Pistol"
SWEP.ItemRank 				= 8

SWEP.Slot					= 1
SWEP.SlotPos				= 2

if ( CLIENT ) then
	SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_obsidian.vmt" )
end

SWEP.ViewModel				= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_deagle.mdl"
SWEP.HoldType 				= "pistol"
SWEP.HoldTypeNPC 			= "pistol"
SWEP.HoldTypeSprint 		= "normal"

SWEP.SciFiSkin 				= "dev/hide"

SWEP.DeploySpeed 			= 2.5

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
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
SWEP.ReloadTime 			= 1.2
SWEP.ReloadPlaybackRate 	= 2

SWEP.SciFiMeleeASpeed		= 0.5
SWEP.SciFiMeleeRange		= 46
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelSprintPos 	= Vector( -2, 0, 1 )
SWEP.ViewModelSprintAng		= Angle( -18, -5, -5 )
SWEP.ViewModelMeleePos		= Vector( 10, 12, -19 )
SWEP.ViewModelMeleeAng		= Angle( 50, 35, -4 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -4, 3, -12 )
SWEP.ViewModelReloadAng		= Angle( 35, -10, 5 )

SWEP.SciFiACCRecoverRate 	= 0.225

SWEP.AdsPos 				= Vector(-2.45, 8, 1.5)
SWEP.AdsAng 				= Angle( 0, 0, 0 )
SWEP.AdsFov					= 48

SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.fang.zoomin"
SWEP.AdsSoundDisable		= "scifi.fang.zoomout"

SWEP.DataTables = {
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Bool", dName = "Silenced" }
}

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 12", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				3x", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Bullet", color = Color( 185, 180, 160 ) },
	["4"] = { text = "Fire rate: 				 4 (semi-auto)", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Clip size: 					12", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 12,
		DamageType = DMG_BULLET,
		CritMul = 3,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.25 }
		},
	},
	ClipSize = 12,
	ReloadSpeed = 1.2,
	Recoil = 6,
	PerkSet = { SCIFI_PERK_AMMO_HIGHCAL, SCIFI_PERK_AMMO_PUNCHTHROUGH_LIGHT }
}

SWEP.FeelGoodEnabled = true
SWEP.FeelGoodRatio = 0.2

SWEP.NPCAccuracy 			= 100
SWEP.NPCSkillLevel 			= 0

local c_hud_bg = Color( 255, 50, 50, 0 )
local c_hud_fg = Color( 255, 70, 60, 0 )

local m_pi 	= math.pi
local m_abs = math.abs
local m_rad = math.rad
local m_sin = math.sin
local m_cos = math.cos

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
	
	for k,v in pairs( arc ) do
		surface.DrawPoly( v )
	end
end

local fAdsScale = 0

local iRadSmall, iRadMedium, iRadLarge = 12, 48, 192 -- 24, 32, 48
local iWidth = 4

local fnSight = function( entWeapon, vOrigin, aRotation, fScale )

	if ( !IsValid( entWeapon ) ) then return end

	iState = entWeapon:GetSciFiState()
	
	bAds = ( iState == SCIFI_STATE_ADS )
	
	if ( fAdsScale > 0 ) then
		c_hud_fg.a = 255 * fAdsScale
		
		surface.SetDrawColor( c_hud_fg )
		draw.NoTexture()
		
		local aPunch = entWeapon:GetOwner():GetViewPunchAngles()
		local iPunchPower = math.abs( aPunch.pitch + aPunch.yaw + aPunch.roll ) * 4 + entWeapon:GetSciFiACC()
		
		local iCenter = 256
		
		local iAnchor = iCenter + iRadMedium * fAdsScale + iPunchPower * 0.5
		local iBracket = iAnchor + iRadSmall * fAdsScale + iPunchPower

		surface.DrawCircle( iCenter, iCenter, 1 * fAdsScale, c_hud_fg.r, c_hud_fg.g, c_hud_fg.b )
		surface.DrawCircle( iCenter, iCenter, 4 * fAdsScale, c_hud_fg.r, c_hud_fg.g, c_hud_fg.b )

		surface.DrawLine( iAnchor, iCenter + iRadSmall, iBracket, iCenter + iRadSmall )
		surface.DrawLine( iAnchor, iCenter - iRadSmall, iBracket, iCenter - iRadSmall )
		surface.DrawLine( iBracket, iCenter + iRadSmall, iBracket, iCenter - iRadSmall )
		
		iAnchor = iCenter - iRadMedium * fAdsScale - iPunchPower * 0.5
		iBracket = iAnchor - iRadSmall * fAdsScale - iPunchPower
		
		surface.DrawLine( iBracket, iCenter + iRadSmall, iBracket, iCenter - iRadSmall )
		surface.DrawLine( iAnchor, iCenter + iRadSmall, iBracket, iCenter + iRadSmall )
		surface.DrawLine( iAnchor, iCenter - iRadSmall, iBracket, iCenter - iRadSmall )
	end
	
	if ( !bAds ) && ( fAdsScale > 0 ) then
		fAdsScale = math.Approach( fAdsScale, 0, FrameTime() * 6 )
	end

	if ( bAds ) && ( fAdsScale < 1 ) then
		fAdsScale = math.Approach( fAdsScale, 1, FrameTime() * 6 )
	end
	
end

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 4, 1, -0.6 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( -3.7, -1, 0.6 ), angle = Angle( 0, 0, 0 ) },
	["v_weapon.Deagle_Parent"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 4, 0 ), angle = Angle( 0, 0, 0 ) },
	["v_weapon.Deagle_Slide"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/pn03/w_pistol.mdl", bone = "v_weapon.Deagle_Parent", rel = "", pos = Vector( -0.275, -3.7, -0.8 ), angle = Angle( 92.5, -45, -42 ), size = Vector( 1.1, 1.1, 1.1 ), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "dev/hide", [1] = "", [2] = "" }, skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/pn03/w_pistol.mdl", bone = "v_weapon.Deagle_Slide", rel = "", pos = Vector( -0.275, 0.3, -2 ), angle = Angle( 92.5, -45, -42 ), size = Vector( 1.1, 1.1, 1.1 ), color = Color(255, 255, 255, 255), surpresslightning = false,  submat = { [0] = "", [1] = "dev/hide", [2] = "dev/hide" },skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "v_weapon.Deagle_Slide", rel = "", pos = Vector( 0.06, -1.72, 1 ), angle = Angle( 0, -90, 0 ), size = Vector(0.06, 0.06, 0.001), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/vk21/holo", skin = 0, bodygroup = {} }
	-- ["0"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "v_weapon.Deagle_Slide", pos = Vector( 0.052, -1.675, 1 ), angle = Angle( 0, 90, 0 ), size = 0.004, draw_func = fnSight },
	-- ["1"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "v_weapon.Deagle_Parent", pos = Vector( 0.052, -5.675, -12 ), angle = Angle( 0, 90, 0 ), size = 0.004, draw_func = fnSight },
	-- ["3"] = { type = SCIFI_SCK_TYPE_QUAD, bone = "v_weapon.Deagle_Parent", pos = Vector( 0.052, -5.675, -12 ), angle = Angle( 0, 0, 0 ), size = 0.004, draw_func = fnSight }
}

SWEP.WElements = {
}


function SWEP:SubInit()

end

local dSilent
local bSilent

function SWEP:Think()

	bSilent = self:GetSilenced()

	if ( ( game.SinglePlayer() || ( !game.SinglePlayer() && CLIENT ) ) && self:GetSciFiState() == SCIFI_STATE_ADS && self:Clip1() > 2 ) then
		local fNextPrimaryFire = self:GetNextPrimaryFire() - CurTime()
		
		if ( fNextPrimaryFire > 0 ) then
			local fAnimationScale = math.Clamp( fNextPrimaryFire / 0.25, 0, 1 )
			
			self.AdsPos.z = 1.5 - 1 * fAnimationScale
			self.AdsPos.x = -2.45 + 1 * fAnimationScale
			self.AdsAng.roll = 4 * fAnimationScale
			self.AdsAng.pitch = -6 * fAnimationScale

			local aPunch = self.Owner:GetViewPunchAngles()
			self.Owner:SetViewPunchAngles( aPunch * ( 0.9 + fAnimationScale * 0.1 ) )
		else 
			self.AdsPos.z = 1.5
			self.AdsPos.x = -2.45
			self.AdsAng.roll = 0
			self.AdsAng.pitch = 0
		end
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

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
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
	-- m_debug:SetTexture( "$basetexture", rtScreen )
	-- render.SetMaterial( m_debug )
	-- render.DrawScreenQuadEx( 64, 64, 64 + SizeX, 64 + SizeY )

end

function SWEP:OnAds( adsBool )

	if ( adsBool ) then
		self:SetHoldType( "revolver" )
	else
		self:SetHoldType( self.HoldType )
	end

end

function SWEP:FireAnimationEvent( pos, ang, event, options )
	
	if ( self.Owner:IsNPC() ) then return end

	local vm = self:GetViewModelEnt() 
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 1.75 )
	
		if ( !self.Owner:ShouldDrawLocalPlayer() && event == 20 ) then 
			local pOwnerEA = self.Owner:EyeAngles()
			local vmAttach = vm:GetAttachment( "2" )
			local fxOrigin = self:GetProjectileSpawnPos() + pOwnerEA:Forward() * 24
			
			local pOwnerEA = self.Owner:EyeAngles()
			local vmAttach = vm:LookupAttachment( "2" )
			local fxOrigin = self:GetProjectileSpawnPos() + pOwnerEA:Forward() * 24
			
			local effectdata = EffectData()
			effectdata:SetEntity( vm )
			effectdata:SetOrigin( fxOrigin )
			effectdata:SetAttachment( 2 )
			effectdata:SetAngles( pOwnerEA + Angle( -30, -90, 0 ) )
			
			util.Effect( "ShellEject", effectdata )
			
			return true
		end
	end

	if( event == 5001 || event == 5011 || event == 20 ) then
		return true
	end

end

function SWEP:PrimaryAttack()

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
	
	local pOwnerAV = self.Owner:GetAimVector()
	
	if ( self.FeelGoodEnabled ) then
		pOwnerAV = self:GetFeelGoodVector( pOwnerAV )
	end
	
	self:SetNextPrimaryFire( CurTime() + 0.25 )

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
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() / 128 )
	bullet.Spread = Vector( .018, .018 ) * ( self:GetSciFiACC() * 0.4 )
	bullet.Tracer = 0
	bullet.TracerName = "spr_tracer"
	bullet.Force = 1
	bullet.HullSize = 0
	bullet.Damage = 12 * GetConVar( "sfw_damageamp" ):GetFloat()
	-- bullet.AmmoType = "pistol"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_BULLET )

		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:ScaleDamage( 1.5 )
		end
	
		if !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) then
			if ( tr.MatType == MAT_GLASS ) || ( tr.MatType == MAT_WOOD ) then
				ptru.Src = tr.HitPos + pOwnerAV * 8
				ptru.Dir = tr.Normal + pOwnerAV

				self.Owner:FireBullets( ptru, false )
			end

			if ( ( tr.MatType == MAT_METAL ) || ( tr.MatType == MAT_CONCRETE ) ) then
				local bouncer = ( tr.Normal - tr.HitNormal )
				bouncer = bouncer:Length()
				
				if ( ( bouncer < 1.8 ) ) then
					ptru.Src = tr.HitPos - pOwnerAV -- * 16
					ptru.Dir = tr.Normal - 2 * tr.Normal:Dot( tr.HitNormal ) * tr.HitNormal

					self.Owner:FireBullets( ptru, false )
				end
			end
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -2.8, -3 ), math.random( 0, 0.1 ), math.random( 0, 0.1 ) ) * ( 0.3 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 6 )
	end

	self:DoMuzzleEffect()

	if ( self:GetSilenced() ) then
		self:EmitSound( "scifi.hybridsniper.fire.silent" )
	else

		self:EmitSound( "scifi.talon.fire" )
		
		if ( self.Owner:WaterLevel() < 2 ) then
			self:EmitSound( "scifi.fang.fire.echo" )
		end
	end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:TakePrimaryAmmo( 1 )

end

function SWEP:SecondaryAttack()

end

function SWEP:OnReloadFinish()
	
	if ( CLIENT ) then
		self:EmitSound( "scifi.asa6.reload.bback" )
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