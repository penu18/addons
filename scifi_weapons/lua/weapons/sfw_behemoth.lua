AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "The 'Behemoth' marks the most destructive part of the RK family. With a humongous magazine combined with a extremely high firerate and good, steady damage, this weapon can turn down hordes of enemies with a hail of bullets."
SWEP.Instructions			= "Hold down Mouse1 to wind up and fire."
SWEP.ItemRank 				= 24

SWEP.ViewModel				= "models/weapons/c_scifivtwoh.mdl"
SWEP.WorldModel				= "models/weapons/w_physics.mdl"
SWEP.HoldType 				= "physgun"
SWEP.DeploySpeed 			= 2.8
SWEP.SciFiSkin				= "models/weapons/moby/skin"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_grinder.vmt" )
end

SWEP.Primary.ClipSize		= 220
SWEP.Primary.DefaultClip	= 220
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.VfxMuzzleParticle	 	= "moby_muzzle"
SWEP.VfxMuzzleColor 		= Color( 255, 210, 190, 120 )
SWEP.VfxMuzzleBrightness 	= 0.4
SWEP.VfxMuzzleFOV 			= 155
SWEP.VfxMuzzleFarZ 			= 250
SWEP.VfxHeatParticle 		= "gunsmoke" 

SWEP.ReloadTime				= 3

SWEP.ViewModelSwayDirection = Vector( 0.1, 4, 1.1 )
SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelSprintSway 	= 4
SWEP.SprintAnimSpeed		= 10

SWEP.ViewModelSprintPos		= Vector( -3, 0.5, 1.6 )
SWEP.ViewModelSprintAng		= Angle( -10, 0, 0 )
SWEP.ViewModelMeleePos		= Vector( -2, 8, 4 )
SWEP.ViewModelMeleeAng		= Angle( -8, 10, -2 )

SWEP.PrintName				= "RK800 'Behemoth' chain-gun"
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.ChargeDeltaCompensate 	= true
SWEP.ChargeMax				= 100
SWEP.ChargeAdd 				= 2
SWEP.ChargeDrain 			= 1

SWEP.SciFiMeleeASpeed		= 0.9
SWEP.SciFiMeleeRange		= 64
SWEP.SciFiMeleeDamage		= 12
SWEP.SciFiMeleeSound		= "scifi.melee.swing.heavy"
SWEP.SprintAnimIdle			= false

SWEP.SciFiFamily			= { "base", "hitscanbullets", "noads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 6", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				x2", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: Bullet", color = Color( 210, 215, 200 ) },
	["4"] = { text = "Clip size: 				 220", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				22 (full-auto)", color = Color( 180, 180, 180 ) },
	["9a"] = { text = "Needs to wind up before actually firing.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 10,
		DamageType = DMG_BULLET,
		CritMul = 1.5,
		StatusChance = nil,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.04 }
		},
		ChargeRate = 2
	},
	-- ClipSize = 220,
	ReloadSpeed = 3,
	Recoil = 2,
	PerkSet = { SCIFI_PERK_CHAMBER_WINDUP, SCIFI_PERK_RELOAD_FROMRESERVES }
}

SWEP.ReloadSND				= "scifi.behemoth.reload"

