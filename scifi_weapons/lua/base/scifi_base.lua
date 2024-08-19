--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v18 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Base content and shared functions like Reload().	--
-- All scifi weapons derive information from this base.			--
-- Note, that a weapon can override a derived function.			--
-- SciFiACC management and math									--
-- coded animations.											--
-- AimDownSights mechanics and viewmodel handling.				--
------------------------------------------------------------------
-- Has to be included by a weapon via AddCSLuaFile()			--
------------------------------------------------------------------
-- soon™														--
------------------------------------------------------------------

AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )
AddCSLuaFile( "base/scifi_hooks.lua" )
include( "base/scifi_hooks.lua" )
AddCSLuaFile( "base/scifi_dropmagic.lua" )
include( "base/scifi_dropmagic.lua" )
AddCSLuaFile( "base/scifi_render.lua" )
include( "base/scifi_render.lua" )
AddCSLuaFile( "base/scifi_damage_swep.lua" )
include( "base/scifi_damage_swep.lua" )
AddCSLuaFile( "base/scifi_elementals.lua" )
include( "base/scifi_elementals.lua" )
AddCSLuaFile( "base/scifi_hud.lua" )
include( "base/scifi_hud.lua" )

SCIFI_INTEGRITY_FLAG_SWEP = 20210727213519

local m_random 			= math.random
local m_min 			= math.min
local m_max 			= math.max
local m_abs 			= math.abs
local m_pi 				= math.pi
local m_rad 			= math.rad
local m_sin 			= math.sin
local m_cos 			= math.cos
local m_tan 			= math.tan
local m_Round 			= math.Round
local m_Truncate 		= math.Truncate
local m_Clamp 			= math.Clamp
local m_Approach 		= math.Approach
local m_AngleDifference = math.AngleDifference

local SCIFI_STATE_IDLE = 0
local SCIFI_STATE_SPRINT = 1
local SCIFI_STATE_ADS = 2
local SCIFI_STATE_MELEE_ATTACK = 3
local SCIFI_STATE_MELEE_RETIRE = 4
local SCIFI_STATE_RELOADING = 5

SWEP.Base 					= "weapon_base"
SWEP.SciFiState 			= false

SWEP.Author					= "Darken217"
SWEP.Category				= "Darken217's SciFi Armory"

SWEP.LastOwner 				= nil

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.AdminOnly				= false
SWEP.UseHands				= true

SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= false
SWEP.DrawAmmo				= true
SWEP.DrawWeaponInfoBox		= true

SWEP.PrintName 				= "Yet another sci-fi weapon"
SWEP.Purpose				= "[PLACEHOLDER]"
SWEP.Instructions			= "[PLACEHOLDER]"

-- sneaking in experimental TTT support --
SWEP.Kind = WEAPON_HEAVY
SWEP.CanBuy = { } -- ROLE_TRAITOR, ROLE_DETECTIVE }
SWEP.WeaponID = 0

SWEP.NpcSpawnFlags 			= { SF_NPC_LONG_RANGE } --, SF_NPC_ALWAYSTHINK }

if ( SERVER ) then
	SWEP.NpcCapabilitiesOverride = false
	
	SWEP.NpcCapabilities 		= bit.bor(
		CAP_MOVE_SHOOT,
		CAP_MOVE_CRAWL,
		CAP_MOVE_FLY,
		CAP_MOVE_JUMP,
		CAP_MOVE_SWIM,
		CAP_MOVE_CLIMB,
		CAP_MOVE_GROUND,
		-- CAP_SKIP_NAV_GROUND_CHECK,
		CAP_SQUAD,
		CAP_DUCK,
		
		CAP_OPEN_DOORS,
		CAP_AUTO_DOORS,
		CAP_USE,
		CAP_USE_WEAPONS,
		CAP_ANIMATEDFACE,
		CAP_TURN_HEAD,
		CAP_AIM_GUN,
		-- CAP_USE_SHOT_REGULATOR,
		
		CAP_WEAPON_RANGE_ATTACK1,
		-- CAP_INNATE_RANGE_ATTACK1,
		CAP_WEAPON_RANGE_ATTACK2,
		-- CAP_INNATE_RANGE_ATTACK2,
		-- CAP_SIMPLE_RADIUS_DAMAGE,
		-- CAP_WEAPON_MELEE_ATTACK1,
		CAP_INNATE_MELEE_ATTACK1,
		-- CAP_WEAPON_MELEE_ATTACK2,
		-- CAP_INNATE_MELEE_ATTACK2,
		
	--	CAP_FRIENDLY_DMG_IMMUNE,
	--	CAP_NO_HIT_PLAYER,
		CAP_NO_HIT_SQUADMATES
	)
end

if ( CLIENT ) then
   SWEP.DrawCrosshair   = true
   SWEP.ViewModelFlip   = false
-- SWEP.CSMuzzleFlashes = true
end

function SWEP:GetHeadshotMultiplier()
	return 2
end

SWEP.ViewModel				= "models/weapons/c_smg1.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.HoldType 				= "smg"
SWEP.HoldTypeNPC 			= "smg"
SWEP.HoldTypeAnimationOverride = true
SWEP.HoldTypeZombie 		= "zombie"
SWEP.HoldTypeSprint 		= "passive"
SWEP.DeploySpeed 			= 3
SWEP.UseSCK 				= true							-- Disable SCK components. This is really only usefull if you have a fully intact view-/worldmodel and want to save performance on all ends.

SWEP.SciFiSkin				= ""
SWEP.SciFiSkin_1			= ""
SWEP.SciFiSkin_2			= ""
SWEP.SciFiSkin_3			= ""
SWEP.SciFiSkin_4			= ""
SWEP.SciFiWorld 			= ""

SWEP.DefaultSwayScale		= 1.6
SWEP.DefaultBobScale		= 2.4
SWEP.SprintSwayScale		= 0
SWEP.SprintBobScale			= 0
SWEP.ViewModelFOV			= 54
SWEP.Weight					= 5

if ( CLIENT ) then
	SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_custom.vmt" )
end

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
															-- Muzzle effect data. Create an effect by calling SWEP.DoMuzzleEffect() or the effect sfw_muzzle_generic. See below for details.
SWEP.VfxMuzzleAttachment 	= "muzzle"						-- What attachment point you want to use for the muzzle effect. This is the attachment's name, NOT the attachment ID.
SWEP.VfxMuzzleAttachment2 	= "muzzle"						-- A fallback variant which can be used for world models and or when the 1st attachment should turn out to be invalid.
SWEP.VfxMuzzleParticle 		= "ngen_muzzle"					-- The particle effect you want to use.
SWEP.VfxMuzzleRule 			= 3								-- Muzzle flash light rule. 0 = No flash (will disable muzzle flash lights, particles will still be used, unless undefined), 1 = Dynamic Light, 2 = Projected texture (cheap, no shadows), 3 = Projected texture. This gets limited by the clients performance options.
SWEP.VfxMuzzleColor 		= Color( 200, 170, 255, 220 )	-- Color of the muzzle light flash.
SWEP.VfxMuzzleBrightness 	= 1								-- Brightness multiplier.
SWEP.VfxMuzzleFarZ 			= 540							-- Sets the range of the muzzleflash.
SWEP.VfxMuzzleFOV 			= 160							-- Sets the angular width of the muzzleflash. (projected texture only!)
SWEP.VfxMuzzleProjexture 	= "effects/mf_light"			-- What texture should be used for muzzlflash projections. Keep in mind, although the TEXTURE is used, a material (.vmt) should be present as well. (projected texture only!)
SWEP.VfxHeatForce 			= false							-- Force heat or smoke effects, even though sfw_fx_heat is 0.
SWEP.VfxHeatParticle 		= "nrg_heat" --"gunsmoke"		-- What heat particle you want to use.
SWEP.VfxHeatThreshold 		= 0.75							-- Percentage of the SciFiACC level (default: max. 30) above which each muzzle event which create a heat effect.
SWEP.VfxHeatDelay 			= 0								-- Hard delay until the next heat effect can be created.

SWEP.SciFiWorldStats		= nil --{ ["1"] = { text = "A scifi weapon", color = Color( 180, 180, 180 ) } } -- Inspection text. If this is nil, instructions and purpose will be used.

SWEP.SciFiACC				= 2
SWEP.SciFiACCRecoverRate	= 0.2							-- How fast the weapon recoveres from recoil or overheat. Increase by using self:AddSciFiACC( <num> ).
SWEP.AdsRecoilMul			= 0.8
SWEP.MidairRecoilMul		= 1.2

SWEP.CrouchRecoilMul 		= 0.9

SWEP.FeelGoodEnabled 		= false							-- Aim-assist.
SWEP.FeelGoodRatio 			= 0.1							-- How strong aim-assist should tilt the current bullet vector toward the desired target vector. 0 = No change, 1 = Perfect magnetism.
SWEP.FeelGoodHullEnabled 	= false							-- When enabled, aim-assist will use a seperate hull trace instead of relying on the player's eyetrace to achieve a more forgiving result. Keep in mind, that this is a seperate trace-cast, thus more performance intensive.
SWEP.FeelGoodHullSize 		= 3 							-- Trace hull size.
SWEP.FeelGoodPunchPower 	= 0.05 							-- How much kick / view punch should effect aim assistance. 0 = No effect, 1 = Full effect. Note, that the accumulative punch power of the kick can often exceed 1, thus the use of small values is recommended.
SWEP.FeelGoodScaleHip		= 0.5							-- Multiplies the aim assistance by this factor when hipfiring. 1 = No effect, 0 = disables aim-assist while hip-firing.
SWEP.FeelGoodScaleAir 		= 0.5							-- Multiplies the aim assistance by this factor while mid-air (not on solid ground).

SWEP.ProjectileOffset 		= Vector( 8, -10 ) 				-- Offset used for realistic projectile spawn offset.
SWEP.ProjectileOffsetNPC 	= Vector( 2, -20 )				-- NPC exclusive variant of the above.
SWEP.ProjectileSpreadY 		= Vector( -5, 5 )				-- Projectile base horizontal spread.
SWEP.ProjectileSpreadZ 		= Vector( -2, 10 )				-- Same as above, but vertical.

SWEP.NPCAccuracy 			= 1400 							-- Arbitrary multiplier to NPC accuracy. Higher makes it less accurate.
SWEP.NPCSkillLevel 			= 1 							-- Base skill with this weapon to average NPC skill against. Lower values mean higher base skill / lower skill requirement.
SWEP.NPCAimVectorOverride 	= Vector( 0, 0, 0 )				-- Will be set when a NPC fires a weapon. Allows for accuracy fine-tuning to the point of pin-point accuracy.
SWEP.NPCLeadTarget	 		= false							-- Whether or not the NPC should attempt to lead the target based on the target's velocity. Only useful for projectile weapons.
SWEP.NPCLeadPower 			= 0.15
SWEP.NPCBulletSpread 		= 4								-- NPC Bullet spread in degrees. This is used for calculating the NPCs artifical inaccuracy. It is handled by the NPC, whereas the system above is handled by the weapon.
SWEP.NPCRestMin 			= 0.3							-- Minimal time the NPC will hold fire during combat (resting)
SWEP.NPCRestMax 			= 0.6							-- Maximum time the NPC will hold fire during combat 
SWEP.NPCBurstMin 			= 1 							-- Minimum amount of shots fired during attack, before "resting" (see above)
SWEP.NPCBurstMax 			= 2								-- Maximum amount of shots fired during attack
SWEP.NPCBurstDelay 			= 0.2							-- Delay in-between shots within a single attack. Note, this is NOT burst fire as a weapon firemode, but how the NPC will attempt to use the weapon. I.e. pop out of cover, pull the trigger 1 to 3 times with 0.1 seconds between trigger-pulls before going back to cover.

SWEP.Charge 				= 0
SWEP.ChargeMax				= 100
SWEP.ChargeAdd				= 1
SWEP.ChargeDrain			= 1
SWEP.ChargeDeltaCompensate 	= true
SWEP.ChargeDeltaFactor 		= 1

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeRecoverTime 	= 0.32
SWEP.SciFiMeleeASpeed		= 0.6
SWEP.SciFiMeleeRange		= 60
SWEP.SciFiMeleeDamage		= 8
SWEP.SciFiMeleeDamageType	= bit.bor( DMG_CLUB, DMG_NEVERGIB )
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"
SWEP.SciFiMeleeHitWorld 	= "scifi.melee.hit.world"
SWEP.SciFiMeleeHitBody 		= "scifi.melee.hit.body"
SWEP.SciFiMeleeChargeMax	= 100

SWEP.AdsPos 				= Vector( -2, 1, -1 )
SWEP.AdsAng 				= Vector( 0, 0, 0 )
SWEP.AdsFov					= 40
SWEP.AdsFovTransitionTime	= 0.16
SWEP.AdsFovCompensation 	= 0.2
SWEP.AdsTransitionAnim		= true
SWEP.AdsTransitionSpeed		= 22
SWEP.AdsTransitionScale 	= 0 -- Will be set automatically.
SWEP.AdsBlur 				= true
if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 6
	SWEP.AdsBlurSize			= ScrH() / 3
	SWEP.AdsMSpeedScale			= GetConVar( "sfw_adsmspeedscale" ):GetFloat()
	SWEP.AdsFovToMouseSens 		= false
end
SWEP.AdsSounds 				= false							-- Whether or not sound effects should be played when zooming in/out with the weapon.
SWEP.AdsSoundEnable 		= "scifi.ancient.sight.turnon"
SWEP.AdsSoundDisable		= "scifi.ancient.sight.turnoff"
SWEP.AdsViewModelHideThreshold = 0.72						-- How high fAnimAds needs to be in order to NOT draw the viewmodel and display the scope overlay, in case RT-Scopes are disabled.
SWEP.AdsRTScopeEnabled 		= false							-- Enables render-target scopes, making the settings below relevant.
SWEP.AdsRTDelta 			= false
SWEP.AdsRTScopeCompensate 	= false 						-- Adjust the brightness of the scope to match that of the world. (brighter in dark places and the other way around).
SWEP.AdsRTScopeSizeX 		= 512							-- Resolution of the desired render target.
SWEP.AdsRTScopeSizeY 		= 512
SWEP.AdsRTScopeScaling 		= false							-- Enables post-creation scaling within the rt-scope's material. This does NOT change the internal RT resolution, it just stretches it.
SWEP.AdsRTScopeOffsetX 		= 1
SWEP.AdsRTScopeOffsetY 		= 1
SWEP.AdsRTScopeScaleX 		= 1 							-- You can use a scale of -1 to mirror the texture. Useful in some cases.
SWEP.AdsRTScopeScaleY 		= 1
SWEP.AdsRTScopeMaterial		= Material( "models/weapons/misc/rt_scope.vmt" ) -- The material you want to write the render target into.
SWEP.AdsRTScopeOffline		= "models/weapons/misc/rt_scope_offline_baset.vtf" -- The texture used instead of the render target when in idle (not aiming down sights).
SWEP.AdsRTScopeTarget 		= "$basetexture" 				-- The texture value you want to overwrite. This can technically be any texture value, i.e. $basetexture, $selfillummask, $detail, etc...
SWEP.AdsRTToneMap 			= true 							-- Internally rebalance tone mapping on HDR maps to prevent overbrighting.
SWEP.AdsRTToneMapBalance 	= 2								-- The target tonemap scale the screen should be balanced to.

