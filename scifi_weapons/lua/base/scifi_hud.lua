--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v18 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Hud displays and custom IHL							--
------------------------------------------------------------------
-- Has to be included by a weapon via AddCSLuaFile()			--
------------------------------------------------------------------

AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )
AddCSLuaFile( "base/scifi_render.lua" )
include( "base/scifi_render.lua" )

SCIFI_INTEGRITY_FLAG_HUD = 20210727213519

SCIFI_PERK_DISSOLVE_LIGHT = 0
SCIFI_PERK_DISSOLVE_HEAVY = 1
SCIFI_PERK_ESCALATINGDAMAGE = 2
SCIFI_PERK_ESCALATINGSTATUS = 3
SCIFI_PERK_PRECISIONSTATUS = 4
SCIFI_PERK_TARGETING_SIMPLE = 5
SCIFI_PERK_TARGETING_SMART = 6
SCIFI_PERK_ELEMENTAL_FIRE = 7
SCIFI_PERK_ELEMENTAL_CORROSIVE = 8
SCIFI_PERK_ELEMENTAL_ICE = 9
SCIFI_PERK_ELEMENTAL_SHOCK = 10
SCIFI_PERK_ELEMENTAL_BLIGHT = 11
SCIFI_PERK_ELEMENTAL_DARK = 12
SCIFI_PERK_ELEMENTAL_GRAVRIFLE_ONKILL = 13
SCIFI_PERK_ELEMENTAL_GRAVRIFLE_OVERCHARGE = 14
SCIFI_PERK_RELOAD_TACTICAL = 15
SCIFI_PERK_RELOAD_REALISTICCLIPS = 16
SCIFI_PERK_RELOAD_FROMRESERVES = 17
SCIFI_PERK_RELOAD_RECHARGEAMMO = 18
SCIFI_PERK_RELOAD_RECHARGEAMMO_DARK = 19
SCIFI_PERK_RELOAD_OVERHEAT = 20
SCIFI_PERK_RELOAD_OVERHEAT_CONDUCTOR = 21
SCIFI_PERK_AMMO_HIGHCAL = 22
SCIFI_PERK_AMMO_SUPERHEATED = 23
SCIFI_PERK_AMMO_TOXIC = 24
SCIFI_PERK_AMMO_RADIATION = 25
SCIFI_PERK_AMMO_EXPLOSIVE = 26
SCIFI_PERK_AMMO_DELAYEDEXPLOSION = 27
SCIFI_PERK_AMMO_RESURGENCE = 28
SCIFI_PERK_AMMO_PUNCHTHROUGH_LIGHT = 29
SCIFI_PERK_AMMO_PUNCHTRHOUGH_HEAVY = 30
SCIFI_PERK_AMMO_RICOCHET_LIGHT = 31
SCIFI_PERK_AMMO_RICOCHET_HEAVY = 32
SCIFI_PERK_AMMO_DAMAGEFALLOFF = 33
SCIFI_PERK_ACCESSORY_RECOIL = 34
SCIFI_PEKR_ACCESSORY_SILENT = 35
SCIFI_PERK_CHAMBER_MULTISHOT = 36
SCIFI_PERK_CHAMBER_ESCALATING = 37
SCIFI_PERK_BARREL_ACCURACY = 38
SCIFI_PERK_BARREL_STEALTH = 39
SCIFI_PERK_FANG_TRIPPLETAP = 40
SCIFI_PERK_TALON_SWITCHBLADE = 41
SCIFI_PERK_APEX_TARGETMARKED = 42
SCIFI_PERK_PHASMA_SWORDANDSHIELD = 43
SCIFI_PERK_PRISMA_OVERCLOCKEDCORE = 44
SCIFI_PERK_ZEALA_UNSTABLECHARGE = 45
SCIFI_PERK_CORRUPTED_RAVENOUS = 46
SCIFI_PERK_CORRUPTED_IMPURERELOAD = 47
SCIFI_PERK_CURSE_DOUBLEAMMODRAW = 48
SCIFI_PERK_AMMO_STICKYGRENADES = 49
SCIFI_PERK_CHAMBER_ESCALATINGFIRERATE = 50
SCIFI_PERK_CHAMBER_WINDUP = 51
SCIFI_PERK_ELEMENTAL_STATUSDURATION = 52
SCIFI_PERK_CHAMBER_ACCELERATOR = 53
SCIFI_PERK_EMBER_LASERFOCUS = 54
SCIFI_PERK_AMMO_CONTACTGRENADES = 55
SCIFI_PERK_VECTRA_MULTISHOT = 56
SCIFI_PERK_HALFLIFEWEAPON = 57
SCIFI_PERK_AMMO_CRITICAL = 58
SCIFI_PERK_STORM_BURSTDOWNSIGHTS = 59
SCIFI_PERK_MMRIFLE_HIGHLIGHTOPTICS = 60

