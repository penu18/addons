AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable=false

SWEP.PrintName				= "AQS 'Zircon' SMG"
-- SWEP.Purpose				= ""
-- SWEP.Instructions			= "Mouse1 to fire, Mouse2 to aim down sights."
SWEP.ItemRank 				= 6

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.ViewModel				= "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_p90.mdl"
-- SWEP.SciFiSkin 				= "models/black"
SWEP.SciFiSkin_1 			= "models/black"
-- SWEP.SciFiSkin_2 			= "models/black"
-- SWEP.SciFiSkin_3 			= "models/black"
-- SWEP.SciFiWorld 			= ""models/black"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.HoldType 				= "smg"
SWEP.HoldTypeSprint			= "passive"
SWEP.HoldTypeNPC 			= "smg"
SWEP.DeploySpeed 			= 2

SWEP.Primary.ClipSize		= 42
SWEP.Primary.DefaultClip	= 42
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"

SWEP.VfxMuzzleAttachment 	= "1"
SWEP.VfxMuzzleParticle 		= "_wraithgun_muzzle"
SWEP.VfxMuzzleColor 		= Color( 80, 70, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 620

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.12
SWEP.NPCAccuracy 			= 1200
SWEP.NPCSkillLevel 			= 2
SWEP.NPCAimVectorOverride 	= Vector( 0, 0, 0 )
SWEP.NPCBulletSpread 		= 4
SWEP.NPCRestMin 			= 0.3
SWEP.NPCRestMax 			= 0.6
SWEP.NPCBurstMin 			= 1
SWEP.NPCBurstMax 			= 2
SWEP.NPCBurstDelay 			= 0.2

SWEP.ProjectileOffset 		= Vector( 6, -2 )
SWEP.ProjectileOffsetNPC 	= Vector( -1, -1 )

SWEP.DepletedSND			= "scifi.storm.dryfire"
SWEP.ReloadSND				= "Weapon_SMG1.Reload" 
SWEP.ReloadACT				= ACT_VM_RELOAD
--SWEP.ReloadRealisticClips 	= false
SWEP.ReloadTime 			= 2.4
SWEP.ReloadPlaybackRate 	= 1.2

SWEP.AdsFov 				= 50
SWEP.AdsTransitionSpeed		= 24
SWEP.AdsPos 				= Vector( -5.85, 0, 1 )
SWEP.AdsAng 				= Angle( 0, 0, 0 )

SWEP.ViewModelSprintPos 	= Vector( 6, 2, -1 ) -- Vector( 5, 1.5, 1 )
SWEP.ViewModelSprintAng		= Angle( -4, 30, -30 ) -- Angle( -17.5, 25, -15 )
SWEP.ViewModelSwayDirection = Vector( -0.75, 6, 2 ) -- Vector( -0.25, 4, 0.6 )
SWEP.ViewModelSwayStrength 	= Vector( 0.5, 0.15 )
SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 4.25
SWEP.SprintAnimSpeed		= 10
SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.0
SWEP.ViewModelDuckPos		= Vector( -2, -6, 3 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -10 )
SWEP.ViewModelMeleePos		= Vector( 20, 11, -4 )
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -60 )

SWEP.SprintAnimIdle			= false
SWEP.ViewModelShift = false

SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -6, 1, -4 )
SWEP.ViewModelReloadAng		= Angle( 10, -12, -6 )

SWEP.SciFiFamily			= { "vtec", "phys" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 10", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				x1.5", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Energy", color = Color( 80, 180, 255 ) },
	["4"] = { text = "Clip size: 					24", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Fire rate: 				4 (semi-auto)", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Pew, pew, pew!", color = Color( 180, 180, 180 ) },
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 10,
		DamageType = DMG_SF_VAPOR,
		CritMul = 2,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.1 }, 
		},
	},
	Secondary = {
		DamageAmount = 180,
		DamageComposition = "120, 60",
		DamageBlastRadius = 256,
		DamageType = { DMG_BLAST, DMG_SF_VAPOR },
		CritMul = nil,
		StatusChance = nil,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 1.2 },
		},
		ChargeRate = nil
	},
	ClipSize = 42,
	ReloadSpeed = 2,
	Recoil = 4,
	PerkSet = { SCIFI_PERK_AMMO_HIGHCAL, SCIFI_PERK_AMMO_STICKYGRENADES, SCIFI_PERK_AMMO_EXPLOSIVE }
}

