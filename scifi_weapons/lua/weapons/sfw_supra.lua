AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.NpcSpawnFlags 			= {}

SWEP.Purpose				= "An energy grenade launcher. The spectral charge bursts into 4 to 6 volatile energy bundles upon impact."
SWEP.Instructions			= "Mouse1 to fire. Hold Mouse1 to charge the weapon and increase range and amount of child grenades for the cost of fire rate."
SWEP.ItemRank 				= 28

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "shotgun"
SWEP.DeploySpeed 			= 2
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.ViewModelFOV = 62

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "SciFiEnergy"

SWEP.VfxMuzzleParticle 		= "astra_muzzle"
SWEP.VfxMuzzleColor 		= Color( 200, 170, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720

SWEP.PrintName				= "C-CK Supra"
SWEP.Slot					= 4
SWEP.SlotPos				= 1

SWEP.AdsPos 				= Vector(-4.975, -1, 2.45)
SWEP.AdsFov					= 60

SWEP.SafeModeOnSnd 	 		= "scifi.ancient.safety.on"
SWEP.SafeModeOffSnd 		= "scifi.ancient.safety.off"

SWEP.ViewModelSprintPos		= Vector( 4, -4, 2 )
SWEP.ViewModelMeleePos		= Vector( 18, 8, -5 )
SWEP.ViewModelMeleeAng		= Angle( -10, 90, -85 )

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8

SWEP.MidairRecoilMul		= 1

SWEP.ChargeMax				= 100
SWEP.ChargeAdd				= 0.75
SWEP.ChargeDrain			= 0.5
SWEP.ChargeDeltaCompensate 	= true

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.52
SWEP.SciFiMeleeRange		= 60
SWEP.SciFiMeleeDamage		= 6
SWEP.SciFiMeleeSound		= "scifi.melee.swing.heavy"

SWEP.DepletedSND			= ""

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.15

SWEP.SciFiFamily			= { "custom", "phys", "ads", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 24, 12; 24", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "AOE Range:		256; 200", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				--", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Blast, Blight", color = Color( 175, 160, 180 ) },
	["5"] = { text = "Fire rate: 				 2.2 (semi-auto / charge)", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Energy drain: 	 30 (per shot)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate: 48", color = Color( 180, 180, 180 ) },
	["9c"] = { text = "... By their will, light shall cleanse this world ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "24, 12; 24",
		DamageAmount = 60,
		DamageBlastRadius = 200,
		DamageType = { DMG_BLAST, DMG_SF_BLIGHT },
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.46 }
		},
		ChargeRate = 0.75
	},
	CoreRechargeRate = 60,
	PerkSet = { SCIFI_PERK_RELOAD_RECHARGEAMMO, SCIFI_PERK_AMMO_EXPLOSIVE, SCIFI_PERK_TARGETING_SMART, { PerkTitle = "Cleansing Light", PerkDescription = "Weapon charge increases amount of \nchild grenades and projectile velocity.", PerkPanelHeight = 3, PerkColor = Color( 255, 20, 20 ) } }
}

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0.8, -2.4 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(39.687, 17.166, -20.129) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, -1, -1 ), angle = Angle(0, 0, 0) }, --Vector(1.736, -0.856, 0.273), angle = Angle(-1.611, -3.504, 5.339) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0 ), angle = Angle(0, 0, 0) } --pos = Vector(0, -0.093, 0), angle = Angle(0, 11.814, 11.616) }
}
SWEP.VElements = {
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(17.214, -1.41, -3.529), angle = Angle(180, 10.067, -171.982), size = Vector(0.703, 0.703, 0.703), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.501, -0.666, -0.738), angle = Angle(37.598, -163.959, -11.36), size = Vector(0.291, 0.31, 0.573), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.386, 1.912, -2.51), angle = Angle(180, 17, 75), size = Vector(0.319, 0.275, 0.275), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.689, 2.003, -2.608), angle = Angle(51.389, -110.558, 180), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.386, -0.403, -4.995), angle = Angle(177.975, -2.537, -91.292), size = Vector(0.319, 0.275, 0.275), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.725, 2.6, -3.8), angle = Angle(174.811, 8.178, -9.08), size = Vector(0.37, 0.279, 0.37), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.277, 2.157, 1.333), angle = Angle(134.783, 19.944, -11.235), size = Vector(0.218, 0.184, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.18, -2.508, -1.451), angle = Angle(66.762, 108.823, 180), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 0, -1.4), angle = Angle(0, 0, 90), size = Vector(0.12, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_chest.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, -1.101, -5.8), angle = Angle(-5.608, 8.671, -170.609), size = Vector(0.68, 0.68, 0.68), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_barrel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(17.214, -1.41, -3.529), angle = Angle(180, 10.067, -171.982), size = Vector(0.703, 0.703, 0.703), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.501, -0.666, -0.738), angle = Angle(37.598, -163.959, -11.36), size = Vector(0.291, 0.31, 0.573), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.386, 1.912, -2.51), angle = Angle(180, 17, 75), size = Vector(0.319, 0.275, 0.275), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.689, 2.003, -2.608), angle = Angle(51.389, -110.558, 180), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.386, -0.403, -4.995), angle = Angle(177.975, -2.537, -91.292), size = Vector(0.319, 0.275, 0.275), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.725, 2.427, -4.481), angle = Angle(174.811, 8.178, -9.08), size = Vector(0.37, 0.279, 0.37), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.277, 2.157, 1.333), angle = Angle(134.783, 19.944, -11.235), size = Vector(0.218, 0.184, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.18, -2.508, -1.451), angle = Angle(66.762, 108.823, 180), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_chest.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, -1.101, -6.112), angle = Angle(-5.608, 8.671, -170.609), size = Vector(0.68, 0.68, 0.68), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- resource.AddSingleFile( "weapons/ancient/supra_charge.wav" )
util.PrecacheSound( "weapons/ancient/supra_charge.wav" )
-- resource.AddSingleFile( "common/NULL.wav" )
util.PrecacheSound( "common/NULL.wav" )

