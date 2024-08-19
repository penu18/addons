AddCSLuaFile()
AddCSLuaFile( "base/scifi_techs.lua" )
include( "base/scifi_techs.lua" )
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false

SWEP.ViewModel 				= "models/weapons/c_scifisg.mdl"
SWEP.WorldModel				= "models/weapons/w_shotgun.mdl"
--SWEP.SciFiSkin				= "vgui/white"

SWEP.DefaultSwayScale		= 1.6
SWEP.DefaultBobScale		= 2.4
SWEP.SprintSwayScale		= 2.2
SWEP.SprintBobScale			= 3.2

SWEP.HoldType 				= "shotgun"
SWEP.HoldTypeNPC 			= "shotgun"
SWEP.DeploySpeed 			= 1.2

SWEP.VfxMuzzleParticle 		= "trace_muzzle"
SWEP.VfxMuzzleColor 		= Color( 200, 40, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 750

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"

SWEP.PrintName				= "RNR 'Meridian' Shotgun"
SWEP.Slot					= 3
SWEP.SlotPos				= 1
SWEP.ViewModelFOV			= 54

SWEP.SciFiACCRecoverRate	= 0.2

SWEP.AdsPos 				= Vector(-4, 6, 2.4)
SWEP.AdsAng 				= Vector(0, -1, 0)
SWEP.AdsFov 				= 54

SWEP.ViewModelSprintPos		= Vector( -2, -2, 2 )
SWEP.ViewModelSprintAng		= Angle( -5, 15, 5 )

SWEP.SciFiMeleeRecoverTime 	= 0.32
SWEP.SciFiMeleeASpeed		= 0.6
SWEP.SciFiMeleeDamage		= 10
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"

SWEP.ReloadTime 			= 2
SWEP.ReloadSND 				= "scifi.asa6.reload.bback"
SWEP.DepletedSND 			= "General.Sentence.Stop"


SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -2), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 2), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
}

SWEP.WElements = {
}

function SWEP:Think()

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 5001 ) then
		return true
	end

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 0.1 )
	
	local cmdDamage = GetConVarNumber( "sfw_damageamp" )
	
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
	local vmAttachShell = vmEntity:LookupAttachment( "1" )

	local ptru = {}
	ptru.Num = 4
	ptru.AmmoType = "shotgun"
	ptru.Tracer = 1
	ptru.TracerName = "meridian_tracer_noattach"
	ptru.Damage = 10 * cmdDamage
	ptru.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_CRUSH, DMG_VEHICLE ) )
	end

	local bullet = {}
	bullet.Num = 4
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV
	bullet.HullSize = 0.32
	bullet.AmmoType = "shotgun"
	bullet.Tracer = 1
	bullet.TracerName = "meridian_tracer"
	bullet.Damage = 12 * cmdDamage
	bullet.Force = 4
	bullet.Spread = Vector( 0.005, 0.005 )
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_CRUSH, DMG_VEHICLE ) )
		
		if ( tr.HitSky ) then return end
		
		for i=0, 1 do
			if ( i == 0 ) then
				ptru.Src = tr.HitPos - pOwnerAV -- * 16
				ptru.Dir = ( tr.Normal + tr.HitNormal )
				ptru.Spread = Vector( 0.05, 0.05 )
			else
				local trBounce = util.TraceLine( { start = tr.HitPos - pOwnerAV, endpos = tr.HitPos + ( tr.Normal + tr.HitNormal ) * 16384, filter = {} } )
				
				ptru.Src = trBounce.HitPos
				ptru.Dir = ( trBounce.Normal + trBounce.HitNormal )
				ptru.Spread = Vector( 0.5, 0.5 )
			end
		
			self.Owner:FireBullets( ptru, false )
		end
	end

	self.Owner:FireBullets( bullet, false )
	
	self:EmitSound( "scifi.trace.fire1", 90, math.random( 95, 105), 1, CHAN_STATIC )
	
	self:DoMuzzleEffect()
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
	
	if ( self:Clip1() == 0 ) && ( self:CanReload() ) then
		self:Reload()
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.2, -1.6 ), math.random( -0.1, -0.5 ), math.random( -0.1, -0.3 ) ) * ( 1 + self:GetSciFiACC() * 0.1 ) )
	end
	
	self:AddSciFiACC( 6 )

end

function SWEP:Reload()
	
	if ( self.SciFiState == SCIFI_STATE_ADS ) then return end
	if ( !self:CanReload() ) then return end
--	if ( self:GetNextPrimaryFire() > CurTime() ) then print( "nope" ) return end
	
	if ( self.Owner:IsPlayer() ) then
		self.SciFiState = SCIFI_STATE_RELOADING
		self:SetAds( false )
		
		timer.Simple( 0.4, function()
			if ( IsValid( self ) ) then
				self:DefaultReload( ACT_VM_RELOAD )
			end
		end )
		
		timer.Simple( 1, function()
			if ( IsValid( self ) ) then
				self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
				self.SciFiState = false
			end
		end )
	end

	self:CreateReloadModels()
	
	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self:SetNextPrimaryFire( CurTime() + self.ReloadTime )
		self:SetNextSecondaryFire( CurTime() + self.ReloadTime )
		self:EmitSound( self.ReloadSND )

		if ( self.Owner:IsPlayer() ) then
		--	self:DefaultReload( ACT_VM_RELOAD )
			self.Owner:DoReloadEvent()
		else
			self:SetClip1( self.Primary.ClipSize )
		end
	end
	
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	
	ParticleEffect( "trace_sparks_new", tr.HitPos, tr.Normal:Angle(), self )

	if ( CLIENT ) && ( self.Owner:IsPlayer() ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos 
			dlight.r = 220
			dlight.g = 40
			dlight.b = 255
			dlight.brightness = 1
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end

end