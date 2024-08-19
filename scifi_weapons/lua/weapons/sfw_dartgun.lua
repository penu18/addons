AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.PrintName				= "'Wasp' Flechette Pistol"
SWEP.Purpose				= ""
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to aim down sights."
SWEP.ItemRank 				= 7

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel				= "models/weapons/c_sfmp.mdl" --"models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"
SWEP.SciFiSkin 				= "vgui/white"
SWEP.SciFiSkin_1 			= "vgui/white"
SWEP.SciFiSkin_2 			= "vgui/white"
SWEP.SciFiSkin_3 			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.HoldType 				= "pistol"
SWEP.HoldTypeSprint			= "normal"
SWEP.HoldTypeNPC 			= "pistol"
SWEP.DeploySpeed 			= 1.6

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.15

SWEP.VfxMuzzleParticle 		= "ngen_muzzle"
SWEP.VfxMuzzleColor 		= Color( 140, 120, 255, 180 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 512
SWEP.VfxHeatParticle 		= "gunsmoke"
SWEP.VfxHeatThreshold 		= 0.5

SWEP.ProjectileOffset 		= Vector( 6, -2 )
SWEP.ProjectileOffsetNPC 	= Vector( -1, -1 )

SWEP.ReloadSND				= "scifi.wasp.reload" 
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadOnTrigger 		= false
--SWEP.ReloadRealisticClips 	= false
SWEP.ReloadTime 			= 1.4

SWEP.AdsFov 				= 50
SWEP.AdsTransitionSpeed		= 24
SWEP.AdsPos 				= Vector( -3.45, 1, 0 )
SWEP.AdsAng 				= Angle( 0, 0, 2 )

SWEP.SprintSwayScale		= 4
SWEP.SprintBobScale			= 0
SWEP.SprintAnimSpeed		= 12

SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 2
SWEP.ViewModelSprintAng		= Angle( -10, -2, -5 )
SWEP.ViewModelDuckPos		= Vector( 0.1, -2, 1 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -5 )
SWEP.ViewModelMeleePos		= Vector( 12, 4, -22 )
SWEP.ViewModelMeleeAng		= Angle( 60, 35, -4 )

SWEP.ViewModelSprintPos 	= Vector( 4, 2, -24 )
SWEP.ViewModelSprintAng		= Angle( 50, 0, 5 )
SWEP.ViewModelSwayDirection = Vector( 1, 6, 0 )
SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( -0.05, -0.1, 0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.1, 0 )

SWEP.SprintAnimIdle			= true

SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -1.5, -4, -4 )
SWEP.ViewModelReloadAng		= Angle( 10, -4, 12 )

SWEP.SciFiFamily			= { "vtec", "phys" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 4, +4", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		128", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Blight", color = Color( 215, 160, 255 ) },
	["4"] = { text = "Clip size: 					15", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 2.4 (burst-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Flechettes will stick to the first surface hit and explode shortly after impact.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "The explosion's damage and range increases, if more then one flechette is pinned on a single target.", color = Color( 180, 180, 180 ) },
--	["8"] = { text = "... From the ashes they will rise ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "4, 4",
		DamageAmount = 8,
		DamageBlastRadius = 128,
		DamageType = { DMG_BULLET, DMG_SF_BLIGHT },
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.12 }, 
			{ RateTitle = "burst", RateDelay = 0.24 }
		},
	},
	ClipSize = 15,
	ReloadSpeed = 1.4,
	Recoil = 6,
	PerkSet = { SCIFI_PERK_AMMO_DELAYEDEXPLOSION, SCIFI_PERK_AMMO_STICKYGRENADES }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 2.8, -1, 7 ), angle = Angle( 0, -2, 0 ) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1.4, -4.4 ), angle = Angle( 0, 2, 12 ) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle(10, -10, -50) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector(-7, -0.5, 3.5), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -0.1 ), angle = Angle( 1, 0, 0 ) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, -15, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, -15, 0) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5, 10, 0) }
}

SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.4, 0.3, -0.1), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.25, 0.4, 4), angle = Angle(110, 90, 0), size = Vector(0.05, 0.037, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["0b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.25, -1.75, 4), angle = Angle(110, -90, 0), size = Vector(0.05, 0.037, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.8, 2, 5), angle = Angle(0, -180, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["6a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(1, -1, 4), angle = Angle(-85, 20, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} },
	["6b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(1, 0.5, 3), angle = Angle(-80, 10, 0), size = Vector(0.3, 0.4, 0.4), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} },
	["6c"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, -1, 4), angle = Angle(-95, -20, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} },
	["6d"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, 0.5, 3), angle = Angle(-110, -10, 0), size = Vector(0.3, 0.4, 0.4), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.22, -0.6, 6), angle = Angle(20, 90, 0), size = Vector(0.12, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/organics", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/mortarsynth.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.22, -1.2, -1.2), angle = Angle(90, 90, 180), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/front", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.62, -1.4, 1.2), angle = Angle(-78.888, -22, -100), size = Vector(1.05, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_nosegun.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.5, 0, 7), angle = Angle(88, 45, 50), size = Vector(0.1, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/barrel", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.2, -1.4, 0.5), angle = Angle(0, -90, 180), size = Vector(0.06, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.2, 2, -3), angle = Angle(5, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.1, 0.4, 4), angle = Angle(110, 90, 0), size = Vector(0.05, 0.037, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["0b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.1, -1.75, 4), angle = Angle(110, -90, 0), size = Vector(0.05, 0.037, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.8, 2, 5), angle = Angle(0, -180, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.22, -0.6, 6), angle = Angle(20, 90, 0), size = Vector(0.12, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/organics", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/mortarsynth.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.22, -1.2, -1.2), angle = Angle(90, 90, 180), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/front", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.62, -1.4, 1.2), angle = Angle(-78.888, -22, -100), size = Vector(1.05, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_nosegun.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.2, -0.5, 8), angle = Angle(90, 50, 25), size = Vector(0.1, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/barrel", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.2, -1.4, 0.5), angle = Angle(0, -90, 180), size = Vector(0.06, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} }
}

