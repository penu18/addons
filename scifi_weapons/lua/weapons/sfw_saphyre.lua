AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.PrintName				= "HS24 'Sapphire' light rifle."
SWEP.Slot					= 2
SWEP.SlotPos				= 2

SWEP.Purpose				= "Fires bursts of four energy pulses that will 'dissect' your target. Has a chance to steal health from your enemies and heal you."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 + 'Use' (e) to switch firemodes. Dealt damage will decently heal the weapon's owner."
SWEP.ItemRank 				= 22

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.SciFiSkin				= "models/weapons/saphyre/skin"
SWEP.HoldType 				= "ar2"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_vtsteel.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.Primary.ClipSize		= 32
SWEP.Primary.DefaultClip	= 32
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.VfxMuzzleParticle 		= "saphyre_muzzle"
SWEP.VfxMuzzleColor 		= Color( 50, 100, 255, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720

SWEP.NPCAccuracy 			= 512
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.25


-- SWEP.ViewModelSprintPos		= Vector( 4, 0.2, -1 )
-- SWEP.ViewModelSprintAng		= Angle( -8, 30, -15 )
SWEP.ViewModelSprintPos 	= Vector( 4, 0, -1 )
SWEP.ViewModelSprintAng		= Angle( -5, 30, -25 )

SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.2
SWEP.ViewModelShiftOffset 	= Vector( 0, -0.04, -0.09 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )

-- SWEP.ViewModelSprintPos 	= Vector( 4, 0, -2 ) -- Vector( 5, 1.5, 1 )
-- SWEP.ViewModelSprintAng		= Angle( -4, 30, -30 ) -- Angle( -17.5, 25, -15 )
-- SWEP.ViewModelSwayDirection = Vector( -0.75, 5, 0 ) -- Vector( -0.25, 4, 0.6 )
-- SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.125 )
SWEP.ViewModelSwayDirection = Vector( -0.75, 6, 1 )
SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.15 )
SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 4.25
SWEP.SprintAnimSpeed		= 12
SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.0

SWEP.SciFiFamily			= { "vtec", "phys", "modes_bfire", "ads", "autoreload", "useshook" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 4, +4", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x6", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Energy, Slash", color = Color( 80, 180, 255 ) },
	["4"] = { text = "Clip size: 					32", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 2.8 (burst) / 14.2 (full-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Has innate life-steal effect.", color = Color( 180, 180, 180 ) },
--	["7"] = { text = "... Their blood could inspire ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "4, 4",
		DamageAmount = 8,
		DamageType = { DMG_SLASH, DMG_SF_VAPOR },
		CritMul = 6,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.11 }, 
			{ RateTitle = "burst", RateDelay = 0.27 }
		},
	},
	ClipSize = 32,
	ReloadSpeed = 0.8,
	Recoil = 2.4,
	PerkSet = { SCIFI_PERK_AMMO_RADIATION, SCIFI_PERK_AMMO_RESURGENCE }
}

SWEP.ReloadSND				= "scifi.hwave.reload" 
SWEP.ReloadACT				= ACT_VM_IDLE_TO_LOWERED
SWEP.ReloadTime 			= 0.8

SWEP.AdsPos 				= Vector(-4.95, 0, 1.159)
SWEP.ViewModelHomePos		= Vector( 0, 1, 0)

SWEP.NPCAccuracy 			= 1100
SWEP.NPCSkillLevel 			= 1.25

