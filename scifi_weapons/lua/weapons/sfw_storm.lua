AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.NpcSpawnFlags 			= {}

SWEP.Purpose				= "A destructive energy shotgun. It fires a volley of volatile energy projectiles but compared to its moderate damage, its low accuracy makes it is only useful on short distances."
SWEP.Instructions			= "Mouse1 to fire. Mouse2 to aim down sights. Aiming down sights will switch the weapon to burst fire. You'll always fire max. 6 projectiles per trigger-pull."
SWEP.ItemRank 				= 21

SWEP.PrintName				= "ASR-5 'Storm' Shotgun"
SWEP.Slot					= 3
SWEP.SlotPos				= 3

SWEP.ViewModel				= "models/weapons/c_scifiv.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.HoldType 				= "shotgun"
SWEP.HoldTypeNPC 			= "shotgun"
SWEP.SciFiSkin				= "models/weapons/saphyre/skin"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "models/weapons/shared/ar2_vtsteel.vmt"
SWEP.ViewModelFOV 			= 60

SWEP.IhlExplicit 		= true
SWEP.IhlModel			= "models/weapons/w_irifle.mdl"
SWEP.IhlHolsterPosition = Vector( -8, -7, -6 )
SWEP.IhlHolsterRotation = Angle( -10, 0, 0 )

SWEP.DefaultSwayScale		= 1.0
SWEP.DefaultBobScale		= 2.0
SWEP.SprintSwayScale		= 0.3 -- 3.0
SWEP.SprintBobScale			= 0.4 -- 4.0

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"

