AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "A relic of the Celestial's downfall, this living weapon is made from the remains of defiled Celestial bodies and weaponry."
SWEP.Instructions			= "Hold Mouse1 to fire. Hold reload to leech health from yourself and convert it into ammo. Additional ammunition will drop from enemies that die while suffering from Dark elemental status."
SWEP.ItemRank 				= 23

SWEP.ViewModel				= "models/weapons/c_scifip.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"
SWEP.HoldType 				= "pistol"
SWEP.HoldTypeNPC 			= "pistol"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 2
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.ViewModelFOV = 70

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_storm.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "InferiantCharge"

SWEP.VfxMuzzleParticle 		= "umbra_cast" 
SWEP.VfxMuzzleRule 			= 0
SWEP.VfxHeatParticle 		= "spectra_muzzle_overheat"
SWEP.VfxHeatThreshold 		= 0.8
SWEP.VfxHeatDelay 			= 0

SWEP.PrintName				= "I-DC Umbra"
SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModelSprintPos		= Vector( 4, 2, 0.8 )
SWEP.ViewModelSprintAng		= Angle( -15, -10, 20 )
SWEP.ViewModelShift = false

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8
SWEP.ChargeMax				= 150
SWEP.ChargeAdd				= 10
SWEP.ChargeDrain			= 4
SWEP.ChargeDeltaCompensate 	= true

