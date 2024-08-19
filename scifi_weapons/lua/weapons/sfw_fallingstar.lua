AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "A festive take on an old friend. The 'Falling Star' either roasts enemies with intense radiation or causing an energetic disruption, entangling targets."
SWEP.Instructions			= "Mouse1 to fire. 'Use' (def. 'E') + Mouse1 for altfire. (Keep your distance...)"
SWEP.ItemRank 				= 25

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.SciFiSkin				= "/models/weapons/hwave/skin" --"/models/weapons/vapor/skin.vmt"
SWEP.SciFiSkin_1			= "/models/weapons/fallingstar/vapor_core.vmt"
SWEP.SciFiWorld 			= "/models/weapons/shared/ar2_vtsteel.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.Ammo			= "AR2AltFire"

SWEP.VfxMuzzleParticle 		= "fstar_muzzle"
SWEP.VfxMuzzleColor 		= Color( 120, 180, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 720

SWEP.PrintName				= "ARX.2 'Falling Star' cannon"
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.AdsPos 				= Vector( -3, -1, 1 )
SWEP.AdsAng 				= Vector( 0, 0, -4 )
SWEP.AdsFov					= 60
SWEP.AdsTransitionSpeed		= 8

SWEP.SciFiMeleeASpeed		= 0.82
SWEP.SciFiMeleeRange		= 64
SWEP.SciFiMeleeDamage		= 10
SWEP.SciFiMeleeSound		= "scifi.melee.swing.heavy"

SWEP.SciFiFamily			= { "vtec", "elemental", "phys", "noads", "autocharge" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 8, +12", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		64", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: Blight", color = Color( 215, 160, 255 ) },
	["3a"] = { text = "Status Chance: 5%", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Clip size: 				 30", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				5.5 (full-auto)", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Alt. damage: 	 40", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Alt. range: 			300 units", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Alt. damage type: Entangling Blight", color = Color( 215, 160, 255 ) },
	["9a"] = { text = "Status Chance: 100%", color = Color( 180, 180, 180 ) },
	["9b"] = { text = "'Entangles' targets in range, pinning them down for a brief amount of time.", color = Color( 180, 180, 180 ) },
	["9c"] = { text = "Altfire consumes 15 ammo.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "8, 12",
		DamageAmount = 20,
		DamageBlastRadius = 64,
		DamageType = DMG_SF_BLIGHT,
		StatusChance = 5,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.18 }
		},
	},
	Secondary = {
		DamageAmount = 40,
		DamageBlastRadius = 300,
		DamageType = DMG_SF_BLIGHT,
		StatusChance = 100,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 1.4 },
		}
	},
	ClipSize = 30,
	ReloadSpeed = 2.2,
	Recoil = 3.2,
	PerkSet = { SCIFI_PERK_ELEMENTAL_BLIGHT, SCIFI_PERK_TARGETING_SMART }
}

SWEP.ReloadSND				= "scifi.vapor.reload"

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1.6, -0.8 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(-1.275, -1.457, 22.207), angle = Angle(180, -1.385, 0), size = Vector(0.082, 0.058, 0.082), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(0.966, 2.381, 22.207), angle = Angle(180, -180, 0), size = Vector(0.082, 0.058, 0.082), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "Base", rel = "", pos = Vector(0.26, -0.15, 15.756), angle = Angle(0, 0, 0), size = Vector(0.0125, 0.0125, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt2", rel = "", pos = Vector(0.157, 1.251, 0), angle = Angle(0, -90, 0), size = Vector(0.219, 0.219, 0.219), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01a.mdl", bone = "Base", rel = "", pos = Vector(-0.5, 0.3, 17.5), angle = Angle(0, 0, 180), size = Vector(0.052, 0.052, 0.052), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_dispenser.mdl", bone = "Base", rel = "", pos = Vector(0.239, -0.143, 6.986), angle = Angle(0, 0, 180), size = Vector(0.078, 0.068, 0.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/capacitor", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "Base", rel = "", pos = Vector(0, 2, 16), angle = Angle(90, 90, 0), size = Vector(0.0175, 0.0175, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/vtech_case", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "Base", rel = "", pos = Vector(0.26, -0.15, 13.756), angle = Angle(0, 180, 0), size = Vector(0.125, 0.125, 0.125), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "Base", rel = "", pos = Vector(-0.792, -2.254, 7.5), angle = Angle(0, 0, 0), size = Vector(0.046, 0.05, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "Base", rel = "", pos = Vector(0.449, -2.254, 6.5), angle = Angle(180, 0, 0), size = Vector(0.046, 0.05, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(24.287, 2.025, -5.342), angle = Angle(0, -90, 75), size = Vector(0.09, 0.07, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(23.086, -0.392, -10.235), angle = Angle(180, -90, 102.416), size = Vector(0.09, 0.07, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/lowerbarrel", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.165, 0.647, -8.046), angle = Angle(-180, -90, 105), size = Vector(0.046, 0.05, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.165, -0.216, -8.046), angle = Angle(180, 94.675, 75), size = Vector(0.046, 0.05, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/fallingstar/case", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14, 0.959, -4), angle = Angle(-12, 0, 0), size = Vector(0.017, 0.017, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/vtech_case", skin = 0, bodygroup = {} }
}

