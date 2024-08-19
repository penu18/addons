AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false

SWEP.PrintName				= "Solaris pulse rifle"
SWEP.Slot					= 2
SWEP.SlotPos				= 2
SWEP.ItemRank 				= 24

SWEP.DefaultSwayScale		= 2.4
SWEP.DefaultBobScale		= 3.2
SWEP.SprintSwayScale		= 3.5
SWEP.SprintBobScale			= 6.0
SWEP.ViewModelFOV			= 60
SWEP.Weight					= 15

SWEP.ViewModel				= "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_famas.mdl"
SWEP.HoldType 				= "ar2"
SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiSkin_1			= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

SWEP.DeploySpeed 			= 1.1

SWEP.Primary.ClipSize		= 16
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.VfxMuzzleParticle	 	= "umbra_muzzle"
SWEP.VfxMuzzleAttachment 	= "1"
SWEP.VfxMuzzleColor 		= Color( 250, 60, 45, 255 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 420
SWEP.VfxHeatParticle 		= "gunsmoke"

--SWEP.ReloadSND				= "weapons/vapor/vapor_reload.wav" 
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadTime 			= 1.8
SWEP.ReloadPlaybackRate 	= 1.6

SWEP.AdsPos 				= Vector(-7.96, -10, 1.43)
SWEP.AdsAng 				= Angle( 0, -3, -1.72 )
SWEP.AdsFov					= 48
SWEP.ViewModelHomePos		= Vector( 0, 1, 0 )
SWEP.ViewModelSprintPos 	= Vector( 3, 0.2, 0.6 )
SWEP.ViewModelSprintAng		= Angle( -15, 38, -5 )
SWEP.ViewModelMeleePos		= Vector( 18, 11, -4 )
SWEP.ViewModelMeleeAng		= Angle( -10, 85, -50 )
SWEP.ViewModelReloadAnim 	= true
SWEP.ViewModelReloadPos		= Vector( -5, -1, -12 )
SWEP.ViewModelReloadAng		= Angle( 50, -5, 15 )
SWEP.ViewModelShift 		= true
SWEP.ViewModelShiftCounter 	= 0.08
SWEP.ViewModelShiftOffset 	= Vector( -0.025, -0.02, -0.1 )
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 )

SWEP.SprintSwayScale		= 0.4
SWEP.SprintBobScale			= 0.5
SWEP.SprintAnimSpeed		= 10

SWEP.ViewModelSprintRatio 	= 0.8
SWEP.ViewModelSprintSway 	= 4

--	$basetexturetransform		"center -0.5 0.52 scale 0.75 0.75 rotate 0 translate 0 0"
SWEP.AdsRTScopeMaterial		= Material( "models/bf4/weapons/bf4_lense.vmt" )
SWEP.AdsRTScopeOffline		= "models/weapons/misc/rt_scope_offline_baset.vtf"
SWEP.AdsFov 				= 4
SWEP.AdsTransitionSpeed		= 14
SWEP.AdsRTScopeEnabled 		= true
SWEP.AdsRTScopeCompensate 	= false
SWEP.AdsRTScopeSizeX 		= 256
SWEP.AdsRTScopeSizeY 		= 256
SWEP.AdsRTScopeScaling 		= true
SWEP.AdsRTScopeOffsetX 		= 1.12
SWEP.AdsRTScopeOffsetY 		= 1.12
SWEP.AdsRTScopeScaleX 		= -0.75
SWEP.AdsRTScopeScaleY 		= 0.75

if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 6
	SWEP.AdsBlurSize			= ScrH() / 2
	SWEP.AdsMSpeedScale			= GetConVarNumber( "sfw_adsmspeedscale" ) * 0.7
end

SWEP.AdsRecoilMul 			= 0.75
SWEP.mat_laser_line = Material( "effects/laser_line_asa.vmt" )

local sightalpha = 255
local nightvision = false
local zoom_nextsetting = 0
local castshell = false
local emitchargesound = true

-- Colors for holographic sight --
local color_visor_default = Color( 255, 255, 255, 255 ) 	-- default white
local color_visor_warning = Color( 255, 45, 15, 255 ) 		-- saturated red
local color_visor_error =  Color( 255, 10, 30, 255 )		-- decent yellow

