AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Purpose				= "Generate a concentrated beam. Originally designed as a field tool for cutting, the design has quickly been adopted as a handy weapon system."
SWEP.Instructions			= "Hold Mouse1 to fire. Has a chance to ignite targets. Burning targets take +50% more damage. Status chance increases the longer the laser is held."
SWEP.ItemRank 				= 13

SWEP.ViewModel				= "models/weapons/c_scifip.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"
SWEP.HoldType 				= "pistol"
SWEP.HoldTypeNPC 			= "pistol"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 1
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.ViewModelFOV = 70

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_phurt.vmt" )
end

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"

SWEP.VfxMuzzleParticle 		= "ember_muzzle"
SWEP.VfxMuzzleRule 			= 1
SWEP.VfxMuzzleColor 		= Color( 255, 110, 60, 180 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFarZ 			= 256

SWEP.PrintName				= "HS12-CF 'Ember' Pistol"
SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModelSprintPos		= Vector( 0, 2, 1)
SWEP.ViewModelSprintAng		= Angle( -15, -10, 0 )
SWEP.ViewModelShift 		= false

SWEP.ViewModelMeleePos		= Vector( 6, 1, -6 )
SWEP.ViewModelMeleeAng		= Angle( 18, 40, -45 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.45
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.ReloadTime 			= 2
SWEP.ReloadPlaybackRate 	= 1.8
SWEP.ReloadLegacy 			= false
SWEP.DepletedSND			= "Weapon_AR2.Empty"

SWEP.DepletedSND			= ""

SWEP.ChargeAdd 				= 1.02
SWEP.ChargeDrain 			= 4

SWEP.SciFiFamily			= { "hwave", "phys", "infammo", "autoregen", "ads" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 12 - 26 / sec", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Plasma, Heat", color = Color( 255, 120, 120 ) },
	["3a"] = { text = "Status Chance: 10%", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Ammo drain: 	 5 (per second)", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Firerate: 					 -- (continuous)", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Has a chance ignite enemies or props.", color = Color( 180, 180, 180 ) },
--	["9a"] = { text = "... Their breath was of fire ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 6,
		DamageAttackRange = 8192,
		DamageType = { DMG_SF_HWAVE, DMG_BURN },
		StatusChance = 0,
		FireRate = { 
			{ RateTitle = "continuous", RateDelay = 0.2 },
		},
	},
	ClipSize = 40,
	ReloadSpeed = 2,
	Recoil = 0,
	PerkSet = { SCIFI_PERK_ELEMENTAL_FIRE, SCIFI_PERK_AMMO_HIGHCAL, SCIFI_PERK_EMBER_LASERFOCUS }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 2, -1, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	-- ["point"] = { type = SCIFI_SCK_TYPE_LASER, disabled = true, color = Color( 255, 110, 30, 768 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector( 2, 0, -1 ), angle = Angle( 0, 0, 0 ), range = 8192, line_size = 1, haze_size = 1, dot_size = 2 },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.4, 2.2, -4), angle = Angle(175, 10, 15), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -3.8), angle = Angle(0, -90, -90), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 3, -1.5), angle = Angle(90, 90, 90), size = Vector(0.045, 0.02, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["8a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, -1, -0.5), angle = Angle(-90, 90, 90), size = Vector(0.045, 0.02, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 0.5, -3), angle = Angle(0, 90, -90), size = Vector(0.061, 0.041, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 2.5, 1), angle = Angle(0, -90, 90), size = Vector(0.061, 0.041, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 1.25, -3), angle = Angle(90, 90, 0), size = Vector(0.404, 0.454, 0.404), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/weapons/hwave/barrel", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	-- ["point"] = { type = SCIFI_SCK_TYPE_LASER, disabled = true, color = Color( 255, 110, 30, 768 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector( 0, 0, -1 ), angle = Angle( 0, 0, 0 ), range = 8192, line_size = 1, haze_size = 1, dot_size = 2 },
	["4"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.4, 2.2, -4), angle = Angle(175, 10, 15), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["9"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -3.8), angle = Angle(0, -90, -90), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 3, -1.5), angle = Angle(90, 90, 90), size = Vector(0.045, 0.02, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["8a"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, -0.3, -0.5), angle = Angle(-90, 90, 90), size = Vector(0.045, 0.02, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/pele_barrel", skin = 0, bodygroup = {} },
	["10"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 0.5, -3), angle = Angle(0, 90, -90), size = Vector(0.061, 0.041, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["11"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 2.5, 1), angle = Angle(0, -90, 90), size = Vector(0.061, 0.041, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/hwave/lowerbarrel", skin = 0, bodygroup = {} },
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 1.25, -3), angle = Angle(90, 90, 0), size = Vector(0.404, 0.454, 0.404), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/weapons/hwave/barrel", skin = 0, bodygroup = {} }
}

SWEP.mat_laser_line = Material( "particle/beam_fire_nocolor_add.vmt" )
SWEP.mat_laser_haze = Material( "effects/laser_haze.vmt" )
SWEP.mat_laser_glow = Material( "particle/fire.vmt" )

local cmd_particles = GetConVar( "sfw_fx_particles" )

util.PrecacheSound( "common/NULL.wav" )
util.PrecacheSound( "scifi.ember.burn" )

local ember_noise = Sound( "scifi.ember.laser" )

SWEP.DataTables = {
	{ dType = "Bool", dName = "BeamActive" },
	{ dType = "Float", dName = "NextAmmoTick" }
}

local func_CreateRandomLight = function( id, dlightOrigin, brightess, size, r, g, b )

	local dlight = DynamicLight( id )
	if ( dlight ) then
		dlight.pos = dlightOrigin
		dlight.r = r
		dlight.g = g
		dlight.b = b
		dlight.brightness = brightness
		dlight.Decay = 2048
		dlight.Size = size
		dlight.Style = 1				
		dlight.DieTime = CurTime() + 1
		dlight.noworld = false
		dlight.nomodel = false
	end
		
end

function SWEP:SubInit()

	self:SetBeamActive( false )
	self:SetNextAmmoTick( 0 )

end

local cmd_damageamp = GetConVar( "sfw_damageamp" )
local iBaseDamage, iDrain, iLeech
local fReloadAnim = 0
local tIndex, pOwnerSP, pOwnerAV, pOwnerEA, fw, up, rt

function SWEP:Equip( NewOwner )

	if ( NewOwner:IsNPC() ) then
		if ( self.SciFiWorld ~= nil && self.SciFiWorld ~= "" ) then
			self:SetMaterial( self.SciFiWorld )
		end
	end

	if ( self.Owner:IsPlayer() ) then
		self.Owner:GiveAmmo( 40, self.Primary.Ammo )
	end

end

local bDeployed = false
local dCharge = 0
local laserV, laserW

local tDestructables = { "func_breakable", "func_physbox", "prop_physics" }

function SWEP:Think()

	local vm = self.Owner:GetViewModel()

	local iClip = math.min( self:Ammo1(), 100 )

	pOwnerSP = self.Owner:GetShootPos()
	pOwnerAV = self.Owner:GetAimVector()
	pOwnerEA = self.Owner:EyeAngles()
	fw, up, rt = pOwnerEA:Forward(), pOwnerEA:Up(), pOwnerEA:Right()

	if ( CLIENT ) then
		if ( self.Owner:ShouldDrawLocalPlayer() ) then
			vm = self || self.Owner:GetActiveWeapon()
		end
	end

	if ( SERVER ) then
		if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && iClip > 0 ) then
			if ( self:CanPrimaryAttack( 0, true ) ) then
				if ( self:GetCharge() < self.ChargeMax ) then
					self:SetCharge( math.min( self:GetCharge() + self.ChargeAdd, self.ChargeMax ) )
				end
			end
		else
			if ( self:GetCharge() > 0 ) then
				self:SetCharge( math.max( self:GetCharge() - self.ChargeDrain, 0 ) )
			end
		end
	end

	if ( self:GetBeamActive() ) then
		fAmp = cmd_damageamp:GetFloat()
		
		local tTraceData = {}
		tTraceData.start = self.Owner:GetShootPos()
		tTraceData.endpos = self.Owner:GetShootPos() + fw * 8192
		tTraceData.filter = { self, self.Owner }
		tTraceData.mask = MASK_SHOT

		local trLaser = util.TraceLine( tTraceData )
	
		-- if ( SERVER || ) then
			local tracer = ""
			
			if ( self.Owner:WaterLevel() == 3 ) then
				tracer = "ember_laser_underwater"
			else
				tracer = "ember_laser"
			end
			
			util.ParticleTracerEx( 
				tracer, --particle system
				self.Owner:GetShootPos() + ( fw * 32 + rt * 10 + up * -8 ), --startpos
				trLaser.HitPos, --endpos
				false, --do whiz effect
				self:EntIndex(), --entity index
				-1  --attachment
			)
		-- end
		
		if ( trLaser.Hit ) then
			if ( CLIENT ) then
				local lightrng = math.random( 80, 110 ) * 0.01
				func_CreateRandomLight( self:EntIndex(), trLaser.HitPos, lightrng, 160 * lightrng, 255, 110, 20 )
				
				if ( cmd_particles:GetBool() ) then
					if ( trLaser.HitWorld && !trLaser.HitSky ) then
						ParticleEffect( "ember_hit_world", trLaser.HitPos, self.Owner:GetAimVector():Angle() )
					elseif ( trLaser.HitNonWorld && trLaser.Hit ) then
						ParticleEffect( "ember_hit_entity", trLaser.HitPos, self.Owner:GetAimVector():Angle() )
					end
					
					-- if ( laserend:WaterLevel() > 0 ) then
						-- ParticleEffect( "ember_underwater_bubbles", trLaser.HitPos, self.Owner:GetAimVector():Angle(), laserend )
					-- end
				end
				-- EmitSound( "weapons/hwave/ember_burn.wav", trLaser.HitPos, self:EntIndex(), CHAN_STATIC, 0.4, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), math.random( 94, 104 ) )
			end
			
			if ( SERVER ) && ( self:GetNextAmmoTick() < CurTime() ) then
				local entTarget = trLaser.Entity
		
				local iDamageType = bit.bor( DMG_SLASH, DMG_CLUB ) -- DMG_PREVENT_PHYSICS_FORCE )
		
				iBaseDamage = 6 * fAmp
				
				if ( entTarget:IsOnFire() ) then
					self:DealAoeDamage( bit.bor( iDamageType, DMG_BURN ), iBaseDamage * 1.5, trLaser.HitPos, 16, Vector( 0, 0, 0 ) )
				end
				
				if ( IsValid( entTarget ) ) then
					if ( tDestructables[ entTarget:GetClass() ] ) then
						iBaseDamage = iBaseDamage * 10
					end
				
					self:DealDirectDamage( iDamageType, iBaseDamage, entTarget, self.Owner, Vector( 0, 0, 0 ) )

					local iStatusThreshold = 100 - self:GetCharge()
		
					if ( math.random( 1, 100 ) > iStatusThreshold ) then
						DoElementalEffect( { Element = EML_FIRE, Target = entTarget, Attacker = self.Owner, Duration = 2 } )
					end
					
					if ( iStatusThreshold < 1 ) then
						DoElementalEffect( { Element = EML_DISSOLVE_HWAVE, Target = entTarget, Origin = trLaser.HitPos, Range = 12 } )
					end
				end
			end
		end
		
		self:DoMuzzleEffect()
		self:EmitSound( "scifi.ember.laser" )
		
		if ( SERVER ) then
			if ( self:GetNextAmmoTick() < CurTime() ) then
				self:TakePrimaryAmmo( 1 )
				self:SetNextAmmoTick( CurTime() + 0.2 )
			end
		end
	end
		
	local bSprint = ( self.SciFiState == SCIFI_STATE_SPRINT )
	local bReload = ( self.SciFiState == SCIFI_STATE_RELOADING )
	
	if ( self.Owner:KeyDown( IN_ATTACK ) && self:CanPrimaryAttack( 0 ) ) && !( bSprint || bReload ) then
		if ( !self:GetBeamActive() ) then
			if ( CLIENT ) then
				self:EmitSound( "scifi.ember.laser.start" )
				
				local att = vm:LookupAttachment("muzzle")
				ParticleEffectAttach( "ember_muzzle_turnon", PATTACH_POINT_FOLLOW, vm, att )
			end
	
			self:SetNextAmmoTick( CurTime() + 0.2 )
			self:SetBeamActive( true )
		end
	else
		if ( self:GetBeamActive() ) then
			if ( CLIENT ) then
				self:EmitSound( "scifi.ember.laser.off" )
				
				local att = vm:LookupAttachment("muzzle")
				ParticleEffectAttach( "ember_muzzle_turnoff", PATTACH_POINT_FOLLOW, vm, att )
				
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )
			end
			
			self:SetNextAmmoTick( CurTime() + 0.2 )
			self:SetBeamActive( false )
		end
	end

	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:Deploy()  

	self:SetAds( false )
	self:SetCharge( 0 )	
	self.ScifiRegenNext = CurTime() + 1
	
	self.SciFiState = SCIFI_STATE_IDLE
	self.SciFiMeleeCharge = 0

	local vm = self:GetViewModelEnt()
	if ( SERVER ) || ( !game.SinglePlayer() && CLIENT ) then
		self:StopParticles()
	end
	
	self:SetBeamActive( false )

	return true
	
end

function SWEP:ResetDeployment()

	self:SetAds( false )
	self:EmitSound( "BaseGrenade.StopSounds" )
	
	local wOwner = self.Owner 

	if ( !wOwner || !IsValid( wOwner ) ) then
		wOwner = self.LastOwner
		
		if ( SERVER ) && ( wOwner ) then
			net.Start( "SciFiUpdateOwnership" )
			net.WriteEntity( wOwner )
			net.Send( wOwner )
		end
	end

	if ( IsValid( wOwner ) && CLIENT && wOwner:IsPlayer() ) then
		local vm = wOwner:GetViewModel()

		if ( IsValid( vm ) ) then 
			vm:SetSubMaterial( 0, "" )
			vm:SetSubMaterial( 1, "" )
			vm:SetSubMaterial( 2, "" )
			vm:SetSubMaterial( 3, "" )
			vm:SetSubMaterial( 4, "" )
			
			self:ResetBonePositions( vm )
			vm:StopParticles()
		end
	end
	
	self:SetBeamActive( false )
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( IsValid( self.Owner ) ) && ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
			vm:StopParticles()
		end
	end
	
	if ( SERVER ) || ( !game.SinglePlayer() && CLIENT ) then
		self:StopParticles()
	end
	
	self:ResetDeployment()
	self:SetSciFiACC( 4 )
	
	bDeployed = false
	
	return true

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( event == 6001 ) then 
		return true 
	end

	if ( event == 21 || event == 22 ) then
		return true
	end

end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsNPC() ) then
		local viewmodel = self:GetViewModelEnt()
	
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( .025, .025, 0 )
		bullet.Tracer = 1
		bullet.Force = 5
		bullet.HullSize = 16
		bullet.Damage = 8 * GetConVarNumber( "sfw_damageamp" )
		bullet.TracerName = "seraph_tracer"
		bullet.Callback = function( attacker, tr, dmginfo )
			dmginfo:SetDamageType( bit.bor( DMG_SLASH, DMG_CLUB ) )
		end

		self.Owner:FireBullets( bullet, false )
	
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.25, -1.5 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 2.4 )
		end
		
		ParticleEffectAttach( "ember_muzzle_turnon", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( SERVER ) and ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) and ( self:GetSciFiACC() >= 20 ) then
			ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		end
		
		self:DrawMuzzleLight( "255 130 100 220", 140, 720, 0.075 )

		self:EmitSound( "scifi.ember.laser.off"  )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	end
	
end

function SWEP:SecondaryAttack()

end

function SWEP:OnReload()
	self:SetBeamActive( false )
end