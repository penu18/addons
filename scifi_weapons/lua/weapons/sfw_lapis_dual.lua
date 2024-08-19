AddCSLuaFile()
AddCSLuaFile( "base/scifi_techs.lua" )
include( "base/scifi_techs.lua" )
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

PrecacheParticleSystem( "lapis_d_vent" )

SWEP.Spawnable = false

SWEP.ViewModel 				= "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_elite.mdl"
SWEP.SciFiSkin 				= "vgui/white"
SWEP.ItemRank 				= 6

SWEP.HoldType 				= "duel"
SWEP.HoldTypeNPC 			= "duel"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 1.4

SWEP.Primary.ClipSize		= 48
SWEP.Primary.DefaultClip	= 48
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.VfxMuzzleParticle 		= "_wraithgun_muzzle"
SWEP.VfxMuzzleAttachment 	= "1"
SWEP.VfxMuzzleColor 		= Color( 80, 70, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 620

SWEP.PrintName				= "Dual AQM"
SWEP.Slot					= 1
SWEP.SlotPos				= 1
SWEP.ViewModelFOV			= 72

SWEP.AdsPos 				= Vector( 0, 0, 0 )
SWEP.AdsAng 				= Vector( 0, 0, 0 )
SWEP.AdsFov					= 56
SWEP.AdsFovTransitionTime	= 0.24

SWEP.SciFiMeleeRange		= 56
SWEP.SciFiMeleeDamage		= 8
SWEP.ViewModelMeleePos		= Vector( 6, -2, -16 )
SWEP.ViewModelMeleeAng		= Angle( 46, 42, -40 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( 0, 0.6, -1 )
SWEP.ViewModelReloadAng		= Angle( -10, 0, 0 )

SWEP.ViewModelSprintPos 	= Vector( 0, -1, 2 )
SWEP.ViewModelSprintAng		= Angle( -24, 0, 0 )
SWEP.ViewModelShift = false

SWEP.DepletedSND			= "scifi.storm.dryfire"
SWEP.ReloadSND				= "Weapon_SMG1.Reload" 
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadOnTrigger 		= false
SWEP.ReloadTime 			= 3
SWEP.ReloadPlaybackRate  	= 1.1
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 10", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x2", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Energy", color = Color( 80, 180, 255 ) },
	["4"] = { text = "Clip size: 					48", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				8 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Pew, pew, pew!", color = Color( 180, 180, 180 ) },
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 10,
		DamageType = DMG_SF_VAPOR,
		CritMul = 2,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.075 }, 
		},
	},
	ClipSize = 48,
	ReloadSpeed = 3,
	Recoil = 8,
	PerkSet = { SCIFI_PERK_AMMO_HIGHCAL }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -1, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -1, 0 ), angle = Angle( 0, 0, 0 ) },
	["v_weapon.elite_left"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -2.5 ), angle = Angle( 0, 0, 0 ) },
	["v_weapon.elite_right"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -2.5 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.WorldModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 10, 40 ) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 10, 40 ) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 10, 40 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 10, 40 ) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 10, 40 ) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 10, 40 ) }
}