SWEP.ViewModelMeleePos		= Vector( 6, 1, -6 )
SWEP.ViewModelMeleeAng		= Angle( 18, 40, -45 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.45
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.DepletedSND			= ""

SWEP.SciFiFamily			= { "custom", "nodas", "infammo" }
-- SWEP.SciFiWorldStats		= { 
	-- ["1"] = { text = "Damage: 				 4", color = Color( 180, 180, 180 ) },
	-- ["1a"] = { text = "Range:		220", color = Color( 180, 180, 180 ) },
	-- ["3"] = { text = "Damage type: 	Dark", color = Color( 100, 40, 20 ) },
	-- ["3a"] = { text = "Status Chance: 30%", color = Color( 180, 180, 180 ) },
	-- ["5"] = { text = "Fire rate: 				 5 (continuous)", color = Color( 180, 180, 180 ) },
	-- ["4"] = { text = "Energy drain: 	 min. 5 per sec.", color = Color( 180, 180, 180 ) },
	-- ["6"] = { text = "Recharge rate: 60", color = Color( 180, 180, 180 ) },
	-- ["6a"] = { text = "Attack has damage falloff.", color = Color( 180, 180, 180 ) },
	-- ["7"] = { text = "The weapon requires 'Impure Spectrum' to fuel its systems. Leech it from yourself or darkened enemies.", color = Color( 180, 180, 180 ) },
	-- ["7a"] = { text = "Dark damage is increased with each stack of dark status applied to a target.", color = Color( 180, 180, 180 ) },
	-- ["7b"] = { text = "Ammo consumption increases with each additional target hit.", color = Color( 180, 180, 180 ) },
	-- ["7c"] = { text = "Damage dealt to darkened targets will regenerate your health.", color = Color( 180, 180, 180 ) },
	-- ["9a"] = { text = "i   am       inferiant", color = Color( 105, 30, 40 ) }
-- }

SWEP.SciFiWorldStats		= { 
	Primary = {
		DamageAmount = 4,
		DamageAttackRange = 220,
		DamageType = DMG_SF_DARK,
		StatusChance = 30,
		FireRate = { 
			{ RateTitle = "continuous", RateDelay = 0.2 }
		},
		ChargeRate = 10,
	},
	Recoil = 0,
	PerkSet = { SCIFI_PERK_ELEMENTAL_DARK, SCIFI_PERK_CORRUPTED_RAVENOUS, SCIFI_PERK_RELOAD_RECHARGEAMMO_DARK, { PerkTitle = "I am Inferiant", PerkColor = Color( 105, 30, 40 ) } }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.muzzle"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 10, -80) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5, -20, -40) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -10, 0) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger5"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.244, 0.023, 1.475), angle = Angle(-8, -5.855, -90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, 4.375, 0.085), angle = Angle(-10, -5.855, 7.138), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, -0.11, -2.129), angle = Angle(-1, -5.855, 180), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} },
	["0+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 3.2, -2.25), angle = Angle(-2, -8, 90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.244, 0.023, 1.875), angle = Angle(-10, -5.855, -90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, 3.6, 0.085), angle = Angle(-10, -5.855, 7.138), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, -0.11, -2.129), angle = Angle(-10, -5.855, 180), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} },
	["0+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 3, -2.25), angle = Angle(-2, -10, 90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 2, bodygroup = {} }
}

SWEP.CanLeechFromDark = true

local cmd_particles = GetConVar( "sfw_fx_particles" )

util.PrecacheSound( "common/NULL.wav" )

local limb_1_hpos = Vector(9.244, 0.023, 1.2)
local limb_2_hpos = Vector(8.654, 3.375, 1.085)
local limb_3_hpos = Vector(8.654, -0.11, -2.129)
local limb_4_hpos = Vector(9, 3.2, -2.25)
local limb_1_hang = Angle(-8, -5.855, -80)
local limb_2_hang = Angle(-10, -5.855, 7.138)
local limb_3_hang = Angle(-1, -5.855, 180)
local limb_4_hang = Angle(-2, -8, 90)

local limb_1_mpos = Vector(2, -2, 0)
local limb_2_mpos = Vector(2, -0.1, 2)
local limb_3_mpos = Vector(2, -0.1, -2)
local limb_4_mpos = Vector(0, 2.4, 0)
local limb_1_mang = Angle(0, 20, -8)
local limb_2_mang = Angle(22, 0, -8)
local limb_3_mang = Angle(-22, 0, 8)
local limb_4_mang = Angle(0, -20, 0)

local hangle

local fNextParticleCast = 0

local mymat = Material( "models/weapons/spectra/spectra_bone_rotten.vmt" )

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

SWEP.DataTables = {
	{ dType = "Float", dName = "NextChargeAnim" },
	{ dType = "Float", dName = "NextCoreFxAnim" }
}

function SWEP:SubInit()

	self:SetCharge( 0 )
	self.ScifiRegenNext = 0
	
	self.GetSafeMode = nil

end

local cmd_damageamp = GetConVar( "sfw_damageamp" )
local bHasBeenLeeched = false
local iBaseDamage, iDrain, iLeech
local fReloadAnim = 0
local tIndex, pOwnerSP, pOwnerAV, pOwnerEA, fw, up, rt

local func_CreateRandomLight = function( id, dlightOrigin, brightess, size, r, g, b )

	local dlight = DynamicLight( id )
	if ( dlight ) then
		dlight.pos = dlightOrigin
		dlight.r = r
		dlight.g = g
		dlight.b = b
		dlight.brightness = brightness
		dlight.Decay = 2048
		dlight.Size = size
		dlight.Style = 1				
		dlight.DieTime = CurTime() + 1
		dlight.noworld = false
		dlight.nomodel = false
	end
		
end

function SWEP:Equip( NewOwner )

	if ( NewOwner:IsNPC() ) then
		if ( self.SciFiWorld ~= nil && self.SciFiWorld ~= "" ) then
			self:SetMaterial( self.SciFiWorld )
		end
	end

	if ( self.Owner:IsPlayer() ) then -- && !( NewOwner == self.LastOwner ) then
		self.Owner:GiveAmmo( 40, self.Primary.Ammo )
	end

end

local bDeployed = false
local dCharge = 0

function SWEP:Think()

--	if ( !IsValid( self.Owner ) ) then return end

	local animtime = self:GetNextChargeAnim()	
	local vm = self.Owner:GetViewModel()
	local fCharge = self:GetCharge()
	local cmod = fCharge * 0.0075
	local sine0 = math.sin( CurTime() * 2 ) * ( 0.2 + cmod )
	local sine1 = math.sin( CurTime() * 4 ) * ( 0.08 + cmod ) --* math.random( 0.01, 0.5 )
	local sine2 = math.cos( CurTime() * 6 ) * ( 0.2 ) --* math.random( 0.01, 0.5 )

	if ( CLIENT ) then
		if ( !bDeployed ) then
			self:StopParticles()
			ParticleEffectAttach( "umbra_core", PATTACH_POINT_FOLLOW, vm, vm:LookupAttachment("muzzle") )
			
			self:SendWeaponAnim( ACT_VM_IDLE )
			
			bDeployed = true
		end
	
		local fAnimSpeedFast, fAnimSpeedMedium = FrameTime() * 8, FrameTime() * 4
		
		local aSway = self:GetViewModelSway()
		local SwayActual = Angle( aSway.roll, aSway.pitch * 0.2, aSway.yaw * 0.4 )

		self.VElements[ "0" ].pos = limb_1_hpos + Vector( -sine0, sine2 - cmod, sine1 )
		self.VElements[ "0+" ].pos = limb_2_hpos + Vector( sine0, sine1, -sine2 + cmod )
		self.VElements[ "0++" ].pos = limb_3_hpos + Vector( sine0, -sine1, sine2 - cmod )
		self.VElements[ "0+++" ].pos = limb_4_hpos + Vector( -sine0, -sine1, sine2 - cmod )
		
		self.VElements[ "0" ].angle = limb_1_hang + SwayActual + Angle( -sine0, sine1, sine2 ) * cmod
		self.VElements[ "0+" ].angle = limb_2_hang + SwayActual + Angle( sine0, sine1, -sine2) * cmod
		self.VElements[ "0++" ].angle = limb_3_hang + SwayActual + Angle( sine0, -sine1, sine2 ) * cmod
		self.VElements[ "0+++" ].angle = limb_4_hang + SwayActual + Angle( -sine0, -sine1, sine2 ) * cmod

		if ( fCharge > 0 ) then
			self.VElements[ "0" ].pos = self.VElements[ "0" ].pos + limb_1_mpos * cmod
			self.VElements[ "0+" ].pos = self.VElements[ "0+" ].pos + limb_2_mpos * cmod
			self.VElements[ "0++" ].pos = self.VElements[ "0++" ].pos + limb_3_mpos * cmod
			self.VElements[ "0+++" ].pos = self.VElements[ "0+++" ].pos + limb_4_mpos * cmod

			self.VElements[ "0" ].angle = self.VElements[ "0" ].angle + limb_1_mang * cmod
			self.VElements[ "0+" ].angle = self.VElements[ "0+" ].angle + limb_2_mang * cmod
			self.VElements[ "0++" ].angle = self.VElements[ "0++" ].angle + limb_3_mang * cmod
			self.VElements[ "0+++" ].angle = self.VElements[ "0+++" ].angle + limb_4_mang * cmod
		end

		if ( fReloadAnim > 0 ) then
			local rmod = fReloadAnim * 0.4

			self.VElements[ "0" ].pos = self.VElements[ "0" ].pos - limb_1_mpos * rmod
			self.VElements[ "0+" ].pos = self.VElements[ "0+" ].pos - limb_2_mpos * rmod
			self.VElements[ "0++" ].pos = self.VElements[ "0++" ].pos - limb_3_mpos * rmod
			self.VElements[ "0+++" ].pos = self.VElements[ "0+++" ].pos - limb_4_mpos * rmod
		end
	end
	
	local iClip = math.min( self:Ammo1(), 100 )

	pOwnerSP = self.Owner:GetShootPos()
	pOwnerAV = self.Owner:GetAimVector()
	pOwnerEA = self.Owner:EyeAngles()
	fw, up, rt = pOwnerEA:Forward(), pOwnerEA:Up(), pOwnerEA:Right()

	if ( CLIENT ) then
		if ( self.Owner:ShouldDrawLocalPlayer() ) then
			vm = self || self.Owner:GetActiveWeapon()
		end
		
		local dlightOrigin = self:GetProjectileSpawnPos() 
		dlightOrigin = dlightOrigin + fw * 28
		
		local dlightScale = 1 * iClip + 128 * cmod
		
		func_CreateRandomLight( self:EntIndex(), dlightOrigin, 0.1 + cmod, dlightScale, 230, 30 + 30 * cmod, 10 + 30 * cmod )
		
		mymat:SetFloat( "$FleshBorderWidth", 0.7 - ( fCharge * 0.004 ) )
		mymat:SetFloat( "$FleshGlossBrightness", 0 + ( fCharge * 0.01 ) )
		mymat:SetVector( "$selfillumtint", Vector( 4, 2, 0.5 ) * ( 0.4 + cmod ) )
		mymat:SetVector( "$FleshBorderTint", Vector( 0.2, 0.04, 0.03 ) * ( fCharge * 0.3 ) )
		
		if ( fCharge > 0 ) then
			self.ViewModelBoneMods[ "ValveBiped.Bip01_R_UpperArm" ].angle = Angle( 0, 0, 0 ) + Angle( -3, -1, 0 ) * cmod
		end
	end
	
	local bSprint = ( self.SciFiState == SCIFI_STATE_SPRINT )
	
	if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && iClip > 0 ) && ( !bSprint ) then
		if ( self:GetCharge() < self.ChargeMax ) then
			self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end
	
	if ( !iLeech ) then
		iLeech = 0
	end
	
	if ( !iDrain ) || ( self.Owner:KeyPressed( IN_ATTACK ) ) then
		iDrain = 1
	end
	
	if ( CLIENT ) then
		if ( fCharge > 1 && dCharge == 0 ) then
			self:EmitSound( "scifi.umbra.growl" )
		end
		
		dCharge = fCharge
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( iClip > 0 ) && ( fCharge >= 90 ) then
		if ( bHasBeenLeeched ) then
			bHasBeenLeeched = false	
		end
		
		if ( CLIENT ) then
			if ( fNextParticleCast <= CurTime() ) then
				self:EmitSound( "scifi.umbra.hunt" )
		
				fNextParticleCast = CurTime() + 1
			end
			
			local seq = vm:LookupSequence( "fire" )
			vm:SendViewModelMatchingSequence( seq )
			
			self:SetAnimNextIdle( CurTime() + 0.2 )
		end
			
		if ( animtime >= 0 && CurTime() > animtime ) then
			if ( CLIENT ) then
				local pOwnerEA = self.Owner:EyeAngles()
				-- local fw = pOwnerEA:Forward()
				
				local dlightOrigin = self:GetProjectileSpawnPos() 
				dlightOrigin = dlightOrigin + fw * math.random( 32, 128 )
				
				local dlightScale = math.random( 1, 4 )
		
				func_CreateRandomLight( -1, dlightOrigin, 0.1 + cmod, dlightScale, 240, 30 + 30 * cmod, 20 - 10 * cmod )
			end
			
			if ( SERVER ) then
				tIndex = ents.FindInBox( pOwnerSP + up * -1 + rt * -0.1, pOwnerSP + fw * 280 + up * 1 + rt * 0.1 )
				
				fAmp = cmd_damageamp:GetFloat()
				
				iBaseDamage = 4 * fAmp