local tPerkSet = {
	[ SCIFI_PERK_DISSOLVE_LIGHT ] 					= { PerkTitle = "Energy Munitions", 				PerkDescription = "Dissolves enemy corpses." },
	[ SCIFI_PERK_DISSOLVE_HEAVY ] 					= { PerkTitle = "Supercharged Ordnance", 			PerkDescription = "Dissolves corpses and props." },
	[ SCIFI_PERK_ESCALATINGDAMAGE ] 				= { PerkTitle = "Relentless", 						PerkDescription = "Consecutive hits on the same target build up Relentless stacks, each granting +10% damage boost for 1 second. Relentless stacks reset when a shot hits something other than the previous target or when the timer runs out." },
	[ SCIFI_PERK_ESCALATINGSTATUS ] 				= { PerkTitle = "Catalyst", 						PerkDescription = "Consecutive hits on the same target increase status chance by 20%." },
	[ SCIFI_PERK_PRECISIONSTATUS ] 					= { PerkTitle = "Catalytic Rounds", 				PerkDescription = "+20% chance to inflict elemental status effects on critical hits." },
	[ SCIFI_PERK_TARGETING_SIMPLE ] 				= { PerkTitle = "Electro-magnetic Guidance System", PerkDescription = "The weapon's EMG can guide projectiles, closely following the player's aim direction." },
	[ SCIFI_PERK_TARGETING_SMART ] 					= { PerkTitle = "Smart Targeting Acquisition", 		PerkDescription = "Projectiles will lock on to targets, homing in on them." },
	[ SCIFI_PERK_ELEMENTAL_FIRE ] 					= { PerkTitle = "Pyro Munitions", 					PerkDescription = "Chance to ignite targets. Burning targets take damage over time, rapid infliction creates bursts of fire, damaging targets. Burning combine soldiers are likely to panic. Fire status is lethal to minor antlions." },
	[ SCIFI_PERK_ELEMENTAL_CORROSIVE ] 				= { PerkTitle = "Chemical Payload", 				PerkDescription = "Chance to coat target in acid, taking low damage over time. Corroding targets take drastically increased damage, damage resistances are lowered or removed." },
	[ SCIFI_PERK_ELEMENTAL_ICE ] 					= { PerkTitle = "Cryo Munitions", 					PerkDescription = "Chance to freeze targets. Lethal against headcrabs." },
	[ SCIFI_PERK_ELEMENTAL_SHOCK ] 					= { PerkTitle = "Electric Rounds", 					PerkDescription = "Chance to electrocute targets, dealing massive damage to shields. NPCs are briefly stunned, players are blinded. Shock status may chain to nearby targets. Low chance for turrets to jam or overload." },
	[ SCIFI_PERK_ELEMENTAL_BLIGHT ] 				= { PerkTitle = "Astral Purge", 					PerkDescription = "Chance to shift targets into a different dimension, locking them in place. While suffering from this effect, NPCs are unaware and will take full stealth damage and will panic upon release." },
	[ SCIFI_PERK_ELEMENTAL_DARK ] 					= { PerkTitle = "Undying Hunger", 					PerkDescription = "Inflicting status effects builds up dark stacks. Dark stacks increase incoming dark damage. Targets dying to dark damage while under the effect of dark status will drop impure spectrum. Damaging darkened targets with this weapon restores health." },
	[ SCIFI_PERK_ELEMENTAL_GRAVRIFLE_ONKILL ] 		= { PerkTitle = "Destablize", 						PerkDescription = "Destabilizes targets, causing them to explode on death. Explosions can chain to nearby targets, causing them to explode as well." },
	[ SCIFI_PERK_ELEMENTAL_GRAVRIFLE_OVERCHARGE ] 	= { PerkTitle = "Critical Mass", 					PerkDescription = "4 consecutive hits within a brief timespan cause a target to destabilize and explode." },
	[ SCIFI_PERK_RELOAD_TACTICAL ] 					= { PerkTitle = "Tactical Reload", 					PerkDescription = "Reloading before emptying the magazine significantly improves reload speed." },
	[ SCIFI_PERK_RELOAD_REALISTICCLIPS ] 			= { PerkTitle = "[PH] Realistic Clips", 			PerkDescription = "Reloading before emptying the magazine will cause leftover ammo to be lost." },
	[ SCIFI_PERK_RELOAD_FROMRESERVES ] 				= { PerkTitle = "Inventory Uplink", 				PerkDescription = "This weapon draws ammo immediately from reserves." },
	[ SCIFI_PERK_RELOAD_RECHARGEAMMO ] 				= { PerkTitle = "Rift Engine", 						PerkDescription = "Weapon is powered by recharging energy core. Ammo regenerates over time when in idle." },
	[ SCIFI_PERK_RELOAD_RECHARGEAMMO_DARK ] 		= { PerkTitle = "Greed", 							PerkDescription = "Able to leech health from the user and convert into ammo, when reserves are low." },
	[ SCIFI_PERK_RELOAD_OVERHEAT ] 					= { PerkTitle = "Unsealed Core", 					PerkDescription = "Continuously firing this weapon will cause it to overheat." },
	[ SCIFI_PERK_RELOAD_OVERHEAT_CONDUCTOR ] 		= { PerkTitle = "Heat Conductor", 					PerkDescription = "Continuous fire will cause this weapon to overheat. The weapon will still be able to fire, but at drastically increased ammo drain. Projectiles gain additional heat damage." },
	[ SCIFI_PERK_AMMO_CRITICAL ] 					= { PerkTitle = "Critical", 						PerkDescription = "This weapon deals increased critical damage against enemy's weak spots." },
	[ SCIFI_PERK_AMMO_HIGHCAL ] 					= { PerkTitle = "High-Cal Rounds", 					PerkDescription = "Weapon is equipped with high-caliber rounds, penetrating organic armor. Increased recoil." },
	[ SCIFI_PERK_AMMO_SUPERHEATED ] 				= { PerkTitle = "High-Thermal Weaponry", 			PerkDescription = "This weapon may ignite flammable materials or enemies, regardless of elemental effects." },
	[ SCIFI_PERK_AMMO_TOXIC ] 						= { PerkTitle = "Toxic", 							PerkDescription = "Damage done by this weapon can poison players, temporarily draining health." },
	[ SCIFI_PERK_AMMO_RADIATION ] 					= { PerkTitle = "Irradiated", 						PerkDescription = "Radiation damage ignores suit armor." },
	[ SCIFI_PERK_AMMO_EXPLOSIVE ] 					= { PerkTitle = "Explosive Payload", 				PerkDescription = "Blast damage ignores all armor types, stuns NPCs and briefly deafens players." },
	[ SCIFI_PERK_AMMO_DELAYEDEXPLOSION ] 			= { PerkTitle = "Flechette", 						PerkDescription = "Projectiles will explode after a short duration." },
	[ SCIFI_PERK_AMMO_RESURGENCE ] 					= { PerkTitle = "Resurgence", 						PerkDescription = "A fraction of the damage dealt with this weapon will be restore to the user's health." },
	[ SCIFI_PERK_AMMO_PUNCHTHROUGH_LIGHT ] 			= { PerkTitle = "Armor-piercing Rounds", 			PerkDescription = "Shots will pierce light materials, such as wood or glass." },
	[ SCIFI_PERK_AMMO_PUNCHTRHOUGH_HEAVY ] 			= { PerkTitle = "Phase Lance", 						PerkDescription = "Shots will effortlessly punch through every material." },
	[ SCIFI_PERK_AMMO_RICOCHET_LIGHT ] 				= { PerkTitle = "Ricochet", 						PerkDescription = "Shots may bounce off of hard surfaces." },
	[ SCIFI_PERK_AMMO_RICOCHET_HEAVY ] 				= { PerkTitle = "Repulsion", 						PerkDescription = "Shots will bounce off of any solid surface." },
	[ SCIFI_PERK_AMMO_DAMAGEFALLOFF ] 				= { PerkTitle = "Low-power Payload", 				PerkDescription = "Shots have damage falloff over large distances." },
	[ SCIFI_PERK_ACCESSORY_RECOIL ] 				= { PerkTitle = "Gel-buffered Stock", 				PerkDescription = "Weapon is equipped with advanced recoil compensator." },
	[ SCIFI_PEKR_ACCESSORY_SILENT ] 				= { PerkTitle = "Suppressor Mod", 					PerkDescription = "Weapon is equipped with a suppressor, reducing noise." },
	[ SCIFI_PERK_CHAMBER_MULTISHOT ] 				= { PerkTitle = "Gemini-Chamber", 					PerkDescription = "Fires 2 shots per trigger-pull. Increased recoil and ammo consumption." },
	[ SCIFI_PERK_CHAMBER_ESCALATING ] 				= { PerkTitle = "Corruption Spreads", 				PerkDescription = "Ammo consumption and status chance increase over time and with each additional target hit at once." },
	[ SCIFI_PERK_BARREL_ACCURACY ] 					= { PerkTitle = "Electromagnetic Stabilizers", 		PerkDescription = "Allows for outstanding accuracy and improved recoil control." },
	[ SCIFI_PERK_BARREL_STEALTH ] 					= { PerkTitle = "CovertAction Barrel", 				PerkDescription = "CovertAction barrel with built-in suppressor, significantly reduces noise and muzzleflash emission. Hits against unaware NPCs have a 3x damage multiplier. Further, shots have slight damage falloff." },
	[ SCIFI_PERK_FANG_TRIPPLETAP ] 					= { PerkTitle = "Real-time Target Analysis", 		PerkDescription = "The RTTA-system increases damage by 10% for every 3 shots against the same target. Buff lasts for 1 second or until another target or surface has been hit. Timer refreshes each time the buff is activated." },
	[ SCIFI_PERK_TALON_SWITCHBLADE ] 				= { PerkTitle = "Switchblade", 						PerkDescription = "Hitting a target with bullets will drastically increase melee damage and range for the next attack. Striking an enemy increases bullet damage for the rest of the magazine." },
	[ SCIFI_PERK_APEX_TARGETMARKED ] 				= { PerkTitle = "Stalker", 							PerkDescription = "Aiming down sights at a target for a short period of time will place a marker. Hitting the marked spot on that target will deal drastically increased damage. Marker lasts for 15 seconds or until the weapon is switched." },
	[ SCIFI_PERK_PHASMA_SWORDANDSHIELD ] 			= { PerkTitle = "Rift Shield", 						PerkDescription = "Shield mode can absorb up 250 incoming damage. The more damage is absorbed, the less damage will be mitigated away from the owner." },
	[ SCIFI_PERK_PRISMA_OVERCLOCKEDCORE ] 			= { PerkTitle = "Overclocked Core", 				PerkDescription = "Weapon draws less ammo from the core, core recharge delay is drastically increased. Core overheats faster." },
	[ SCIFI_PERK_ZEALA_UNSTABLECHARGE ] 			= { PerkTitle = "Unstable Charge", 					PerkDescription = "Holding the fully charged weapon will drain the user's shields." },
	[ SCIFI_PERK_CORRUPTED_RAVENOUS ]		 		= { PerkTitle = "Ravenous", 						PerkDescription = "Continuous attacks, especially against multiple targets, gradually increase damage, status-chance and ammo consumption." },
	[ SCIFI_PERK_CORRUPTED_IMPURERELOAD ] 			= { PerkTitle = "Insatiable", 						PerkDescription = "Picking up impure spectrum will reload a small amount of ammo from reserves." },
	[ SCIFI_PERK_CURSE_DOUBLEAMMODRAW ] 			= { PerkTitle = "Combination Loader", 				PerkDescription = "Consumes 2 ammo per shot." },
	[ SCIFI_PERK_AMMO_STICKYGRENADES ] 				= { PerkTitle = "Sticky Grenades", 					PerkDescription = "Ordnance sticks to surfaces and enemies." },
	[ SCIFI_PERK_CHAMBER_ESCALATINGFIRERATE ] 		= { PerkTitle = "Siege Engine", 					PerkDescription = "Continuous attacks increase fire rate." },
	[ SCIFI_PERK_CHAMBER_WINDUP ] 					= { PerkTitle = "Wind-Up", 							PerkDescription = "Needs to wind up before firing." },
	[ SCIFI_PERK_ELEMENTAL_STATUSDURATION ] 		= { PerkTitle = "Enhanced Catalyzer", 				PerkDescription = "Increased status duration." },
	[ SCIFI_PERK_CHAMBER_ACCELERATOR ] 				= { PerkTitle = "Improved Accelerator",	 			PerkDescription = "Drastically increased projectile velocity." },
	[ SCIFI_PERK_EMBER_LASERFOCUS ] 				= { PerkTitle = "Laser Focus",	 					PerkDescription = "Slightly increased damage when the target is on fire." },
	[ SCIFI_PERK_AMMO_CONTACTGRENADES ] 			= { PerkTitle = "Contact Grenades",	 				PerkDescription = "Ordnance will explode immediately on contact with an enemy and shortly after colliding with any other surface." },
	[ SCIFI_PERK_VECTRA_MULTISHOT ] 				= { PerkTitle = "Rift Surge",	 					PerkDescription = "Charging up the weapon will increase projectile count and projectile flight speed." },
	[ SCIFI_PERK_HALFLIFEWEAPON ] 					= { PerkTitle = "One Free Man",	 					PerkDescription = "Can by fired while sprinting. Outstanding recoil control." },
	[ SCIFI_PERK_STORM_BURSTDOWNSIGHTS ] 			= { PerkTitle = "Focus Choke Barrel",	 			PerkDescription = "Aiming down sights with this weapon engages a focus choke, significantly decreasing projectile spread, but splitting the full volley into a 3 bursts of 3, 2 and 1 projectile(s) respectively." },
	[ SCIFI_PERK_MMRIFLE_HIGHLIGHTOPTICS ] 			= { PerkTitle = "Phase-scan Optics", 				PerkDescription = "Scope highlights targets, even cloaked ones." },
}