-- Colors for holographic sight --
local color_visor_default = Color( 180, 220, 255, 255 ) 	-- default white
local color_visor_warning = Color( 255, 15, 15, 255 ) 		-- saturated red
local color_visor_error =  Color( 255, 180, 80, 255 )		-- decent yellow

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 2, 0, 3 ), angle = Angle( 0, 0, 0 ) },
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1, 0 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "Base", rel = "", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "Base", rel = "", pos = Vector(-0.09, -0.098, 11.967), angle = Angle(0, 0, 0), size = Vector(0.36, 0.36, 0.36), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/lab_flourescentlight002b.mdl", bone = "Base", rel = "", pos = Vector(0.963, 1.616, 10.572), angle = Angle(0, 0, 90), size = Vector(0.112, 0.029, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "Base", rel = "", pos = Vector(5.015, 68.08, -10.5), angle = Angle(180, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt1", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/health_charger001.mdl", bone = "Base", rel = "", pos = Vector(-0.005, 1, 5), angle = Angle(0, 0, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(0.3, 4, 20), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/lowerbarrel", skin = 0, bodygroup = {} },
	["holo_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 5), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_hexaframe_chroma", skin = 0, bodygroup = {} },
	["holo_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_point", skin = 0, bodygroup = {} },
	["holo_3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_point", skin = 0, bodygroup = {} },
	["holo_4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6.25), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_lines", skin = 0, bodygroup = {} },
	["holo_5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.1, -3.05, 5.5), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_disp_burst", skin = 0, bodygroup = {} },
	["holo_6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.16, -3.051, 5.45), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/saphyre/holo_disp_notify_reload", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "Base", rel = "", pos = Vector(0.03, -2.75, 5), angle = Angle(0, -90, 180), size = Vector(0.025, 0.025, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "Base", rel = "", pos = Vector(0, 0.181, 19), angle = Angle(0, 160, 90), size = Vector(0.314, 0.414, 0.314), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/barrel", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.25, -5), angle = Angle(165, 10, 8), size = Vector(1.303, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11, 0.6, -6), angle = Angle(-105, 0, 0), size = Vector(0.46, 0.46, 0.46), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
--	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 0.4, -5.8), angle = Angle(13, 180, 180), size = Vector(0.011, 0.016, 0.011), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/vtech_case", skin = 0, bodygroup = {} },
--	["3+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 0.4, -4.85), angle = Angle(-13, 0, 180), size = Vector(0.011, 0.016, 0.011), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/vtech_case", skin = 0, bodygroup = {} },
--	["3++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, 0.4, -6.6), angle = Angle(3.5, 180, 180), size = Vector(0.013, 0.013, 0.011), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/vtech_case", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 5.2, 78), angle = Angle(0, 90, 192), size = Vector(0.8, 1.12, 1.295), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/health_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.8, -3.8), angle = Angle(0, -90, -103), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19, 2, -3.2), angle = Angle(0, -90, 75), size = Vector(0.081, 0.081, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/lowerbarrel", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.4, -8.7), angle = Angle(80, 0, 0), size = Vector(0.035, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, 0.4, -9), angle = Angle(0, 90, 14), size = Vector(0.404, 0.454, 0.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/barrel", skin = 0, bodygroup = {} }
}

SWEP.DataTables = {
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Bool", dName = "CanBurst" },
	{ dType = "Int", dName = "BurstCount" }
}

function SWEP:SubInit()

	self:SetBurstMode( true )
	
end

function SWEP:Think()

	if ( self.Owner:IsPlayer() ) then
		
		if ( !self.Owner:InVehicle() && self.SciFiState == SCIFI_STATE_ADS ) then
			local tr = self.Owner:GetEyeTrace()
			local tardist = self.Owner:GetShootPos():Distance( tr.HitPos )
			local clrmod = 255 - ( self.VElements[ "holo_4" ].size.x * 5600 )
		
			self.VElements[ "holo_2" ].size = Vector(0.015, 0.015, 0.015) * ( self:GetSciFiACC() / 3 + 1 )
			self.VElements[ "holo_4" ].size = Vector(0.007, 0.007, 0.007) * ( tardist / 4000 )
			self.VElements[ "holo_4" ].color = Color( clrmod, clrmod, clrmod, clrmod )

			if ( tr.Entity:IsNPC() ) || ( tr.Entity:IsPlayer() ) then
				self.VElements[ "holo_3" ].size = Vector(0.03, 0.03, 0.03)
				if ( self.Owner:GetEyeTrace().HitGroup == HITGROUP_HEAD ) then
					self.VElements[ "holo_3" ].color = color_visor_warning
				else
					self.VElements[ "holo_3" ].color = color_visor_error
				end
			else
				self.VElements[ "holo_3" ].size = Vector(0.02, 0.02, 0.02)
				self.VElements[ "holo_3" ].color = color_visor_default
			end
		end

		if ( self:GetBurstMode() ) then
			self.VElements[ "holo_5" ].material = "models/weapons/saphyre/holo_disp_burst"
		else
			self.VElements[ "holo_5" ].material = "models/weapons/saphyre/holo_disp_auto"
		end
		
		if ( self.Owner:WaterLevel() == 3 ) then
			self.VElements[ "holo_1" ].color = color_visor_error
			self.VElements[ "holo_5" ].material = "models/weapons/saphyre/holo_disp_error"
		else
			self.VElements[ "holo_1" ].color = color_visor_default
		end
		
		if ( self.Weapon:Clip1() < 9 ) && !( self.SciFiState == SCIFI_STATE_RELOADING ) then
			self.VElements[ "holo_6" ].material = "models/weapons/saphyre/holo_disp_notify_reload"
		else
			self.VElements[ "holo_6" ].material = "vgui/white"
		end
				
		if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
			self.VElements[ "5" ].angle = self.VElements[ "5" ].angle + Angle( 0, -( self.Weapon:Clip1() / 8 ), 0 )
			self.VElements[ "10" ].pos = Vector(0.3, 4, math.Clamp( 16 + ( self.Weapon:Clip1() / 4 ), 0, 20 ) )
			self.VElements[ "holo_1" ].color = color_visor_error
		else
			self.VElements[ "10" ].pos = Vector(0.3, 4, 20)
			self.VElements[ "holo_1" ].color = color_visor_default
		end

		if ( self:GetNextPrimaryFire() >= CurTime() ) then
			self.VElements[ "5" ].angle = Lerp( 1, self.VElements[ "5" ].angle, self.VElements[ "5" ].angle + Angle( 0, 2, 0 ) ) --self.VElements[ "5" ].angle + Angle( 0, 1, 0 )
		end
		
	end
	
	if ( self:GetBurstMode() ) then
		if !( self.SciFiState == SCIFI_STATE_RELOADING ) && ( self:CanBFire() ) && ( self:GetNextPrimaryFire() < CurTime() && self:GetNextPrimaryFire() > -1 ) then
			if ( self:GetBurstCount() <= 4 && self:GetCanBurst() ) && ( self:GetNextPrimaryFire() ~= -1 ) then
				self:PrimaryAttack()
				self:SetNextPrimaryFire( CurTime() + 0.07 )	
			end
			
			if ( self:GetBurstCount() >= 4 ) then
				self:SetNextPrimaryFire( CurTime() + 0.35 )
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