SWEP.VElements = {
--	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_canal/generator01.mdl", bone = "Base", rel = "", pos = Vector(2, 2.5, 18), angle = Angle(180, 90, 90), size = Vector(0.042, 0.042, 0.042), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/motor_case", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/moby_barrel.mdl", bone = "Base", rel = "", pos = Vector(0, 3.2, 24), angle = Angle(90, 0, 0), size = Vector(2.6, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_barrel", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/moby_body.mdl", bone = "Base", rel = "", pos = Vector(0, 2, 10), angle = Angle(90, -90, 0), size = Vector(1, 1.4, 1.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/case_side", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "Base", rel = "", pos = Vector(-0.2, 0, -4), angle = Angle(180, 90, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/engine", skin = 0, bodygroup = {} },
	["6la"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "Base", rel = "", pos = Vector(4, 2, 4), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_core", skin = 0, bodygroup = {} },
	["6r"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "Base", rel = "", pos = Vector(-4, 2, 4), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_core", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/moby_barrel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(24, -3.75, -6), angle = Angle(-4.5, 10.5, 30), size = Vector(2.2, 2.1, 2.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_barrel", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/moby_body.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, -3, -8), angle = Angle(0, 8, 197.5), size = Vector(0.6, 1, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/case_side", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, -1.4, -5), angle = Angle(68, -84, 92), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/engine", skin = 0, bodygroup = {} },
	["6l"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14, 1, -6.2), angle = Angle(-20, -80, -95), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_core", skin = 0, bodygroup = {} },
	["6r"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13, -4.2, -4.2), angle = Angle(160, -80, -85), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_core", skin = 0, bodygroup = {} }
}

if ( CLIENT ) then
	function SWEP:CustomAmmoDisplay()

		self.AmmoDisplay = self.AmmoDisplay || {}
		self.AmmoDisplay.Draw = true
		
		self.AmmoDisplay.PrimaryClip = self:Ammo1()

		self.AmmoDisplay.SecondaryClip = -1
		self.AmmoDisplay.SecondaryAmmo = -1

		return self.AmmoDisplay
	end
end

local bullet = {}
bullet.Num = 1
bullet.Tracer = 1
bullet.Force = 128
bullet.HullSize = 1
bullet.AmmoType = "SciFiAmmo"
bullet.TracerName = "moby_tracer"
bullet.Callback = function( attacker, tr, dmginfo )
	dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_SLASH ) )
					
	if ( tr.HitGroup == HITGROUP_HEAD ) then
		dmginfo:SetDamage( dmginfo:GetDamage() * 0.75 )
	end	
end

-- resource.AddSingleFile( "weapons/moby/spinup.wav" )
util.PrecacheSound( "weapons/moby/spinup.wav" )

SWEP.DataTables = {
	{ dType = "Float", dName = "NextChargeAnim" }
}

function SWEP:Equip( NewOwner )

	if ( NewOwner:IsNPC() ) then
		if ( self.SciFiWorld ~= nil && self.SciFiWorld ~= "" ) then
			self:SetMaterial( self.SciFiWorld )
		end
	end

	if ( self.Owner:IsPlayer() ) then
		self.Owner:GiveAmmo( 200, self.Primary.Ammo )
	end

end

function SWEP:SubInit()

	self:SetCharge( 0 )
	
end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextChargeAnim( CurTime() + vm:SequenceDuration() / 12 )

end

function SWEP:Think()

	if ( self.Owner:IsPlayer() ) then
		if ( SERVER ) then
			if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( self.SciFiState != SCIFI_STATE_SPRINT ) then
				if ( self:GetCharge() < self.ChargeMax ) then
					self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
				end
			else
				if ( self:GetCharge() > 0 ) then
					self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
				end
			end
		end

		self.VElements[ "3" ].angle = self.VElements[ "3" ].angle + Angle( 0, 0, self:GetCharge() * 0.125 )
		self.WElements[ "3" ].angle = self.WElements[ "3" ].angle + Angle( 0, 0, self:GetCharge() * 0.125 )
	end
	
	local animtime = self:GetNextChargeAnim()
	local vm = self.Owner:GetViewModel()
	
	if ( animtime >= 0 && CurTime() > animtime && self:Clip1() > 0 ) then
		if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() && CLIENT ) then
			--vm:SendViewModelMatchingSequence( vm:LookupSequence( "shake" ) )
			if ( self:GetCharge() >= 80 ) then
				-- self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			else
			--	self:SendWeaponAnim( ACT_IDLE )
			end

			self:UpdateNextIdle()
		end
	end

	if ( CLIENT ) then
		if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( self:GetCharge() >= 25 ) && ( self:Clip1() > 0 ) && ( self.SciFiState == SCIFI_STATE_IDLE ) then
			if ( self:GetCharge() >= 10 ) then
				EmitSound( "weapons/moby/spinup.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_ITEM, 0.4, 60, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), math.Clamp( self:GetCharge() * 1.25, 50, 100 ) )
			--	self:EmitSound( "weapons/moby/spinup.wav", 60, math.Clamp( self.Charge * 1.25, 50, 100 ), 1, CHAN_ITEM ) 
			end
		end
		
		if ( self.Owner:KeyReleased( IN_ATTACK ) ) && ( self:GetCharge() >= 25 ) || ( self:Clip1() == 0 ) && ( self:GetNextPrimaryFire() < CurTime() ) then
			if ( self:GetCharge() >= 10 ) then
				EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_ITEM, 1, 60, bit.bor( SND_IGNORE_NAME, SND_STOP ), PITCH_NORM )
				self:EmitSound( "scifi.behemoth.spindn" )
			end
		end
	end