--				iDrain = math.max( iDrain * 0.5, 1 )
				
				for k, tEntity in pairs( tIndex ) do
					local tOwner = tEntity:GetOwner()
					if ( tEntity == self.Owner || tOwner == self.Owner ) || ( !tEntity:VisibleVec( pOwnerSP ) ) then
						continue
					end
					
					local tPosition = tEntity:EyePos()
					local oPosition = pOwnerSP + ( pOwnerAV * 12 )
					local tDistance = tPosition:Distance( oPosition )
					local fFalloff = math.min( 0.25 + ( 1 - ( tDistance * 0.0032 ) ), 1 )

					local iDmg = math.max( iBaseDamage * fFalloff, 1 )
					iDmg = math.Round( iDmg, 0 )

					if ( tEntity:IsPlayer() || tEntity:IsNPC() ) then
						self:DealDirectDamage( DMG_SF_DARK, iDmg, tEntity, self.Owner )

						local iStatus = math.random( 0, 100 )
						local iStatusMax = 60
						iStatusMax = iStatusMax - ( ( iDrain - 1 ) * 16 )
						iStatusMax = iStatusMax - ( 4 * fFalloff )

						if ( iStatus > iStatusMax ) then
							DoElementalEffect( { Element = EML_DARK, Target = tEntity, Attacker = self.Owner } )
						end
