-- sfw_sg550 --
-- Darken217's Sci-Fi Weapons, Update 16: Midnight Dawn --

-- AddCSLuaFile it.
AddCSLuaFile()

-- Include the base. Yes, this sort of happens twice, but this is more of a percussion for multiplayer scenarios, so the server is always setting the rules and to prevent massive explointing.
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

-- This weapon isn't listed in the spawn menu, however it can be found through the search tab.
SWEP.Spawnable 				= false

-- Info to show in the bubble in weapon selection or on IHL item cards.
SWEP.Purpose				= "An examplary weapon for testing and learning purposes."
SWEP.Instructions			= "Mouse1 to fire, Mouse2 + 'Use' (def. 'E') to toggle laser"
SWEP.ItemRank 				= 14

-- View- and world-model. We're using the a CSS model from Gmod's resources. Note, that gmod only delivers the model, NOT the materials, as those are derived from CSS.
SWEP.ViewModel				= "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel				= "models/weapons/w_snip_sg550.mdl"

-- 3rd-person hold types.
SWEP.HoldType 				= "ar2"
SWEP.HoldTypeNPC 			= "ar2"

-- Deploy speed. The weapon is ready-to-use AFTER the deploy event has expired. The following value is not a value in seconds, it's a speed multiplier.
SWEP.DeploySpeed 			= 1.6

-- SWEP data... 
SWEP.PrintName				= "SG550"
SWEP.Slot					= 3
SWEP.SlotPos				= 1
SWEP.ViewModelFOV			= 60

SWEP.Primary.ClipSize		= 24
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "smg1" -- It uses HL2 smg ammo.

-- Information for muzzle effects. We'll be using a base internal function for particle effect management.
SWEP.VfxMuzzleAttachment 	= "1"							-- The attachment ID on the viewmodel the muzzle flash particle will be parented to.
SWEP.VfxMuzzleParticle 		= "ngen_muzzle_4"				-- The name of the particle system you want to use as a muzzle flash. When using the internal muzzle function, this should be an effect that has a limited lifetime. (no continuous emitter without lifetime limitation)
SWEP.VfxHeatParticle 		= "gunsmoke"					-- The name of a heat or gunsmoke particle system you want to use. This will only be spawned if "sfw_fx_heat" is set to 1.
SWEP.VfxHeatThreshold 		= 0.2							-- Factor that determines when the heat particle should be spawn along with the muzzle flash. This depends on the current recoil/overheat level. (self:GetSciFiACC() * self.VfxHeatThreshold)

