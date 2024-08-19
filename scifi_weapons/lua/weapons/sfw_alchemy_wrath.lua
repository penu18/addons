AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable				= false

SWEP.Purpose				= "A more personalized version of the Spectra."
SWEP.Instructions			= "Press Mouse1 to fire, Hold and release Mouse1 to charge and fire a blight-shock. Press R to safely release a charged shot."

SWEP.ViewModel				= "models/weapons/c_scifip.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"
SWEP.HoldType 				= "pistol"
SWEP.HoldTypeNPC 			= "pistol"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 2
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.ViewModelFOV = 70

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_trace.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "SciFiEnergy"

SWEP.VfxMuzzleParticle 		= "umbra_muzzle"
SWEP.VfxMuzzleColor 		= Color( 255, 40, 40, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 160
SWEP.VfxMuzzleFarZ 			= 560

SWEP.PrintName				= "sfw_alchemy_wrath"
SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.AdsPos 				= Vector( 4.85, -4, 7 )
SWEP.AdsAng					= Angle( -1, 4, 22 )
SWEP.AdsFov 				= 55
SWEP.AdsSounds 				= true
SWEP.AdsSoundEnable 		= "scifi.ancient.sight.turnon"
SWEP.AdsSoundDisable		= "scifi.ancient.sight.turnoff"

SWEP.ViewModelHomePos		= Vector( 0, 0, 0 )

SWEP.ViewModelSprintAng		= Angle( -5, -10, 20 )
--SWEP.SprintAnim				= false
SWEP.ViewModelShift = false

SWEP.MidairRecoilMul		= 1

SWEP.SciFiACCRecoverRate	= 0.25
SWEP.SciFiRegenDelay		= 0.8
SWEP.ChargeMax				= 150
SWEP.ChargeAdd				= 2
SWEP.ChargeDrain			= 2
SWEP.ChargeDeltaCompensate 	= true

SWEP.ViewModelMeleePos		= Vector( 6, 1, -6 )
SWEP.ViewModelMeleeAng		= Angle( 18, 40, -45 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.45
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.DepletedSND			= ""

SWEP.SciFiFamily			= { "custom", "phys", "enerbow_cbeam", "nodas", "infammo" }
SWEP.IhlLaserColor 			= Color( 220, 0, 16, 255 )

SWEP.ViewModelBoneMods = {
	["ValveBiped.muzzle"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 10, -80) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5, -20, -40) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -10, 0) }
}

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.244, 0.023, 1.475), angle = Angle(-8, -5.855, -90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, 4.375, 0.085), angle = Angle(-10, -5.855, 7.138), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, -0.11, -2.129), angle = Angle(-1, -5.855, 180), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["0+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 3.2, -2.25), angle = Angle(-2, -8, 90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "0+++", pos = Vector(-14, 0.72, 2.72), angle = Angle(50, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["7"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "", rel = "0+++", pos = Vector(-15, 1.2, 3.4), angle = Angle(50, 0, 0), size = Vector(0.005, 0.005, 0.001), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["7+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/circle2x2.mdl", bone = "", rel = "7", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.004, 0.004, 0.001), color = Color(220, 220, 255, 140), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["8"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+++", pos = Vector(-4, 3.14, 3.76), angle = Angle(82.703, 9.536, -1.053), size = Vector(0.004, 0.004, 0.004), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["8+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/hunter/tubes/tube2x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "0+++", pos = Vector(0, 2.864, 3.88), angle = Angle(82.703, 9.536, -1.053), size = Vector(0.008, 0.008, 0.008), color = Color(220, 220, 255, 200), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.244, 0.023, 1.875), angle = Angle(-10, -5.855, -90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, 3.6, 0.085), angle = Angle(-10, -5.855, 7.138), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, -0.11, -2.129), angle = Angle(-10, -5.855, 180), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["0+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/catalyst/spectra_bone.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 3, -2.25), angle = Angle(-2, -10, 90), size = Vector(0.45, 0.34, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- resource.AddSingleFile( "weapons/hwave/hwave_charge.wav" )
util.PrecacheSound( "weapons/hwave/hwave_charge.wav" )
-- resource.AddSingleFile( "common/NULL.wav" )
util.PrecacheSound( "common/NULL.wav" )

local limb_1_hpos = Vector(9.244, 0.023, 1.2)
local limb_2_hpos = Vector(8.654, 3.375, 1.085)
local limb_3_hpos = Vector(8.654, -0.11, -2.129)
local limb_1_hang = Angle(-8, -5.855, -80)
local limb_2_hang = Angle(-10, -5.855, 7.138)
local limb_3_hang = Angle(-1, -5.855, 180)

local limb_1_mpos = Vector(10, -1, -1.8)
local limb_2_mpos = Vector(10, 1.4, 3)
local limb_3_mpos = Vector(10, 4.4, -1.5)
local limb_1_mang = Angle(-180, -32, -90)
local limb_2_mang = Angle(20, -180, -12)
local limb_3_mang = Angle(-160, -5, 30)

local core_invis = "vgui/white"
local core_vis = "models/weapons/misc/energy_surf_hwave"
local core_color_blight = Vector( 1, 1, 1 )
local core_color_default = Vector( 8, 0.2, 0.1 )

local mymat = Material( "models/weapons/spectra/spectra_bone_rtedit.vmt" )

SWEP.DataTables = {
	{ dType = "Float", dName = "NextChargeAnim" },
	{ dType = "Float", dName = "NextCoreFxAnim" }
}

function SWEP:SubInit()

	self:SetCharge( 0 )
	self.ScifiRegenNext = 0

end

function SWEP:Think()

	local animtime = self:GetNextChargeAnim()	
	local vm = self.Owner:GetViewModel()
	local sine0 = math.sin( CurTime() * 16 ) / 8
	local sine1 = math.sin( CurTime() * 8 ) / math.random( 10, 20 )
	local sine2 = math.sin( CurTime() * 8 ) / math.random( 15, 25 )
	local cmod = self.Charge / 100

	self.VElements[ "0" ].pos = limb_1_hpos + Vector( -sine0, sine1 - cmod, sine2 )
	self.VElements[ "0+" ].pos = limb_2_hpos + Vector( sine0, sine1, -sine2 + cmod )
	self.VElements[ "0++" ].pos = limb_3_hpos + Vector( sine0, -sine1, sine2 - cmod )
	
	self.VElements[ "0" ].angle = limb_1_hang + Angle( -sine0, sine1, sine2 ) * cmod
	self.VElements[ "0+" ].angle = limb_2_hang + Angle( sine0, sine1, -sine2) * cmod
	self.VElements[ "0++" ].angle = limb_3_hang + Angle( sine0, -sine1, sine2 ) * cmod
	
	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetProjectileSpawnPos() + self.Owner:EyeAngles():Forward() * 30
			dlight.r = 255
			dlight.g = 45
			dlight.b = 30
			dlight.brightness = 0.1 + cmod
			dlight.Decay = 2048
			dlight.Size = 1 * self.Weapon:Clip1() + 128 * cmod
			dlight.Style = 1				
			dlight.DieTime = CurTime() + 1
			dlight.noworld = false
			dlight.nomodel = false
		end
	end

	local core_color_actual = mymat:GetVector( "$selfillumtint" )
	
	if ( self.Charge >= 25 ) then
		core_color_actual = LerpVector( FrameTime() * 4, core_color_actual, core_color_blight )
	else
		core_color_actual = LerpVector( FrameTime() * 4, core_color_actual, core_color_default )
	end
	
	mymat:SetVector( "$selfillumtint", core_color_actual )
	
	if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
		if ( self:GetNextCoreFxAnim() <= CurTime() ) then
			ParticleEffectAttach( "celest_wrath_core", 4, vm, vm:LookupAttachment("muzzle") )
		--	ParticleEffectAttach( "item_pfx_upgrade", 4, self.Owner, 0 )
			self:SetNextCoreFxAnim( CurTime() + 2 )
		end
	end
		
	local hangle
	if ( self.SciFiState == SCIFI_STATE_ADS ) then
		hangle = LerpAngle( FrameTime() * 8, self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle, Angle(10, 10, -40) )
		self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle = hangle
		self.VElements[ "8" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "8" ].color.a, 255 )
		self.VElements[ "8+" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "8+" ].color.a, 255 )
		self.VElements[ "6" ].color.a = Lerp( FrameTime() * 4, self.VElements[ "6" ].color.a, 255 )
		self.VElements[ "6" ].size = Vector(0.005, 0.005, 0.001) * ( 1 + cmod )
		if ( self.Charge >= 25 ) then
			self.VElements[ "6" ].color = core_color_blight:ToColor()
		else
			self.VElements[ "6" ].color = core_color_default:ToColor()
		end
		self.VElements[ "7" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "7" ].color.a, 220 )
		self.VElements[ "7+" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "7+" ].color.a, 20 )
		self.VElements[ "7+" ].size = self.VElements[ "7" ].size * ( self:Clip1() / 100 )
	else
		hangle = LerpAngle( FrameTime() * 8, self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle, Angle(10, 10, -80) )
		self.ViewModelBoneMods["ValveBiped.Bip01_R_Hand"].angle = hangle
		self.VElements[ "8" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "8" ].color.a, 0 )
		self.VElements[ "8+" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "8+" ].color.a, 0 )
		self.VElements[ "6" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "6" ].color.a, 0 )
		self.VElements[ "7" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "7" ].color.a, 0 )
		self.VElements[ "7+" ].color.a = Lerp( FrameTime() * 8, self.VElements[ "7+" ].color.a, 0 )
	end
	
	if ( self.Owner:KeyDown( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) && self:Clip1() > 0 ) then
		if ( CLIENT ) then self.Charge = math.Clamp( self.Charge + self.ChargeAdd * self.ChargeDeltaFactor, 0, self.ChargeMax ) end
		if ( SERVER ) then self.Charge = math.Clamp( self.Charge + self.ChargeAdd, 0, self.ChargeMax ) end
	else
		if ( CLIENT ) then self.Charge = math.Clamp( self.Charge - self.ChargeDrain * self.ChargeDeltaFactor, 0, self.ChargeMax ) end
		if ( SERVER ) then self.Charge = math.Clamp( self.Charge - self.ChargeDrain, 0, self.ChargeMax ) end
	end

	if ( self.Owner:KeyReleased( IN_ATTACK ) && !self.Owner:KeyDown( IN_RELOAD ) ) && ( self:GetNextPrimaryFire() <= CurTime() ) && (self.SciFiState ~= SCIFI_STATE_SPRINT ) then
		if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) then
			self:DefaultAttack()
			
			if ( self.Charge >= 100 ) then
				self:SetNextPrimaryFire( CurTime() + 0.32 )	
			else
				self:SetNextPrimaryFire( CurTime() + 0.14 )	
			end
		end
	end
	
	if ( CLIENT ) && ( self:GetNextPrimaryFire() > CurTime() ) && (self.SciFiState ~= SCIFI_STATE_SPRINT ) then
		self:SetCharge( 0 )
	end

	if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( self.Charge >= 25 ) then
		for k,v in pairs( ents.FindInSphere( self.Owner:EyePos(), 512 ) ) do
			self:VortexDrag( v )
		end
	
		if ( self:GetNextPrimaryFire() + 0.22 <= CurTime() ) then
			if ( animtime >= 0 && CurTime() > animtime ) then
				if ( ( game.SinglePlayer() && SERVER ) || !game.SinglePlayer() ) && ( self.Charge >= 40 ) then
					ParticleEffectAttach( "celest_wrath_core_charging", 4, vm, vm:LookupAttachment("muzzle") )
				end
			end
			
			if ( animtime >= 0 && CurTime() > animtime ) then
				if ( SERVER ) then
					vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle01" ) )
				end
				self:SetNextChargeAnim( CurTime() + 0.8 )
			end
		
			if ( CLIENT ) then
				if ( self.Charge >= 40 ) then
					EmitSound( "weapons/hwave/hwave_charge.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, 1, SNDLVL_NORM, bit.bor( SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL, SND_CHANGE_PITCH ), math.Clamp( self.Charge * 0.75, 0, 150 ) )
				end
			end
		end
	end

	if ( CLIENT ) && ( self.Owner:KeyReleased( IN_ATTACK ) ) then
		EmitSound( "common/NULL.wav", self:GetProjectileSpawnPos(), self:EntIndex(), CHAN_WEAPON, self.Owner:EntIndex(), 60, bit.bor( SND_IGNORE_NAME, SND_STOP ), math.Clamp( self.Charge * 1.25, 50, 100 ) )
	end
	
	if ( SERVER ) then
		if( self.ScifiRegenNext <= CurTime() ) && ( !self.Owner:KeyDown( IN_ATTACK ) ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) then 
				self.Weapon:SetClip1( self.Weapon:Clip1() + 1 ) 
			end
		end
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:VortexDrag( target )

	if ( !IsValid( self ) ) then return end
	if ( !IsValid( target ) ) then return end
	if ( !target:IsWeapon() ) then return end
	if ( IsValid( target:GetOwner() ) ) then return end
	
	local own_pos = self.Owner:EyePos()
	local tar_pos = target:GetPos()
	local dist = tar_pos:Distance( own_pos )
	local dir = ( tar_pos - own_pos ) * -1
	local acc = math.Round( 512 - dir:Length(), 2 ) * 0.005

	if ( SERVER ) then
		local phys = target:GetPhysicsObject()
		
		if ( !IsValid( phys ) ) then return end

		if ( target:IsNPC() ) then
			local t_health_max = target:GetMaxHealth()
			
			if ( t_health_max < 250 ) then
				target:SetPos( tar_pos + dir * 0.02 )
			end
		return end
		
		local mass = math.abs( phys:GetMass() / 50 )

		local t_class = target:GetClass()
		
		if ( t_class == "sfw_vortex_world" ) then
			DevMsg( "!Error; Vortex conflict" )
			return 
		end
		
		if ( IsValid ( target ) ) then
			local velo = ( dir * acc )
			velo = ( dir * acc )
			phys:ApplyForceOffset( velo, tar_pos )
		end
	end
	
end

function SWEP:Deploy() 

	self:StopParticles()
	self:SetAds( false )
	self:SetCharge( 0 )	
	self.ScifiRegenNext = CurTime() + 1
	
	self.SciFiState = SCIFI_STATE_IDLE
	self.SciFiMeleeCharge = 0
	
	local vm = self:GetViewModelEnt()
	if ( GetConVarNumber( "sfw_fx_particles" ) >= 1 ) && ( ( SERVER ) || ( !game.SinglePlayer() && CLIENT ) ) then
		ParticleEffectAttach( "celest_wrath_core", 4, vm, vm:LookupAttachment("muzzle") )
		mymat:SetVector( "$selfillumtint", core_color_default)
		self:SetNextCoreFxAnim( CurTime() + 2 )
	end

	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( IsValid( self.Owner ) ) && ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid( vm ) then
			self:ResetBonePositions( vm )
			
			for k,v in pairs( self.VElements ) do
				local ed = EffectData()
				ed:SetOrigin( v.pos )
				ed:SetEntity( v.modelEnt )
				util.Effect( "propspawn", ed, true, false )
			end
		end
	end

	mymat:SetVector( "$selfillumtint", core_color_blight )
	
	if ( SERVER ) || ( !game.SinglePlayer() ) then
		self:StopParticles()
	end
	
	self:ResetDeployment()
	self:SetSciFiACC( 4 )
	return true

end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( event == 6001 ) then 
		return true 
	end

	if ( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:CreateProjectile()

	local ent = ents.Create( "celest_w_pfire" )
	if ( !IsValid( ent ) ) then return end
	if ( self.SciFiState ~= SCIFI_STATE_ADS ) then
		ent:SetPos( self:GetProjectileSpawnPos() )
	else
		ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 20 ) )
	end
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:SetOwner( self.Owner )
	ent:Spawn()
	ent:Activate()
	ent:SetPhysicsAttacker( self.Owner, 10 )
	
	if ( self.Charge >= 100 ) then
		ent.UseChargeMode = true
	end

	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end
	phys:ApplyForceCenter( self.Owner:GetAimVector() * 4800 + self:GetProjectileSpreadVector() * ( 1 + self:GetSciFiACC() * 4 ) )
	
	if ( self.Owner:WaterLevel() == 3 ) then
		phys:EnableDrag( true )
		phys:SetDragCoefficient( 10000 )
	end
	
