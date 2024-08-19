AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false

SWEP.PrintName				= "T3i 'Ymir' Axe"

SWEP.Purpose				= ""
SWEP.Instructions			= ""

SWEP.Slot					= 0
SWEP.SlotPos				= 2

SWEP.ViewModel				= "models/weapons/c_stunstick.mdl"
SWEP.WorldModel				= "models/weapons/w_crowbar.mdl"
SWEP.HoldType 				= "crowbar"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 0.8

SWEP.DefaultSwayScale		= 2.0
SWEP.DefaultBobScale		= 4
SWEP.SprintSwayScale		= 24
SWEP.SprintBobScale			= 64
SWEP.ViewModelFOV			= 64
SWEP.Weight					= 1

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
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector( 0, 0, 0 ), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}


SWEP.VElements = {
	-- ["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(0, 0, 0), angle = Angle(-2, 2, -20), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	-- ["parent+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(14, -3, 2), angle = Angle(12, 22, -22), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	-- ["parent++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(1, 0, 1.2), angle = Angle(-4, 2, -20), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} }
	["axe"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/melee/w_fireaxe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.6, 1.2, 0), angle = Angle(0, 0, 178.5), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	-- ["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(-4, 2, -1), angle = Angle(-2, 2, -20), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	-- ["parent+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(16, -2, 2), angle = Angle(12, 2, -22), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	-- ["parent++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(-3, 0, 5), angle = Angle(-14, -2, -10), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} }
}

local pHealth = 0
local pShield = 0
local LastMeleeMode = 0

local LUArmAngle = Angle( 0, 20, -10 )
local LUArmOrigin = Vector( 1, 0, 2 )
local RUArmAngle = Angle( -10, -2, -4 )
local RUArmOrigin = Vector( 0, 0, 0 )
local RFArmAngle = Angle( 0, 0, 0 ) --Angle( 10, 20, 10 )
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
	self:SetCharge( 0 )
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
	
	end
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( GetConVarNumber( "sfw_allow_advanims" ) == 1 ) then
		if ( game.SinglePlayer() ) then
			self.SckAnimDeployed = 5
		else
			self.SckAnimDeployed = 3
		end
		
		self.BladeAnim = true
		self.BladeAnimTime = CurTime() + math.max( FrameTime() * 60, 0.6 )
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

end

function SWEP:Think()

	if !( IsValid( self ) && IsValid( self.Owner ) ) then
		return
	end

	if ( IsValid( self.Owner ) && self.Owner:InVehicle() ) then
		self.SckAnimDeployed = 6
		
		return
	end

	-- what an unelegant workaround --
	if ( CLIENT ) && ( self.SckAnimDeployed > 0 && self.BladeAnimTime < CurTime() ) then
		self.BladeAnimTime = CurTime() + 0.02
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
	
	vm:SetPlaybackRate( 0.4 )
	
	if ( idletime >= 0 && CurTime() > idletime ) && ( SERVER ) then
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" .. math.random( 1, 2 ) ) )

		self:UpdateNextIdle()
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
	end
	
	if ( seq == 2 ) then
		LUArmAngle = Angle( 0, 20, -10 ) + ( Angle( 0, 20, -20 ) * animtime )
		LUArmOrigin = Vector( 1, 0, 2 ) + ( Vector( -1, 0, -2 ) * animtime )
		
		RUArmAngle = Angle( -1, -1, 1 ) + ( Angle( -1, 1, 41 ) * animtime )
		RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( 0, -2, 2 ) * animtime )

		RFArmAngle = Angle( 10, 20, 10 ) + ( Angle( -24, -24, -32 ) * animtime )

		self.Charge = self.Charge + ( 1 + animtime * -1 )
	end
-- print(seq)
	if ( seq == 3 ) then
		LUArmAngle = Angle( 0, 20, -10 ) + ( Angle( 0, 20, -20 ) * animtime )
		LUArmOrigin = Vector( 1, 0, 2 ) + ( Vector( -1, 0, -2 ) * animtime )
		
		RUArmAngle = Angle( -10, -16, 4 ) + ( Angle( 14, 16, 0 ) * animtime )
		RUArmOrigin = Vector( 0, 0, 0 ) + ( Vector( 0, -2, 2 ) * animtime )

		-- RFArmAngle = Angle( 10, 20, 10 ) + ( Angle( -24, -24, -32 ) * animtime )

		self.Charge = self.Charge + ( 1 + animtime * -1 )
	end

	if ( !self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_ATTACK2 ) ) then
		self.Charge = math.Clamp( self.Charge - self.ChargeDrain, 0, self.ChargeMax )
	end

	if ( self.SckAnimDeployed > 0 ) then
		self.SckAnimDeployed = math.Approach( self.SckAnimDeployed, 0, FrameTime() * 4 * animspeed ) 
	end
	
	if ( self.SckAnimModeswitch > 0 )then
		self.SckAnimModeswitch = math.Approach( self.SckAnimModeswitch, 0, FrameTime() * 12 * animspeed ) 
	end
	
	self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = LUArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos = LUArmOrigin
	self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = RUArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].pos = RUArmOrigin
	self.ViewModelBoneMods["ValveBiped.Bip01_R_Forearm"].angle = RFArmAngle
	self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle = RHandAngle

	self:SciFiMath()

end

function SWEP:DealDamage()

	local pOwnerSP = self.Owner:GetShootPos()
	local pOwnerAV = self.Owner:GetAimVector()
	
	self.Owner:LagCompensation( true )
	
	local iDmg = 48 * GetConVarNumber( "sfw_damageamp" )
	local iRange = 52
	
	if ( self.Combo == 1 ) then
		iDmg = iDmg * 1.5
		iRange = 40
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

	
	-- if ( trResult.Hit && !( game.SinglePlayer() && CLIENT ) ) then
		-- local vm = self.Owner:GetViewModel()
		-- vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter"..math.random( 1, 2 ) ) )
		
	--	self:EmitSound( "scifi.phasma.blade.scratch" )
	--	self:EmitSound( "scifi.spectra.hit" )
	--	ParticleEffect( "astra_hit", trResult.HitPos, trResult.HitNormal:Angle(), self )
	-- end
	
	-- if ( trResult.Hit ) then
		-- self:SendWeaponAnim( ACT_VM_SWINGMISS )
	-- else
		-- self:SendWeaponAnim( ACT_VM_SWINGHIT )
	-- end

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

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter"..math.random( 1, 2 ) ) )
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner:ViewPunch( Angle( -2, 8, 1 ) )

	local weaken = 1 + ( self:GetSciFiACC() / 30 )
	self:SetCharge( 0 )
		
	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 - ( self.Combo / 10 ) )
	
	self:SetNextPrimaryFire( CurTime() + weaken )
	self:SetNextSecondaryFire( CurTime() + weaken )

	self:AddSciFiACC( 12 )

end

function SWEP:SecondaryAttack()
	
end