AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "An ice smg featuring moderate damage and a main focus on crowd control by freezing enemies."
SWEP.Instructions			= "Mouse1 to fire. Bullets can freeze enemies and have a chance to deal massive damage. Mouse1 + 'Use' (e) to switch to aurora blast. Mouse2 to zoom. Mouse2 + 'Use' (e) to switch to firemodes."
SWEP.ItemRank 				= 14

SWEP.ViewModel				= "models/weapons/c_sfmp.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.HoldType 				= "smg"

SWEP.PrintName				= "T3i 'Blizzard' smg"
SWEP.Slot					= 2
SWEP.SlotPos				= 2

SWEP.DeploySpeed 			= 1.2

if ( CLIENT ) then
	SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_cryon.vmt" )
end

-- SWEP.SciFiSkin				= "vgui/white"
-- SWEP.SciFiWorld 			= "vgui/white"
-- SWEP.ViewModelFOV 			= 54

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.VfxMuzzleParticle 		= "eml_muzzle_cryo"
SWEP.VfxMuzzleColor 		= Color( 200, 220, 255, 120 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 150
SWEP.VfxMuzzleFarZ 			= 350
SWEP.VfxHeatParticle 		= "ice_crystals_3"

SWEP.ReloadTime 			= 1
SWEP.ReloadPlaybackRate 	= 1.8
SWEP.ReloadRealisticClips 	= false
SWEP.ReloadLegacy 			= false
-- SWEP.ReloadSND 				= ""
SWEP.DepletedSND			= "Weapon_AR2.Empty"

SWEP.AdsPos 				= Vector( -6.518, 0, 0.2845 )
SWEP.AdsAng 				= Vector( 0, 0, 0 )
SWEP.AdsFov					= 50
SWEP.ViewModelMeleePos		= Vector( 16, 8, -8 )
SWEP.ViewModelMeleeAng		= Angle( -5, 90, -95 )
SWEP.ViewModelSprintPos		= Vector( 5, 0.2, -1.6 )

SWEP.DefaultSwayScale		= 2.6
SWEP.DefaultBobScale		= 3

SWEP.ViewModelSprintPos 	= Vector( 4, 0, -2 ) -- Vector( 5, 1.5, 1 )
SWEP.ViewModelSprintAng		= Angle( -4, 30, -30 ) -- Angle( -17.5, 25, -15 )
SWEP.ViewModelSwayDirection = Vector( -0.75, 6, 1 ) -- Vector( -0.25, 4, 0.6 )
SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.15 )
SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelSprintSway 	= 4.25
SWEP.SprintAnimSpeed		= 10
SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.0

SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelDuckPos		= Vector( -2, -6, 3 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -10 )
SWEP.ViewModelMeleePos		= Vector( 20, 11, -4 )
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -60 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -6, 1, -16 )
SWEP.ViewModelReloadAng		= Angle( 60, -12, 14 )
SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.05
SWEP.ViewModelShiftOffset 	= Vector( -0.01, -0.02, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )
SWEP.ViewModelSafeAnim	 	= true
SWEP.ViewModelSafePos 		= Vector( 2, 0, 0 )
SWEP.ViewModelSafeAng 		= Angle( 0, 30, -40 )

SWEP.NPCAccuracy 			= 800
SWEP.NPCSkillLevel 			= 1
SWEP.NPCBulletSpread 		= 1
SWEP.NPCRestMin 			= 0.3
SWEP.NPCRestMax 			= 0.6
SWEP.NPCBurstMin 			= 1
SWEP.NPCBurstMax 			= 1
SWEP.NPCBurstDelay 			= 0.4

SWEP.FeelGoodEnabled = true
SWEP.FeelGoodRatio = 0.2

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "5 + 3",
		DamageAmount = 8, 
		DamageType = { DMG_BULLET, DMG_SF_ICE },
		CritMul = 2,
		StatusChance = 25,
		FireRate = { 
			{ RateTitle = "full-auto", RateDelay = 0.1 }, 
			{ RateTitle = "burst", RateDelay = 0.35 }
		},
		ChargeRate = nil
	},
	Secondary = {
		DamageAmount = 10,
		DamageBlastRadius = 180,
		DamageType = DMG_SF_ICE,
		CritMul = nil,
		StatusChance = 100,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 1.3 },
		},
		ChargeRate = nil
	},
	CoreRechargeRate = nil,
	ClipSize = 40,
	ReloadSpeed = 1.8,
	Recoil = 3,
	PerkSet = { SCIFI_PERK_ELEMENTAL_ICE }
}