SWEP.SafeModeOnSnd 	 		= "scifi.safe.on"				-- Sound to be played when switching weapon safety.
SWEP.SafeModeOffSnd 		= "scifi.safe.off"

SWEP.ViewModelIdleAnim 		= true							-- Play idle (i.e. breathing) animations while in idle state
SWEP.ViewModelIdleSequence 	= ACT_VM_IDLE 					-- There is no point in changing this, as it'll be overwritten anyway.
SWEP.ViewModelHomePos		= Vector( 0, 0, 0 )
SWEP.ViewModelHomeAng		= Angle( 0, 0, 0 )

SWEP.SprintAnim				= true							-- Apply bob- and sway modulation while sprinting.
SWEP.SprintAnimIdle			= false 						-- Currently ( june, 4th 2017 ) bugged as it resets to the last used sequence instead of the given one.
SWEP.SprintAnimSpeed		= 8								-- Transition speed from "idle" to "sprint" animation. Does NOT affect how fast you switch from "idle" to "sprint" state internally, just how quick the animations transition.

SWEP.ViewModelSprintPos		= Vector( 5, 0.2, 0.6 )			-- Desired viewmodel offset while sprinting.
SWEP.ViewModelSprintAng		= Angle( -10, 34, -15 )			-- Desired viewmodel rotation while sprinting.
SWEP.ViewModelSprintRatio 	= 0.8							-- Extra viewmodel sway frequency.
SWEP.ViewModelSprintSway 	= 3								-- Extra sway intensity.
SWEP.ViewModelSwayDirection = Vector( -0.4, 7, 0.1 )		-- How much the viewmodel should sway from side to side, relatively to its origin when sprint sway is above 1.
SWEP.ViewModelSwayStrength 	= Vector( 0.4, 0.11 )			-- How much the viewmodel should be titled while swaying. This is more to create a feel of weight in the sprinting animation and can be just left at the default values.
SWEP.ViewModelShift 		= true							-- Manipulate the sprint offset and rotation while looking downwards.
SWEP.ViewModelShiftCounter 	= 0.2							-- Multiplier to blend the default sprint rotation into shift rotation.
SWEP.ViewModelShiftOffset 	= Vector( 0.01, -0.04, -0.09 ) 	-- Coordinate system is z-top and y-depth. Will be applied on top of sprint modulations when looking down.
SWEP.ViewModelShiftRotation = Vector( 0.2, 0.6, 1 ) 		-- Translates into pitch, yaw and roll.
SWEP.ViewModelMoveBob 		= true

SWEP.ViewModelDuckPos		= Vector( -1, -1, 1 ) 			-- '' while crouching
SWEP.ViewModelDuckAng		= Angle( 0, 0, -5 )				--
SWEP.ViewModelMeleePos		= Vector( 20, 12, -3 )			-- Viewmodel position offset while performing a quick fAnimMelee. The negative will be used while charing / drawing back.
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -60 )			-- '' rotation for the above.

SWEP.ViewModelInspectable 	= true							-- Is the weapon inspectable and should the viewmodel be turned around during inspection?
SWEP.ViewModelMenuPos		= Vector( 12, 3.2, -6 )
SWEP.ViewModelMenuAng		= Angle( 20, 35, -10 )

SWEP.ViewModelReloadAnim 	= false							-- Apply offset and rotation while weapon is in "reloading" state. (SCIFI_STATE_RELOADING)
SWEP.ViewModelReloadPos		= Vector( -1, -1, 0 )
SWEP.ViewModelReloadAng		= Angle( -2, 2, 0 )
SWEP.ViewModelReloadAnimSpeed = 4

SWEP.ViewModelSafeAnim 		= false							-- Modulate viewmodel position / rotation, when safety is on. Use this only, if the viewmodel doesn't support the lowered idle animation, i.e. for CSS weapons.
SWEP.ViewModelSafePos 		= Vector( 0, 0, 0 )
SWEP.ViewModelSafeAng 		= Angle( 0, 0, 0 )

SWEP.ReloadLegacy 			= true 							-- Use default method to cast reload times / animation events. Set this to 'false' if you wish to properly adjust reload speed or cancel reload events on the fly.
SWEP.ReloadOnTrigger 		= true							-- Automatically perform the reload action when pulling the trigger on an empty weapon.
SWEP.ReloadRealisticClips 	= false							-- When reloading manually (hit the reload key), any ammo remaining in the ejected clip will be lost.
SWEP.ReloadTime				= 2.2							-- How long you'll have to wait until the weapon tries to revert back to the "idle" state. This may be overriden by the view model's reload sequence's durtation.
SWEP.ReloadSND				= "Weapon_SMG1.Reload"			-- Sound to be played while reloading. Set this to nil or "" to play nothing.
SWEP.ReloadACT				= ACT_VM_RELOAD					-- ACT_ index (sequence) to be send to the viewmodel while reloading. This doesn't neccessarily need to be ACT_VM_RELOAD.
SWEP.ReloadPlaybackRate 	= 1								-- Reload animation playback speed. Should be adjusted along with SWEP.ReloadTime.
SWEP.ReloadAnimEndIdle 		= false							-- Trigger ACT_VM_IDLE upon finishing the reload event.
SWEP.ReloadModels 			= false							-- Create a prop upon reloading, simulating an ejected, empty clip.
SWEP.ReloadGib 				= "models/dav0r/hoverball.mdl"	-- The model of the clip.
SWEP.ReloadGibMaterial 		= ""							-- Material override. Use "" if you want to use the default.
SWEP.ReloadGibMass 			= nil							-- Mass override. Using nil will not change the mass at all.
SWEP.ReloadGibSize 			= 1								-- Model scale. May also apply to collision mesh.
SWEP.ReloadGibParentBone	= "ValveBiped.Bip01_R_Hand"		-- Parent bone to derive gib spawn position from.
SWEP.ReloadGibOrigin		= Vector( 0, 0, 0 )				-- Offset from parent bone.
SWEP.ReloadGibDelay 		= 0.2							-- Delay (in seconds) starting from the moment the reload was triggered.

SWEP.DepletedSND			= "Weapon_Pistol.Empty" 		-- Sound to be played when pulling the trigger on an empty weapon/clip.

SWEP.SciFiFamily = {} -- Deprecated

