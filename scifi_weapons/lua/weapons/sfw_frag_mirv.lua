AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false
SWEP.ItemRank 				= 8

SWEP.ViewModel				= "models/weapons/c_scifind.mdl"
SWEP.WorldModel				= "models/weapons/w_grenade.mdl"
SWEP.HoldType 				= "grenade"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 2.8

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_grinder.vmt" )
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

SWEP.PrintName				= "Mirv Grenade"
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.SciFiFamily			= { "base", "phys", "noads", "autoreload", "grenade" }

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				  8", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "AOE Range:		128", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x2", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Bullet", color = Color( 210, 215, 200 ) },
	["4"] = { text = "Clip size: 					30", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 11.1", color = Color( 180, 180, 180 ) }
} 

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "60, 60",
		DamageAmount = 240,
		DamageBlastRadius = 128,
		DamageType = { DMG_BULLET, DMG_BLAST }
	},
	ReloadSpeed = 1.8,
	PerkSet = { SCIFI_PERK_AMMO_EXPLOSIVE }
}

SWEP.SprintAnimIdle			= false

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
		local pOwnerEA = self.Owner:EyeAngles()
		local up = pOwnerEA:Up()
		
		local ent = ents.Create( "sfw_mirv_ent" )
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