SWEP.VfxMuzzleAttachment 	= "Muzzle"
SWEP.VfxMuzzleParticle 		= "storm_muzzle"
SWEP.VfxMuzzleColor 		= Color( 70, 80, 255, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 620
--SWEP.VfxHeatForce 			= true
SWEP.VfxHeatDelay 			= 0.4

SWEP.DepletedSND			= "scifi.storm.dryfire"
SWEP.ReloadSND				= "scifi.storm.reload.start" 
SWEP.ReloadACT				= ACT_VM_IDLE_TO_LOWERED
SWEP.ReloadPlaybackRate 	= 2.8 -- 2.6
SWEP.ReloadTime 			= 0.3 -- 0.35

SWEP.AdsPos 				= Vector(-2.9, -4, 1)
SWEP.AdsAng 				= Vector(0, 0, 0)
SWEP.AdsFov 				= 60
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.storm.zoomin"
SWEP.AdsSoundDisable		= "scifi.storm.zoomout"

SWEP.SprintAnimIdle 		= false
SWEP.ViewModelSprintPos		= Vector( 4.5, -1, 1 )
SWEP.ViewModelSprintAng		= Angle( -15, 30, -5 )
SWEP.ViewModelShiftOffset 	= Vector( 0, -0.041, -0.12 )
SWEP.ViewModelShiftRotation = Vector( 0.35, 0.5, 1.2 )
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelSprintRatio 	= 1
SWEP.ViewModelSprintSway 	= 3
SWEP.ViewModelSwayDirection = Vector( -0.4, 6, 0 )
SWEP.SprintAnimSpeed		= 10

SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( 5, -4, -5 )
SWEP.ViewModelReloadAng		= Angle( 10, 5, 15 )

SWEP.ViewModelMeleePos		= Vector( 14, -2, -10 )
SWEP.ViewModelMeleeAng		= Angle( 40, 50, -20 )

SWEP.ProjectileSpreadY 		= Vector( -10, 10 )
SWEP.ProjectileSpreadZ 		= Vector( -10, 10 )

SWEP.NPCLeadTarget	 		= true
SWEP.NPCLeadPower 			= 0.15
SWEP.NPCSkillLevel 			= 2
SWEP.NPCBulletSpread 		= 0
SWEP.NPCRestMin 			= 0.6
SWEP.NPCRestMax 			= 0.8
SWEP.NPCBurstMin 			= 1
SWEP.NPCBurstMax 			= 1
SWEP.NPCBurstDelay 			= 0.4

SWEP.MidairRecoilMul		= 2

SWEP.SciFiFamily			= { "vtec", "phys", "autoreload" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 10 * 6", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Energy", color = Color( 80, 180, 255 ) },
	["2"] = { text = "Crit. mul.: 				x1.5", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Fire rate: 				 1.2", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Clip size: 					1", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "10 * 6",
		DamageAmount = 48,
		DamageType = DMG_SF_VAPOR,
		CritMul = 1.5,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.8 }, 
			{ RateTitle = "burst", RateDelay = 0.63 }
		},
	},

	CoreRechargeRate = nil,
	ReloadSpeed = 1.8,
	Recoil = 6,
	PerkSet = { SCIFI_PERK_RELOAD_FROMRESERVES, SCIFI_PERK_STORM_BURSTDOWNSIGHTS }
}

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 3, -2 ), angle = Angle( 0, 0, 0 ) },
	["Shell2"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Reload1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Claw1"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["Claw2"] = { scale = Vector( 0, 0, 0 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 5, 1, 7 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["2"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_lock01.mdl", bone = "Bolt2", rel = "", pos = Vector(0, 1, -1), angle = Angle(0, -90, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/bbolt", skin = 0, bodygroup = {} },
	["3b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_dispenser.mdl", bone = "Base", rel = "parent", pos = Vector(1, -1.5, 10), angle = Angle(0, 0, 180), size = Vector(0.05, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/capacitor", skin = 0, bodygroup = {} },
	["3a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_dispenser.mdl", bone = "Base", rel = "parent", pos = Vector(1, -1.5, 10), angle = Angle(0, 0, 180), size = Vector(0.05, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/capacitor", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/obsidian_barrel.mdl", bone = "Base", rel = "parent", pos = Vector(0, -0.8, 16), angle = Angle(0, 0, 90), size = Vector(0.4, 0.4, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["4a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "Base", rel = "parent", pos = Vector(0.4, -2.75, 9), angle = Angle(0, -180, 0), size = Vector(0.08, 0.08, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} },
	["4b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "Base", rel = "parent", pos = Vector(-0.4, -2.75, 9), angle = Angle(0, 0, 0), size = Vector(0.08, 0.08, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "Base", rel = "parent", pos = Vector(0, 1.6, 18), angle = Angle(90, 90, 0), size = Vector(0.0175, 0.008, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/vtech_case", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "Base", rel = "parent", pos = Vector(0, -3.5, 8), angle = Angle(2, -90, 180), size = Vector(0.012, 0.012, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "Base", rel = "parent", pos = Vector(0.449, -2.254, 6.5), angle = Angle(180, 0, 0), size = Vector(0.046, 0.05, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/case", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["parent"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.4, 0.1, -3.2), angle = Angle(0, -90, -103), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "vgui/white", skin = 0, bodygroup = {} },
	["3b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_dispenser.mdl", bone = "Base", rel = "parent", pos = Vector(1, -1.5, 10), angle = Angle(0, 0, 180), size = Vector(0.05, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/capacitor", skin = 0, bodygroup = {} },
	["3a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_dispenser.mdl", bone = "Base", rel = "parent", pos = Vector(1, -1.5, 10), angle = Angle(0, 0, 180), size = Vector(0.05, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/capacitor", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/gear/obsidian_barrel.mdl", bone = "Base", rel = "parent", pos = Vector(0, -0.8, 16), angle = Angle(0, 0, 90), size = Vector(0.4, 0.4, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/m_barrel", skin = 0, bodygroup = {} },
	["4a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "Base", rel = "parent", pos = Vector(0.4, -2.75, 9), angle = Angle(0, -180, 0), size = Vector(0.08, 0.08, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} },
	["4b"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_light001a.mdl", bone = "Base", rel = "parent", pos = Vector(-0.4, -2.75, 9), angle = Angle(0, 0, 0), size = Vector(0.08, 0.08, 0.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/storm_core", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinetrain01a.mdl", bone = "Base", rel = "parent", pos = Vector(0, 1.4, 18), angle = Angle(90, 90, 0), size = Vector(0.0175, 0.008, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/vtech_case", skin = 0, bodygroup = {} },
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_core_arm01.mdl", bone = "Base", rel = "parent", pos = Vector(0, -3.5, 8), angle = Angle(2, -90, 180), size = Vector(0.012, 0.012, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/jotunn/combine_core_arm01", skin = 0, bodygroup = {} },
	["5+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "Base", rel = "parent", pos = Vector(0.449, -2.254, 6.5), angle = Angle(180, 0, 0), size = Vector(0.046, 0.05, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/vapor/case", skin = 0, bodygroup = {} }
}

SWEP.DataTables = {
	{ dType = "Bool", dName = "BurstMode" },
	{ dType = "Bool", dName = "CanBurst" },
	{ dType = "Bool", dName = "IsReloading" },
	{ dType = "Int", dName = "BurstCount" }
}

function SWEP:SubInit()

end

local fHandOffset = 0
local bCastShell = false
local bStylishReload = false
local dState = 0

function SWEP:Think()

	if ( IsValid( self.Owner ) && self.Owner:IsPlayer() ) then
		if ( self:GetSciFiState() == SCIFI_STATE_ADS || self:GetBurstCount() > 0 ) && ( SERVER || !game.SinglePlayer() ) then
			if ( !self:GetIsReloading() ) && ( self:CanBFire() ) && ( self:GetNextPrimaryFire() < CurTime() && self:GetNextPrimaryFire() > -1 ) then
				if ( self:GetBurstCount() < 4 && self:GetCanBurst() ) && ( self:GetNextPrimaryFire() ~= -1 ) then
					for i = 1, 3 - self:GetBurstCount() do 
						self:Storm()
					end
					
					if ( self:GetBurstCount() < 4 ) then 
						self:SetCanBurst( true )
						self:SetBurstCount( self:GetBurstCount() + 1 )
						self:SetNextPrimaryFire( CurTime() + 0.07 )
					end

				end

				if ( self:GetBurstCount() > 2 ) then
					self:SetNextPrimaryFire( CurTime() + 0.7 )
					self:SetCanBurst( false )
					self:SetBurstCount( 0 )
				end
			end	
		end
	
		local fNextPFire = self:GetNextPrimaryFire() - ( CurTime() + FrameTime() )
		fNextPFire = fNextPFire * self.ChargeDeltaFactor

		if ( CLIENT ) then
			if ( self:GetSciFiState() == SCIFI_STATE_ADS ) && !( dState == SCIFI_STATE_ADS ) then
				self.VfxMuzzleParticle = "storm_muzzle_cheap"
			end
			
			if ( !( self:GetSciFiState() == SCIFI_STATE_ADS ) && ( dState == SCIFI_STATE_ADS ) ) || ( !dState ) then
				self.VfxMuzzleParticle = "storm_muzzle"
			end
			
			if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
				if !( dState == self.SciFiState ) then
					if ( bStylishReload ) then
						self.ViewModelReloadPos	= Vector( 5, -4, -5 )
						self.ViewModelReloadAng	= Angle( 10, 5, 15 )
						bStylishReload = false
					end
					
					if ( !bStylishReload ) && ( math.random( 0, 6 ) > 4 ) then
						self.ViewModelReloadPos	= Vector( 6, 0, -12 )
						self.ViewModelReloadAng	= Angle( 25, 20, -10  )
						bStylishReload = true
					end
				end
				
				if ( fNextPFire > 0.3 ) then
					fHandOffset = Lerp( FrameTime() * 10, fHandOffset, 1 )
				end

				if ( fNextPFire < 0.3 ) then
					fHandOffset = Lerp( FrameTime() * 10, fHandOffset, 0 )
				end
				
				if ( fNextPFire <= 0.05 ) then
					fHandOffset = 0
				end

				self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos = Vector( 5, 1, 7 ) - Vector( 3, 2, 6 ) * fHandOffset
				self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = Angle( 0, 0, 0 ) + Angle( 0, 2, 10 ) * fHandOffset
				self.VElements["6"].pos = Vector(0, 1.6, 18) - Vector( 0, 0, 6 ) * fHandOffset
				self.VElements["4a"].pos = Vector(0.4, -2.75, 9) - Vector( 0, 0, 4 ) * fHandOffset
				self.VElements["4b"].pos = Vector(-0.4, -2.75, 9) - Vector( 0, 0, 4 ) * fHandOffset
				self.VElements["5"].pos = Vector(0, -3.5, 8) + Vector(0, 0, 4) * fHandOffset
				self.VElements["5"].angle = Angle(2, -90, 180) + Angle(-20, 0, 0) * fHandOffset
			end
			
			dState = self.SciFiState
		end
		
		if( fNextPFire > 0.1 ) && ( fNextPFire < 0.48 ) && ( self:CanReload() ) then
			local vmEntity = self.Owner:GetViewModel()
			
			if ( IsValid( vmEntity ) ) then
				
				if ( SERVER ) then
					self:StormReload()
					
					if ( bCastShell ) then
						local pOwnerEA = self.Owner:EyeAngles()
						local vmAttach = vmEntity:LookupAttachment( "muzzle" )
						local fxOrigin = self:GetProjectileSpawnPos() + pOwnerEA:Forward() * 32
						
						local effectdata = EffectData()
						effectdata:SetEntity( vmEntity )
						effectdata:SetOrigin( fxOrigin )
						effectdata:SetAttachment( 2 )
						effectdata:SetAngles( pOwnerEA + Angle( -30, -90, 0 ) )
						
						util.Effect( "ShotgunShellEject", effectdata )
						
						bCastShell = false
					end
				end

				if ( CLIENT && IsFirstTimePredicted() ) then
					vmEntity:SetSequence( "ir_reload" )
					vmEntity:SetPlaybackRate( self.ReloadPlaybackRate )
				end
			end
		end
		
		if ( fNextPFire > -2 ) then
			self:StopSound( "Weapon_AR2.Reload" )
			self:StopSound( "Weapon_AR2.Reload_Rotate" )
			self:StopSound( "Weapon_AR2.Reload_Push" )
		end
	end

	self:Anims()
	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:OnAds( bAds )
	
	if ( !bAds ) then
		local iBCount = self:GetBurstCount()
		if ( iBCount > 0 ) then
			self:SetBurstCount( 5 )
			self:TakePrimaryAmmo( 1 )
			bCastShell = true
		end
	end
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 21 || event == 22 ) then
		return true
	end

end

function SWEP:Storm()
	
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	if ( SERVER ) then
		local ent = ents.Create( "storm_pfire" )
		if ( !IsValid( ent ) ) then return end
		if ( self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( pOwnerSP + ( pOwnerAV * 8 ) )
		end
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		
		local vSpread 
		if ( self:GetSciFiState() == SCIFI_STATE_ADS ) then
			vSpread = self:GetProjectileSpreadVector() * 4 + Vector( 0, 0, 2 ) * self:GetSciFiACC()
		else
			vSpread = self:GetProjectileSpreadVector() * 30 + Vector( 0, 0, 2 ) * self:GetSciFiACC()
		end
		
		if ( self.Owner:IsNPC() ) then 
	--		pOwnerAV = self.NPCAimVectorOverride * 0.001
			self.Owner:SetSaveValue( "m_flLastAttackTime", ( CurTime() + 0.8 ) * -1 )
			self.Owner:SetSaveValue( "m_flNextAttack", 0.8 )
	--		vSpread = vSpread * 0.005
		end

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:Wake()
		phys:ApplyForceCenter( pOwnerAV * 4800 + vSpread )
	end

	if !( self:GetSciFiState() == SCIFI_STATE_ADS ) then return end
	self:StormMuzzle()
	
end

function SWEP:StormMuzzle()

	self:DoMuzzleEffect()
	
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( self:GetSciFiState() == SCIFI_STATE_ADS ) then
		self:EmitSound( "scifi.wraithshot.fire" )
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	else
		self:EmitSound( "scifi.storm.fire" )
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	end
	
	if ( self:GetSciFiState() == SCIFI_STATE_ADS ) then
		local iBurst = 3 - self:GetBurstCount()
		
		self.Owner:ViewPunch( Angle( math.random( -0.3, -0.6 ), 0, 0 ) * ( iBurst + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 2 * iBurst )
		
		if ( iBurst < 2 ) then
			self:TakePrimaryAmmo( 1 )
			
			self:SetNextPrimaryFire( CurTime() + 0.8 )
			bCastShell = true
		end
	else
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -3.2, -4 ), 0, 0 ) * ( 2 + self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 6 )
		
			self:TakePrimaryAmmo( 1 )
		end
		
		self:SetNextPrimaryFire( CurTime() + 0.8 )
		bCastShell = true
	end

end

function SWEP:PrimaryAttack()
	
	if ( !self:CanPrimaryAttack( 0 ) ) then 
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		
		return 
	end
	
	if ( self:GetSciFiState() == SCIFI_STATE_ADS ) && ( self.Owner:IsPlayer() ) then
		if ( self:GetBurstCount() >= 4 ) then return end
		self:SetCanBurst( true )
		
		return
	end
	
	for i=0, 5 do 
		self:Storm()
	end
	
	self:StormMuzzle()
	
end

function SWEP:CanBFire()

	if ( self:Clip1() <= 0 ) then
	--	self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end

	return true
	
end

function SWEP:CanReload()

	if ( self:Clip1() >= self.Primary.ClipSize ) then
		return false
	end

	if ( self:GetNextPrimaryFire() - 0.6 > CurTime() ) then
		return false
	end
	
	if ( self.Owner:IsPlayer() ) then
		if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then
			return false
		end

		if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
			return false
		end
		
		local cmd_advanims = GetConVar( "sfw_allow_advanims" )
		local bAnims = cmd_advanims:GetBool()
		
		if ( ( self:GetSciFiState() == SCIFI_STATE_SPRINT ) && ( bAnims ) ) then
			return false
		end
	end	
	
	return true
	
end

function SWEP:OnReload()

	if ( self.ReloadSND ) then
		self:EmitSound( self.ReloadSND )
	end
	
end

function SWEP:StormReload()

	-- self:OnReload()
	self:SetIsReloading( true )
	-- self:SetBurstCount( 5 )
	
	if ( self.Owner:IsPlayer() ) then
		if ( SERVER ) then
			net.Start( "SciFiReload" )
			net.WriteBool( true )
			net.WriteBool( self:GetSciFiState() == SCIFI_STATE_ADS )
			net.Send( self.Owner )
		end
		
		self:SetSciFiState( SCIFI_STATE_RELOADING )
		
		self:SetAds( false, false )
	
		timer.Simple( self.ReloadTime, function()
			if ( IsValid( self ) && IsValid( self.Owner ) ) then
				if ( self.ReloadAnimEndIdle ) then
					self:SendWeaponAnim( ACT_VM_IDLE )
				end
				
				self.Owner:RemoveAmmo( 1, self.Primary.Ammo )
				self:SetClip1( self.Primary.ClipSize )
--				self.Owner:DoReloadEvent()

				if ( IsFirstTimePredicted() && CLIENT ) then
					local vm = self.Owner:GetViewModel()
					vm:SetPlaybackRate( 1 )
			
					self:StopSound( "Weapon_AR2.Reload" )
					self:StopSound( "Weapon_AR2.Reload_Rotate" )
					self:StopSound( "Weapon_AR2.Reload_Push" )
				end
				
				if ( !game.SinglePlayer() && IsFirstTimePredicted() && CLIENT ) || ( SERVER ) then
					self:EmitSound( "scifi.storm.reload.finish" )
				end
				
				self:SetSciFiState( SCIFI_STATE_IDLE )
				
				if ( SERVER ) then
					net.Start( "SciFiReload" )
					net.WriteBool( false )
					net.WriteBool( false )
					net.Send( self.Owner )
				end
			end
		end )
	end

	-- if ( !game.SinglePlayer() && IsFirstTimePredicted() && CLIENT ) || ( SERVER ) then
		if ( self.Owner:IsPlayer() ) then
			local vm = self.Owner:GetViewModel()
			vm:SetPlaybackRate( self.ReloadPlaybackRate )
		else
			self:SetClip1( self.Primary.ClipSize )
		end

		self:SetIsReloading( false )
	-- end

end

function SWEP:Reload()

	if ( !self:CanReload() ) then return end

	self:StormReload()

end