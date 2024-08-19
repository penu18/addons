AddCSLuaFile()
AddCSLuaFile( "base/scifi_techs.lua" )
include( "base/scifi_techs.lua" )
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false

SWEP.Instructions			= ""

SWEP.ItemRank 				= 25

SWEP.ViewModel 				= "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel				= "models/weapons/w_shot_m3super90.mdl"
SWEP.SciFiSkin 				= "models/black"
SWEP.SciFiWorld 			= "models/black"

SWEP.HoldType 				= "shotgun"
SWEP.HoldTypeNPC 			= "shotgun"
SWEP.HoldTypeSprint			= "passive"
SWEP.DeploySpeed 			= 1

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"

SWEP.VfxMuzzleParticle 		= "ar2_muzzle"
SWEP.VfxMuzzleAttachment 	= "1"
SWEP.VfxMuzzleColor 		= Color( 80, 120, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720

SWEP.PrintName				= "Voltshot"
SWEP.Slot					= 3
SWEP.SlotPos				= 3
SWEP.ViewModelFOV			= 60

--SWEP.SciFiMeleeRange		= 46
SWEP.SciFiMeleeDamage		= 8
SWEP.ViewModelMeleePos		= Vector( 4, 2, -16 )
SWEP.ViewModelMeleeAng		= Angle( 46, 42, -40 )

SWEP.AdsPos 				= Vector(-8, 2, 0)
SWEP.AdsAng 				= Vector(0, -1, -10)
SWEP.AdsFov 				= 54

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeRecoverTime 	= 0.32
SWEP.SciFiMeleeASpeed		= 0.6
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"
SWEP.SciFiMeleeChargeMax	= 100

SWEP.SprintAnimIdle			= false
SWEP.ViewModelSprintPos		= Vector( 4, 1, 1 )
SWEP.ViewModelSprintAng		= Angle( -15, 35, -5 )
SWEP.ViewModelSprintSway 	= 4
SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -1, -1, 1 )
SWEP.ViewModelReloadAng		= Angle( -20, -2, -10 )
SWEP.ReloadTime 			= 0.4

SWEP.ReloadAct 				= ACT_VM_RELOAD

SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				  10 * 6", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x1.5", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	 	Bullet, Shock", color = Color( 110, 100, 255 ) },
	["3a"] = { text = "Status Chance:		20%", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Clip size: 					6", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				  0.9", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "10 * 6",
		DamageAmount = 60,
		DamageType = { DMG_BULLET, DMG_SHOCK },
		CritMul = 1.5,
		StatusChance = 20,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 1.1 }, 
		},
	},
	ClipSize = 6,
	ReloadSpeed = 0.7,
	Recoil = 15,
	PerkSet = { SCIFI_PERK_ELEMENTAL_SHOCK }
}

function SWEP:SubInit()

end

SWEP.NextReload = 0

function SWEP:Think()

	if ( self.Owner:IsPlayer() && !self.Owner:InVehicle() ) then
		local NextPFire = self:GetNextPrimaryFire()
		if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
			self:ReloadShotgun()
		end
		
		self:SetAnimNextIdle( CurTime() + 0.4 )
	end	
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 5001 || event == 5011 ) then
		return true
	end

end

