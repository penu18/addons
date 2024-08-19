AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "A modified HS24 rifle. It lost its diverse firemodes in exchange for chemical munitions support and a charging functionality."
SWEP.Instructions			= "Press mouse1 to fire. Hold mouse1 to charge. Hold mouse2 to aim down sights. Hold 'R' while releasing mouse1 to cancel a charged shot."
SWEP.ItemRank 				= 21

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.SciFiSkin				= "models/weapons/festive/hw_skin"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_edit.vmt"

if ( CLIENT ) then
	SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_arain.vmt" )
end

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "ar2"

SWEP.VfxMuzzleParticle 		= "pest_muzzle"
SWEP.VfxMuzzleColor 		= Color( 200, 255, 100, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720

SWEP.PrintName				= "HS24-K1 'Pandemic'"
SWEP.Slot					= 2
SWEP.SlotPos				= 2

SWEP.ReloadACT 				= ACT_VM_RELOAD

SWEP.ChargeMax				= 80
SWEP.ChargeAdd 				= 1.4
SWEP.ChargeDrain 			= 2
SWEP.ChargeSyncFactor 		= 1.8

SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.5
SWEP.SprintAnimSpeed		= 10

SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelSprintSway 	= 4

SWEP.ViewModelSprintPos		= Vector( 2, 0.2, -1 )
SWEP.ViewModelSprintAng		= Angle( -8, 30, -15 )

SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.2
SWEP.ViewModelShiftOffset 	= Vector( 0, -0.04, -0.09 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )

SWEP.SciFiFamily			= { "elemental", "hitscanbullets", "phys", "enerbow_cbeam", "ads", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 6", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Corrosive, Bullet", color = Color( 200, 255, 110 ) },
	["3a"] = { text = "Status Chance: 20%", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Clip size: 					33", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				9.0", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Charged projectiles home in on targets.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Has a chance to corrode enemies.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Corroding targets will take more damage.", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Weapon can be charged if the trigger is held down.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 6,
		DamageType = { DMG_BULLET, DMG_SF_CORROSIVE },
		CritMul = 2,
		StatusChance = 20,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.04 }
		},
	},
	Secondary = {
		DamageComposition = "6, 6",
		DamageAmount = 9,
		DamageBlastRadius = 64,
		DamageType = { DMG_POISON, DMG_SF_CORROSIVE },
		StatusChance = 100,
		FireRate = { 
			{ RateTitle = "burst", RateDelay = 0.2 }
		},
		ChargeRate = 1.4
	},
	CoreRechargeRate = nil,
	ClipSize = 40,
	ReloadSpeed = 2.4,
	Recoil = 2,
	PerkSet = { SCIFI_PERK_ELEMENTAL_CORROSIVE, SCIFI_PERK_AMMO_TOXIC, SCIFI_PERK_TARGETING_SMART }
}

SWEP.AdsPos 				= Vector(-4.95, 0, 1.159)
SWEP.ViewModelHomePos		= Vector( 0, 1, 0)

SWEP.NPCAccuracy 			= 14
SWEP.NPCSkillLevel 			= 1
SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 1

-- Colors for holographic sight --
local color_visor_default = Color( 120, 255, 60, 255 ) 	-- default white
local color_visor_warning = Color( 255, 45, 15, 255 ) 		-- saturated red
local color_visor_error =  Color( 255, 10, 30, 255 )		-- decent yellow

local snd_charge = Sound( "weapons/vapor/idleloop.wav" )
local snd_chargefire

if ( IsMounted( "ep2" ) ) then

	sound.Add( {
		name = "scifi.panda.chargefire",
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 70,
		pitch = {95, 105},
		sound = "npc/antlion/antlion_shoot2.wav"
	} )

	
	snd_chargefire = "scifi.panda.chargefire"
else
	snd_chargefire = "scifi.seraph.fire1"