if ( CLIENT ) then
	surface.CreateFont( "asaHudSmall",
	{
		font = "Bandal",
		size = 16,
		weight = 0,
		blursize = 0,
		scanlines = 4,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = true,
		outline = false,
	})
	
	local function Circle( x, y, radius, degrees, offset )
		local segmentdist = 360 / ( 2 * math.pi * radius / 2 )

		for a = 90 + offset, ( math.abs( degrees ) + offset ) - segmentdist + 90, segmentdist do
			surface.DrawLine( x + math.cos( math.rad( a ) ) * radius, y - math.sin( math.rad( a ) ) * radius, x + math.cos( math.rad( a + segmentdist ) ) * radius, y - math.sin( math.rad( a + segmentdist ) ) * radius )
		end
	end

	local function Arc( x, y, radius, linewidth, startangle, endangle, aa, color )

		if ( startangle == endangle ) then
			return
		end
	
		if ( color ) then
			surface.SetDrawColor( color )
		end
	
		aa = aa or 1
		startangle = math.Clamp( startangle, -360, 360 ) - 90
		endangle = math.Clamp( endangle, -360, 360 ) - 90
		 
		if ( endangle < startangle ) then
			local temp = endangle
			endangle = startangle
			startangle = temp
		end

		for i=startangle, endangle, aa do
			local _i = math.rad( i )
			surface.DrawTexturedRectRotated(math.cos( _i ) * (radius - linewidth) + x,math.sin( _i ) * (radius - linewidth) + y, linewidth, aa*2, -i )
		end

	end

	local lensring = surface.GetTextureID("effects/sight_lens")
	local lensglass = surface.GetTextureID("effects/sight_glass")
	local lenswarp = surface.GetTextureID("models/weapons/asa6/sight_lens_refract") 
	local lensline = surface.GetTextureID("models/weapons/asa6/asa_hud_nv")
	
	local disp_font_small = "asaHudSmall"
	
	function SWEP.DrawScopeOverlay( ply, wep )

		local disp_color = Color( 255, 40, 20, sightalpha )
		local disp_color_noti = Color( 220, 40, 20, sightalpha )
		local clrSight = Color( 255, 80, 22, sightalpha / 2 )
		
		local midx, midy = wep.AdsRTScopeSizeX / 2, wep.AdsRTScopeSizeY / 2
		local plyETrace = ply:GetEyeTrace()
	
		local rtReso = ( wep.AdsRTScopeSizeX + wep.AdsRTScopeSizeY ) / 512
		
		local brtWorld = 0
		if ( wep.AdsRTScopeCompensate ) then
			local clrWorld = render.GetLightColor( plyETrace.HitPos ) * 100
			brtWorld = clrWorld.r + clrWorld.g + clrWorld.b
		end
		
		local lines_start = Vector( midx, midy )

		cam.Start2D()
			local pOwnerSP = ply:GetShootPos()
			local dist = pOwnerSP:Distance( plyETrace.HitPos )
			
			dist = dist * 0.016933 -- source units to meters --
			
			if ( dist >= 32768 || !isnumber( dist ) ) then
				dist = "error"
			else
				dist = math.Round( dist, 0 )
			end
			
			local ammo = wep:Clip1()
			
			local offset = 16 - ( sightalpha / 16 )

			local RadialOuter = 24 * rtReso
			local RadialInner = 80 * rtReso
			local LinearSmall = 12 * rtReso
			local LinearMedia = 32 * rtReso
			local LinearMedia2 = 40 * rtReso
			local LinearLarge = 71 * rtReso
			local LinearSpecial = 55 * rtReso
			local SpacingMedia = 36 * rtReso
			
			local punchmod = ply:GetViewPunchAngles()
			punchmod = math.abs( punchmod.pitch + punchmod.yaw + punchmod.roll ) * 8
			LinearSmall = LinearSmall + punchmod

			surface.SetDrawColor( disp_color )
			Circle( midx, midy, RadialInner, 90, 45 )
			Circle( midx, midy, RadialInner, -90, -135 )
			Circle( midx, midy, 2 * rtReso, 360, 0 )

			Arc( midx, midy, LinearSmall, rtReso, 0, 360 * ( wep.Charge / wep.ChargeMax ), 2 )

			local ammofrac = ammo / 16
			Circle( midx + offset * 2, midy, RadialInner - ( 5 * rtReso ), 90 * ammofrac, 45 )
			
			local text = "--"
			
			if ( plyETrace.Entity ) && ( !plyETrace.HitWorld ) then
				text = "*1"
				
				if ( plyETrace.HitGroup == HITGROUP_HEAD ) then
					text = "*4"
				end
			end

			render.DrawLine( lines_start - Vector( 0, LinearSmall ), lines_start - Vector( 0, RadialOuter ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 0, LinearSmall ), lines_start + Vector( 0, RadialOuter ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( LinearSmall, 0 ), lines_start - Vector( LinearMedia, 0 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( LinearSpecial , 0 ), lines_start - Vector( LinearLarge, 0 ), clrSight, false )
			render.DrawLine( lines_start + Vector( LinearSmall, 0 ), lines_start + Vector( LinearMedia, 0 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( LinearMedia2 + string.len( dist ) * LinearMedia / 4, 0 ), lines_start + Vector( LinearLarge, 0 ), clrSight, false )
			
			local firetime = ( math.max( wep:GetNextPrimaryFire() - CurTime(), 0 ) / 0.3 )
			
			if ( firetime ) then
				surface.SetDrawColor( disp_color_noti )
				Circle( midx, midy, RadialOuter - 6, ( 360 * firetime ) , 0 )
			end
			
			surface.SetFont( disp_font_small )
			surface.SetTextColor( disp_color )
			
			surface.SetTextPos( midx - 52, midy - LinearMedia / 4 )
			surface.DrawText( ammo )
			
			surface.SetTextPos( midx + SpacingMedia, midy - LinearMedia / 4 )
			surface.DrawText( dist )
			
			surface.SetTextPos( midx + SpacingMedia, midy + LinearMedia / 4 )
			surface.DrawText( text )
			
			surface.SetTextPos( midx - ( 52 * rtReso ), midy + LinearMedia / 4 )
			surface.DrawText( wep.AdsFov )
			
			surface.SetDrawColor( 1, 1, 1, 255 )
			
			surface.SetTexture( lenswarp )
			surface.DrawTexturedRect( 0, 0, wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY )
			
			surface.SetTexture( lensglass )
			surface.DrawTexturedRect( 0, 0, wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY )
			
			surface.SetDrawColor( 255 - brtWorld, 255 - brtWorld, 255 - brtWorld, 255 - brtWorld * 316 )
			surface.SetTexture( lensring )
			
			surface.DrawTexturedRect( 0, 0, wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY )

			if ( nightvision  ) then
				render.FogMaxDensity( 0 )
				surface.SetTexture( lensline )
				surface.DrawTexturedRect( 0, 0, wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY )
			end
			
			if ( plyETrace.Entity ) && ( plyETrace.Entity:IsNPC() || plyETrace.Entity:IsPlayer() ) then
				local bones = plyETrace.Entity:GetBoneCount()
				
				for bone = 1, bones-1 do
					local origin, rotation = plyETrace.Entity:GetBonePosition( bone )
					
					surface.DrawRect( origin.x, origin.y, 255, 255 ) 
				end		
			end
		cam.End2D()
	end
end

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -3, 0 ), angle = Angle( 0, 0, 0 ) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, -3, 0 ), angle = Angle( 0, 0, 0 ) },
	["v_weapon.aug_parent"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, -1 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/bf4/weapons/hk xm25.mdl", bone = "v_weapon.aug_parent", rel = "", pos = Vector(1, -3, 14), angle = Angle(-92, -2, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "", [1] = "", [2] = "", [3] = "", [4] = "", [5] = "" }, skin = 0, bodygroup = { [0] = 2, [1] = 1, [2] = 1, [3] = 1, [4] = 2, [5] = 1, [6] = 1 } },
	["6"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/bf4/weapons/hk xm25 magazine.mdl", bone = "v_weapon.aug_clip", rel = "", pos = Vector(0.5, -0.5, 7.5), angle = Angle(-92, -2, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "", [1] = "", [2] = "", [3] = "", [4] = "", [5] = "" }, skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["5"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/bf4/weapons/hk xm25.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10.5, 0.5, 1), angle = Angle(-11, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, submat = { [0] = "", [1] = "", [2] = "", [3] = "", [4] = "", [5] = "" }, skin = 0, bodygroup = { [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0 } },
}

local snd_bback = Sound( "/weapons/asa/solaris_bback.wav" )

function SWEP:SubInit()

end

function SWEP:Think()

	if ( CLIENT ) then
		local IsAds = self.SciFiState == SCIFI_STATE_ADS
		local animtime = FrameTime() * 400 * self.ChargeDeltaFactor

		if ( !isnumber( sightalpha ) ) then
			sightalpha = 0
		end
		
		if ( IsAds ) then
			if ( sightalpha < 255 ) then
				sightalpha = math.Approach( sightalpha, 255, animtime )
			end
			
			if ( !self.AdsRTDelta ) then
				self.AdsRTScopeMaterial:SetFloat( "$PhongBoost", 0.8 )
				self.AdsRTScopeMaterial:SetVector( "$EnvmapTint", Vector( .015, 0.02, .025 ) )
			end
			
			if ( !nightvision ) then
				local nwentity = self:GetNWEntity( "nvlight" )
				
				if ( IsValid( nwentity ) ) then
					nwentity:Remove()
				end
			end
		else
			if ( sightalpha > 0 ) then
				sightalpha = math.Approach( sightalpha, 0, animtime * 2 )
			end
			
			if ( self.AdsRTDelta ) then
				self.AdsRTScopeMaterial:SetFloat( "$PhongBoost", 4 )
				self.AdsRTScopeMaterial:SetVector( "$EnvmapTint", Vector( .075, .1, .125 ) )
			end
			
			local nwentity = self:GetNWEntity( "nvlight" )
			
			if ( IsValid( nwentity ) ) then
				nwentity:Remove()
			end
		end
	end

	self:Ads()
	self:Anims()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )
	
	local vm = self:GetViewModelEnt() 
	if ( IsValid( vm ) ) then 
		vm:SetPlaybackRate( 1 )
	end
		
	if( event == 5001 ) then
		return true
	end
	
	if ( event == 20 ) then
		if ( !IsValid( vm ) ) then return end

		local pOwnerEA = self.Owner:EyeAngles()
		local vmAttach = vm:LookupAttachment( "2" )
		local fxOrigin = self:GetProjectileSpawnPos() + pOwnerEA:Forward() * 24
		
		local effectdata = EffectData()
		effectdata:SetEntity( vm )
		effectdata:SetOrigin( fxOrigin )
		effectdata:SetAttachment( 2 )
		effectdata:SetAngles( pOwnerEA + Angle( -30, -90, 0 ) )
		
		util.Effect( "RifleShellEject", effectdata )
		
		return true
	end

