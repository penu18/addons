AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.PrintName				= "AQM 'Lapis' Pistol"
SWEP.Purpose				= "A simple, yet efficient energy pistol commonly used by Calhan security personnel and mandatory in any Calhan warrior's basic weaponry."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to aim down sights."
SWEP.ItemRank 				= 6

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
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.HoldType 				= "pistol"
SWEP.HoldTypeSprint			= "normal"
SWEP.HoldTypeNPC 			= "pistol"
SWEP.DeploySpeed 			= 1.6

SWEP.Primary.ClipSize		= 24
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.VfxMuzzleAttachment 	= "Muzzle"
SWEP.VfxMuzzleParticle 		= "_wraithgun_muzzle"
SWEP.VfxMuzzleColor 		= Color( 80, 70, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 620

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.1
SWEP.NPCAccuracy 			= 1000
SWEP.NPCSkillLevel 			= 2
SWEP.NPCAimVectorOverride 	= Vector( 0, 0, 0 )
SWEP.NPCBulletSpread 		= 4
SWEP.NPCRestMin 			= 0.3
SWEP.NPCRestMax 			= 0.6
SWEP.NPCBurstMin 			= 1
SWEP.NPCBurstMax 			= 2
SWEP.NPCBurstDelay 			= 0.2

SWEP.ProjectileOffset 		= Vector( 6, -2 )
SWEP.ProjectileOffsetNPC 	= Vector( -1, -1 )

SWEP.DepletedSND			= "scifi.storm.dryfire"
SWEP.ReloadSND				= "Weapon_SMG1.Reload" 
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadOnTrigger 		= false
--SWEP.ReloadRealisticClips 	= false
SWEP.ReloadTime 			= 1.4

SWEP.AdsFov 				= 50
SWEP.AdsTransitionSpeed		= 24
SWEP.AdsPos 				= Vector( -3.2, 1, 1.8 )
SWEP.AdsAng 				= Angle( 0, 0, 2 )

SWEP.ViewModelSprintPos		= Vector( -2, 1, -1 )
SWEP.ViewModelSprintAng		= Angle( -10, -2, -5 )
SWEP.ViewModelSprintSway 	= 0.8
SWEP.ViewModelSwayDirection = Vector( -0.4, 16, 0.1 )
SWEP.ViewModelDuckPos		= Vector( 0.1, -2, 1 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -5 )
SWEP.ViewModelMeleePos		= Vector( 12, 4, -22 )
SWEP.ViewModelMeleeAng		= Angle( 60, 35, -4 )

SWEP.SprintAnimIdle			= true
SWEP.ViewModelShift = false

SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -1.5, -4, -4 )
SWEP.ViewModelReloadAng		= Angle( 10, -4, 12 )

SWEP.SciFiFamily			= { "vtec", "phys" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 10", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x2", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Energy", color = Color( 80, 180, 255 ) },
	["4"] = { text = "Clip size: 					24", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				4 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Pew, pew, pew!", color = Color( 180, 180, 180 ) },
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 10,
		DamageType = DMG_SF_VAPOR,
		CritMul = 2,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.15 }, 
		},
	},
	ClipSize = 24,
	ReloadSpeed = 1.4,
	Recoil = 6,
	PerkSet = { SCIFI_PERK_AMMO_HIGHCAL }
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
--[[
SWEP.VElements = {
	["gun"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dpfilms/weapons/w_neophron.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.4, 4, 0.2), angle = Angle(0, 0, -92), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}
]]--
SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.4, 0.3, -0.1), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-1, 0.4, 6), angle = Angle(180, 90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["0b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.6, -1.75, 6), angle = Angle(180, -90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.8, 2, 5), angle = Angle(0, -180, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/obsidian_barrel.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.22, -0.6, 2), angle = Angle(0, 0, 90), size = Vector(0.25, 0.3, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/stalkerpod_lid.mdl", bone = "Base", rel = "parent", pos = Vector(-0.22, -1.2, -1.2), angle = Angle(-90, 90, 0), size = Vector(0.3, 0.2, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lapis_casing", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.62, -1.4, 1.2), angle = Angle(-78.888, -22, -100), size = Vector(1.05, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.2, -1.4, 0.5), angle = Angle(0, -90, 180), size = Vector(0.06, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.2, 2, -3), angle = Angle(5, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-1, 0.4, 6), angle = Angle(180, 90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["0b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.6, -1.75, 6), angle = Angle(180, -90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.6, 2, 5), angle = Angle(0, -180, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/obsidian_barrel.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.22, -0.6, 2), angle = Angle(0, 0, 90), size = Vector(0.25, 0.3, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/stalkerpod_lid.mdl", bone = "Base", rel = "parent", pos = Vector(-0.22, -1.2, -1.2), angle = Angle(-90, 90, 0), size = Vector(0.3, 0.2, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lapis_casing", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.62, -1.4, 1.2), angle = Angle(-78.888, -22, -100), size = Vector(1.05, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.2, -1.4, 0.5), angle = Angle(0, -90, 180), size = Vector(0.06, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} }
}

