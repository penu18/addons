AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Turn your foes into ashes..."
SWEP.Instructions			= "Mouse1 to fire. Mouse2 to zoom. Kick some ass."
SWEP.ItemRank 				= 25

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "ar2"
SWEP.DeploySpeed 			= 3
SWEP.SciFiSkin				= "/models/weapons/nio/skin.vmt"
SWEP.SciFiSkin_1			= "/models/weapons/nio/vapor_core.vmt"
SWEP.SciFiWorld				= "/models/weapons/shared/ar2_edit.vmt"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_nio.vmt" )
end

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2AltFire" -- "AR2"

SWEP.VfxMuzzleParticle 		= "nio_charge"
SWEP.VfxMuzzleRule 			= 0
SWEP.VfxMuzzleColor 		= Color( 145, 255, 60, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 120
SWEP.VfxMuzzleFarZ 			= 720

SWEP.PrintName				= "MTM 'Neutrino' Cannon"
SWEP.Slot					= 4
SWEP.SlotPos				= 2

SWEP.SciFiFamily			= { "autocharge", "hitscanbullets", "ads", "useshook" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 250 + 250", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				--", color = Color( 180, 180, 180 ) },
	["1b"] = { text = "AOE Range:			100", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Radiation", color = Color( 20, 255, 180 ) },
	["4"] = { text = "Clip size: 				  6", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				 0.8 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Shots can dissolve enemies.", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Radiation damage bypasses shields.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Ineffective vs. armor.", color = Color( 180, 180, 180 ) },
	["9"] = { text = "Has to charge up before the actual shot.", color = Color( 180, 180, 180 ) },
	["9a"] = { text = "Get rekt.", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "250, 250",
		DamageAmount = 500,
		DamageBlastRadius = 100,
		DamageType = DMG_RADIATION,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 1.2 }, 
		},
	},
	ClipSize = 6,
	ReloadSpeed = 2,
	Recoil = 8,
	PerkSet = { SCIFI_PERK_AMMO_RADIATION, SCIFI_PERK_DISSOLVE_LIGHT }
}

SWEP.AdsPos 				= Vector( -5.98, 6.1, 1 )
SWEP.AdsAng 				= Angle( 0, 0, 0 )
SWEP.AdsFov					= 37.5

SWEP.ViewModelSprintPos		= Vector( 5, 1, 1 )
SWEP.ViewModelSprintAng		= Angle( -15, 35, -5 )
SWEP.ViewModelShiftOffset 	= Vector( -0.01, 0.06, -0.15 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )

SWEP.VElements = {
	["3++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/tprotato1.mdl", bone = "Base", rel = "", pos = Vector(0.805, 1.55, 28.044), angle = Angle(-5.825, -55.533, 0), size = Vector(0.054, 0.029, 0.135), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_3", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mine01.mdl", bone = "Shell1", rel = "", pos = Vector(0, 0, -1.257), angle = Angle(0, 0, 180), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "Base", rel = "", pos = Vector(3.543, 2.5, 13.859), angle = Angle(180, 90, -88.236), size = Vector(0.878, 0.878, 0.578), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_5", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mine01.mdl", bone = "Shell2", rel = "", pos = Vector(0, 0, -0.539), angle = Angle(0, 0, 180), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/tprotato1.mdl", bone = "Base", rel = "", pos = Vector(0, -1.32, 28.044), angle = Angle(-5.825, 90, 0), size = Vector(0.054, 0.029, 0.135), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_3", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "Bolt2", rel = "", pos = Vector(-0.405, -0.019, 0), angle = Angle(180, 23.385, 0), size = Vector(0.082, 0.082, 0.082), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_2", skin = 0, bodygroup = {} },
	["3+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/tprotato1.mdl", bone = "Base", rel = "", pos = Vector(-0.806, 1.55, 28.044), angle = Angle(-5.825, -141.676, 0), size = Vector(0.054, 0.029, 0.135), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_3", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_emitter01.mdl", bone = "Base", rel = "", pos = Vector(-0.151, 0, 8.522), angle = Angle(90, -90, 0), size = Vector(0.342, 0.384, 0.138), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_4", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_dispenser.mdl", bone = "Base", rel = "", pos = Vector(0.389, -0.251, 3.451), angle = Angle(0, 0, 180), size = Vector(0.089, 0.054, 0.089), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_0", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/c_sfmp.mdl", bone = "Base", rel = "", pos = Vector(6.438, -4.218, -12.362), angle = Angle(90, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", submat = { [0] = "vgui/white", [1] = "vgui/white", [2] = "models/weapons/nio/element_6" }, skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "Base", rel = "", pos = Vector(0, 2.5, 24), angle = Angle(0, 0, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_0", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 85, 255, 0, 220 ), bone = "Base", pos = Vector( 0, 3.2, 16 ), angle = Angle( 90, 0, 0 ), range = 8192, line_size = 0.15, haze_size = 0.15, dot_size = 1 }
}

SWEP.WElements = {
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(24.4, 1.6, -8.4), angle =  Angle(40, -94, -100), size = Vector(0.044, 0.019, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_3", skin = 0, bodygroup = {} },
	["3+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(24.4, -1.2, -8.4), angle = Angle(30, 94, 100), size = Vector(0.044, 0.019, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_3", skin = 0, bodygroup = {} },
	["3++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(24, 0.4, -11.2), angle = Angle(-112, -1, 1), size = Vector(0.044, 0.019, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_3", skin = 0, bodygroup = {} },
--	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, -1.257), angle = Angle(0, 0, 180), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, -0.539), angle = Angle(0, 0, 180), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18, 3, -4), angle = Angle(77, 0, -90), size = Vector(0.878, 0.878, 0.578), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_5", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 2, -6), angle = Angle(100, 120, 60), size = Vector(0.082, 0.082, 0.082), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_2", skin = 0, bodygroup = {} },
--	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.151, 0, 8.522), angle = Angle(90, -90, 0), size = Vector(0.342, 0.384, 0.138), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_4", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_dispenser.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 1, -4.5), angle = Angle(0, -100, -100), size = Vector(0.089, 0.054, 0.089), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_0", skin = 0, bodygroup = {} },
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 85, 255, 0, 220 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector( 20, 1, -6 ), angle = Angle( -14, 0, 0 ), range = 8192, line_size = 0.2, haze_size = 0.2, dot_size = 2 }
--	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/c_sfmp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.438, -4.218, -12.362), angle = Angle(90, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", smaterial1 = "vgui/white", smaterial2 = "vgui/white", smaterial3 = "models/weapons/nio/element_6", skin = 0, bodygroup = {} },
--	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 2.5, 24), angle = Angle(0, 0, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/nio/element_0", skin = 0, bodygroup = {} }
}

function SWEP:EpicImpact()

	local amp = GetConVar( "sfw_damageamp" ):GetFloat()

	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( 0, 0 )
	bullet.Tracer = 1
	bullet.Force = 0
	bullet.HullSize = 16
	bullet.Damage = 250 * amp
	bullet.AmmoType = "CombineCannon"
	bullet.TracerName = "nio_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_RADIATION, DMG_AIRBOAT, DMG_NEVERGIB ) )
		dmginfo:SetInflictor( self )
		
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( dmginfo:GetDamage() / 2 )
		end

		ParticleEffect( "nio_impact", tr.HitPos, self.Owner:EyeAngles() )
		
		DoElementalEffect( { Element = EML_DISSOLVE_NEUTRINO, Attacker = self.Owner, Target = tr.Entity, Origin = tr.HitPos, Range = 32 } ) 
		DoElementalEffect( { Element = EML_DISSOLVE_NEUTRINO, Attacker = self.Owner, Origin = tr.HitPos, Range = 32 } ) 

		local tarpos = tr.HitPos
		self:DealAoeDamage( bit.bor( DMG_RADIATION, DMG_AIRBOAT, DMG_NEVERGIB ), 250 * amp, tarpos, 100, 0 )
	end

	self:FireBullets( bullet, false )

end

