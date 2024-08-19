AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "The stinger fires slow moving projectiles that will stick on enemies and some other surfaces. Damage them to let them explode."
SWEP.Instructions			= "Mouse1 to fire normal sting. Mouse2 to fire three homing stings. Mouse1 + 'Use' (e) to remotely destroy stings. Projectiles stick on enemies."
SWEP.ItemRank 				= 28

SWEP.ViewModel				= "models/weapons/c_scifivtwoh.mdl"
SWEP.WorldModel				= "models/weapons/w_physics.mdl"
SWEP.HoldType 				= "physgun"
SWEP.DeploySpeed 			= 1.4
SWEP.SciFiSkin				= "/models/weapons/stinger/skin.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_stinger.vmt" )
end

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "AR2AltFire"

SWEP.VfxMuzzleParticle 		= "stinger_muzzle"
SWEP.VfxMuzzleColor 		= Color( 110, 190, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 120
SWEP.VfxMuzzleFarZ 			= 400

SWEP.ViewModelSprintAng		= Angle( -10, 0, 0 )
SWEP.ViewModelMeleePos		= Vector( -2, 8, 4 )
SWEP.ViewModelMeleeAng		= Angle( -8, 10, -2 )
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( -0.045, 0.05, -0.3 )
SWEP.ViewModelShiftRotation = Vector( 0.5, 0.1, 0.2 )
SWEP.SprintSwayScale		= 4
SWEP.SprintBobScale			= 0
SWEP.SprintAnimSpeed		= 12
SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelSprintSway 	= 2
SWEP.ViewModelShift 		= true

SWEP.ReloadTime 			= 2
SWEP.ReloadSND 				= "scifi.stinger.rearm"

SWEP.SciFiFamily			= { "vtec", "phys", "noads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 80", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		160", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Blast", color = Color( 245, 240, 80 ) },
	["4"] = { text = "Clip size: 					32", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 2.8 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Projectiles stick to enemies or objects.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Projectiles are extremely sensitive to incoming damage...", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Alt. damage: 		60", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Alt-fire homes on targets.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 80,
		DamageBlastRadius = 160,
		DamageType = DMG_BLAST,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.2 }, 
		},
		ChargeRate = nil
	},
	Secondary = {
		DamageComposition = "80 * 3",
		DamageAmount = 240,
		DamageBlastRadius = 160,
		DamageType = DMG_BLAST,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.6 }, 
		},
	},
	CoreRechargeRate = nil,
	ClipSize = 12,
	ReloadSpeed = 1,
	Recoil = 2,
	PerkSet = { SCIFI_PERK_AMMO_EXPLOSIVE, SCIFI_PERK_AMMO_STICKYGRENADES, SCIFI_PERK_TARGETING_SMART }
}

SWEP.PrintName				= "'Stinger' launcher"
SWEP.Slot					= 4
SWEP.SlotPos				= 4
SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 15.1), angle = Angle(180, 155, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "Base", rel = "parent", pos = Vector(0, -3.432, 9.699), angle = Angle(-7.223, -90, 180), size = Vector(0.035, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 16), angle = Angle(180, 0, 0), size = Vector(0.0361, 0.0361, 0.3437), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "Base", rel = "parent", pos = Vector(6.314, 1.769, 9), angle = Angle(-7.223, 180, 180), size = Vector(0.035, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/stalkerpod_lid.mdl", bone = "Base", rel = "parent", pos = Vector(0.16, 1.082, -2.198), angle = Angle(-95, 90, 0), size = Vector(0.773, 0.828, 0.592), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/stinger/stinger_body", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 16), angle = Angle(180, 0, 0), size = Vector(0.0861, 0.0861, 0.1437), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 15), angle = Angle(180, 30, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 15), angle = Angle(0, 0, 0), size = Vector(0.495, 0.495, 0.495), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/stinger/stinger_core", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 15), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/stinger/stinger_core_warp", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, -1.5, -7), angle = Angle(-20, -80, -95), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 15.1), angle = Angle(180, 155, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "Base", rel = "parent", pos = Vector(0, -3.432, 9.699), angle = Angle(-7.223, -90, 180), size = Vector(0.035, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 16), angle = Angle(180, 0, 0), size = Vector(0.0361, 0.0361, 0.3437), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "Base", rel = "parent", pos = Vector(6.314, 1.769, 9), angle = Angle(-7.223, 180, 180), size = Vector(0.035, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/stalkerpod_lid.mdl", bone = "Base", rel = "parent", pos = Vector(0.16, 1.082, -2.198), angle = Angle(-95, 90, 0), size = Vector(0.773, 0.828, 0.592), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/stinger/stinger_body", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 16), angle = Angle(180, 0, 0), size = Vector(0.0861, 0.0861, 0.1437), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/pulsar/barrel_case", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mortar01b.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 15), angle = Angle(180, 30, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 15), angle = Angle(0, 0, 0), size = Vector(0.495, 0.495, 0.495), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/stinger/stinger_core", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dav0r/hoverball.mdl", bone = "Base", rel = "parent", pos = Vector(0.72, 2.5, 15), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/stinger/stinger_core_warp", skin = 0, bodygroup = {} }
}

