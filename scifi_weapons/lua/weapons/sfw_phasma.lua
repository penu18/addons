AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.NpcSpawnFlags 			= {}

local fnMathRandom 			= math.random
local fnMathMin 			= math.min
local fnMathMax 			= math.max
local fnMathAbs 			= math.abs
local fnMathPi 				= math.pi
local fnMathRad 			= math.rad
local fnMathSin 			= math.sin
local fnMathCos 			= math.cos
local fnMathTan 			= math.tan
local fnMathRound 			= math.Round
local fnMathTruncate 		= math.Truncate
local fnMathClamp 			= math.Clamp
local fnMathApproach 		= math.Approach
local fnMathAngleDifference = math.AngleDifference

local fnGameTime = CurTime
local fnFrameTime = FrameTime

local cmd_damageamp = GetConVar( "sfw_damageamp" )
local overpower = GetConVar( "sfw_sk_phasma_enableoverpower" )
local stealthfinisher = GetConVar( "sfw_allow_stealthfinishers" )

SWEP.PrintName				= "C-AE Phasma"

SWEP.Purpose				= "The Celestial Ascendant's trade mark melee weapon. Providing offensive as well as defensive aspects, the Phasma can adapt to any combat situation."
SWEP.Instructions			= "Mouse1 to strike. Holding down Mouse1 will vary the type of attack used. Mouse2 to perform a forward leap with narrowed range but increased damage.\nPress 'Use' (def. E) + Mouse2 to switch to shield mode. The shield will absorb health damage taken. Press Mouse1 in shield mode to perform a counter attack."
SWEP.ItemRank 				= 25

SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.ViewModel				= "models/weapons/c_arms.mdl"
SWEP.WorldModel				= "models/weapons/w_knife_t.mdl"
SWEP.HoldType 				= "knife"
SWEP.HoldTypeSprint			= "normal"
SWEP.HoldTypeNPC 			= "melee"
SWEP.DeploySpeed 			= 1.25

SWEP.ViewModelSwayDirection = Vector( -2.25, 5, 0.1 )
SWEP.ViewModelSprintRatio 	= 1.6
SWEP.ViewModelSprintSway 	= 4
SWEP.SprintAnimSpeed		= 14
SWEP.DefaultSwayScale		= 2.0
SWEP.DefaultBobScale		= 4
SWEP.ViewModelFOV			= 64
SWEP.Weight					= 1

SWEP.MidairRecoilMul		= 1

SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 250
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SciFiEnergy"

SWEP.Secondary.Automatic	= true

SWEP.ReloadTime				= 0.1
SWEP.ReloadSND				= ""
SWEP.ReloadACT				= ACT_VM_RELOAD

if ( owerpower == 1 ) then
	SWEP.ChargeMax 			= 10000000
else
	SWEP.ChargeMax 			= 250
end

