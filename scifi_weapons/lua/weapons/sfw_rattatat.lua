AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

local cmd_heat = GetConVarNumber( "sfw_fx_heat" )
local snd_reload = Sound( "/weapons/smg/gunother/smg_fullautobutton_1.wav" )

PrecacheParticleSystem( "umbra_muzzle" )
PrecacheParticleSystem( "drake_hit_sparks" )

SWEP.Spawnable = false

SWEP.ViewModel 				= "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_p90.mdl"
SWEP.ItemRank 				= 12

SWEP.PrintName				= "rattatat"
SWEP.Slot					= 2
SWEP.SlotPos				= 1
SWEP.ViewModelFOV			= 56

SWEP.DeploySpeed 			= 2

--SWEP.SciFiSkin			= "vgui/white"
--SWEP.SciFiSkin_1			= "vgui/white"
--SWEP.SciFiSkin_2			= "vgui/white"
--SWEP.SciFiSkin_3			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.Primary.ClipSize		= 45
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.VfxMuzzleAttachment 	= "1"
SWEP.VfxMuzzleAttachment2 	= "Muzzle"
SWEP.VfxMuzzleParticle 		= "ngen_muzzle_4"
SWEP.VfxMuzzleColor 		= Color( 250, 160, 80, 255 ) -- Color( 70, 80, 255, 255 )
SWEP.VfxHeatForce 			= false
SWEP.VfxHeatParticle 		= "gunsmoke"
SWEP.VfxHeatThreshold 		= 0.4
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 750

SWEP.ReloadSND				= "Weapon_SMG1.Reload"
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadTime 			= 2.4
SWEP.ReloadPlaybackRate 	= 3
SWEP.ReloadLegacy 			= false
SWEP.DepletedSND			= "Weapon_AR2.Empty"

SWEP.AdsPos 				= Vector(-5.85, -7, 1.1)
SWEP.AdsAng 				= Vector(0, 0, 0)
SWEP.AdsFov					= 50
SWEP.AdsRTScopeMaterial		= Material( "models/weapons/asa6/rt_scope.vmt" )
SWEP.AdsRTScopeOffline		= "models/weapons/asa6/rt_scope_offline_baset.vtf"
SWEP.AdsRTScopeEnabled 		= false
SWEP.AdsRTScopeCompensate 	= false
SWEP.AdsRTScopeSizeX 		= 256
SWEP.AdsRTScopeSizeY 		= 256
SWEP.AdsRTScopeScaling 		= true
SWEP.AdsRTScopeScaleX 		= -0.5
SWEP.AdsRTScopeScaleY 		= -0.5

SWEP.ViewModelSprintPos		= Vector( 2, 0.72, 0.2 )
SWEP.ViewModelSprintAng		= Angle( -10, 25, -5 )
SWEP.ViewModelMeleePos		= Vector( 15, 4, -4 )
SWEP.ViewModelMeleeAng		= Angle( 8, 75, -45 )