function SWEPGetNPCRestTimes()
	return 0.01, 0.01
end

function SWEP:GetNPCBurstSettings()
	return 3, 3, 0.3
end

SWEP.VElements = {
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, -0.778, 7.48), angle = Angle(0, 0, 180), size = Vector(0.295, 0.295, 0.495), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/cryo_nade", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/tgun_attach.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.257, -0.685, -1.805), angle = Angle(90, -90, 0), size = Vector(0.856, 0.856, 0.856), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.1225, -3.55, -4), angle = Angle(0, 0, 0), size = Vector(0.003, 0.003, 0), color = Color(135, 190, 255, 200), surpresslightning = false, material = "models/spawn_effect2", skin = 0, bodygroup = {} },
	["3"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_ring01.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.1225, -3.55, -2.8), angle = Angle(0, 0, 0), size = Vector(0.0015, 0.0015, 0), color = Color(135, 190, 255, 200), surpresslightning = false, material = "models/spawn_effect2", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7, 1.2, -5.75), angle = Angle(-101, 0, 0), size = Vector(0.4, 0.4, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/cryo_nade", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/tgun_attach.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.5, -5.5), angle = Angle(-169, 180, -2), size = Vector(0.856, 0.856, 0.856), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} }
}

SWEP.DataTables = {
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Bool", dName = "CanBurst" },
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Bool", dName = "Silenced" },
	{ dType = "Int", dName = "BurstCount" },
	{ dType = "Int", dName = "PerkInterval" },
	{ dType = "Float", dName = "PerkTime" },
	{ dType = "Float", dName = "PerkDamage" }
}

function SWEP:SubInit()
	self:SetBurstMode( false )
end

function SWEP:Think()

	bBurst = self:GetBurstMode()
	
	if ( CLIENT ) then
		local bReloading = self:GetSciFiState() == SCIFI_STATE_RELOADING
		local fNextPFire = self:GetNextPrimaryFire() - CurTime()
		
		if ( bReloading ) && ( !dReloading ) then
			self.ViewModelReloadPos	= Vector( -8, 1, -12 )
			self.ViewModelReloadAng	= Angle( 45, -12, 14 )
		end
		
		if ( bReloading ) then
			local fReloadScale = math.Clamp( fNextPFire / self.ReloadTime, 0, 1 )

			if ( fReloadScale < 0.5 ) then
				fReloadScale = 1 - ( fReloadScale * 2 )
				local fReloadScaleAdaptive = math.sin( fReloadScale * 2.5 )
				
				self.ViewModelReloadAng.pitch = 45 + 5 * fReloadScale
				self.ViewModelReloadAng.yaw = -12 + 2 * fReloadScale
				self.ViewModelReloadAng.roll = 12 + 12 * fReloadScaleAdaptive
				self.ViewModelReloadPos.x = -8 - 1 * fReloadScale
				self.ViewModelReloadPos.z = -12 + 2 * fReloadScaleAdaptive
			end
		end
		
		dReloading = bReloading
	end

	if ( bBurst ) && ( SERVER || !game.SinglePlayer() ) then
		local fNextPFire = self:GetNextPrimaryFire()
		
		if ( self:CanBFire() ) && ( fNextPFire < CurTime() && fNextPFire > -1 ) then
			if ( self:GetBurstCount() < 4 && self:GetCanBurst() ) && ( fNextPFire > -1 ) then
				self:Attack()
				
				self:SetCanBurst( true )
				self:SetBurstCount( self:GetBurstCount() + 1 )

				self:SetNextPrimaryFire( CurTime() + 0.08 )
			end
			
			if ( self:GetBurstCount() > 3 ) then
				self:SetNextPrimaryFire( CurTime() + 0.35 )
				self:SetCanBurst( false )
				self:SetBurstCount( 0 )
			end
		end	
	end
		
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

local tEventBlacklist = { 
	[ 21 ] = true, 
	-- [ 6001 ] = true
}

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( tEventBlacklist[ event ] ) then
		return true
	end