end

function SWEP:DefaultAttack()

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.2 )
	self.ScifiRegenNext = CurTime() + 1
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttach = vmEntity:LookupAttachment("muzzle")
	
	if ( self.Charge < 100 ) then
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 2 )
		end
		
		if ( SERVER ) then
			self:CreateProjectile()
		end
	
		self:DoMuzzleEffect()

		self:EmitSound( "scifi.spectra.fire2" )
		
		self:TakePrimaryAmmo( 2 )
	else
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -2, -2.4 ), math.random( 0, 0.06 ), math.random( 0, 0.06 ) ) * ( self:GetSciFiACC() * 0.2 ) )
			self:AddSciFiACC( 12 )
		end

		if ( SERVER ) then
			self:CreateProjectile()
			self:CreateProjectile()
			self:CreateProjectile()
			self:CreateProjectile()
		end
		
		ParticleEffectAttach( "drake_muzzle", 4, vmEntity, vmAttach )
		ParticleEffectAttach( "celest_wrath_pulse", 4, vmEntity, vmAttach )
		
		if ( SERVER ) || ( !game.SinglePlayer() ) then
			self:EmitSound( "scifi.ancient.bshock" )
		end

		self:TakePrimaryAmmo( 30 )
	end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:SetCharge( 0 )
	
