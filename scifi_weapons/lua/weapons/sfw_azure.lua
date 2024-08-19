AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false
SWEP.ItemRank 				= 19

SWEP.ViewModel				= "models/weapons/c_bugbait.mdl"
SWEP.WorldModel				= "models/weapons/w_grenade.mdl"
SWEP.HoldType 				= "grenade"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 2.8

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "grenade"

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.ViewModelSprintPos		= Vector( 1.8, 0.2, 0.8 )
SWEP.ViewModelSprintAng		= Angle( -10, -8, 0 )

SWEP.ViewModelMeleePos		= Vector( 6, 2, -6 )
SWEP.ViewModelMeleeAng		= Angle( 18, 40, -45 )

SWEP.PrintName				= "AMX 'Azure' Grenade"
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.SprintAnimIdle			= false

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "120, 60",
		DamageAmount = 180,
		DamageBlastRadius = 256,
		DamageType = { DMG_BLAST, DMG_SF_VAPOR, DMG_RADIATION }
	},
	ReloadSpeed = 1.8,
	PerkSet = { SCIFI_PERK_AMMO_STICKYGRENADES, SCIFI_PERK_AMMO_RADIATION }
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
	
	end

	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:NadeThrow()

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 1.2 )
	self:SetNextSecondaryFire( CurTime() + 1.2 )
	
	self:frag( 4600 )
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
	
	self:frag( 1600 )
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
		local ent = ents.Create( "sfw_azure_ent" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() ) --self.Owner:EyePos() + ( self.Owner:GetAimVector() * 12 ) + self.Owner:EyeAngles():Up() )
		ent:SetAngles( self.Owner:EyeAngles() + Angle( math.random( 10, 80 ), 40, 0 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:EyeAngles():Up() * speed / 10 + self.Owner:GetAimVector() * speed )
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