AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "A heavy weapon firing explosive rounds. The grinder is a heavy rifle which provides high firepower and fire rate."
SWEP.Instructions			= "Mouse 1 to fire, Mouse 2 to aim down sights. Rate of fire increases over time."
SWEP.ItemRank 				= 30

-- SWEP.ViewModel				= "models/weapons/c_sfmp.mdl"
-- SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.ViewModel				= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel				= "models/weapons/w_mach_m249para.mdl"
SWEP.HoldType 				= "smg"
SWEP.DeploySpeed 			= 3
SWEP.SciFiSkin				= ""

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_grinder.vmt" )
end

SWEP.Primary.ClipSize		= 90
SWEP.Primary.DefaultClip	= 90
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.VfxMuzzleParticle 		= "ngen_muzzle_4"
SWEP.VfxMuzzleAttachment 	= "0"
SWEP.VfxMuzzleRotation 		= Angle( 90, 90, 90 )
SWEP.VfxMuzzleColor 		= Color( 255, 160, 100, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 420
SWEP.VfxHeatParticle 		= "gunsmoke"
SWEP.VfxHeatThreshold 		= 0.5

SWEP.PrintName				= "RK30-K2 'Grinder' rifle"
SWEP.Slot					= 3
SWEP.SlotPos				= 3

SWEP.SciFiFamily			= { "base", "phys_legacy", "ads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 ??", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Heavy Impact", color = Color( 185, 180, 175 ) },
	["4"] = { text = "Clip size: 				 120", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 18 (full-auto, wind-up)", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Has to warm up before unleashing the maximum fire rate.", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "10, 5",
		DamageAmount = 15,
		DamageType = { DMG_BULLET, DMG_BLAST },
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.2 }, 
		},
	},
	ClipSize = 90,
	ReloadSpeed = 2,
	Recoil = 4,
	PerkSet = { SCIFI_PERK_AMMO_EXPLOSIVE, SCIFI_PERK_CHAMBER_ESCALATINGFIRERATE }
}

SWEP.SciFiMeleeASpeed		= 0.8
SWEP.SciFiMeleeRange		= 50
SWEP.SciFiMeleeDamage		= 10
SWEP.SciFiMeleeSound		= "scifi.melee.swing.heavy"

SWEP.AdsPos 				= Vector(-6.1, -2, 2)
SWEP.AdsAng 				= Vector(0, 0, 0)
SWEP.AdsFov					= 50
SWEP.ViewModelMeleePos		= Vector( 16, 8, -8 )
SWEP.ViewModelMeleeAng		= Angle( -5, 90, -95 )