function SWEP:Think()

	if ( CLIENT ) then
		
		if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
		self.VElements[ "1" ].angle = self.VElements[ "1" ].angle + Angle( 0, -( self:Clip1() / 3.5 ), 0 )
		end
	
		if ( self.Owner:KeyDown( IN_ATTACK ) == true ) and ( self.SciFiState == SCIFI_STATE_RELOADING == false ) then
		self.VElements[ "1" ].angle = self.VElements[ "1" ].angle + Angle( 0, 2 + 1 * ( self:GetSciFiACC() / 10 ), 0 )
		end
		
		self.VElements[ "7" ].angle = self.VElements[ "7" ].angle + Angle( 0, 2, 0 )
		
	end

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:AltFire()

	-- if (  !self:CanPrimaryAttack( 14 ) ) then return end
	if ( self.Owner:GetAmmoCount( self.Secondary.Ammo ) < 1 ) then 
		self:EmitSound( self.DepletedSND )
		self:SetNextPrimaryFire( CurTime() + 0.16 )
		return 
	end
	
	self:SetNextPrimaryFire( CurTime() + 1.4 )
	
	local viewmodel = self:GetViewModelEnt()
	ParticleEffectAttach( "fstar_charge", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	
	if ( SERVER ) then
		if ( IsValid( self.Owner ) ) then
			local fx2 = ents.Create( "light_dynamic" )
			if ( !IsValid( fx2 ) ) then return end
			fx2:SetKeyValue( "_light", "120 200 255 255" )
			fx2:SetKeyValue( "spotlight_radius", 180 )
			fx2:SetKeyValue( "distance", 240 )
			fx2:SetKeyValue( "brightness", 1 )
			fx2:SetKeyValue( "style", 1 )
			fx2:SetPos( viewmodel:GetAttachment( viewmodel:LookupAttachment( "Muzzle" ) ).Pos )
			fx2:SetParent( self )
			fx2:Spawn()
			fx2:Fire( "Kill", "", 0.7 )
		end
	end
	
	self:SendWeaponAnim( ACT_VM_FIDGET )
	
	self:EmitSound( "scifi.fstar.altfirecharge" )
	
	timer.Create( "awesomechargefx", 0.7, 1, function()
	
		if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end

		self:EmitSound( "scifi.fstar.altfireshoot" )
		
		if ( SERVER ) then
	
			local ent = ents.Create( "fstar_sfire" )
			if ( !IsValid( ent ) ) then return end
			if ( self:GetSciFiState() == SCIFI_STATE_ADS ) then
				ent:SetPos( self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 12 ) )
			else
				ent:SetPos( self:GetProjectileSpawnPos() )
			end
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( self.Owner:GetAimVector() * 7200 )
			
		end
		
		-- self:TakePrimaryAmmo( 15 )
	
		self.Owner:RemoveAmmo( 1, self.Secondary.Ammo )
		
		local viewmodel = self.Owner:GetViewModel()
		ParticleEffectAttach( "fstar_muzzle_altfire", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( -4, 0, 0 ) )
		end
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		
		self:AddSciFiACC( 20 )
		
		timer.Remove( "awesomechargefx" )
		
	end )
	
end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsPlayer() && self.Owner:KeyDown( IN_USE ) ) then
		self:AltFire()
		return
	end

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.18 )
	
	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
	
		local ent = ents.Create( "fstar_pfire" )
		if ( !IsValid( ent ) ) then return end
		if ( self:GetSciFiState() == SCIFI_STATE_ADS ) then
			ent:SetPos( self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 12 ) )
		else
			ent:SetPos( self:GetProjectileSpawnPos() )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 600 + self:GetProjectileSpreadVector() * ( self:GetSciFiACC() * 1.5 ) )
		
	end
	
	if ( self.Owner:IsPlayer() ) then
	
		self.Owner:ViewPunch( Angle( math.random( -1.25, -2 ), math.random( 0, 0.418 ), math.random( 0, 0.418 ) ) * ( self:GetSciFiACC() * 0.05 ) )
		
		self:AddSciFiACC( 3.2 )
		
	end
	
	self:DoMuzzleEffect()
	
	self:EmitSound( "scifi.fstar.fire1" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
	
end

----------------------------------------------------------------------------------------------------------
---##------##----####----------#######-------######------#######-----########----########------########---
----##----##--------##---------##----##-----##----##-----##----##-------##-------##-----------##----------
-----##--##--------####--------#######-----##------##----#######--------##-------######------##-----------
------####--------##--##-##----##-----------##----##-----##---##--------##-------##-----------##----------
-------##--------##----###-----##------------######------##----##-------##-------########------########---
----------------------------------------------------------------------------------------------------------