SWEP.DataTables = {} 										-- Define custom data table entries here. (see: http://wiki.garrysmod.com/page/WEAPON/SetupDataTables ). Do NOT overwrite the SWEP.SetupDataTables function, unless you really need to / know what you're doing.
--[[
	Example: 
	
	SWEP.DataTables = {
		{ dType = "Bool", dName = "TestMode" },
		{ dType = "Int", dName = "TestValue" }
	}
	
	would create SWEP.SetTestMode( <bool> ) and SWEP.SetTestValue( <int> )
--]]

SWEP.RandomSkins 			= true 							-- Don't touch this. It's a cheap hotfix to prevent addon conflicts.

SWEP.mat_laser_line = Material( "effects/laser_line.vmt" )
SWEP.mat_laser_haze = Material( "effects/laser_haze.vmt" )
SWEP.mat_laser_glow = Material( "effects/blueflare1.vmt" )

local cmd_actualspawnoffset 		= GetConVar( "sfw_allow_actualspawnoffset" )
local cmd_staticspawnoffset 		= GetConVar( "sfw_allow_staticspawnoffset" )
local cmd_recoiltoaimvector 		= GetConVar( "sfw_allow_recoiltoaimvector" )
local cmd_allow_npccompatibility 	= GetConVar( "sfw_allow_npccompatibility" )
local cmd_advanims 					= GetConVar( "sfw_allow_advanims" )
local cmd_debug_showanimscaling 	= GetConVar( "sfw_debug_showanimscaling" )
local cmd_debug_showaavectors 		= GetConVar( "sfw_debug_showaimassist" )
local cmd_engine_fovdesired 		= GetConVar( "fov_desired" )
local cmd_fx_heat 					= GetConVar( "sfw_fx_heat" )
local cmd_fx_muzzlelights 			= GetConVar( "sfw_fx_muzzlelights" )
local cmd_fx_particles 				= GetConVar( "sfw_fx_particles" )
local cmd_fx_suppressonzoom 		= GetConVar( "sfw_fx_suppressonzoom" )
local cmd_kb_inspect 				= GetConVar( "sfw_kb_inspect" )
local cmd_legacyzoom 				= GetConVar( "sfw_allow_legacyzoom" )
local cmd_maxacc 					= GetConVar( "sfw_sk_maxacc" )
local cmd_viewbob 					= GetConVar( "sfw_allow_viewbob" )
local cmd_sboxhints 				= GetConVar( "cl_showhints" )
local cmd_autodestroysck 			= GetConVar( "sfw_allow_sck_autocleanup" )
local cmd_rtsniperscopes 			= GetConVar( "sfw_allow_rtsniperscopes" )
local cmd_toggleaim 				= GetConVar( "sfw_toggleaim" )
local cmd_adsmspeedscale 			= GetConVar( "sfw_adsmspeedscale" )
local cmd_adsadativesens 			= GetConVar( "sfw_adsmspeedadaptive" )

local iSprintSpeed
local dSprintSpeed
local fAnimMenu = 0
local fAnimSprint = 0
local fAnimCrouch = 0
local fAnimMelee = 0
local fAnimAds = 0
local fAnimReload = 0
local fAnimSafety = 0
local fSprintMod = 0
local vSway = Vector( 0, 0, 0 )
local aSway = Angle( 0, 0, 0 )
local aDiff = Angle( 0, 0, 0 )

local vMoveBob, aMoveBob = Vector( 0, 0, 0 ), Angle( 0, 0, 0 )
local vecSprint = Vector( 0, 0, 0 )
local angSprint = Angle( 0, 0, 0 )
local angDelta = Angle( 0, 0, 0 )
local pVeloMax
	
function SWEP:GetAmmoNature()
	
	local aTypeP = self.Primary.Ammo
	
	if ( !isstring( aTypeP ) ) then
		return false
	end 
	
	if ( isnumber( aTypeP ) && aTypeP <= 0 ) then
		return false
	end
	
	if ( aTypeP == "" ) || ( aTypeP == "SciFiEnergy" ) then
		return false
	end
	
	return true
	
end

if ( CLIENT ) then

	local function Circle( x, y, radius, degrees, offset, startoffset )
		local segmentdist = 360 / ( 2 * m_pi * radius * 0.25 )
		
		if ( !startoffset ) then
			startoffset = 0
		end
		
		if ( !offset ) then
			offset = 0
		end

		for a = 0 + offset, ( -startoffset + m_abs( degrees ) + offset ) - segmentdist + startoffset, segmentdist do
			surface.DrawLine( x + m_cos( m_rad( a ) ) * radius, y - m_sin( m_rad( a ) ) * radius, x + m_cos( m_rad( a + segmentdist ) ) * radius, y - m_sin( m_rad( a + segmentdist ) ) * radius )
		end
	end

	local lensring = surface.GetTextureID("effects/sight_lens")
	local lenswarp = surface.GetTextureID("effects/sight_lens_refract") 
	local lensglass = surface.GetTextureID("effects/sight_glass")
	
	function SWEP.PreDrawRTScope( entPlayer, entWeapon, vSway, aSway )
	
	end

	function SWEP.DrawScopeOverlay( entPlayer, entWeapon )
		local midx, midy = entWeapon.AdsRTScopeSizeX * 0.5, entWeapon.AdsRTScopeSizeY * 0.5
		local plyETrace = entPlayer:GetEyeTrace()

		local fOverlayAnchorX, fOverlayAnchorY = 0, 0
		local fOverlaySizeX, fOverlaySizeY = entWeapon.AdsRTScopeSizeX, entWeapon.AdsRTScopeSizeY
		
		if ( !cmd_rtsniperscopes:GetBool() ) then
			midx, midy = ScrW() * 0.5, ScrH() * 0.5
		
			fOverlaySizeX, fOverlaySizeY = ScrH(), ScrH()
			fOverlayAnchorX, fOverlayAnchorY = ScrW() * 0.5 - ScrH() * 0.5, 0
		
			surface.DrawRect( 0, 0, fOverlayAnchorX, fOverlaySizeY * 2 )
			surface.DrawRect( fOverlayAnchorX + fOverlaySizeX * 2, 0, ScrW(), ScrH() )
		end
		
		local clrSight = Color( 200, 15, 10, 128 )
		local lines_start = Vector( midx, midy )
		
		cam.Start2D()
			draw.NoTexture()
			surface.SetDrawColor( 255, 10, 30, 255 )
			Circle( midx, midy, 1, 360 )
			
			render.DrawLine( lines_start - Vector( 0, 16 ), lines_start - Vector( 0, 46 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 0, 16 ), lines_start + Vector( 0, 46 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, 0 ), lines_start - Vector( 128, 0 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 0 ), lines_start + Vector( 128, 0 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, -16 ), lines_start - Vector( 64, -16 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 16 ), lines_start + Vector( 64, 16 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, -32 ), lines_start - Vector( 32, -32 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 32 ), lines_start + Vector( 32, 32 ), clrSight, false ) 
			
			surface.SetDrawColor( 1, 1, 1, 255 )
			surface.SetTexture( lenswarp )
			surface.DrawTexturedRect( fOverlayAnchorX, fOverlayAnchorY, fOverlaySizeX, fOverlaySizeY )
			
			if ( entWeapon.AdsRTScopeCompensate ) then
				local clrWorld = render.GetLightColor( plyETrace.HitPos ) * 100
				local brtWorld = clrWorld.r + clrWorld.g + clrWorld.b

				surface.SetDrawColor( 255 - brtWorld, 255 - brtWorld, 255 - brtWorld, 255 - brtWorld * 316 )
			end

			surface.SetTexture( lensglass )
			surface.DrawTexturedRect( fOverlayAnchorX, fOverlayAnchorY, fOverlaySizeX, fOverlaySizeY )
			surface.SetTexture( lensring )
			surface.DrawTexturedRect( fOverlayAnchorX, fOverlayAnchorY, fOverlaySizeX, fOverlaySizeY )
			surface.DrawTexturedRect( fOverlayAnchorX - aSway.yaw * 12, fOverlayAnchorY + aSway.pitch * 12, fOverlaySizeX - aSway.yaw * 12, fOverlaySizeY + aSway.pitch * 12 )
		cam.End2D()
	end
	
-- local oldRT
	local entPlayer, entWeapon
	local function DrawRTScope()
		if ( !cmd_rtsniperscopes:GetBool() ) then return end
		
		entPlayer = LocalPlayer()
	
		if ( !entPlayer ) || ( entPlayer && !entPlayer:Alive() ) then return end
		if ( entPlayer:ShouldDrawLocalPlayer() ) then return end
		
		if ( IsValid( entPlayer ) ) then
			entWeapon = entPlayer:GetActiveWeapon()
		end
		
		if ( !IsValid( entWeapon ) ) then return end
		if ( !entWeapon.AdsRTScopeEnabled ) then return end
	
		local mat_scope = entWeapon.AdsRTScopeMaterial
		local IsAds = entWeapon.SciFiState == SCIFI_STATE_ADS
	
		if ( IsAds ) then
			if ( !entWeapon.AdsRT ) then
				-- from Valve's dynamic scope tutorial: https://developer.valvesoftware.com/wiki/Adding_a_Dynamic_Scope
				
				entWeapon.AdsRT = GetRenderTargetEx( 
					"_rt_Scope", 
					entWeapon.AdsRTScopeSizeX, 
					entWeapon.AdsRTScopeSizeY, 
					RT_SIZE_LITERAL,
					MATERIAL_RT_DEPTH_SHARED,
					bit.bor( 0x0004, 0x0008, 0x8000, 0x0010, 0x0100, 0x0200 ),
					bit.bor( CREATERENDERTARGETFLAGS_HDR, CREATERENDERTARGETFLAGS_AUTOMIPMAP ),
					IMAGE_FORMAT_DEFAULT
				)

				-- entWeapon.AdsRT = GetRenderTarget("sfw_scope_rt", entWeapon.AdsRTScopeSizeX, entWeapon.AdsRTScopeSizeY, false)
			end
			
		-- oldRT = render.GetRenderTarget()
					
			local x, y = ScrW(), ScrH()
			
			entWeapon.AdsRTScopeSizeX = m_min( entWeapon.AdsRTScopeSizeX, x )
			entWeapon.AdsRTScopeSizeY = m_min( entWeapon.AdsRTScopeSizeY, y )
			
			local newrt = {}
			newrt.angles = aEyes
			newrt.origin = entPlayer:GetShootPos()
			newrt.x = 0
			newrt.y = 0
			newrt.w = entWeapon.AdsRTScopeSizeX
			newrt.h = entWeapon.AdsRTScopeSizeY
			newrt.fov = entWeapon.AdsFov
			newrt.drawviewmodel = false
			newrt.drawhud = false
			-- newrt.dopostprocess = false
			-- newrt.bloomtone = false
			
			-- render.SetRenderTarget( entWeapon.AdsRT )

			render.PushRenderTarget( entWeapon.AdsRT, 0, 0, entWeapon.AdsRTScopeSizeX, entWeapon.AdsRTScopeSizeY )
			
			local aPunch = entPlayer:GetViewPunchAngles()
			
			local aEyes = entPlayer:EyeAngles() + aPunch * 0.5
			aEyes:RotateAroundAxis( aEyes:Forward(), -1 )
			
			entWeapon.PreDrawRTScope( entPlayer, entWeapon, vSway, aSway )
			
			render.SetViewPort( 0, 0, entWeapon.AdsRTScopeSizeX, entWeapon.AdsRTScopeSizeY )
			render.Clear( 0, 0, 0, 0, true, true )
			render.ClearRenderTarget( entWeapon.AdsRT, color_white )
	
			if ( entWeapon.AdsRTToneMap ) then
				local fToneMapScale = GetConVar( "mat_hdr_tonemapscale" ):GetFloat()
				local fToneMapBalance = entWeapon.AdsRTToneMapBalance / fToneMapScale

				render.SetGoalToneMappingScale( fToneMapScale * fToneMapBalance )
			end
			
			render.RenderView( newrt )

			entWeapon.DrawScopeOverlay( entPlayer, entWeapon, vSway, aSway )
			
			if ( entWeapon.AdsTransitionScale < 0.975 ) then
				local scale = 1 - ( 0.975 / entWeapon.AdsTransitionScale )
				scale = scale * scale
				scale = m_min( 1, scale )
			
				surface.SetDrawColor( 0, 0, 0, 255 * scale )
				-- surface.SetTexture( surface.GetTextureID( entWeapon.AdsRTScopeOffline ) )

				-- surface.DrawTexturedRect( -entWeapon.AdsRTScopeSizeX, -entWeapon.AdsRTScopeSizeY, entWeapon.AdsRTScopeSizeX * 2, entWeapon.AdsRTScopeSizeY * 2 )
				surface.DrawRect( -entWeapon.AdsRTScopeSizeX, -entWeapon.AdsRTScopeSizeY, entWeapon.AdsRTScopeSizeX * 2, entWeapon.AdsRTScopeSizeY * 2 )
			end
	
			render.SetViewPort( 0, 0, x, y )
			render.SetScissorRect( 0, 0, x, y )
			render.PopRenderTarget()
			
			-- render.SetRenderTarget( oldRT )
			
			-- render.Clear( 0, 0, 0, 255, true, true )
			
			if ( !entWeapon.AdsRTDelta && mat_scope ) then
				mat_scope:SetTexture( entWeapon.AdsRTScopeTarget, entWeapon.AdsRT )
				
				if ( entWeapon.AdsRTScopeScaling ) then
					local OffX, OffY = entWeapon.AdsRTScopeOffsetX, entWeapon.AdsRTScopeOffsetY
					local ScaleX, ScaleY = entWeapon.AdsRTScopeScaleX, entWeapon.AdsRTScopeScaleY

					local matrix = Matrix()
					matrix:Translate( Vector( OffX, OffY ) )
					matrix:Scale( Vector( ScaleX, ScaleY ) )
					
					mat_scope:SetMatrix( "$basetexturetransform", matrix )
				else
					mat_scope:SetUndefined( "$basetexturetransform" )
				end
			end
			
			entWeapon.AdsRTDelta = true
		else 
			if ( entWeapon.AdsRTDelta && mat_scope ) then
				mat_scope:SetTexture( "$basetexture", entWeapon.AdsRTScopeOffline )
			end
			
			entWeapon.AdsRTDelta = false
		end	
	end

	-- hook.Remove( "PreRender", "SciFiBaseDrawRTScope" )
	-- hook.Remove( "RenderScene", "SciFiBaseDrawRTScope" )
	-- hook.Remove( "PreDrawEffects", "SciFiBaseDrawRTScope" )
	-- hook.Remove( "DrawWorld", "SciFiBaseDrawRTScope" )
	hook.Add( "RenderScene", "SciFiBaseDrawRTScope", DrawRTScope )

	function SWEP:CustomAmmoDisplay()
		self.AmmoDisplay = self.AmmoDisplay || {}
		self.AmmoDisplay.Draw = true
		
		if ( self.Primary.ClipSize > 0 ) && ( self:GetAmmoNature() ) then
			self.AmmoDisplay.PrimaryClip = self:Clip1()
			self.AmmoDisplay.PrimaryAmmo = self:Ammo1()
		else
			self.AmmoDisplay.PrimaryClip = self:Clip1()
			self.AmmoDisplay.PrimaryAmmo = -1
		end
			
		if ( self.Secondary.ClipSize > 0 ) && !( self.Primary.Ammo == "" || self.Primary.Ammo == "none" ) then
			self.AmmoDisplay.SecondaryClip = self:Clip2()
			self.AmmoDisplay.SecondaryAmmo = self:Ammo2()
		else
			self.AmmoDisplay.SecondaryClip = -1
			self.AmmoDisplay.SecondaryAmmo = -1
		end

		return self.AmmoDisplay
	end

end

function SWEP:DrawHudOverlay()

	if ( self.AdsRTScopeEnabled && !cmd_rtsniperscopes:GetBool() && self:GetSciFiState() == SCIFI_STATE_ADS && fAnimAds > self.AdsViewModelHideThreshold ) then
		
		self.PreDrawRTScope( self:GetOwner(), self, vSway, aSway )
		
		local fOverlaySizeX, fOverlaySizeY = ScrH() * 0.5, ScrH() * 0.5
		local fOverlayAnchorX, fOverlayAnchorY = ScrW() * 0.5 - ScrH() * 0.5, 0
		
		draw.NoTexture()
		surface.SetDrawColor( 0, 0, 0, 255 )
	
		surface.DrawRect( 0, 0, fOverlayAnchorX, fOverlaySizeY * 2 )
		surface.DrawRect( fOverlayAnchorX + fOverlaySizeX * 2, 0, ScrW(), ScrH() )

		self.DrawScopeOverlay( self:GetOwner(), self, vSway, aSway, 1 ) 
	end
	
end

function SWEP:ShouldDrawViewModel()
	if ( self.AdsRTScopeEnabled && !cmd_rtsniperscopes:GetBool() && self:GetSciFiState() == SCIFI_STATE_ADS && fAnimAds > self.AdsViewModelHideThreshold ) then -- && fAnimAds > 0.9 ) then
		return false
	else
		return true
	end
end

if ( SERVER ) then

	function SWEP:GetCapabilities()
		if ( self.NpcCapabilitiesOverride ) then
			return self.NpcCapabilities
		else
			return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1 )
		end
	end

end

SWEP.SciFiStateDelta = 0

function SWEP:SetupDataTables()
	
	local tTypeIndex, tDataTables = {}, {}
	
	tDataTables = {
		{ dType = "Bool", dName = "SafeMode" },
		{ dType = "Int", dName = "SciFiState" },
		{ dType = "Float", dName = "AnimNextIdle" },
		{ dType = "Float", dName = "SciFiACC" },
		{ dType = "Float", dName = "Charge" },
		{ dType = "Float", dName = "MeleeTime" },
		{ dType = "Float", dName = "MeleeCharge" }
	}
	
	table.Add( tDataTables, self.DataTables )
	
	for k, v in pairs( tDataTables ) do
		if !( v.dType && v.dName ) then
			continue
		end

		local id
		
		if ( !tTypeIndex[ v.dType ] ) then
			tTypeIndex[ v.dType ] = 0
		end
		
		id = tTypeIndex[ v.dType ] + 1
		
		if ( id > 31 ) then
			DevMsg( "@" .. self .. " : !Error, Exceeding data tables! You cannot add more than 32 total entries of the same type!" )
			continue
		end
		
		tTypeIndex[ v.dType ] = id

		self:NetworkVar( v.dType, id, v.dName )
	end
end

function SWEP:Initialize()

	if ( self.Owner:IsPlayer() ) then 
		self:SetHoldType( self.HoldType )
	else
		self:SetHoldType( self.HoldTypeNPC )
	end
	
	if ( CLIENT && !cmd_autodestroysck:GetBool() && self.UseSCK ) then
		self:sckInit()
	end
		
	self:SetDeploySpeed( self.DeploySpeed )
	
	self:SubInit()

end

function SWEP:SubInit()

end

function SWEP:AddAcc()

end

function SWEP:AddWAcc()

end

function SWEP:Think()
	
	self:Anims()
	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	
end

local iFTRecent = 0
local iFTDelta = 0
	
function SWEP:SciFiMath()
	
	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then 
		DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) 
		return 
	end

	if ( self.Owner:IsNPC() ) then return end
	
	if ( !self.GetSciFiACC ) then
		DevMsg( "@" .. self:GetClass() .. " : !Error; SciFiACC hasn't been added to this weapon's data tables." )
		
		self.SciFiACC = 1
		return
	end

	if ( CLIENT ) && ( self.ChargeDeltaCompensate ) then
		local iFTActual = FrameTime() 
		local iDiff = iFTActual / iFTDelta
		
		self.ChargeDeltaFactor = math.min( iDiff, 1 )
		
		iFTDelta = iFTActual
	end
	
	local fAcc = self:GetSciFiACC()
	local fRecov = self.SciFiACCRecoverRate

	local fMaxAcc = cmd_maxacc:GetFloat()
	
	if ( fAcc > fMaxAcc ) then
		fAcc = fMaxAcc
	end
	
	if ( fAcc > 0 ) then
		fAcc = fAcc - fRecov
	end

	if ( fAcc < 0 ) then
		fAcc = 0 
	end

--	fAcc = m_Clamp( fAcc - fRecov, 0, fMaxAcc )
	
	self:SetSciFiACC( fAcc )

end

function SWEP:AddSciFiACC( value, bIgnoreAds )
	
	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end

	local fMaxAcc = cmd_maxacc:GetFloat()
	local IsAds = ( self:GetSciFiState() == SCIFI_STATE_ADS )
	
	local fAcc = self:GetSciFiACC()

	if ( self.Owner:IsNPC() ) then 
		fAcc = 0 

		return 
	end
	
	local bAnims = cmd_advanims:GetBool() 
	if ( !bAnims ) then
		bIgnoreAds = true
	end
	
	if ( self.Owner:Crouching() && bAnims ) then
		value = value * self.CrouchRecoilMul
	end
	
	if ( value < ( fMaxAcc * 1.4 ) ) && ( value > 0 ) then
		if ( IsAds && !bIgnoreAds ) then
			fAcc = m_Clamp( fAcc + ( value * self.AdsRecoilMul ), 0, fMaxAcc )
		else
			fAcc = m_Clamp( fAcc + value, 0, fMaxAcc )
		end
	else
		DevMsg( "@"..self:GetClass().." : !Warning; Potential SciFiACC malformation ("..self:GetSciFiACC() + value..")! Maximum value is "..fMaxAcc.."!" )
	end

--	local bZeroGrav = ( physenv.GetGravity():Length() < 1 )
--	if ( bZeroGrav && self.Owner:IsPlayer() ) then
--		self.Owner:SetVelocity( self.Owner:GetAimVector() * -fAcc * 10 )
--	end
	
	self:SetSciFiACC( fAcc )

end

function SWEP:IsFamily( tag )

	if ( table.HasValue( self.SciFiFamily, tag ) && self.SciFiFamily ~= nil ) then
		return true
	else
		return false
	end

end

function SWEP:GetViewModelEnt()

	local viewmodel

	if ( !IsValid( self.Owner ) ) then
		viewmodel = self
		return viewmodel
	end
	
	if ( self.Owner:IsPlayer() ) then
		viewmodel = self.Owner:GetViewModel()
	end
	
	if ( self.Owner:IsNPC() ) || ( !game.SinglePlayer() && !self.Owner ) then
		viewmodel = self.Owner:GetActiveWeapon()
	end
	
	if ( !IsValid( viewmodel ) ) then return end
	
	return viewmodel

end

function SWEP:GetViewModelSway()

	return aDiff

end

function SWEP:GetProjectileSpawnPos()

	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end

	local bOffset = cmd_actualspawnoffset:GetBool() 
	local iStatic = cmd_staticspawnoffset:GetInt()
	
	if ( !bOffset ) then
		local pOwnerEyes = self.Owner:EyePos()
		local pOwnerAV = self.Owner:GetAimVector()
	
		local pos = pOwnerEyes + ( pOwnerAV * 20 )
	
		return pos
	end
	
	local bStatic, bStaticNPC = ( iStatic > 0 && self.Owner:IsPlayer() ), ( iStatic > 1 && self.Owner:IsNPC() )
	
	if ( bStatic || bStaticNPC ) then
		local rt = self.Owner:GetRight()
		local up = self.Owner:GetUp()
	
		local vNative, vShootPos

		if ( bStaticNPC ) then	
			vShootPos = self.Owner:EyePos()
			vNative = self.ProjectileOffsetNPC
		else
			vShootPos = self.Owner:GetShootPos()
			vNative = self.ProjectileOffset
		end

		local vOffset = ( rt * vNative.x + up * vNative.y )
		local pos = vShootPos + vOffset
		
		return pos
	else
		local vmEntity = self:GetViewModelEnt()
		local vmAttach = vmEntity:LookupAttachment( "muzzle" )

		if ( !vmAttach || vmAttach == 0 ) then
			vmAttach = vmEntity:LookupAttachment( "1" )
		end
	
		local pos = self:GetAttachment( vmAttach ).Pos

		return pos
	end