-- SWEP.VElements = {
	-- ["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.324, -0.262, -5.98), angle = Angle(-180, 90, 0), size = Vector(0.144, 0.144, 0.144), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/engine", skin = 0, bodygroup = {} },
	-- ["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/light_decklight01_off.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, -1.31, 2.477), angle = Angle(0, -90, -90), size = Vector(0.172, 0.377, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/body_case", skin = 0, bodygroup = {} },
	-- ["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_canal/generator01.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(1.478, 0.402, 2.407), angle = Angle(180, 90, 90), size = Vector(0.014, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/motor_case", skin = 0, bodygroup = {} },
	-- ["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_wasteland/gear02.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(1.039, 0.491, 3.394), angle = Angle(0, 0, 90), size = Vector(0.307, 0.307, 0.307), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	-- ["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/plazafallingmonitor.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.229, 4.623, 1.179), angle = Angle(-32.663, 51, -26.696), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	-- ["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_lever.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(1.279, 1.032, 0.55), angle = Angle(0, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	-- ["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_citizen_tech/steamengine001a.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.879, 0.043, 10.803), angle = Angle(90.299, 0, -90), size = Vector(0.0257, 0.037, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
-- }

SWEP.VElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "v_weapon.M249", rel = "", pos = Vector(-0.3, -1, 11), angle = Angle(-180, 90, 0), size = Vector(0.144, 0.144, 0.144), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/engine", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/light_decklight01_off.mdl", bone = "v_weapon.M249", rel = "", pos = Vector(0.1, -2.5, 15), angle = Angle(0, -90, -90), size = Vector(0.08, 0.4, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/body_case", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_canal/generator01.mdl", bone = "v_weapon.M249", rel = "", pos = Vector(1.478, 0.402, 7.407), angle = Angle(180, 90, 90), size = Vector(0.014, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/motor_case", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_wasteland/gear02.mdl", bone = "v_weapon.M249", rel = "", pos = Vector(1.039, 0.491, 8.2), angle = Angle(0, 0, 90), size = Vector(0.307, 0.307, 0.307), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	-- ["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/plazafallingmonitor.mdl", bone = "v_weapon.M249", rel = "", pos = Vector(-0.229, 4.623, 1.179), angle = Angle(-32.663, 51, -26.696), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_lever.mdl", bone = "v_weapon.M249", rel = "", pos = Vector(1.279, 1.032, 0.55), angle = Angle(0, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_citizen_tech/steamengine001a.mdl", bone = "v_weapon.M249", rel = "", pos = Vector(-0.879, 0.043, 10.803), angle = Angle(90.299, 0, -90), size = Vector(0.0257, 0.037, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/trappropeller_engine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1, 1, -4.8), angle = Angle(80, 0, 0), size = Vector(0.144, 0.144, 0.144), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/engine", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_c17/light_decklight01_off.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.2, 1.4, -7), angle = Angle(80, 0, 90), size = Vector(0.172, 0.377, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/body_case", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_canal/generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 3.2, -6), angle = Angle(80, 0, 90), size = Vector(0.014, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/grinder/motor_case", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_wasteland/gear02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.75, 2.75, -6.1), angle = Angle(-100, 0, 90), size = Vector(0.307, 0.307, 0.307), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/plazafallingmonitor.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.2, 1.5, -2), angle = Angle(-17.251, 153.126, -8.652), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_citizen_tech/steamengine001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 0.8, -7), angle = Angle(-10, 0, 180), size = Vector(0.0257, 0.032, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

local ShootSound = Sound( "scifi.grinder.pfire" )
local XplodeSound = Sound( "weapons/grinder/he_hit.wav" )

local amp = GetConVarNumber( "sfw_damageamp" )
local pfx = GetConVarNumber( "sfw_fx_particles" )

function SWEP:Think()

	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
	self.VElements[ "5" ].angle = self.VElements[ "5" ].angle + Angle( 0, -( self.Weapon:Clip1() / 20 ), 0 )
	self.WElements[ "5" ].angle = self.VElements[ "5" ].angle + Angle( 0, -( self.Weapon:Clip1() / 20 ), 0 )
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) == true ) and ( self.SciFiState == SCIFI_STATE_RELOADING == false ) then --and ( self:CanPrimaryAttack( 0 ) ) then
	self.VElements[ "5" ].angle = self.VElements[ "5" ].angle + Angle( 0, 1.4 + self:GetSciFiACC(), 0 )
	self.WElements[ "5" ].angle = self.VElements[ "5" ].angle + Angle( 0, 1.4 + self:GetSciFiACC(), 0 )
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:HeavyBullet( ent )

	if ( CLIENT ) then return end
	
	local ent = ents.Create( "prop_physics" )
	--if ( IsValid( ent ) ) then return end
	ent:SetModel( "models/props_bts/rocket.mdl" )
	ent:SetMaterial( "models/bullet.vmt" )
	if (self.SciFiState ~= SCIFI_STATE_ADS ) then
		ent:SetPos( self:GetProjectileSpawnPos() )
	else
		ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
	end
	ent:SetAngles( self.Owner:GetAimVector():Angle() )
	ent:Spawn()
	ent:Fire( "DisableFloating", "", 0 )
	ent:SetPhysicsAttacker( self.Owner, 10 )
	
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	phys:EnableGravity( false )
	if ( ent:WaterLevel() == 3 ) then
		phys:EnableDrag( true )
	else
		phys:EnableDrag( false )
	end
	phys:ApplyForceCenter( self.Owner:GetAimVector() * 10000000000000000 + ( VectorRand() * 3619999999 ) * ( self:GetSciFiACC() * 6000 ) )
	if ( GetConVarNumber( "sfw_sk_grinder_physdmgscale" ) == 1 ) then
		phys:SetMass( 4 )
	elseif ( GetConVarNumber( "sfw_sk_grinder_physdmgscale" ) == 2	) then
		phys:SetMass( 5 )
	elseif ( GetConVarNumber( "sfw_sk_grinder_physdmgscale" ) == 3 ) then
		phys:SetMass( 500 )
	elseif ( GetConVarNumber( "sfw_sk_grinder_physdmgscale" ) >= 4 ) then
		phys:SetMass( 2048 )
	end
	
	local fx = ents.Create( "light_dynamic" )
	if ( !IsValid( fx ) ) then return end
	fx:SetKeyValue( "_light", "255 128 1 130" )
	fx:SetKeyValue( "spotlight_radius", 120 )
	fx:SetKeyValue( "distance", 180 )
	fx:SetKeyValue( "brightness", 0.3 )
	fx:SetPos( ent:GetPos() )
	fx:SetParent( ent )
	fx:Spawn()
	
	if ( GetConVarNumber( "sfw_sprites" ) == 1 ) then
		local fxf = ents.Create( "env_sprite" )
		if ( !IsValid( fxf ) ) then return end
		fxf:SetKeyValue( "model", "effects/grinderfx.vmt" )
		fxf:SetKeyValue( "renderamt", 255 )
		fxf:SetKeyValue( "Scale", 0.01 )
		fxf:SetPos( ent:GetPos() )
		fxf:SetAngles( self.Owner:EyeAngles() )
		fxf:SetParent( ent )
		fxf:Spawn()
	end

	if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
	ParticleEffectAttach( "gunsmoke", 1, ent, 1)
	end

	ent:AddCallback( "PhysicsCollide", function( boom ) 

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
	phys:EnableGravity( true )
	
	if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx ) ) then return end
	fx2:SetKeyValue( "_light", "255 126 1 130" )
	fx2:SetKeyValue( "spotlight_radius", 150 )
	fx2:SetKeyValue( "distance", 210 )
	fx2:SetKeyValue( "brightness", 1 )
	fx2:SetPos( boom:GetPos() )
	fx2:SetParent( ent )
	fx2:Spawn()
	fx2:Fire( "kill", "", 0.115 )

	ParticleEffect( "hellfire_blast_sparks", ent:GetPos(), Angle( 1, 2, 3 ), ent )
	end
	
	boom:Fire( "hurt", "", 0 )
	boom:EmitSound( XplodeSound ) 
	ent:Fire( "break", "", 1 ) end )
	
	SafeRemoveEntityDelayed( ent, 10 )
	SafeRemoveEntityDelayed( fx, 10 )
	