end

function SWEP:ChargedAttack()

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	self:SetNextPrimaryFire( CurTime() + 0.32 )
	self.ScifiRegenNext = CurTime() + 1
	
	local cmdDamageAmp = GetConVarNumber( "sfw_damageamp" )
	
	local vmEntity = self:GetViewModelEnt()
	local vmAttach = vmEntity:LookupAttachment("muzzle")

	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	local myeml = {}
	myeml.Element = EML_DISSOLVE_CELESTWRATH
	myeml.Attacker = self.Owner
	myeml.Ticks = 8
	myeml.Range = 64
	myeml.DslvMaxMass = 1000
	myeml.Origin = pOwnerSP
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV
	bullet.Spread = Vector( 0, 0 )
	bullet.Tracer = 1
	bullet.TracerName = "seraph_tracer"
	bullet.Force = 1
	bullet.HullSize = 32
	bullet.Damage = 20 * cmdDamageAmp
	bullet.Distance = 786
	bullet.AmmoType = "smg1"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( DMG_SF_PHASEBLADE )
		
		myeml.Origin = tr.HitPos
		DoElementalEffect( myeml )
		
		for k,v in pairs ( ents.FindInSphere( tr.HitPos, 128 ) ) do
			if ( v:IsNPC() || v:IsPlayer() ) && ( v ~= self.Owner ) then
				self:DealAoeDamage( DMG_SF_ENERGYSHOCKWAVE, 5 + ( 0.8 * v:Health() ) * cmdDamageAmp, v:GetPos(), 1 )
				
				ParticleEffect( "item_upg_break", v:GetPos(), Angle(0,0,0) )
			end
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( SERVER ) then
		--util.ScreenShake( self:GetPos(), 256, 64, 0.8, 256)
	end
	
	if ( SERVER ) || ( !game.SinglePlayer() ) then
		self:EmitSound( "scifi.ancient.bshock" )
	end
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -6, -6 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) )
		self:AddSciFiACC( 12 )
	end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 30 )
	self:SetCharge( 0 )

end

function SWEP:PrimaryAttack()

	if ( self.Owner:IsNPC() ) then
		self:DefaultAttack()
		self:SetClip1( self.Primary.ClipSize )
	end

end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()

	if ( SERVER ) then
		self:SendWeaponAnim( ACT_VM_IDLE )
	end
	
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 255
			dlight.g = 20
			dlight.b = 20
			dlight.brightness = 5
			dlight.Decay = 512
			dlight.Size = 256
			dlight.DieTime = CurTime() + 1
		end
	end
	
	return true

end