SWEP.VfxMuzzleColor 		= Color( 255, 130, 100, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleFarZ 			= 720
SWEP.VfxMuzzleProjexture 	= "effects/mf_light" 			-- The texture you want to use for real-time muzzle lights. Keep in mind, that this needs to be a texture (.vtf) not a material (.vmt).

-- Override the weapon's index '0' sub-material with the rt_scope. 
SWEP.SciFiSkin 				= "models/weapons/misc/rt_scope"

-- Move the viewmodel to those coordinates while aiming down sights.
SWEP.AdsPos 				= Vector( -7.641, -12, 1.56 )
SWEP.AdsAng 				= Vector(0, 0, 0)

-- Static aim-down-sights data.
SWEP.AdsFov 				= 4								-- FOV. As we'll be using rt_scope for zooming, this will not change the player's primary FOV, but will directly effect the FOV of the scope render target.
SWEP.AdsTransitionSpeed		= 12 							-- Animation speed.
SWEP.AdsRTScopeEnabled 		= true							-- Use rt_scope. This is required, otherwise the base won't record / store a render target in the rt_scope material.
SWEP.AdsRTScopeScaling 		= true 							-- As we've applied the rt_scope material directly on the model, we'll have to check if it's flipped or mirrored. In this particular case, it appears to be mirrored, so we re-mirror the render target.
SWEP.AdsRTScopeScaleX 		= -1 							-- Reverse the recored render target's x-axis. Technically, this flips the image around the y-axis.
SWEP.AdsRTScopeSizeX 		= 256
SWEP.AdsRTScopeSizeY 		= 256
SWEP.AdsRTToneMapBalance 	= 3

if ( CLIENT ) then
	-- Static fake-DOF effect while aiming down sights. 
	SWEP.AdsBlurIntensity	= 2 			-- strength.
	SWEP.AdsBlurSize		= ScrH() / 2 	-- size relative to screen size.
	
	-- Mouse sensitivity modifier while zooming. This will slow down mouse movement severely to allow a more steady aim while zooming.
	SWEP.AdsMSpeedScale		= GetConVarNumber( "sfw_adsmspeedscale" ) * 0.2
end

-- Melee --
SWEP.SciFiMeleeASpeed		= 0.6 							-- Base-attack-speed.
SWEP.SciFiMeleeRange		= 55 							-- Range. This shouldn't be too insane, as this isn't a baseball-bat after all.
SWEP.SciFiMeleeDamage		= 8								-- Damage. Nothing more to say here.
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium" 	-- The sound that's played when performing the melee attack. This is NOT the impact sound.

-- The position/angles to modulate the viewmodel to while sprinting
SWEP.ViewModelSprintPos		= Vector( 4, 1, 0 )
SWEP.ViewModelSprintAng		= Angle( -18, 35, -5 )
SWEP.SprintAnimIdle			= false -- We're using a weapon model from CSS. Those don't have the lowered-idle animations we're usually using for fake sprint animations.
SWEP.SprintAnimSpeed		= 10 -- gotta go fast.

SWEP.ViewModelMeleePos		= Vector( 18, 4, -8 )
SWEP.ViewModelMeleeAng		= Angle( -12, 85, -80 )
SWEP.ViewModelMenuPos		= Vector( 18, 2, -2 )
SWEP.ViewModelMenuAng		= Angle( 20, 60, -10 )

SWEP.ReloadTime				= 4 -- Fake reload duration. This is the actual attack delay from the moment we've started reloading.
SWEP.ReloadRealisticClips 	= true -- Fake a realistic clip mechanic. Meaning, that you'll keep 1 bullet in the barrel, when we reloading with a non-empty clip.

-- SciFi families. Those can effect the color of custom item halos and serve as reference for tooltips.
SWEP.SciFiFamily			= { "base", "hitscanbullets", "ads" }

-- The weapon's item card that is shown while inspecting or on IHL.
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 24", color = Color( 180, 180, 180 ) },
	["1a"] = { text = "Crit. mul.: 				4x", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Bullet", color = Color( 185, 180, 160 ) },
	["5"] = { text = "Fire rate: 				 12 (semi-auto)", color = Color( 180, 180, 180 ) },
	["4"] = { text = "Clip size: 					24", color = Color( 180, 180, 180 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageAmount = 24,
		DamageType = DMG_BULLET,
		CritMul = 4,
		FireRate = { 
			{ RateTitle = "semi-auto", RateDelay = 0.2 },
		}
	},
	ClipSize = 24,
	ReloadSpeed = 3.2,
	Recoil = 24
}

-- Laser-pointer materials. Those are defined outside SCK for reasons.
SWEP.mat_laser_line = Material( "effects/laser_line2.vmt" )
SWEP.mat_laser_glow = Material( "models/weapons/v_mk23/dot2.vmt" )

-- Precache the sounds.
local snd_gunfire = Sound( "weapons/asa/rev_nosilent_echo.wav" )
local snd_gunecho = Sound( "npc/sniper/echo1.wav" )

-- SCK tables. In this case, we're just using it to add the lasers.
SWEP.VElements = {
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 255, 20, 10 ), bone = "v_weapon.SG550_Parent", pos = Vector( -0.2, -3.8, -22 ), angle = Angle( -90, 0, 0 ), range = 8192, line_size = 2, haze_size = 0.1, dot_size = 1.4 }
}

SWEP.WElements = {
	["point"] = { type = SCIFI_SCK_TYPE_LASER, color = Color( 255, 20, 10 ), bone = "ValveBiped.Bip01_R_Hand", pos = Vector( 10.6, 2.2, -4 ), angle = Angle( -8, 0, 0 ), range = 8192, line_size = 0.6, haze_size = 0.1, dot_size = 2 }
}

-- On-Initialize-Event.
function SWEP:SubInit()

	-- Create an empty control variable we can access all the time.
	-- We'll need this when we come to toggling the laser on or off.
	self.NextLaserToggle = 0

end

function SWEP:Think()

	-- Make the laser toggleable. 
	-- Due to SCK being client-side anyway, this has to be ran client-side as well, so we don't even bother the server.
	if ( CLIENT ) && ( self.NextLaserToggle <= CurTime() ) then
	
		-- Precache the input keys we're looking for. 
		-- You should really consider doing this, so you don't have to flood the garbage collector with the data returend from player.KeyDown().
		local key_attack2 = self.Owner:KeyDown( IN_ATTACK2 )
		local key_use = self.Owner:KeyDown( IN_USE )
		
		-- Due to this being part of the SWEP table, this doesn't have to be precached, however I didn't wanted to type the whole thing evertime.
		local vLaser = self.VElements[ "point" ]
		local wLaser = self.WElements[ "point" ]
		
		-- Change the 'disabled' value when 'Mouse2' and 'E' are pressed simultaniously.
		if ( key_attack2 && key_use ) then
			-- if it's true, make it false and the other way around.
			if ( vLaser.disabled ) then
				vLaser.disabled = false
				wLaser.disabled = false
			else
				vLaser.disabled = true
				wLaser.disabled = true
			end
			
			-- Now we came this far, that we actually toggled the laser, but we have to put in a delay, so we don't toggle once per frame. This whole if-loop will only run, if our current point in time is past the last toggle + delay.
			self.NextLaserToggle = CurTime() + 0.5
		end
	end

	-- The SciFi base's four default functions that should be ran in Think(). 
	self:Ads() -- aim-down-sights mechanic.
	self:Anims() -- sprint animations.
	self:SciFiMath() -- recoil math.
	self:SciFiMelee() -- melee (damage mechanics, not animations).

