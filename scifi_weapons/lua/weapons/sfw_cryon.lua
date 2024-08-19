AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Freeze your victims."
SWEP.Instructions			= "Mouse1 to throw, mouse2 to roll."
SWEP.ItemRank 				= 15

SWEP.ViewModel				= "models/weapons/c_scifind.mdl"
SWEP.WorldModel				= "models/weapons/w_grenade.mdl"
SWEP.HoldType 				= "grenade"
SWEP.HoldTypeSprint			= "normal"
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiSkin_2			= "vgui/white"
SWEP.SciFiSkin_3			= "vgui/white"
SWEP.SciFiSkin_4			= "vgui/white"
SWEP.SciFiWorld				= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_cryon.vmt" )
end

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "grenade"

SWEP.PrintName				= "T3i 'Cryon' ice grenade"
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.ViewModelSprintPos		= Vector( 1.8, 0.2, 0.8 )
SWEP.ViewModelSprintAng		= Angle( -10, -8, 0 )
SWEP.SprintAnimIdle			= false
SWEP.ViewModelShift = false

SWEP.ViewModelMeleePos		= Vector( 6, 2, -6 )
SWEP.ViewModelMeleeAng		= Angle( 18, 40, -45 )

SWEP.SciFiFamily			= { "elemental", "phys", "noads", "autoreload", "grenade" }

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "16 + 60",
		DamageAmount = 76,
		DamageBlastRadius = 320,
		DamageType = { DMG_RADIATION, DMG_SF_ICE }
	},
	ReloadSpeed = 1.0,
	PerkSet = { SCIFI_PERK_ELEMENTAL_ICE, SCIFI_PERK_AMMO_RADIATION }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0, -0.101, 3), angle = Angle(180, 0, 0), size = Vector(0.54, 0.54, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/cryo_nade.vmt", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5, 2, 3.5), angle = Angle(-180, 0, 0), size = Vector(0.54, 0.54, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/cryo_nade", skin = 0, bodygroup = {} }
}

local activate = Sound( "npc/turret_floor/click1.wav" )
local active = true

if ( CLIENT ) then

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	
	if ( self.Primary.ClipSize > -1 ) then
		self.AmmoDisplay.PrimaryClip = self.Owner:GetAmmoCount( self.Primary.Ammo )
		self.AmmoDisplay.PrimaryAmmo = -1
		self.AmmoDisplay.SecondaryClip = -1
		self.AmmoDisplay.SecondaryAmmo = -1
	end
	
	return self.AmmoDisplay
	
end

end

function SWEP:Equip( NewOwner )

	if ( self.Owner:IsPlayer() && GetConVarNumber( "cl_showhints" ) == 1 ) then
		if ( !table.HasValue( self.Owner:GetWeapons(), "sfw_" ) ) then
		self.Owner:SendHint( "sfw_remi_dmgamp", 0.05 )
		end
		
		if ( !table.HasValue( self.Owner:GetWeapons(), "sfw_" ) ) then
		self.Owner:SendHint( "sfw_remi_melee", 0.45 )
		end
		
		if ( !self:IsFamily( "nomelee" ) ) then
			self.Owner:SendHint( "sfw_passivemelee", 0.05 )
		end
	end
	
	if ( NewOwner:IsNPC() ) then
		self:SetNWBool( "MobDrop", true )
		if ( self.SciFiWorld ~= nil && self.SciFiWorld ~= "" ) then
			self:SetMaterial( self.SciFiWorld )
		end
	end

	if ( self.Owner:IsPlayer() ) then
		if ( GetConVarNumber( "vh_campaign" ) == 0 ) then
			self.Owner:GiveAmmo( self.Primary.ClipSize * 8, self.Primary.Ammo )
		else
			self.Owner:GiveAmmo( 1, self.Primary.Ammo )
		end
	end

end

function SWEP:Think()

	local lmb = self.Owner:KeyDown( IN_ATTACK )
	local rmb = self.Owner:KeyDown( IN_ATTACK2 )

	if ( game.SinglePlayer() && SERVER || !game.SinglePlayer() ) then
		if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
			if ( self:GetNextPrimaryFire() < CurTime() ) then
				if ( self.Owner:KeyPressed( IN_ATTACK ) && !rmb ) then 
					self:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
					active = true
				end

				if ( self.Owner:KeyReleased( IN_ATTACK ) && !rmb ) && ( active ) then 
					self:NadeThrow()
				end
			end
			
			if ( self:GetNextSecondaryFire() < CurTime() ) then
				if ( self.Owner:KeyPressed( IN_ATTACK2 ) && !lmb ) then 
					self:SendWeaponAnim( ACT_VM_PULLBACK_LOW )
					active = true
				end

				if ( self.Owner:KeyReleased( IN_ATTACK2 ) && !lmb ) && ( active ) then 
					self:NadeRoll()
				end
			end
		else
			self:SendWeaponAnim( ACT_VM_HOLSTER )
		end
	end
	
	if ( active ) && ( self:GetAnimNextIdle() < CurTime() ) then
		self:SetAnimNextIdle( CurTime() + 1 )
	end

	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:frag( speed ) 

	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
		local pOwnerEA = self.Owner:EyeAngles()
		local up = pOwnerEA:Up()
		
		local ent = ents.Create( "sfw_cryon_ent" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( pOwnerEA + Angle( math.random( 10, 80 ), 40, 0 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( up * speed * 0.1 + self.Owner:GetAimVector() * speed )
		phys:AddAngleVelocity( up * speed )
	end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:RemoveAmmo( 1, self.Primary.Ammo )

end

function SWEP:NadeThrow()

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 1.2 )
	self:SetNextSecondaryFire( CurTime() + 1.2 )
	
	self:frag( 8600 )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_THROW )
	
	active = false
		
	self:PreNadeReload()

end

function SWEP:NadeRoll()

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 1 )
	self:SetNextSecondaryFire( CurTime() + 1 )
	
	self:frag( 1600 )
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	
	active = false
		
	self:PreNadeReload()

end

function SWEP:PrimaryAttack()
	
end

function SWEP:SecondaryAttack()

end

function SWEP:PreNadeReload()

	timer.Simple( 0.7, function()
		if ( IsValid( self ) && IsValid( self.Owner ) ) then
			local pWeapon = self.Owner:GetActiveWeapon()
			if ( !IsValid( pWeapon ) ) then return end
			
			if ( pWeapon:GetClass() ~= self:GetClass() ) then
				self:NadeReloadSilent()
			else
				self:NadeReload()
			end
		end
	end )

end

function SWEP:NadeReload()

	if ( self.Owner:IsPlayer() ) then
		if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
			if ( self.Owner:IsPlayer() ) then
				self:EmitSound( activate )
			end
		end
	else
		if ( self.Owner:IsNPC() ) then
			self.Weapon:SetClip1( self.Primary.ClipSize )
			self:EmitSound( activate )
		end
	end
	
end

function SWEP:NadeReloadSilent()

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		if ( self.Owner:IsPlayer() ) then
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo )
		end
	end
	
	if ( self.Owner:IsNPC() ) then
		self.Weapon:SetClip1( self.Primary.ClipSize )
	end

end

function SWEP:Reload()
	
end