local stock_hpos = Vector(-0.25, -1.2, -1.2)
local fStockOffset = 0
local fTimeOffset = 0

local cmd_particles = GetConVar( "sfw_fx_particles" )

local dState
local vmEntity, vmAttach
function SWEP:Think()

	local bAds = self:GetSciFiState() == SCIFI_STATE_ADS
	
	if ( bAds ) then
		local fNextPrimaryFire = self:GetNextPrimaryFire() - CurTime()
		
		if ( fNextPrimaryFire > 0 ) && ( self:Clip1() > 0  ) then
			local fAnimationScale = ( fNextPrimaryFire / 0.15 )
			self.AdsPos.x = -3.4 + 2 * fAnimationScale
			self.AdsPos.z = 0.4 - 4.5 * fAnimationScale
			self.AdsAng.pitch = -5 * fAnimationScale
			self.AdsAng.roll = 15 * fAnimationScale
			
			local aPunch = self.Owner:GetViewPunchAngles()
			self.Owner:SetViewPunchAngles( aPunch * ( 0.85 + fAnimationScale * 0.15 ) )
		else
			self.AdsPos.x = -3.4
			self.AdsPos.z = 0.4
			self.AdsAng.pitch = 0
			self.AdsAng.roll = 2
		end
	end

	if ( bAds && dState != self:GetSciFiState() ) then
		self:SetHoldType( "revolver" )
	end
	
	if ( dState == SCIFI_STATE_ADS && dState != self:GetSciFiState() ) then
		self:SetHoldType( self.HoldType )
	end
	
	local fNextPFire = self:GetNextPrimaryFire() - ( CurTime() + FrameTime() )
	fNextPFire = fNextPFire * self.ChargeDeltaFactor

	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
		local bParticles = cmd_particles:GetBool()
		if ( CLIENT ) && ( bParticles ) && !( dState == SCIFI_STATE_RELOADING ) then			
			if ( self.Owner:ShouldDrawLocalPlayer() ) then
				vmEntity = self || self.Owner:GetActiveWeapon()
			else
				vmEntity = self.Owner:GetViewModel()
			end
			
			vmAttach = vmEntity:LookupAttachment( "muzzle" )
			
			vmEntity:SetSequence( "reload" )
			
			ParticleEffectAttach( "lapis_vent", PATTACH_POINT_FOLLOW, vmEntity, vmAttach )
		end
	
		if ( fNextPFire > 1.2 && fNextPFire < 1.4 ) then
			fStockOffset = Lerp( FrameTime() * 8, fStockOffset, 1 )
		end
		
		if ( fNextPFire < 0.2 ) then
			fStockOffset = Lerp( FrameTime() * 8, fStockOffset, 0 )
		end
		
		local stock = self.VElements[ "8" ]
		
		stock.pos = stock_hpos + Vector( 0, 0, -2 ) * fStockOffset
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

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0 ) ) then 
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		
		return 
	end

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	if ( SERVER ) then
		local ent = ents.Create( "lapis_pfire" )
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
		
		local vSpread = self:GetProjectileSpreadVector() * ( 1 + self:GetSciFiACC() ) + Vector( 0, 0, 1 ) * self:GetSciFiACC()
		if( self.Owner:IsNPC() ) then
			vSpread = Vector( 0, 0, 0 )
		end

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * 7200 + vSpread )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.4, -0.6 ), 0, 0 ) * ( 1 + self:GetSciFiACC() * 0.05 ) )
		self:AddSciFiACC( 6 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.wraithshot.fire" )
	self:EmitSound( "scifi.wraithshot.fire.echo" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self:TakePrimaryAmmo( 1 )

	self:SetNextPrimaryFire( CurTime() + 0.15 )

end

function SWEP:OnReload()

end

function SWEP:OnReloadFinish()

	if ( !game.SinglePlayer() && CLIENT ) || ( SERVER ) then
		self:EmitSound( "scifi.asa6.reload.bback" )
	end

end