SWEP.ViewModelBoneMods = {
	-- ["ValveBiped.base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 2.8, -1, 7 ), angle = Angle( 0, -2, 0 ) },
	-- ["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 1.4, -4.4 ), angle = Angle( 0, 2, 12 ) },
	-- ["ValveBiped.Bip01_L_Hand"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle(10, -10, -50) },
	-- ["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector(-7, -0.5, 3.5), angle = Angle( 0, 0, 0 ) },
	-- ["ValveBiped.Bip01_R_Forearm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	-- ["ValveBiped.Bip01_R_Hand"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -0.1 ), angle = Angle( 1, 0, 0 ) },
	-- ["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, -15, 0) },
	-- ["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, -15, 0) },
	-- ["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5, 10, 0) }
}
--[[
SWEP.VElements = {
	["gun"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/dpfilms/weapons/w_neophron.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.4, 4, 0.2), angle = Angle(0, 0, -92), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}
]]--
SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-0.1, -4.5, 1), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-1, 0.4, 6), angle = Angle(180, 90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["0b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.6, -1.75, 6), angle = Angle(180, -90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.8, 2, 5), angle = Angle(0, -180, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/obsidian_barrel.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.22, -0.6, 2), angle = Angle(0, 0, 90), size = Vector(0.25, 0.3, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/stalkerpod_lid.mdl", bone = "Base", rel = "parent", pos = Vector(-0.22, -1.2, -1.2), angle = Angle(-90, 90, 0), size = Vector(0.3, 0.2, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lapis_casing", skin = 0, bodygroup = {} },
	-- ["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.62, -1.4, 1.2), angle = Angle(-78.888, -22, -100), size = Vector(1.05, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "v_weapon.p90_Clip", rel = "", pos = Vector(0.1, -1.4, -2.8), angle = Angle(0, -90, 0), size = Vector(0.06, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.5, 1, -4.5), angle = Angle(0, -90, -100), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["0a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-1, 0.4, 6), angle = Angle(180, 90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["0b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.6, -1.75, 6), angle = Angle(180, -90, 0), size = Vector(0.08, 0.03, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lowerbarrel", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.6, 2, 5), angle = Angle(0, -180, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/obsidian_barrel.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.22, -0.6, 2), angle = Angle(0, 0, 90), size = Vector(0.25, 0.3, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/stalkerpod_lid.mdl", bone = "Base", rel = "parent", pos = Vector(-0.22, -1.2, -1.2), angle = Angle(-90, 90, 0), size = Vector(0.3, 0.2, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/lapis_casing", skin = 0, bodygroup = {} },
	-- ["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(0.62, -1.4, 1.2), angle = Angle(-78.888, -22, -100), size = Vector(1.05, 1.103, 1.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "ValveBiped.base", rel = "parent", pos = Vector(-0.2, -1.4, 0.5), angle = Angle(0, -90, 180), size = Vector(0.06, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} }
}

local stock_hpos = Vector(-0.25, -1.2, -1.2)
local body_hpos = Vector(-0.22, -0.6, 2)
local fStockOffset = 0
local fTimeOffset = 0

local cmd_particles = GetConVar( "sfw_fx_particles" )

local dState
local vmEntity, vmAttach
function SWEP:Think()
	
	local fNextPFire = self:GetNextPrimaryFire() - ( CurTime() + FrameTime() )
	fNextPFire = fNextPFire * self.ChargeDeltaFactor

	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
		local bParticles = cmd_particles:GetBool()
		if ( CLIENT ) && ( bParticles ) && !( dState == SCIFI_STATE_RELOADING ) then			
			if ( self.Owner:ShouldDrawLocalPlayer() ) then
				vmEntity = self || self.Owner:GetActiveWeapon()
			else
				vmEntity = self.Owner:GetViewModel()
			end
			
			vmAttach = vmEntity:LookupAttachment( "1" )
			
			vmEntity:SetSequence( "reload" )
			
			ParticleEffectAttach( "lapis_vent", PATTACH_POINT_FOLLOW, vmEntity, vmAttach )
		end

		if ( fNextPFire > 2.6 && fNextPFire < 3 ) then
			fStockOffset = Lerp( FrameTime() * 12, fStockOffset, 2 )
		end
		
		if ( fNextPFire < 1.1 ) then
			fStockOffset = Lerp( FrameTime() * 12, fStockOffset, 0 )
		end
		
		local stock, body = self.VElements[ "8" ], self.VElements[ "7" ]
		stock.pos = stock_hpos + Vector( 0, 0, -2 ) * fStockOffset
		body.pos = body_hpos + Vector( 0, 0, 1 ) * fStockOffset
	end

	dState = self.SciFiState
	
	self:Anims()
	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	
end

local tEventBlacklist = { 
	[ 20 ] = true, 
	[ 5001 ] = true, 
	[ 5003 ] = true 
}

function SWEP:FireAnimationEvent( pos, ang, event, options )

	local vm = self:GetViewModelEnt() 
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 2 )
	end

	if ( tEventBlacklist[ event ] ) then
		return true
	end

end

function SWEP:AltFire()

	if ( !self:CanPrimaryAttack( 9 ) ) then 
		return 
	end

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	if ( SERVER ) then
		local ent = ents.Create( "sfw_azure_ent" )
		if ( !IsValid( ent ) ) then return end
		if (self.SciFiState != SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( pOwnerSP + ( pOwnerAV * 8 ) )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent.MeteorEnabled = true
		ent.PhxGrav = false
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local vSpread = self:GetProjectileSpreadVector()
		if( self.Owner:IsNPC() ) then
			vSpread = Vector( 0, 0, 0 )
		end

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( ( pOwnerAV + Vector( 0, 0, 0 ) ) * 3200 + vSpread )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -2.2, -2.6 ), 0, 0 ) * ( 1 + self:GetSciFiACC() * 0.05 ) )
		self:AddSciFiACC( 12 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.wraithshot.fire.charged" )
	self:EmitSound( "scifi.wraithshot.fire.echo" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 10 )

	self:SetNextPrimaryFire( CurTime() + 1.2 )
	
end

function SWEP:Attack()

	if ( self.Owner:IsPlayer() && self.Owner:KeyDown( IN_USE ) ) then

		self:AltFire()
		
		return
	end

	if ( !self:CanPrimaryAttack( 0 ) ) then 
		return 
	end

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	if ( SERVER ) then
		local ent = ents.Create( "lapis_pfire" )
		if ( !IsValid( ent ) ) then return end
		if (self.SciFiState != SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( pOwnerSP + ( pOwnerAV * 8 ) )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		ent.BaseDamage = 8
		
		local vSpread = self:GetProjectileSpreadVector() * ( 1.2 + self:GetSciFiACC()  * 0.6 ) + Vector( 0, 0, 8 ) * self:GetSciFiACC()
		if( self.Owner:IsNPC() ) then
			vSpread = Vector( 0, 0, 0 )
		end

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( pOwnerAV * 7200 + vSpread )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.4, -0.6 ), 0, 0 ) * ( 1 + self:GetSciFiACC() * 0.05 ) )
		self:AddSciFiACC( 4 )
	end
	
	self:DoMuzzleEffect()

	self:EmitSound( "scifi.wraithshot.fire" )
	self:EmitSound( "scifi.wraithshot.fire.echo" )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

	self:SetNextPrimaryFire( CurTime() + 0.1 )

end

function SWEP:PrimaryAttack()
	
	if ( self.Owner:IsNPC() ) then
		if ( self:GetNextPrimaryFire() > CurTime() ) then return end

		timer.Create( "zircon_bfire_"..self:EntIndex(), 0.1, math.random( 2, 4 ), function() 
			if ( !IsValid( self ) || !IsValid( self.Owner ) || !self:CanPrimaryAttack( 0, true ) ) then return end
			
			self:Attack()
		end )
		
		self:SetNextPrimaryFire( CurTime() + 0.6 )
		
		return
	end

	if ( self.Owner:KeyDown( IN_USE ) ) then
		self:AltFire()
	
		return
	end

	self:Attack()

end

function SWEP:OnReload()

	if ( !game.SinglePlayer() && CLIENT ) || ( SERVER ) then
		self:EmitSound( "scifi.hwave.switchmode" )
	end

end

function SWEP:OnReloadFinish()

	if ( !game.SinglePlayer() && CLIENT ) || ( SERVER ) then
		self:EmitSound( "scifi.asa6.reload.bback" )
	end

end