local barrel_1_hpos = Vector(15, -1.101, -6.112)
local barrel_2_hpos = Vector(17.214, -1.41, -3.529)
local limb_1_hpos = Vector(5.386, 1.912, -2.51)
local limb_2_hpos = Vector(5.386, -0.403, -4.995)
local limb_3_hpos = Vector(15.689, 2.003, -2.608)
local limb_4_hpos = Vector(13.18, -2.508, -1.451)
local barrel_1_hang = Angle(-5.608, 8.671, -170.609)
local barrel_2_hang = Angle(180, 10, 170)
local limb_1_hang = Angle(180, 17, 75)
local limb_2_hang = Angle(177.975, -2.537, -91.292)
local limb_3_hang = Angle(51.389, -110.558, 180)
local limb_4_hang = Angle(66.762, 108.823, 180)
local core_hpos = Vector(6, 0.6, -3.2)
local core_hscale = Vector( 0.001, 0.001, 0.001 )

local core_color_default = Color( 190, 215, 255 )
local matCore = Material( "models/weapons/misc/energy_surf" )

SWEP.DataTables = {
	{ dType = "Float", dName = "NextCoreFxAnim" },
	{ dType = "Float", dName = "NextChargeAnim" }
}

function SWEP:SubInit()

	self:SetCharge( 0 )
	self.ScifiRegenNext = 0
	
end

function SWEP:Think()
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
	if ( !self.Owner:IsPlayer() ) then return end

	local animtime = self:GetNextChargeAnim()	
	local vm = self.Owner:GetViewModel()
	local sine0 = math.sin( CurTime() * 8 ) / 8
	local sine1 = math.sin( CurTime() * 4 ) / 10
	local sine2 = math.sin( CurTime() * 4 ) / 20
	local cmod = self:GetCharge() / 100
	
	local iClip1 = self:Clip1()
	
	if ( SERVER ) then
		if( self.ScifiRegenNext <= CurTime() )&&( !self.Owner:KeyDown( IN_ATTACK ) ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) then 
				self.Weapon:SetClip1( self.Weapon:Clip1() + 1 ) 
			end
		end
		
		if ( self.Weapon:Clip1() >= self.Primary.ClipSize + 1 ) then
			self.Weapon:SetClip1( self.Primary.ClipSize )
		end
	end
	
	if ( self:GetSafeMode() ) then
		cmod = 0
		iClip1 = 0
	end
	
	self.VElements[ "0+" ].pos = barrel_2_hpos + Vector( -sine0, -sine1, sine2 - cmod )
	self.VElements[ "5" ].pos = limb_1_hpos + Vector( sine0, sine1 + cmod, sine2 )
	self.VElements[ "5+" ].pos = limb_2_hpos + Vector( sine0, -sine1 - cmod, sine2 + ( cmod / 10 ) )
	self.VElements[ "6" ].pos = limb_3_hpos + Vector( sine0, -sine1 + cmod, sine2 )
	self.VElements[ "6+" ].pos = limb_4_hpos + Vector( -sine0, -sine1, sine2 - cmod )
	
	self.VElements[ "0+" ].angle = barrel_2_hang + Angle( -sine0, -sine1, sine2 ) * cmod
	self.VElements[ "5" ].angle = limb_1_hang + Angle( -sine0, sine1, sine2 ) * cmod
	self.VElements[ "5+" ].angle = limb_2_hang + Angle( sine0, sine1, -sine2) * cmod
	self.VElements[ "6" ].angle = limb_3_hang + Angle( -sine0, -sine1, sine2 ) * cmod
	self.VElements[ "6+" ].angle = limb_4_hang + Angle( sine0, sine1, sine2 ) * cmod

	self.VElements[ "4" ].pos = core_hpos + Vector( sine0, sine1, -sine2 )
