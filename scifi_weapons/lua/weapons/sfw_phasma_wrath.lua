AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

local overpower = GetConVarNumber( "sfw_sk_phasma_enableoverpower" )

SWEP.Spawnable 				= false

SWEP.PrintName				= "sfw_phasma_wrath" --"C-AE Phasma"

--SWEP.Purpose				= "The Celestial Ascendant's trade mark melee weapon. Providing offensive as well as defensive aspects, the Phasma can adapt to any combat situation."
--SWEP.Instructions			= "Mouse1 to strike. Holding down Mouse1 will vary the type of attack used. Mouse2 to perform a forward leap with narrowed range but increased damage.\n Press 'Use' (def.E) + Mouse2 to switch to shield mode. Press Mouse1 in shieldmode to perform a counter attack."

SWEP.Slot					= 0
SWEP.SlotPos				= 2

SWEP.ViewModel				= "models/weapons/c_arms.mdl"
SWEP.WorldModel				= "models/weapons/w_knife_t.mdl"
SWEP.HoldType 				= "knife"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 0.8

SWEP.DefaultSwayScale		= 2.0
SWEP.DefaultBobScale		= 4
SWEP.SprintSwayScale		= 6
SWEP.SprintBobScale			= 6
SWEP.ViewModelFOV			= 64
SWEP.Weight					= 1

SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 250
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= ""

if ( owerpower == 1 ) then
	SWEP.ChargeMax 			= 10000000
else
	SWEP.ChargeMax 			= 250
end

