AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Fires a bouncing energy ray which will damage everything in its path. Once the projectile hits a surface, it will bounce around in random directions. NOT FOR INDOOR USAGE!"
SWEP.Instructions			= "Mouse1 to fire. Bullets reflect from surfaces. Mouse1 + 'Use' for powershot. The powershot empties the entire drum, regardless of how many shots are left, creating an additional projectile on every bounce for every bullet left at the moment it was fired. Beware of bouncing projectiles!"
SWEP.ItemRank 				= 20

SWEP.ViewModel				= "models/weapons/c_scifihc.mdl"
SWEP.WorldModel				= "models/weapons/w_357.mdl"
SWEP.HoldType 				= "revolver"
SWEP.HoldTypeSprint			= "normal"

SWEP.SciFiSkin				= "models/weapons/trace/skin.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"

SWEP.VfxMuzzleParticle 		= "trace_muzzle"
SWEP.VfxMuzzleColor 		= Color( 255, 100, 210, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 720

SWEP.PrintName				= "RND 'Trace' blaster"
SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.SciFiMeleeASpeed		= 0.5
SWEP.SciFiMeleeRange		= 46
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.AdsTransitionSpeed		= 16
SWEP.AdsPos 				= Vector(-4.75, 2, -0.1)
SWEP.AdsAng 				= Vector(0, 0, 0)
SWEP.AdsFov					= 50

SWEP.ViewModelSprintPos		= Vector( 0, 2, 0.8 )
SWEP.ViewModelSprintAng		= Angle( -25, -10, 0 ) -- Angle( -5, -10, 0 )

SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelSprintPos 	= Vector( -1, 4, -16 )
SWEP.ViewModelSprintAng		= Angle( 50, -10, 5 )
SWEP.ViewModelSwayDirection = Vector( -0.4, 4.4, 0 )

SWEP.ReloadTime				= 2.7
SWEP.ReloadAnimEndIdle  	= true

SWEP.SciFiFamily			= { "base", "phys", "noads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				70", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		72", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: Impact, Crush", color = Color( 140, 130, 120 ) },
	["4"] = { text = "Clip size: 				 6", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				6 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Projectiles bounce off of every surface they hit.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Alt. damage: 	 100.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Alt. range: 			100 units", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Alt. damage type: Impact, Crush", color = Color( 140, 130, 120 ) },
	["9a"] = { text = "Altfire consumes 6 ammo.", color = Color( 180, 180, 180 ) },
	["9b"] = { text = "Altfire spawns an additional projectile with every collision.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 70,
		DamageType = { DMG_CRUSH, DMG_IMPACT },
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.15 },
		},
	},
	Secondary = {
		DamageAmount = 70,
		DamageType = { DMG_CRUSH, DMG_IMPACT },
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.15 },
		},
	},
	CoreRechargeRate = nil,
	ClipSize = 36,
	ReloadSpeed = 2.7,
	Recoil = 6,
	PerkSet = { SCIFI_PERK_AMMO_RICOCHET_HEAVY, { PerkTitle = "Meridian", PerkPanelHeight = 4, PerkDescription = "Secondary attack creates an additional \nprojectile with every hit, \nbased on ammo remaining in magazine." } }
}

local ShootSound = Sound( "scifi.trace.fire1" )

local amp = GetConVarNumber( "sfw_damageamp" )
local pfx = GetConVarNumber( "sfw_fx_particles" )

function SWEP:Think()

	if ( game.SinglePlayer() ) || ( !game.SinglePlayer() && CLIENT ) then
		local bAds = ( self:GetSciFiState() == SCIFI_STATE_ADS )
		local fNextPrimaryFire = self:GetNextPrimaryFire() - CurTime()
		
		if ( bAds ) then
			if ( fNextPrimaryFire > 0 ) then
				local fAnimationScale = ( fNextPrimaryFire / 0.15 )
		
				-- if ( !game.SinglePlayer() ) then
					fAnimationScale = fAnimationScale * fAnimationScale 
				-- end
		
				self.AdsPos.x = -4.74 + 1 * fAnimationScale
				self.AdsPos.z = 0.24 - 0.90 * fAnimationScale
				self.AdsAng.pitch = -16 * fAnimationScale
				self.AdsAng.roll = 14 * fAnimationScale

				local aPunch = self.Owner:GetViewPunchAngles()
				self.Owner:SetViewPunchAngles( aPunch * ( 0.95 + fAnimationScale * 0.05 ) )
			else
				self.AdsPos.x = -4.74
				self.AdsPos.z = 0.24
				self.AdsAng.pitch = 0
				self.AdsAng.roll = 0
			end
		end
	end

	dState = self.SciFiState
	self:SciFiMath()
	self:SciFiMelee()
	self:Anims()
	self:Ads()

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0 ) ) then return end

	if ( self.Owner:KeyDown( IN_USE ) && self:GetNextPrimaryFire() < CurTime() ) then
		self:SetNextPrimaryFire( CurTime() + 0.15 )
		
		local amp = GetConVarNumber( "sfw_damageamp" )
		local viewmodel = self:GetViewModelEnt()
		
		if ( SERVER ) then
		
		local ent = ents.Create( "trace_sfire" )
		if ( !IsValid( ent ) ) then return end	
		ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent.trace_maxchilds = self:Clip1() - 1
		ent:Activate()

		local phys = ent:GetPhysicsObject()
		if (  !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 34000 )
		
		end
		
		self:DoMuzzleEffect()
			
		if ( self.Owner:IsPlayer() ) then	
			self.Owner:ViewPunch( Angle( math.random( -0.8, -2 ), math.random( 0, 0.15 ), math.random( 0, 0.15 ) ) )
			self:AddSciFiACC( 6 + self:Clip1() )
		end
		
		self:EmitSound( ShootSound )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:TakePrimaryAmmo( self:Clip1() )
	
		return
	end
	self:SetNextPrimaryFire( CurTime() + 0.15 )
	
	local amp = GetConVarNumber( "sfw_damageamp" )
	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
	
	local ent = ents.Create( "trace_pfire" )
	if ( !IsValid( ent ) ) then return end	
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:SetOwner( self.Owner )
	ent:Spawn()
	ent:Activate()

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	phys:ApplyForceCenter( self.Owner:GetAimVector() * 340000 )
	
	end
	
	self:DoMuzzleEffect()
		
	if ( self.Owner:IsPlayer() ) then	
		self.Owner:ViewPunch( Angle( math.random( -0.8, -2 ), math.random( 0, 0.15 ), math.random( 0, 0.15 ) ) )
		self:AddSciFiACC( 6 )
	end
	
	self:EmitSound( ShootSound )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:TakePrimaryAmmo( 1 )
	
end