function SWEP:PrimaryAttack()

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
	self:SetNextPrimaryFire( CurTime() + 1.2 )
	
	local viewmodel = self:GetViewModelEnt()
	
	if ( self.Owner:IsPlayer() ) then
		if ( GetConVarNumber( "sfw_fx_suppressonzoom" ) >= 1 ) then
			if (self.SciFiState ~= SCIFI_STATE_ADS ) then
				self:DoMuzzleEffect()
			end
		else
			self:DoMuzzleEffect()
		end
		
		if ( SERVER ) then
			local fx2 = ents.Create( "light_dynamic" )
			if ( !IsValid( fx2 ) ) then return end
			fx2:SetKeyValue( "_light", "85 255 0 255" )
			fx2:SetKeyValue( "spotlight_radius", 32 )
			fx2:SetKeyValue( "distance", 64 )
			fx2:SetKeyValue( "brightness", 0.5 )
			fx2:SetKeyValue( "style", 1 )
			fx2:SetPos( viewmodel:GetAttachment( viewmodel:LookupAttachment( "Muzzle" ) ).Pos )
			fx2:SetParent( self.Owner )
			fx2:Spawn()
			fx2:Fire( "Kill", "", 0.7 )
		end
		
		self:SendWeaponAnim( ACT_VM_FIDGET )
		
		self:EmitSound( "scifi.neutrino.charge" )
		
		timer.Create( "awesomechargefx" .. self:EntIndex(), 0.7, 1, function()
			if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end

			self:EmitSound( "scifi.neutrino.fire" )

			self:TakePrimaryAmmo( 1 )
			
			ParticleEffectAttach( "nio_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
			self:DrawMuzzleLight( "80 255 40 255 ", 130, 720, 0.06 )
			
			if ( self.Owner:IsPlayer() ) then
				self.Owner:ViewPunch( Angle( math.random( -2.8, -3 ), math.random( -0.15, 0.15 ), math.random( -0.15, 0.15 ) ) )
			end
			
			
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )

			self:EpicImpact()
			
			self:AddSciFiACC( 8 )
			
			timer.Remove( "awesomechargefx" .. self:EntIndex() )
		end)
	end

	if ( IsValid( self.Owner ) && self.Owner:IsNPC() ) then
		ParticleEffectAttach( "nio_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EpicImpact()
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:EmitSound( "scifi.neutrino.fire" )
	end
	
end

function SWEP:NPCShoot_Primary( ShootPos, ShootDir )
	
	if ( !self:CanPrimaryAttack( 0 ) ) then return end
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	
	ParticleEffectAttach( "nio_charge", PATTACH_POINT_FOLLOW, self, 1 )
	self:EmitSound( "scifi.neutrino.charge" )
	
	timer.Simple( 0.7, function()
		if !( IsValid( self ) && IsValid( self.Owner ) ) then return end
		
		local entTarget = self.Owner:GetEnemy()
		
		if ( IsValid( entTarget ) && ShootDir ) then
			local HeadBone = self:GetTargetHeadBone( entTarget )
			
			local vBullsEye
			if ( HeadBone ) then
				vBullsEye = entTarget:GetBonePosition( HeadBone )
			else
				vBullsEye = entTarget:EyePos()
			end
			
			local fSkill = self.NPCSkillLevel / self.Owner:GetCurrentWeaponProficiency()
			local vSpread = Vector( 0.1, 0.1, 0.1 ) * math.random( -self.NPCAccuracy, self.NPCAccuracy ) * fSkill

			ShootDir = vBullsEye - self.Owner:GetShootPos() + vSpread
			
			if ( self.NPCLeadTarget ) then
				local vTargetVelo = entTarget:GetVelocity()
				
				ShootDir = ShootDir + ( vTargetVelo:GetNormalized() * vTargetVelo:Length() * self.NPCLeadPower )
			end
			
			self.NPCAimVectorOverride = ShootDir
		end
		
		if ( !ShootDir ) then
			local iParentBone = self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )
			ShootPos, ShootDir = self.Owner:GetBonePosition( iParentBone )
			ShootDir = ( ShootDir:Forward() + self.Owner:GetAimVector() ) * 0.5
		end
		self:EmitSound( "scifi.neutrino.fire" )

		self:TakePrimaryAmmo( 1 )
		
		ParticleEffectAttach( "nio_muzzle", PATTACH_POINT_FOLLOW, self, 1 )
		self:DrawMuzzleLight( "80 255 40 255 ", 130, 720, 0.06 )
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )

		self:EpicImpact()
		
		self:AddSciFiACC( 8 )
	end )

	self:SetNextPrimaryFire( CurTime() + 1.2 )
	self.Owner:SetSaveValue( "m_flLastAttackTime", ( CurTime() + 1.2 ) * -1 )
	self.Owner:SetSaveValue( "m_flNextAttack", 1.2 )

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	
	util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	
	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		dlight.pos = tr.HitPos 
		dlight.r = 85
		dlight.g = 255
		dlight.b = 0
		dlight.brightness = 2
		dlight.Decay = 1024
		dlight.Size = 512
		dlight.DieTime = CurTime() + 1
	
		sound.Play( "scifi.neutrino.impact", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 95, 102 ), 1.0 )
	end

end

function SWEP:SecondaryAttack()
	
end

function SWEP:CanSecondaryAttack()

end