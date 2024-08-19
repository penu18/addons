AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.ItemRank 				= 11

SWEP.HoldType 				= "grenade"
SWEP.HoldTypeSprint			= "normal"

SWEP.ViewModel				= "models/weapons/c_scifind.mdl"
SWEP.WorldModel				= "models/weapons/w_grenade.mdl"
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiSkin_2			= "vgui/white"
SWEP.SciFiSkin_3			= "vgui/white"
SWEP.SciFiSkin_4			= "vgui/white"
SWEP.SciFiWorld				= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "grenade"

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.ViewModelSprintPos		= Vector( 1.8, 0.2, 0.8 )
SWEP.ViewModelSprintAng		= Angle( -10, -8, 0 )

SWEP.ViewModelMeleePos		= Vector( 6, 2, -6 )
SWEP.ViewModelMeleeAng		= Angle( 18, 40, -45 )

SWEP.PrintName				= "AEX VPR Grenade"
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.SprintAnimIdle			= false

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 			 600 + 8", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "AOE Range:		160", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type:  Charged Energy, Radiation", color = Color( 10, 220, 255 ) },
	["7"] = { text = "Low-damage radiation shockwave may disrupt smaller robotics.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "600, 8",
		DamageAmount = 600,
		DamageBlastRadius = 256,
		DamageType = { DMG_BLAST, DMG_SF_VAPOR, DMG_RADIATION }
	},
	ReloadSpeed = 1.8,
	PerkSet = { SCIFI_PERK_AMMO_RADIATION }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/w_models/weapons/w_eq_pipebomb.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0, -0.101, 0), angle = Angle(180, 0, 0), size = Vector(1,1,1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/w_models/weapons/w_eq_pipebomb.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5, 2, 3.5), angle = Angle(-180, 0, 0), size = Vector(1,1,1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local activate = Sound( "scifi.melee.swing.light" )
local active = true

if ( CLIENT ) then

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	
	if ( self.Primary.ClipSize > -1 ) then
		self.AmmoDisplay.PrimaryClip = self.Owner:GetAmmoCount( self.Primary.Ammo )
	end
	
	return self.AmmoDisplay
	
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

function SWEP:NadeThrow()

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 1.2 )
	self:SetNextSecondaryFire( CurTime() + 1.2 )
	
	self:frag( 24000 )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_THROW )
	
	active = false
		
	timer.Simple( 0.7, function()
		if ( IsValid( self ) && IsValid( self.Owner ) ) then
			if ( self.Owner:GetActiveWeapon():GetClass() ~= self:GetClass() ) then
				self:NadeReloadSilent()
			else
				self:NadeReload()
			end
		end
	end )

end

function SWEP:NadeRoll()

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 1 )
	self:SetNextSecondaryFire( CurTime() + 1 )
	
	self:frag( 6000 )
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	
	active = false
		
	timer.Simple( 0.7, function()
		if ( IsValid( self ) && IsValid( self.Owner ) ) then
			if ( self.Owner:GetActiveWeapon():GetClass() ~= self:GetClass() ) then
				self:NadeReloadSilent()
			else
				self:NadeReload()
			end
		end
	end )

end

function SWEP:frag( speed ) 

	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
		local ent = ents.Create( "sfw_vpr_ent" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() + Angle( math.random( 40, 120 ), 40, 0 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:EyeAngles():Up() * speed / 10 + self.Owner:GetAimVector() * speed )
		phys:AddAngleVelocity( self.Owner:EyeAngles():Up() * -speed )
	end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

end

function SWEP:PrimaryAttack()
	
end

function SWEP:SecondaryAttack()

end

function SWEP:NadeReload()

	if ( self.Owner:IsPlayer() ) then
		if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
			
			if ( self.Owner:IsPlayer() ) then
				self.Owner:RemoveAmmo( 1, self.Primary.Ammo )
				self:EmitSound( activate )
			end
		else
			self:Remove()
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
	else
		self:Remove()
	end
	
	if ( self.Owner:IsNPC() ) then
		self.Weapon:SetClip1( self.Primary.ClipSize )
	end

end

function SWEP:Reload()
	
end