end

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 2, 0, 3 ), angle = Angle( 0, 0, 0 ) },
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1, 0 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "Base", rel = "", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/healthvial.mdl", bone = "Base", rel = "", pos = Vector(-0.09, -0.098, 11.967), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/lab_flourescentlight002b.mdl", bone = "Base", rel = "", pos = Vector(0.963, 1.616, 10.572), angle = Angle(0, 0, 90), size = Vector(0.112, 0.029, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "Base", rel = "", pos = Vector(5.015, 68.08, -10.5), angle = Angle(180, 0, -90), size = Vector(0.86, 0.9, 1.095), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt1", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "Base", rel = "", pos = Vector(-0.005, 1, 5), angle = Angle(0, 0, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/festive/capac", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(0.3, 4, 20), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/festive/lowerbarrel", skin = 0, bodygroup = {} },
	["holo_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 5), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_dots_arc", skin = 0, bodygroup = {} },
	["holo_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/festive/holo_point", skin = 0, bodygroup = {} },
	["holo_3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/festive/holo_point", skin = 0, bodygroup = {} },
	["holo_4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 6.25), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/festive/holo_lines", skin = 0, bodygroup = {} },
	["holo_5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(-0.1, -3.05, 5.5), angle = Angle(0, -90, 0), size = Vector(0.02, 0.02, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_disp_error", skin = 0, bodygroup = {} },
	["holo_glass"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "Base", rel = "", pos = Vector(0.03, -3.05, 5), angle = Angle(0, -90, 0), size = Vector(0.018, 0.018, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/festive/sight_glass_broken", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "Base", rel = "", pos = Vector(0.03, -2.75, 5), angle = Angle(0, -90, 180), size = Vector(0.025, 0.025, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "Base", rel = "", pos = Vector(0, 0.181, 19), angle = Angle(0, 160, 90), size = Vector(0.314, 0.414, 0.314), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/festive/barrel", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.25, -5), angle = Angle(165, 10, 8), size = Vector(1.303, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11, 0.6, -6), angle = Angle(-105, 0, 0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/hw_case_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 5.2, 78), angle = Angle(0, 90, 192), size = Vector(0.8, 1.12, 1.295), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.8, -3.8), angle = Angle(0, -90, -103), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/festive/capac", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19, 2, -3.2), angle = Angle(0, -90, 75), size = Vector(0.081, 0.081, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/festive/lowerbarrel", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.4, -8.7), angle = Angle(80, 0, 0), size = Vector(0.035, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, 0.4, -9), angle = Angle(0, 90, 14), size = Vector(0.404, 0.454, 0.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/festive/barrel", skin = 0, bodygroup = {} }
}


SWEP.DataTables = {
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Int", dName = "BurstCount" },
	{ dType = "Float", dName = "NextChargeAnim" },
	{ dType = "Float", dName = "NextCoreFxAnim" }
}

function SWEP:SubInit()

	self:SetCharge( 0 )

end