end

function SWEP:GetProjectileSpreadVector()

	local vSpread = Vector()
	local pOwnerEA = self.Owner:EyeAngles()
	local vForward, vRight, vUp = pOwnerEA:Forward(), pOwnerEA:Right(), pOwnerEA:Up()

	vRight = vRight * math.random( self.ProjectileSpreadY.x, self.ProjectileSpreadY.y )
	vUp = vUp * math.random( self.ProjectileSpreadZ.x, self.ProjectileSpreadZ.y )
	
	vSpread = vForward + vRight + vUp
	
	return vSpread

end

function SWEP:Equip( NewOwner )

	if ( NewOwner:IsNPC() && cmd_allow_npccompatibility:GetBool() ) then
		if ( self.SciFiWorld ~= nil && self.SciFiWorld ~= "" ) then
			self:SetMaterial( self.SciFiWorld )
		end
		
		if ( self.HoldTypeNPC ) then
			self:SetupWeaponHoldTypeForAI( self.HoldTypeNPC )
		else
			self:SetupWeaponHoldTypeForAI( "ar2" )
		end
		
		local iSpawnFlags = NewOwner:GetSpawnFlags()
		
		for k,v in pairs( self.NpcSpawnFlags ) do
			if ( !v ) then continue end
			
			iSpawnFlags = bit.bor( iSpawnFlags, v )
		end
		
		NewOwner:SetKeyValue( "spawnflags", iSpawnFlags )

		NewOwner:SetSaveValue( "m_flDistTooFar", 8192 )
		NewOwner:SetSaveValue( "m_nBurstHits", 12 )
		NewOwner:SetSaveValue( "m_nMaxBurstHits", 12 )
		NewOwner:SetSaveValue( "m_nBurstMode", 0 )
		NewOwner:SetSaveValue( "m_nBurstSteerMode", 4 )
		NewOwner:SetSaveValue( "additionalequipment", self:GetClass() )
--		NewOwner:SetSaveValue( "m_hMyWeapons", self )

		NewOwner:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )

		if ( self.Owner:Classify() == CLASS_ZOMBIE ) then
			self:SetHoldType( self.HoldTypeZombie )
		end
		
		self:SetClip1( self.Primary.ClipSize )
	end

	if ( self.Owner:IsPlayer() ) then
		if ( self:GetAmmoNature() ) && ( !GetConVar( "vh_campaign" ):GetBool() ) then
			self.Owner:GiveAmmo( self.Primary.ClipSize * 6, self.Primary.Ammo )
			self.Owner:GiveAmmo( self.Primary.ClipSize * 3, self.Primary.Ammo )
		end
		
		if ( !self:GetAmmoNature() ) then
			self:SetClip1( self.Primary.ClipSize )
		end
		
		cmd_sboxhints = GetConVar( "cl_showhints" ) -- garry, pls
		if ( cmd_sboxhints && cmd_sboxhints:GetBool() ) then
			-- if ( self.Owner.m_bHasSeenSciFiHints ) then return end
			
			self.Owner:SendHint( "sfw_controls_simple", 2 )
			self.Owner:SendHint( "sfw_controls_altfire", 4 )
			self.Owner:SendHint( "sfw_controls_firemodes", 4 )
			self.Owner:SendHint( "sfw_controls_safety", 6 )
			self.Owner:SendHint( "sfw_options", 10 )
			
			self.Owner.m_bHasSeenSciFiHints = true
		end
	end

end

function SWEP:ResetAnimationScale( fScaleOverride )
	
	if ( !fScaleOverride ) then
		fScaleOverride = 0
	end
	
	iSprintSpeed = nil
	fAnimMenu = fScaleOverride
	fAnimSprint = fScaleOverride
	fAnimCrouch = fScaleOverride
	fAnimMelee = fScaleOverride
	fAnimSafety = fScaleOverride
	fAnimReload = fScaleOverride
	fAnimAds = fScaleOverride

end

function SWEP:Deploy() 
	
	if ( cmd_autodestroysck:GetBool() ) then
		self:sckInit()
	end

	self:SetAds( false )

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self:SetSciFiState( SCIFI_STATE_IDLE )
		self:SetMeleeCharge( 0 )
		self:SetSciFiACC( 4 )
	end
	
	self:ResetAnimationScale()
	
	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( IsValid(self.Owner) ) && ( self.Owner:IsPlayer() ) then
		self:ResetBonePositions()
		self:ResetAnimationScale()
	end
	
	-- self:SetSciFiState( SCIFI_STATE_IDLE )

	-- self:SetAds( false )

	self:ResetDeployment()

	return true

end

function SWEP:OnDrop()

	self:SetAds( false )
	self:SetSciFiState( SCIFI_STATE_IDLE )
	self:ResetDeployment()

end

function SWEP:ShouldDropOnDie()

	return true
	
end

local tLootDropEffects = {
	"lbox_open_t0",
	"lbox_open_t1",
	"lbox_open_t2",
	"lbox_open_t3",
	"lbox_open_t3",
	-- "lbox_open_t4",
}

function SWEP:OwnerChanged()

	local wOwner = self:GetOwner()

	if ( IsValid( wOwner ) ) && ( wOwner != self.LastOwner ) then
		self.LastOwner = wOwner
	else
		self:ResetDeployment()
	
		if ( SERVER ) && ( wOwner != self.LastOwner ) && ( self.Component && self.Component.Quality ) then
			local sEffectName = tLootDropEffects[ self.Component.Quality + 1 ] || "lbox_open_t0"
			
			if ( self.Component.Legendary ) then
				sEffectName = "lbox_open_t4"
			end

			ParticleEffectAttach( sEffectName, PATTACH_ABSORIGIN_FOLLOW, self, 0 )
		end
	end
end

function SWEP:CanPrimaryAttack( cap, canunderwater )
	
	if ( !IsValid( self.Owner ) ) then return end
	
	if ( self.GetSafeMode ) && ( self:GetSafeMode() ) then
		self:SetNextPrimaryFire( CurTime() + 0.1 )
		self:SetSafeMode( false )
		
		self:EmitSound( self.SafeModeOffSnd )
		self:SendWeaponAnim( ACT_VM_LOWERED_TO_IDLE )

		self.ViewModelIdleSequence = ACT_VM_IDLE
		
		return
	end
	
	if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
		return false
	end
	
	if ( !cap ) then
		cap = 0
	end
	
	local bAnims = cmd_advanims:GetBool() 

	if ( self:Clip1() <= cap ) then
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
		end
		
		if ( self.ReloadOnTrigger ) then
			self:Reload()
			self:SetNextPrimaryFire( CurTime() + 0.1 )
		else
			self:SetNextPrimaryFire( CurTime() + 0.2 )
--			self:SendWeaponAnim( ACT_VM_DRYFIRE )
		end

		return false
	end

	if ( self:GetSciFiState() == SCIFI_STATE_SPRINT ) && ( bAnims ) then
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) && ( !canunderwater ) then
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
		end

		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end

	return true
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 21 || event == 22 ) then
		return true
	end

end

local sTargetBone = "ValveBiped.Bip01_Head1"

function SWEP:GetTargetHeadBone( entTarget )

	if ( !IsValid( entTarget ) ) then return end

	local iGroupCount = entTarget:GetHitBoxGroupCount()
	
	if ( !iGroupCount ) then return end
	
	for iGroupID = 0, iGroupCount - 1 do
		local iHBoxCount = entTarget:GetHitBoxCount( iGroupID )

		for iHboxID = 0, iHBoxCount - 1 do
			local bone = entTarget:GetHitBoxBone( iHboxID, iGroupID )
			
			if ( entTarget:GetBoneName( bone ) == sTargetBone ) then
				return bone
			end
		end
	end

end

function SWEP:GetFeelGoodVector( vInput )

	if ( !SERVER ) then 
		return vInput 
	end
	
	if ( !self.Owner:IsPlayer() ) then 
		return vInput 
	end
	
	if ( !vInput ) then
		vInput = self.Owner:GetAimVector()
	end

	local tr = self.Owner:GetEyeTrace()
	local entLookingAt = tr.Entity
	
	if ( self.FeelGoodHullEnabled ) then
		local trData, trResult = {}, {}
		
		local vHullSize = Vector( self.FeelGoodHullSize, self.FeelGoodHullSize, self.FeelGoodHullSize )
		
		trData.start = self.Owner:GetShootPos()
		trData.endpos = tr.HitPos
		trData.mins = vHullSize * -1
		trData.maxs = vHullSize
		trData.ignoreworld = true
		trData.mask = MASK_SHOT
		trData.filter = { self.Owner, self }
		
		tr = util.TraceHull( trData )

		if ( cmd_debug_showaavectors:GetBool() ) then
			local iTraceDistance = 32768 * tr.Fraction
			
			debugoverlay.BoxAngles( tr.StartPos, Vector( 1, 1, 1 ) * -self.FeelGoodHullSize, Vector( iTraceDistance, self.FeelGoodHullSize, self.FeelGoodHullSize ), tr.Normal:Angle(), 4, Color( 180, 10, 30, 1 ) )
		end
	end
	
	local entTarget = tr.Entity
	
	if ( self.FeelGoodHullEnabled ) then
		if ( IsValid( entTarget ) && IsValid( entLookingAt ) && ( entTarget != entLookingAt ) && ( entLookingAt:IsPlayer() || entLookingAt:IsNPC() ) ) then
			entTarget = entLookingAt
		end
	end
	
	if !( IsValid( entTarget ) && ( entTarget:IsPlayer() || entTarget:IsNPC() ) ) then 
		return vInput 
	end
	
	local HeadBone = self:GetTargetHeadBone( entTarget )
	
	local vBullsEye
	if ( HeadBone ) then
		vBullsEye = entTarget:GetBonePosition( HeadBone )
	else
		vBullsEye = entTarget:EyePos()
	end
		
	local aPunch = self.Owner:GetViewPunchAngles()
	local fPunchPower = math.abs( aPunch.pitch + aPunch.yaw + aPunch.roll ) * self.FeelGoodPunchPower
	
	local fRatio = math.Clamp( self.FeelGoodRatio - fPunchPower, 0, 1 )
	
	if ( self:GetSciFiState() != SCIFI_STATE_ADS ) then
		fRatio = fRatio * self.FeelGoodScaleHip
	end
	
	if ( !self.Owner:OnGround() ) then
		fRatio = fRatio * self.FeelGoodScaleAir
	end
	
	vBullsEye = vBullsEye - self.Owner:GetShootPos()
	vBullsEye:Normalize()
	
	local vFeelGood = LerpVector( fRatio, vInput, vBullsEye )

	if ( cmd_debug_showaavectors:GetBool() ) then
		local iTraceDistance = 32768 * tr.Fraction
		debugoverlay.Line( tr.StartPos, tr.HitPos, FrameTime() * 240, Color( 255, 0, 0 ), true )
		debugoverlay.Line( tr.StartPos, tr.StartPos + vBullsEye * iTraceDistance, FrameTime() * 240, Color( 0, 0, 255 ), true )
		debugoverlay.Line( tr.StartPos, tr.StartPos + vFeelGood * iTraceDistance, FrameTime() * 240, Color( 0, 255, 0 ), true )
	end

	return vFeelGood

end

function SWEP:DoMuzzleEffect()

--	local bComplexParticles = cmd_fx_particles:GetBool()
	local bHeatParticles = cmd_fx_heat:GetBool()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then 
		DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) 
		return 
	end
	
	local bSuppressOnZoom = cmd_fx_suppressonzoom:GetBool()

	if ( bSuppressOnZoom ) then 
		local bIsAds = ( self:GetSciFiState() == SCIFI_STATE_ADS )
		
		if ( bIsAds ) then
			return
		end
	end

	local vmEntity = self:GetViewModelEnt()
		
	if ( !IsValid( vmEntity ) ) then 
		DevMsg( "@"..self:GetClass().." : !Error; Invalid viewmodel. Invalid/missing model file?" ) 
		return 
	end

	local vmOrigin = vmEntity:GetPos()
	
	if ( !game.SinglePlayer && self.Owner:ShouldDrawLocalPlayer() ) then 
		vmEntity = self.Owner:GetActiveWeapon()
	end

	local ed = EffectData()
	ed:SetOrigin( vmOrigin )
	ed:SetEntity( self )
--	ed:SetAttachment( vmAttach )
	
	util.Effect( "sfw_muzzle_generic", ed, true, false )

	if ( !bHeatParticles ) && ( !self.VfxHeatForce ) then return end
	
	if ( !self.m_nLastHeat ) then
		self.m_nLastHeat = 0
	end

	if ( game.SinglePlayer && SERVER ) || ( !game.SinglePlayer && CLIENT ) then
		local maxacc = cmd_maxacc:GetFloat() * self.VfxHeatThreshold
		
		local delay = 0
		if ( self.VfxHeatDelay > 0 ) then
			delay = self.m_nLastHeat + self.VfxHeatDelay
		end

		if ( self.VfxHeatForce ) || ( ( delay <= CurTime() ) && ( self:GetSciFiACC() >= maxacc ) ) then	
			local vmAttach

			if ( self.VfxMuzzleAttachment ) then
				vmAttach = vmEntity:LookupAttachment( self.VfxMuzzleAttachment )
			else
				vmAttach = vmEntity:LookupAttachment( "muzzle" )
				
				if ( vmAttach == 0 ) then
					vmAttach = vmEntity:LookupAttachment( "1" )
				end
			end
			
			if ( vmAttach == 0 ) || ( !vmAttach ) then 
				DevMsg( "@"..self:GetClass().." : !Error; Invalid muzzle attachment ID." ) 
				vmAttach = 1
			end

			local vmOrigin = vmEntity:GetAttachment( vmAttach )
			vmOrigin = vmOrigin.Pos
			
			if ( !vmOrigin ) then 
				DevMsg( "@"..self:GetClass().." : !Error; Invalid muzzle attachment position." ) 
				return 
			end

			ParticleEffectAttach( self.VfxHeatParticle, PATTACH_POINT_FOLLOW, vmEntity, vmAttach )
			self.m_nLastHeat = CurTime()
		end
	end
	
end