--	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:Deploy() 

	self:SetAds( false, self.Owner )

	self:SetCharge( 0 )
	
	return true
	
end

local cmd_advanims = GetConVar( "sfw_allow_advanims" )

function SWEP:CanPrimaryAttack()
	
	if ( !IsValid( self.Owner ) ) then return end
	
	if ( self.Owner:IsNPC() ) then
		return true
	end
	
	if ( self.GetSafeMode ) && ( self:GetSafeMode() ) then
		self:SetNextPrimaryFire( CurTime() + 0.1 )
		self:SetSafeMode( false )
		
		self:EmitSound( self.SafeModeOffSnd )
		self:SendWeaponAnim( ACT_VM_LOWERED_TO_IDLE )

		self.ViewModelIdleSequence = ACT_VM_IDLE
		
		return
	end
	
	if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
		return false
	end
	
	local bAnims = cmd_advanims:GetBool() 

	if ( self:Ammo1() < 1 ) then
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
		end
		
		if ( self.ReloadOnTrigger ) then
			self:Reload()
			self:SetNextPrimaryFire( CurTime() + 0.1 )
		else
			self:SetNextPrimaryFire( CurTime() + 0.2 )
--			self:SendWeaponAnim( ACT_VM_DRYFIRE )
		end

		return false
	end

	if ( self:GetSciFiState() == SCIFI_STATE_SPRINT ) && ( bAnims ) then
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
		end

		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end

	return true
	
end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack() ) then return end
	if ( self:GetCharge() < 80 || self.Owner:IsNPC() ) then return end

	self:SetNextPrimaryFire( CurTime() + 0.04 )	
	
	local viewmodel = self:GetViewModelEnt()
	
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector() + self.Owner:EyeAngles():Up() * ( self:GetSciFiACC() * 0.002 )
	bullet.Spread = Vector( .014, .014 ) + Vector( 1, 1 ) * ( self:GetSciFiACC() * 0.001 )
	bullet.Damage = math.random( 6, 8 ) * GetConVarNumber( "sfw_damageamp" )
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_BULLET )
	end

	self.Owner:FireBullets( bullet, false )

	if ( self:GetSciFiACC() > 25 && math.random( 0, 9 ) > 1 ) || ( self:GetSciFiACC() < 25 ) then		
		self:DoMuzzleEffect()
	end
	
	self:EmitSound( "cat.vk21hv.pfire" )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.1, -2 ), math.random( -0.1, -1 ), math.random( -0.1, -1 ) ) * ( self:GetSciFiACC() * 0.02 ) )
		-- self:TakePrimaryAmmo( 1 )
		
		self.Owner:RemoveAmmo( 1, self.Primary.Ammo )
	end
	
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	self:AddSciFiACC( 2 )

end

function SWEP:Reload()

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	if ( SERVER ) then return end

	if ( self:GetSciFiACC() > 25 && math.random( 0, 2 ) > 1 ) || ( self:GetSciFiACC() < 25 ) then
		ParticleEffect( "moby_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
	end
	
	if ( self.Owner:IsNPC() ) then return end
	if ( tr.MatType == MAT_GLASS ) then return end
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = tr.HitPos
		dlight.r = 255
		dlight.g = 210
		dlight.b = 190
		dlight.brightness = 1
		dlight.Decay = 2048
		dlight.Size = 128
		dlight.DieTime = CurTime() + 0.5
	end

end