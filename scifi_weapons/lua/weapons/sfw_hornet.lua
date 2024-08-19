AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

local cmd_heat = GetConVarNumber( "sfw_fx_heat" )

SWEP.Purpose				= "The 'Hornet' is a medium flechette rifle. The crystalline bolts are highly volatile and will explode shortly after impact."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to aim down sights. 'Use' (def. 'E') + Mouse2 to switch firemodes. \nFlechette-damage increases, when used vs. a single target."
SWEP.ItemRank 				= 13

SWEP.PrintName				= "'Hornet' flechette rifle"
SWEP.Slot					= 2
SWEP.SlotPos				= 3

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.SciFiSkin				= "models/weapons/hornet/skin"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_edit.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.15

SWEP.VfxMuzzleParticle 		= "ngen_muzzle"
SWEP.VfxMuzzleColor 		= Color( 140, 120, 255, 180 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 512
SWEP.VfxHeatParticle 		= "gunsmoke"
SWEP.VfxHeatThreshold 		= 0.5

SWEP.SciFiFamily			= { "vtec", "elemental", "phys", "ads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 4, +4", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		128", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Blight", color = Color( 215, 160, 255 ) },
	["4"] = { text = "Clip size: 					40", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 15 (full-auto)", color = Color( 180, 180, 180 ) },
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
			{ RateTitle = "full-auto", RateDelay = 0.1 }, 
		},
	},
	Secondary = {
		DamageComposition = "4, 4 * 8",
		DamageAmount = 64,
		DamageBlastRadius = 128,
		DamageType = { DMG_BULLET, DMG_SF_BLIGHT },
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 1 }, 
		},
	},
	ClipSize = 15,
	ReloadSpeed = 1.4,
	Recoil = 6,
	PerkSet = { SCIFI_PERK_AMMO_DELAYEDEXPLOSION, SCIFI_PERK_AMMO_STICKYGRENADES }
}

SWEP.ReloadTime				= 1.8

SWEP.ReloadSND				= "scifi.hornet.reload" 

SWEP.AdsPos 				= Vector(-3.85, -6, 0.8)
SWEP.AdsFov					= 56
SWEP.ViewModelShiftOffset 	= Vector( 0.03, 0.075, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.3, 0.8 )
SWEP.ViewModelSprintPos		= Vector( 6, -1, 1 )
SWEP.ViewModelMeleePos		= Vector( 18, 8, -5 )
SWEP.ViewModelMeleeAng		= Angle( -10, 90, -85 )
SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -1, -5, -4 )
SWEP.ViewModelReloadAng		= Angle( 10, 1, -2 )

SWEP.SprintSwayScale		= 4
SWEP.SprintBobScale			= 0
SWEP.SprintAnimSpeed		= 8

SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelSprintSway 	= 3