SWEP.SciFiFamily			= { "custom", "melee_simple", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 			     30", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 		     --", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	 Phaseblade", color = Color( 180, 10, 35 ) },
	["4"] = { text = "Attack speed: 	 (max.) 0.9", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Range: 			        48 - 72 units", color = Color( 180, 180, 180 ) },
	["6a"] = { text = "Inflicts up to 2 damage instances on a single target.", color = Color( 180, 180, 180 ) },
	["6b"] = { text = "Damages nearby targets when in very close range.", color = Color( 180, 180, 180 ) },
	["6c"] = { text = "Combined strikes can leap attacks can drastically increase damage output.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Alt. damage: 		  --", color = Color( 180, 180, 180 ) },
	["8a"] = { text = "Alt. damage-type: Blight", color = Color( 215, 160, 255 ) },
	["9"] = { text = "Alt. max. charge:  250", color = Color( 180, 180, 180 ) },
	["9a"] = { text = "Alt. range: 			  48 - 256 (in cone)", color = Color( 180, 180, 180 ) },
	["9b"] = { text = "Alt. damage and range are based on absorbed damage.", color = Color( 180, 180, 180 ) },
	["9c"] = { text = "The more damage is absorbed, the less damage will be mitigated away from the owner.", color = Color( 180, 180, 180 ) },
	["9z"] = { text = "... All are silenced and calmed ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 30,
		DamageAttackRange = 54,
		DamageType = DMG_SF_PHASEBLADE,
		FireRate = { 
			{ RateTitle = "swing", RateDelay = 0.9 }
		},
	},
	Secondary = {
		DamageComposition = "--",
		DamageBlastRadius = 256,
		DamageType = DMG_SF_BLIGHT,
		FireRate = { 
			{ RateTitle = "charge", RateDelay = 0.4 },
		},
	},
	PerkSet = { SCIFI_PERK_PHASMA_SWORDANDSHIELD, { PerkPanelHeight = 3, PerkDescription = "Weapon allows for aggressive leap attack\nallowing for quick follow-up strikes.", PerkTitle = "All are silenced and calmed", PerkColor = Color( 255, 20, 20 ) } }
}

SWEP.ViewModelIdleAnim 		= false

SWEP.ViewModelHomePos		= Vector( 0, 0, 0 )
SWEP.ViewModelHomeAng		= Angle( 0, 0, 0 )
SWEP.ViewModelSprintPos		= Vector( 0, 0, 0 )
SWEP.ViewModelSprintAng		= Angle( -20, -10, 0 )
SWEP.ViewModelShift = false

SWEP.ViewModelMenuPos		= Vector( 12, 3.2, -6 )
SWEP.ViewModelMenuAng		= Angle( 20, 35, -10 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.45
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.DepletedSND			= nil

SWEP.SckAnimDeployed 		= 0

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(1, 0, 2), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 2), angle = Angle(20, 20, 10) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 20, -10) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle( -10, -10, -10 ) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 40, 10) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(0.2, 1.2, -1.6), angle = Angle(2, 2, -28), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["parent+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(14.6, -3.2, 2), angle = Angle(12, 22, -22), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["parent++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(1, 0, 0.2), angle = Angle(-2, 4, -20), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(0, 1.8, 1.9), angle = Angle(45.893, 14.565, -19.542), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(3, 2, 1), angle = Angle(31.653, 9.727, -14.4), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(6, 2.2, -0.3), angle = Angle(12.998, 0.146, -11.822), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(9.2, 2.8, 1.824), angle = Angle(-50, 52, -17), size = Vector(0.5, 0.699, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(9.161, -3.6, -0.676), angle = Angle(-16, -67, 3), size = Vector(0.5, 0.699, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(20.08, 0.451, -0.484), angle = Angle(-10, -173.482, 25.395), size = Vector(1, 1, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1++++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(30.406, -1.019, 1.851), angle = Angle(-16, -170.084, 24.968), size = Vector(1, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blade1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(34, -1.4, 4.4), angle = Angle(-170, 5, 124), size = Vector(1.3, 0.5, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_glyph_solid", skin = 0, bodygroup = {} },
	["blade1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(34, -1.6, 4.4), angle = Angle(-170, 5, 128), size = Vector(1.3, 0.5, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_glyph_solid", skin = 0, bodygroup = {} }
--	["shield1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(18, -4, 18), angle = Angle(-40, 62, 10), size = Vector(1, 1, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_shield", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(0.2, -1, -1.8), angle = Angle(1, -20, -38), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["parent+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(14.6, -3.5, 1.5), angle = Angle(12, 12, -32), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["parent++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(0, -3, .2), angle = Angle(-2, -18, -30), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(0, 1.8, 1.9), angle = Angle(45.893, 14.565, -19.542), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(3, 2, 1), angle = Angle(31.653, 9.727, -14.4), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(6, 2.2, -0.3), angle = Angle(12.998, 0.146, -11.822), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(9.2, 2.8, 1.824), angle = Angle(-50, 52, -17), size = Vector(0.5, 0.699, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(9.161, -3.6, -0.676), angle = Angle(-16, -67, 3), size = Vector(0.5, 0.699, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(20.08, 0.451, -0.484), angle = Angle(-10, -173.482, 25.395), size = Vector(1, 1, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1++++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(30.406, -1.019, 1.851), angle = Angle(-16, -170.084, 24.968), size = Vector(1, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blade1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(31, -1.4, 3.4), angle = Angle(-170, 5, 124), size = Vector(1, 0.5, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_glyph_solid_static", skin = 0, bodygroup = {} },
	["blade1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(31, -1.6, 3.4), angle = Angle(-170, 5, 128), size = Vector(1, 0.5, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_glyph_solid_static", skin = 0, bodygroup = {} }
}

local pHealth = 0
local pShield = 0
local LastMeleeMode = 0

local LUArmAngle = Angle( 0, 20, -10 )
local LUArmOrigin = Vector( 1, 0, 2 )
local RUArmAngle = Angle( -10, 2, 4 )
local RUArmOrigin = Vector( 0, 0, 0 )
local RFArmAngle = Angle( 10, 30, 10 )
local RHandAngle = Angle( 0, 0, 0 )
	
local MClaw1Origin = Vector(0, 1.8, 1.9)
local MClaw1Angle = Angle(46, 15, -20)
local MClaw2Origin = Vector(3, 2, 1)
local MClaw2Angle = Angle(31.5, 9.7, -14.4)
local MClaw3Origin = Vector(6, 2.2, -0.3)
local MClaw3Angle = Angle(13, 0.2, -12)

local MGrip1Origin = Vector(20.08, 0.451, -0.484)
local MGrip1Angle = Angle(-10, -173.482, 25.395)
local MGrip2Origin = Vector(30.406, -1.019, 1.851)
local MGrip2Angle = Angle(-16, -170.084, 24.968)

local BladeGlow = Vector( 0.9, 1, 2 )
local BladeGlowBase = Vector( 0.9, 1, 2 )

local mymat = Material( "models/weapons/spectra/phasma_glyph_solid" )
local mymat2 = Material( "models/weapons/spectra/phasma_glyph_solid_static" )

SWEP.DataTables = {
	{ dType = "Bool", dName = "AnimSingleParticle" },
	{ dType = "Int", dName = "MeleeMode" },
	{ dType = "Int", dName = "Combo" },
	{ dType = "Float", dName = "NextMeleeAttack" },
	{ dType = "Float", dName = "AnimNextParticle" }
}

function SWEP:SubInit()

	self.SckAnimModeswitch = 0
	self.SckAnimDeployed = 4
	self:SetCharge( 0 )
	
	self.BladeAnim = true
	self.BladeAnimTime = fnGameTime() + 0.45
	
	if ( CLIENT ) && ( !IsValid( self.Owner ) ) then
		for k,v in pairs( self.WElements ) do 
			v.bone = "ValveBiped.Bip01_R_Forearm"
		end
	end
	
	self.GetSafeMode = nil -- break "gun safety", since this isn't a gun and I can't be asked to define gun safety per weapon instead of disabling it on those that don't feature it.

end

function SWEP:OwnerChanged()

	local wOwner = self:GetOwner()

	if ( IsValid( wOwner ) ) && ( wOwner ~= self.LastOwner ) then
		self.LastOwner = wOwner
	
		if ( CLIENT ) then
			for k,v in pairs( self.WElements ) do 
				v.bone = "ValveBiped.Bip01_R_Forearm"
			end
		end
	else
		self:ResetDeployment()
	
		if ( CLIENT ) then
			for k,v in pairs( self.WElements ) do 
				v.bone = "ValveBiped.Bip01_R_Hand"
			end
		end
	end
end

function SWEP:ResetDeployment()

	if ( IsValid( self.Owner ) && self.Owner:IsPlayer() ) then
		if ( CLIENT ) then
			local vm = self.Owner:GetViewModel()
			if ( IsValid( vm ) ) then 
				vm:SetSubMaterial( 0, "" )
				vm:SetSubMaterial( 1, "" )
				vm:SetSubMaterial( 2, "" )
				vm:SetSubMaterial( 3, "" )
				vm:SetSubMaterial( 4, "" )
				
				self:ResetBonePositions(vm)
			end

			self.VElements["parent+"].modelEnt:StopParticles()
			self.VElements["blade1"].modelEnt:StopParticles()
			self.WElements["blade1"].modelEnt:StopParticles()
		end
		
		if ( game.SinglePlayer() || !game.SinglePlayer() && CLIENT ) then
			if ( self:GetMeleeMode() == 0 ) then
				ParticleEffectAttach( "phasma_blade_disable", PATTACH_ABSORIGIN_FOLLOW, self.VElements["blade1"].modelEnt, 1 )

				self:EmitSound( "scifi.phasma.blade.turnoff" )
			end
		end
	end
	
end

function SWEP:Holster( wep )
		
	local cmd_advanims = GetConVar( "sfw_allow_advanims" )
	local bAnims = cmd_advanims:GetBool()

	if ( CLIENT ) && ( bAnims ) then
		if ( game.SinglePlayer() ) then
			self.SckAnimDeployed = 4
		else
			self.SckAnimDeployed = 4
		end
		
		self.BladeAnim = true
		self.BladeAnimTime = fnGameTime() + fnMathMax( fnFrameTime() * 60, 0.6 )
	end
	
	if ( CLIENT ) && ( IsValid( self.Owner ) ) && ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
		
		self:SetAds( false )
	end

	self:ResetDeployment()
	return true

end

function SWEP:Deploy() 

	if ( self.Owner:IsNPC() ) then 
		self:Remove()
	end

	self:SetAds( false )

	local vm = self.Owner:GetViewModel()
	local seq = vm:LookupSequence( "fists_draw" )
	vm:SendViewModelMatchingSequence( seq )
	
	self:UpdateNextIdle()
	
	pHealth = self.Owner:Health()
	pShield = self.Owner:Armor()
	
	if ( game.SinglePlayer() ) then
		self.SckAnimDeployed = 4
	else
		self.SckAnimDeployed = 4
	end
	
	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self.SciFiState = SCIFI_STATE_IDLE
		self.SciFiMeleeCharge = 0
		self:SetSciFiACC( 4 )
	end
	
	if ( CLIENT ) then
		self.SciFiState = SCIFI_STATE_IDLE
	end
	
	self:ResetAnimationScale()
	self:SetNextPrimaryFire( fnGameTime() + 0.9 )
	
	return true
	
end

local animspeed = 1
if ( !game.SinglePlayer() ) then
	animspeed = 1.72
end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetAnimNextIdle( fnGameTime() + vm:SequenceDuration() )

end

function SWEP:Think()

	if !( IsValid( self ) && IsValid( self.Owner ) ) then
		return
	end

	if ( IsValid( self.Owner ) && self.Owner:InVehicle() ) then
		self.SckAnimDeployed = 4
		
		return
	end

	-- what an unelegant workaround --
	if ( CLIENT ) && ( self.SckAnimDeployed > 0 && self.BladeAnimTime < fnGameTime() ) then
		self.BladeAnimTime = fnGameTime() + 0.02
	end

	if ( IsValid( self.Owner ) && self.Owner:GetActiveWeapon() ~= self ) then return end
	
	if ( ( IsValid( self ) && IsValid( self.Owner ) ) && ( !isnumber( self:GetCharge() ) ) ) then
		self:SetCharge( 1 )
	end
	
	if !( self:GetMeleeMode() == LastMeleeMode ) then
		self.SckAnimModeswitch = 10
		
		self.BladeAnim = true
		self.BladeAnimTime = fnGameTime() + fnMathMax( fnFrameTime() * 10, 0.32 )

		if ( CLIENT ) then
			self.VElements["parent+"].modelEnt:StopParticles()
			self.VElements["blade1"].modelEnt:StopParticles()
			self.WElements["blade1"].modelEnt:StopParticles()
		end
	end

	local vm = self.Owner:GetViewModel()
	local seqActual = vm:GetSequence()

	local curtime = fnGameTime()
	local idletime = self:GetAnimNextIdle()
	local animtime = idletime - curtime
	
	local sine0 = fnMathSin( fnGameTime() * 8 ) * 0.0625
	local sine1 = fnMathSin( fnGameTime() * 6 ) * 0.0417
	local sine2 = fnMathSin( fnGameTime() * 4 ) * 0.0313
	local cmod = self:GetCharge() * 0.01

	if ( self:GetMeleeMode() == 1 ) && ( self.SckAnimModeswitch <= 0 ) then
		BladeGlow = Vector( 0, 0, 0 )
	else
		BladeGlow = BladeGlowBase
	end

	if ( idletime >= 0 && fnGameTime() > idletime ) && ( SERVER ) then
		local seq = vm:LookupSequence( "fists_idle_0" .. fnMathRandom( 1, 2 ) )
		vm:SendViewModelMatchingSequence( seq )

		self:UpdateNextIdle()
	end

	if ( self:GetMeleeMode() == 0 ) then
		if ( self.SckAnimModeswitch > 0 ) then
			local fFrameTime = fnFrameTime() * 6

			MClaw1Origin = LerpVector( fFrameTime, MClaw1Origin, Vector(0, 1.8, 1.9) )
			MClaw1Angle = LerpAngle( fFrameTime, MClaw1Angle, Angle(46, 15, -20) )
			MClaw2Origin = LerpVector( fFrameTime, MClaw2Origin, Vector(3, 2, 1) )
			MClaw2Angle = LerpAngle( fFrameTime, MClaw2Angle, Angle(31.5, 9.7, -14.4) )
			MClaw3Origin = LerpVector( fFrameTime, MClaw3Origin, Vector(6, 2.2, -0.3) )
			MClaw3Angle = LerpAngle( fFrameTime, MClaw3Angle, Angle(13, 0.2, -12) )
		
			MGrip1Origin = LerpVector( fFrameTime, MGrip1Origin, Vector(20, 0.5, -0.5) )
			MGrip1Angle = LerpAngle( fFrameTime, MGrip1Angle, Angle(-10, -176, 25) )
			MGrip2Origin = LerpVector( fFrameTime, MGrip2Origin, Vector(30.5, -1.019, 1.8) )
			MGrip2Angle = LerpAngle( fFrameTime, MGrip2Angle, Angle(-16, -170, 25) )
		
			RUArmAngle = LerpAngle( fFrameTime, RUArmAngle, Angle( -10, 2, 4 ) )
			RUArmOrigin = LerpVector( fFrameTime, RUArmOrigin, Vector( 0, 0, 0 ) )
			RFArmAngle = LerpAngle( fFrameTime, RFArmAngle, Angle( 10, 30, 10 ) )
			RHandAngle = LerpAngle( fFrameTime, RHandAngle, Angle( 0, 0, 0 ) )

			self.VElements[ "blade1" ].material = "models/weapons/spectra/phasma_glyph_solid"
			self.VElements[ "blade1+" ].material = "models/weapons/spectra/phasma_glyph_solid"
--			self.VElements[ "shield1" ].material = "vgui/white"
			self.WElements[ "blade1" ].material = "models/weapons/spectra/phasma_glyph_solid_static"
			self.WElements[ "blade1+" ].material = "models/weapons/spectra/phasma_glyph_solid_static"
			
			if ( CLIENT ) && ( game.SinglePlayer() && self.Owner:ShouldDrawLocalPlayer() ) then
				self.WElements[ "blade1" ].material = "models/weapons/spectra/phasma_glyph_solid"
				self.WElements[ "blade1+" ].material = "models/weapons/spectra/phasma_glyph_solid"
			end
		end
	
		if ( self:GetNextMeleeAttack() > 0 && fnGameTime() > self:GetNextMeleeAttack() ) then
			if ( self.Owner:KeyDown( IN_ATTACK ) ) then
				if ( self:GetCombo() == 0 ) then
					self:SetCombo( 1 )
				else 
					self:SetCombo( 0 )
				end
			end
			
			if ( self.Owner:KeyDown( IN_ATTACK2 ) ) then
				self:SetCombo( 2 )
			end
			
			self:DealDamage()

			self:SetNextMeleeAttack( 0 )
			
			-- quick fix to allow animation skip for reactionary weapon swap? --
			if ( self.SckAnimDeployed > 0 ) then
				self.SckAnimDeployed = 0.1
				self.BladeAnimTime = 0
			end
		end
		
		-- Primary attack, wide slash --
		if ( seqActual == 5 ) then
			if ( self:GetCombo() == 0 ) then
				LUArmAngle = Angle( 0, 20, -10 ) + ( Angle( 20, 20, 0 ) * animtime )
				LUArmOrigin = Vector( 1, 0, 2 ) + ( Vector( -1, 0, -2 ) * animtime )
				
				RUArmAngle = Angle( -10, -2, 4 ) + ( Angle( 50 * animtime , 30, fnMathSin( animtime * 8 ) * 80 ) * animtime )
				RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( -4, 2, -2 ) * animtime )
				
				RFArmAngle = Angle( 10, 30, 10 ) + ( Angle( -10, -10, 10 ) * animtime )
			else
				LUArmAngle = Angle( 0, 20, -10 ) + ( Angle( 20, 20, 0 ) * animtime )
				LUArmOrigin = Vector( 1, 0, 2 ) + ( Vector( -1, 0, -2 ) * animtime )
				
				RUArmAngle = Angle( -10, 2, 4 ) + ( Angle( 15 + fnMathSin( animtime * 4 ) * 60, -5 + fnMathSin( animtime * 4 ) * 25, -60 + fnMathSin( animtime * 4 ) * 70 ) * animtime )
				RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( -8, 2, 4 ) * animtime )
				
				RFArmAngle = Angle( 10, 30, 10 ) + ( Angle( -20, 30, -140 ) * animtime )
			end
			
			BladeGlow = Vector( 0.8, 0.8, 1.8 ) + Vector( 0.6, 0.4, 3.2 ) * animtime

			self:SetCharge( self:GetCharge() + ( 1 + animtime * -1 ) )
		end

		-- Secondary attack, forward cleave --
		if ( seqActual == 3 ) then
			LUArmAngle = Angle( 0, 20, -10 ) + ( Angle( 0, 20, -20 ) * animtime )
			LUArmOrigin = Vector( 1, 0, 2 ) + ( Vector( -1, 0, -2 ) * animtime )
			
			RUArmAngle = Angle( -10, 2, 4 ) + ( Angle( -4, 6, 12 ) * animtime )
			RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( 0, -4, -12 ) * animtime )

			RFArmAngle = Angle( 10, 30, 10 ) + ( Angle( -24, -24, -32 ) * animtime )
			
			BladeGlow = BladeGlowBase + Vector( 0.2, -0.4, 1.2 ) * animtime

			self:SetCharge( self:GetCharge() + ( 1 + animtime * -1 ) )
		end
		
		self.VElements[ "0" ].pos = MClaw1Origin + Vector( sine0, -sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "0+" ].pos = MClaw2Origin + Vector( sine0, sine1, -sine2 ) * ( 1 + cmod )
		self.VElements[ "0++" ].pos = MClaw3Origin + Vector( -sine0, sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "0" ].angle = MClaw1Angle + Angle( sine0, -sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "0+" ].angle = MClaw2Angle + Angle( sine0, sine1, -sine2 ) * ( 1 + cmod )
		self.VElements[ "0++" ].angle = MClaw3Angle + Angle( -sine0, sine1, sine2 ) * ( 1 + cmod )
		
		self.VElements[ "1+" ].pos = MGrip1Origin + Vector( -sine0, sine1, sine2 ) * ( cmod )
		self.VElements[ "1++++" ].pos = MGrip2Origin + Vector( sine0, -sine1, -sine2 ) * ( cmod )
		self.VElements[ "1+" ].angle = MGrip1Angle + Angle( sine0, sine1, -sine2 ) * ( cmod )
		self.VElements[ "1++++" ].angle = MGrip2Angle + Angle( sine0, -sine1, sine2 ) * ( cmod )
	
		if ( !self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_ATTACK2 ) ) then -- && ( self:GetCharge() < self.ChargeMax ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end

	else
		if ( self.SckAnimModeswitch > 0 ) then
			local fFrameTime = fnFrameTime() * 4

			MClaw1Origin = LerpVector( fFrameTime, MClaw1Origin, Vector(5, 3, -2.1) )
			MClaw1Angle = LerpAngle( fFrameTime, MClaw1Angle, Angle(-46, -15, 10) )
			MClaw2Origin = LerpVector( fFrameTime, MClaw2Origin, Vector(6, 1, -2) )
			MClaw2Angle = LerpAngle( fFrameTime, MClaw2Angle, Angle(-46, 5, 0) )
			MClaw3Origin = LerpVector( fFrameTime, MClaw3Origin, Vector(6, -1, -2) )
			MClaw3Angle = LerpAngle( fFrameTime, MClaw3Angle, Angle(-46, 25, -20) )
		
			MGrip1Origin = LerpVector( fFrameTime, MGrip1Origin, Vector(16, -6, 0.2) )
			MGrip1Angle = LerpAngle( fFrameTime, MGrip1Angle, Angle(-14, -130, -2.2) )
			MGrip2Origin = LerpVector( fFrameTime, MGrip2Origin, Vector(16, 4, 2.7) )
			MGrip2Angle = LerpAngle( fFrameTime, MGrip2Angle, Angle(-40, 145, 15) )
		
			RUArmAngle = LerpAngle( fFrameTime, RUArmAngle, Angle(0, -20, -32) )
			RUArmOrigin = LerpVector( fFrameTime, RUArmOrigin, Vector(1, 1, -2) )
			RFArmAngle = LerpAngle( fFrameTime, RFArmAngle, Angle(-14, -5, -32) )
			RHandAngle = LerpAngle( fFrameTime, RHandAngle, Angle(0, 10, -60) )

			self.VElements[ "blade1" ].material = "vgui/white"
			self.VElements[ "blade1+" ].material = "vgui/white"
			self.WElements[ "blade1" ].material = "vgui/white"
			self.WElements[ "blade1+" ].material = "vgui/white"
--			self.VElements[ "shield1" ].material = "models/weapons/spectra/phasma_shield"
			
--			local mShield = Material( "models/weapons/spectra/phasma_shield" )
--			mShield:SetVector( "$selfillumtint", Vector( .1, .1, .2 ) * ( 1 - self.SckAnimModeswitch / 10 ) )
		end
		
		self.VElements[ "0" ].pos = MClaw1Origin + Vector( sine0, -sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "0+" ].pos = MClaw2Origin + Vector( sine0, sine1, -sine2 ) * ( 1 + cmod )
		self.VElements[ "0++" ].pos = MClaw3Origin + Vector( -sine0, sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "0" ].angle = MClaw1Angle + Angle( sine0, -sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "0+" ].angle = MClaw2Angle + Angle( sine0, sine1, -sine2 ) * ( 1 + cmod )
		self.VElements[ "0++" ].angle = MClaw3Angle + Angle( -sine0, sine1, sine2 ) * ( 1 + cmod )
		
		self.VElements[ "1+" ].pos = MGrip1Origin + Vector( -sine0, sine1, sine2 ) * ( 1 + cmod )
		self.VElements[ "1++++" ].pos = MGrip2Origin + Vector( sine0, -sine1, -sine2 ) * ( 1 + cmod )
		self.VElements[ "1+" ].angle = MGrip1Angle + Angle( sine0, sine1, -sine2 ) * ( 1 + cmod )
		self.VElements[ "1++++" ].angle = MGrip2Angle + Angle( sine0, -sine1, sine2 ) * ( 1 + cmod )
		
		local HealthDiff = fnMathClamp( pHealth - self.Owner:Health(), 0, 100 )

		if ( pHealth > 0 ) then
			if ( pHealth > self.Owner:Health() ) then
				local iCharge = self:Clip1()
				
				if ( SERVER ) then
					local pOwnerSP = self.Owner:GetShootPos()
					local pOwnerAV = self.Owner:GetAimVector()
					local pOwnerEA = self.Owner:EyeAngles()
				
					ParticleEffect( "phasma_absorb", pOwnerSP + pOwnerAV * 32 + pOwnerEA:Up() * -4, pOwnerEA, self )
					
					self:EmitSound( "weapons/ancient/phasma_absorb.wav", 70, fnMathClamp( 60 + iCharge, 60, 200 ), 1, CHAN_WEAPON )
				end
		
				if !( game.SinglePlayer() && CLIENT ) then
					if ( self:GetNextPrimaryFire() <= fnGameTime() ) then
						if ( pShield > 1 ) then
							HealthDiff = HealthDiff * 1.8
						end
						
						self:SetCharge( fnMathMin( self:GetCharge() + HealthDiff, self.ChargeMax ) )

						self:SetClip1( self:GetCharge() )

						self.Owner:SetHealth( pHealth - ( HealthDiff * fnMathRound( iCharge * 0.001, 1 ) ) )
						
						if ( overpower:GetBool() ) then
							self.Owner:SetArmor( pShield )
						end
					end
				end
			end
		end
	end
	
	local entBlade = self.VElements["blade1"].modelEnt
	if ( CLIENT ) && ( self.Owner:ShouldDrawLocalPlayer() ) then
		entBlade = self.WElements[ "blade1" ].modelEnt
	end

	-- timed blade anim event --
	if ( CLIENT ) && ( self.BladeAnim && self.BladeAnimTime <= fnGameTime() ) then
		if ( self:GetMeleeMode() == 0 ) then
			ParticleEffectAttach( "phasma_blade_enable", PATTACH_ABSORIGIN_FOLLOW, entBlade, 1 )
			if ( GetConVar( "sfw_fx_particles" ):GetBool() ) then
				ParticleEffectAttach( "phasma_initial_mist", PATTACH_ABSORIGIN_FOLLOW, entBlade, 1 )
			end
			
			self:EmitSound( "scifi.phasma.blade.turnon" )
		end

		if ( self:GetMeleeMode() == 1 ) then
			ParticleEffectAttach( "phasma_core", PATTACH_ABSORIGIN_FOLLOW, self.VElements["parent+"].modelEnt, 1 )
		
			if ( LastMeleeMode == 0 ) then
				ParticleEffectAttach( "phasma_blade_enable", PATTACH_ABSORIGIN_FOLLOW, entBlade, 1 )

				self:EmitSound( "scifi.phasma.blade.turnoff" )
			end
		end
		
		self.BladeAnim = false
	end	

	if ( self:GetMeleeMode() == 0 ) &&( LastMeleeMode == 1 ) then
		self.HoldType = "knife"
		self:SetHoldType( self.HoldType )
	end

	if ( self:GetMeleeMode() == 1 ) && ( LastMeleeMode == 0 ) then
		self.HoldType = "fist"
		self:SetHoldType( self.HoldType )
	end

	
	-- untimed blade anim event --
	if ( CLIENT ) && ( self.BladeAnim  ) then
		if ( self:GetMeleeMode() == 1 && LastMeleeMode == 0 ) then
			ParticleEffectAttach( "phasma_blade_enable", PATTACH_ABSORIGIN_FOLLOW, self.VElements["blade1"].modelEnt, 1 )

			self:EmitSound( "scifi.phasma.blade.turnoff" )
		end
	end

	if ( self.SckAnimDeployed > 0 ) then
		if ( CLIENT ) then
			self.SckAnimDeployed = fnMathApproach( self.SckAnimDeployed, 0, fnFrameTime() * ( 4 * self.ChargeDeltaFactor ) * animspeed ) 
		end
		
		if ( SERVER ) then
			self.SckAnimDeployed = fnMathApproach( self.SckAnimDeployed, 0, fnFrameTime() * 4 * animspeed ) 
		end
		
		if ( self:GetMeleeMode() == 0 ) then
			RUArmAngle = Angle( -10, 2, 4 ) + ( Angle( -4, -6, 10 ) * self.SckAnimDeployed )
			RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( 1, 0, 1 ) * self.SckAnimDeployed )
			RFArmAngle = Angle( 10, 30, 10 ) + ( Angle( 4, 4, -20 ) * self.SckAnimDeployed )

			local fDeployScale = math.min( 1 / ( self.SckAnimDeployed - 3 ), 1 ) -- fnMathMax( 0.1 - self.SckAnimDeployed, 0 )

			BladeGlow = BladeGlow * fDeployScale
		end
	end
	
	if ( self.SckAnimModeswitch > 0 )then
		self.SckAnimModeswitch = fnMathApproach( self.SckAnimModeswitch, 0, fnFrameTime() * 16 * animspeed ) 
	
		if ( self:GetMeleeMode() == 1 ) then
			BladeGlow = BladeGlow * fnMathMax( self.SckAnimModeswitch - 6, 0 )
		else
			BladeGlow = BladeGlow * fnMathMax( 1 - ( self.SckAnimModeswitch / 1 ), 0 )
		end
	end
	
--	BladeGlow = Vector( 200 + ( 50 * math.sin( CurTime() * 4 ) ), 200 + ( 50 * math.cos( CurTime() * 4 ) ), 200 + ( 50 * -math.sin( CurTime() * 4 ) ) ) / 128 -- dance, baby

	mymat:SetVector( "$selfillumtint", BladeGlow * ( 1 + cmod ) )
	
	self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = LUArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos = LUArmOrigin
	self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = RUArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].pos = RUArmOrigin
	self.ViewModelBoneMods["ValveBiped.Bip01_R_Forearm"].angle = RFArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle = RHandAngle

	if ( CLIENT ) then
		local lightorigin = self.VElements[ "0++" ].modelEnt:GetPos()
		if ( self.Owner:ShouldDrawLocalPlayer() ) then
			lightorigin = self.WElements[ "parent+" ].modelEnt:GetPos()
		end
		
		local lightbrightness = 0.4

		if ( self.SckAnimDeployed > 0 )  then
			lightbrightness = fnMathMax( lightbrightness - self.SckAnimDeployed, 0 )
		end
		
		if ( self.SckAnimModeswitch > 0 )  then
			if ( self:GetMeleeMode() == 1 ) then
				lightbrightness = fnMathMax( self.SckAnimModeswitch - 4, 0 )
			else
				lightbrightness = fnMathMax( lightbrightness - ( self.SckAnimModeswitch / 8 ), 0 )
			end
		end
		
		if ( self:GetMeleeMode() == 1 ) then
			lightbrightness = 0.012 + ( self:Clip1() * 0.005 )
				
--			local mShield = Material( "models/weapons/spectra/phasma_shield" )
--			mShield:SetVector( "$selfillumtint", Vector( 0.2, 0.2, 0.4 ) + BladeGlowBase * lightbrightness )
		end
		
--		local lightcolor = BladeGlow * 128

		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = lightorigin
--			dlight.r = fnMathMin( lightcolor.x, 255 )
--			dlight.g = fnMathMin( lightcolor.y, 255 )
--			dlight.b = fnMathMin( lightcolor.z, 255 )
			dlight.r = 120
			dlight.g = 130
			dlight.b = 255
			dlight.brightness = lightbrightness
			dlight.Decay = 1024
			dlight.Size = 620 * lightbrightness * ( 1 + self:GetCharge() * 0.001 )
			dlight.DieTime = fnGameTime() + 1
		end
	end

	self:SciFiMath()
	self:Anims()
	
	-- I did some testing an appearently you HAVE to be THIS explicit when it comes to multiplayer. In SP, everything is FUCKING FINE!!!! --
	if ( game.SinglePlayer() ) then
		pHealth = self.Owner:Health()
		pShield = self.Owner:Armor()
		LastMeleeMode = self:GetMeleeMode()
	else
		if ( SERVER ) then
			pHealth = self.Owner:Health()
			pShield = self.Owner:Armor()
			LastMeleeMode = self:GetMeleeMode()
		end
		
		if ( CLIENT ) then
			pHealth = self.Owner:Health()
			pShield = self.Owner:Armor()
			LastMeleeMode = self:GetMeleeMode()
		end
	end

end

function SWEP:DealDamage()

	local pOwnerSP = self.Owner:GetShootPos()
	local pOwnerAV = self.Owner:GetAimVector()
	
	self.Owner:LagCompensation( true )
	
	local fDamageAmp = cmd_damageamp:GetFloat()
	
	local iDmg = 30 * fDamageAmp
	local iRange = 56
	
	if ( self:GetCombo() == 0 ) then
		self.Owner:ViewPunch( Angle( -2, 8, 1 ) )
	end
	
	if ( self:GetCombo() == 1 ) then
		self.Owner:ViewPunch( Angle( 2, -8, 1 ) )
		iDmg = iDmg * 1.25
		iRange = 48
	end
	
	if ( self:GetCombo() == 2 ) then
		iDmg = iDmg * 2
		iRange = 32
	end

	if ( self.SciFiState == SCIFI_STATE_SPRINT ) then
		iRange = iRange * 0.6
	end
	
	local cone = ents.FindInCone( pOwnerSP, pOwnerAV, iRange, 0 )
	
	local trData, trResult = {}, {}

	trData.start 		= pOwnerSP
	trData.endpos 		= pOwnerSP + pOwnerAV * 72
	trData.maxs 		= Vector( 3, 3, 1 + ( 1 * self:GetCombo() ) ) * ( iRange / 10 )
	trData.mins 		= trData.maxs * -1
	trData.mask			= MASK_SHOT_HULL
	trData.ignoreworld 	= false
	trData.filter 		= function( ent ) 
							if ( ent == self.Owner ) || ( ent:GetOwner() == self.Owner ) then
								return false
							else
								return true
							end 
						end
	trData.output  		= trResult

	util.TraceHull( trData )

	if ( CLIENT ) then
		ParticleEffectAttach( "phasma_trail", PATTACH_ABSORIGIN_FOLLOW, entBlade, 1 )
	end
	
	local angCombo = Angle( 0, 90, 45 )
	if ( self:GetCombo() == 1 ) then
		angCombo = Angle( 0, -90, 45 )
	elseif ( self:GetCombo() == 2 ) then
		angCombo = Angle( 90, 0, 90 )
	end
	
	if ( trResult.Hit && !( CLIENT && game.SinglePlayer() ) ) then
		self:EmitSound( "scifi.phasma.blade.scratch" )
		self:EmitSound( "scifi.spectra.hit" )
		ParticleEffect( "astra_hit", trResult.HitPos, trResult.Normal:Angle() + angCombo, self )

--		if ( trResult.SurfaceProps == 103 ) then
--			ParticleEffect( "blood_impact_zombie_01_b", trResult.HitPos, trResult.HitNormal:Angle() )
--		end
	end

	if ( SERVER && IsValid( trResult.Entity ) ) then
		local dmginfo = DamageInfo()

		local vForce = Vector( 0, 0, 0 )
		
		if ( self:GetCombo() == 1 ) then
			vForce = pOwnerSP + ( pOwnerAV + self.Owner:GetRight() * 64 ) + trResult.HitNormal * 4
		else
			vForce = pOwnerSP + ( pOwnerAV + self.Owner:GetForward() * 128 ) + trResult.HitNormal * 4
		end
		
		if ( stealthfinisher:GetBool() ) && ( trResult.Entity:IsNPC() && trResult.Entity:GetNPCState() == NPC_STATE_IDLE ) then
			iDmg = iDmg * 8
		end
		
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( iDmg )
		dmginfo:SetDamageType( DMG_SF_PHASEBLADE )
		dmginfo:SetDamageForce( vForce )

		trResult.Entity:TakeDamageInfo( dmginfo )
		
		for k,v in pairs( cone ) do
			if ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) then
				dmginfo:SetDamage( iDmg / 2 )
		--		dmginfo:SetDamageForce( vForce / 4 )
				v:TakeDamageInfo( dmginfo )
			end
		end
--[[
		local phys = trResult.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			local vForceDirection = pOwnerAV - trResult.HitNormal
			phys:ApplyForceOffset( vForce, vForceDirection * 2 )
		end
]]--
	end

	self.Owner:LagCompensation( false )
--[[
	local a = ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND
	local g = GESTURE_SLOT_ATTACK_AND_RELOAD 
	self.Owner:AnimResetGestureSlot(g) 
	self.Owner:AnimSetGestureWeight(g,1)
	self.Owner:AnimRestartGesture(g,a,true) 
]]--
end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsNPC() ) then
		return
	end

	if ( self:GetMeleeMode() == 0 ) then
		local vm = self.Owner:GetViewModel()
		local seq = vm:LookupSequence( "fists_uppercut" )
		vm:SendViewModelMatchingSequence( seq )
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		local weaken = 0.7 - ( self:GetCombo() * 0.2 ) + ( self:GetSciFiACC() / 60 )
		--self:SetCharge( 0 )
		if ( self:GetCombo() == 2 ) then
			self:SetCombo( 0 )
		end

		self:EmitSound( "scifi.phasma.blade.swing" )
		self:EmitSound( "scifi.phasma.whoosh" )
			
		self:UpdateNextIdle()
		self:SetNextMeleeAttack( fnGameTime() + 0.16 + ( 0.02 - self:GetCombo() * 0.04 ) ) -- 0.2 )
		
		self:SetNextPrimaryFire( fnGameTime() + weaken )
		self:SetNextSecondaryFire( fnGameTime() + weaken )

		self:AddSciFiACC( 12 )
	else		
		if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
		local pOwnerSP = self.Owner:GetShootPos()
		local pOwnerAV = self.Owner:GetAimVector()
		local pOwnerEA = self.Owner:EyeAngles()
		local up = pOwnerEA:Up()
		
		if ( SERVER ) then
			local fDamageAmp = cmd_damageamp:GetFloat()
			local bDmg = self:Clip1() * fDamageAmp

			for k, v in pairs ( ents.FindInCone( pOwnerSP, pOwnerAV, 220, 0 ) ) do
				if ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) && ( v:VisibleVec( pOwnerSP ) ) then
				--	DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 2, Attacker = self.Owner } )
					
					local tPosition = v:EyePos()
					local pPosition = self.Owner:GetShootPos() + ( pOwnerAV * 12 )
					local tDistance = tPosition:Distance( pPosition )
					local iDmg = fnMathClamp( bDmg - ( tDistance / 10 ), 0, bDmg )
					local vDmgForce = ( tPosition - pPosition ) * iDmg * 4
					
					if ( v:IsPlayer() || v:IsNPC() ) then
						self:DealDirectDamage( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ), iDmg, v, self.Owner, pOwnerAV * iDmg * 64 )
					else
						local dmginfo = DamageInfo()
						dmginfo:SetAttacker( self.Owner )
						dmginfo:SetInflictor( self )
						dmginfo:SetDamage( iDmg )
						dmginfo:SetDamageType( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ) )
						dmginfo:SetDamageForce( vDmgForce )
					
						v:TakeDamageInfo( dmginfo )
					end
					
					local phys = v:GetPhysicsObject()
					if ( IsValid( phys ) ) then
						local pNormal = pOwnerAV:GetNormalized()
						phys:ApplyForceCenter( vDmgForce )
					end
				end
			end
			
			util.ScreenShake( self:GetPos(), 1 * self:Clip1(), 64, 0.8, 256 )
		
			local mul = bDmg / 50

			local fx = EffectData() 
			fx:SetOrigin( pOwnerSP + pOwnerAV * 16 ) 
			fx:SetEntity( self.Owner ) 
			fx:SetScale( 0.4 * mul ) 
			fx:SetRadius( 20 + 10 * mul ) 
			fx:SetNormal( Vector( 0.15, 0.1, 2 ) * fnMathClamp( mul, 0, 1 ) )
			
			util.Effect( "scifi_aftershock", fx )
		end
		
		if ( SERVER ) || ( !game.SinglePlayer() ) then
			ParticleEffect( "phasma_blast", pOwnerSP + pOwnerAV * 24 + up * -4, pOwnerEA, self )
			
			self:EmitSound( "scifi.zeala.fire" )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( fnMathRandom( -6, -6 ), fnMathRandom( 0, 0.03 ), fnMathRandom( 0, 0.03 ) ) )
			self:AddSciFiACC( 12 )
		end

		self:SetNextPrimaryFire( fnGameTime() + 0.4 )
		self:TakePrimaryAmmo( self:Clip1() )
		self:SetCharge( 0 )
		self:AddSciFiACC( 13 )
	end