end

function SWEP:PrimaryAttack()

	if (  !self:CanPrimaryAttack( 0, true ) ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.2 - ( self:GetSciFiACC() * 0.0035 ) )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.6, -0.8 ), math.random( -0.3, 0.3 ), math.random( -0.3, 0.3 ) ) * ( self:GetSciFiACC() * 0.03 ) )

		self:AddSciFiACC( 6, true )
	end

	self:DoMuzzleEffect()
	
	local pOwnerAV = self.Owner:GetAimVector()
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() * 0.001 )
	bullet.Spread = Vector( .01, .01 ) * ( self:GetSciFiACC() * 0.1 )
	bullet.AmmoType = "SMG1"
	bullet.Tracer = 1
	bullet.TracerName = "moby_tracer"
	bullet.Force = 4
	bullet.HullSize = 4
	bullet.Damage = 10

	bullet.Callback = function( attacker, tr, dmginfo )
		if ( tr.HitGroup ) && ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:ScaleDamage( 0.5 )
		end
		
		dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_CLUB ) )
		
		self:DealAoeDamage( DMG_BLAST_SURFACE, bullet.Damage * 0.5, tr.HitPos, 64 )
		
		ParticleEffect( "xplo_hit_cheap", tr.HitPos, Angle(0,0,0) )
	end
	
	self.Owner:FireBullets( bullet, false )
	
	self:EmitSound( ShootSound )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	self:TakePrimaryAmmo( 1 )

end

---------------------------------------------
--##----##----#####----##----##--------------
---##--##----##---##---##----##--------------
----####----##-----##--##----##--------------
-----##------##---##---##----##--------------
-----##-------#####-----######---##--##--##--
---------------------------------------------
---...-know-what-grinds-my-gears?------------