--print( 100 - iStatusMax, iDrain )
						iDrain = iDrain + 0.05 -- + 0.5
					else
						tEntity:TakeDamage( iDmg, self.Owner, self )
					end
				end

				iDrain = math.Clamp( iClip - ( iClip - iDrain ) , 0, iClip )

				self.Owner:RemoveAmmo( iDrain, self.Primary.Ammo )
			end
				
			self:DoMuzzleEffect()
			
			self:SetNextChargeAnim( CurTime() + 0.2 )
		end

		self.Owner:ViewPunch( Angle( -0.2 - 0.1 * sine2 * cmod, 0.04 * sine0 * cmod, 0 ) )
	end
		
	if ( self.Owner:KeyReleased( IN_ATTACK ) ) then
		if ( CLIENT ) && ( self:Clip1() > 0 ) then
			self:EmitSound( "scifi.umbra.rest" )
			
			local att = vm:LookupAttachment("muzzle")
			ParticleEffectAttach( "umbra_shutdown_flecks", PATTACH_POINT_FOLLOW, vm, att )
			
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )
		end
		
		self:SetAnimNextIdle( CurTime() + 0.4 )
	end
	
	if ( self.Owner:KeyDown( IN_RELOAD ) ) && ( iClip < self.Primary.ClipSize ) then
		if ( CLIENT ) then
			fReloadAnim = math.Clamp( fReloadAnim + 0.1 * self.ChargeDeltaFactor, 0, 1 )
		end

		if ( SERVER ) then
			fReloadAnim = math.Clamp( fReloadAnim + 0.1, 0, 1 )

			if ( self.ScifiRegenNext <= CurTime() ) then 
				self.Owner:GiveAmmo( 1, self.Primary.Ammo, true )
				
				iLeech = fReloadAnim + ( 1 - iClip * 0.01 ) * ( 0.015 + iDrain * 0.002 )
				
				local LeechInfo = DamageInfo()
				LeechInfo:SetDamage( iLeech )
				LeechInfo:SetDamageType( bit.bor( DMG_FALL, DMG_PREVENT_PHYSICS_FORCE ) )
				LeechInfo:SetAttacker( self.Owner )
				LeechInfo:SetInflictor( self )
				LeechInfo:SetDamageForce( Vector( 0, 0, 0 ) )
				self.Owner:TakeDamageInfo( LeechInfo )
				