function SWEP:Think()

	local iClip = self:Clip1()
	local fCharge = self:GetCharge()
	local animtime = self:GetNextChargeAnim()
	local vm = self.Owner:GetViewModel()
	local fNextPFire = self:GetNextPrimaryFire()
	
	if ( iClip == self.Primary.ClipSize && self.Owner:KeyDown( IN_RELOAD ) ) then
		if ( SERVER ) then
			self:SetCharge( 0 )
			self:SendWeaponAnim( ACT_VM_IDLE )
		end
		
		self:SetNextPrimaryFire( CurTime() + 0.5 )	
		self:SetNextChargeAnim( CurTime() + 0.5 )
		
		return
	end

	if ( self.Owner:KeyReleased( IN_ATTACK ) ) then
		if ( self:GetNextPrimaryFire() <= CurTime() ) && ( self:CanPrimaryAttack( 0 ) ) then
			self:StopParticles()
			
			if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
				if ( fCharge >= self.ChargeMax ) then
				--	self:HwaveCharged()
				--	self:SetNextPrimaryFire( CurTime() + 0.18 )	
					self:SetBurstMode( true )
				else
					self:HwaveFire()
					self:SetNextPrimaryFire( CurTime() + 0.1 )	
				end
			end
			
			self:SetCharge( 0 )
		-- else
			-- if ( SERVER ) then
				-- vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )
			-- end
		end
	end
	
	if ( self:GetBurstMode() ) && ( SERVER || !game.SinglePlayer() ) then
		local iMaxBurst = math.min( iClip / 3, 3 )
		iMaxBurst = math.abs( iMaxBurst )

		if ( iMaxBurst < 1 ) then 
			self:SetBurstMode( false )
			self:SetBurstCount( 0 )
		end
		
		if ( fNextPFire < CurTime() && fNextPFire > -1 ) then
			if ( self:GetBurstCount() <= 3 ) && ( fNextPFire ~= -1 ) then
				self:HwaveCharged()
				
				if ( self:GetBurstCount() >= iMaxBurst ) then 
					self:SetBurstMode( false )
					self:SetBurstCount( 0 )
				end
				
				self:SetBurstCount( self:GetBurstCount() + 1 )

				self:SetNextPrimaryFire( CurTime() + 0.11 )
			end
			
			if ( self:GetBurstCount() >= iMaxBurst ) then
				self:SetNextPrimaryFire( CurTime() + 0.2 )
				self:SetBurstMode( false )
				self:SetBurstCount( 0 )
			end
		end	
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && iClip > 0 ) then
		if ( self:CanPrimaryAttack() ) then
			if ( self:GetCharge() < self.ChargeMax ) then
				self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
			end
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end
	
	if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( fCharge >= 20 ) && ( self:GetNextPrimaryFire() + 0.22 <= CurTime() ) then
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() && CLIENT ) then
				if ( fCharge >= self.ChargeMax ) then 
					ParticleEffectAttach( "panda_charged", 4, vm, vm:LookupAttachment("muzzle") ) 
				else
					ParticleEffectAttach( "panda_charge", 4, vm, vm:LookupAttachment("muzzle") ) 
				end
			end
		end
		
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( SERVER ) then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "shake" ) )
			end

			self:SetNextChargeAnim( CurTime() + 0.18 * self.ChargeDeltaFactor )
		end
	
		if ( CLIENT ) then
			if ( fCharge >= 20 ) then
				local dlight = DynamicLight( self:EntIndex() )

				if ( dlight ) then
					dlight.pos = self:GetProjectileSpawnPos() + self.Owner:EyeAngles():Forward() * 32
					dlight.r = 190
					dlight.g = 255
					dlight.b = 20
					dlight.brightness = self:GetCharge() / 150
					dlight.Decay = 2048
					dlight.Size = 512 * ( self:GetCharge() / 150 )
					dlight.Style = 1
					dlight.DieTime = CurTime() + 1
					dlight.noworld = false
					dlight.nomodel = false
				end
			
				EmitSound( snd_charge, self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), math.Clamp( fCharge * 1, 1, 100 ) )
			end
		end
	end
	
	if ( self:GetNextPrimaryFire() > CurTime() ) && ( self.SciFiState != SCIFI_STATE_SPRINT ) then
		self:SetCharge( 0 )
	end
		
	if ( CLIENT ) then
		if ( self.Owner:KeyReleased( IN_ATTACK ) ) then
			EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, self.Owner:EntIndex(), 60, bit.bor( SND_IGNORE_NAME, SND_STOP ), PITCH_NORM )
		end
	end

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:Deploy() 

	self:SetAds( false, self.Owner )

	self:SetCharge( 0 )	
	self.SciFiState = SCIFI_STATE_IDLE
	self.SciFiMeleeCharge = 0
	
	return true
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:HwaveFire()

	local viewmodel = self:GetViewModelEnt()
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector() + self.Owner:EyeAngles():Up() * ( self:GetSciFiACC() * 0.002 )
	bullet.Spread = Vector( .02, .02 ) + Vector( 1, 1 ) * ( self:GetSciFiACC() * 0.001 )
	bullet.Tracer = 1
	bullet.Force = 4
	bullet.HullSize = 1
	bullet.Damage = 6 * GetConVarNumber( "sfw_damageamp" )