local tDamageTypeReference = {
	[ DMG_BULLET ] 			= { TypeTitle = "Bullet", 		TypeColor = Color( 185, 180, 160 ) },
	[ DMG_BUCKSHOT ] 		= { TypeTitle = "Buckshot", 	TypeColor = Color( 185, 180, 160 ) },
	[ DMG_DISSOLVE ] 		= { TypeTitle = "Dissolve", 	TypeColor = Color( 25, 150, 255 ) },
	[ DMG_CLUB ] 			= { TypeTitle = "Impact", 		TypeColor = Color( 255, 255, 255 ) },
	[ DMG_CRUSH ] 			= { TypeTitle = "Crush", 		TypeColor = Color( 185, 180, 175 ) },
	[ DMG_SLASH ] 			= { TypeTitle = "Slash", 		TypeColor = Color( 255, 255, 255 ) },
	[ DMG_POISON ] 			= { TypeTitle = "Toxin", 		TypeColor = Color( 180, 255, 110 ) },
	[ DMG_BURN ] 			= { TypeTitle = "Heat", 		TypeColor = Color( 255, 80, 40 ) }, 
	[ DMG_SF_ICE ] 			= { TypeTitle = "Ice", 			TypeColor = Color( 160, 170, 180 ) }, 
	[ DMG_SF_CORROSIVE ] 	= { TypeTitle = "Corrosive", 	TypeColor = Color( 200, 240, 60 ) },
	[ DMG_SHOCK ] 			= { TypeTitle = "Shock", 		TypeColor = Color( 60, 80, 255 ) },
	[ DMG_RADIATION ] 		= { TypeTitle = "Radiation", 	TypeColor = Color( 85, 255, 220 ) },
	[ DMG_SF_HWAVE ] 		= { TypeTitle = "Plasma", 		TypeColor = Color( 255, 120, 120 ) },
	[ DMG_SF_PHASEBLADE ] 	= { TypeTitle = "Phaseblade", 	TypeColor = Color( 180, 10, 35 ) },
	[ DMG_SF_VAPOR ] 		= { TypeTitle = "Energy", 		TypeColor = Color( 25, 150, 255 ) },
	[ DMG_BLAST ] 			= { TypeTitle = "Blast", 		TypeColor = Color( 245, 240, 80 ) },
	[ DMG_SF_BLIGHT ] 		= { TypeTitle = "Blight", 		TypeColor = Color( 215, 160, 255 ) },
	[ DMG_SF_DARK ] 		= { TypeTitle = "Dark", 		TypeColor = Color( 100, 40, 20 ) }
}