function SWEP:Attack()
	
	local cmdDamage = GetConVarNumber( "sfw_damageamp" )
	
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()

	local bullet = {}
	bullet.Num = 6
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV + ( Vector( 0, 0, 0.002 ) * self:GetSciFiACC() )
	bullet.Tracer = 1
	bullet.HullSize = 1
	-- bullet.AmmoType = "buckshot"
	bullet.TracerName = "AR2TracerNoMuzzle"
	
	bullet.Damage = 10 * cmdDamage
	bullet.Force = 2
	bullet.Spread = Vector( .05, .1 )
	
	bullet.Callback = function( attacker, tr, dmginfo )
		-- dmginfo:SetDamageType( DMG_BUCKSHOT )
		dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_SHOCK ) )

		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:ScaleDamage( 0.75 )
		end
		
		-- self:DealAoeDamage( DMG_SHOCK, 5, tr.HitPos, 32 )
		
		if ( math.random( 1, 100 ) > 80 ) then
			ParticleEffect( "eml_generic_shock", tr.HitPos, tr.Normal:Angle() )
		
			local myeml = {}
			myeml.Element = EML_SHOCK
			myeml.Damage = 40
			myeml.Attacker = self.Owner
			myeml.Inflictor = self
			myeml.Target = tr.Entity
			DoElementalEffect( myeml )
		end
	end
	
	self.Owner:FireBullets( bullet, false )

	self:EmitSound( "scifi.hybridsniper.fire.default" )
	self:EmitSound( "scifi.voltshot.fire" )
	-- self:EmitSound( "scifi.asa6.fire1.echo" )
	-- self:EmitSound( "scifi.solaris.echo" )

	self:TakePrimaryAmmo( 1 )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -4.6, -4 ), 0, 0.3 ) * ( 1 + self:GetSciFiACC() * 0.2 ) )
	end
	
	self:AddSciFiACC( 15 )
	
end

function SWEP:Muzzle()
	
	local vmEntity = self:GetViewModelEnt()
	
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:DoMuzzleEffect()

	if ( self:GetSciFiACC() >= math.random( 10, 35 ) ) then
		ParticleEffectAttach( "gunsmoke", 4, vmEntity, vmAttachMuzzle )
	end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

end

function SWEP:PrimaryAttack()

	self:SetNextPrimaryFire( CurTime() + 1.1 )

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	self:Muzzle()
	self:Attack()
	
	if ( self.Owner:IsNPC() ) then
		self:SetClip1( 0 )
	end

end

function SWEP:OnReload()

	self.NextReload = 8 - self:Clip1()

end

function SWEP:OnReloadFinish()

	self.NextReload = 0

	self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
	
	if ( self.NextReload > 0 ) then
		self:ReloadShotgun()
	end

end

function SWEP:Reload()

	if ( !self:CanReload() ) then return end

	self:OnReload()
	
	if ( self.Owner:IsPlayer() ) then
		if ( game.SinglePlayer() ) && ( SERVER ) then
			net.Start( "SciFiReload" )
			net.WriteBool( true )
			net.Send( self.Owner )
		end
		
		self:SetSciFiState( SCIFI_STATE_RELOADING )
		
		self:SetAds( false )
		
		timer.Simple( self.ReloadTime, function()
			if ( IsValid( self ) ) then
				if ( self.ReloadRealisticClips ) then
					self.Primary.ClipSize = self.Primary.DefaultClip
				end
				
				if ( self.ReloadAnimEndIdle ) then
					self:SendWeaponAnim( ACT_VM_IDLE )
				end
				
				if ( game.SinglePlayer() ) && ( SERVER ) then
					net.Start( "SciFiReload" )
					net.WriteBool( false )
					net.Send( self.Owner )
				end
				
				self:SetSciFiState( SCIFI_STATE_IDLE )
				
				self:OnReloadFinish()
			end
		end )
	end
	
end

function SWEP:ReloadShotgun()

	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	if ( self.NextReload < 1 ) then return end

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self:SetNextPrimaryFire( CurTime() + self.ReloadTime )
		self:SetNextSecondaryFire( CurTime() + self.ReloadTime )

		if ( self.Owner:IsPlayer() ) then
			self:SendWeaponAnim( ACT_VM_RELOAD )
			self:SetClip1( math.Clamp( self:Clip1() + 1, 0, 8 ) )
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo )
			self.Owner:DoReloadEvent()
		else
			self:SetClip1( self.Primary.ClipSize )
		end
	end

	self.NextReload = self.NextReload - 1
	
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	ParticleEffect( "ar2_hit", tr.HitPos, tr.Normal:Angle() )

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 80
			dlight.g = 120
			dlight.b = 255
			dlight.brightness = 1
			dlight.Decay = 1024
			dlight.Size = 128
			dlight.DieTime = CurTime() + 0.5
		end
	end

end