SWEP.VElements = {
	["lparent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.elite_left", rel = "", pos = Vector( 0.4, -3.5, 2 ), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["l0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "lparent", pos = Vector(-1, 0.4, 6), angle = Angle(180, 90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["l0b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "lparent", pos = Vector(0.6, -1.75, 6), angle = Angle(180, -90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["l2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.base", rel = "lparent", pos = Vector(-0.8, 2, 5), angle = Angle(0, -180, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["l7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/obsidian_barrel.mdl", bone = "ValveBiped.base", rel = "lparent", pos = Vector(-0.22, -0.6, 2), angle = Angle(0, 0, 90), size = Vector(0.25, 0.3, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["l8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/stalkerpod_lid.mdl", bone = "Base", rel = "lparent", pos = Vector(-0.22, -1.2, -1.2), angle = Angle(-90, 90, 0), size = Vector(0.3, 0.2, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["l5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "lparent", pos = Vector(0.62, -1.4, 1.2), angle = Angle(-78.888, -22, -100), size = Vector(1.05, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["l4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "ValveBiped.base", rel = "lparent", pos = Vector(-0.2, -1.4, 0.5), angle = Angle(0, -90, 180), size = Vector(0.06, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} },

	["rparent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.elite_right", rel = "", pos = Vector( 0.4, -3.5, 2 ), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["r0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "rparent", pos = Vector(-1, 0.4, 6), angle = Angle(180, 90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["r0b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "rparent", pos = Vector(0.6, -1.75, 6), angle = Angle(180, -90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["r2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.base", rel = "rparent", pos = Vector(-0.8, 2, 5), angle = Angle(0, -180, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["r7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/obsidian_barrel.mdl", bone = "ValveBiped.base", rel = "rparent", pos = Vector(-0.22, -0.6, 2), angle = Angle(0, 0, 90), size = Vector(0.25, 0.3, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["r8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/stalkerpod_lid.mdl", bone = "Base", rel = "rparent", pos = Vector(-0.22, -1.2, -1.2), angle = Angle(-90, 90, 0), size = Vector(0.3, 0.2, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["r5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "rparent", pos = Vector(0.62, -1.4, 1.2), angle = Angle(-78.888, -22, -100), size = Vector(1.05, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["r4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "ValveBiped.base", rel = "rparent", pos = Vector(-0.2, -1.4, 0.5), angle = Angle(0, -90, 180), size = Vector(0.06, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} }
}

local snd_fire_lowclip = Sound( "weapons/pistol/pistol_empty.wav" )

function SWEP:SubInit()

end

local stock_hpos = Vector(-0.25, -1.2, -1.2)
local fStockOffset = 0
local fTimeOffset = 0

local cmd_particles = GetConVar( "sfw_fx_particles" )

local dState
local vmEntity, vmAttach

function SWEP:Think()

	local fNextPFire = self:GetNextPrimaryFire() - ( CurTime() + FrameTime() )
	fNextPFire = fNextPFire * self.ChargeDeltaFactor

	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
		if ( CLIENT ) && !( dState == SCIFI_STATE_RELOADING ) then			
			if ( self.Owner:ShouldDrawLocalPlayer() ) then
				vmEntity = self || self.Owner:GetActiveWeapon()
			else
				vmEntity = self.Owner:GetViewModel()
			end
			
			ParticleEffectAttach( "lapis_d_vent", PATTACH_POINT_FOLLOW, vmEntity, 1 )
			ParticleEffectAttach( "lapis_d_vent", PATTACH_POINT_FOLLOW, vmEntity, 2 )
		end
		
		if ( fNextPFire > 2.6 && fNextPFire < 3.4 ) then
			fStockOffset = Lerp( FrameTime() * 8, fStockOffset, 1 )
		end
		
		if ( fNextPFire < 0.9 ) then
			fStockOffset = Lerp( FrameTime() * 8, fStockOffset, 0 )
		end
		
		local stockL = self.VElements[ "l8" ]
		stockL.pos = stock_hpos + Vector( 0, 0, -2 ) * fStockOffset
		
		local stockR = self.VElements[ "r8" ]
		stockR.pos = stock_hpos + Vector( 0, 0, -2 ) * fStockOffset
	end
	
	if ( self.SciFiState == SCIFI_STATE_ADS ) && !( dState == SCIFI_STATE_ADS ) then
		self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 3, 0 ), angle = Angle( 0, 0, 10 ) }
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 3, 0 ), angle = Angle( 0, 0, -10 ) }
		self.ViewModelBoneMods["v_weapon.elite_left"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -1, -0.5 ), angle = Angle( 0, 10, 0 ) }
		self.ViewModelBoneMods["v_weapon.elite_right"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1, -0.5 ), angle = Angle( 0, -10, 0 ) }
	end
	
	if !( self.SciFiState == SCIFI_STATE_ADS ) && ( dState == SCIFI_STATE_ADS ) then
		self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -1, 0 ), angle = Angle( 0, 0, 0 ) }
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -1, 0 ), angle = Angle( 0, 0, 0 ) }
		self.ViewModelBoneMods["v_weapon.elite_left"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -2.5 ), angle = Angle( 0, 0, 0 ) }
		self.ViewModelBoneMods["v_weapon.elite_right"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -2.5 ), angle = Angle( 0, 0, 0 ) }
	end

	dState = self.SciFiState
	
	self:Anims()
	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	local vm = self:GetViewModelEnt()
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 1.5 )
	end

	if ( event == 5001 || event == 5011 || event == 20 ) then
		return true
	end

end

function SWEP:Attack()
	
	local cmdDamage = GetConVarNumber( "sfw_damageamp" )
	
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	local iSelf = self:EntIndex()
	local attach
	if ( self.RightHand ) then
		attach = 1
	else
		attach = 2
	end
	
	local pOwnerEA = self.Owner:EyeAngles()

	if ( !vmEntity ) then
		vmEntity = self:GetViewModelEnt()
	end
	
	local entOffset = pOwnerEA:Right() * -20 * ( 1 - attach )
	local entOrigin = self:GetProjectileSpawnPos() - entOffset
	
	if ( SERVER ) then
		local ent = ents.Create( "lapis_pfire" )
		if ( !IsValid( ent ) ) then return end
		if (self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( entOrigin )
		else
			ent:SetPos( pOwnerSP + ( pOwnerAV * 8 ) )
		end
		ent:SetAngles( pOwnerEA )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local vSpread = self:GetProjectileSpreadVector() * ( 4 + self:GetSciFiACC() ) + Vector( 0, 0, 3 ) * self:GetSciFiACC()
		if( self.Owner:IsNPC() ) then
			vSpread = Vector( 0, 0, 0 )
		end
		
		local assist = ( Vector( 2.14, -9.5, 0 ) + entOffset )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * 7200 + vSpread + assist )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.8, -1.2 ), 0, 0 ) * ( 1 + self:GetSciFiACC() * 0.05 ) )
		self:AddSciFiACC( 8 )
	end

	self:EmitSound( "scifi.wraithshot.fire" )
	self:EmitSound( "scifi.wraithshot.fire.echo" )

	self:TakePrimaryAmmo( 1 )
	
end

function SWEP:Muzzle()
	
	local vmEntity = self:GetViewModelEnt()
	local iClip = self:Clip1()
	
	if ( self.RightHand ) then
		self.VfxMuzzleAttachment = "1"
		
		local seq = "shoot_right1"
		
		if ( iClip < 3 ) then
			seq = "shoot_rightlast"
		end
		
		vmEntity:SetSequence( seq )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	else
		self.VfxMuzzleAttachment = "2"
	
		local seq = "shoot_left1"
		
		if ( iClip < 3 ) then
			seq = "shoot_leftlast"
		end
		
		vmEntity:SetSequence( seq )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	end
	
	if ( iClip < 1 ) then return end

	local vmAttachMuzzle = vmEntity:LookupAttachment( self.VfxMuzzleAttachment )
	
	ParticleEffectAttach( "_wraithgun_muzzle", 4, vmEntity, vmAttachMuzzle )
	
	self:DrawMuzzleLight( "80 70 255 255 ", 160, 620, 0.06 )

end

function SWEP:PrimaryAttack()

	self:SetNextPrimaryFire( CurTime() + 0.075 )
	
	if ( self.RightHand ) then
		self.RightHand = false
		self.LeftHand = true
	else
		self.RightHand = true
		self.LeftHand = false
	end

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	self:Muzzle()
	self:Attack()

end

function SWEP:OnReloadFinish()

	if ( !game.SinglePlayer() && CLIENT ) || ( SERVER ) then
		self:EmitSound( "scifi.asa6.reload.bback" )
		timer.Simple( math.random( 0.01, 0.04 ), function()
			self:EmitSound( "scifi.asa6.reload.bback" )
		end )
	end

end