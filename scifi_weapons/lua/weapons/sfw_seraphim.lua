AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.NpcSpawnFlags 			= {}

SWEP.Purpose				= "The HS20-40 fires an energetic blast of multiple charged plasma bolts, igniting enemies."
SWEP.Instructions			= "Mouse1 to fire. Projectiles have limited range, high chance to ignite, moderate chance to dissolve light props and ragdolls."
SWEP.ItemRank 				= 19

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "shotgun"
SWEP.DeploySpeed 			= 3.4
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_phurt.vmt" )
end

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.VfxMuzzleParticle 		= "seraph_muzzle"
SWEP.VfxMuzzleColor 		= Color( 255, 130, 100, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720

SWEP.ReloadTime				= 1.1

SWEP.PrintName				= "HS20-40 'Seraphim' shotgun"
SWEP.Slot					= 3
SWEP.SlotPos				= 3

SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.5
SWEP.SprintAnimSpeed		= 10

SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 4

SWEP.ViewModelSprintPos		= Vector( 2, 0.2, -1 )
SWEP.ViewModelSprintAng		= Angle( -8, 30, -15 )

SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( 0.045, 0.025, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.5, 1.2 )

SWEP.SciFiFamily			= { "hwave", "hitscanbullets", "ads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 8 x 6", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x2.2", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Plasma, Slash", color = Color( 255, 120, 110 ) },
	["3a"] = { text = "Status Chance: 10%", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Clip size: 				  16", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 4.2 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Shots can dissolve enemies or lighter props.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Plasma bolts have a very limited range.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Consumes two ammo per shot", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Has a chance to ignite enemies or props.", color = Color( 180, 180, 180 ) },
--	["9a"] = { text = "... Their return is to be feared ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "8 * 6",
		DamageAmount = 48,
		DamageAttackRange = 1024,
		DamageType = { DMG_SLASH, DMG_SF_HWAVE },
		CritMul = 2.5,
		StatusChance = 10,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.24 },
		},
	},
	ClipSize = 12,
	ReloadSpeed = 2.2,
	Recoil = 9,
	PerkSet = { SCIFI_PERK_ELEMENTAL_FIRE, SCIFI_PERK_DISSOLVE_LIGHT, SCIFI_PERK_AMMO_HIGHCAL }
}

SWEP.ReloadSND				= "weapons/vapor/vapor_reload.wav" --"scifi.hwave.reload" 
SWEP.AdsPos 				= Vector(-3.82, 0.2, 1.2)
SWEP.AdsFov					= 50
SWEP.ViewModelHomePos		= Vector( -1, 1.75, -0.7 )
SWEP.ViewModelMeleePos		= Vector( 14, 8, -6 )
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -90 )

SWEP.NPCAccuracy 			= 1
SWEP.NPCSkillLevel 			= 1

local snd_hit = Sound( "weapons/hwave/hwave_hit.wav" )

if ( SERVER ) then
	util.PrecacheSound( snd_hit )
