AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.NpcSpawnFlags 			= {}

SWEP.Purpose				= "It makes your enemy's blood boil inside their bodies. Also, it stuns enemies like zombies for a short time, preventing them to attack you."
SWEP.Instructions			= "Hold mouse1 to fire. Fire rate, ammo consumption and maximum damage will increase with continuous fire. May arc from hit position and targets, inflicting more damage to multiple targets."
SWEP.ItemRank 				= 12

SWEP.PrintName				= "T3i AC23 'Thunderbolt' arc emitter"
SWEP.Slot					= 3
SWEP.SlotPos				= 3

SWEP.ViewModel				= "models/weapons/c_sfmp.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiSkin_2			= "vgui/white"
SWEP.SciFiSkin_3			= "vgui/white"
SWEP.SciFiWorld				= "vgui/white"

SWEP.HoldType 				= "physgun"
SWEP.HoldTypeNPC 			= "smg"
SWEP.DeploySpeed 			= 2.6

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_tbolt.vmt" )
end

SWEP.VfxMuzzleParticle 		= "tbolt_muzzle"
SWEP.VfxMuzzleRule 			= 2
SWEP.VfxMuzzleColor 		= Color( 100, 130, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 120
SWEP.VfxMuzzleFarZ 			= 420

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.ChargeAdd				= 0.4
SWEP.ChargeDrain			= 0.6

SWEP.ReloadTime 			= 1.8

SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( 0, 0, 2 )
SWEP.ViewModelReloadAng		= Angle( -10, -4, 0 )
SWEP.ViewModelSprintPos		= Vector( -1, -2, 2 )
SWEP.ViewModelSprintAng		= Angle( -12, 4, 0 )
SWEP.ViewModelMeleePos		= Vector( 22, 4, -1 )
SWEP.ViewModelMeleeAng		= Angle( -10, 80, -60 )
SWEP.ViewModelMenuPos		= Vector( 16, 3.2, -4 )
SWEP.ViewModelShift 		= false

SWEP.DepletedSND 			= nil

SWEP.SciFiFamily			= { "elemental", "phys", "infammo", "autoregen", "noads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 1 * 2", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Damage type: 	Shock", color = Color( 80, 80, 255 ) },
	["3"] = { text = "Status Chance: 5%", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Fire rate: 				 12 (continuous)", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate and damage increase with continuous fire.", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Lightning arcs from targets up to 3 times, inflicting damage and status every time.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Can easily hit multiple targets at once, but will reduce the amount of possible arcs.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Shock elemental damage stuns enemies for a brief amount of time and inflicts devastating damage vs. shields.", color = Color( 180, 180, 180 ) },
	["9a"] = { text = "Say 'Watt' Again", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 2,
		DamageAttackRange = 256,
		DamageType = DMG_SHOCK,
		StatusChance = 5,
		FireRate = { 
			{ RateTitle = "continuous", RateDelay = 0.08 }, 
		},
	},
	Secondary = {
		DamageAmount = 16,
		DamageBlastRadius = 128,
		DamageType = DMG_SHOCK,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 1.2 },
		},
	},
	ClipSize = 100,
	ReloadSpeed = 1.8,
	Recoil = 4,
	PerkSet = { SCIFI_PERK_ELEMENTAL_SHOCK, SCIFI_PERK_AMMO_STICKYGRENADES, SCIFI_PERK_ACCESSORY_RECOIL }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.base"] = { scale = Vector(1, 1, 1), pos = Vector(0, -4, 12), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(6, 0, -7), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-20, -20, 80) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector( -2, 0, -1 ), angle = Angle( -5, 0, -2 ) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 3), angle = Angle(-90, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/maxofs2d/thruster_propeller.mdl", bone = "", rel = "parent", pos = Vector(2, 2.1, 9.7), angle = Angle(180, 10, 86), size = Vector(0.15, 0.15, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_cooling", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/maxofs2d/thruster_propeller.mdl", bone = "", rel = "parent", pos = Vector(2, 1.1, 10), angle = Angle(180, -10, -86), size = Vector(0.15, 0.15, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_cooling", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "parent", pos = Vector(4.8, 1.4, 14), angle = Angle(-20, 180, 176), size = Vector(0.015, 0.015, 0.015), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "parent", pos = Vector(6.45, 1.3, 5), angle = Angle(0, 180, 176), size = Vector(0.015, 0.015, 0.015), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/scanner_gib01.mdl", bone = "", rel = "parent", pos = Vector(0.8, 0, 13), angle = Angle(110, 0, 0), size = Vector(0.5, 0.44, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "", rel = "parent", pos = Vector(2.6, 1.6, 16), angle = Angle(4, 0, 6), size = Vector(0.02, 0.02, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/maxofs2d/lamp_projector.mdl", bone = "", rel = "parent", pos = Vector(2.4, 2.1, 12), angle = Angle(88, 90, 0), size = Vector(0.2, 0.2, 0.2), color = Color(24, 24, 30, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "", rel = "parent", pos = Vector(-0.4, 2, 10), angle = Angle(170, 180, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_core", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/combine_turrets/ground_turret.mdl", bone = "", rel = "parent", pos = Vector(1.4, 1.72, 12), angle = Angle(0, 0, 4), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_case", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/utilityconnecter006c.mdl", bone = "", rel = "parent", pos = Vector(2, 1.8, 14), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_case", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "", rel = "parent", pos = Vector(2, 1.6, 6), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/hwave_core", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/moby_barrel.mdl", bone = "", rel = "parent", pos = Vector(2.6, 1, 11), angle = Angle(97, 84, 0), size = Vector(1.75, 0.65, 0.65), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_barrel", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "", rel = "parent", pos = Vector(-0.8, 5.2, 17), angle = Angle(0, 170, 0), size = Vector(1, 1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_stunbaton.mdl", bone = "", rel = "parent", pos = Vector(2.9, 2.15, 16), angle = Angle(-83, 90, 0), size = Vector(1, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_barrel", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/c_scifip.mdl", bone = "", rel = "parent", pos = Vector(10.4, 5.25, -14), angle = Angle(95, 0, 180), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_grip", skin = 0, bodygroup = {} },
--	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(0.72, 2.5, 15), angle = Angle(0, 0, 0), size = Vector(0.495, 0.495, 0.495), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/stinger/stinger_core", skin = 0, bodygroup = {} },
--	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(0.72, 2.5, 15), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/stinger/stinger_core_warp", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(-100, 0, 30), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/maxofs2d/thruster_propeller.mdl", bone = "", rel = "parent", pos = Vector(2, 2.1, 9.7), angle = Angle(180, 10, 86), size = Vector(0.15, 0.15, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_cooling", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/maxofs2d/thruster_propeller.mdl", bone = "", rel = "parent", pos = Vector(2, 1.1, 10), angle = Angle(180, -10, -86), size = Vector(0.15, 0.15, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_cooling", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "parent", pos = Vector(5.2, 1.3, 14), angle = Angle(-20, 180, 180), size = Vector(0.015, 0.015, 0.015), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "", rel = "parent", pos = Vector(6.45, 1.3, 5), angle = Angle(0, 180, 180), size = Vector(0.015, 0.015, 0.015), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/scanner_gib01.mdl", bone = "", rel = "parent", pos = Vector(0.8, 0, 13), angle = Angle(110, 0, 0), size = Vector(0.4, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "", rel = "parent", pos = Vector(2.6, 1.6, 16), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/maxofs2d/lamp_projector.mdl", bone = "", rel = "parent", pos = Vector(2.4, 1.6, 12), angle = Angle(90, 90, 0), size = Vector(0.2, 0.12, 0.12), color = Color(24, 24, 30, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "", rel = "parent", pos = Vector(-1.6, 2, 11), angle = Angle(170, 180, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_core", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/combine_turrets/ground_turret.mdl", bone = "", rel = "parent", pos = Vector(2, 1.72, 11), angle = Angle(0, 0, 0), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_case", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/utilityconnecter006c.mdl", bone = "", rel = "parent", pos = Vector(2, 1.8, 14), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_case", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "", rel = "parent", pos = Vector(2, 1.6, 6), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/hwave_core", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/moby_barrel.mdl", bone = "", rel = "parent", pos = Vector(2.6, 1.6, 11), angle = Angle(90, 90, 0), size = Vector(1.75, 0.65, 0.65), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/moby/moby_barrel", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "", rel = "parent", pos = Vector(-0.8, 5.2, 17), angle = Angle(0, 170, 0), size = Vector(1, 1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_stunbaton.mdl", bone = "", rel = "parent", pos = Vector(3, 2.15, 16), angle = Angle(-90, 90, 0), size = Vector(1, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_barrel", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/c_scifip.mdl", bone = "", rel = "parent", pos = Vector(10.4, 5.45, -14), angle = Angle(95, 0, 180), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/tbolt/tbolt_grip", skin = 0, bodygroup = {} },
--	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(0.72, 2.5, 15), angle = Angle(0, 0, 0), size = Vector(0.495, 0.495, 0.495), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/stinger/stinger_core", skin = 0, bodygroup = {} },
--	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(0.72, 2.5, 15), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/stinger/stinger_core_warp", skin = 0, bodygroup = {} }
}

-- resource.AddSingleFile( "ambient/energy/electric_loop.wav" )
util.PrecacheSound( "ambient/energy/electric_loop.wav" )
-- resource.AddSingleFile( "common/NULL.wav" )
util.PrecacheSound( "common/NULL.wav" )

sound.Add( {
	name = "scifi.tbolt.fire",
	channel = CHAN_WEAPON, 
	volume = 1, 
	level = 50, 
	pitch = PITCH_NORM,
	sound = "ambient/energy/electric_loop.wav"
} )

function SWEP:SubInit()

	self.ScifiNextAmmoDrain = 0
	
end

function SWEP:ResetDeployment()

	if ( IsValid( self ) && CLIENT ) then
		local entIndex = self:EntIndex()
		local pOwnerIndex = LocalPlayer():EntIndex()
		
		EmitSound( "common/NULL.wav", Vector( 0, 0, 0 ), entIndex, CHAN_WEAPON, pOwnerIndex, 100, bit.bor( SND_IGNORE_NAME, SND_STOP ), 100 )
	end

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
	end
	
end

function SWEP:Deploy() 

	self:SetAds( false )	

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self.SciFiState = SCIFI_STATE_IDLE
		self.SciFiMeleeCharge = 0
		self:SetSciFiACC( 4 )
	end
	
	if ( CLIENT ) then
		self.SciFiState = SCIFI_STATE_IDLE -- doubled as a hotfix for level transitions.
	end
	
	self.ScifiNextAmmoDrain = 0
	
	menu = 0
	sprint = 0
	rouch = 0
	melee = 0
	Mul = 0

	return true
	
end

function SWEP:Think()

	if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && self:Clip1() >= 1 ) && (self.SciFiState ~= SCIFI_STATE_SPRINT ) && (self.SciFiState ~= SCIFI_STATE_RELOADING ) then
		if ( self:GetCharge() < self.ChargeMax ) then
			self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
		end
		
		if ( CLIENT ) then
	--[[	
			EmitSound( 
				"ambient/energy/electric_loop.wav", 
				self:GetProjectileSpawnPos(), 
				self:EntIndex(), 
				CHAN_WEAPON, 
				1, 
				70 + ( self.Charge / 4 ), 
				SND_CHANGE_PITCH, 
				100 + ( self.Charge / 4 ) 
			)
	]]--
			self:EmitSound( "scifi.tbolt.fire", math.min( 70 + ( self:GetCharge() * 0.25 ) ), 100 + ( self:GetCharge() * 0.25 ), 1, CHAN_WEAPON )
		end
	else
		if ( self:GetCharge() > 0 ) then
			self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
		end
	end

	if ( CLIENT ) && ( self.SciFiState == SCIFI_STATE_IDLE ) then
		self.VElements["8"].angle = self.VElements["8"].angle + ( Angle( 0, 1, 0 ) * self:GetCharge() )
		
		if ( self.Owner:KeyPressed( IN_ATTACK ) && ( self:Clip1() > 0 ) && (self.SciFiState ~= SCIFI_STATE_RELOADING ) ) then
			self:EmitSound( "scifi.tbolt.hold" )
		end
		
		if ( self.Owner:KeyReleased( IN_ATTACK ) && self:Clip1() > 0 ) then
			self:EmitSound( "scifi.tbolt.throw" )
		end
	end
	
	if ( CLIENT ) && ( self.Owner:KeyReleased( IN_ATTACK ) || !self.Owner || self.SciFiState == SCIFI_STATE_SPRINT || self:Clip1() <= 0 || self.SciFiState == SCIFI_STATE_RELOADING ) then
		self:StopSound( "scifi.tbolt.fire" )
		EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, self.Owner:EntIndex(), 100, bit.bor( SND_IGNORE_NAME, SND_STOP ), 100 )
	end

	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( event == 6001 ) then 
		return true 
	end

	if ( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.08 - ( self:GetCharge() / 4096 ) )

	local cmdDamage = GetConVarNumber( "sfw_damageamp" )

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	local pOwnerEA = self.Owner:EyeAngles()
	local fw = pOwnerEA:Forward()
	
	if ( SERVER ) && ( self.Owner:IsNPC() || self.Owner:KeyDown( IN_USE ) ) then
		if ( !self:CanPrimaryAttack( 19 ) ) then return end
		
		if ( CLIENT ) then return end
		
		local bolt = ents.Create( "sfw_thor_ent" )
		bolt:SetPos( self:GetProjectileSpawnPos() )
		bolt:SetAngles( pOwnerEA )
		bolt:SetOwner( self.Owner )
		bolt:Spawn()
		
		local physBolt = bolt:GetPhysicsObject()
		physBolt:ApplyForceCenter( pOwnerAV * 2048 )
		
		self:SetNextPrimaryFire( CurTime() + 0.5 )
		
		if ( self.Owner:IsNPC() ) then
			self:TakePrimaryAmmo( 100 )
		else
			self:TakePrimaryAmmo( 20 )
		end
		
		self:DoMuzzleEffect()
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		
		return
	end
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
	
	local cone = ents.FindInCone( pOwnerSP, pOwnerAV, 256, 0 )
	local scan = util.TraceHull( {
		start = pOwnerSP + fw * 32,
		endpos = pOwnerSP + fw * 256,
		filter = function( ent ) if ( IsValid( ent ) && ( ent ~= self.Owner || ent:GetOwner() == self.Owner ) ) then return true end end,
		mins = Vector( -128, -128, -128 ),
		maxs = Vector( 128, 128, 128 ),
		mask = MASK_SHOT_HULL,
		ignoreworld = true
	} )
	
	local iDmg = ( 1 + ( self:GetCharge() / 60 ) ) * cmdDamage

	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( .2, .2 )
	ptru.Tracer = 1
	ptru.TracerName = "tbolt_tracer_cheap"
	ptru.HullSize = 4
	ptru.Distance = 256
	ptru.Damage = iDmg
	ptru.Force = 0.1
	ptru.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_ENERGYBEAM )
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( dmginfo:GetDamage() / 2 )
		end
		
		if ( tr.MatType == MAT_METAL ) then
			dmginfo:SetDamage( dmginfo:GetDamage() * 2 )
		end

		if ( GetRelChance( 5 ) ) then
			DoElementalEffect( { Element = EML_SHOCK, Target = tr.Entity, Attacker = self.Owner } )
			ParticleEffect( "eml_generic_shock", tr.HitPos, tr.Normal:Angle() )
		end
	end
	
	local boff = {}
	boff.Num = 1
	boff.Spread = Vector( 0, 0 )
	boff.Tracer = 0
	boff.HullSize = 4
	boff.Distance = 128
	boff.Damage = iDmg / 2
	boff.Force = 0.1
	boff.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_ENERGYBEAM )
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( dmginfo:GetDamage() / 2 )
		end

		util.ParticleTracerEx( 
			"tbolt_tracer_cheap",
			tr.StartPos,
			tr.HitPos,
			self:EntIndex(),
			0,
			-1
		)
	end

	local bullet = {}
	bullet.Num = 2
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV
	if ( IsValid( scan.Entity ) && ( scan.Entity:IsPlayer() || scan.Entity:IsNPC() ) ) then -- Woo, intelligent lightning. :/ What will come next?
		local tEntitySP = scan.Entity:WorldToLocal( scan.Entity:EyePos() ) 
		local tPosition = scan.Entity:GetPos() + ( tEntitySP / 2 )
		
		bullet.Dir = bullet.Dir + ( tPosition - pOwnerSP ) * 0.002
	end
	bullet.Tracer = 1
	bullet.HullSize = 16
	bullet.TracerName = "tbolt_tracer"
	bullet.Distance = 256
	bullet.Damage = iDmg
	bullet.Force = 0.1
	bullet.Spread = Vector( .2, .2 )
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_ENERGYBEAM )
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( dmginfo:GetDamage() / 2 )
		end
		
		if ( GetRelChance( 5 ) ) then
			DoElementalEffect( { Element = EML_SHOCK, Target = tr.Entity, Attacker = self.Owner } )
			ParticleEffect( "eml_generic_shock", tr.HitPos, tr.Normal:Angle() )
		end
		
		if ( table.HasValue( cone, scan.Entity ) ) then
			local tEntitySP = scan.Entity:WorldToLocal( scan.Entity:EyePos() ) 
			local tPosition = scan.Entity:GetPos() + ( tEntitySP / 2 )
			
			ptru.Src = tr.HitPos - pOwnerAV * 16
			ptru.Dir = ( tPosition - ptru.Src )
			self.Owner:FireBullets( ptru, false )
		end

		boff.Src = tr.HitPos - pOwnerAV
		boff.Dir = ( tr.Normal + tr.HitNormal )
		self.Owner:FireBullets( boff, false )
	end

	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -0.2, 0, 0 ) )
		self:AddSciFiACC( 4 )
	end
	
	self:DoMuzzleEffect()
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	if ( self.ScifiNextAmmoDrain <= CurTime() ) then
		self:TakePrimaryAmmo( 1 )
		self.ScifiNextAmmoDrain = CurTime() + ( 0.28 - ( self:GetCharge() / 512 ) )
	end

end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then
		EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, self.Owner:EntIndex(), 100, bit.bor( SND_IGNORE_NAME, SND_STOP ), 100 )
	end
	
end

function SWEP:OnReload()

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	if ( SERVER ) then return true end
	
--	print( util.GetSurfacePropName( tr.SurfaceProps ) )

	ParticleEffect( "tbolt_hit", tr.HitPos, tr.Normal:Angle() )
	sound.Play( "LoudSpark", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
	
	if ( self.Owner:IsPlayer() ) then
		if ( tr.MatType == MAT_GLASS ) then return true end
		local dlight = DynamicLight( self:EntIndex() ) 
		if ( dlight ) then
			dlight.pos = tr.HitPos 
			dlight.r = 100
			dlight.g = 130
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2048
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.5
		end
	end
	
	return true

end