end

function SWEP:CanBFire()

	if ( self.Weapon:Clip1() <= 0 ) then
		self:SetBurstCount( 4 )
		return false
	end

	return true
	
end

function SWEP:CreateIceGib( vOrigin, aRotation, vVelocity )
	
	local entProp = ents.Create( "prop_emptymag" )
	entProp.RMdl = "models/gibs/furniture_gibs/furnituretable002a_chunk11.mdl"
	entProp.RMat = "models/elemental/frozen_alpha"
	entProp:SetPos( vOrigin )
	entProp:SetAngles( aRotation + Angle( 0, 90, 0 ) )
	entProp:Spawn()
	
	if ( vVelocity ) then
		local physProp = entProp:GetPhysicsObject()
		if ( !IsValid( physProp ) ) then return end
		physProp:SetMass( 4 )
		physProp:SetMaterial( "gmod_ice" )
		physProp:ApplyForceCenter( vVelocity )
	end
	
end

function SWEP:Attack( pOwnerAV )
	
	if ( !pOwnerAV ) then
		pOwnerAV = self.Owner:GetAimVector()
	end
	
	if ( self.FeelGoodEnabled ) then
		pOwnerAV = self:GetFeelGoodVector( pOwnerAV )
	end
	
	if ( self:WaterLevel() > 2 ) then
		local vDartOrigin = self:GetProjectileSpawnPos()
		local aDartRotation = self.Owner:EyeAngles()
		
		self:CreateIceGib( vDartOrigin, aDartRotation, 7200 * aDartRotation:Forward() )
	else
		local cmdDamageAmp = GetConVar( "sfw_damageamp" ):GetFloat()
		
		local iDmg = 5 * cmdDamageAmp

		local ptru = {}
		ptru.Num = 1
		ptru.Spread = Vector( 0, 0 )
		ptru.Tracer = 0
		ptru.Distance = 786
		ptru.HullSize = 1
		ptru.Damage = iDmg * 0.75

		local bullet = {}
		bullet.Num = 1
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() * 0.0024 )
		bullet.Spread = Vector( 0.002, 0.0016 ) + Vector( 0.001, 0.002 ) * self:GetSciFiACC()
		bullet.TracerName = "eml_tracer_cryo" 
		bullet.Tracer = 1
		bullet.Force = 2
		bullet.HullSize = 0.05
		bullet.Damage = iDmg

		bullet.Callback = function( attacker, tr, dmginfo )
			dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_SF_ICE ) )
			
			if !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) then
				if ( ( tr.MatType == MAT_METAL ) || ( tr.MatType == MAT_CONCRETE ) ) then
					local bouncer = ( tr.Normal - tr.HitNormal )
					bouncer = bouncer:Length()
					
					if ( ( bouncer < 1.8 ) ) then
						ptru.Src = tr.HitPos - pOwnerAV
						ptru.Dir = tr.Normal - 2 * tr.Normal:Dot( tr.HitNormal ) * tr.HitNormal

						self.Owner:FireBullets( ptru, false )
					end
				end
			end

			self:DealAoeDamage( DMG_CLUB, 3 * cmdDamageAmp, tr.HitPos, 40 )

			if ( !tr.Entity:IsWorld() && math.random( 0, 100 ) > 74 ) then
				DoElementalEffect( {
					Element = EML_ICE,
					Target = tr.Entity,
					Duration = 2,
					Attacker = self.Owner,
					Inflictor = self,
					Origin = tr.HitPos
				} )
			end
			
			if ( tr.HitWater ) then
				self:CreateIceGib( tr.HitPos - tr.Normal * 16, tr.Normal:Angle(), tr.Normal * 100 )
			end
		end
		
		self.Owner:FireBullets( bullet, false )
	end
	
	if ( self.Owner:IsPlayer() ) then
		if ( game.SinglePlayer && SERVER ) || ( CLIENT && IsFirstTimePredicted() ) then
			self.Owner:ViewPunch( Angle( math.random( -50, -60 ), math.random( -30, 30 ), 0 ) * ( 0.001 + self:GetSciFiACC() * 0.001 ) )
		end
		
		self:AddSciFiACC( 3 )
	end

	self:DoMuzzleEffect()
	self:EmitSound( "cat.vk21he.pfire" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
end

function SWEP:AltFire()

	if (  !self:CanPrimaryAttack( 9 ) ) then return end
	
	local viewmodel = self:GetViewModelEnt()
	ParticleEffectAttach( "ice_sfire_charge", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	
	if ( SERVER ) then
	
	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx2 ) ) then return end
	fx2:SetKeyValue( "_light", "110 190 255 255" )
	fx2:SetKeyValue( "spotlight_radius", 180 )
	fx2:SetKeyValue( "distance", 240 )
	fx2:SetKeyValue( "brightness", 1 )
	fx2:SetKeyValue( "style", 1 )
	fx2:SetPos( viewmodel:GetAttachment( viewmodel:LookupAttachment( "Muzzle" ) ).Pos )
	fx2:SetParent( self.Owner )
	fx2:Spawn()
	fx2:Fire( "Kill", "", 0.6 )
	
	end
	
	self:EmitSound( "elemental/freeze_breakfree.wav" )
	
	timer.Create( "awesomechargefx", 0.6, 1, function()
	
		if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end

		self:EmitSound( "elemental/freeze.wav" )
		self:TakePrimaryAmmo( 10 )
		
		local viewmodel = self.Owner:GetViewModel()
		
		if ( SERVER ) then
			ParticleEffectAttach( "aeblast_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )

			for k, v in pairs ( ents.FindInCone( self.Owner:EyePos(), self.Owner:GetAimVector(), 180, 0 ) ) do
				if ( v ~= self.Owner && v:GetOwner() ~= self.Owner ) && ( v:IsRagdoll() || v:GetClass() == "prop_physics" || v:IsNPC() || v:IsPlayer() ) && ( v:VisibleVec( self.Owner:EyePos() ) ) then
					DoElementalEffect( { Element = EML_ICE, Target = v, Duration = 3, Damage = 100, Attacker = self.Owner } )
					
					-- timer.Create( "freeze" .. self:EntIndex(), 0.1, 10, function() 
						-- if ( IsValid( self ) && IsValid( v ) ) then
							-- self:DoFreezeRagdolls( v:GetPos() )
						-- end
						-- timer.Remove( "freeze" .. self:EntIndex() )
					-- end )	
					
					v:TakeDamage( 10 * GetConVarNumber( "sfw_damageamp" ), self.Owner, self ) 
				end
			end
		end
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( -1.8, 0, 0 ) )
		end
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		
		timer.Remove( "awesomechargefx" )
		
	end )