local ShootSound = Sound( "scifi.stinger.fire" )

local amp = GetConVarNumber( "sfw_damageamp" )
local pfx = GetConVarNumber( "sfw_fx_particles" )

function SWEP:Think()
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then
		self.VElements[ "3" ].angle = self.VElements[ "3" ].angle + Angle( 0, 2, 0 )
		self.VElements[ "5" ].angle = self.VElements[ "5" ].angle + Angle( 1, 10, 1 )
	end
	
	self.VElements[ "5" ].angle = self.VElements[ "5" ].angle + Angle( 1, 0.25, 0.5 )
	self.VElements[ "5+" ].angle = self.VElements[ "5+" ].angle + Angle( -1, -1, -1 )
	self.VElements[ "5" ].size = Vector(0.295, 0.295, 0.295) + Vector( 0.025, 0.025, 0.025 ) * self.Weapon:Clip1()
	self.VElements[ "5+" ].size = Vector(0.31, 0.31, 0.31) + Vector( 0.025, 0.025, 0.025 ) * self.Weapon:Clip1()
	
	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		
		if ( dlight ) then
			dlight.pos = self:GetProjectileSpawnPos() + self.Owner:EyeAngles():Forward() * 56
			dlight.r = 190
			dlight.g = 215
			dlight.b = 255
			dlight.brightness = 1
			dlight.Decay = 2048
			dlight.Size = 22 * self.Weapon:Clip1()
			dlight.Style = 1
			dlight.DieTime = CurTime() + 1
			dlight.noworld = false
			dlight.nomodel = false
		end
	end
	
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsPlayer() && self.Owner:KeyDown( IN_USE ) ) then
		if ( SERVER ) then
			local mystings = {}
		
			for k,v in pairs( ents.FindByClass( "sting_pfire" ) ) do
				if ( v:GetOwner() == self.Owner ) then
					table.insert( mystings, v )
				end
			end
			
			for k,w in pairs( ents.FindByClass( "sting_sfire" ) ) do
				if ( w:GetOwner() == self.Owner ) then
					table.insert( mystings, w )
				end
			end
		
			for k,x in pairs( mystings ) do
				x:Remove()
			end
		end
	else
		if (  !self:CanPrimaryAttack( 0 ) ) then return end
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:SetNextSecondaryFire( CurTime() + 0.2 )
		
		local amp = GetConVarNumber( "sfw_damageamp" )
		local viewmodel = self:GetViewModelEnt()
		
		if ( SERVER ) then
		
		local ent = ents.Create( "sting_pfire" )
		if ( !IsValid( ent ) ) then return end	
		ent:SetPos( self:GetProjectileSpawnPos(true) )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()

		local phys = ent:GetPhysicsObject()
		if (  !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 2800 )
		
		end

		self:DoMuzzleEffect()
			
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.8, -2 ), math.random( 0, 0.15 ), math.random( 0, 0.15 ) ) )
		end
		
		self:EmitSound( ShootSound )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:TakePrimaryAmmo( 1 )
	end
	
end

function SWEP:EmitSecfireSting()

	if ( SERVER ) then
	
	local ent = ents.Create( "sting_sfire" )
	if ( !IsValid( ent ) ) then return end	
	ent:SetPos( self:GetProjectileSpawnPos() )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:SetOwner( self.Owner )
	ent:SetNWBool( "HomingEnabled", true )
	ent:Spawn()
	ent:Activate()

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	phys:ApplyForceCenter( self.Owner:GetAimVector() * 512 + ( self:GetProjectileSpreadVector() * 18 ) )
	
	end

end

function SWEP:SecondaryAttack()

	if (  !self:CanPrimaryAttack( 2 ) ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.6 )
	self:SetNextSecondaryFire( CurTime() + 0.6 )
	
	local amp = GetConVarNumber( "sfw_damageamp" )
	local viewmodel = self:GetViewModelEnt()
	
	self:EmitSecfireSting()
		self:EmitSecfireSting()
			self:EmitSecfireSting()

	self:DoMuzzleEffect()
	
	if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) then
		ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	end
		
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.8, -2 ), math.random( 0, 0.15 ), math.random( 0, 0.15 ) ) )
	end
	
	self:EmitSound( ShootSound )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:TakePrimaryAmmo( 3 )
	
end