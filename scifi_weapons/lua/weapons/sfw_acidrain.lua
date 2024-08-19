AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.NpcSpawnFlags 			= {}

SWEP.Purpose				= "The TCTG grenade launcher fires three toxic projectiles which will create corrosive gas clouds upon hit. Its secondary fire features a chemical grenade that spawns child grenades upon hitting a surface."
SWEP.Instructions			= "Mouse1 / Mouse2 to fire. (Note: Secondary fire requires EP2 to work properly.)"
SWEP.ItemRank 				= 18

SWEP.ViewModel				= "models/weapons/c_scifisg.mdl"
SWEP.WorldModel				= "models/weapons/w_shotgun.mdl"
SWEP.HoldType 				= "shotgun"
SWEP.SciFiSkin				= ""

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_arain.vmt" )
end

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "grenade"

SWEP.VfxMuzzleParticle 		= "corro_muzzle"
SWEP.VfxMuzzleRule 			= 0

SWEP.ReloadTime				= 1.1

SWEP.PrintName				= "TCTG 'AcidRain' launcher"
SWEP.Slot					= 4
SWEP.SlotPos				= 4

SWEP.SciFiFamily			= { "elemental", "phys_legacy", "noads", "autoreload" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 1 - 3 for 3.5 seconds", color = Color( 180, 180, 180 ) },
	["2"] = { text = "AOE Range:		200", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: Toxin", color = Color( 180, 255, 110 ) },
	["7"] = { text = "Alt. damage: 	 10 - 20.", color = Color( 180, 180, 180 ) },
	["9a"] = { text = "Alt. damage-type: Corrosive", color = Color( 180, 255, 80 ) },
	["8"] = { text = "Alt. range: 			128 units", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Alt-fire is guaranteed to corrode targets.", color = Color( 180, 180, 180 ) },
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "3 over 4 seconds",
		DamageAmount = 3,
		DamageBlastRadius = 200,
		DamageType = DMG_POISON,
		StatusChance = 10,
	},
	Secondary = {
		DamageComposition = "60 * 8",
		DamageAmount = 480,
		DamageBlastRadius = 100,
		DamageType = DMG_SF_CORROSIVE,
		StatusChance = 100,
	},
	ReloadSpeed = 1.1,
	Recoil = 4,
	PerkSet = { SCIFI_PERK_ELEMENTAL_CORROSIVE, SCIFI_PERK_AMMO_TOXIC }
}

SWEP.ViewModelMeleePos		= Vector( 24, 8, -8 )
SWEP.ViewModelMeleeAng		= Angle( -5, 70, -80 )

local ShootSound = Sound( "weapons/corro/fire.wav" )
local XplodeSound = Sound( "weapons/corro/burst.wav" )
local amp = GetConVarNumber( "sfw_damageamp" )

SWEP.VElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(-0.51, 0.2, 2), angle = Angle(-180, 90, 0), size = Vector(0.2, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/arain/engine", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/light_decklight01_off.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(0, -1.31, -4), angle = Angle(0, -90, -90), size = Vector(0.23, 0.32, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/arain/body_case", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_trainstation/trashcan_indoor001b.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(-0.2, 0.12, 12), angle = Angle(0, 0, -180), size = Vector(0.182, 0.182, 0.325), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/arain/barrel", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/plazafallingmonitor.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(-0.229, 4.623, 4.179), angle = Angle(-32.663, 51, -26.696), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_citizen_tech/steamengine001a.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(-0.879, 0.043, 12), angle = Angle(90, 0, -90), size = Vector(0.05, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(17, 1.8, -6), angle = Angle(90, 90, 90), size = Vector(0.2, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/arain/engine", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/light_decklight01_off.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 1.2, -6), angle = Angle(90, 90, 0), size = Vector(0.23, 0.32, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/arain/body_case", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_trainstation/trashcan_indoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(26, 0.8, -6.25), angle = Angle(85, 0, 0), size = Vector(0.162, 0.162, 0.225), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/arain/barrel", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/plazafallingmonitor.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 0.975, -1.051), angle = Angle(-17.251, 153.126, -8.652), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_citizen_tech/steamengine001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(26.386, 0.107, -6.099), angle = Angle(-7.269, 1.333, 180), size = Vector(0.05, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:Equip()

	if ( self.Owner:IsNPC() ) or ( self.Primary.Ammo == "SciFiAmmo" ) then return end

	self.Owner:GiveAmmo( 32, self.Primary.Ammo )

end

function SWEP:SubInit()

	acidrain_firemode = 0

end

function SWEP:Think()

	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:CorroSpit( dmg, decay, acc, amp )
	
	local amp = GetConVarNumber( "sfw_damageamp" )

	self:EmitSound( ShootSound )
	
	if ( SERVER ) then
	
	local ent = ents.Create( "prop_physics" )
	if (  !IsValid( ent ) ) then return end
	ent:SetModel( "models/grub_nugget_large.mdl" )
	ent:SetMaterial( "models/spitball/spitball" )
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
	ent:SetAngles( self.Owner:EyeAngles() * 10 )
	--if ( acidrain_firemode == 1 ) then
	--	ent:SetModelScale( 5, 0 )
	--end
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	
	phys:ApplyForceCenter( self.Owner:GetAimVector() * 12800 + VectorRand() * acc )
	phys:SetMass( 3 )
	
	local fx = ents.Create( "light_dynamic" )
	if ( !IsValid( fx ) ) then return end
	fx:SetKeyValue( "_light", "105 211 41 255" )
	fx:SetKeyValue( "spotlight_radius", 60 )
	fx:SetKeyValue( "distance", 80 )
	fx:SetKeyValue( "brightness", 1 )
	fx:SetPos( ent:GetPos() )
	fx:SetParent( ent )
	fx:Spawn()
	
	ParticleEffectAttach( "corro_blob", 1, ent, 1 )
	
	ent:AddCallback( "PhysicsCollide", function( boom ) 
	
		if ( !IsValid( self ) ) or ( !IsValid( self.Owner ) ) then return end
		
		local pos = ent:GetPos()
		
		self:DealAoeDamage( bit.bor( DMG_ACID, DMG_POISON ), dmg * amp, pos, 100 )
		
		if ( acidrain_firemode == 0 ) then
		self:AcidGas( ent )
		elseif ( acidrain_firemode == 1 ) then
		ParticleEffect( "eml_generic_crsv", pos, Angle( 0, 0, 0 ), self.Owner )	
		
		local trData = { start = pos + Vector( 0, 0, 64 ), endpos = pos - Vector( 0, 0, 64 ), filter = ent, ignoreworld = false }
		local tr = util.TraceEntity( trData, ent )
				
		ParticleEffect( "eml_generic_crsv_splat", tr.HitPos, Angle( 0, 0, 0 ) )
		
		self:AcidSpit( pos )
			self:AcidSpit( pos )
				self:AcidSpit( pos )
					self:AcidSpit( pos )
		end
		
		ent:EmitSound( XplodeSound )
		ent:Fire( "break", "", 0.01 ) 

		if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then	
		
		local fx2 = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx2:SetKeyValue( "_light", "105 255 70 255" )
		fx2:SetKeyValue( "spotlight_radius", 200 )
		fx2:SetKeyValue( "distance", 250 )
		fx2:SetKeyValue( "brightness", 3 )
		fx2:SetPos( ent:GetPos() )
		--fx2:SetParent( ent )
		fx2:Spawn()
		fx2:Fire( "kill", "", 0.115 )
		
		
		end
	
	end )
	
	ent:SetPhysicsAttacker( self.Owner, decay )
	SafeRemoveEntityDelayed( ent, decay )
	SafeRemoveEntityDelayed( fx, decay )
	
	end

end

function SWEP:AcidSpit( pos )

	self:DealAoeDamage( bit.bor( DMG_RADIATION, DMG_POISON ), 10 * amp, pos, 128 )

	for k, v in pairs( ents.FindInSphere( pos, 128 ) ) do
		DoElementalEffect( { Element = EML_CORROSIVE, Target = v, Attacker = self.Owner, Inflictor = self } )
	end
	
	local spit = ents.Create( "grenade_spit" )
	spit:SetPos( pos )
	spit:SetKeyValue( "damage", 20 )
	spit:Spawn()
	spit:SetVelocity( Vector( math.random( -200, 200 ), math.random( -200, 200 ), math.random( 50, 70 ) ) * math.random( 3, 4 ) )
	spit:Spawn()
	
end

function SWEP:AcidGas( parent )
	
	self:DealAoeDamageOverTime( bit.bor( DMG_RADIATION, DMG_POISON ), math.random( 1, 3 ) * amp, parent:GetPos(), 200, 3.5, 0.01, self )
	--ParticleEffect( "corro_blast", parent:GetPos(), Angle( 0, 0, 0 ), self.Owner )
	ParticleEffect( "gas", parent:GetPos(), Angle( 0, 0, 0 ), self )
	
end

function SWEP:PrimaryAttack()

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
--	self:SetNextPrimaryFire( CurTime() + 0.2 )
	
	if ( self.Owner:IsPlayer() ) then
	self.Owner:ViewPunch( Angle( -0.5, 0, 0 ) )
	end
	
	self:EmitSound( ShootSound )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	self:DoMuzzleEffect()
	
	acidrain_firemode = 0
	self:CorroSpit( 5, 10, 1 )
		self:CorroSpit( 5, 10, 256 )
			self:CorroSpit( 5, 10, 512 )
			
	self:TakePrimaryAmmo( 1 )
	self:Reload()
	
end

function SWEP:SecondaryAttack()

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
--	self:SetNextSecondaryFire( CurTime() + 0.2 )
	
	self:DoMuzzleEffect()
	
	self:EmitSound( ShootSound )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	acidrain_firemode = 1
	self:CorroSpit( 10, 10, 1 )
	
	self:TakePrimaryAmmo( 1 )
	self:Reload()
	
end

function SWEP:CanPrimaryAttack( cap, canunderwater )

	--if ( CLIENT ) then return end

	if ( self.Weapon:Clip1() <= cap ) then
		self:EmitSound( "Weapon_Pistol.Empty" )
		self:Reload()
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		if ( canunderwater == true ) then
			return true
		end
		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end
	
	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
		return false
	end
	
	if ( self.SciFiState == SCIFI_STATE_SPRINT ) and ( GetConVarNumber( "sfw_allow_advanims" ) >= 1 ) then
		return false
	end

	return true
	
end

function SWEP:Reload()

	if ( CLIENT ) then return end
	
	if ( !self:CanReload() ) then return end

	self:EmitSound( self.ReloadSND )
	
	-- dat lazy animation schedule --
	timer.Simple( 0.2, function() 
		if ( !IsValid( self ) ) then return end
		self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
		self:EmitSound( "Weapon_Shotgun.Special1" )
	end )
	
	timer.Simple( 0.6, function()
		if ( !IsValid( self ) ) then return end
		self:SendWeaponAnim( ACT_VM_RELOAD )
		self:EmitSound( "Weapon_Shotgun.Reload" )
		if ( self.Owner:IsPlayer() ) then
			self.SciFiState = SCIFI_STATE_RELOADING
			self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo )
			self.SciFiState = false
		end
	end )

	timer.Simple( 0.9, function()
		if ( !IsValid( self ) ) then return end
		self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
	end )
	
	self:SetNextPrimaryFire( CurTime() + self.ReloadTime )
	self:SetNextSecondaryFire( CurTime() + self.ReloadTime )
	
	if ( self.Owner:IsNPC() ) then
		self.Weapon:SetClip1( self.Primary.ClipSize )
	end
	
end