end

function SWEP:PrimaryAttack()
	
	if ( self.Owner:IsNPC() ) then
		if ( self:GetNextPrimaryFire() > CurTime() ) then return end
		
		self:Attack()
		
		self:SetNextPrimaryFire( CurTime() + 0.1 )
		
		return
	end

	if ( self.Owner:KeyDown( IN_USE ) && self:GetNextPrimaryFire() < CurTime() ) then
		self:AltFire()

		self:SetNextPrimaryFire( CurTime() + 1.3 )
	
		return
	end

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	if ( self:GetBurstMode() ) && ( self.Owner:IsPlayer() ) then
		if ( self:GetBurstCount() > 3 ) then return end
		
		self:SetCanBurst( true )
	else
		self:Attack()
	
		self:SetNextPrimaryFire( CurTime() + 0.1 )
	end

end

function SWEP:SecondaryAttack()

	self:SetNextSecondaryFire( CurTime() + 0.4 )
	
	if ( self.Owner:KeyDown( IN_USE ) ) then
		if ( self:GetBurstMode() ) then 
			self:SetBurstMode( false )
		else
			self:SetBurstMode( true )
		end
		
		self:EmitSound( "Weapon_AR2.Empty" )
	end

end

function SWEP:OnReloadFinish()
	
	self:SetSciFiACC( 0 )

	self:SendWeaponAnim( ACT_VM_IDLE )

	self:SetCanBurst( false )
	self:SetBurstCount( 0 )

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	if ( SERVER ) then return end
	
	ParticleEffect( "ice_impact", tr.HitPos, Angle( 0, 0, 0 ) )
	ParticleEffect( "eml_generic_cryo_small", tr.HitPos, Angle( 0, 0, 0 ) )

	sound.Play( "scifi.bliz.hit", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 95, 102 ), 1.0 )

end