SWEP.DataTables = {
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Bool", dName = "CanBurst" },
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Int", dName = "BurstCount" }
}

function SWEP:SubInit()

	self:SetBurstMode( true )
	
end

local stock_hpos = Vector(-0.22, -1.2, -1.2)
local fStockOffset = 0
local fTimeOffset = 0

local cmd_particles = GetConVar( "sfw_fx_particles" )

local dState
local vmEntity, vmAttach
function SWEP:Think()

	if ( self.SciFiState == SCIFI_STATE_ADS && dState ~= self.SciFiState ) then
		self:SetHoldType( "revolver" )
	end
	
	if ( dState == SCIFI_STATE_ADS && dState ~= self.SciFiState ) then
		self:SetHoldType( self.HoldType )
	end
	
	local fNextPFire = self:GetNextPrimaryFire() - ( CurTime() + FrameTime() )
	fNextPFire = fNextPFire * self.ChargeDeltaFactor

	if !( self.SciFiState == SCIFI_STATE_RELOADING ) && ( fNextPFire > 0 ) && ( self:Clip1() > 0 ) then
		local bParticles = cmd_particles:GetBool()

		if ( fNextPFire > 0.05 && fNextPFire < 0.07 ) then
			fStockOffset = Lerp( FrameTime() * 16, fStockOffset, 1 )
		end
		
		if ( fNextPFire < 0.03 ) then
			fStockOffset = Lerp( FrameTime() * 16, fStockOffset, 0 )
		end

		local stock = self.VElements[ "8" ]
		stock.pos = stock_hpos + Vector( 0, 0, -4 ) * fStockOffset
	end
	
	if ( SERVER || !game.SinglePlayer() ) then
		local fNextPFire = self:GetNextPrimaryFire()
		
		if ( self:CanBFire() ) && ( fNextPFire < CurTime() && fNextPFire > -1 ) then
			if ( self:GetBurstCount() <= 3 && self:GetCanBurst() ) && ( fNextPFire ~= -1 ) then
				self:Attack()
				
				if ( self:GetBurstCount() >= 4 ) then return end
				
				self:SetCanBurst( true )
				self:SetBurstCount( self:GetBurstCount() + 1 )

				self:SetNextPrimaryFire( CurTime() + 0.07 )
			end
			
			if ( self:GetBurstCount() >= 3 ) then
				self:SetNextPrimaryFire( CurTime() + 0.24 )
				self:SetCanBurst( false )
				self:SetBurstCount( 0 )
			end
		end	
	end

	dState = self.SciFiState
	
	self:Anims()
	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( event == 21 || event == 22 || event == 6001 ) then
		return true
	end

end

function SWEP:CanBFire()

	if ( self.Weapon:Clip1() <= 0 ) then
		self:SetBurstCount( 3 )
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		self:SetNextPrimaryFire( CurTime() + 0.1 )
		return false
	end

	return true
	
end

function SWEP:Attack()

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	if ( SERVER ) then
		local ent = ents.Create( "hornet_pfire" )
		if ( !IsValid( ent ) ) then return end
		if (self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( pOwnerSP + ( pOwnerAV * 8 ) )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local vSpread = self:GetProjectileSpreadVector() * ( 2 + self:GetSciFiACC() ) + Vector( 0, 0, 2 ) * self:GetSciFiACC()
		if( self.Owner:IsNPC() ) then
			vSpread = Vector( 0, 0, 0 )
		end

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * 6400 + vSpread )
		phys:EnableGravity( true )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.8, -1.2 ), 0, 0 ) * ( 1 + self:GetSciFiACC() * 0.05 ) )
		self:AddSciFiACC( 6 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.hornet.pfire" )
	self:EmitSound( "scifi.solaris.echo" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:PrimaryAttack()
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	if ( self:GetBurstMode() ) && ( self.Owner:IsPlayer() ) then
		if ( self:GetBurstCount() >= 4 ) then return end
		
		self:SetCanBurst( true )
	else
		self:Attack()
	
		self:SetNextPrimaryFire( CurTime() + 0.12 )
	end
	
end

function SWEP:SecondaryAttack()

	self:SetNextSecondaryFire( CurTime() + 0.5 )
	
	if ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetBurstMode() ) then 
			self:SetBurstMode( false )
		else
			self:SetBurstMode( true )
		end
		self:EmitSound( "Weapon_Shotgun.Empty" )
	end

end

function SWEP:OnReload()

end

function SWEP:OnReloadFinish()

	self:SetSciFiACC( 0 )

	self:SendWeaponAnim( ACT_VM_IDLE )

	self:SetCanBurst( false )

end