SWEP.VElements = {
-- 	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
-- 	["parent2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -5, -5), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
-- 	["a1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mine01.mdl", bone = "", rel = "parent2", pos = Vector(1.2, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
-- 	["a0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "", rel = "parent2", pos = Vector(1, 0, 0), angle = Angle(-90, 0, 0), size = Vector(0.043, 0.043, 0.043), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
-- 	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinebutton.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.4, -0.6, 3), angle = Angle(0, 5, -90), size = Vector(0.115, 0.115, 0.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
-- 	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
-- 	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-0.4, 2, 20), angle = Angle(180, 90, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_core", skin = 0, bodygroup = {} },
-- 	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt1", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
-- 	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-5, 64.5, 18), angle = Angle(0, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0]="vgui/white", [1]="models/weapons/misc/case_stock", [2]="vgui/white", [3]="vgui/white", [4]="vgui/white" }, skin = 0, bodygroup = {} },
-- 	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.4, 0, 2), angle = Angle(0, 180, 0), size = Vector(0.12, 0.16, 0.16), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/sight", skin = 0, bodygroup = {} },
-- 	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.p90_Parent", rel = "parent2", pos = Vector(0.3, 5, 6), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
--	["13"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "parent", pos = Vector(0, -1.2, 13.2), angle = Angle(30, -90, 0), size = Vector(0.02, 0.01, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
--	["15"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/cell_01_supportsb.mdl", bone = "", rel = "10", pos = Vector(-0.24, 5.5, 15), angle = Angle(1, 90, -180), size = Vector(0.012, 0.007, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/drak_railing", skin = 0, bodygroup = {} },
--	["17"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-1, 5.4, 8), angle = Angle(0, 0, 180), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
--	["17a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "", rel = "10", pos = Vector(-0.132, 1.8, 8), angle = Angle(180, 0, 0), size = Vector(0.04, 0.04, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
--	["18"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.5, -3, 8), angle = Angle(180, -90, 2), size = Vector(0.03, 0.014, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
--	["20a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-0.3, 0.1, 14), angle = Angle(0, 0, 0.1), size = Vector(0.016, 0.022, 0.3), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
--	["20b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube1x1x1.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-0.3, 1, 14), angle = Angle(0, 0, -0.1), size = Vector(0.016, 0.022, 0.3), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
--	["optics"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "v_weapon.p90_Parent", rel = "parent2", pos = Vector(-0.7, -3, -7), angle = Angle(180, 0, 0), size = Vector(0.05, 0.05, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
--	["sight_lens"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/construct/wood/wood_angle360.mdl", bone = "v_weapon.p90_Parent", rel = "optics", pos = Vector(-0.7, 0.5, 4), angle = Angle(0, 90, 0), size = Vector(0.017, 0.017, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/asa6/rt_scope", skin = 0, bodygroup = {} },
--	["sight_casing"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_phx/wheels/magnetic_large.mdl", bone = "v_weapon.p90_Parent", rel = "sight_lens", pos = Vector(0, 0, -2.8), angle = Angle(0, 0, 0), size = Vector(0.028, 0.028, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 255, 10, 30 ), bone = "v_weapon.p90_Parent", pos = Vector(-0.4, 2.8, 21), angle = Angle( 90, 0, 0 ), range = 8192, line_size = 0.8, haze_size = 0.1, dot_size = 1 }
}

SWEP.WElements = {
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 255, 20, 10 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector( 11.75, 1.45, -7.2 ), angle = Angle( -10, 0, 0 ), range = 8192, line_size = 1, haze_size = 0.2, dot_size = 2 },
}

SWEP.mat_laser_line = Material( "effects/laser_line2.vmt" )
SWEP.mat_laser_glow = Material( "models/weapons/v_mk23/dot2.vmt" )

SWEP.DataTables = {
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Bool", dName = "CanBurst" },
	{ dType = "Int", dName = "BurstCount" }
}

function SWEP:SubInit()

	self:SetBurstMode( false )
	
end

local offset = 0
function SWEP:Think()
	--[[
	if ( self:GetBurstMode() ) && ( SERVER || !game.SinglePlayer() ) then
		local bMax = 3
		if !( self.SciFiState == SCIFI_STATE_RELOADING ) && ( self:CanBFire() ) then
			if ( self:GetBurstCount() <= bMax && self:GetCanBurst() ) && ( self:GetNextPrimaryFire() ~= -1 ) then
				self:HwaveFire()
	
				if ( self:GetBurstCount() > bMax ) then return end
				self:SetCanBurst( true )
				self:SetBurstCount( self:GetBurstCount() + 1 )
	
				self:SetNextPrimaryFire( CurTime() + 0.08 )	
			end
			
			if ( self:GetBurstCount() > bMax ) then
				self:SetNextPrimaryFire( CurTime() + 0.28 )
				self:SetCanBurst( false )
				self:SetBurstCount( 0 )
			end
		end	
	end
	
	if ( CLIENT ) then
		local animtime = FrameTime() * 2
		
		if ( self.SciFiState == SCIFI_STATE_RELOADING && self:GetNextPrimaryFire() - 0.95 > CurTime() ) then
			if ( offset < 1 ) then
				offset = Lerp( animtime, offset, 1 )
				self.VElements[ "parent2" ].angle = Angle( 180, 0, 0 ) + Angle( 0, 0, 40 ) * offset
				self.VElements[ "optics" ].pos = Vector(-0.7, -3, -7) + Vector( 0, 0, 8 ) * offset
			end
		else
			if ( offset > 0 ) then
				offset = math.Approach( offset, 0, animtime )
				self.VElements[ "parent2" ].angle = Angle( 180, 0, 0 ) + Angle( 0, 0, 40 ) * offset
				self.VElements[ "optics" ].pos = Vector(-0.7, -3, -7) + Vector( 0, 0, 8 ) * offset
			end
		end
	end
	]]--
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 5001 || event == 5011 ) then
		return true
	end

	self:GetViewModelEnt():SetPlaybackRate( self.ReloadPlaybackRate )
	
end

function SWEP:HwaveFire()

	local pOwnerAV = self.Owner:GetAimVector()

	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 0
	--ptru.TracerName = "ca3_tracer_noattach"
	ptru.Distance = 128
	ptru.AmmoType = "smg1"

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() / 128 )
	bullet.Spread = Vector( .02, .02 ) * ( 1 + self:GetSciFiACC() * 0.2 )
	bullet.Tracer = 1
	bullet.TracerName = "spr_tracer" -- "ca3_tracer"
	bullet.Force = 5
	bullet.HullSize = 0.4
	bullet.Damage = 8
	bullet.AmmoType = "SMG1"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_BULLET )	

		if ( tr.MatType == MAT_METAL || tr.MatType == MAT_CONCRETE ) then
			ptru.Src = tr.HitPos - pOwnerAV -- * 16
			ptru.Dir = ( tr.Normal + tr.HitNormal )

			self.Owner:FireBullets( ptru, false )
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -60, -80 ), math.random( -40, 40 ), 0 ) * ( 0.004 + self:GetSciFiACC() * 0.001 ) )
		
		self:AddSciFiACC( 1 )
	end

	self:DoMuzzleEffect()
	
--	ParticleEffectAttach( "saphyre_muzzle_flames_0a", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), self.Owner:GetViewModel():LookupAttachment( "1" ) )

	self:EmitSound( "scifi.hybridammo.fire1" )
--	self:EmitSound( "weapons/asa/wraithshot_fire.wav", 30, math.random( 100, 120 ), 1, CHAN_STATIC )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	if ( self:GetBurstMode() ) && ( self.Owner:IsPlayer() ) then
		if ( self:GetBurstCount() >= 4 ) then return end
		self:SetCanBurst( true )
	--	self:HwaveFire()
		self:SetBurstCount( self:GetBurstCount() + 1 )
	else
		if ( self.Owner:IsPlayer() ) then
			self:HwaveFire()
			self:SetNextPrimaryFire( CurTime() + 0.06 )
		else
			timer.Create( "fakebfire", 0.08, 3, function()
				if ( IsValid( self ) && IsValid( self.Owner ) ) then
					self:HwaveFire()
				end
			end )
		end
	end

end

function SWEP:CanBFire()

	if ( self:Clip1() <= 0 ) then
	--	self:Reload()
	--	self:SetNextPrimaryFire( CurTime() + 3 )
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end
	
	if ( self:GetNextPrimaryFire() > CurTime() && self:GetNextPrimaryFire() > -1 ) then
		return false
	end

	return true
	
end

function SWEP:SecondaryAttack()

	self:SetNextSecondaryFire( CurTime() + 0.5 )
	
	if ( self.Owner:KeyDown( IN_ATTACK2 ) ) and ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetBurstMode() ) then 
			self:SetBurstMode( false )
		else
			self:SetBurstMode( true )
		end
		self:EmitSound( "Weapon_AR2.Empty" )
		self:SendWeaponAnim( ACT_VM_IDLE_TO_LOWERED )
	end

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	
--	ParticleEffect( "ngen_hit_sparks_2", tr.HitPos, tr.Normal:Angle(), self )
--	ParticleEffect( "umbra_hit", tr.HitPos, tr.Normal:Angle(), self )

	if ( CLIENT ) && ( tr.MatType == MAT_METAL ) then
--		ParticleEffect( "ngen_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
		ParticleEffect( "spr_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
		
		if ( self.Owner:IsPlayer() ) then
			local dlight = DynamicLight( self:EntIndex() )
			if ( dlight ) then
				dlight.pos = tr.HitPos
				dlight.r = 255
				dlight.g = 220
				dlight.b = 200
				dlight.brightness = 1
				dlight.Decay = 2048
				dlight.Size = 64
				dlight.DieTime = CurTime() + 0.5
			end
		end
	end

end

function SWEP:OnReloadFinish()

	self:SetBurstCount( 5 )
	self:SendWeaponAnim( ACT_VM_IDLE )

end