--				local iStatus = math.random( 0, 100 )
--				if ( iStatus > 95 ) then
--					DoElementalEffect( { Element = EML_DARK, Target = self.Owner, Attacker = self.Owner } )
--				end
				
				local iHealth, iMaxHealth
				iHealth = self.Owner:Health()
				iMaxHealth = self.Owner:GetMaxHealth()
				
				fHealth = iHealth / iMaxHealth
				
				local fBuffer = math.sin( fHealth + ( 1 - iClip * 0.01 ) )

				local delay = 0.2 * ( 1.4 - fReloadAnim * fBuffer )
				
				if ( self.Owner:HasGodMode() ) then
					delay = 0.01
				end
				
				self.ScifiRegenNext = CurTime() + delay
			end
		end
	else
		iLeech = 0
		
		if ( fReloadAnim > 0 ) then
			fReloadAnim = math.max( fReloadAnim - FrameTime() * 4, 0 )
		end
	end
	
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:Deploy()  

	self:SetAds( false )
	self:SetCharge( 0 )	
	self.ScifiRegenNext = CurTime() + 1
	
	self.SciFiState = SCIFI_STATE_IDLE
	self.SciFiMeleeCharge = 0

	local vm = self:GetViewModelEnt()
	if ( SERVER ) || ( !game.SinglePlayer() && CLIENT ) then
		self:StopParticles()
		ParticleEffectAttach( "umbra_core", PATTACH_POINT_FOLLOW, vm, vm:LookupAttachment("muzzle") )
		
		-- deprecated? --
		bDeployed = false

--		fNextParticleCast = CurTime() + 2
	end

	return true
	
end

function SWEP:ResetDeployment()

	self:SetAds( false )
	self:EmitSound( "BaseGrenade.StopSounds" )
	
	local wOwner = self.Owner 

	if ( !wOwner || !IsValid( wOwner ) ) then
		wOwner = self.LastOwner
		
		if ( SERVER ) && ( wOwner ) then
			net.Start( "SciFiUpdateOwnership" )
			net.WriteEntity( wOwner )
			net.Send( wOwner )
		end
	end

	if ( IsValid( wOwner ) && CLIENT && wOwner:IsPlayer() ) then
		local vm = wOwner:GetViewModel()

		if ( IsValid( vm ) ) then 
			vm:SetSubMaterial( 0, "" )
			vm:SetSubMaterial( 1, "" )
			vm:SetSubMaterial( 2, "" )
			vm:SetSubMaterial( 3, "" )
			vm:SetSubMaterial( 4, "" )
			
			self:ResetBonePositions( vm )
			vm:StopParticles()
		end
	end
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( IsValid( self.Owner ) ) && ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
			vm:StopParticles()
		end
	end
	
	if ( SERVER ) || ( !game.SinglePlayer() && CLIENT ) then
		self:StopParticles()
	end
	
	self:ResetDeployment()
	self:SetSciFiACC( 4 )
	
	bDeployed = false
	
	return true

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( event == 6001 ) then 
		return true 
	end

	if ( event == 21 || event == 22 ) then
		return true
	end

end

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()

	if ( SERVER ) then
		self:SendWeaponAnim( ACT_VM_IDLE )
	end
	
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

end