end

function SWEP:PrimaryAttack()

	-- Check, if we are capable of shooting right now. 
	-- SWEP.CanPrimaryAttack( Cap, CanUnderWater )
	if ( !self:CanPrimaryAttack( 0, true ) ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 0.2 )
	
	-- Scifi damage amplifier
	local cmdDamage = GetConVarNumber( "sfw_damageamp" )
	
	-- Store the current viewmodel so we don't have to call it everytime again.
	local vmEntity = self:GetViewModelEnt() 		-- Our current viewmodel.
	local vmAttach = vmEntity:LookupAttachment("1") -- The muzzle attachment. Note, that this can be named differently, depending on the used model. On CSS weapons, it's usually called "1", on HL2 weapons "muzzle".
	
	-- If you use the same to-be-retrieved data several times per function, consider precaching it.
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerSP = self.Owner:GetShootPos()
	
	-- Bullet structures. 'bullet' is the first bullet trace from the player's weapon to the point they're shooting at, 'ptru' is the second bullet to fake a punch-through scenario.
	local ptru = {}
	ptru.Num = 1
	ptru.Spread = Vector( 0, 0 )
	ptru.Tracer = 0 -- Don't render a tracer effect for punch-through bullets.
	ptru.Distance = 128
	ptru.Damage = 18 * cmdDamage
	ptru.AmmoType = "smg1"

	local bullet = {}
	bullet.Num = 1
	bullet.Src = pOwnerSP
	bullet.Dir = pOwnerAV
	bullet.Spread = Vector( .0021, .0021 ) + ( Vector( 0.01, 0.4 ) * ( self:GetSciFiACC() * 0.4 ) ) -- Spread computation. self:GetSciFiACC() represents the current recoil level.
	bullet.Tracer = 1
	bullet.Force = 2
	bullet.HullSize = 0.1
	bullet.Damage = 24 * cmdDamage
	bullet.AmmoType = "smg1"
	bullet.TracerName = "spr_tracer" -- Lookup towards the gLua tracer effect. Attachment magic happens in that one, not in the weapon or the bullet.
	bullet.Callback = function( attacker, tr, dmginfo ) -- OnImpact callback.
		-- Change the damage type. This can be any composition of DMG_ enums you can think of.
		dmginfo:SetDamageType( bit.bor( DMG_BULLET, DMG_GENERIC ) )
		
		-- Increased damage on headshots: ( Base damage * head-modifier (2x) ) * 2. This can also be used to cheese a weapon to have no crit. multiplier at all.
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( dmginfo:GetDamage() * 2 )
		end
		
		-- Fire the punch-through bullet. Note, that some enemy's hitboxes are larger then ptru bullet's spawn offset, causing the weapon to hit the same target with both bullets, inflicting damage every time.
		ptru.Src = tr.HitPos + pOwnerAV * 4 -- Spawn offset: Impact position + player aim direction * 4.
		ptru.Dir = pOwnerAV -- The direction is not accurate as it just repeates the player's aim vector instead of respecting spread and so on.
		self.Owner:FireBullets( ptru, false )
	end
	
	-- Spawn the first bullet.
	self.Owner:FireBullets( bullet, false )
	
	-- Create a particle muzzle flash. The entire effect happens inside the particle and isn't touched by gLua. The particle spawn and alingment however is done by the base.
	self:DoMuzzleEffect()
	
	-- View-punch effect. This modulates the player's view angles. The intensity is effected by the current recoil/overheat level (self:GetSciFiACC()).
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -2.2, -2.6 ), math.random( -0.1, -0.5 ), math.random( -0.1, -0.3 ) ) * ( 1 + self:GetSciFiACC() * 0.1 ) )
	end
	
	-- Sounds. Note, that the first sound is played in CHAN_WEAPON, so it will be overriden by other sounds in that channel. The second one is in CHAN_STATIC and is also considerable louder to create an "echo" effect.
	self:EmitSound( snd_gunfire, 100, math.random( 95, 105), 0.6, CHAN_WEAPON ) -- "cat.vk21.pfire" ) -- We could use the already precached sound, but I want this thing to be loud.
	self:EmitSound( snd_gunecho, 100, math.random( 95, 105), 1, CHAN_STATIC )
	
	-- Play animations. SetAnimation() only effects the world model, SendWeaponAnim() the viewmodel.
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	-- Remove 1 ammo from our current clip.
	self:TakePrimaryAmmo( 1 )
	
	-- Increase the recoil level. Note that the self:GetSciFiACC() value is constantly decreasing towards 0, so your added value has to be high enough that continuous fire would counter-act the drain.
	self:AddSciFiACC( 14 )

end