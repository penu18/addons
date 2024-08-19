AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

local cmd_heat = GetConVarNumber( "sfw_fx_heat" )

SWEP.Spawnable = false
SWEP.AdminSpawnable = false

SWEP.Purpose				= "It's like the default SMG, but better... I guess..."
SWEP.Instructions			= "Mouse1 to fire, Mouse1 + 'Use' (e) to altfire. Mouse2 to zoom. Mouse2 + 'Use' (e) to switch firemodes."
SWEP.ItemRank 				= 0

SWEP.DeploySpeed 			= 2.8
SWEP.UseSCK 				= false

SWEP.SciFiSkin				= ""
SWEP.SciFiWorld 			= ""

SWEP.Primary.ClipSize		= 45
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.ReloadLegacy 			= false
SWEP.ReloadTime 			= 1
SWEP.ReloadPlaybackRate 	= 1.2
SWEP.ReloadRealisticClips 	= false
SWEP.ReloadLegacy 			= false
SWEP.ReloadSND 				= ""
SWEP.DepletedSND			= "Weapon_SMG1.Empty"
SWEP.ReloadSND				= "Weapon_SMG1.Reload"
SWEP.ReloadACT				= ACT_VM_RELOAD

SWEP.VfxMuzzleParticle 		= "ngen_muzzle_4"
SWEP.VfxMuzzleColor 		= Color( 255, 160, 100, 200 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 150
SWEP.VfxMuzzleFarZ 			= 480
SWEP.VfxHeatForce 			= true
SWEP.VfxHeatParticle 		= "gunsmoke"
SWEP.VfxHeatThreshold 		= 1

SWEP.Secondary.Ammo			= "SMG1_GRENADE"
SWEP.Secondary.DefaultClip	= 30

SWEP.PrintName				= "SMG"
SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.AdsPos 				= Vector(-6.6, 0, 1.075)
SWEP.AdsAng 				= Vector(0, 0, 0)
SWEP.AdsFov					= 45

SWEP.SprintAnimSpeed 		= 12
SWEP.ViewModelMeleePos		= Vector( 16, 8, -4 )
SWEP.ViewModelMeleeAng		= Angle( -5, 80, -65 )
SWEP.ViewModelSprintSway 	= 4
SWEP.ViewModelSprintPos		= Vector( 3, -0.2, -2 )
SWEP.ViewModelSprintAng		= Angle( -5, 30, -15 )
SWEP.ViewModelSwayDirection = Vector( -0.5, 6, 1 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -1, 0, -4 )
SWEP.ViewModelReloadAng		= Angle( 15, -5, 5 )

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				  4", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x2", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Bullet", color = Color( 210, 215, 200 ) },
	["4"] = { text = "Clip size: 					45", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 12", color = Color( 180, 180, 180 ) }
}

SWEP.DataTables = {
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Bool", dName = "CanBurst" },
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Int", dName = "BurstCount" }
}

function SWEP:SubInit()

	self:SetBurstMode( false )
	
end

function SWEP:Think()
	
	if ( self:GetBurstMode() ) then
	
		if !( self.SciFiState == SCIFI_STATE_IS_RELOADING ) && ( self:CanBFire() ) && ( self:GetNextPrimaryFire() < CurTime() && self:GetNextPrimaryFire() > -1 ) then
			if ( self:GetBurstCount() <= 3 && self:GetCanBurst() ) and ( self:GetNextPrimaryFire() ~= -1 ) then
				self:PrimaryAttack()
				self:SetNextPrimaryFire( CurTime() + 0.07 )	
			end
			
			if ( self:GetBurstCount() >= 3 ) then
				self:SetNextPrimaryFire( CurTime() + 0.35 )
				self:SetCanBurst( false )
				self:SetBurstCount( 0 )
			end
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

function SWEP:Attack()
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	local pOwnerAV = self.Owner:GetAimVector()

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector() + ( Vector( 0, 0, 0.4 ) * ( self:GetSciFiACC() / 256 ) )
	bullet.Spread = Vector( .01, .02 ) + ( Vector( 0, 1 ) * ( self:GetSciFiACC() * 0.01 ) )
	bullet.Tracer = 0
	bullet.TracerName = "spr_tracer"
	bullet.Force = 1
--	bullet.HullSize = 1
	bullet.Damage = 4 * GetConVar( "sfw_damageamp" ):GetFloat()
	bullet.AmmoType = "smg1"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_BULLET )
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -10, -20 ), math.random( -10, 10 ), 0 ) * ( 0.004 + self:GetSciFiACC() * 0.001 ) )
		self:AddSciFiACC( 3 )
	end

	self:DoMuzzleEffect()

	self:EmitSound( "Weapon_SMG1.Single" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:AltFire()

	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
	
	local viewmodel = self:GetViewModelEnt()
	self:SetNextSecondaryFire( CurTime() + 1.4 )
	
	self:AddSciFiACC( 8 )

	if ( SERVER ) then
		local ent = ents.Create( "sfw_frag_ent" )
		if ( !IsValid( ent ) ) then return end	
		ent:SetModel( "models/items/AR2_Grenade.mdl" )
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() + Angle( 90, 0, 0 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent.NextTick = CurTime() + 5.5
		ent.LauncherMode = true

		local phys = ent:GetPhysicsObject()
		if (  !IsValid( phys ) ) then ent:Remove() return end
	--	phys:SetMass( 4 )
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 5600 + self.Owner:EyeAngles():Up() * 320 )	
	end

	self:EmitSound( "Weapon_SMG1.Double" )
	
	ParticleEffectAttach( "gunsmoke", 4, viewmodel, 1 )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -3.25, -4), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 4 )
	end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	
	self.Owner:RemoveAmmo( 1, self.Secondary.Ammo )

end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsPlayer() ) && ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self.Owner:GetAmmoCount( self.Secondary.Ammo ) < 1 ) then return end
		self:SetNextPrimaryFire( CurTime() + 1 )
		self:AltFire()
	else
		if ( !self:CanPrimaryAttack( 0 ) ) then return end
		if ( self:GetBurstMode() ) && ( self.Owner:IsPlayer() ) then
			if ( self:GetBurstCount() >= 4 ) then return end
			self:SetCanBurst( true )
			self:Attack()
			self:SetBurstCount( self:GetBurstCount() + 1 )
		else
			if ( self.Owner:IsPlayer() ) then
				self:SetNextPrimaryFire( CurTime() + 0.05 )
				self:Attack()
			else
				self:SetNextPrimaryFire( CurTime() + 0.05 )	
				timer.Create("sprayandpray" .. self:EntIndex(), 0.07, 5, function()
					if ( !IsValid( self ) ) then return end
					if ( !IsValid( self.Owner ) ) then return end
					if ( !self:CanPrimaryAttack( 0, true ) ) then return end
					
					self:Attack()
				end )
			end
		end
	end
	
end

function SWEP:CanBFire()

	if ( self.Weapon:Clip1() <= 0 ) then
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end

	return true
	
end

function SWEP:SecondaryAttack()

	self:SetNextSecondaryFire( CurTime() + 0.5 )
	
	if ( self.Owner:KeyDown( IN_ATTACK2 ) ) and ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetBurstMode() ) then 
			self:SetBurstMode( false )
		else
			self:SetBurstMode( true )
		end
		self:EmitSound( "Weapon_AR2.Empty" )
		self:SendWeaponAnim( ACT_VM_IDLE_TO_LOWERED )
	end

end

function SWEP:OnReloadFinish()
	
	self:SetSciFiACC( 0 )

	self:SendWeaponAnim( ACT_VM_IDLE )

end