--	self.VElements[ "4" ].angle = self.VElements[ "4" ].angle + Angle( sine0, sine1, -sine2 ) * 12
	self.VElements[ "4" ].size = core_hscale * iClip1 * ( 1 + cmod )
	
	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetProjectileSpawnPos() + self.Owner:EyeAngles():Forward() * 20 + self.Owner:EyeAngles():Up() * -4
			dlight.r = core_color_default.r
			dlight.g = core_color_default.g
			dlight.b = core_color_default.b
			dlight.brightness = 0.1 + cmod
			dlight.Decay = 2048
			dlight.Size = 0.6 * iClip1 + 128 * cmod
			dlight.Style = 1				
			dlight.DieTime = CurTime() + 1
			dlight.noworld = false
			dlight.nomodel = false
		end
	end

	if (GetConVar( "sfw_fx_particles" ):GetBool()) then
		if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
			if ( self:GetNextCoreFxAnim() <= CurTime() ) then
			--	ParticleEffectAttach( "prisma_core", 4, vm, vm:LookupAttachment("muzzle") )
				self:SetNextCoreFxAnim( CurTime() + 2 )
			end
		end
	end

	if ( self.Owner:KeyReleased( IN_ATTACK ) ) && ( self:GetNextPrimaryFire() <= CurTime() ) && (self.SciFiState ~= SCIFI_STATE_SPRINT ) then
		if ( SERVER || !game.SinglePlayer() ) then
			self:DefaultAttack()
			self:SetNextPrimaryFire( CurTime() + 0.46 )	
			self:SetCharge( 0 )
		end
	end
	
	if ( CLIENT ) && ( self:GetNextPrimaryFire() > CurTime() ) && (self.SciFiState ~= SCIFI_STATE_SPRINT ) then
		self:SetCharge( 0 )
	end

	if ( CLIENT ) then
		local scale = 0.045 * ( iClip1 * 0.01 ) * ( 1 + cmod * 2 )
		matCore:SetFloat( "$FleshBorderWidth", scale )
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && iClip1 > 0 ) then
		if ( self:GetCharge() < self.ChargeMax ) then
			self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( self:GetCharge() >= 20 ) && ( self:GetNextPrimaryFire() + 0.22 <= CurTime() ) then
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
				ParticleEffectAttach( "supra_charging", 4, vm, vm:LookupAttachment("muzzle") )
			end
		end
		
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( SERVER ) then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "shake" ) )
			end
			self:SetNextChargeAnim( CurTime() + 0.8 )
		end
	
		if ( CLIENT ) then
			if ( self:GetCharge() >= 20 ) then
				EmitSound( "weapons/ancient/supra_charge.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), math.Clamp( self:GetCharge() * 1.25, 20, 100 ) )
			end
		end
	end
		
	if ( CLIENT ) && ( self.Owner:KeyReleased( IN_ATTACK ) ) then
		EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, self.Owner:EntIndex(), 60, bit.bor( SND_IGNORE_NAME, SND_STOP ), math.Clamp( self:GetCharge() * 1.25, 50, 100 ) )
	end

end

function SWEP:Deploy() 

	self:SetAds( false, self.Owner )
	self:SetCharge( 0 )	
	self.ScifiRegenNext = CurTime() + 1
	
	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT )&&( IsValid(self.Owner) )&&( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	self:ResetDeployment()
	self:SetSciFiACC( 4 )
	return true

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( event == 6001 ) then 
		return true 
	end

	if ( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:DefaultAttack()
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	if ( self.Owner:IsPlayer() && self.Owner:KeyDown( IN_RELOAD ) ) then return end
	
	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
		-- self:SetNextPrimaryFire( CurTime() + 0.09 )
		
		local ent = ents.Create( "supra_nade_parent" )
		if ( !IsValid( ent ) ) then return end
		if (self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 20 ) )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent.Charge = self:GetCharge()
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local spread = self:GetProjectileSpreadVector() * ( 72 + self:GetSciFiACC() * 17 )
		if ( self.Owner:IsNPC() ) then
			spread = self.Owner:EyeAngles():Forward()
		end
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( ( self.Owner:GetAimVector() * 3200 * ( 1 + self:GetCharge() / 6 ) + spread ) )
	end

	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.4, -0.6 ), math.random( 0, 0.02 ), math.random( 0.01, 0.02 ) ) * ( 0.5 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 1.8 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.supra.fire1" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	
	if ( self.Owner:IsPlayer() ) then
		local drain = math.Clamp( 30 + 30 * ( self:GetCharge() / self.ChargeMax ), 0, 70 )
		local delay = math.min( drain * 0.05, 5 )

		self:TakePrimaryAmmo( math.min( drain, self:Clip1() ) )
		self.ScifiRegenNext = CurTime() + delay
	
		self:AddSciFiACC( 1 )
	end
	
	if ( CLIENT ) then
		self:SetCharge( 0 )
	end
	
	if ( SERVER ) then
		self:SetCharge( 0 )
	end
	
end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsNPC() ) then
		self:SetCharge( 80 )
		self:DefaultAttack()
		self:SetClip1( 0 )
	end

end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()
	
end