AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Deliver destruction with this fast-acting, auto-targeting rocket launcher."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 to aim down sights. Does NOT reload automatically. Missiles will detect targets, if you aim close to them.\n Missiles will go to 'rest'-mode, if you loose a formally locked target."
SWEP.ItemRank 				= 23

SWEP.ViewModel				= "models/weapons/c_rpg.mdl"
SWEP.WorldModel				= "models/weapons/w_rocket_launcher.mdl"
SWEP.HoldType 				= "rpg"
SWEP.DeploySpeed 			= 2.2
SWEP.SciFiSkin				= "models/weapons/meteor/skin"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "RPG_ROUND"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_custom.vmt" )
end

SWEP.PrintName				= "VK220 'Meteor' Rocket Launcher."
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.AdsPos 				= Vector(-9.8, 1, 1.8)
SWEP.AdsAng 				= Vector(0, 0, 0)

SWEP.ViewModelSprintPos		= Vector( -2, 0, 6 )
SWEP.ViewModelSprintAng		= Angle( -30, 0, 0 )
SWEP.ViewModelMeleePos		= Vector( -2, 2, 4 )
SWEP.ViewModelMeleeAng		= Angle( -8, 2, -2 )

SWEP.SciFiMeleeASpeed		= 0.9
SWEP.SciFiMeleeRange		= 64
SWEP.SciFiMeleeDamage		= 12
SWEP.SciFiMeleeSound		= "scifi.melee.swing.heavy"
SWEP.SprintAnimIdle			= false

SWEP.ReloadTime 			= 1.6
SWEP.ReloadSND 				= "Weapon_Shotgun.Special1"

SWEP.ProjectileOffset 		= Vector( 3, -1 )

SWEP.SciFiFamily			= { "base", "phys", "ads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 160, +160, +8", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		256; 256; 512", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Blast, Impact", color = Color( 245, 240, 80 ) },
	["4"] = { text = "Clip size: 					1", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Homes after targets.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "160, 160, +10",
		DamageAmount = 330,
		DamageBlastRadius = 350,
		DamageType = DMG_BLAST,
	},
	ClipSize = 1,
	ReloadSpeed = 0.5,
	PerkSet = { SCIFI_PERK_AMMO_EXPLOSIVE, SCIFI_PERK_TARGETING_SMART }
}