end

function SWEP:Attack( pOwnerAV )
	
	if ( !pOwnerAV ) then
		pOwnerAV = self.Owner:GetAimVector()
	end

	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 0
	ptru.TracerName = "spr_tracer_noattach"
	ptru.Distance = 128
	ptru.AmmoType = "smg1"

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = pOwnerAV + Vector( 0, 0, self:GetSciFiACC() / 200 )
	bullet.Spread = Vector( .002, .004 ) * ( self:GetSciFiACC() * 1 )
	bullet.AmmoType = "SMG1"
	bullet.Tracer = 1
	bullet.TracerName = "emg_tracer"
	bullet.Force = 8
	bullet.HullSize = 4
	bullet.Damage = 16
	
	bullet.Callback = function( attacker, tr, dmginfo )
		local myeml = {}
		myeml.Element=EML_DISSOLVE_CELESTWRATH
		myeml.Attacker=self.Owner
		myeml.Range=4
		myeml.Ticks=1
		myeml.DslvMaxMass=500
		myeml.Origin=tr.HitPos
		
		DoElementalEffect(myeml)
		
		dmginfo:SetDamageType( DMG_SF_PHASEBLADE )

		ParticleEffect( "emg_hit", tr.HitPos, tr.Normal:Angle(), self )
	end
	
	self.Owner:FireBullets( bullet, false )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -2.1, -2.4 ), math.random( 0, 0.1 ), math.random( 0, 0.1 ) ) * ( 0.4 + self:GetSciFiACC() * 0.1 ) )
		self:AddSciFiACC( 5 )
	end

	self:DoMuzzleEffect()

	local ammo = self:Clip1()
	local iPitchMin, iPitchMax = 98, 102
	
	if ( ammo < 8 ) then
		local offset = 8 - ammo
		offset = offset * 1.5
		
		iPitchMin, iPitchMax = iPitchMin + offset, iPitchMax + offset
	end

	local pitch = math.random( iPitchMin, iPitchMax )

	self:EmitSound( "scifi.solaris.fire1" )
	
	if ( self:WaterLevel() < 3 ) then
		self:EmitSound( "scifi.solaris.echo" )
	end
	
	self:EmitSound( snd_bback, 50 + pitch * 0.25, pitch, 1, CHAN_STATIC )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )

end

function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	self:Attack()

	self:SetNextPrimaryFire( CurTime() + 0.25 )
	
end

function SWEP:NPCShoot_Primary( ShootPos, ShootDir )
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end

	if ( IsValid( self.Owner:GetEnemy() ) ) then
		ShootDir = self.Owner:GetShootPos() - self.Owner:GetEnemy():EyePos()
	end
	
--	timer.Create( "bfire" .. self:EntIndex(), 0.08, 3, function() 
--		if !( IsValid( self ) && IsValid( self.Owner ) ) then return end
		self:Attack()
--	end )

	self:SetNextPrimaryFire( CurTime() + 0.3 )

end

function SWEP:SecondaryAttack()

end

function SWEP:OnReload()
	
	if ( self:Clip1() > 0 ) then
		self.VElements["6"].bodygroup[2]=0
	else
		self.VElements["6"].bodygroup[2]=1
	end
	
end

function SWEP:OnReloadFinish()
	
	self:EmitSound( "scifi.solaris.bback" )

	self:SendWeaponAnim( ACT_VM_IDLE )

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	ParticleEffect( "umbra_hit", tr.HitPos, tr.Normal:Angle(), self )

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 255
			dlight.g = 20
			dlight.b = 10
			dlight.brightness = 0.6
			dlight.Decay = 2048
			dlight.Size = 32
			dlight.DieTime = CurTime() + 0.5
		end
	end

end