--	bullet.AmmoType = "SciFiAmmo"
	bullet.TracerName = "pest_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_NERVEGAS ) )
		if ( SERVER ) && ( GetRelChance( 20 ) ) then
			DoElementalEffect( { Element = EML_CORROSIVE, Target = tr.Entity, Attacker = attacker, Inflictor = dmginfo:GetInflictor() } )
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.55, -1 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 2.4 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.pandemic.pfire" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	self:AddSciFiACC( 2 )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:HwaveCharged()

	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
		local ent = ents.Create( "panda_pfire" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 1024 + self:GetProjectileSpreadVector() * 4 )
		
		if ( self.Owner:IsNPC() && IsValid( self.Owner:GetEnemy() ) ) then
			ent:SetMTarEntity( self.Owner:GetEnemy() )
		end
		
		self:TakePrimaryAmmo( 3 )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.25, -2 ), math.random( -0.03, 0.03 ), 0 ) )
		self:AddSciFiACC( 2.4 )
	end
	
	ParticleEffectAttach( "panda_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	
	self:DrawMuzzleLight( "200 255 100 220", 140, 720, 0.075 )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )

	self:EmitSound( snd_chargefire )
	self:EmitSound( "cat.pest.pfire" )

	self:AddSciFiACC( 3 )
	
end

SWEP.NpcBehaviorUseCharged = true
SWEP.NpcBehaviorCount = 0

function SWEP:PrimaryAttack()

	if ( !self.Owner:IsNPC() ) then return end
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	
	if ( self.NpcBehaviorUseCharged ) then
		-- ParticleEffectAttach( "panda_charge", PATTACH_POINT_FOLLOW, self, 1 )
		-- self:EmitSound( snd_charge ) 
		
		local sTimerName = self.Owner:EntIndex() .. "_npc_pandemic_burst"
		
		timer.Create( sTimerName, 0.11, 3, function()
			if ( !IsValid( self.Owner ) ) then
				timer.Destory( sTimerName )
				return
			end
			
			self:HwaveCharged()
			
			self.NpcBehaviorUseCharged = false
		end )

		self:SetNextPrimaryFire( CurTime() + 1 )
		self.Owner:SetSaveValue( "m_flLastAttackTime", ( CurTime() + 1 ) * -1 )
		self.Owner:SetSaveValue( "m_flNextAttack", 1 )
	else
		if ( self.NpcBehaviorCount < 4 ) then
			self.NpcBehaviorCount = self.NpcBehaviorCount + 1
		else
			self.NpcBehaviorCount = 0
			self.NpcBehaviorUseCharged = true
		end
		
		self:HwaveFire()

		self:SetNextPrimaryFire( CurTime() + 0.04 )
		self.Owner:SetSaveValue( "m_flLastAttackTime", ( CurTime() + 0.04 ) * -1 )
		self.Owner:SetSaveValue( "m_flNextAttack", 0.04 )
	end

end

function SWEP:SecondaryAttack()

end

function SWEP:OnReload()
	
	self:SetBurstMode( false )
	
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	if ( SERVER ) then return end

	ParticleEffect( "pest_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
	
	if ( self.Owner:IsNPC() ) then return end
	if ( tr.MatType == MAT_GLASS ) then return end
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = tr.HitPos
		dlight.r = 190
		dlight.g = 255
		dlight.b = 2
		dlight.brightness = 2
		dlight.Decay = 2048
		dlight.Size = 256
		dlight.DieTime = CurTime() + 0.5
	end

	sound.Play( "cat.pest.hit", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
	util.Decal( "yellowblood", tr.HitPos + tr.HitNormal / 10, tr.HitPos - tr.HitNormal / 10 )

end