end

function SWEP:SecondaryAttack()

	if ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetMeleeMode() == 0 ) then
			self:SetMeleeMode( 1 )
			self:SetClip1( 0 )

			local vm = self.Owner:GetViewModel()
			local seq = vm:LookupSequence( "fists_idle_02" ) 
			vm:SendViewModelMatchingSequence( seq )
			
			self:UpdateNextIdle()
			
		--	self:EmitSound( "scifi.spectra.fm.up" )
		else
			self:SetMeleeMode( 0 )
			self:SetClip1( 0 )
			self:EmitSound( "scifi.spectra.fm.dn" )
		end

		self:SetNextPrimaryFire( fnGameTime() + 0.4 )
		self:SetNextSecondaryFire( fnGameTime() + 0.6 )
	else
		if ( self:GetMeleeMode() == 0 ) then
			local vm = self.Owner:GetViewModel()
			local seq = vm:LookupSequence( "fists_right" ) 
			vm:SendViewModelMatchingSequence( seq )
			
			local pOwnerEA = self.Owner:EyeAngles()
			local pOwnerET = self.Owner:GetEyeTrace()
			local fw = pOwnerEA:Forward()
			local up = pOwnerEA:Up()
			
			self.Owner:SetVelocity( fw * 256 + up * 32 )
			
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:ViewPunch( Angle( 12, 8, 0 ) )

			local weaken = 1 + ( self:GetSciFiACC() / 30 )
			self:SetCombo( 2 )
			
			self:EmitSound( "scifi.phasma.blade.stab" )
			
			self:UpdateNextIdle()
			self:SetNextMeleeAttack( fnGameTime() + 0.2 )
			
			self:SetNextPrimaryFire( fnGameTime() + weaken * 0.5 )
			self:SetNextSecondaryFire( fnGameTime() + weaken * 1.125 )

			self:AddSciFiACC( 12 )
		end
	end
	
end