SWEP.SciFiFamily			= { "custom", "melee_simple", "infammo" }

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
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(0, 0, 0), angle = Angle(-2, 2, -20), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["parent+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(14, -3, 2), angle = Angle(12, 22, -22), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["parent++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(1, 0, 1.2), angle = Angle(-4, 2, -20), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(0, 1.8, 1.9), angle = Angle(45.893, 14.565, -19.542), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(3, 2, 1), angle = Angle(31.653, 9.727, -14.4), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(6, 2.2, -0.3), angle = Angle(12.998, 0.146, -11.822), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(9.2, 2.8, 1.824), angle = Angle(-50, 52, -17), size = Vector(0.5, 0.699, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(9.161, -3.6, -0.676), angle = Angle(-16, -67, 3), size = Vector(0.5, 0.699, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(20.08, 0.451, -0.484), angle = Angle(-10, -173.482, 25.395), size = Vector(1, 1, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1++++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(30.406, -1.019, 1.851), angle = Angle(-16, -170.084, 24.968), size = Vector(1, 1, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blade1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(34, -2.4, 4.4), angle = Angle(-168, 5, 124), size = Vector(1.3, 0.5, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_glyph_solid", skin = 0, bodygroup = {} },
	["blade1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(34, -2.6, 4.4), angle = Angle(-168, 5, 128), size = Vector(1.3, 0.5, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_glyph_solid", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(-4, 2, -1), angle = Angle(-2, 2, -20), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["parent+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(16, -2, 2), angle = Angle(12, 2, -22), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["parent++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(-3, 0, 5), angle = Angle(-14, -2, -10), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(0, 1.8, 1.), angle = Angle(45.893, 14.565, -19.542), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(3, 2, 1), angle = Angle(31.653, 9.727, -14.4), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent+", pos = Vector(6, 2.2, -0.3), angle = Angle(12.998, 0.146, -11.822), size = Vector(0.2, 0.2, 0.239), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(9.161, 3.2, 1.636), angle = Angle(-50, 41.696, -36.98), size = Vector(0.5, 0.699, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(9.161, -2.929, -0.676), angle = Angle(-17, -66.195, 3.069), size = Vector(0.5, 0.699, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(20.08, 0.451, -0.484), angle = Angle(-10, -173.482, 25.395), size = Vector(1, 1, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1++++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/astra_body.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent", pos = Vector(30.406, -1.019, 1.851), angle = Angle(-16, -170.084, 24.968), size = Vector(1, 1, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["blade1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(34, -2.4, 4.4), angle = Angle(-168, 5, 124), size = Vector(1.3, 0.5, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_glyph_solid", skin = 0, bodygroup = {} },
	["blade1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "parent++", pos = Vector(34, -2.6, 4.4), angle = Angle(-168, 5, 128), size = Vector(1.3, 0.5, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/spectra/phasma_glyph_solid", skin = 0, bodygroup = {} }
}


local pHealth = 0
local pShield = 0
local LastMeleeMode = 0

local LUArmAngle = Angle( 0, 20, -10 )
local LUArmOrigin = Vector( 1, 0, 2 )
local RUArmAngle = Angle( -10, 2, 4 )
local RUArmOrigin = Vector( 0, 0, 0 )
local RFArmAngle = Angle( 10, 20, 10 )
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

local BladeEntity
local BladeGlow = Vector( 2.4, 0.3,  0.3 )

local mymat = Material( "models/weapons/spectra/phasma_glyph_solid" )

SWEP.LastAttackTime = 0

SWEP.DataTables = {
	{ dType = "Bool", dName = "AnimSingleParticle" },
	{ dType = "Int", dName = "MeleeMode" },
	{ dType = "Int", dName = "Combo" },
	{ dType = "Float", dName = "NextMeleeAttack" },
	{ dType = "Float", dName = "AnimNextParticle" }
}

function SWEP:SubInit()

	self.SckAnimModeswitch = 0
	self.SckAnimDeployed = 6
	self.Charge = 0
	self.Combo = 0
	
	self.BladeAnim = true
	self.BladeAnimTime = CurTime() + 0.45

end

function SWEP:ResetDeployment()

	if ( IsValid( self.Owner ) && CLIENT && self.Owner:IsPlayer() ) then
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
		
		if ( IsValid( BladeEntity ) ) then
			BladeEntity:StopParticles()
		end

		if ( self:GetMeleeMode() == 0 ) then
			self:EmitSound( "scifi.phasma.blade.turnoff" )
		end
	end
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( GetConVarNumber( "sfw_allow_advanims" ) == 1 ) then
		if ( game.SinglePlayer() ) then
			self.SckAnimDeployed = 6
		else
			self.SckAnimDeployed = 4
		end
		
		self.BladeAnim = true
		self.BladeAnimTime = 0 --math.max( FrameTime() * 60, 0.6 )
	end
	
	if ( CLIENT ) && ( IsValid(self.Owner) ) && ( self.Owner:IsPlayer() ) then
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

	self:SetAds( false )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
	
	self:UpdateNextIdle()
	
	pHealth = self.Owner:Health()
	pShield = self.Owner:Armor()
	
	if ( game.SinglePlayer() ) then
		self.SckAnimDeployed = 8
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

	return true
	
end

local animspeed = 1
if ( !game.SinglePlayer() ) then
	animspeed = 1.72
end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetAnimNextIdle( CurTime() + vm:SequenceDuration() )
	
	if ( self.LastAttackTime + 2 <= CurTime() ) then
		if ( self:GetHoldType() == self.HoldType ) then
			self:SetHoldType( "knife" )
		end
	else
		if ( self:GetHoldType() == self.HoldTypeSprint ) then
			self:SetHoldType( "fist" )
		end
	end

end

function SWEP:Think()

	if !( IsValid( self ) && IsValid( self.Owner ) ) then
		return
	end

	if ( IsValid( self.Owner ) && self.Owner:InVehicle() ) then
		self.SckAnimDeployed = 6
		
		return
	end
	
	if ( CLIENT ) then
		BladeEntity = self.VElements["blade1"].modelEnt
		
		if ( ( GetViewEntity() ~= LocalPlayer() ) || GetConVarNumber( "ihl_3rdperson" ) == 1 || self.Owner ~= LocalPlayer() ) then
			BladeEntity = self.WElements["blade1"].modelEnt
		end
	end

	-- what an unelegant workaround --
	if ( CLIENT ) && ( self.SckAnimDeployed > 0 && self.BladeAnimTime < CurTime() ) then
		self.BladeAnimTime = CurTime() + 0.008
	end

	if ( IsValid( self.Owner ) && self.Owner:GetActiveWeapon() ~= self.Weapon ) then return end
	
	if ( ( IsValid( self ) && IsValid( self.Owner ) ) && ( !self.Charge || !isnumber( self.Charge ) ) ) then
		self.Charge = 1
	end
	
	if ( self:GetMeleeMode() ~= LastMeleeMode ) then
		self.SckAnimModeswitch = 10
		
		self.BladeAnim = true
		self.BladeAnimTime = CurTime() + math.max( FrameTime() * 10, 0.32 )

		if ( CLIENT ) then
			self.VElements["parent+"].modelEnt:StopParticles()
			BladeEntity:StopParticles()
		end
	end

	local vm = self.Owner:GetViewModel()
	local seq = vm:GetSequence()
	
	local curtime = CurTime()
	local idletime = self:GetAnimNextIdle()
	local animtime = idletime - curtime
	
	local sine0 = math.sin( CurTime() * 8 ) / 16
	local sine1 = math.sin( CurTime() * 6 ) / 24
	local sine2 = math.sin( CurTime() * 4 ) / 32
	local cmod = self.Charge / 100
	
	if ( self:GetMeleeMode() == 1 ) && ( self.SckAnimModeswitch <= 0 ) then
		BladeGlow = Vector( 0, 0, 0 )
	else
		BladeGlow = Vector( 2.4, 0.3,  0.3 )
	end

	if ( idletime >= 0 && CurTime() > idletime ) && ( SERVER ) then
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )

		self:UpdateNextIdle()
	end

	if ( self:GetMeleeMode() == 0 ) then
		if ( self.SckAnimModeswitch > 0 ) then
			local iFrameTime = FrameTime() * 6

			MClaw1Origin = LerpVector( iFrameTime, MClaw1Origin, Vector(0, 1.8, 1.9) )
			MClaw1Angle = LerpAngle( iFrameTime, MClaw1Angle, Angle(46, 15, -20) )
			MClaw2Origin = LerpVector( iFrameTime, MClaw2Origin, Vector(3, 2, 1) )
			MClaw2Angle = LerpAngle( iFrameTime, MClaw2Angle, Angle(31.5, 9.7, -14.4) )
			MClaw3Origin = LerpVector( iFrameTime, MClaw3Origin, Vector(6, 2.2, -0.3) )
			MClaw3Angle = LerpAngle( iFrameTime, MClaw3Angle, Angle(13, 0.2, -12) )
		
			MGrip1Origin = LerpVector( iFrameTime, MGrip1Origin, Vector(20, 0.5, -0.5) )
			MGrip1Angle = LerpAngle( iFrameTime, MGrip1Angle, Angle(-10, -176, 25) )
			MGrip2Origin = LerpVector( iFrameTime, MGrip2Origin, Vector(30.5, -1.019, 1.8) )
			MGrip2Angle = LerpAngle( iFrameTime, MGrip2Angle, Angle(-16, -170, 25) )
		
			RUArmAngle = LerpAngle( iFrameTime, RUArmAngle, Angle( -10, 2, 4 ) )
			RUArmOrigin = LerpVector( iFrameTime, RUArmOrigin, Vector( 0, 0, 0 ) )
			RFArmAngle = LerpAngle( iFrameTime, RFArmAngle, Angle( 10, 20, 10 ) )
			RHandAngle = LerpAngle( iFrameTime, RHandAngle, Angle( 0, 0, 0 ) )

		end
	
		if ( self:GetNextMeleeAttack() > 0 && CurTime() > self:GetNextMeleeAttack() ) then

			if ( self.Owner:KeyDown( IN_ATTACK ) ) then
				if ( self.Combo == 0 ) then
					self.Combo = 1
				else 
					self.Combo = 0
				end
			end
			
			if ( self.Owner:KeyDown( IN_ATTACK2 ) ) then
				self.Combo = 2
			end
			
			self:DealDamage()

			self:SetNextMeleeAttack( 0 )
			
			if ( self:GetHoldType() == self.HoldTypeSprint ) then
				self:SetHoldType( self.HoldType )
			end
		end
		
		-- Primary attack, wide slash --
		if ( seq == 5 ) then
			if ( self.Combo == 0 ) then
				LUArmAngle = Angle( 0, 20, -10 ) + ( Angle( 20, 20, 0 ) * animtime )
				LUArmOrigin = Vector( 1, 0, 2 ) + ( Vector( -1, 0, -2 ) * animtime )
				
				RUArmAngle = Angle( -10, 2, 4 ) + ( Angle( 10, 40, math.sin( animtime * 8 ) * 60 ) * animtime )
				RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( -2, 4, -4 ) * animtime )
				
				RFArmAngle = Angle( 10, 20, 10 ) + ( Angle( -10, -10, 10 ) * animtime )
			else
				LUArmAngle = Angle( 0, 20, -10 ) + ( Angle( 20, 20, 0 ) * animtime )
				LUArmOrigin = Vector( 1, 0, 2 ) + ( Vector( -1, 0, -2 ) * animtime )
				
				RUArmAngle = Angle( -10, 2, 4 ) + ( Angle( 45 + math.sin( animtime * 4 ) * 60, 5 + math.sin( animtime * 4 ) * 25, -60 + math.sin( animtime * 4 ) * 70 ) * animtime ) --+ Angle( 20, 0, 0 ) * animtime * 2 )
				RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( -8, 2, 4 ) * animtime )
				
				RFArmAngle = Angle( 10, 20, 10 ) + ( Angle( -20, 30, -140 ) * animtime )
			end
			
			BladeGlow = Vector( 2.4, 0.3,  0.3 ) + Vector( 3.2, 0.8, 0.4 ) * animtime

			self.Charge = self.Charge + ( 1 + animtime * -1 )
		end

		-- Secondary attack, forward cleave --
		if ( seq == 3 ) then
			LUArmAngle = Angle( 0, 20, -10 ) + ( Angle( 0, 20, -20 ) * animtime )
			LUArmOrigin = Vector( 1, 0, 2 ) + ( Vector( -1, 0, -2 ) * animtime )
			
			RUArmAngle = Angle( -10, 2, 4 ) + ( Angle( -4, 6, 12 ) * animtime )
			RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( 0, -4, -12 ) * animtime )

			RFArmAngle = Angle( 10, 20, 10 ) + ( Angle( -24, -24, -32 ) * animtime )
			
			BladeGlow = Vector( 2.4, 0.3,  0.3 ) + Vector( 1.2, 0, 0.2 ) * animtime

			self.Charge = self.Charge + ( 1 + animtime * -1 )
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
	
		if ( !self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_ATTACK2 ) ) then
			self.Charge = math.Clamp( self.Charge - self.ChargeDrain, 0, self.ChargeMax )
		end

	else
		if ( self.SckAnimModeswitch > 0 ) then
			local iFrameTime = FrameTime() * 4

			MClaw1Origin = LerpVector( iFrameTime, MClaw1Origin, Vector(5, 3, -2.1) )
			MClaw1Angle = LerpAngle( iFrameTime, MClaw1Angle, Angle(-46, -15, 10) )
			MClaw2Origin = LerpVector( iFrameTime, MClaw2Origin, Vector(6, 1, -2) )
			MClaw2Angle = LerpAngle( iFrameTime, MClaw2Angle, Angle(-46, 5, 0) )
			MClaw3Origin = LerpVector( iFrameTime, MClaw3Origin, Vector(6, -1, -2) )
			MClaw3Angle = LerpAngle( iFrameTime, MClaw3Angle, Angle(-46, 25, -20) )
		
			MGrip1Origin = LerpVector( iFrameTime, MGrip1Origin, Vector(16, -6, 0.2) )
			MGrip1Angle = LerpAngle( iFrameTime, MGrip1Angle, Angle(-14, -130, -2.2) )
			MGrip2Origin = LerpVector( iFrameTime, MGrip2Origin, Vector(16, 4, 2.7) )
			MGrip2Angle = LerpAngle( iFrameTime, MGrip2Angle, Angle(-40, 145, 15) )
		
			RUArmAngle = LerpAngle( iFrameTime, RUArmAngle, Angle(0, -20, -32) )
			RUArmOrigin = LerpVector( iFrameTime, RUArmOrigin, Vector(1, 1, -2) )
			RFArmAngle = LerpAngle( iFrameTime, RFArmAngle, Angle(-14, -5, -32) )
			RHandAngle = LerpAngle( iFrameTime, RHandAngle, Angle(0, 10, -60) )
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
		
		local HealthDiff = math.Clamp( pHealth - self.Owner:Health(), 0, 100 )

		if ( pHealth > 0 ) then
			if ( pHealth > self.Owner:Health() ) then
			if ( SERVER ) then
					local pOwnerSP = self.Owner:GetShootPos()
					local pOwnerAV = self.Owner:GetAimVector()
					local pOwnerEA = self.Owner:EyeAngles()
				
					ParticleEffect( "celest_wrath_hit", pOwnerSP + pOwnerAV * 32 + pOwnerEA:Up() * -4, pOwnerEA, self )
					
					self:EmitSound( "weapons/ancient/phasma_absorb.wav", 70, math.Clamp( 60 + self:Clip1(), 60, 200 ), 1, CHAN_WEAPON )
			end
				if !( game.SinglePlayer() && CLIENT ) then
					if ( self:GetNextPrimaryFire() <= CurTime() ) then
						self.Charge = math.Clamp( self.Charge + HealthDiff, 0, self.ChargeMax )
						self:SetClip1( self.Charge )

						self.Owner:SetHealth( pHealth - ( HealthDiff * math.Round( self:Clip1() / 1000, 1 ) ) )
						
						if ( overpower == 1 ) then
							self.Owner:SetArmor( pShield )
						end
					end
				end
			end
		end
	end


	-- timed blade anim event --
	if ( CLIENT ) && ( self.BladeAnim && self.BladeAnimTime <= CurTime() ) then
		if ( self:GetMeleeMode() == 0 ) then
			ParticleEffectAttach( "phasma_w_blade_enable", PATTACH_ABSORIGIN_FOLLOW, BladeEntity, 1 )
			ParticleEffectAttach( "phasma_w_initial_mist", PATTACH_ABSORIGIN_FOLLOW, BladeEntity, 1 )
			
			self:EmitSound( "scifi.phasma.blade.turnon" )
		end
		
		if ( self:GetMeleeMode() == 1 && LastMeleeMode == 0 ) then
			ParticleEffectAttach( "phasma_w_blade_enable", PATTACH_ABSORIGIN_FOLLOW, BladeEntity, 1 )

			self:EmitSound( "scifi.phasma.blade.turnoff" )
		end

		if ( self:GetMeleeMode() == 1 ) then
			ParticleEffectAttach( "phasma_core", PATTACH_ABSORIGIN_FOLLOW, self.VElements["parent+"].modelEnt, 1 )
		end
		
		self.BladeAnim = false
	end
	
	-- untimed blade anim event --
	if ( CLIENT ) && ( self.BladeAnim  ) then
		if ( self:GetMeleeMode() == 1 && LastMeleeMode == 0 ) then
			ParticleEffectAttach( "phasma_w_blade_enable", PATTACH_ABSORIGIN_FOLLOW, BladeEntity, 1 )

			self:EmitSound( "scifi.phasma.blade.turnoff" )
		end
	end

	if ( self.SckAnimDeployed > 0 ) then
		self.SckAnimDeployed = math.Approach( self.SckAnimDeployed, 0, FrameTime() * 4 * animspeed ) 
		
		if ( self:GetMeleeMode() == 0 ) then
			RUArmAngle =  Angle( -10, 2, 4 ) + ( Angle( -4, -6, 10 ) * self.SckAnimDeployed )
			RUArmOrigin =  Vector( 0, 0, 0 ) + ( Vector( 1, 0, 1 ) * self.SckAnimDeployed )
			RFArmAngle = Angle( 10, 20, 10 ) + ( Angle( 4, 4, -20 ) * self.SckAnimDeployed )
			
			BladeGlow = BladeGlow * math.max( 1 - self.SckAnimDeployed, 0 )
		end
	end
	
	if ( self.SckAnimModeswitch > 0 )then
		self.SckAnimModeswitch = math.Approach( self.SckAnimModeswitch, 0, FrameTime() * 12 * animspeed ) 
	
		if ( self:GetMeleeMode() == 1 ) then
			BladeGlow = BladeGlow * math.max( self.SckAnimModeswitch - 6, 0 )
		else
			BladeGlow = BladeGlow * math.max( 1 - ( self.SckAnimModeswitch / 1 ), 0 )
		end
	end

	mymat:SetVector( "$selfillumtint", BladeGlow * ( 1 + cmod ) )
	
	self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = LUArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos = LUArmOrigin
	self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = RUArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].pos = RUArmOrigin
	self.ViewModelBoneMods["ValveBiped.Bip01_R_Forearm"].angle = RFArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle = RHandAngle

	if ( CLIENT ) then
		local lightorigin = BladeEntity:GetPos()
		local lightbrightness = 0.4
		
		if ( self.SckAnimDeployed > 0 )  then
			lightbrightness = math.max( lightbrightness - self.SckAnimDeployed, 0 )
		end
		
		if ( self.SckAnimModeswitch > 0 )  then
			if ( self:GetMeleeMode() == 1 ) then
				lightbrightness = math.max( self.SckAnimModeswitch - 4, 0 )
			else
				lightbrightness = math.max( lightbrightness - ( self.SckAnimModeswitch / 8 ), 0 )
			end
		end
		
		if ( self:GetMeleeMode() == 1 ) then
			lightbrightness = 0.01 + ( self:Clip1() * 0.005 )
		end
	
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = lightorigin
			dlight.r = 255
			dlight.g = 20
			dlight.b = 10
			dlight.brightness = lightbrightness
			dlight.Decay = 1024
			dlight.Size = 512 * lightbrightness * ( 1 + self.Charge * 0.001 )
			dlight.DieTime = CurTime() + 1
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
	
	local iDmg = 32 * GetConVarNumber( "sfw_damageamp" )
	local iRange = 54
	
	if ( self.Combo == 1 ) then
		iDmg = iDmg * 1.5
		iRange = 42
	end
	
	if ( self.Combo == 2 ) then
		iDmg = iDmg * 2
		iRange = 28
	end
	
	if ( self.SciFiState == SCIFI_STATE_SPRINT ) then
		iRange = iRange * 0.6
	end
	
	local cone = ents.FindInCone( pOwnerSP, pOwnerAV, iRange, 0 )
	
	local trData 		= {}
	local trResult 		= {}
	
	trData.start 		= pOwnerSP
	trData.endpos 		= pOwnerSP + pOwnerAV * 72
	trData.maxs 		= Vector( 3, 3, 1 + ( 1 * self.Combo ) ) * ( iRange / 10 )
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
		ParticleEffectAttach( "phasma_w_trail", PATTACH_ABSORIGIN_FOLLOW, BladeEntity, 1 )
	end
	
	if ( trResult.Hit && !( game.SinglePlayer() && CLIENT ) ) then
		self:EmitSound( "scifi.phasma.blade.scratch" )
		self:EmitSound( "scifi.spectra.hit" )
		ParticleEffect( "celest_wrath_hit", trResult.HitPos, trResult.HitNormal:Angle(), self )
	end
	
	if ( SERVER && trResult.Hit ) then
		local myeml = {}
		myeml.Element = EML_DISSOLVE_CELESTWRATH
		myeml.Attacker = self.Owner
		myeml.Ticks = 8
		myeml.Range = 16
		myeml.Origin = trResult.HitPos
		
		DoElementalEffect( myeml )
	end

	if ( SERVER && IsValid( trResult.Entity ) && ( trResult.Entity:IsNPC() || trResult.Entity:IsPlayer() || trResult.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
	
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( iDmg )
		dmginfo:SetDamageType( DMG_SF_PHASEBLADE )

		if ( self.Combo == 1 ) then
			dmginfo:SetDamageForce( pOwnerSP + self.Owner:GetRight() + trResult.HitNormal * 1024 )
		else
			dmginfo:SetDamageForce( pOwnerSP + self.Owner:GetForward() + trResult.HitNormal * 2048 )
		end
		
		trResult.Entity:TakeDamageInfo( dmginfo )
		
		for k,v in pairs( cone ) do
			if ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) then
				dmginfo:SetDamage( iDmg / 2 )
				v:TakeDamageInfo( dmginfo )
			end
		end
	end

	if ( SERVER && IsValid( trResult.Entity ) ) then
		local phys = trResult.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass(), trResult.HitPos )
		end
	end
	
	self.Owner:LagCompensation( false )

end

function SWEP:PrimaryAttack()

	if ( self:GetMeleeMode() == 0 ) then
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_uppercut" ) )
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:ViewPunch( Angle( -2, 8, 1 ) )

		local weaken = 0.6 - ( self:GetSciFiACC() / 150 )
		self.Charge = 0
		if ( self.Combo == 2 ) then
			self.Combo = 0
		end

		self:EmitSound( "scifi.phasma.blade.swing" )
			
		self:UpdateNextIdle()
		self:SetNextMeleeAttack( CurTime() + 0.2 - ( self.Combo / 10 ) )
		
		self:SetNextPrimaryFire( CurTime() + weaken )
		self:SetNextSecondaryFire( CurTime() + weaken )

		self:AddSciFiACC( 12 )
	else		
		if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
		local pOwnerSP = self.Owner:GetShootPos()
		local pOwnerAV = self.Owner:GetAimVector()
		local pOwnerEA = self.Owner:EyeAngles()
		local up = pOwnerEA:Up()
		local iDmg = self:Clip1() * GetConVarNumber( "sfw_damageamp" )
		
		if ( SERVER ) then
			for k, v in pairs ( ents.FindInCone( pOwnerSP, pOwnerAV, 220, 0 ) ) do
				if ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) && ( v:VisibleVec( pOwnerSP ) ) then
				--	DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 2, Attacker = self.Owner } )
					
					local tPosition = v:EyePos()
					local pPosition = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 12 )
					local tDistance = tPosition:Distance( pPosition )
					
					if ( v:IsPlayer() || v:IsNPC() ) then
						self:DealDirectDamage( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ), iDmg, v, self.Owner, self.Owner:GetAimVector() * iDmg * 128 )
					else
						iDmg = math.Clamp( iDmg - ( tDistance / 10 ), 0, iDmg )
					
						v:TakeDamage( iDmg, self.Owner, self )
					end
					
					local phys = v:GetPhysicsObject()
					if ( IsValid( phys ) ) then
						phys:ApplyForceCenter( self.Owner:GetAimVector() * iDmg * 2 )
					end
				end
			end
			util.ScreenShake( self:GetPos(), 1 * self:Clip1(), 64, 0.8, 256 )
		end
		
		if ( SERVER ) || ( !game.SinglePlayer() ) then
			ParticleEffect( "celest_wrath_pulse", pOwnerSP + pOwnerAV * 24 + up * -4, pOwnerEA, self )
			ParticleEffect( "celest_wrath_explode", pOwnerSP + pOwnerAV * 24 + up * -4, pOwnerEA, self )
			
			self:EmitSound( "scifi.zeala.fire" )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -6, -6 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) )
			self:AddSciFiACC( 12 )
		end

		self:TakePrimaryAmmo( self:Clip1() )
		self.Charge = 0
		self:AddSciFiACC( 13 )
	end
	
	self.LastAttackTime = CurTime()