function SWEP:PrimaryAttack()

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 0.08 )

	local viewmodel = self:GetViewModelEnt()
	local amp = GetConVar( "sfw_damageamp" ):GetFloat()
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .0021, .0021 ) * self:GetSciFiACC()
	bullet.Tracer = 1
	bullet.TracerName = "ca3_tracer" 
	bullet.Force = 4
	bullet.HullSize = 1
	bullet.Damage = 8 * amp
	bullet.Callback = function( attacker, tr, dmginfo )
	
		ParticleEffect( "ngen_hit", tr.HitPos, Angle( 0, 0, 0 ), fx )
		sound.Play( "scifi.ca3.hit", tr.HitPos, SOUNDLVL_NORM, m_random( 95, 102 ), 1.0 )
	
		if ( GetRelChance( 8 ) ) then 
			ParticleEffect( "hornet_blast", tr.HitPos, Angle( 0, 0, 0 ), fx )
			DoElementalEffect( { Element = EML_SHOCK, Target = tr.Entity, Attacker = self.Owner, Damage = 30 } )
			self:DealAoeDamage( bit.bor( DMG_SHOCK, DMG_RADIATION ), 12 * amp, tr.HitPos, 40 )
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	self:DoMuzzleEffect()
--	self:DrawMuzzleLight( "120 110 255 120" , 155, 500, 0.07 )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( m_random( -0.6, -1 ), m_random( -0.1, -0.5 ), m_random( -0.1, -0.3 ) ) * ( self:GetSciFiACC() * 0.1 ) )
	end
	
	self:AddSciFiACC( 3.4 )
	
	self:EmitSound( "cat.vk21.pfire" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
	
end

function SWEP:GetNPCRestTimes()

	return self.NPCRestMin, self.NPCRestMax

end

function SWEP:GetNPCBurstSettings()
	
	local iMinBurst = self.NPCBurstMin
	local iMaxBurst = self.NPCBurstMax
	local iDelay = self.NPCBurstDelay

	return iMinBurst, iMaxBurst, iDelay

end

function SWEP:GetNPCBulletSpread( iNpcProficiency )

	return self.NPCBulletSpread

end

function SWEP:NPCShoot_Primary( ShootPos, ShootDir )

	local entTarget = self.Owner:GetEnemy()
	local vShootDirOld = ShootDir

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

		if ( cmd_debug_showaavectors:GetBool() ) then
			local iTraceDistance = 32768
			debugoverlay.Line( ShootPos, ShootPos + vShootDirOld * iTraceDistance, FrameTime() * 240, Color( 255, 0, 0 ), true )
			debugoverlay.Line( ShootPos, ( vBullsEye - ShootPos ) * iTraceDistance, FrameTime() * 240, Color( 0, 0, 255 ), true )
			debugoverlay.Line( ShootPos, ShootPos + ShootDir * iTraceDistance, FrameTime() * 240, Color( 0, 255, 0 ), true )
		end
	end
	
	if ( !ShootDir ) then
		local iParentBone = self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )
		ShootPos, ShootDir = self.Owner:GetBonePosition( iParentBone )
		ShootDir = ( ShootDir:Forward() + self.Owner:GetAimVector() ) * 0.5
	end
	
	self:PrimaryAttack()

end

function SWEP:CanSecondaryAttack()

	if ( self:Clip1() < 30 ) then
		self:EmitSound( "Weapon_ar2.Empty" )
		self:Reload()
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
		end
		
		self:SetNextSecondaryFire( CurTime() + 0.2 )
		return false
	end
	
	if ( self:GetSciFiState() == SCIFI_STATE_SPRINT ) && ( cmd_advanims:GetBool() ) then
		return false
	end

	return true

end

function SWEP:SecondaryAttack()

end

function SWEP:TakePrimaryAmmo( iDrain )
	
	if ( IsValid( self.Owner ) && self.Owner:IsPlayer() ) then
		if ( self:Clip1() <= 0 ) then 
			if ( self:Ammo1() <= 0 ) then return end
			
			self.Owner:RemoveAmmo( iDrain, self:GetPrimaryAmmoType() )
		
			return 
		end
	end
	
	self:SetClip1( self:Clip1() - iDrain )	
	
end

function SWEP:OnReloadGibCreated( entReloadGib, physReloadGib )

end

function SWEP:CreateReloadModels()

	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end

	if ( SERVER ) then
		if ( !util.IsValidModel( self.ReloadGib ) ) then return end
		
		local iParentBone = self.Owner:LookupBone( self.ReloadGibParentBone )
		
		if ( !iParentBone ) then return end
		
		local vBoneOrigin, aBoneRotation = self.Owner:GetBonePosition( iParentBone )
		
		if ( !vBoneOrigin || !aBoneRotation ) then return end
		
		local fw = aBoneRotation:Forward()
		local rt = aBoneRotation:Right()
		local up = aBoneRotation:Up()
		
		local vGibOrigin = vBoneOrigin + ( up * self.ReloadGibOrigin.z + rt * self.ReloadGibOrigin.y + fw * self.ReloadGibOrigin.y )
		
		local ent = ents.Create( "prop_emptymag" ) -- "prop_physics" )
		if (  !IsValid( ent ) ) then return end
--		ent:SetModel( self.ReloadGib )
--		ent:SetMaterial( self.ReloadGibMaterial )
		ent.RMdl = self.ReloadGib
		ent.RMat = self.ReloadGibMaterial || ""
		ent:SetPos( vGibOrigin )
		ent:SetAngles( self.Owner:EyeAngles() + aBoneRotation * 0.1 )
		ent:SetModelScale( self.ReloadGibSize )
		ent:SetOwner( self.Owner )
		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		if ( self.ReloadGibMass ) then
			phys:SetMass( self.ReloadGibMass )
		end
		phys:SetMaterial( "weapon" )
		phys:ApplyForceCenter( fw * 64 )
		
		self:OnReloadGibCreated( ent, phys )
		
--		SafeRemoveEntityDelayed( ent, 10 )
	end

end

function SWEP:CanReload()

	if ( self:Clip1() >= self.Primary.ClipSize ) then
		return false
	end
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then
		return false
	end
	
	if ( self.Owner:IsPlayer() ) then
		if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then
			return false
		end

		if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
			return false
		end
		
		if ( ( self:GetSciFiState() == SCIFI_STATE_SPRINT ) && ( cmd_advanims:GetBool() ) ) then
			return false
		end
	end	
	
	return true
	
end

function SWEP:OnReload()

end

function SWEP:OnReloadFinish()

end

function SWEP:Reload()

	if ( !self:CanReload() ) then return end

	self:OnReload()
	
	if ( self.ReloadModels ) then
		local cmd_propcreation = GetConVar( "sfw_allow_propcreation" ):GetBool()
		if ( cmd_propcreation ) then 
			if ( self.ReloadGibDelay > 0 ) then
				timer.Simple( self.ReloadGibDelay, function()
					if ( !IsValid( self ) ) then return end
					self:CreateReloadModels()
				end )
			else
				self:CreateReloadModels()
			end
		end
	end

	if ( self.Owner:IsPlayer() ) then
		if ( SERVER ) then
			net.Start( "SciFiReload" )
			net.WriteBool( true )
			net.WriteBool( self:GetSciFiState() == SCIFI_STATE_ADS )
			net.Send( self.Owner )
		end
	
		self:SetSciFiState( SCIFI_STATE_RELOADING )

		self:SetAds( false )
		
		if ( self.ReloadRealisticClips ) then
			if ( self:Clip1() > 0 ) then
				self:SetClip1( 1 )
			else
				self:SetClip1( 0 )
			end
		end

		local vm = self.Owner:GetViewModel()
		vm:SetPlaybackRate( self.ReloadPlaybackRate )

		timer.Simple( self.ReloadTime, function()
			if ( IsValid( self ) && IsValid( self.Owner ) ) then
				if ( self.ReloadAnimEndIdle ) then
					self:SendWeaponAnim( ACT_VM_IDLE )
				end
				
				if ( SERVER ) then
					net.Start( "SciFiReload" )
					net.WriteBool( false )
					net.WriteBool( false )
					net.Send( self.Owner )
				
					self:SetSciFiState( SCIFI_STATE_IDLE )

					local vm = self.Owner:GetViewModel()
					vm:SetPlaybackRate( 1 )
					
					self:OnReloadFinish()
				end
				
				if ( !self.ReloadLegacy ) then
					local iAmmoReserves, iClip = self.Owner:GetAmmoCount( self.Primary.Ammo ), self:Clip1()
					local iDrain = m_min( self.Primary.ClipSize - iClip, iAmmoReserves )
					local iAmmo = iClip + iDrain
					
					if ( self.ReloadRealisticClips ) && ( iClip > 0 ) then
						iAmmo = iAmmo + 1
					end
					
					self:SetClip1( iAmmo )
					self.Owner:RemoveAmmo( iDrain, self.Primary.Ammo )
				end
			end
		end )
	end
	
	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self:SetNextPrimaryFire( CurTime() + self.ReloadTime )
		self:SetNextSecondaryFire( CurTime() + self.ReloadTime )
		
		if ( self.ReloadSND ) then
			self:EmitSound( self.ReloadSND )
		end

		self:SetNWInt( "BurstCount", 5 )

		if ( self.Owner:IsPlayer() ) then
			local vm = self.Owner:GetViewModel()
			vm:SetPlaybackRate( self.ReloadPlaybackRate )
	
			if ( self.ReloadLegacy ) then
				self:DefaultReload( self.ReloadACT )
			else
				local sSequenceName = vm:SelectWeightedSequence( self.ReloadACT )
				self:SendWeaponAnim( self.ReloadACT )
				
				vm:SetSequence( sSequenceName ) -- double-trouble?
			end
			
			self.Owner:DoReloadEvent()

			vm:SetPlaybackRate( self.ReloadPlaybackRate )
			
			self:SetAnimNextIdle( CurTime() + vm:SequenceDuration() * self.ReloadPlaybackRate )
		else
			self:SetClip1( self.Primary.ClipSize )
		end
	end
	
end

function SWEP:DrawMuzzleLight( color, fov, range, lifetime )

	if ( cmd_fx_muzzlelights:GetInt() < 2 ) then return end
	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
	
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerEP = self.Owner:EyePos()
	local ang = pOwnerAV:Angle()

	local vmEntity = self:GetViewModelEnt()

	local vmAttach = vmEntity:LookupAttachment( self.VfxMuzzleAttachment )

	if ( !vmAttach || vmAttach == 0 ) then
		vmAttach = vmEntity:LookupAttachment( "1" )
	end
	
	local pos 
	if ( !vmAttach || vmAttach == 0 ) then
		pos = self:GetProjectileSpawnPos()
	else
		pos = vmEntity:GetAttachment( vmAttach ).Pos
		pos = pos + ( VectorRand() * ( self:GetSciFiACC() / 10 ) )
	end

	if ( SERVER ) then
		local realtime = ents.Create( "env_projectedtexture" )
		if ( !IsValid( realtime ) ) then return end
		realtime:SetKeyValue( "targetname", "realtimelight" )
		realtime:SetPos( pos )
		realtime:SetAngles( ang )		
		realtime:SetKeyValue( "lightfov", fov * m_random( 0.98, 1.02 ) )
		realtime:SetKeyValue( "lightworld", 1 )	
		realtime:SetKeyValue( "lightcolor", color )
		realtime:SetKeyValue( "enableshadows", 1 )
		realtime:SetKeyValue( "farz", range )
		realtime:SetKeyValue( "nearz", 4 )
		realtime:SetParent( self )
		realtime:Spawn()
		realtime:Fire( "SpotlightTexture", self.VfxMuzzleProjexture, 0 )
		realtime:Fire( "kill", "", lifetime )
	end
	
end

function SWEP:CanMelee()
	
	if ( !self.Owner:IsPlayer() ) then return false end
	if ( self.Owner:InVehicle() ) then return false end

	local cmd_allow_melee = GetConVar( "sfw_allow_melee" ):GetBool()
	if ( !cmd_allow_melee ) then return false end

	if ( self.Owner:KeyDown( IN_ATTACK ) ) then return false end
	
	if !( self:GetSciFiState() == SCIFI_STATE_IDLE ) then return false end
	
	return true
	
end

function SWEP:SciFiMelee()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then 
		DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) 
		return 
	end
	
	if ( !self:CanMelee() ) then return end

	if ( self.Owner:KeyDown( IN_GRENADE2 ) && !self.Owner:KeyPressed( IN_ATTACK ) ) then
		if ( self:GetMeleeCharge() < self.SciFiMeleeChargeMax ) then
			self:SetMeleeCharge( self:GetMeleeCharge() + 1 )
		end
	else
		if ( self:GetMeleeCharge() > 0 ) then
			self:SetMeleeCharge( self:GetMeleeCharge() - 0.5 )
		end
	end

	if ( self.Owner:KeyReleased( IN_GRENADE2 ) ) then
		if !( self:GetMeleeTime() <= CurTime() && self:GetNextPrimaryFire() < CurTime() ) then return end

		--if ( !game.SinglePlayer() && SERVER ) || ( CLIENT ) then
			self.Owner:AnimResetGestureSlot( GESTURE_SLOT_ATTACK_AND_RELOAD )
			self.Owner:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND, true )
			-- self.Owner:AnimSetGestureWeight( GESTURE_SLOT_ATTACK_AND_RELOAD, 1 )
		--end

		self:SetSciFiState( SCIFI_STATE_MELEE_ATTACK )
		
		self:EmitSound( self.SciFiMeleeSound )
		
		local vPunchAng = Angle( m_random( 1, 2 ), m_random( 1, 5 ), m_random( 0, 0.1 ) )
		self.Owner:ViewPunch( vPunchAng * ( 4 + self:GetSciFiACC() * 0.5 + self:GetMeleeCharge() / 10 ) )
		
		timer.Simple( self.SciFiMeleeRecoverTime, function()
			if ( IsValid( self ) && IsValid( self.Owner ) && self.Owner:Alive() ) then
				self:SetSciFiState( SCIFI_STATE_IDLE )
			end
		end )
		
		local amp = GetConVar( "sfw_damageamp" ):GetFloat()
		local playervelo = self.Owner:GetVelocity()
		local velo = m_Clamp( playervelo:Length() * 0.0018, 1, 10 )
		
		self.Owner:LagCompensation( true )
	
		local tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.SciFiMeleeRange,
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		} )

		if ( !IsValid( tr.Entity ) ) then 
			tr = util.TraceHull( {
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * ( self.SciFiMeleeRange + self:GetMeleeCharge() / 8 ) ,
				filter = self.Owner,
				mins = Vector( -10, -4, -2 ),
				maxs = Vector( 10, 4, 2 ),
				mask = MASK_SHOT_HULL
			} )
		end
		
		if ( SERVER && IsValid( tr.Entity ) ) then -- && ( tr.Entity:GetOwner() ~= self.Owner ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 || tr.Entity:IsRagdoll() || tr.Entity:GetClass() == "prop_physics" ) ) then
			local dmginfo = DamageInfo()
			
			local cmd_stealthfinisher = GetConVar( "sfw_allow_stealthfinishers" )
			local iDmg = self.SciFiMeleeDamage * amp + velo + self:GetMeleeCharge() / 10
			
			if ( tr.Entity:GetClass() == "item_item_crate" ) then
				iDmg = iDmg * 4
			end
			
			if ( util.GetSurfacePropName( tr.SurfaceProps ) == "glass" && tr.Entity:GetClass() == "func_breakable" ) then
				iDmg = iDmg * 2
			end
			
			if ( self.Owner:WaterLevel() == 3 ) then
				iDmg = iDmg * 0.25
			end
			
			if ( cmd_stealthfinisher:GetBool() ) && ( tr.Entity:IsNPC() && tr.Entity:GetNPCState() == NPC_STATE_IDLE ) then
				iDmg = iDmg * 8
			end
			
			local attacker = self.Owner
			if ( !IsValid( attacker ) ) then attacker = self end
			dmginfo:SetAttacker( attacker )
			dmginfo:SetInflictor( attacker )
			dmginfo:SetDamage( iDmg )
			dmginfo:SetDamageForce( self.Owner:GetRight() * 2 + self.Owner:GetForward() * 12 )
			dmginfo:SetDamageType( self.SciFiMeleeDamageType )
			local phys = tr.Entity:GetPhysicsObject()
			
			if ( IsValid( phys ) ) then
				phys:ApplyForceCenter( self.Owner:GetRight() * 2 + self.Owner:GetForward() * 8 + playervelo * 4 )
			end
			
			if ( tr.Entity:IsNPC() ) then
				local target = tr.Entity	
				if ( !target:IsCurrentSchedule( SCHED_BACK_AWAY_FROM_ENEMY ) && target:GetMaxHealth() <= 150 && !target:GetNWBool( "bliz_frozen" )  ) then
					target:SetSchedule( SCHED_FEAR_FACE ) -- step aside, peasants!
					target:SetSchedule( SCHED_MOVE_AWAY )
					target:SetSchedule( SCHED_BACK_AWAY_FROM_ENEMY )
					target:SetSchedule( SCHED_RUN_FROM_ENEMY )
					timer.Simple( 50 / target:Health(), function()
						if ( IsValid( target ) ) && ( SERVER ) then
							target:SetSchedule( SCHED_WAKE_ANGRY )
						end
					end )
				end
			end

			tr.Entity:TakeDamageInfo( dmginfo )
		end

		if ( !( game.SinglePlayer() && CLIENT ) ) then
			if ( tr.Hit && !tr.HitWorld ) then
				self:EmitSound( self.SciFiMeleeHitBody )
			elseif( tr.HitWorld ) then
				self:EmitSound( self.SciFiMeleeHitWorld )
			end
		end

		if ( SERVER && IsValid( tr.Entity ) ) then
			local phys = tr.Entity:GetPhysicsObject()
			if ( IsValid( phys ) ) then
				phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos )
			end
		end

		self.Owner:LagCompensation( false )
		
		local delay = CurTime() + self.SciFiMeleeASpeed

