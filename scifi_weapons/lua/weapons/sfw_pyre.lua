AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "The 'Pyre' launches a HS200-X grenade that explodes shortly after coming into contact with a surface or immediately after touching a target or water."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to aim."
SWEP.ItemRank 				= 24

SWEP.ViewModel				= "models/weapons/c_scifixbo.mdl"
SWEP.WorldModel				= "models/weapons/w_crossbow.mdl"
SWEP.HoldType 				= "shotgun"
SWEP.DeploySpeed 			= 3.8

SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_phurt.vmt" )
end

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "grenade"

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.15

SWEP.ReloadTime				= 1.85

SWEP.PrintName				= "HS200-X 'Pyre' grenade launcher"
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.AdsPos 				= Vector(-8.385, -8, 3.22)
SWEP.AdsFov					= 50
SWEP.ViewModelHomePos		= Vector( 0, 0, 0 )
SWEP.ViewModelMeleePos		= Vector( -2, -1, 4 )
SWEP.ViewModelMeleeAng		= Angle( -8, 10, -2 )

SWEP.SciFiFamily			= { "hwave", "phys", "ads", "autoreload" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 120, +60", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		180; 256", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Impact, Heat", color = Color( 180, 0, 20 ) },
	["4"] = { text = "Clip size: 					1", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 0.6", color = Color( 180, 180, 180 ) }
--	["8"] = { text = "... From the ashes they will rise ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "120, 60",
		DamageAmount = 180,
		DamageBlastRadius = 256,
		DamageType = { DMG_CLUB, DMG_BURN },
	},

	ClipSize = 1,
	ReloadSpeed = 2.2,
	PerkSet = { SCIFI_PERK_AMMO_CONTACTGRENADES, SCIFI_PERK_AMMO_SUPERHEATED }
}


SWEP.VElements = {
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_bts/rocket.mdl", bone = "ValveBiped.bolt", rel = "", pos = Vector(0, -0.18, 4.172), angle = Angle(90, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/black", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(-9, -79.848, 2.299), angle = Angle(0, 0, 90), size = Vector(1.509, 0.559, 1.294), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "", bone = "ValveBiped.Base", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(-0.2, -1.4, 1), angle = Angle(-18, 90, 0), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/capac", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(0, 4, 22), angle = Angle(0, 0, 180), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(-2.6, -0.6, 6), angle = Angle(0, 55, 0), size = Vector(0.045, 0.02, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["8a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(2, -1, 8), angle = Angle(0, -55, 0), size = Vector(0.045, 0.02, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.pull", rel = "", pos = Vector(0, 0, 2), angle = Angle(180, -90, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(0.3, -1.7, 5), angle = Angle(180, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["holo_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(-0.2, -3.48, 4), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_dots_arc", skin = 0, bodygroup = {} },
	["holo_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(-0.2, -3.48, 5), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_point", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(-0.2, -3.2, 4), angle = Angle(0, -90, 180), size = Vector(0.025, 0.025, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
--	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_bts/rocket.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, -0.18, 4.172), angle = Angle(90, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/black", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, -7.4, -82), angle = Angle(0, -79.5, 0), size = Vector(1.509, 0.559, 1.294), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 1.8, -4), angle = Angle(175, 20, 8), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "", bone = "ValveBiped.Base", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
--	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.005, 1, 5), angle = Angle(0, 0, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/capac", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19, -0.258, -0.422), angle = Angle(0, -80.5, 90), size = Vector(0.081, 0.081, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.75, -1.8, -3.3), angle = Angle(-90, 9.25, 0), size = Vector(0.045, 0.02, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["8a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 2.5, -4), angle = Angle(90, 10.25, 180), size = Vector(0.045, 0.02, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
--	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 2), angle = Angle(180, -90, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 1.25, -4.5), angle = Angle(0, 100, -90), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
--	["holo_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.2, -3.48, 4), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_dots_arc", skin = 0, bodygroup = {} },
--	["holo_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.2, -3.48, 5), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_point", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.64, -5.8), angle = Angle(85, 10, 0), size = Vector(0.025, 0.025, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

}

function SWEP:Equip()

	if ( self.Owner:IsNPC() ) or ( self.Primary.Ammo == "SciFiAmmo" ) then return end

	self.Owner:GiveAmmo( 32, self.Primary.Ammo )

end

function SWEP:PrimaryAttack()

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
--	self:SetNextPrimaryFire( CurTime() + 0.4 )

	if ( SERVER ) then
		local ent = ents.Create( "hwave_grenade" )
		if ( !IsValid( ent ) ) then return end		
		if (self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 20 ) )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 44560 + self.Owner:EyeAngles():Up() * 2560 )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.6, -2 ), math.random( -0.01, -0.1 ), math.random( -0.01, -0.1 ) ) )
		
		self:AddSciFiACC( 2.4 )
	end
		
	self:EmitSound( "scifi.hfire.fire1" )
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			
	self:TakePrimaryAmmo( 1 )
	self:Reload()
	
end

function SWEP:SecondaryAttack()
	
end

function SWEP:CanPrimaryAttack( cap, canunderwater )

	--if ( CLIENT ) then return end

	if ( self.Weapon:Clip1() <= cap ) then
		self:EmitSound( "Weapon_Pistol.Empty" )
		self:Reload()
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		if ( canunderwater == true ) then
			return true
		end
		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end
	
	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
		return false
	end
	
	if ( self.SciFiState == SCIFI_STATE_SPRINT ) and ( GetConVarNumber( "sfw_allow_advanims" ) >= 1 ) then
		return false
	end

	return true
	
end

function SWEP:Reload()

	if ( CLIENT ) then return end
	
	if ( !self:CanReload() ) then return end
	
	-- dat lazy animation schedule --
	self:EmitSound( "Weapon_Shotgun.Special1" )
	
	timer.Simple( 0.2, function() 
		if ( !IsValid( self ) ) then return end
		self:SendWeaponAnim( ACT_VM_RELOAD )
	end )
	
	timer.Simple( 1, function()
		if ( !IsValid( self ) ) then return end
	--	if ( self.SciFiState == SCIFI_STATE_SPRINT ) then return end
		self:EmitSound( "scifi.pele.bback" ) --"Weapon_Shotgun.Reload" )
		if ( self.Owner:IsPlayer() ) then
			self.SciFiState = SCIFI_STATE_RELOADING
			self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo )
			self.SciFiState = false
		end
	end )

	timer.Simple( 0.9, function()
		if ( !IsValid( self ) ) then return end
		self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
	end )
	
	self:SetNextPrimaryFire( CurTime() + self.ReloadTime )
	self:SetNextSecondaryFire( CurTime() + self.ReloadTime )
	
	if ( self.Owner:IsNPC() ) then
		self.Weapon:SetClip1( self.Primary.ClipSize )
	end
	
end