end

function SWEP:SecondaryAttack()

	if ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetMeleeMode() == 0 ) then
			self:SetMeleeMode( 1 )
			self:SetClip1( 0 )

			local vm = self.Owner:GetViewModel()
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_02" ) )
			
			self:UpdateNextIdle()
			
		--	self:EmitSound( "scifi.spectra.fm.up" )
		else
			self:SetMeleeMode( 0 )
			self:SetClip1( 0 )
			self:EmitSound( "scifi.spectra.fm.dn" )
		end

		self:SetNextPrimaryFire( CurTime() + 0.6 )
		self:SetNextSecondaryFire( CurTime() + 1 )
	else
		if ( self:GetMeleeMode() == 0 ) then
			local vm = self.Owner:GetViewModel()
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_right" ) )
			
			local pOwnerEA = self.Owner:EyeAngles()
			local pOwnerET = self.Owner:GetEyeTrace()
			local fw = pOwnerEA:Forward()
			local up = pOwnerEA:Up()
			
			self.Owner:SetVelocity( fw * 256 + up * 32 )
			
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:ViewPunch( Angle( 12, 8, 0 ) )

			local weaken = 0.5 + ( self:GetSciFiACC() / 30 )
			self.Charge = 0
			self.Combo = 2
			
			self:EmitSound( "scifi.phasma.blade.stab" )
			
			self:UpdateNextIdle()
			self:SetNextMeleeAttack( CurTime() + 0.2 )
			
			self:SetNextPrimaryFire( CurTime() + weaken )
			self:SetNextSecondaryFire( CurTime() + weaken )

			self:AddSciFiACC( 12 )
		end
	end
	
	self.LastAttackTime = CurTime()

	
end