--		self:SetNextPrimaryFire( delay - 0.1 )
		self:SetMeleeTime( delay )
		self.SciFiMeleeTime = delay
		self:AddSciFiACC( 12 )
		
		self:SetMeleeCharge( 0 )
	end

end

function SWEP:IsSprinting()

	-- if ( dSprintSpeed ~= self.Owner:GetRunSpeed() ) then
		-- iSprintSpeed = nil
	-- end

	-- if ( !iSprintSpeed ) then
		-- iSprintSpeed = self.Owner:GetRunSpeed() - 10
		-- dSprintSpeed = iSprintSpeed + 1
	-- end
	
	local key_sprint = self.Owner:IsSprinting()
	if ( !key_sprint ) then
		return false 
	end 
	
	if ( self.Owner:GetMoveType() == MOVETYPE_NOCLIP ) then
		return false
	end
	
	-- dSprintSpeed = iSprintSpeed

	local iSprintSpeed = self.Owner:GetRunSpeed() - 10

	local pVelo = self.Owner:GetVelocity()
	local pSpeed = pVelo:Length()

	if ( key_sprint ) && ( self.Owner:OnGround() ) && ( pSpeed >= iSprintSpeed ) then 
		if ( self:GetSciFiState() == SCIFI_STATE_ADS ) then
			self:SetAds( false )
		end
		return true
	else
		-- print("speed not exceeding threshold", self.Owner:OnGround(), pSpeed, iSprintSpeed, key_sprint)
		return false
	end
	
end

function SWEP:OnSprint( bSprinting )

end

local fIdleTime, fAttackTime1, fAttackTime2
function SWEP:AnimsUpdate( value )

	if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then return end 

	if ( !value ) then
		local vm = self.Owner:GetViewModel()
		value = vm:SequenceDuration()
	end
	
	if ( value < 0 ) then 
--		DevMsg( "@" .. self:GetClass() .. " : !Error; Tried to set negative idle time (" .. value .. ")." )
	
		return 
	end

	self:SetAnimNextIdle( CurTime() + value )

end

local tTwoHanded = {
	["ar2"] = true,
	["smg"] = true,
	["rpg"] = true,
	["shotgun"] = true,
	["gravitygun"] = true
}

local kAlt, kUse
function SWEP:Anims()

	if ( !IsValid( self ) || !IsValid( self.Owner ) ) || ( !self.Owner:IsPlayer() ) then 
		DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) 
		return 
	end
	
	if ( CLIENT && cmd_autodestroysck:GetBool() && self.UseSCK && !self.SckInitalized ) then
		self:sckInit()
	end
	
	if ( self.GetSafeMode ) && ( !game.SinglePlayer() && CLIENT || SERVER ) then
		kAlt = self.Owner:KeyPressed( IN_WALK )
		kUse = self.Owner:KeyDown( IN_USE )
		
		if ( kAlt && kUse ) && ( self:GetNextPrimaryFire() < CurTime() ) then
			self:SetAds( false )

			if ( self:GetSafeMode() ) then
				self:SetSafeMode( false )
				self:EmitSound( self.SafeModeOffSnd )
				
				self.ViewModelIdleSequence = ACT_VM_IDLE
				self:SetHoldType( self.HoldType )
			else
				self:SetSafeMode( true )
				self:EmitSound( self.SafeModeOnSnd )
				
				self.ViewModelIdleSequence = ACT_VM_IDLE_LOWERED
				
				if ( tTwoHanded[ self.HoldType ] ) then
					self:SetHoldType( "passive" )
				else
					self:SetHoldType( "normal" )
				end
			end
			
			self:SetAnimNextIdle( CurTime() )
			self:SetNextPrimaryFire( CurTime() + 0.1 )

			self:SendWeaponAnim( self.ViewModelIdleSequence )
		end
	end

	local iState = self:GetSciFiState()
	
	self.SciFiState = iState -- self:GetSciFiState()
	
	if ( self.ViewModelIdleAnim ) && ( self:GetSciFiState() == SCIFI_STATE_IDLE ) then
		fIdleTime = self:GetAnimNextIdle()
		fAttackTime1 = self:GetNextPrimaryFire()
		fAttackTime2 = self:GetNextSecondaryFire()

		if ( SERVER || !game.SinglePlayer() ) then
			if ( fAttackTime1 > fIdleTime ) then
				local fDiff = fIdleTime - fAttackTime1
				fDiff = fDiff + 2
				self:AnimsUpdate( fDiff )
			end
			
			if ( fAttackTime2 > fIdleTime ) then
				local fDiff = fIdleTime - fAttackTime2
				fDiff = fDiff + 2
				self:AnimsUpdate( fDiff )
			end
			
			fIdleTime = self:GetAnimNextIdle()

			if ( fIdleTime >= 0 && fIdleTime < CurTime() ) then
				if ( self.Charge && self.Charge < 1 ) then
					self:AnimsUpdate()
					self:SendWeaponAnim( self.ViewModelIdleSequence )
				else
					self:AnimsUpdate( 1 )
				end
			end
		end
	end

	if ( iState == SCIFI_STATE_RELOADING ) then
		if ( self.SciFiStateDelta == SCIFI_STATE_ADS ) then
			self.SwayScale = self.DefaultSwayScale
			self.BobScale = self.DefaultBobScale
		end

		self.SciFiStateDelta = self.SciFiState
		return 
	end
	
	if ( iState == SCIFI_STATE_MELEE_ATTACK ) then 
		self.SciFiStateDelta = self.SciFiState
		return 
	end
	
	if ( iState == SCIFI_STATE_ADS ) then
		if ( self:IsSprinting() ) then
			self:SetSciFiState( -1 )
		end
		
		if !( self.SciFiStateDelta == SCIFI_STATE_ADS ) then
			self.SwayScale = 0
			self.BobScale = 0
		end
	
		self.SciFiStateDelta = self.SciFiState
		return 
	end

	if ( self.SciFiStateDelta == SCIFI_STATE_ADS ) then
		self.SwayScale 	= self.DefaultSwayScale
		self.BobScale 	= self.DefaultBobScale
	end


	local bAnims = cmd_advanims:GetBool()
	if ( bAnims ) then
		if ( iState != self.SciFiStateDelta ) && ( iState == SCIFI_STATE_SPRINT || self.SciFiStateDelta == SCIFI_STATE_SPRINT ) then
			self:OnSprint( iState == SCIFI_STATE_SPRINT )
			
			if ( CLIENT ) && ( iState != SCIFI_STATE_SPRINT ) then
				vMoveBob, aMoveBob = Vector( 0, 0, 0 ), Angle( 0, 0, 0 )
			end
		end
		
		if ( self:IsSprinting() ) then
			self:SetSciFiState( SCIFI_STATE_SPRINT )
		elseif ( !iState ) || !( self.SciFiStateDelta == SCIFI_STATE_IDLE ) then
			self:SetSciFiState( SCIFI_STATE_IDLE )
		end
		
		if ( self.SprintAnim ) then
			if ( self.SprintAnimIdle ) then
				if ( iState == SCIFI_STATE_SPRINT ) && !( self.SciFiStateDelta == SCIFI_STATE_SPRINT ) then
					self:SendWeaponAnim( ACT_VM_IDLE_TO_LOWERED )
				end

				if ( iState == SCIFI_STATE_IDLE ) && ( self.SciFiStateDelta == SCIFI_STATE_SPRINT ) then
					self:SendWeaponAnim( ACT_VM_IDLE )
				end
			end

			if ( self.SciFiStateDelta == SCIFI_STATE_SPRINT && iState == SCIFI_STATE_SPRINT ) then
				if ( self.SprintAnimIdle ) && !( iState == SCIFI_STATE_RELOADING ) then
					self:SendWeaponAnim( ACT_VM_IDLE )
				end

				if ( self.SwayScale ~= self.SprintSwayScale ) then
					self.SwayScale = self.SprintSwayScale
					self.BobScale = self.SprintBobScale
				end
				
				local wHType = self:GetHoldType()
				if ( wHType ~= self.HoldTypeSprint ) then
					self:SetHoldType( self.HoldTypeSprint )
				end
			elseif ( self.SciFiStateDelta == SCIFI_STATE_SPRINT ) && !( iState == SCIFI_STATE_SPRINT ) then
				if ( self.SwayScale ~= self.DefaultSwayScale ) then
					self.SwayScale = self.DefaultSwayScale
					self.BobScale = self.DefaultBobScale
				end

				local wHType = self:GetHoldType()
				if ( wHType ~= self.HoldType ) then
					self:SetHoldType( self.HoldType )
				end
			end
		end
	end

	self.SciFiStateDelta = iState

end

function SWEP:AdjustMouseSensitivity()
	
	if ( CLIENT ) then
		local IsAds = ( self:GetSciFiState() == SCIFI_STATE_ADS )
	
		if ( IsAds ) then
			local fSpeed = self.AdsMSpeedScale || cmd_adsmspeedscale:GetFloat()
			local fov = GetConVar( "fov_desired" ):GetFloat()
			
			if ( cmd_adsadativesens:GetBool() ) then
				fSpeed = fSpeed * math.Clamp( self.AdsFov * 2 / fov, 0, 1 )
			end

			return fSpeed
		else
			return 1
		end
	end

end

function SWEP:CanAds()

	if ( !IsValid( self.Owner ) ) then 
		return false
	end
	if ( self.Owner:IsNPC() ) then 
		return false
	end

	local key_use = self.Owner:KeyDown( IN_USE ) 
	
	if ( key_use ) && ( self.SciFiState ~= SCIFI_STATE_ADS ) then
		return false
	end
	
	if ( self:GetSciFiState() == SCIFI_STATE_SPRINT || self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
		return false
	end
	
	if ( self.Owner:InVehicle() ) then
		return false
	end
	
	return true

end

function SWEP:Ads()

	if ( !CLIENT ) then return end

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then 
		DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) 
		return 
	end
	
	if ( self.GetSafeMode && self:GetSafeMode() ) then 
		return 
	end
	
	self.AdsTransitionScale = fAnimAds
	
	if ( cmd_toggleaim:GetBool() ) then
		if ( !self.AdsTime ) then
			self.AdsTime = 0
		end
		
		if ( self.Owner:KeyPressed( IN_ATTACK2 ) && self.AdsTime < CurTime() ) then
			local bAds = !( self:GetSciFiState() == SCIFI_STATE_ADS )

			self:SetAds( bAds, true )
			
			self.AdsTime = CurTime() + FrameTime() * 4
		end
	else
		if ( self.Owner:KeyPressed( IN_ATTACK2 ) ) then
			self:SetAds( true, true )
		end

		if ( self.Owner:KeyReleased( IN_ATTACK2 ) ) then
			self:SetAds( false, true )
		end
	end
	
	if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
		self:SetAds( false, true )
	end

end

if ( SERVER ) then
	util.AddNetworkString( "SciFiADS" )
	util.AddNetworkString( "SciFiReload" )
	util.AddNetworkString( "SciFiUpdateOwnership" )
end

net.Receive( "SciFiADS", function( len, ply )

	local bool = net.ReadBool()
	local wep = ply:GetActiveWeapon()

	if ( !IsValid( wep ) || !wep.SetSciFiState ) then return end

	if ( bool ) then
		wep:SetSciFiState( SCIFI_STATE_ADS )
	else
		wep:SetSciFiState( SCIFI_STATE_IDLE )
	end
	
end )

function SWEP:GetIronSights()

	local bAds = ( self:GetSciFiState() == SCIFI_STATE_ADS )
	
	return bAds
	
end

net.Receive( "SciFiReload", function( len, ply )

	if ( !ply ) then
		ply = LocalPlayer()
	end

	if ( IsValid( ply ) ) then
		local bool = net.ReadBool()
		local bAds = net.ReadBool()
		local wep = ply:GetActiveWeapon()

		if ( !IsValid( wep ) || !wep.SetSciFiState || bool == nil ) then return end
		
		if ( bAds ) then
			wep._scifi_restore_ads_after_reload = bAds
		end

		if ( bool ) then
			-- wep:SetSciFiState( SCIFI_STATE_RELOADING )

			local vm = ply:GetViewModel()
			if ( IsValid( vm ) ) then
				vm:SetPlaybackRate( wep.ReloadPlaybackRate )
			end
			
			wep:OnReload()
		else
			-- wep:SetSciFiState( SCIFI_STATE_IDLE )
			
			local vm = ply:GetViewModel()
			if ( IsValid( vm ) ) then
				vm:SetPlaybackRate( 1 )
			end
	
			if ( wep._scifi_restore_ads_after_reload ) then
				if ( ply:KeyDown( IN_ATTACK2 ) || cmd_toggleaim:GetBool() ) then
					wep:SetAds( true, false )
				end
			end
			
			wep._scifi_restore_ads_after_reload = nil
			
			wep:OnReloadFinish()
		end
	end
	
end )