-- Colors for holographic sight --
local color_visor_default = Color( 255, 255, 255, 255 ) 	-- default white
local color_visor_warning = Color( 210, 200, 255, 255 ) 		-- saturated red
local color_visor_error =  Color( 255, 10, 30, 255 )		-- decent yellow
local invisible = Color( 0, 0, 0, 0 )
local visible = Color( 220, 200, 255, 80 )

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 2.1, 0 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "Base", rel = "", pos = Vector(0, -1.415, 9.75), angle = Angle(-59.667, 90, 0), size = Vector(0.046, 0.046, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "Base", rel = "", pos = Vector(0, -2.039, 5.653), angle = Angle(66.966, 90, 180), size = Vector(0.037, 0.037, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "Base", rel = "", pos = Vector(0, 1.835, 10), angle = Angle(132, 90, 0), size = Vector(0.037, 0.03, 0.052), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/mortarsynth.mdl", bone = "Base", rel = "", pos = Vector(0, -1.04, 15.336), angle = Angle(80.971, -90, 0), size = Vector(0.195, 0.093, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/front", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "Base", rel = "", pos = Vector(0, -0.144, 9.335), angle = Angle(-45, 90, 0), size = Vector(0.111, 0.111, 0.111), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/organics", skin = 0, bodygroup = {} },
	["2+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "Base", rel = "", pos = Vector(0, -1.331, 7.572), angle = Angle(-45, 90, 0), size = Vector(0.071, 0.071, 0.071), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/organics", skin = 0, bodygroup = {} },
	["2++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "Base", rel = "", pos = Vector(0, -1.902, 5.04), angle = Angle(-50.709, 90, 0), size = Vector(0.075, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/organics", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_nosegun.mdl", bone = "Base", rel = "", pos = Vector(-1, 1, 18), angle = Angle(97.1, 90, 0), size = Vector(0.146, 0.215, 0.215), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/barrel", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "Base", rel = "", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "Base", rel = "", pos = Vector(-0.09, -0.098, 11.967), angle = Angle(0, 0, 0), size = Vector(0.375, 0.375, 0.467), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["2-1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_window001.mdl", bone = "base", rel = "", pos = Vector(0, -3.65, 3.5), angle = Angle(-120, -90, 0), size = Vector(0.012, 0.017, 0.007), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["2-2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_window001.mdl", bone = "base", rel = "", pos = Vector(0, -3.65, 4.5), angle = Angle(-120, -90, 0), size = Vector(0.012, 0.017, 0.007), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "Base", rel = "", pos = Vector(0, -0.819, 7.636), angle = Angle(90, 0, 0), size = Vector(0.465, 0.465, 0.465), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} },
	["6+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "Base", rel = "", pos = Vector(0.324, -0.466, 7.652), angle = Angle(97.632, 51.405, 0), size = Vector(0.465, 0.465, 0.465), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} },
	["6++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "Base", rel = "", pos = Vector(0, -0.09, 7.636), angle = Angle(99.35, 180, 71.299), size = Vector(0.465, 0.465, 0.465), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} },
	["6+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "Bolt2", rel = "", pos = Vector(-0.5, -0.45, -2), angle = Angle(90, 0, 0), size = Vector(0.665, 0.72, 0.72), color = Color(255, 255, 255, 128), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 0.6, -7.2), angle = Angle(-170, 0, 0), size = Vector(0.066, 0.066, 0.066), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5, 0.6, -6.4), angle = Angle(-30, 0, 180), size = Vector(0.057, 0.057, 0.052), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11, 0.6, -3.6), angle = Angle(20, 0, 0), size = Vector(0.05, 0.04, 0.062), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/case", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/mortarsynth.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 0.6, -9.75), angle = Angle(-5, 0, 180), size = Vector(0.105, 0.103, 0.129), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/front", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.6, -4.7), angle = Angle(0, 0, 0), size = Vector(0.141, 0.141, 0.141), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/organics", skin = 0, bodygroup = {} },
	["2+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.5, 0.6, -6), angle = Angle(0, 0, 0), size = Vector(0.081, 0.081, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/organics", skin = 0, bodygroup = {} },
	["2++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 0.6, -6.2), angle = Angle(-5, 0, 0), size = Vector(0.085, 0.085, 0.085), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/organics", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/gunship_gibs_nosegun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(17, -0.6, -6), angle = Angle(-7, 0, 0), size = Vector(0.156, 0.225, 0.225), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hornet/barrel", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.25, -5), angle = Angle(165, 10, 8), size = Vector(1.313, 1.113, 1.113), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/furniture_gibs/furnituretable001a_chunk06.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1, -5.4), angle = Angle(-10, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(220, 200, 255, 80), surpresslightning = true, material = "models/elemental/frozen_alpha", skin = 0, bodygroup = {} }
}

SWEP.DataTables = {
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Bool", dName = "CanBurst" },
	{ dType = "Int", dName = "BurstCount" }
}

function SWEP:Think()

	if ( game.SinglePlayer() && SERVER ) || ( CLIENT ) then
		local ammo  = self:Clip1()
		
		if ( ammo > 39 ) then
			self.VElements[ "6" ].color = visible
			self.VElements[ "6+" ].color = visible
			self.VElements[ "6++" ].color = visible
			self.VElements[ "6+++" ].color = visible
		end
		
		if ( ammo < 30 ) then
			self.VElements[ "6" ].color = invisible
		end
		
		if ( ammo < 20 ) then
			self.VElements[ "6+" ].color = invisible
		end
		
		if ( ammo < 10 ) then
			self.VElements[ "6++" ].color = invisible
		end
		
		if ( ammo < 1 ) then
			self.VElements[ "6+++" ].color = invisible
		end
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:GetProjectileAcceleration()

	local acc = 5600
	if ( self.Owner:WaterLevel() == 3 ) then
		acc = 2400
	end
	
	return acc

end

function SWEP:HornetFire()
	
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	if ( SERVER ) then
		local origin = self:GetProjectileSpawnPos()
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			origin = self.Owner:EyePos() + ( self.Owner:GetAimVector() * 20 )
		end
	
		local ent = ents.Create( "hornet_pfire" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( origin )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		-- ent.PhxGrav=false
		-- ent.MeteorEnabled=true
		-- ent.MeteorIgnoreworld=true
		-- ent.MeteorAlwaysTrack=false
		-- ent.MeteorNeverForget=true
		-- ent.MeteorHomingFactor=12
		-- ent.MeteorVelocityScale=4
		-- ent.MeteorVelocityInitial=1
		-- ent.PhxMaxVelocity = 1200
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local vSpread = self:GetProjectileSpreadVector()
		local iAcc = self:GetProjectileAcceleration()

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * iAcc + vSpread * ( iAcc / 1000 + self:GetSciFiACC() * 2 ) )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 3 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.hornet.pfire" )
	self:EmitSound( "scifi.solaris.echo" )
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:HornetBlast()
	
	if ( !self:CanPrimaryAttack( 7, true ) ) then return end

	if ( SERVER ) then
		local origin = self:GetProjectileSpawnPos()
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			origin = self.Owner:EyePos() + ( self.Owner:GetAimVector() * 20 )
		end
		
		for i=1, 8 do
			local ent = ents.Create( "hornet_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( origin )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local vSpread = VectorRand() * 0.1
			local iAcc = self:GetProjectileAcceleration() * 0.8
			
			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( ( self.Owner:GetAimVector() + vSpread ) * iAcc ) --* ( 1 + self:GetSciFiACC() * 2 ) )
		end
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -3.2, -4 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( 1 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 14 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.hornet.pfire" )
	self:EmitSound( "scifi.hornet.sfire" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self:TakePrimaryAmmo( 8 )

end

function SWEP:PrimaryAttack()
	
	if ( self:GetBurstMode() ) then
		self:HornetBlast()
		self:SetNextPrimaryFire( CurTime() + 1 )
	else
		self:HornetFire()
		self:SetNextPrimaryFire( CurTime() + 0.1 )
	end

end

function SWEP:SecondaryAttack()

	local key = self.Owner:KeyDown( IN_USE )

	if ( key ) then 
		if ( self:GetBurstMode() ) then
			self:SetBurstMode( false )
		else
			self:SetBurstMode( true )
		end
		
		self:SetNextPrimaryFire( CurTime() + 0.1 )
		self:SetNextSecondaryFire( CurTime() + 0.1 )
		
		self:EmitSound( "Weapon_Shotgun.Empty" )
--		self:EmitSound( "scifi.fathom.idle" )
	end
	
end