SWEP.VElements = {
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinebutton.mdl", bone = "base", rel = "", pos = Vector(-34.524, -8.235, -17.647), angle = Angle(180, 45, 90), size = Vector(0.212, 0.212, 0.212), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1-1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "base", rel = "", pos = Vector(-27.458, -5.935, -30.344), angle = Angle(90, -52.598, 2.711), size = Vector(0.061, 0.05, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1-1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "base", rel = "", pos = Vector(-27.458, -6.316, -13.855), angle = Angle(-90, 135.514, 3.506), size = Vector(0.026, 0.061, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_wasteland/laundry_washer003.mdl", bone = "base", rel = "", pos = Vector(-29.994, -10.273, -30.469), angle = Angle(-90, -6.169, -142.385), size = Vector(0.212, 0.212, 0.212), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2-1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket02a.mdl", bone = "base", rel = "", pos = Vector(5.45, 3, 18), angle = Angle(0, -20, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2-2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_window001.mdl", bone = "base", rel = "", pos = Vector(3.5, -0.5, 16), angle = Angle(-80, 180, 180), size = Vector(0.05, 0.05, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, smaterial0 = "models/weapons/meteor/sight", smaterial1 = "models/weapons/meteor/sight_glass", skin = 0, bodygroup = {} },
	["2-1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket02b.mdl", bone = "base", rel = "", pos = Vector(5.45, -3.6, 18.2), angle = Angle(0, 20, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["holo_1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "base", rel = "", pos = Vector(6.511, -0.5, 16), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_circle", skin = 0, bodygroup = {} },
	["holo_2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "base", rel = "", pos = Vector(6.511, -0.5, 17), angle = Angle(0, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_circle", skin = 0, bodygroup = {} },
	["holo_3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/plates/plate1x1.mdl", bone = "base", rel = "", pos = Vector(6.511, -0.5, 15), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/hwave/holo_point", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinebutton.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, -10), angle = Angle(0, 0, 0), size = Vector(0.212, 0.212, 0.212), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2-1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket02b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 0, -10), angle = Angle(0, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1-1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 0, -10), angle = Angle(0, 0, 0), size = Vector(0.061, 0.05, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2-1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_barricade_bracket02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15, 0, -10), angle = Angle(0, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1-1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20, 0, -10), angle = Angle(0, 0, 0), size = Vector(0.026, 0.061, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_wasteland/laundry_washer003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(25, 0, -10), angle = Angle(0, 0, 0), size = Vector(0.212, 0.212, 0.212), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- Colors for holographic sight --
local color_visor_default = Color( 255, 255, 255, 255 ) 	-- default white
local color_visor_warning = Color( 255, 45, 15, 255 ) 		-- saturated red
local color_visor_error =  Color( 255, 10, 30, 255 )		-- decent yellow

function SWEP:Equip()

	if ( self.Owner:IsNPC() ) or ( self.Primary.Ammo == "SciFiAmmo" ) then return end

	self.Owner:GiveAmmo( 32, self.Primary.Ammo )

end

function SWEP:Think()

	if ( self.Owner:IsPlayer() ) then
		local tr = util.TraceHull( {
			start = self.Owner:GetEyeTrace().StartPos,
			endpos = self.Owner:GetEyeTrace().HitPos,
			filter = function( ent ) if ( IsValid( ent ) && ( ent:IsNPC() || ( ent:IsPlayer() && ent ~= self.Owner ) ) ) then return true end end,
			mins = Vector( -90, -90, -90 ),
			maxs = Vector( 90, 90, 90 ),
			mask = MASK_SHOT_HULL,
			ignoreworld = true
		} )
		
		if ( tr.Entity:IsPlayer() || tr.Entity:IsNPC() ) then
			self.VElements[ "holo_2" ].size = Vector(0.03, 0.03, 0.03)
			self.VElements[ "holo_2" ].color = color_visor_error
		else
			self.VElements[ "holo_2" ].size = Vector(0.05, 0.05, 0.05)
			self.VElements[ "holo_2" ].color = color_visor_default
		end
	end

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:HwaveFire()

--	self.Owner:LagCompensation( true )

	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
		local ent = ents.Create( "mtm_missile" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		if ( self:GetNWBool( "BurstMode" ) == true ) then
			phys:ApplyForceCenter( self.Owner:GetAimVector() * 34000 + ( Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -5, 5 ) ) * 500 ) )
		else
			phys:ApplyForceCenter( self.Owner:GetAimVector() * 34000 )
		end
	end
	
--	self:EmitSound( "NPC_Hunter.FlechetteShoot" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
	
--	self.Owner:LagCompensation( false )

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.5 )

	local pOwnerAV = self.Owner:GetAimVector()

	if ( SERVER ) then
		local ent = ents.Create( "mtm_missile" )
		if ( !IsValid( ent ) ) then return end
		if ( self:GetSciFiState() == SCIFI_STATE_ADS ) then
			ent:SetPos( self.Owner:GetShootPos() + ( pOwnerAV * 20 ) )
		else
			ent:SetPos( self:GetProjectileSpawnPos() )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * 48000 )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.6, -2 ), math.random( -0.01, -0.1 ), math.random( -0.01, -0.1 ) ) )
		
		self:AddSciFiACC( 2.4 )
	end
		
	self:EmitSound( "scifi.hfire.fire1" )
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			
	self:TakePrimaryAmmo( 1 )
--	self:AutoReload()
	
end

function SWEP:SecondaryAttack()
	
end