net.Receive( "SciFiUpdateOwnership", function( len, ply )

	if ( !CLIENT ) then return end
	
	local pOwner = net.ReadEntity()
	if ( !pOwner || pOwner == NULL ) then return end
	
	local vmEntity = pOwner:GetViewModel()
	
	for i=0, pOwner:GetBoneCount() do
		pOwner:ManipulateBoneScale( i, Vector(1, 1, 1) )
		pOwner:ManipulateBoneAngles( i, Angle(0, 0, 0) )
		pOwner:ManipulateBonePosition( i, Vector(0, 0, 0) )
	end

	if ( !IsValid( vmEntity ) ) then return end

	vmEntity:SetSubMaterial( 0, "" )
	vmEntity:SetSubMaterial( 1, "" )
	vmEntity:SetSubMaterial( 2, "" )
	vmEntity:SetSubMaterial( 3, "" )
	vmEntity:SetSubMaterial( 4, "" )
	
	if ( !vmEntity:GetBoneCount() ) then return end
	
	for i=0, vmEntity:GetBoneCount() do
		vmEntity:ManipulateBoneScale( i, Vector(1, 1, 1) )
		vmEntity:ManipulateBoneAngles( i, Angle(0, 0, 0) )
		vmEntity:ManipulateBonePosition( i, Vector(0, 0, 0) )
	end

end )

function SWEP:SetAds( adsBool, adsSounds )

	if ( !IsValid( self.Owner ) ) then return end
	if ( self.Owner:IsNPC() ) then return end
	
	if ( !self:CanAds() ) then return end

	if ( CLIENT ) then
		net.Start( "SciFiADS" )
			if ( adsBool ) then
				net.WriteBool( true )
				self.SciFiState = SCIFI_STATE_ADS
			else
				net.WriteBool( false )
				
				if ( self.SciFiState == SCIFI_STATE_ADS ) then
					self.SciFiState = SCIFI_STATE_IDLE
				end
			end
		net.SendToServer()

		if ( self.AdsSounds ) && ( adsSounds ) then
			if ( adsBool ) then
				self:EmitSound( self.AdsSoundEnable )
			else
				self:EmitSound( self.AdsSoundDisable )
			end
		end
	end

	if ( cmd_legacyzoom:GetBool() ) && ( ( SERVER ) || ( !game.SinglePlayer() && CLIENT ) ) then
		if ( !adsBool ) then
			local key_sprint = self.Owner:KeyDown( IN_SPEED )
		
			if ( key_sprint ) then
				self.Owner:SetFOV( 0, 0 )
			else
				self.Owner:SetFOV( 0, self.AdsFovTransitionTime )
			end
		end

		if ( adsBool ) && ( self:CanAds() ) && ( !self.AdsRTScopeEnabled || ( !cmd_rtsniperscopes:GetBool() && self.AdsRTScopeEnabled ) ) then
			local iFovEngine = cmd_engine_fovdesired:GetInt()
			local fovcompensation = iFovEngine / 56 + ( iFovEngine - 90 )
			local fov = self.AdsFov
			
			if ( self.AdsRTScopeEnabled && !cmd_rtscniperscopes:GetBool() ) then
				fov = fov * 1.75
			end
			
			fov = m_Round( self.AdsFov * fovcompensation, 2 )
		
			self.Owner:SetFOV( m_Clamp( fov, self.AdsFov, iFovEngine ), self.AdsFovTransitionTime )
		end
	end
	
	self.AdsMSpeedScale = cmd_adsmspeedscale:GetFloat()

	self:OnAds( adsBool )
			
	if ( CLIENT ) then --  && ( iState != SCIFI_STATE_SPRINT ) then
		vMoveBob = Vector( 0, 0, 0 )
		aMoveBob = Angle( 0, 0, 0 )

		vSway = Vector( 0, 0, 0 )
		aSway = Angle( 0, 0, 0 )
		aDiff = Angle( 0, 0, 0 )

		-- vecSprint = Vector( 0, 0, 0 )
		-- angSprint = Angle( 0, 0, 0 )
		-- angDelta = Angle( 0, 0, 0 )
	end

end

function SWEP:OnAds( adsBool )

end

local angNull = Angle(0, 0, 0)
local angVBob = Angle(0, 0, 0)
local FovAdapted = 0

function SWEP:CalcView( pOwner, vOrigin, aView, iFov ) 

	local iFrameTime 	= FrameTime()
	local iCurTime  	= CurTime()
	
	if ( !self.AdsRTScopeEnabled || ( self.AdsRTScopeEnabled && !cmd_rtsniperscopes:GetBool() ) ) then
		local FovEngine = iFov || cmd_engine_fovdesired:GetInt()
		local FovIntended = FovIndended || FovEngine

		if ( self:GetSciFiState() == SCIFI_STATE_ADS ) then
			local FovCompensation = FovEngine - 75 -- magic number of default FOV --
			
			FovAdapted = Lerp( iFrameTime * self.AdsTransitionSpeed, FovAdapted, ( FovEngine - ( self.AdsFov + FovCompensation ) ) )
		else
			FovAdapted = Lerp( iFrameTime * self.AdsTransitionSpeed, FovAdapted, 0 )
		end
		
		iFov = FovIntended - FovAdapted
	end
	
	local bRecoilToAV = cmd_recoiltoaimvector:GetBool()
	if ( bRecoilToAV ) || ( self.Owner.m_bBleedingOut ) then
		local aPunch = pOwner:GetViewPunchAngles()
		
		local aNew = aView - aPunch * 0.95
		aNew.roll = 0

		pOwner:SetEyeAngles( aNew )
	end
	
	local bAnims, bViewBob = cmd_advanims:GetBool(), cmd_viewbob:GetBool()
	if !( bAnims && bViewBob && GetViewEntity() == LocalPlayer() ) then return vOrigin, aView, iFov end
	
	local cos1, cos2
	local iPlayerSpeed 	= self.Owner:GetVelocity():Length()
	
	local pOwnerWS = self.Owner:GetWalkSpeed()
	local pOwnerRS = self.Owner:GetRunSpeed()

	if ( self.Owner:OnGround() ) && ( iPlayerSpeed > pOwnerWS ) then
		if ( iPlayerSpeed < pOwnerWS * 1.2 )  then
			cos1 = m_cos( iCurTime * ( 10 + pOwnerRS / 100 ) )
			cos2 = m_cos( iCurTime * ( 8 + pOwnerRS / 100 ) )
			angVBob.p = cos1 * 0.2
			angVBob.y = cos2 * 0.1
		else
			cos1 = m_cos( iCurTime * ( 18 + pOwnerWS / 100 ) )
			cos2 = m_cos( iCurTime * ( 10 + pOwnerWS / 100 ) )
			angVBob.p = cos1 * 0.4
			angVBob.y = cos2 * 0.2
		end
	else
		angVBob = LerpAngle( iFrameTime * 10, angVBob, angNull )
	end
	

	return vOrigin, aView + angVBob, iFov
	
end

function SWEP:ModulateViewModelPosition( pos, ang, newpos, newang, factor )

--	if ( factor <= 0 ) then return pos, ang end

	local rt = ang:Right()
	local up = ang:Up()
	local fw = ang:Forward()
	
	-- if ( !game.SinglePlayer() ) then
		-- factor = factor * 0.8
	-- end
	
	pos = pos + newpos.x * rt * factor
	pos = pos + newpos.y * fw * factor
	pos = pos + newpos.z * up * factor
	
	ang:RotateAroundAxis( rt, self.ViewModelHomeAng.x + ( newang.x * factor ) )
	ang:RotateAroundAxis( up, self.ViewModelHomeAng.y + ( newang.y * factor ) )
	ang:RotateAroundAxis( fw, self.ViewModelHomeAng.z + ( newang.z * factor ) )
	
	return pos, ang
	
end

local dMouseX = 0
local dMouseY = 0
function SWEP:GetMouseOffset()
	if ( !GetConVar( "sfw_allow_viewsway" ):GetBool() ) then 
		return false
	end
	
	local iMouseX, iMouseY = gui.MouseX(), gui.MouseY()
	local iDiffX = dMouseX - iMouseX
	local iDiffY = dMouseY - iMouseY
	
	dMouseX = iMouseX
	dMouseY = iMouseY
	
	local mAngle = Angle( 0, 0, 0 )
	mAngle.pitch = iDiffY
	mAngle.yaw = iDiffX

	return mAngle
end

local fSpeed = 0
local fMoveFW, fMoveRT = 0, 0
local kFW, kRT, kLT, kBK
function SWEP:ReadPlayerMovement( ang )

	if ( !CLIENT ) then return end
	if ( fSpeed < 1 ) then return end
	if ( !ang ) then return end
	if ( self.AdsRTScopeEnabled && self:GetSciFiState() == SCIFI_STATE_ADS ) || ( !self.ViewModelMoveBob ) then 
		aMoveBob = Angle( 0, 0, 0 )
		
		return 
	end
	
	kFW = self.Owner:KeyDown( IN_FORWARD )
	kRT = self.Owner:KeyDown( IN_MOVERIGHT )
	kLT = self.Owner:KeyDown( IN_MOVELEFT )
	kBK = self.Owner:KeyDown( IN_BACK )
	
	local fStrafe, fStride = 0, 0
	local vMoveActual = Vector( 0, 0, 0 )
	local aMoveActual = Angle( 0, 0, 0 )
	
	if ( kFW && !kBK ) then
		fStride = -2
	end
	
	if ( !kFW && kBK ) then
		fStride = 2
	end
	
	if ( kLT && !kRT ) then
		fStrafe = -2
		
		aMoveActual.roll = -5
	end
	
	if ( !kLT && kRT ) then
		fStrafe = 2

		aMoveActual.roll = 5
	end
	
	local fSpeed = FrameTime() * 8
	
	fMoveFW = Lerp( fSpeed, fMoveFW, fStride )
	fMoveRT = Lerp( fSpeed, fMoveRT, fStrafe )

	-- local Forward = ang:Forward()
	-- local Right = ang:Right()
	local Up = ang:Up()

	-- vMoveBob = vMoveActual + Right * fMoveRT * 1.1
	-- vMoveBob = vMoveActual + Forward * fMoveFW
	vMoveBob = vMoveActual + Up * fMoveRT * 0.225 -- 0.125

	aMoveBob = LerpAngle( fSpeed, aMoveBob, aMoveActual )

end

function SWEP:GetViewModelPosition( pos, ang )

	if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:IsPlayer() ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end

	local Forward 	= ang:Forward()
	local Right 	= ang:Right()
	local Up 		= ang:Up()

	local inspectkey = cmd_kb_inspect:GetInt() 
	local WaterLevel = self.Owner:WaterLevel()
	local fFrameTime = FrameTime()
	
	local bSway = GetConVar( "sfw_allow_viewsway" ):GetBool()
	local bAdsDeltaAnim = GetConVar( "sfw_allow_adsdeltaanim" ):GetBool()
	
	if ( bAdsDeltaAnim ) && ( !game.SinglePlayer() ) then
		fFrameTime = fFrameTime * self.ChargeDeltaFactor
	end
	
	-- if ( !game.SinglePlayer() ) then
		-- fFrameTime = fFrameTime * 0.7
	-- end
	
	local bCrouching = self.Owner:Crouching()
	
	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
	
	local bAdvancedAnimations = cmd_advanims:GetBool()
	
	local vang = self.Owner:EyeAngles()

	if !( self:GetSciFiState() == SCIFI_STATE_ADS ) && ( bAdvancedAnimations ) then
		local fPitchMod = m_abs( vang.pitch - 0.1, 0 )
		local fPitchLowered = m_max( vang.pitch, 0 )
		
		local vmod_pos = Vector( fPitchMod * -0.01, fPitchMod * 0.005, fPitchMod * -0.025 )
		local vmod_ang = Angle( 0, fPitchMod * 0.02, fPitchMod * 0.06 * ( 1 + fAnimSprint ) )