function SWEP:HwaveFire()

	local vmEntity = self:GetViewModelEnt()
	local vmAttach = vmEntity:LookupAttachment( "muzzle" )
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerEP = self.Owner:EyePos()
	local pOwnerEA = self.Owner:EyeAngles()
	local wepIsAds = self.SciFiState == SCIFI_STATE_ADS
	local vSpread = self:GetProjectileSpreadVector() * 0.16
	
	if ( self.Owner:IsNPC() ) then
		pOwnerAV = self.NPCAimVectorOverride
	end
	
	if ( SERVER ) then
		local origin = self:GetProjectileSpawnPos()
		
		if ( wepIsAds ) then
			origin = pOwnerEP + ( pOwnerAV * 20 )
		end
	
		local ent = ents.Create( "saph_pfire" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( origin )
		ent:SetAngles( pOwnerEA )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * 340000 + vSpread * ( 1 + self:GetSciFiACC() * 1500 ) )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( ( Angle( math.random( 80, 120 ), 0, 0 ) + vSpread:Angle() ) * -0.001 ) -- * -0.00075 )
		-- self.Owner:ViewPunch( Angle( math.random( -0.25, -1.5 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( 0.3 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 2.4 )
	end
	
	if ( self:GetBurstMode() ) then
		if ( self:GetBurstCount() >= 3 ) then
			self:EmitSound( "scifi.saph.fire2" )
		else
			self:EmitSound( "scifi.saph.fire1" )
		end
	else
		self:EmitSound( "scifi.saph.fire1" )
	end
	
	if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() )&& ( cmd_heat == 1 ) then
		if ( self:GetSciFiACC() >= 14 ) then
			ParticleEffectAttach( "hwave_debris_small", 4, vmEntity, vmAttach )
		end
		
		if ( self:GetSciFiACC() >= 20 ) then
			ParticleEffectAttach( "nrg_heat", 4, vmEntity, vmAttach )
		end
	end
	
	self:DoMuzzleEffect()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:PrimaryAttack()
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	if ( self:GetBurstMode() ) && ( self.Owner:IsPlayer() ) then
		if ( self:GetBurstCount() >= 4 ) then return end
		self:SetCanBurst( true )
		self:HwaveFire()
		self:SetBurstCount( self:GetBurstCount() + 1 )
	else
		self:HwaveFire()
		self:SetNextPrimaryFire( CurTime() + 0.11 )
		
		if ( self.Owner:IsNPC() ) then
			self.Owner:SetSaveValue( "m_flLastAttackTime", 0 )
			self.Owner:SetSaveValue( "m_flNextAttack", 0 )
		end
	end

end

function SWEP:CanBFire()

	if ( self.Weapon:Clip1() <= 0 ) then
	--	self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		self:SetNextPrimaryFire( CurTime() + 0.2 )
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
		self:EmitSound( "scifi.hwave.switchmode" )
	end

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )

end