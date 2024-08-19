AddCSLuaFile()
AddCSLuaFile( "base/scifi_techs.lua" )
include( "base/scifi_techs.lua" )
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false
SWEP.ItemRank 				= 8

SWEP.ViewModel 				= "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_elite.mdl"
SWEP.SciFiSkin 				= "vgui/white"

SWEP.HoldType 				= "duel"
SWEP.HoldTypeNPC 			= "duel"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 1.4

SWEP.Primary.ClipSize		= 90
SWEP.Primary.DefaultClip	= 90
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "pistol"

SWEP.VfxMuzzleParticle 		= "ngen_muzzle_4"
SWEP.VfxMuzzleAttachment 	= "1"
SWEP.VfxMuzzleColor 		= Color( 255, 160, 100, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 600

SWEP.PrintName				= "Ak-Raga"
SWEP.Slot					= 1
SWEP.SlotPos				= 1
SWEP.ViewModelFOV			= 60

SWEP.SciFiACCRecoverRate	= 0.26

SWEP.AdsPos 				= Vector( 0, 0, 0 )
SWEP.AdsAng 				= Vector( 0, 0, 0 )
SWEP.AdsFov					= 50
SWEP.AdsFovTransitionTime	= 0.16
SWEP.AdsFovCompensation 	= 0.2
SWEP.AdsRecoilMul			= 0.8
SWEP.AdsTransitionAnim		= true
SWEP.AdsTransitionSpeed		= 22

SWEP.SciFiMeleeRange		= 60
SWEP.SciFiMeleeDamage		= 8
SWEP.ViewModelMeleePos		= Vector( 4, 2, -16 )
SWEP.ViewModelMeleeAng		= Angle( 46, 42, -40 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( 0, 0.6, -1 )
SWEP.ViewModelReloadAng		= Angle( -10, 0, 0 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeRecoverTime 	= 0.32
SWEP.SciFiMeleeASpeed		= 0.6
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"
SWEP.SciFiMeleeChargeMax	= 100

SWEP.ViewModelSprintPos 	= Vector( 0, -2, 4 )
SWEP.ViewModelSprintAng		= Angle( -24, 0, 0 )
SWEP.ViewModelShift = false

SWEP.SprintAnimIdle			= false
--SWEP.ViewModelInspectable 	= false

SWEP.ReloadTime 			= 2.5
SWEP.ReloadSND 				= Sound( "weapons/pn03/reload.wav" )
SWEP.ReloadModels 			= true
SWEP.ReloadGib 				= "models/weapons/w_pist_glock18_mag.mdl"
SWEP.ReloadOnTrigger 		= false
SWEP.ReloadRealisticClips 	= false
SWEP.ReloadPlaybackRate  	= 1.1

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				  5", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x2", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Bullet", color = Color( 210, 215, 200 ) },
	["4"] = { text = "Clip size: 					90", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 15.3 (full-auto)", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 5,
		DamageType = DMG_BULLET,
		CritMul = 2,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.065 }, 
		},
	},
	ClipSize = 90,
	ReloadSpeed = 2.5,
	Recoil = 4
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -1.5, 0 ), angle = Angle( 0, 0, 0 ) },
	["v_weapon.elite_left"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -1.5 ), angle = Angle( 0, 0, 0 ) },
	["v_weapon.elite_right"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -1.5 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["gunl"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_smg1.mdl", bone = "v_weapon.elite_left", rel = "", pos = Vector( -0.2, -2.5, 7 ), angle = Angle( 90, 5, -90 ), size = Vector( 1, 1, 1 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gunr"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_smg1.mdl", bone = "v_weapon.elite_right", rel = "", pos = Vector( -1.2, -2.5, 7 ), angle = Angle( 90, -5, -90 ), size = Vector( 1, 1, 1 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

local snd_fire = Sound( "weapons/asa/atypethree_fire.wav" ) -- "weapons/asa/weowa_fire.wav" )
local snd_fire_lowclip = Sound( "weapons/pistol/pistol_empty.wav" )

function SWEP:SubInit()

end

function SWEP:Think()

	if ( self.Owner:IsPlayer() && !self.Owner:InVehicle() ) then
		local vmEntity = self:GetViewModelEnt()
		local NextPFire = math.max( self:GetNextPrimaryFire(), self:GetNextSecondaryFire() )
		if ( NextPFire >= CurTime() + 0.02 ) && ( NextPFire < CurTime() + 0.04 ) then
			vmEntity:SetSequence( "idle" )
		end
		
		if ( CLIENT ) then
		
		end
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	local vm = self:GetViewModelEnt()
	
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 2 )
	end

	if ( event == 5001 ) then
		return true
	end