--[[		
		if ( self.ViewModelShift ) && ( fAnimSprint > 0 ) then
			local shiftOff, shiftRot = self.ViewModelShiftOffset, self.ViewModelShiftRotation
		
			vmod_pos = vmod_pos + ( Right * fPitchLowered * shiftOff.x ) + ( Forward * fPitchLowered * shiftOff.y ) + ( Up * fPitchLowered * shiftOff.z )

			vmod_pos.x = vmod_pos.x * ( 1 + self.ViewModelSprintPos.x * self.ViewModelShiftCounter * fAnimSprint )
			vmod_pos.y = vmod_pos.y * ( 1 + self.ViewModelSprintPos.y * self.ViewModelShiftCounter * fAnimSprint )
			vmod_pos.z = vmod_pos.z * ( 1 + self.ViewModelSprintPos.z * self.ViewModelShiftCounter * fAnimSprint )
			
			vmod_ang = vmod_ang - Angle( math.max( vang.pitch * shiftRot.x, 0 ), math.max( vang.pitch * shiftRot.y, 0 ), math.max( vang.pitch * shiftRot.z, 0 ) ) * fAnimSprint
		end
]]--		
		if ( self.ViewModelShift ) && ( fAnimSprint > 0 ) then
			local shiftOff, shiftRot = self.ViewModelShiftOffset, self.ViewModelShiftRotation
			
			vmod_pos = vmod_pos + ( ( ( Right * fPitchLowered * shiftOff.x ) + ( Forward * fPitchLowered * shiftOff.y ) + ( Up * fPitchLowered * shiftOff.z ) ) + self.ViewModelSprintPos * self.ViewModelShiftCounter ) * fAnimSprint
			vmod_ang = vmod_ang - Angle( math.max( vang.pitch * shiftRot.x, 0 ), math.max( vang.pitch * shiftRot.y, 0 ), math.max( vang.pitch * shiftRot.z, 0 ) ) * fAnimSprint
		end
		
		local pVelo = self.Owner:GetVelocity()
		fSpeed = pVelo:Length()

		if ( !pVeloMax ) then
			pVeloMax = self.Owner:GetRunSpeed()
		end
		
		vecSprint = Vector( 0, 0, 0 )
		
		local pVeloHold = pVeloMax * 0.25
		
		if ( bSway ) && ( fSpeed > pVeloHold ) then
			local iMul = ( self.ViewModelSprintRatio + pVeloMax / 100 )
			
			local fSprintCos = m_cos( CurTime() * iMul ) * fAnimSprint
			local fSprintSin = m_sin( CurTime() * iMul ) * fAnimSprint
			
			fSprintMod = m_tan( fSprintCos * fSprintSin, fSprintCos * fSprintSin ) * self.ViewModelSprintSway

			vecSprint = vecSprint + Right * ( fSprintMod * 0.2 )
			vecSprint = vecSprint + Forward * ( fSprintMod * 0.1 )
			vecSprint = vecSprint + Up * ( m_abs( fSprintMod ) * 1 )
		end
		
		if ( self.ViewModelReloadAnim ) then
			if ( self:GetSciFiState() == SCIFI_STATE_RELOADING ) then
				fAnimReload = m_Approach( fAnimReload, 1, fFrameTime * self.ViewModelReloadAnimSpeed )
			else
				if ( fAnimReload > 0 ) then 
					fAnimReload = m_Approach( fAnimReload, 0, fFrameTime * self.ViewModelReloadAnimSpeed )
				end
			end
			
			if ( fAnimReload > 0 ) then
				pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelReloadPos, self.ViewModelReloadAng, fAnimReload )
			end
		end
	
		if ( self.ViewModelInspectable ) then
			if ( input.IsKeyDown( inspectkey ) || input.IsMouseDown( inspectkey ) ) then
				fAnimMenu = m_Approach( fAnimMenu, 1, fFrameTime * 6 )
			else
				if ( fAnimMenu > 0 ) then 
					fAnimMenu = m_Approach( fAnimMenu, 0, fFrameTime * 4 )
				end
			end
			
			if ( fAnimMenu ) then
				pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelMenuPos, self.ViewModelMenuAng, fAnimMenu )
			end
		end
		
		local bSprinting = ( self:GetSciFiState() == SCIFI_STATE_SPRINT )
		
		if ( self.ViewModelSafeAnim ) then
			if ( self:GetSafeMode() && !bSprinting ) then -- && !( fAnimSpeed > 0 ) then
				fAnimSafety = m_Approach( fAnimSafety, 1, fFrameTime * 4 )
			else
				if ( fAnimSafety > 0 ) then
					fAnimSafety = m_Approach( fAnimSafety, 0, fFrameTime * 4 )
				end
			end
			
			if ( fAnimSafety > 0 ) then
				pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelSafePos, self.ViewModelSafeAng, fAnimSafety )
			end
		end
		
		if ( bSprinting && !bCrouching ) then
			fAnimSprint = m_Round( Lerp( fFrameTime * ( self.SprintAnimSpeed * 0.5 ), fAnimSprint, 1 ), 3 )
			pos = pos + vecSprint
		elseif ( WaterLevel > 2 ) then  
			fAnimSprint = m_Round( Lerp( fFrameTime * 2, fAnimSprint, 0 ), 2 )
		else
			fAnimSprint = m_Truncate( Lerp( fFrameTime * self.SprintAnimSpeed, fAnimSprint, 0 ), 2 )
		end
		
		pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelSprintPos, self.ViewModelSprintAng, fAnimSprint )
		
		if ( !bSprinting && bCrouching ) then
			fAnimCrouch = m_Approach( fAnimCrouch, 1, fFrameTime * 60 * self.Owner:GetDuckSpeed()  )
		elseif ( WaterLevel > 2 ) then  
			fAnimCrouch = m_Approach( fAnimCrouch, 0, fFrameTime * 60 * self.Owner:GetDuckSpeed() )
		else
			if !( fAnimCrouch == 0 ) then
				fAnimCrouch = m_Approach( fAnimCrouch, 0, fFrameTime * 60 * self.Owner:GetUnDuckSpeed() )
			end
		end
--[[		
		if ( self.Owner:KeyPressed( IN_JUMP ) ) then
			fAnimCrouch = -0.5
		end
]]--		
		pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelDuckPos, self.ViewModelDuckAng, fAnimCrouch )

		if ( self:GetMeleeCharge() ) && ( self:GetMeleeCharge() >= 20 ) then
			pos = pos + self.ViewModelSprintPos.z * Forward * ( self:GetMeleeCharge() - 20 ) * -0.022
			fAnimMelee = Lerp( fFrameTime * 2, fAnimMelee, -0.2 )
		end
		
		if ( self:GetSciFiState() == SCIFI_STATE_MELEE_ATTACK ) then
			if ( WaterLevel < 3 ) then
				fAnimMelee = Lerp( fFrameTime * 24, fAnimMelee, 1 )
			else
				fAnimMelee = Lerp( fFrameTime * 6, fAnimMelee, 1 )
			end
		else
			if ( fAnimMelee > 0 ) then
				if ( WaterLevel < 3 ) then
					fAnimMelee = m_Truncate( Lerp( fFrameTime * 8, fAnimMelee, 0 ), 3 )
				else
					fAnimMelee = m_Truncate( Lerp( fFrameTime * 2, fAnimMelee, 0 ), 3 )
				end
			end
		end

		pos = pos + self.ViewModelMeleePos.x * Right * fAnimMelee
		pos = pos + self.ViewModelMeleePos.y * Forward * fAnimMelee
		pos = pos + self.ViewModelMeleePos.z * Up * fAnimMelee
		
		ang:RotateAroundAxis( ang:Right(), self.ViewModelHomeAng.x + ( self.ViewModelMeleeAng.x * fAnimMelee ) )
		ang:RotateAroundAxis( ang:Up(), self.ViewModelHomeAng.y + ( self.ViewModelMeleeAng.y * fAnimMelee ) )
		ang:RotateAroundAxis( ang:Forward(), self.ViewModelHomeAng.z + ( self.ViewModelMeleeAng.z * fAnimMelee ) )
		
		pos = pos + vmod_pos
		ang = ang + vmod_ang
	end
		
	fSprintMod = fSprintMod * fAnimSprint
	
	if ( !self.AdsPos ) then return pos, ang end
	
	local speed = self.AdsTransitionSpeed
	
	if ( !game.SinglePlayer() ) then
		speed = speed * 0.6
	end
	
	local bAds = self:GetSciFiState() == SCIFI_STATE_ADS
	
	if ( self.AdsTransitionAnim && bAdvancedAnimations ) then
		if ( bAds ) then
			fAnimAds = Lerp( fFrameTime * speed, fAnimAds, 0.975 )
--			fAnimAds = m_Approach( fAnimAds, 0.975, fFrameTime * speed )
				
			if ( self.AdsRTScopeEnabled ) then
				vMoveBob = Vector( 0, 0, 0 )
				aMoveBob = Angle( 0, 0, 0 )
			end
		else
			if ( fAnimAds > 0 ) then
--				fAnimAds = Lerp( fFrameTime * speed, fAnimAds, 0 )
				fAnimAds = m_Approach( fAnimAds, 0, fFrameTime * speed )
			end
		end
	else 
		if ( bAds ) then
			fAnimAds = 0.975
		else
			fAnimAds = 0
		end
	end
	
	if ( fAnimAds > 0 ) then
		pos = pos + self.AdsPos.x * Right * fAnimAds
		pos = pos + self.AdsPos.y * Forward * fAnimAds
		pos = pos + self.AdsPos.z * Up * fAnimAds

		ang:RotateAroundAxis( ang:Right(), self.AdsAng.x * fAnimAds )
		ang:RotateAroundAxis( ang:Up(), self.AdsAng.y * fAnimAds )
		ang:RotateAroundAxis( ang:Forward(), self.AdsAng.z * fAnimAds )
	end

	if ( bSway && !bAds ) then
		local pitch, yaw, roll
		pitch 	= m_AngleDifference( ang.pitch, angDelta.pitch )
		yaw 	= m_AngleDifference( ang.yaw, angDelta.yaw )
		roll 	= m_AngleDifference( ang.roll, angDelta.roll )
		
		aDiff = Angle( pitch, yaw, roll )

		aSway = Angle( 0, 0, 0 )
		aSway.pitch = m_Clamp( pitch, -1, 1 )
		aSway.yaw 	= m_Clamp( yaw, -1, 1 )
--		aSway.roll 	= m_Clamp( roll, -1, 1 )

		aSway.pitch = m_Round( pitch * 0.08, 3 )
		aSway.yaw 	= m_Round( yaw * 0.08, 3 )
--		aSway.roll 	= m_Round( roll / 12, 3 )
--[[
		vecMove = Vector( cMoveFW, cMoveUP, cMoveRT ) * 0.1
		angMove = Angle( cMoveFW / 10, 0, cMoveRT ) * 0.2

		vecDelayed = LerpVector( fFrameTime * 4, vecMove, vecDelayed )
		angDelayed = LerpAngle( fFrameTime * 2, angMove, angDelayed )
]]--
		local ratio = fFrameTime * 16 * self.ChargeDeltaFactor
		angDelta = LerpAngle( ratio, angDelta, ang )
		
		local fForwardOffset = 1 - 4 * ( 0.975 - fAnimAds )
		
		vSway = Vector( 0, 0, 0 ) + Right * fForwardOffset * aSway.yaw * 0.1 + Up * aSway.pitch * 0.1 -- Vector( aSway.yaw * -0.4, 0, aSway.pitch * 0.4 )

		local aSway2 = Angle( self.ViewModelSwayDirection.x, self.ViewModelSwayDirection.y * 1.4, self.ViewModelSwayDirection.z ) * fSprintMod
		-- aSway2 = aSway2 + Angle( 0, 12 * fSprintMod, 0 )

		vSway = vSway + Forward * aSway2.pitch * self.ViewModelSwayStrength.x -- 0.5
		vSway = vSway + Right * aSway2.yaw * self.ViewModelSwayStrength.y -- 0.125
		
		self:ReadPlayerMovement( ang )
-- vSway = vSway * 10
		pos = pos + vSway + vMoveBob -- + vecDelayed
		-- ang = ang + aSway + aSway2 + angVBob * ( fAnimSprint * 4 ) -- + angDelayed
		ang = ang + aSway + aSway2 + aMoveBob + angVBob * ( fAnimSprint * 4 ) -- + angDelayed
	end

	return pos, ang
	
end

function SWEP:OnReloaded()

	self:SubInit()
	
	if ( IsValid( self.Owner ) ) then
		if ( self.Owner:IsPlayer() ) then 
			self:SetHoldType( self.HoldType )
		else
			self:SetHoldType( self.HoldTypeNPC )
		end
	end
	
end

function SWEP:CanBePickedUpByNPCs()
	return true
end

function SWEP:TranslateActivity( act )

	if ( self.Owner:IsNPC() ) then
		if ( act == ACT_RELOAD ) then
			local iState = self:GetSciFiState()
			local ammo = self:Clip1()
			
			local bReloading = iState == SCIFI_STATE_RELOADING
			
			if ( ammo < self.Primary.ClipSize ) then
				if ( !bReloading ) then
					self:SetSciFiState( SCIFI_STATE_RELOADING )
					
					if ( self.ReloadSND ) then
						self:EmitSound( self.ReloadSND )
					end
					
				end
			else
				if ( bReloading ) then
					self:SetSciFiState( SCIFI_STATE_IDLE )
				end
			end
		end
		
		if ( self.ActivityTranslateAI[ act ] ) then
			return self.ActivityTranslateAI[ act ]
		end
		
		return -1
	end

	if ( self.ActivityTranslate[ act ] != nil ) then
		return self.ActivityTranslate[ act ]
	end

	return -1

end

function SWEP:SetupWeaponHoldTypeForAI( t )

	if ( !self.HoldTypeAnimationOverride || !t ) then return end

	if ( t == "grenade" ) then
	
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_GRENADE_TOSS 
	
	end
	
	if ( t == "smg" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_SMG1
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SMG1
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_SMG1
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_SMG1

	return end
	
	if ( t == "ar2" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SMG1
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
--		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_AR2
--		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_SMG1
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_AR2_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_AR2

	return end

	if ( t == "pistol" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_PISTOL
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_PISTOL
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_PISTOL
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_PISTOL
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_PISTOL
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_PISTOL_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_PISTOL_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_PISTOL
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_PISTOL_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_PISTOL_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_PISTOL
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_PISTOL_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_PISTOL_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_PISTOL
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_PISTOL_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_PISTOL_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_PISTOL
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_PISTOL_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_PISTOL_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_PISTOL
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_PISTOL_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_PISTOL_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_PISTOL
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_PISTOL
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_PISTOL
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_PISTOL
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_PISTOL
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_PISTOL
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_PISTOL
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_PISTOL

	return end
	
	if ( t == "shotgun" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SHOTGUN
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SHOTGUN_LOW
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_AR2
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_AR2_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_AR2

	return end

end

function SWEP:DrawSciFiBaseDebugInfo()

	local bShowAnimScaling = cmd_debug_showanimscaling:GetBool()
	if ( !bShowAnimScaling ) then return end

	local w, h = ScrW(), ScrH()
	local x, y = w * 0.05, h * 0.25
	
	local offset = 0
	
	local dbFont = "DebugFixed"
	local dbColorText = Color( 255, 255, 255, 255 )
	local dbColorPanel = Color( 50, 55, 60, 200 )
	
	cam.Start2D( Vector( x, y ), 1 )
		draw.WordBox( 4, x - 16, y + offset, "Animation Scaling", dbFont, dbColorPanel, dbColorText )
		offset = offset + 32
		draw.WordBox( 4, x, y + offset, "Sprint 		: " .. fAnimSprint .. " / " .. fSprintMod .. " / " .. tostring( vecSprint ), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Crouch 		: " .. fAnimCrouch, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Reload 		: " .. fAnimReload, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Melee  		: " .. fAnimMelee, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "ADS    		: " .. fAnimAds, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Inspect		: " .. fAnimMenu, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Safety			: " .. fAnimSafety, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Bob			: " .. tostring( vMoveBob ) .. ", " .. tostring( aMoveBob ), dbFont, dbColorPanel, dbColorText )
		offset = offset + 48
		draw.WordBox( 4, x - 16, y + offset, "Anim table", dbFont, dbColorPanel, dbColorText )
		offset = offset + 32
		draw.WordBox( 4, x, y + offset, "bob scale  : " .. self.BobScale, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "sway scale : " .. self.SwayScale, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "sway angle  	: " .. tostring(angDelta), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "sequence   : " .. self:GetSequenceName(self:GetSequence()) .. " / " .. self:GetSequenceActivityName(self:GetSequence()), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "idle time  	: " .. tostring(fIdleTime) .. " / " .. tostring(CurTime()), dbFont, dbColorPanel, dbColorText )
		offset = offset + 48
		draw.WordBox( 4, x - 16, y + offset, "State", dbFont, dbColorPanel, dbColorText )
		offset = offset + 32
		draw.WordBox( 4, x, y + offset, "internal  : " .. tostring(self.SciFiState), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "delta  			: " .. tostring(self.SciFiStateDelta), dbFont, dbColorPanel, dbColorText )
		offset = offset + 48
		draw.WordBox( 4, x - 16, y + offset, "Balances", dbFont, dbColorPanel, dbColorText )
		offset = offset + 32
		draw.WordBox( 4, x, y + offset, "SciFiACC  : " .. tostring(self:GetSciFiACC()), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Charge  			: " .. tostring(self:GetCharge()), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Delta Factor  		: " .. tostring(self.ChargeDeltaFactor), dbFont, dbColorPanel, dbColorText )
	cam.End2D()
	
end