local function fnFormatString( sInputString, iFormat )

	local sOutputString

	if ( !sInputString ) then
		sOutputString = "Error!"
		return sOutputString
	end
	
	local iLength = string.len( sInputString )
	local iFormattingLength = iFormat || 32
	local iFormattingSteps = math.ceil( iLength / iFormattingLength )
	
	local tStringBuffer = {}

	for i = 1, iFormattingSteps do
		local iLengthActual = string.len( sInputString )
		local iSplitCoordinate, iSplitSafety, sString = string.find( sInputString, " ", iFormattingLength )

		local iOffset = 0
		if ( iSplitCoordinate ) then
			iOffset = iSplitCoordinate
		end

		local sSection = string.Left( sInputString, iSplitCoordinate  )
		sInputString = string.Right( sInputString, iLengthActual - iOffset )
		
		tStringBuffer[ i ] = sSection
	
		if ( sSection == sInputString ) then
			break
		end
	end

	for i = 1, #tStringBuffer do
		local sStringSegment = tStringBuffer[ i ]
		
		if ( !sStringSegment || sStringSegment == "" || sStringSegment == " " ) then
			continue
		end

		if ( !sOutputString ) then
			sOutputString = sStringSegment
		else
			sOutputString = sOutputString .. "\n" .. sStringSegment
		end
	end

	local iLineEndings = iFormattingSteps 
	if ( #tStringBuffer == iFormattingSteps ) then
		iLineEndings = iLineEndings + 1
	end
	
	return sOutputString, iLineEndings
	
end

function scifi_CreatePerkTableEntry( tEntry, id )

	if ( !tEntry || !istable( tEntry ) ) then
		return
	end
	
	if ( !id ) then
		id = #tPerkSet + 1
	end
	
	tPerkSet[ id ] = tEntry
	
end

function scifi_GetDamageTypeReference()
	return tDamageTypeReference
end

function scifi_GetPerkReference()
	return tPerkSet
end

function SWEP:scifi_GetDamageTypeReference()
	return tDamageTypeReference
end

function SWEP:scifi_GetPerkReference()
	return tPerkSet
end

if ( !CLIENT ) then return end

local blur_mat = Material( "pp/bokehblur" )

local function DrawBokehDOF( size, focus, radius )

	render.UpdateScreenEffectTexture()

	blur_mat:SetTexture( "$BASETEXTURE", render.GetScreenEffectTexture() )
	blur_mat:SetTexture( "$DEPTHTEXTURE", render.GetResolvedFullFrameDepth() )

	blur_mat:SetFloat( "$size", size )
	blur_mat:SetFloat( "$focus", focus )
	blur_mat:SetFloat( "$focusradius", radius )

	render.SetMaterial( blur_mat )
	render.DrawScreenQuad()

end


local tFontDataTitle = {
	font 		= "Roboto Th",
	extended 	= true,
	size 		= 64,
	weight 		= 1,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= false,
	additive 	= false,
	outline 	= false,
}

local tFontDataLabelLarge = {
	font 		= "Roboto",
	extended 	= true,
	size 		= 24,
	weight 		= 8,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= false,
	additive 	= false,
	outline 	= false,
}

local tFontDataLabelSmall = {
	font 		= "Roboto Th",
	extended 	= true,
	size 		= 24,
	weight 		= 1,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= false,
	additive 	= false,
	outline 	= false,
}

local tFontDataNotes = {
	font 		= "Roboto",
	extended 	= true,
	size 		= 16,
	weight 		= 1,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= false,
	additive 	= false,
	outline 	= false,
}

local fShowTitle = 0
local fShowStats = 0
local fShowPerks = 0
local iPanelSizeX = 360
local iPanelSizeY = 32
local iGapTitle = 80
local iGapStats = 60
local iGapPerks = 40
local iPanelOffsetX = 12
local iPanelOffsetY = 20
local iTitleScaling = 86

local bBlur = true
local m_blur = Material( "vgui/panels/blur.vmt" )
local m_draw = Material( "vgui/panels/draw.vmt" )
local rtOld, rtNew

local scrW, scrH

local c_hud_stats_bg = Color( 20, 20, 20, 180 )
local c_hud_stats_fg = Color( 220, 220, 220, 180 )
local c_hud_stats_text = Color( 240, 240, 240, 255 )
local c_hud_perks_bg = Color( 20, 20, 20, 180 )
local c_hud_perks_fg = Color( 220, 220, 220, 180 )
local c_hud_perks_text = Color( 240, 240, 240, 255 )
local c_hud_title_text = Color( 240, 240, 240, 255 )

local function DrawDescriptionPanel( x, y, w, h, c_background, title )
	
	surface.SetDrawColor( c_background )
	surface.DrawRect( x, y, w, h )
	
	draw.SimpleText( title, "SciFiInspectNotes", x + 12, y + 4, c_hud_stats_text, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	
end

local function DrawStatPanel( x, y, w, h, c_background, c_foreground, title, stat, statcolor )
	
	surface.SetDrawColor( c_background )
	surface.DrawRect( x + 4, y, w - 4, h )
	
	surface.SetDrawColor( c_foreground )
	surface.DrawRect( x, y, w - ( w - 4 ), h )
	
	if ( title ) then
		draw.SimpleText( title, "SciFiInspectLabel", x + 12, y + 4, c_hud_stats_text, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) 
	end
	
	if ( stat ) then
		local color = c_hud_stats_text
		if ( statcolor ) then
			color = statcolor
		end

		draw.SimpleText( stat, "SciFiInspectLabel", x + w - 12, y + 4, color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP ) 
	end
	
end

local function DrawPerkPanel( x, y, w, h, c_background, c_foreground, title, desc )
	
	surface.SetDrawColor( c_background )
	surface.DrawRect( x + 4, y, w - 4, h )
	
	surface.SetDrawColor( c_foreground )
	surface.DrawRect( x, y, w - ( w - 4 ), h )
	
	local iOffset = 4
	
	if ( title ) then
		draw.SimpleText( title, "SciFiInspectLabelLarge", x + 12, y + iOffset, c_hud_perks_text, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) 
		iOffset = iOffset + 28
	end
	
	if ( desc ) then
		draw.DrawText( desc, "SciFiInspectLabel", x + 12, y + iOffset, c_hud_perks_text, TEXT_ALIGN_LEFT ) 
	end
	
end

local bUIScaled = false
local iNativeX, iNativeY = 1920, 1080

local function UpdateUIScaling()

	if ( !m_blur || !m_draw ) then return end
	
	local iScaleX, iScaleY = ScrW() / iNativeX, ScrH() / iNativeY

	fShowTitle, fShowStats, fShowPerks = 0, 0, 0
	iPanelSizeX, iPanelSizeY = 360 * iScaleX, 32 * iScaleY
	iGapTitle, iGapStats, iGapPerks = 80 * iScaleX, 60 * iScaleX, 40 * iScaleX
	iPanelOffsetX, iPanelOffsetY = 12 * iScaleX, 20 * iScaleY
	iTitleScaling = 86 * iScaleX
	
	tFontDataTitle.size = 64 * iScaleX
	tFontDataLabelLarge.size = 24 * iScaleX
	tFontDataLabelSmall.size = 24 * iScaleX
	tFontDataNotes.size = 16 * iScaleX
	
	surface.CreateFont( "SciFiInspectTitles", tFontDataTitle )
	surface.CreateFont( "SciFiInspectLabelLarge", tFontDataLabelLarge )
	surface.CreateFont( "SciFiInspectLabel", tFontDataLabelSmall )
	surface.CreateFont( "SciFiInspectNotes", tFontDataNotes )
	
end

local iFadeinTitle, iFadeinStats, iFadeinPerks

function SWEP:DrawHUD()

	self:DrawHudOverlay()
	self:DrawSciFiBaseDebugInfo( vm, ply, wep )	
	
	if ( !self.ViewModelInspectable ) then return end

	local cmd_kb_inspect = GetConVar( "sfw_kb_inspect" ):GetInt()
	local cmd_fx_inspectblur = GetConVar( "sfw_fx_inspectblur" )
	
	if ( !cmd_kb_inspect ) then return end
	
	if ( input.IsKeyDown( cmd_kb_inspect ) || input.IsMouseDown( cmd_kb_inspect ) ) then
		-- fShowTitle = math.Approach( fShowTitle, 1, FrameTime() * 16 )
		-- fShowStats = math.Approach( fShowStats, 1, FrameTime() * 8 )
		-- fShowPerks = math.Approach( fShowPerks, 1, FrameTime() * 2 )
		fShowTitle = Lerp( FrameTime() * 16, fShowTitle, 1 )
		fShowStats = Lerp( FrameTime() * 12, fShowStats, 1 )
		fShowPerks = Lerp( FrameTime() * 8, fShowPerks, 1 )
		
		bEnabled = true
	else
		if ( fShowTitle > 0 || fShowStats > 0 || fShowPerks > 0 ) then
			fShowTitle = math.Approach( fShowTitle, 0, FrameTime() * 4 )
			fShowStats = math.Approach( fShowStats, 0, FrameTime() * 8 )
			fShowPerks = math.Approach( fShowPerks, 0, FrameTime() * 12 )
		else
			if ( bEnabled ) then
				bEnabled = false
			end
		end
	end

	if ( bEnabled && !dEnabled ) then
		UpdateUIScaling()
	end

	dEnabled = bEnabled

	if ( bEnabled ) then
		c_hud_title_text.a = 255 * fShowTitle
		
		c_hud_stats_bg.a = 180 * fShowStats
		c_hud_stats_fg.a = 255 * fShowStats
		c_hud_stats_text.a = 255 * fShowStats
		
		c_hud_perks_bg.a = 180 * fShowPerks
		c_hud_perks_fg.a = 255 * fShowPerks
		c_hud_perks_text.a = 255 * fShowPerks
		
		scrW, scrH = ScrW(), ScrH()
		
		if ( bBlur ) then
			render.UpdateScreenEffectTexture()
			render.UpdateFullScreenDepthTexture()

			if ( !rtNew ) then
				rtOld, rtNew = render.GetRenderTarget(), GetRenderTargetEx( "_rt_hudbackground", scrW, scrH, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_NONE, bit.bor( 256, 8192, 32768 ), CREATERENDERTARGETFLAGS_UNFILTERABLE_OK, IMAGE_FORMAT_RGBA8888 )
			end

			render.PushFilterMag( TEXFILTER.ANISOTROPIC )
			render.PushFilterMin( TEXFILTER.ANISOTROPIC )
			
			render.PushRenderTarget( rtNew, 0, 0, scrW, scrH )
			
			render.Clear( 0, 0, 0, 0, false, false )
			render.OverrideAlphaWriteEnable( true, true )
		end
		
		local posX, posY = scrW * 0.05, scrH * 0.125
		iFadeinTitle = iGapTitle * ( 1 - fShowTitle )

		draw.SimpleTextOutlined( self.PrintName, "SciFiInspectTitles", posX, posY - iTitleScaling + iFadeinTitle, c_hud_title_text, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1 * fShowTitle, c_hud_stats_bg )
		
		-- DrawDescriptionPanel( posX, posY, ScrW() * 0.875, 24, c_hud_stats_bg, self.Purpose )
		-- DrawDescriptionPanel( posX, posY + 32, ScrW() * 0.875, 24, c_hud_stats_bg, self.Instructions )

		local iOffset = 0
		
		local stats = self.SciFiWorldStats
		
		if ( stats ) then
			iFadeinStats = iGapStats * ( 1 - fShowStats )
			iFadeinPerks = iGapPerks * ( 1 - fShowPerks )
			
			local iStatOffsetHorizontal = 0
			local iStatOffsetVertical = iOffset + iFadeinStats
			
			local tFireModes = { stats.Primary, stats.Secondary }
			
			for iFireModeID = 1, #tFireModes do
				local substat = tFireModes[ iFireModeID ]
				
				if ( !substat ) then continue end
				
				if ( iFireModeID > 1 ) then
					iStatOffsetHorizontal = iPanelSizeX + iPanelOffsetX
					iStatOffsetVertical = iOffset + iFadeinStats
					
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_fg, c_hud_stats_fg, nil, "Secondary Fire", c_hud_stats_bg )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				else
					if ( stats.Secondary ) then
						DrawStatPanel( posX, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_fg, c_hud_stats_fg, nil, "Primary Fire", c_hud_stats_bg )
						iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
					end
				end
				
				if ( substat.DamageComposition ) then
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Damage", substat.DamageComposition )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				elseif ( substat.DamageAmount ) then
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Damage", substat.DamageAmount )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				end
				
				if ( substat.DamageBlastRadius ) then
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Blast Radius", substat.DamageBlastRadius )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				end
				
				if ( substat.DamageAttackRange ) then
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Attack Range", substat.DamageAttackRange )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				end
				
				if ( substat.DamageType ) then
					if ( isstring( substat.DamageType ) ) then
						DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Damage Type", substat.DamageType )
						iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
					elseif ( istable( substat.DamageType ) ) then
						local sHybridDamageName, c_hybriddamage
						for id, entry in pairs( substat.DamageType ) do
							local tRef = tDamageTypeReference[ entry ]
							if ( !tRef ) then continue end
							
							if ( sHybridDamageName ) then
								sHybridDamageName = sHybridDamageName .. ", " .. tRef.TypeTitle
							else
								sHybridDamageName = tRef.TypeTitle
							end
							
							c_hybriddamage = tRef.TypeColor
						end
						
						c_hybriddamage.a = c_hud_stats_text.a
								
						DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Damage Type", sHybridDamageName, c_hybriddamage )
						iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
					else
						local tRef = tDamageTypeReference[ substat.DamageType ]
						if ( tRef ) then
							local c_damagetype = tRef.TypeColor
							c_damagetype.a = c_hud_stats_text.a
							
							DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Damage Type", tRef.TypeTitle, c_damagetype )
							iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
						end
					end
				end
				
				if ( substat.CritMul ) then
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Crit. Multiplier", "x" .. substat.CritMul )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				end
				
				if ( substat.StatusChance ) then
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Elemental Effect Chance", substat.StatusChance .. "%" )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				end
			
				if ( substat.FireRate ) then
					if ( !substat.FireRateFormatted ) then
						local sString
						
						for k, v in pairs( substat.FireRate ) do
							if ( !v.RateDelay ) then
								v.RateDelay = "?"
							end
							
							local rate = math.Round( 1 / v.RateDelay, 2 )
							local name = " (" .. v.RateTitle .. ")"
							
							if ( !sString ) then
								sString = rate .. name
							else
								sString = sString .. "; " .. rate .. name
							end
						end
						
						substat.FireRateFormatted = sString
					end
					
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Fire Rate", substat.FireRateFormatted )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				end
				
				if ( substat.ChargeRate ) then
					DrawStatPanel( posX + iStatOffsetHorizontal, posY + iStatOffsetVertical, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Charge Rate", 60 * substat.ChargeRate )
					iStatOffsetVertical = iStatOffsetVertical + iPanelSizeY + 2
				end
			end
			
			iOffset = iStatOffsetVertical
			
			if ( stats.CoreRechargeRate ) then
				DrawStatPanel( posX, posY + iOffset, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Core Regen Rate", stats.CoreRechargeRate )
				iOffset = iOffset + iPanelSizeY + 2
			end
			
			if ( stats.ClipSize ) then
				DrawStatPanel( posX, posY + iOffset, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Clip Size", stats.ClipSize || self.Primary.ClipSize )
				iOffset = iOffset + iPanelSizeY + 2
			end
			
			if ( stats.ReloadSpeed ) then
				DrawStatPanel( posX, posY + iOffset, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Reload Speed", stats.ReloadSpeed )
				iOffset = iOffset + iPanelSizeY + 2
			end
			
			if ( stats.Recoil ) then
				DrawStatPanel( posX, posY + iOffset, iPanelSizeX, iPanelSizeY, c_hud_stats_bg, c_hud_stats_fg, "Recoil", stats.Recoil )
				iOffset = iOffset + iPanelSizeY + 2
			end
			
			if ( stats.PerkSet ) then
				iOffset = iOffset + iPanelSizeY + iFadeinPerks
				
				local bTiling = false
				local iOffsetHorizontal, iOffsetVertical = 0, iGapStats
				
				for k, v in pairs( stats.PerkSet ) do
					if ( istable( v ) ) then
						local iPerkPanelSizeY = v.PerkPanelHeight || 1
						local c_perktitle = v.PerkColor || c_hud_perks_fg
						c_perktitle.a = c_hud_perks_fg.a
						
						DrawPerkPanel( posX + iOffsetHorizontal, posY + iOffset, iPanelSizeX, iPanelSizeY * iPerkPanelSizeY, c_hud_perks_bg, c_perktitle, v.PerkTitle, v.PerkDescription )
						
						if ( iPerkPanelSizeY > iOffsetVertical ) then
							iOffsetVertical = iPerkPanelSizeY + iPanelOffsetY + iFadeinPerks
						end
						
						if ( !bTiling && k >= math.ceil( #stats.PerkSet * 0.5 ) ) then
							bTiling = true
							iOffset = iOffset + iOffsetVertical
							iOffsetHorizontal = 0
						else
							iOffsetHorizontal = iOffsetHorizontal + iPanelSizeX + iPanelOffsetX
						end
					else
						local perk = tPerkSet[ v ]
						if ( !perk ) then continue end
						
						if ( !perk.PerkDescriptionFormatted ) then
							perk.PerkDescriptionFormatted, perk.PerkFormattingSteps = fnFormatString( perk.PerkDescription, 26 )
						end
						
						local iPerkPanelSizeY = iPanelSizeY * perk.PerkFormattingSteps
						
						DrawPerkPanel( posX + iOffsetHorizontal, posY + iOffset, iPanelSizeX, iPerkPanelSizeY, c_hud_perks_bg, c_hud_perks_fg, perk.PerkTitle, perk.PerkDescriptionFormatted )

						-- draw.SimpleTextOutlined( "(ID: "..k..", Value: "..v..", Tiling:"..tostring(bTiling)..", Custom: "..tostring(istable(v))..")", "DebugFixed", posX + iOffsetHorizontal, posY + iOffset, Color( 255, 180, 40, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ) )

						if ( iPerkPanelSizeY > iOffsetVertical ) then
							iOffsetVertical = iPerkPanelSizeY + iPanelOffsetY + iFadeinPerks
						end
						
						if ( !bTiling && k >= math.ceil( #stats.PerkSet * 0.5 ) ) then
							bTiling = true
							iOffset = iOffset + iOffsetVertical
							iOffsetHorizontal = 0
						else
							iOffsetHorizontal = iOffsetHorizontal + iPanelSizeX + iPanelOffsetX
						end
					end
				end
			end
		
			if ( !self.FormattedPurpose ) then
				self.FormattedPurpose, self.FormattedPurposeSteps = fnFormatString( self.Purpose, 32 )
			end
			
			iStatOffsetHorizontal = iStatOffsetHorizontal + iPanelSizeX + iPanelOffsetX
			if ( #tFireModes < 2 ) then
				iStatOffsetHorizontal = iStatOffsetHorizontal + iPanelSizeX + iPanelOffsetX
			end
			
			DrawPerkPanel( posX + iStatOffsetHorizontal, posY + iFadeinPerks, iPanelSizeX, iPanelSizeY * self.FormattedPurposeSteps, c_hud_stats_bg, c_hud_stats_fg, nil, self.FormattedPurpose )
			
			if ( !self.FormattedInstructions ) then
				self.FormattedInstructions, self.FormattedInstructionsSteps = fnFormatString( self.Instructions, 32 )
			end
			
			iStatOffsetHorizontal = iStatOffsetHorizontal + iPanelSizeX + iPanelOffsetX
			DrawPerkPanel( posX + iStatOffsetHorizontal, posY + iFadeinPerks, iPanelSizeX, iPanelSizeY * self.FormattedInstructionsSteps, c_hud_stats_bg, c_hud_stats_fg, nil, self.FormattedInstructions )
		end
		
		if ( bBlur ) then
			render.OverrideAlphaWriteEnable( false )

			render.PopRenderTarget()
			
			render.PopFilterMag()
			render.PopFilterMin()

			m_blur:SetTexture( "$BASETEXTURE", render.GetScreenEffectTexture() )
			m_blur:SetTexture( "$DEPTHTEXTURE", rtNew )

			m_blur:SetFloat( "$size", 6 * fShowTitle )
			m_blur:SetFloat( "$focus", 0 )
			m_blur:SetFloat( "$focusradius", 0.1 )

			render.SetMaterial( m_blur )
			render.DrawScreenQuad()

			m_draw:SetTexture( "$basetexture", rtNew )
		
			render.SetMaterial( m_draw )
			render.DrawScreenQuad()
		end
	end

end