end

function SWEP:Attack()
	
	local cmdDamage = GetConVarNumber( "sfw_damageamp" )
	
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	local iSelf = self:EntIndex()
	local attach
	if ( self.RightHand ) then
		attach = 1
	else
		attach = 2
	end

	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 1
	ptru.AmmoType = "pistol"
	ptru.TracerName = "spr_tracer_noattach"
	ptru.Callback = function( attacker, tr, dmginfo )
		ParticleEffect( "umbra_hit", tr.HitPos, tr.Normal:Angle(), self )
	end
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() / 512 )
	bullet.Tracer = 0
	bullet.HullSize = 0.32
	bullet.AmmoType = "pistol"
	bullet.TracerName = "spr_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		util.ParticleTracerEx( 
			"spr_tracer", 	--particle system
			tr.StartPos, 	--startpos
			tr.HitPos, 	--endpos
			false, 			--do whiz effect
			iSelf, 			--entity index
			attach 			--attachment
		)
	
		dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_GENERIC ) )
		
		local bouncer = ( tr.Normal - tr.HitNormal )
		bouncer = bouncer:Length()
		
		ParticleEffect( "umbra_hit", tr.HitPos, tr.Normal:Angle(), self )

		if ( bouncer < 1.72 ) && ( tr.MatType == MAT_GLASS ) || ( tr.MatType == MAT_WOOD ) then
			ptru.Src = tr.HitPos + pOwnerAV * 8
			ptru.Dir = tr.Normal + pOwnerAV

			self.Owner:FireBullets( ptru, false )
		end
		
		if ( tr.MatType == MAT_METAL ) || ( tr.MatType == MAT_CONCRETE ) then
			ptru.Src = tr.HitPos - pOwnerAV -- * 16
			ptru.Dir = ( tr.Normal + tr.HitNormal )

			self.Owner:FireBullets( ptru, false )
		end
	end
	
	bullet.Damage = 5 * cmdDamage
	ptru.Damage = 4 * cmdDamage
	bullet.Force = 4
	bullet.Spread = Vector( .001, .0014 ) * ( self:GetSciFiACC() * 1 )
	self.Owner:FireBullets( bullet, false )

	self:EmitSound( snd_fire, 80, math.random( 95, 105 ), 1, CHAN_WEAPON ) -- "scifi.talon.fire" )

	self:TakePrimaryAmmo( 1 )
	
	if ( self:Clip1() < ( self.Primary.ClipSize * 0.2 ) ) then
		self:EmitSound( snd_fire_lowclip, 60, math.random( 95, 105), 1, CHAN_STATIC )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.8, -1 ), 0, 0 ) * ( 1 + self:GetSciFiACC() * 0.02 ) )
	end
	
	self:AddSciFiACC( 4 )
	
end

function SWEP:Muzzle()
	
	local vmEntity = self:GetViewModelEnt()
	
	if ( self.RightHand ) then
		self.VfxMuzzleAttachment = "1"
		
		local seq = "shoot_right1"
		
		if ( self:Clip1() < 3 ) then
			seq = "shoot_rightlast"
		end
		
		vmEntity:SetSequence( seq )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	else
		self.VfxMuzzleAttachment = "2"
	
		local seq = "shoot_left1"
		
		if ( self:Clip1() < 3 ) then
			seq = "shoot_leftlast"
		end
		
		vmEntity:SetSequence( seq )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	end

	local vmAttachMuzzle = vmEntity:LookupAttachment( self.VfxMuzzleAttachment )
	
	ParticleEffectAttach( "umbra_muzzle", 4, vmEntity, vmAttachMuzzle )

	if ( self:GetSciFiACC() >= math.random( 10, 35 ) ) then
		ParticleEffectAttach( "gunsmoke", 4, vmEntity, vmAttachMuzzle )
	end
	
	self:DrawMuzzleLight( "255 70 50 255 ", 130, 620, 0.04 )

end

function SWEP:PrimaryAttack()

	self:SetNextPrimaryFire( CurTime() + 0.065 )

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	if ( self.RightHand ) then
		self.RightHand = false
		self.LeftHand = true
	else
		self.RightHand = true
		self.LeftHand = false
	end
	
	if ( self.Owner:IsNPC() ) then
		timer.Create("sprayandpray" .. self:EntIndex(), 0.064, 12, function()
			if ( !IsValid( self ) ) then return end
			if ( !IsValid( self.Owner ) ) then return end
			if ( !self:CanPrimaryAttack( 0, true ) ) then return end
			
			self:Attack()
		end )
	else
		self:Muzzle()
		self:Attack()
	end

end