end

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( -1, 1.75, -0.7 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "Base", rel = "", pos = Vector(0.709, 0.052, 7.394), angle = Angle(-78.888, -21.202, -97.026), size = Vector(1.103, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "Base", rel = "", pos = Vector(-0.09, -0.098, 11.967), angle = Angle(0, 0, 0), size = Vector(0.36, 0.36, 0.36), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/lab_flourescentlight002b.mdl", bone = "Base", rel = "", pos = Vector(0.963, 1.616, 10.572), angle = Angle(0, 0, 90), size = Vector(0.112, 0.029, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(-1, -1.75, 9), angle = Angle(0, 180, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(0.5, -1.75, 1), angle = Angle(180, 180, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt1", rel = "", pos = Vector(1.021, 1.19, 0.583), angle = Angle(0, -90, 0), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/bbolt", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "Base", rel = "", pos = Vector(-0.005, 1, 5), angle = Angle(0, 0, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "Base", rel = "", pos = Vector(0.25, 2.8, 20), angle = Angle(0, 0, 180), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "Base", rel = "", pos = Vector(0, 0.181, 18.923), angle = Angle(0, 160.024, 89.082), size = Vector(0.314, 0.314, 0.314), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/barrel", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.25, -5), angle = Angle(165, 10, 8), size = Vector(1.303, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11, 0.6, -6), angle = Angle(-105, 0, 0), size = Vector(0.46, 0.46, 0.46), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 0.8, -3.8), angle = Angle(0, -90, -103), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19, 2, -5), angle = Angle(0, -90, 75), size = Vector(0.081, 0.081, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 0.75, -6), angle = Angle(0, -90, -103), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["11+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14, -0.5, -7), angle = Angle(180, -90, 100), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["12"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14, -0.5, -8), angle = Angle(180, -90, 100), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22, 0.4, -9), angle = Angle(0, 90, 14), size = Vector(0.404, 0.454, 0.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/barrel", skin = 0, bodygroup = {} }
}

function SWEP:SeraphFire()

	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then DevMsg( "!Error; Failed to validate entity." ) return end

	local amp = GetConVarNumber( "sfw_damageamp" )
	local viewmodel = self:GetViewModelEnt()
	local muzzle = viewmodel:GetAttachment( viewmodel:LookupAttachment( "Muzzle" ) )
	
	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Num = 6
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Distance = 1024
	bullet.Spread = Vector( .095, .095, 0 )
	bullet.Tracer = 1
	bullet.Force = 1
	bullet.HullSize = 24
	bullet.Damage = 8 * amp
	bullet.TracerName = "seraph_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamageType( DMG_SF_HWAVE )
		
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( dmginfo:GetDamage() * 1.25 )
		end
		
		if ( tr.HitGroup == HITGROUP_CHEST ) || ( tr.HitGroup == HITGROUP_STOMACH ) then
			dmginfo:SetDamage( dmginfo:GetDamage() * 1.25 )
		end
		
		dmginfo:ScaleDamage( 1 - tr.Fraction )

		if ( tr.Fraction > 0.6 ) then return end
		
		local tEntity = tr.Entity

		EmitSound( snd_hit, tr.HitPos, -1, CHAN_STATIC, 1, 50, SND_NOFLAGS, math.random( 90, 100 ) )
		DoElementalEffect( { Element = EML_DISSOLVE_HWAVE, Target = tr.Entity, Attacker = self.Owner, Origin = tr.HitPos, IndexType = 0, Range = 32, Ticks = 4 } )
		
		if ( IsValid( tEntity:GetPhysicsObject() ) && tEntity:GetPhysicsObject():GetMaterial() ~= "metal" ) && ( GetRelChance( 10 ) ) then
			DoElementalEffect( { Element = EML_FIRE, Target = tEntity, Attacker = self.Owner, Duration = 1.5 } )
		end
	end

	self.Owner:FireBullets( bullet, false )

	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.25, -1.5 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( 1 + self:GetSciFiACC() * 0.1 ) )
	end
	
	self:TakePrimaryAmmo( 1 )
	
	self:AddSciFiACC( 9 )
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.hwave.fire1" )
	self:EmitSound( "scifi.seraph.fire1" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	self:SeraphFire()
	self:SetNextPrimaryFire( CurTime() + 0.24 )	
	
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	
	ParticleEffect( "seraph_hit", tr.HitPos, self.Owner:EyeAngles(), self )
	
	util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
	if ( GetConVarNumber( "sfw_fx_particles" ) >= 1 ) then 
		ParticleEffect( "gunsmoke", tr.HitPos, Angle( 0, 0, 0 ), self )
	end
	
	if ( self.Owner:IsPlayer() && CLIENT ) then
		if ( tr.MatType == MAT_GLASS ) then return end
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos 
			dlight.r = 255
			dlight.g = 130
			dlight.b = 100
			dlight.brightness = 2
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
	
	return false

end