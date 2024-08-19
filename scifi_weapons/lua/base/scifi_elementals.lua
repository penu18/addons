--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v18 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Global functions for elemental status functions,	--
-- damage effectivities as well as dissolve functions.			--
------------------------------------------------------------------
-- Auto-included in base.										--
------------------------------------------------------------------

AddCSLuaFile()

SCIFI_INTEGRITY_FLAG_ELEMENTALS = 20210727213519

--[[

	Structure: ElementalInfo (emlinfo)
	emlinfo.Element		EML_ enum
	emlinfo.Target		Entity
	emlinfo.Duration	Float
	emlinfo.Attacker	Entity
	emlinfo.Inflictor	Entity (most likely a weapon)
	emlinfo.Origin		Vector
	emlinfo.Range		Float
	emlinfo.Ticks		Int

	DoElementalEffect( table = emlinfo )

	Note: You don't need all of these vars for every elemental effect. See the examples below.
	
	Example:
	
				local MyEml = {}
				MyEml.Element = EML_FIRE
				MyEml.Target = Entity( 1 )
				MyEml.Duration = 2
				MyEml.Attacker = Entity( 0 )
				
				DoElementalEffect( MyEml )
				
		Works the same way as:

				DoElementalEffect( { Element = EML_FIRE, Target = Entity( 1 ), Duration = 2, Attacker = Entity( 0 ) } )
				
	This would ignite the player for 2 seconds.
	You can optionally define an attacker here. The attacker is obligatory for most of the other elements, 
	however when used with fire, the attacker won't be able to ignite neither himself nor owned entities, like currently equipped weapons.
	The elements fire, ice and entangling blight share the same structure (element, target, duration, attacker). 
	Shock elemental only requires the target. It doesn't have any duration and also doesn't need an attacker.
	Note: If you know, you're going to spam the elemental info at one || more targets, consider the first solution and have the ElementalInfo table precached, if possible, so you don't drawn the garbage collector.

				DoElementalEffect( { Element = EML_CORROSIVE, Target = Entity( 1 ), Attacker = Entity( 1 ), Inflictor = Entity( 1 ):GetActiveWeapon() } )
				
	This would cause the player to corrode himself with the weapon, they're currently using.
	Duration is obsolete for this element, as the corrosive damage source has a capped life-time of 5 seconds.

				DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 5, Attacker = self.Owner } )
				DoElementalEffect( { Element = EML_SHOCK, Target = v } )
				DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 5, Attacker = self.Owner } )
				
	These are lines used in a ents.FindInSphere() context, in the scifi_projectile's base XPlode() function, which is triggered on every hit.
	In this case "v" equals each element of the returned table and therefore an entity within a set radius.
	self.Owner is obvious.
	Note: Unless you work around owner-issue otherwise, I'd recommend using self:GetValidOwner() instead of self.Owner, to avoid NULL Entity errors, if the projectile outlives its creator.
	
	For dissolve effects, you'll need to define the initial position emlinfo.Origin, range and optionally the maximum amount of scan-ticks.
	In addition, you can force the function to use cheap particles, by setting emlinfo.ForceCheapFX to true. This is recommended, if you're planning to cover a large area with a dissolving elemental effect.
	Effects will automatically forced to cheap, if the limit from sfw_fx_maxexpensive is reached.
	
	Example: (like in sfw_seraphim)
	
				DoElementalEffect( { Element = EML_DISSOLVE_HWAVE, Attacker = self.Owner, Range = 64, Ticks = 25, Indextype = 0, ForceCheapFX = false } )
				
	Note: Everything in the line above is obligatory for dissolve elements to work. Only ticks are optional.
	Also keep in mind that the origin for indextype 1 is always the attackers shoot pos.

]]--

local NotiColor	= Color( 80, 255, 175 )

local function DevNotice( msg )

	local bDevmode = GetConVar( "developer" ):GetBool()

	if ( !bDevmode ) then return end
	
	MsgC( NotiColor, msg .. "\n" )

end

DMG_SF_PULSE 				= 102				-- Impulse damage. Suffers vs. armor. Hurts helicopters.
DMG_SF_HWAVE				= 132				-- Plasma/Slash combo. Ignores light/medium armor.One-hits headcrabs.
DMG_SF_PHASEBLADE 			= 8324				-- Same as the above, but more effective.
DMG_SF_ICE 					= 130				-- Suffers vs. armor. 
DMG_SF_ICE_SHRED 			= 536875012			-- No armor reduction except for fortified synth armor (striders).
DMG_SF_CORROSIVE_DART 		= 65538				-- Corrosive/Bullet combo.
DMG_SF_CORROSIVE 			= 393216			-- Corrosive/Toxin combo, similar to antlion worker's acid spit.
DMG_SF_CORROSIVE_ENERGY 	= 536940544			-- Just corrosive damage. Suffers from actual armor, but hurts 2.5x more when the target is corroding.
DMG_SF_BLAST 				= 33554496			-- Blast/Airboat combo. Hurts everything. No armor reduction.
DMG_SF_ENERGYBULLET 		= 4098				-- Energy projectile. Obeys default armor rules.
DMG_SF_ENERGYBLADE 			= 5120				-- Energy/Slash/Impact combo. Ignores light/medium armor. One-hits headcrabs.
DMG_SF_ENERGY 				= 33554560			-- Energy. Ignores light/medium armor.
DMG_SF_ENERGYSHOCKWAVE 		= 536875008			-- Energy damamge...
DMG_SF_VAPOR 				= 9216				-- Good effectivity. Ignores light/medium armor.
DMG_SF_VAPOR_OP 			= 33559552			-- Supreme effectivity. Ignores all kinds of armor.
DMG_SF_BLIGHT 				= bit.bor( 0, 301989892 ) -- 33554432			-- No effectivities/resistanes. Ignores light/medium armor.
DMG_SF_RADIANTFIRE 			= 33540137 			-- ???
DMG_SF_RADIANTSHOCK 		= 5122 --33826816	-- Mana damage. It's like weird radiation. Very unhealthy.
DMG_SF_DARK 				= bit.bor( DMG_SLASH, DMG_NEVERGIB, DMG_NERVEGAS ) -- 33591300			-- A very unhealthy curse.
DMG_BURN_DPS 				= 268435464 		-- Appearently the damage type used for roasting a headcrab until it's done.

EML_FIRE 					= 1					-- Pretty obvious. It's fire and stuff... Don't confuse this with HL2's ignition. This fire will NOT spread naturally.
EML_CORROSIVE				= 2					-- Corrosive damage. Small DOT + increased damage from all sources and even more increased bullet damage.
EML_ICE 					= 3					-- Cryo damage. Freezes the target in place.
EML_ICE_LEGACY 				= 512				-- The same as above but at terrible performance.
EML_SHOCK 					= 4					-- Heavily drains player's shields and stuns NPCs, ultimately cancels and/or resets their scheduled actions. Causes ragdolls to spazzer.
EML_BLIGHT 					= 5					-- Blight damage. Usually, ineffective vs. objects.
EML_BLIGHT_ENT 				= 6					-- Entangling blight damage. Freezes the target in place and causes NPCs to panic upon breaking free.
EML_DARK 					= 7					-- Dark status. Increases incoming dark damage.
EML_GRAVRIFLE_BLAST 		= 8					-- Overcharges the target, causing them to explode. The initial explosion can chain to nearby entities.
EML_DISSOLVE_HWAVE 			= 9					-- Dissolves props and ragdolls with orange light effects and particles.
EML_DISSOLVE_VAPOR 			= 10 				-- Dissolves props and ragdolls with blue light effects and particles.
EML_DISSOLVE_VAPOR_HEAVY 	= 101 				-- Same as above, but with a mass cap of 3000, exclusive to sfw_vapor's altfire.
EML_DISSOLVE_CORROSIVE 		= 11 				-- Dissolves and shrinks down a ragdoll with green goo around it.
EML_DISSOLVE_NEUTRINO 		= 12 				-- Exposure to intense radiation (like, you know, REALLY intense).
EML_DISSOLVE_DARK			= 13 				-- Transition effect for bodies to eventually become corrupted mass.
EML_DISSOLVE_HWAVE_ADVANCED = 14 				-- Clientside ragdoll dissolve... prediction messed that one up.
EML_DISSOLVE_CELESTWRATH 	= 15 				-- Fear the wrath...
EML_DISSOLVE_GRAVRIFLE 		= 16				-- For instantaneous gravrifle explosion on kill.

local antlion 				= 87 	-- 99		-- Antlions, workers and grubs
local flesh 				= 39 -- 40			-- Combine infantry, players, citizens, stalkers, uncommon zombies and all humanoid NPCs from Half-Life: Source
local alienflesh  			= 41				-- Headcrabs, Vortigaunts, Barnacles and basically all Xenians from Half-Life: Source
local zombieflesh 			= 90 -- 103 -- 102	-- Zombies, uncommon zombies (partially!), all zombie enemies from Half-Life: Source (needs confirmation due to inconsistency)
local machine 				= 70				-- Scanners
local metal 				= 3					-- Helicopters, Mines, Rollers, Cameras, Turrets, Gargantuas
local wood 					= 14				-- Mostly world targets, i.e. func_breakable, prop_physics and item_item_crate.
local alloyarmor 			= 94				-- Vehicles
local synthflesh 			= 92 -- 86 	-- 85	-- Hunters
local syntharmor 			= 98				-- Striders, Gunships
local shield 				= 129 				-- Anything that has individual shielding. (players, certain NPCs with ManaGames content. Basically, if entity:Armor() returns n>0)

local sfw_allow_advanceddamage_bias = GetConVar( "sfw_allow_advanceddamage_bias" )
local sfw_allow_forceserverdissolve = GetConVar( "sfw_allow_forceserverdissolve" )
local cmd_serverragdolls = GetConVar( "ai_serverragdolls" )
local cmd_debug_showdmgranges = GetConVar( "sfw_debug_showdmgranges" )

local Effectivities = {
	[ DMG_BULLET ] 				= { [ antlion ] = 0.9, 	[ flesh ] = 1.1, 	[ alienflesh ] = 0.85, 	[ zombieflesh ] = 1.15, [ machine ] = 0.7, 	[ metal ] = 0.7, 	[ wood ] = 1.75, 	[ alloyarmor ] = 0.7, 	[ synthflesh ] = 0.8, 	[ syntharmor ] = 0.8, 	[ shield ] = 0.9	},
	[ DMG_BUCKSHOT ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 0.85, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.7, 	[ wood ] = 1.25, 	[ alloyarmor ] = 0.65, 	[ synthflesh ] = 0.85, 	[ syntharmor ] = 0.8, 	[ shield ] = 1.2	},
	[ DMG_CLUB ] 				= { [ antlion ] = 1.1, 	[ flesh ] = 0.9, 	[ alienflesh ] = 1.2, 	[ zombieflesh ] = 1.25, [ machine ] = 1.5, 	[ metal ] = 1.2, 	[ wood ] = 2, 		[ alloyarmor ] = 0.8, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5, 	[ shield ] = 0.8	},
	[ DMG_PHYSGUN ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1,  	[ wood ] = 2,	 	[ alloyarmor ] = 1.1,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.8, 	[ shield ] = 0.5 	},
	[ DMG_SLASH ] 				= { [ antlion ] = 0.8, 	[ flesh ] = 1.2, 	[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 0.9, 	[ metal ] = 0.8, 	[ wood ] = 1.2, 	[ alloyarmor ] = 0.8, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.75, 	[ shield ] = 1 		},
	[ DMG_VEHICLE ] 			= { [ antlion ] = 2, 	[ flesh ] = 1.5, 	[ alienflesh ] = 1.5, 	[ zombieflesh ] = 1.25, [ machine ] = 1, 	[ metal ] = 1, 	 	[ wood ] = 1, 		[ alloyarmor ] = 1,		[ synthflesh ] = 1.25, 	[ syntharmor ] = 1, 	[ shield ] = 2 		},
	[ DMG_CRUSH ] 				= { [ antlion ] = 2, 	[ flesh ] = 1, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 2, 	[ metal ] = 1,  	[ wood ] = 2,	 	[ alloyarmor ] = 1,		[ synthflesh ] = 2, 	[ syntharmor ] = 1, 	[ shield ] = 2		},
	[ DMG_ENERGYBEAM ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 0.8, 	[ zombieflesh ] = 1, 	[ machine ] = 2, 	[ metal ] = 1.1, 	[ wood ] = 1, 		[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.25, 	[ syntharmor ] = 1.1, 	[ shield ] = 1.2 	},
	[ DMG_AIRBOAT ] 			= { [ antlion ] = 2, 	[ flesh ] = 1.5, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1.5, 	[ machine ] = 1.25, [ metal ] = 1.15, 	[ wood ] = 4,  		[ alloyarmor ] = 2,		[ synthflesh ] = 1, 	[ syntharmor ] = 1, 	[ shield ] = 1 		},
	[ DMG_DISSOLVE ] 			= { [ antlion ] = 2, 	[ flesh ] = 2, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 1, 	[ metal ] = 1, 	 	[ wood ] = 4, 		[ alloyarmor ] = 2,		[ synthflesh ] = 2, 	[ syntharmor ] = 1, 	[ shield ] = 2 		},
	[ DMG_SHOCK ] 				= { [ antlion ] = 0.8, 	[ flesh ] = 0.8, 	[ alienflesh ] = 0.75, 	[ zombieflesh ] = 0.75, [ machine ] = 2, 	[ metal ] = 1.5,  	[ wood ] = 0.25, 	[ alloyarmor ] = 2.2,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1, 	[ shield ] = 1.5	},
	[ DMG_RADIATION ] 			= { [ antlion ] = 0.8, 	[ flesh ] = 1, 		[ alienflesh ] = 0.8, 	[ zombieflesh ] = 0.8, 	[ machine ] = 2, 	[ metal ] = 1.15, 	[ wood ] = 1,  		[ alloyarmor ] = 2,		[ synthflesh ] = 1.25, 	[ syntharmor ] = 1.1, 	[ shield ] = 1 		},
	[ DMG_ACID ] 				= { [ antlion ] = 1.25, [ flesh ] = 1.1, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 1.1, 	[ machine ] = 1.15, [ metal ] = 1.2,   	[ wood ] = 1.25,	[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.15, 	[ shield ] = 0.8	},
	[ DMG_BURN ] 				= { [ antlion ] = 1.5, 	[ flesh ] = 1, 		[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.25, [ machine ] = 0.75, [ metal ] = 0.75,   [ wood ] = 2,		[ alloyarmor ] = 0.2,	[ synthflesh ] = 0.5, 	[ syntharmor ] = 0.5, 	[ shield ] = 0.8	},
	[ DMG_BURN_DPS ] 			= { [ antlion ] = 1.5, 	[ flesh ] = 1, 		[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.25, [ machine ] = 0.75, [ metal ] = 0.75,   [ wood ] = 2,		[ alloyarmor ] = 0.2,	[ synthflesh ] = 0.5, 	[ syntharmor ] = 0.5, 	[ shield ] = 0.5	},
	
	[ DMG_SF_PULSE ]			= { [ antlion ] = 0.85, [ flesh ] = 0.85, 	[ alienflesh ] = 0.8, 	[ zombieflesh ] = 1, 	[ machine ] = 1.2, 	[ metal ] = 1.2,   	[ wood ] = 1.5,  	[ alloyarmor ] = 0.8,	[ synthflesh ] = 0.8, 	[ syntharmor ] = 1.15, 	[ shield ] = 0.8 	},
	[ DMG_SF_HWAVE ]			= { [ antlion ] = 1, 	[ flesh ] = 1.2, 	[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 0.9, 	[ metal ] = 0.9,   	[ wood ] = 1.5, 	[ alloyarmor ] = 0.8,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.8, 	[ shield ] = 0.8	},
	[ DMG_SF_PHASEBLADE ] 		= { [ antlion ] = 1.2, 	[ flesh ] = 1.25, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1.25, [ machine ] = 1, 	[ metal ] = 0.95,   [ wood ] = 2,  		[ alloyarmor ] = 1,		[ synthflesh ] = 0.85, 	[ syntharmor ] = 0.95, 	[ shield ] = 1		},
	[ DMG_SF_ENERGY ] 			= { [ antlion ] = 1, 	[ flesh ] = 1.1, 	[ alienflesh ] = 0.9, 	[ zombieflesh ] = 1, 	[ machine ] = 0.85, [ metal ] = 0.9,    [ wood ] = 1, 		[ alloyarmor ] = 1.2,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5, 	[ shield ] = 1		},
	[ DMG_SF_ENERGYBLADE ] 		= { [ antlion ] = 1.15, [ flesh ] = 1.15, 	[ alienflesh ] = 1.15, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.75,   [ wood ] = 2,  		[ alloyarmor ] = 1.2,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5, 	[ shield ] = 1.2	},
	[ DMG_SF_ENERGYBULLET ] 	= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1.1, 	[ machine ] = 1.15, [ metal ] = 1, 	   	[ wood ] = 1.5, 	[ alloyarmor ] = 1.1,	[ synthflesh ] = 0.8, 	[ syntharmor ] = 0.5, 	[ shield ] = 1		},
	[ DMG_SF_ENERGYSHOCKWAVE ] 	= { [ antlion ] = 1.15, [ flesh ] = 1.15, 	[ alienflesh ] = 1.15, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.75,   [ wood ] = 1.5,  	[ alloyarmor ] = 1.2,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5, 	[ shield ] = 1		},
	[ DMG_SF_CORROSIVE ] 		= { [ antlion ] = 1.5, 	[ flesh ] = 0.95, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 0.8, 	[ machine ] = 1.2, 	[ metal ] = 1.2,   	[ wood ] = 1.25,	[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1, 	[ shield ] = 0.8	},
	[ DMG_SF_CORROSIVE_DART ] 	= { [ antlion ] = 1.5, 	[ flesh ] = 0.8, 	[ alienflesh ] = 0.75, 	[ zombieflesh ] = 0.8, 	[ machine ] = 1.2, 	[ metal ] = 1.2,    [ wood ] = 1.25, 	[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1, 	[ shield ] = 0.75	},
	[ DMG_SF_CORROSIVE_ENERGY ] = { [ antlion ] = 1.25, [ flesh ] = 0.85, 	[ alienflesh ] = 0.85, 	[ zombieflesh ] = 0.85, [ machine ] = 1.15, [ metal ] = 1.15,   [ wood ] = 1,  		[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.15, 	[ syntharmor ] = 1, 	[ shield ] = 0.85	},
	[ DMG_SF_ICE ] 				= { [ antlion ] = 0.85, [ flesh ] = 0.9, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1.1,    [ wood ] = 0.7,	 	[ alloyarmor ] = 0.7,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1, 	[ shield ] = 1		},
	[ DMG_SF_ICE_SHRED ] 		= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1.2,    [ wood ] = 1,		[ alloyarmor ] = 0.75,	[ synthflesh ] = 1.2, 	[ syntharmor ] = 1.2, 	[ shield ] = 1.15	},
	[ DMG_SF_VAPOR_OP ] 		= { [ antlion ] = 2, 	[ flesh ] = 2, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 1, 	[ metal ] = 1,    	[ wood ] = 2,		[ alloyarmor ] = 2,		[ synthflesh ] = 2, 	[ syntharmor ] = 1.5, 	[ shield ] = 2		},
	[ DMG_SF_VAPOR ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 0.9,   	[ wood ] = 1,  		[ alloyarmor ] = 1,		[ synthflesh ] = 1, 	[ syntharmor ] = 0.9, 	[ shield ] = 1.1	},
	[ DMG_SF_BLIGHT ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1.2, 	[ zombieflesh ] = 1.5, 	[ machine ] = 1, 	[ metal ] = 1, 	   	[ wood ] = 1,		[ alloyarmor ] = 2,		[ synthflesh ] = 1.25, 	[ syntharmor ] = 1.25, 	[ shield ] = 1 		},
	[ DMG_SF_DARK ] 			= { [ antlion ] = 1.5, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 0.9, 	[ metal ] = 1, 	   	[ wood ] = 2,		[ alloyarmor ] = 1.25,	[ synthflesh ] = 2, 	[ syntharmor ] = 2, 	[ shield ] = 1.5	},
	[ DMG_SF_BLAST ] 			= { [ antlion ] = 1.15, [ flesh ] = 1.1, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 1.5, 	[ metal ] = 1.25,   [ wood ] = 2,		[ alloyarmor ] = 2, 	[ synthflesh ] = 1.2, 	[ syntharmor ] = 1.25, 	[ shield ] = 0.8	},
	[ DMG_SF_RADIANTFIRE ] 		= { [ antlion ] = 5, 	[ flesh ] = 5, 		[ alienflesh ] = 5, 	[ zombieflesh ] = 5, 	[ machine ] = 5, 	[ metal ] = 5, 	   	[ wood ] = 5,		[ alloyarmor ] = 4,		[ synthflesh ] = 5, 	[ syntharmor ] = 5, 	[ shield ] = 5		},
	[ DMG_SF_RADIANTSHOCK ] 	= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1.2,    [ wood ] = 2,		[ alloyarmor ] = 0.75,	[ synthflesh ] = 1.2, 	[ syntharmor ] = 1.2, 	[ shield ] = 1.2	}
}

local tDestructables = {
	["npc_turret_ceiling"] = true,
	["npc_turret_floor"] = true,
	["npc_rollermine"] = true
}

local tModels = {
	["models/combine_soldier.mdl"] = true,
	["models/zombie/classic.mdl"] = true,
	["models/zombie/zombie_soldier.mdl"] = true
}

local tRemains = {
	["models/combine_soldier.mdl"] = "models/zombie/zombie_soldier_torso.mdl",
	["models/zombie/classic.mdl"] = "models/zombie/classic_torso.mdl",
	["models/zombie/zombie_soldier.mdl"] = "models/zombie/zombie_soldier_torso.mdl"
}

local tGibs = {
	["models/combine_soldier.mdl"] = "models/zombie/zombie_soldier_legs.mdl",
	["models/zombie/classic.mdl"] = "models/zombie/classic_legs.mdl",
	["models/zombie/zombie_soldier.mdl"] = "models/zombie/zombie_soldier_legs.mdl"
}

local tGibSounds = {
	"player/damage1.wav",
	"player/damage2.wav",
	"player/damage3.wav",
	"player/damage4.wav",
	"physics/body/body_medium_break2.wav",
	"physics/body/body_medium_break3.wav",
	"physics/body/body_medium_break4.wav"
}

for k,v in pairs( tGibSounds ) do
	sound.Add( {
		name = "scifi.gibs.flesh." .. k ,
		channel = CHAN_STATIC,
		volume = 1,
		level = 80,
		pitch = {98, 102},
		sound = v
	} )
	
--	util.PrecacheSound( v )
end

function GetEffectivityTable()
	return Effectivities
end

local decal = "Blood"
local splats = 6

local funcGibCollide = function( gEntity, pCollisionData ) 
	local gOrigin = gEntity:GetPos()
	local trOrigin, trNormal = pCollisionData.HitPos, pCollisionData.HitNormal
	
	for i = 0, splats do
		local rng = VectorRand() * math.random( -10, 10 )
		
		util.Decal( decal, gOrigin + rng * i,trOrigin + trNormal * -i, { gEntity } )
		util.Decal( decal, gOrigin, gOrigin + rng, { tEntity } )
	end
end

-- local tMeta = FindMetaTable( "CTakeDamageInfo" )
-- tMeta.m_nElementalEffect = 0
-- tMeta.m_nElementalStatusChance = 0
-- tMeta.m_nElementalEffectDuration = 0
-- tMeta.m_nElementalEffectThreshold = 250

-- function tMeta:SetElementalEffect( iElementalEffectEnum )
	-- tMeta.m_nElementalEffect = iElementalEffectEnum
-- end

-- function tMeta:GetElementalEffect()
	-- return tMeta.m_nElementalEffect
-- end

-- function tMeta:GetInstanceID()
	-- local id = 1 -- .. self:GetAttacker():EntIndex() .. self:GetInflictor():EntIndex() .. self:GetDamage() .. self:GetDamageType()
	-- return id
-- end

-- function tMeta:Dump()
	-- print( self, self:GetInstanceID(), self:GetAttacker(), self:GetInflictor(), self:GetDamageType(), self:GetDamage(), self:GetDamageForce(), self:GetElementalEffect() )
-- end

-- local fnOriginal, fnWrapper

-- fnOriginal = DamageInfo

-- fnWrapper = function()
	-- local CTakeDamageInfo = fnOriginal()
	
	-- CTakeDamageInfo:CreateInstanceID()

	-- tMeta.m_nElementalEffect = 0
	-- tMeta.m_nElementalStatusChance = 0
	-- tMeta.m_nElementalEffectDuration = 0
	-- tMeta.m_nElementalEffectThreshold = 250

	-- print( CTakeDamageInfo:Dump() )
	
	-- return CTakeDamageInfo
-- end

-- DamageInfo = fnWrapper

hook.Add( "EntityTakeDamage", "0_SciFiDamageEffectivity", function( tEntity, dmgInfo )

	local cmd_advdmg = GetConVar( "sfw_allow_advanceddamage" ):GetInt()
	
	if ( cmd_advdmg < 1 ) then return end
	
--	dmgInfo:ScaleDamage( 0.75 )
			
	local cmdBias = sfw_allow_advanceddamage_bias:GetFloat()

	local dmgType = dmgInfo:GetDamageType()
	local dmgAtt = dmgInfo:GetAttacker()
	local dmgInf = dmgInfo:GetInflictor()
	local dmgPos = dmgInfo:GetDamagePosition()

	local trData = { start = dmgPos, endpos = tEntity:GetPos(), filter = function( ent ) if ( ent == tEntity ) then return true else return false end end, ignoreworld = true }
	local tr = util.TraceEntity( trData, tEntity )

	local mul = 1

	if ( tr.Hit ) then
		local effect = Effectivities[ dmgType ]
		if ( !effect ) then
			if ( cmd_advdmg > 1 ) then 
				DevNotice( "@SciFiDamage : Error. Failed to derive effectivity data for damage-type " .. dmgType .. " \n" )
			end
			
			return 1 
		end
		
		local tSurface = tr.SurfaceProps
		if ( !tSurface ) then return 1 end 

		local scale  = effect[ tSurface ]

		if ( !scale ) then
			scale = 1
		
			if ( cmd_advdmg > 1 ) then 
				DevNotice( "@SciFiDamage : Failed to get damage multiplier. Defaulting! (" .. dmgType .. " vs. " .. util.GetSurfacePropName( tSurface ) .. " / " .. tSurface .. ")\n" )
			end
			
			return scale
		end
		
		if ( tEntity.Armor && tEntity:Armor() > 0 ) then
			local shieldbias = effect[ shield ]
		
			scale = ( scale + shieldbias ) * 0.5
		end
	
		local bias = 1
		
		if ( cmdBias ) && !( cmdBias == 1 ) then
			if ( scale < 1 ) then
				bias = bias / cmdBias
			elseif ( scale > 1 ) then
				bias = bias * cmdBias
			end
			
			bias = math.Round( bias, 2 )
		end
	
		mul = scale * bias
		
		if ( cmd_advdmg == 2 ) && ( tEntity:IsPlayer() || tEntity:IsNPC() ) then 
			DevNotice( "@SciFiDamage : " .. "Using damage type '" .. dmgType .. "' vs. target (" .. util.GetSurfacePropName( tSurface ) .. " / " .. tSurface .. ") with an effectivity of " .. ( mul * 100 ) .. "%.\n" )
		end
		
		if ( cmd_advdmg > 2 ) then 
			DevNotice( "@SciFiDamage : " .. "Using damage type '" .. dmgType .. "' vs. target (" .. util.GetSurfacePropName( tSurface ) .. " / " .. tSurface .. ") with an effectivity of " .. ( mul * 100 ) .. "%.\n" )
		end

		local tModel = tEntity:GetModel()
		if ( tEntity:IsNPC() ) && ( tModels[ tModel ] ) then 
			local trHead = util.TraceLine( { start = dmgPos, endpos = tEntity:EyePos() + tEntity:EyeAngles():Forward()*-4, filter = {}, ignoreworld = true } )
			local hgroup = trHead.HitGroup
			
			local iDamage = dmgInfo:GetDamage()
			local iTargetHealth = tEntity:Health()
			local iOverKill = iTargetHealth - iDamage
			
--			print( iOverKill, hgroup, bit.band( dmgType, DMG_SLASH ) == DMG_SLASH )

			if ( hgroup == HITGROUP_HEAD ) then
				if ( tModel == "models/combine_soldier.mdl" ) && ( iOverKill < -12 ) then
					tEntity:SetModel( "models/zombie/zombie_soldier.mdl" )
					tEntity:SetSequence( "Idle01" )

					local gib = ents.Create( "prop_ragdoll" )
					gib:SetModel( "models/infected/limbs/limb_male_head01.mdl" )
					gib:SetPos( dmgPos )
					gib:SetAngles( tEntity:EyeAngles() )
					gib:Spawn()
					
					local physGib = gib:GetPhysicsObject()
					physGib:ApplyForceCenter( dmgInfo:GetDamageForce() / 4 )
					
					gib:AddCallback( "PhysicsCollide", funcGibCollide )
					
					ParticleEffectAttach( "blood_zombie_split_spray", PATTACH_ABSORIGIN_FOLLOW, gib, 0 )
					ParticleEffectAttach( "blood_headsplat", PATTACH_ABSORIGIN_FOLLOW, gib, 0 )
					ParticleEffect( "blood_headsplat_cheap", dmgPos, trHead.Normal:Angle(), NULL )
					
					gib:EmitSound( "wraith.magic.finisher" )
					EmitSound( tGibSounds[ math.random( 1, 4 ) ], dmgPos, -1, CHAN_STATIC, 1, 100, 0, 100 )
					-- dmgAtt:EmitSound( tGibSounds[ math.random( 1, 4 ) ], dmgPos, -1, CHAN_STATIC, 1, 100, 0, 100 )
			
					util.Decal( "blood", trHead.HitPos, tEntity:GetPos() - Vector( 0, 0, 4 ), { tEntity } )
					util.Decal( "blood", trHead.HitPos, trHead.HitPos + tr.Normal * 16, { tEntity } )
				end
			else
				if ( iOverKill < -12 ) && ( hgroup == HITGROUP_CHEST || ( bit.band( dmgType, DMG_SLASH ) == DMG_SLASH ) || ( bit.band( dmgType, DMG_BLAST ) == DMG_BLAST ) ) then
					tEntity:SetModel( tRemains[ tModel ] )
					tEntity:SetSequence( "Idle01" )

					local gib2 = ents.Create( "prop_ragdoll" )
					gib2:SetModel( tGibs[ tModel ] )
					gib2:SetPos( tEntity:GetPos() + Vector( 0, 0, 4 ) )
					gib2:SetAngles( tEntity:EyeAngles() )
					gib2:Spawn()
					gib2:SetSkin( tEntity:GetSkin() )
					
					local physGib = gib2:GetPhysicsObject()
					physGib:ApplyForceCenter( dmgInfo:GetDamageForce() * 0.05 )
					
					gib2:AddCallback( "PhysicsCollide", funcGibCollide )

					ParticleEffectAttach( "blood_zombie_split_spray", PATTACH_ABSORIGIN_FOLLOW, gib2, 0 )
					ParticleEffectAttach( "blood_headsplat", PATTACH_ABSORIGIN_FOLLOW, gib2, 0 )
					ParticleEffect( "blood_headsplat_cheap", dmgPos, trHead.Normal:Angle(), NULL )
					
					gib2:EmitSound( tGibSounds[ math.random( 1, 7 ) ] ) --"Watermelon.Impact" )
					EmitSound( tGibSounds[ math.random( 5, 7 ) ], dmgPos, -1, CHAN_STATIC, 1, 80, 0, 100 )
					-- dmgAtt:EmitSound( tGibSounds[ math.random( 5, 7 ) ], dmgPos, -1, CHAN_STATIC, 1, 80, 0, 100 )
			
					util.Decal( "blood", trHead.HitPos, tEntity:GetPos() - Vector( 0, 0, 4 ), { tEntity } )
					util.Decal( "blood", trHead.HitPos, trHead.HitPos + tr.Normal * 16, { tEntity } )
				end
			end
		end
	end

	if ( mul ) then
		dmgInfo:ScaleDamage( mul )
	end
	
end )

hook.Add( "EntityTakeDamage", "0_SciFiDamageElementalEffects", function( ent, dmginfo )

	local iscorroding = ent:GetNWBool( "edmg_corrosive" )
	local dmgamt = dmginfo:GetDamage()
	local dmgtype = dmginfo:GetDamageType()
	local attacker = dmginfo:GetAttacker()

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		if ( iscorroding ) && !( bit.band( dmgtype, DMG_ENERGYBEAM ) == DMG_ENERGYBEAM ) then
			dmginfo:ScaleDamage( 2 )
			
			if ( dmginfo:IsBulletDamage() ) then
				dmginfo:AddDamage( 4 )
			end
		end
		
		if ( ent:GetNWBool( "bliz_frozen" )  ) && ( dmginfo:GetDamageType() == DMG_CLUB || dmginfo:GetDamageType() == DMG_BLAST ) then
			dmginfo:ScaleDamage( 2 )
		end
	end

end )

local mat_dslv_hwave 	= "models/elemental/burned"
local mat_dslv_vapor 	= "models/elemental/vapored"
local mat_stun_ice 		= "models/elemental/frozen"

local snd_dslv_hwave 	= Sound( "scifi.hwave.dissolve" )
local snd_dslv_wrath 	= Sound( "scifi.wrath.dissolve" )
local snd_dslv_wscream 	= Sound( "scifi.vapor.dissolve.scream" )
local snd_dslv_vapor 	= Sound( "scifi.vapor.dissolve" )
local snd_stun_ice 		= Sound( "scifi.bliz.breakfree" )
local snd_stun_ice_2 	= Sound( "scifi.cryo.freeze" )
local snd_stun_shock 	= Sound( "scifi.Blade.Hit.Electric03" )
local snd_stun_ebl		= Sound( "scifi.stinger.attach" )

local tDistantBlastSounds = {
	Sound( "weapons/calhan/blast_distant1.wav" ),
	Sound( "weapons/calhan/blast_distant2.wav" ),
	Sound( "weapons/calhan/blast_distant3.wav" ),
	Sound( "weapons/calhan/blast_distant4.wav" )
}

local function fnGravrifle( entTarget, entAttacker, entInflictor, vOrigin, bShouldSpawnChild, fDelay, fDelayFlux )

	if ( !IsValid( entAttacker ) ) then
		if ( CLIENT ) then
			entAttacker = LocalPlayer()
		else
			entAttacker = Entity( 0 )
		end
	end

	if ( !IsValid( entInflictor ) ) then 
		if ( CLIENT ) then
			entInflictor = LocalPlayer()
		else
			entInflictor = Entity( 0 )
		end
	end
	
	if ( !IsValid( entTarget ) || ( entTarget:IsPlayer() && !entTarget:Alive() ) || entTarget:IsWorld() ) then return end

	if ( !entTarget.m_hGravrifleAttacker ) then
		entTarget.m_hGravrifleAttacker = entAttacker
		-- print( "cast gravrifle on target (",entTarget,"), but no attacker was set... Defaulting to internal:", entAttacker )
	-- else
		-- return
	end

	local phyTarget = entTarget:GetPhysicsObject()
	if ( !IsValid( phyTarget ) ) then return end
	
	if ( !vOrigin || !isvector( vOrigin ) ) then
		vOrigin = entTarget:GetPos()
	end
	
	if ( entTarget.m_bGravrifleChainingOverride && entTarget.m_nGravrifleTime && entTarget.m_nGravrifleTime + 0.2 > CurTime() ) then
		bShouldSpawnChild = entTarget.m_bGravrifleChainingOverride
	end
	
	local bShouldChainToProps = entTarget.m_bGravrifleNoChainingRestriction || false
	
	if ( !fDelay ) then
		fDelay = 0.5 
	end
	
	if ( fDelayFlux && fDelayFlux > 0 ) then
		fDelay, fDelayFlux = fDelay * 1000, fDelayFlux * 1000
		fDelay = math.random( fDelay - fDelayFlux, fDelay + fDelayFlux )
		fDelay = math.abs( fDelay * 0.001 )
	end

	local ed = EffectData()
	ed:SetEntity( entTarget )
	ed:SetOrigin( vOrigin )
	ed:SetScale( fDelay )

	util.Effect( "gravrifle_preexplode", ed, true, true )
	timer.Simple( fDelay, function()
		if ( !IsValid( entAttacker ) ) then return end
		if ( !IsValid( entInflictor ) ) then return end
		if ( !IsValid( entTarget ) ) then return end

		local dmgType = bit.bor( DMG_GENERIC, DMG_DIRECT, DMG_REMOVENORAGDOLL, DMG_NEVERGIB, DMG_AIRBOAT, DMG_SLASH )
		
		local vBlastOrigin = entTarget:EyePos()
		local vBlastOffset = vBlastOrigin - entTarget:GetPos()
		vBlastOffset = vBlastOffset * 0.5
		vBlastOrigin = vBlastOrigin - vBlastOffset
		
		local iBlastRadius = 200
		local fBlastChainRadius = 0.6
		
		local iBoneCount = entTarget:GetBoneCount()
		if ( iBoneCount > 1 ) then
			for i=0, iBoneCount - 1, 2 do
				local vBonePosition, aBoneRotation = entTarget:GetBonePosition( i )
			
				ParticleEffect( "gravrifle_dissolve", vBonePosition, aBoneRotation )
			end
		end

		ParticleEffect( "gravrifle_blast", vBlastOrigin, Angle( 0, 0, 0 ) )
		ParticleEffectAttach( "gravrifle_blast_parentable", PATTACH_ABSORIGIN, entTarget, 0 )
		
		entTarget.m_hGravrifleAttacker = nil
		entTarget.m_bGravrifleChainingOverride = nil
		entTarget.m_nGravrifleTime = nil
		
		if ( bShouldSpawnChild ) then
			for k, v in pairs( ents.FindInSphere( vBlastOrigin, iBlastRadius * fBlastChainRadius ) ) do
				if ( !IsValid( v ) ) then continue end
				if ( v == entAttacker || v:GetOwner() == entAttacker || v == entTarget || v:GetOwner() == entAttacker ) then continue end
	
				local vChainOrigin = v:GetPos()
				if ( v:IsNPC() ) then
					if ( SERVER ) then
						vChainOrigin = v:BodyTarget( vBlastOrigin, false )
					else
						vChainOrigin = v:EyePos()
					end
					
					local myeml = {}
					myeml.Element = EML_DISSOLVE_GRAVRIFLE
					myeml.Target = v
					myeml.Attacker = entAttacker
					myeml.Inflictor = entInflictor
					myeml.Origin = vChainOrigin
					
					DoElementalEffect( myeml )
				else
					if ( v:IsPlayer() ) then
						if ( !GetConVar( "sbox_playershurtplayers" ):GetBool() ) then 
							continue
						end
					else
						if ( bShouldChainToProps ) then
							vChainOrigin = v:GetPos()
						else
							continue
						end
					end
				end

				local fDelayNoise = math.max( math.sin( CurTime() * ( 4 * k ) ) * 0.5, 0.05 )
				
				local fChainFuseTime = math.random( 0.25, 1 )
				if ( v.GetMaxHealth ) then
					fChainFuseTime = ( fChainFuseTime + v:GetMaxHealth() * 0.01 ) * 0.2
				end
				fnGravrifle( v, entAttacker, entInflictor, vChainOrigin, bChain, fChainFuseTime, fDelayNoise + 0.5 )
			end
		end
		
		if ( SERVER ) then
			local fDamageAmp = GetConVar( "sfw_damageamp" ):GetFloat()
			local fDamage = 50 * fDamageAmp
			
			if ( entTarget.m_nGravrifleDamage ) then
				fDamage = entTarget.m_nGravrifleDamage * fDamageAmp
			end

			local CDamageInfo = DamageInfo()
			CDamageInfo:SetDamage( fDamage * fDamageAmp )
			CDamageInfo:SetDamageType( dmgType )
			CDamageInfo:SetDamageForce( vBlastOffset * 2 )
			CDamageInfo:SetAttacker( entAttacker )
			CDamageInfo:SetInflictor( entInflictor )

			entTarget:TakeDamageInfo( CDamageInfo )
			
			dmgType = bit.bor( DMG_GENERIC, DMG_DIRECT, DMG_AIRBOAT, DMG_SLASH, DMG_NEVERGIB )
			CDamageInfo:SetDamageType( dmgType )
		
			util.BlastDamageInfo( CDamageInfo, vBlastOrigin, iBlastRadius )
			util.ScreenShake( vBlastOrigin, 24, 6, 0.25, iBlastRadius * 3.5 )
	
			local bDebug = cmd_debug_showdmgranges:GetBool()
			
			if ( bDebug ) then
				debugoverlay.Sphere( vBlastOrigin, iBlastRadius, 2, Color( 0, 128, 255, 5 ), false )
				debugoverlay.Sphere( vBlastOrigin, iBlastRadius * fBlastChainRadius, 2.2, Color( 255, 128, 0, 45 ), false ) 
			end
		end

		if ( entTarget:IsRagdoll() ) then
			ParticleEffect( "gravrifle_blast_smoke", vBlastOrigin, Angle( 0, 0, 0 ), fx )

			-- if ( !game.SinglePlayer() ) then
				if ( CLIENT ) then
					local iDistance = vBlastOrigin:Distance( EyePos() )
					local fVolume = math.Clamp( iDistance / 2000, 0, 0.25 )
					EmitSound( tDistantBlastSounds[ math.random( 1, #tDistantBlastSounds ) ], vBlastOrigin, -1, CHAN_STATIC, fVolume, SNDLVL_95dB, SND_NOFLAGS, 100 )
					entTarget:EmitSound( "scifi.gravrifle.blast" )
				else
					-- entTarget:EmitSound( "scifi.gravrifle.distant" .. math.random( 1, 4 ) )
					entTarget:EmitSound( "scifi.gravrifle.blast" )
				end
			-- end
			if ( CLIENT && entTarget:GetOwner() == LocalPlayer() ) then
				phyTarget:EnableMotion( false )
			end
			-- entTarget:Fire( "kill", "", 0 )
		else
			if ( SERVER && IsValid( entTarget ) ) then
				local sTargetClass = entTarget:GetClass()
				
				if ( entTarget:IsNPC() ) then
					if ( tDestructables[ sTargetClass ] ) then
						entTarget:Fire( "SelfDestruct", "", 0 )
						entTarget:Fire( "powerdown" )
						entTarget:SetShouldServerRagdoll( false )
					end
				end
		
				if ( sTargetClass == "prop_combine_ball" ) then
					entTarget:Fire( "explode", "", 0 )
				end
		
				if ( sTargetClass == "npc_grenade_frag" ) then
					entTarget:Fire( "settimer", "", 0 )
				end
			end
		end
	end )

end

local function GetFXStressCount()

	local entities = ents.GetAll()
	local valids = {}
	
	for k,v in pairs( entities ) do
		if ( v:GetNWBool( "IsVaporizing" ) ) then
			table.insert( valids, v )
		end
	end

	return #valids
	
end

local function CanUseExpensive()

	local cmd_fx_maxexpensive = GetConVar( "sfw_fx_maxexpensive" ):GetInt()
	
	if ( GetFXStressCount() <= cmd_fx_maxexpensive ) || ( cmd_fx_maxexpensive < 0 ) then
		return true
	else
		DevNotice( "@SciFiElementals : !Warning; Can't create more low-perf effects!" )
		return false
	end
	
end

local TargetClasses = {
	prop_ragdoll = true,
	prop_physics = true,
	prop_physics_multiplayer = true,
	hl2mp_ragdoll = true,
--	prop_dynamic = true,
	gib = true --,
--	prop_door_rotating = true
}

local tElemental = {

	[ EML_DISSOLVE_HWAVE ] = { 
		fxScripted = "hwave_dissolve", 
		fxParticle = "pyro_dissolve", 
		fxParticleCheap = "pyro_dissolve_cheap", 
		mOverride = mat_dslv_hwave, 
		sndDissolve = snd_dslv_hwave, 
		bDisableGravity = true, 
		bDisableShadows = true, 
		bRagdollsOnly = false, 
		iMaxMass = 80, 
		fTimeUntilRemove = 1.4,
		iFlags = 0,
		fnCallBack = function( entOwner, entRagdoll ) 
			-- entRagdoll:StopParticles()
			entRagdoll:SetColor( Color( 100, 20, 0, 255 ) )
			
			if ( SERVER ) then
				entRagdoll:Extinguish()
				
				if ( IsValid( entOwner ) ) then
					local tChildren = entOwner:GetChildren()
					if ( #tChildren > 1 ) then
						for k, v in pairs( tChildren ) do
							v:Extinguish()
						end
					end
				end
			end
		end 
	},

	[ EML_DISSOLVE_CELESTWRATH ] = { 
		fxScripted = "celest_dissolve_wrath", 
		fxParticle = "celest_wrath_dissolve", 
		sndDissolve = snd_dslv_wrath, 
		bDisableGravity = true, 
		bDisableShadows = true,
		iMaxMass = 100, 
		fTimeUntilRemove = 2,
		iFlags = 0,
		fnCallBack = function( entOwner, entRagdoll ) 
			-- entRagdoll:SetColor( Color( 80, 80, 80, 255 ) )
			
			local physRagdoll = entRagdoll:GetPhysicsObject()
			if ( IsValid( physRagdoll ) ) then
				physRagdoll:EnableDrag( true )
				physRagdoll:SetDragCoefficient( 4000 )
				physRagdoll:SetAngleDragCoefficient( 4000 )
			end
		end 
	},

	[ EML_DISSOLVE_VAPOR ] = { 
		fxScripted = "vp_dissolve",
		fxParticle = "vp_dissolve", 
		fxParticleCheap = "vp_dissolve_cheap", 
	--	mOverride = "models/elemental/vapored",
		sndDissolve = snd_dslv_vapor, 
		bDisableGravity = true, 
		bDisableShadows = true,
		iMaxMass = 200, 
		fTimeUntilRemove = 1,
		iFlags = 8
	},

	[ EML_DISSOLVE_VAPOR_HEAVY ] = { 
		fxScripted = "vp_dissolve",
		fxParticle = "vp_dissolve", 
		fxParticleCheap = "vp_dissolve_cheap", 
	--	mOverride = "models/elemental/vapored",
		sndDissolve = snd_dslv_vapor, 
		bDisableGravity = true, 
		bDisableShadows = true,
		iMaxMass = 3000, 
		fTimeUntilRemove = 1,
		iFlags = 8
	},

	[ EML_DISSOLVE_CORROSIVE ] = { 
		fxScripted = "crsv_dissolve", 
		fxParticle = "crsv_dissolve", 
		fxParticleCheap = "crsv_dissolve_cheap", 
		sndDissolve = snd_dslv_hwave,
		bRagdollsOnly = true, 
		iMaxMass = 80, 
		fTimeUntilRemove = 2,
		iFlags = 0
	},

	[ EML_DISSOLVE_DARK ] = { 
		fxScripted = "dark_succumb", 
		fxParitcle = "umbra_succumb",
--		mOverride = "models/elemental/darkened",
		sndDissolve = "scifi.dark.succumb",
		bRagdollsOnly = true, 
		bDisableGravity = false, 
		bDisableShadows = false,
		iMaxMass = 200, 
		fTimeUntilRemove = 3,
		iFlags = 0
	},

	[ EML_DISSOLVE_NEUTRINO ] = { 
		fxScripted = "nio_dissolve",
		sndDissolve = "scifi.neutrino.dissolve", 
		bDisableGravity = true, 
		bDisableShadows = true, 
		iMaxMass = 300, 
		fTimeUntilRemove = 1.5,
		iFlags = 8
	},

	[ EML_DISSOLVE_GRAVRIFLE ] = { 
		-- fxScripted = "gravrifle_preexplode", 
		-- fxParticle = "gravrifle_blast_smoke", 
		-- sndDissolve = Sound( "weapons/calhan/blast.wav" ), 
		bDisableGravity = true, 
		bDisableShadows = true,
		iMaxMass = 1500, 
		fTimeUntilRemove = 1,
		iFlags = 0,
		fnCallBack = function( entOwner, entRagdoll, tInfo )
			local fFuseTime = 0.6
			if ( entOwner.m_nGravrifleFuseTime ) then
				fFuseTime = entOwner.m_nGravrifleFuseTime -- * 0.9
			end
			
			tInfo.fTimeUntilRemove = fFuseTime + FrameTime()

			if ( entOwner.m_nGravrifleDamage ) then
				entRagdoll.m_nGravrifleDamage = entOwner.m_nGravrifleDamage
			end
			
			local physRagdoll = entRagdoll:GetPhysicsObject()
			if ( IsValid( physRagdoll ) ) then
				physRagdoll:EnableDrag( true )
				physRagdoll:SetDragCoefficient( 1 )
				physRagdoll:SetAngleDragCoefficient( 1 )
				
				timer.Simple( fFuseTime * 0.2, function()
					if ( entRagdoll != NULL && physRagdoll != NULL ) then
						local vVelo = physRagdoll:GetVelocity()
						
						if ( vVelo:Length() > 50 ) then
							physRagdoll:SetVelocityInstantaneous( vVelo * -0.01 )
						end
					end					
				end )
			end
			
			fnGravrifle( entRagdoll, entOwner.m_hGravrifleAttacker, entOwner.m_hGravrifleAttacker, nil, entOwner.m_bGravrifleChainingOverride, fFuseTime, 0 )
		end 
	},

}

local fnDissolve = function( entOwner, entRagdoll, iDissolveID )

	if ( !IsValid( entRagdoll ) ) then return end
	if ( entRagdoll:GetNWBool( "IsVaporizing" ) ) then return end

	local info = tElemental[ iDissolveID ]
	if ( !info ) then return end
	
	if ( entOwner:IsPlayer() ) then
		entRagdoll = entOwner:GetRagdollEntity()
	end
	
	if ( info.bRagdollsOnly && !entRagdoll:IsRagdoll() ) then return end

	local vRagdollOrigin = entRagdoll:GetPos()
	
	local phys = entRagdoll:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		if ( info.iMaxMass ) then
			local fDamageAmp = GetConVar( "sfw_damageamp" ):GetFloat()
			if ( phys:GetMass() > info.iMaxMass * fDamageAmp ) then	return end
		end
		
		entRagdoll:SetNWBool( "IsVaporizing", true )
		entRagdoll:AddFlags( FL_DISSOLVING )
	
		if ( SERVER ) then
			entRagdoll:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
			
			if ( entRagdoll:IsOnFire() ) then
				entRagdoll:Extinguish()
			end
		end

		if ( info.bDisableGravity ) then
			if ( entRagdoll:IsRagdoll() ) then
				phys:SetVelocity( Vector( 0, 0, 0 ) )
				phys:SetMass( 1 )
				phys:SetDragCoefficient( 65532 )
				phys:SetAngleDragCoefficient( 65532 )
				-- phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 2 )
			-- else
				-- phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 1 )
			end

			local bones = entRagdoll:GetPhysicsObjectCount()

			for  i=0, bones-1 do
				local grav = entRagdoll:GetPhysicsObjectNum( i )
				if ( IsValid( grav ) ) then
					grav:EnableGravity( false )
				end
			end
			
			phys:EnableDrag( true )
		end
	end
	
	if ( info.bDisableShadows ) then
		entRagdoll:DrawShadow( false )
	end
	
	if ( info.fxScripted ) then
		local vDamageOrigin = entOwner:GetNWVector( "DissolveDamageOrigin" )
		if ( !vDamageOrigin ) then
			vDamageOrigin = vRagdollOrigin
		end
		
		local vFxNormal = ( vRagdollOrigin - vDamageOrigin ):GetNormalized() --* -1

		local ed = EffectData()
		if ( CLIENT ) && ( entOwner:IsNPC() ) then
			if ( info.iFlags ) then
				ed:SetFlags( info.iFlags )
			end

			ed:SetEntity( entOwner )
		
			entOwner:SetMaterial( "dev/hide" )
			entOwner:SetNoDraw( true )
		else
			ed:SetEntity( entRagdoll )
		end
		
		ed:SetOrigin( entOwner.m_vEffectOrigin || vRagdollOrigin )
		ed:SetNormal( vFxNormal )

		util.Effect( info.fxScripted, ed, true, true )
	end
	
	if ( info.mOverride ) then
		entRagdoll:SetMaterial( info.mOverride )
	end
	
	if ( info.sndDissolve ) then
		entRagdoll:EmitSound( info.sndDissolve )
	end
	
	if ( info.fxParticle ) then
		local bParticles = GetConVar( "sfw_fx_particles" ):GetBool()
		if ( bParticles ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then 
			ParticleEffectAttach( info.fxParticle, PATTACH_ABSORIGIN_FOLLOW, entRagdoll, 0 )
		elseif ( info.fxParticleCheap ) then
			ParticleEffectAttach( info.fxParticleCheap, PATTACH_ABSORIGIN_FOLLOW, entRagdoll, 0 ) 
		end
	end
	
	if ( info.fnCallBack ) then
		info.fnCallBack( entOwner, entRagdoll, info )
	end

	if ( CLIENT ) then
		timer.Simple( ( info.fTimeUntilRemove || 1 ) - 0.2, function() 
			if ( IsValid( entRagdoll ) ) then
				entRagdoll:SetSaveValue( "m_bFadeOut", true )
				entRagdoll:SetSaveValue( "m_bFadingOut", true )
			end
		end )
		
		if ( entOwner:IsPlayer() ) then
			timer.Simple( ( info.fTimeUntilRemove || 1 ) - 0.2, function() 
				if ( IsValid( entRagdoll ) ) then
					entRagdoll:SetMaterial( "dev/hide" )
					entRagdoll:RemoveAllDecals()
					entRagdoll:DestroyShadow()
				end
			end )
		end
	else
		timer.Simple( info.fTimeUntilRemove || 1, function() 
			if ( IsValid( entRagdoll ) ) then
				entRagdoll:SetMaterial( "dev/hide" )
				entRagdoll:Fire( "kill", "", FrameTime() )
				-- entRagdoll:Remove()
			end
		end )
	end

end

local fnShellFunction = function( entOwner, entRagdoll )

	if !( IsValid( entRagdoll ) && IsValid( entOwner ) ) then return end
	if ( entRagdoll:GetNWBool( "IsVaporizing" ) ) then return end

	local fDissolveTimeStamp = entOwner.m_nDissolveTime || entRagdoll.m_nDissolveTime
	local fMercyBuffer = FrameTime() * 8
	if ( !game.SinglePlayer() && CLIENT ) then	
		fMercyBuffer = engine.ServerFrameTime() * 8
	end

	if !( fDissolveTimeStamp && fDissolveTimeStamp + fMercyBuffer > CurTime() ) then return end

	local iDissolveID = entOwner.m_nDissolveType || entRagdoll.m_nDissolveType

	if ( !iDissolveID || iDissolveID < 1 ) then return end 

	fnDissolve( entOwner, entRagdoll, iDissolveID )
	
	if ( entOwner:IsPlayer() ) then
		if ( CLIENT ) then
			entOwner.m_nDissolveType = -1
		end
		
		if ( SERVER ) then
			net.Start( "SciFiDissolve" )
			net.WriteEntity( entOwner )
			net.WriteInt( iDissolveType, -1 )
			net.Broadcast()
		end
	end

end

if ( SERVER ) then
	util.AddNetworkString( "SciFiDissolve" )
end

net.Receive( "SciFiDissolve", function( len, ply )

	local entTarget = net.ReadEntity()
	
	if ( !IsValid( entTarget ) ) then return end

	entTarget.m_nDissolveType = net.ReadInt( 16 )
	entTarget.m_nDissolveTime = CurTime()

end )

local function fnScheduleDissolve( entTarget, iDissolveType )
	
	if ( !iDissolveType ) then
		DevNotice( "!Error; No dissolve type given. See EML_ enums." )
		return
	end

	if ( !IsValid( entTarget ) ) then return end
	
	if ( SERVER ) then
		if ( sfw_allow_forceserverdissolve:GetBool() && entTarget:IsNPC() ) then
			local sTargetClass = entTarget:GetClass()
			
			if ( tDestructables[ sTargetClass ] ) then
				entTarget:SetShouldServerRagdoll( false )
			else
				entTarget:SetShouldServerRagdoll( true )
			end
		else
			net.Start( "SciFiDissolve" )
			net.WriteEntity( entTarget )
			net.WriteInt( iDissolveType, 16 )
			net.Broadcast()
		end
		
		entTarget.m_nDissolveType = iDissolveType
		entTarget.m_nDissolveTime = CurTime()
	end
	
end

local fnPreDeathCleanup = function( entTarget, entAttacker, entInflictor )

	if ( entTarget:IsPlayer() ) then
		local GarryPleaseMakeYourFunctionsConsistent = entAttacker
		entAttacker = entInflictor
		entInflictor = GarryPleaseMakeYourFunctionsConsistent
		
		-- input vars are ordered differently for PlayerKilled and OnNPCKilled
	end

	if ( IsValid( entInflictor ) && entInflictor:IsWeapon() ) then
		if ( entInflictor.OnKill ) then
			entInflictor:OnKill( entTarget, entAttacker )
		end
	end
	
end

local fnRagdollManager = function( entOwner, entRagdoll )

	if ( !game.SinglePlayer() && CLIENT ) then
		timer.Simple( engine.ServerFrameTime(), function()
			fnShellFunction( entOwner, entRagdoll )
		end )
	else
		fnShellFunction( entOwner, entRagdoll )
	end

end

function DoElementalEffect( emlinfo )

	if ( !emlinfo || !istable( emlinfo ) || emlinfo == nil ) then DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! No data given!" ) return end
	
	local element 				= emlinfo.Element 						-- Enum
	local target 				= emlinfo.Target						-- Entity
	local duration 				= emlinfo.Duration 						-- Float
	local attacker 				= emlinfo.Attacker						-- Entity
	local inflictor 			= emlinfo.Inflictor 					-- Entity
	local origin 				= emlinfo.Origin						-- Vector
	local range 				= emlinfo.Range							-- Float
	local indextype 			= emlinfo.IndexType 					-- Integer
	local ticks 				= emlinfo.Ticks							-- Integer
	local forcecheapfx 			= emlinfo.ForceCheapFX					-- Boolean
	local damage 				= emlinfo.Damage 						-- Float
	local amp 					= GetConVar( "sfw_damageamp" ):GetFloat()	-- Float
	local cmd_debug_showemlinfo = GetConVar( "sfw_debug_showemlinfo" ):GetInt()
	local cmd_fx_particles 		= GetConVar( "sfw_fx_particles" ):GetBool()
	local cmd_allow_dissolve 	= GetConVar( "sfw_allow_dissolve" ):GetBool()
	
	if ( element == nil ) then DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! No or invalid element!" ) return end
	
	if ( cmd_debug_showemlinfo >= 1 ) then
		if ( isvector( origin ) ) then
			debugoverlay.Text( origin, "origin", 5, true ) 
			debugoverlay.Cross( origin, 4, 3, Color( 255, 20, 40, 255 ), true )
			
			if ( range ) then
				debugoverlay.Sphere( origin, range, 3, Color( 80, 255, 175, 4 ), false )
			end
		end
	end
	
	if ( cmd_debug_showemlinfo == 2 ) then
		DevNotice( table.ToString( emlinfo, "emlinfo @ "..CurTime(), true ).."\n" )
	end
	
	if ( IsValid( target ) && target:IsPlayer() ) then
		if ( target:HasGodMode() ) then
			DevNotice( "@SciFiElementals : !Warning; Target has god-mode." ) 
			return
		end
		
		if ( !game.SinglePlayer() ) && !( target == attacker ) && ( IsValid( attacker ) && attacker:IsPlayer() && target:IsPlayer() ) then
			local bFriendlyFire = GetConVar( "sbox_playershurtplayers" )
			if ( bFriendlyFire && !bFriendlyFire:GetBool() ) then
				DevNotice( "@SciFiElementals : !Warning; Friendly-fire is prohibited." ) 
				return
			end
		end
	end
	
	if ( element == EML_DISSOLVE_HWAVE && cmd_allow_dissolve ) then
		if ( IsValid( target ) ) && ( target:IsPlayer() || target:IsNPC() || TargetClasses[ target:GetClass() ] ) then
			fnScheduleDissolve( target, EML_DISSOLVE_HWAVE )
		end
		
		if ( !target ) then
			for index, target in pairs( ents.FindInSphere( origin, range ) ) do
				if !( target:IsRagdoll() || TargetClasses[ target:GetClass() ] ) then continue end
				
				target.m_vEffectOrigin = origin
				
				fnDissolve( NULL, target, element )
			end
		else
			if !( target:IsRagdoll() || TargetClasses[ target:GetClass() ] ) then return end
				
			target.m_vEffectOrigin = origin
			
			fnDissolve( NULL, target, element )
		end

		return
	end
	
	if ( element == EML_DISSOLVE_CELESTWRATH && cmd_allow_dissolve  ) then
		if ( IsValid( target ) ) && ( target:IsPlayer() || target:IsNPC() || TargetClasses[ target:GetClass() ] ) then
			fnScheduleDissolve( target, EML_DISSOLVE_CELESTWRATH )
		end
		
		if ( !target ) then
			for index, target in pairs( ents.FindInSphere( origin, range ) ) do
				if ( !IsValid( target ) ) then return end
				
				target.m_vEffectOrigin = origin
						
				if ( target:IsPlayer() || target:IsNPC()  ) then
					fnScheduleDissolve( target, EML_DISSOLVE_CELESTWRATH )
					continue
				end
				
				if !( target:IsRagdoll() || TargetClasses[ target:GetClass() ] ) then continue end
				fnScheduleDissolve( target, EML_DISSOLVE_CELESTWRATH )

				fnDissolve( NULL, target, element )
			end
		else
			if !( target:IsRagdoll() || TargetClasses[ target:GetClass() ] ) then return end
			
			target.m_vEffectOrigin = origin
			
			fnDissolve( NULL, target, element )
		end

		return
	end
	
	if ( element == EML_DISSOLVE_VAPOR || element == EML_DISSOLVE_VAPOR_HEAVY ) && ( cmd_allow_dissolve ) then
		if ( IsValid( target ) ) && ( target:IsPlayer() || target:IsNPC() || TargetClasses[ target:GetClass() ] ) then
			fnScheduleDissolve( target, element )
		end

		if ( !target ) then
			for index, target in pairs( ents.FindInSphere( origin, range ) ) do
				if ( !IsValid( target ) ) then continue end
						
				if ( target:IsPlayer() || target:IsNPC()  ) then
					fnScheduleDissolve( target, element )
					continue
				end
				
				if !( target:IsRagdoll() || TargetClasses[ target:GetClass() ] ) then continue end
				
				fnScheduleDissolve( target, element )

				fnDissolve( NULL, target, element )
			end
		else
			if !( target:IsRagdoll() || TargetClasses[ target:GetClass() ] ) then return end
		
			fnDissolve( NULL, target, element )
		end

		return
	end
	
	if ( element == EML_DISSOLVE_CORROSIVE && cmd_allow_dissolve  ) then
		if ( IsValid( target ) ) && ( target:IsPlayer() || target:IsNPC() || target:IsRagdoll() ) then
			fnScheduleDissolve( target, EML_DISSOLVE_CORROSIVE )
		end

		if ( !target ) then
			for index, target in pairs( ents.FindInSphere( origin, range ) ) do
				if ( !IsValid( target ) ) then return end
						
				if ( target:IsPlayer() || target:IsNPC()  ) then
					fnScheduleDissolve( target, EML_DISSOLVE_CORROSIVE )
					continue
				end
				
				if !( target:IsRagdoll() ) then continue end
				fnScheduleDissolve( target, EML_DISSOLVE_CORROSIVE )

				fnDissolve( NULL, target, element )
			end
		else
			if !( target:IsRagdoll() ) then return end
			
			fnDissolve( NULL, target, element )
		end

		return
	end
	
	if ( element == EML_DISSOLVE_DARK && cmd_allow_dissolve  ) then
		if ( IsValid( target ) ) && ( target:IsPlayer() || target:IsNPC() || target:IsRagdoll() ) then
			fnScheduleDissolve( target, EML_DISSOLVE_DARK )
		end

		if ( !target ) then
			for index, target in pairs( ents.FindInSphere( origin, range ) ) do
				if ( !IsValid( target ) ) then return end
				
				target.m_vEffectOrigin = origin
						
				if ( target:IsPlayer() || target:IsNPC()  ) then
					fnScheduleDissolve( target, EML_DISSOLVE_DARK )
					continue
				end
				
				if !( target:IsRagdoll() ) then continue end
				fnScheduleDissolve( target, EML_DISSOLVE_DARK )

				fnDissolve( NULL, target, element )
			end
		else
			if !( target:IsRagdoll() ) then return end
				
			target.m_vEffectOrigin = origin
			
			fnDissolve( NULL, target, element )
		end

		return
	end
	
	if ( element == EML_DISSOLVE_NEUTRINO && cmd_allow_dissolve  ) then
		if ( IsValid( target ) ) && ( target:IsPlayer() || target:IsNPC() || TargetClasses[ target:GetClass() ] ) then
			fnScheduleDissolve( target, EML_DISSOLVE_NEUTRINO )
		end

		if ( !target ) then
			for index, target in pairs( ents.FindInSphere( origin, range ) ) do
				if ( !IsValid( target ) ) then return end
						
				if ( target:IsPlayer() || target:IsNPC()  ) then
					fnScheduleDissolve( target, EML_DISSOLVE_NEUTRINO )
					continue
				end
				
				if !( target:IsRagdoll() ) then continue end
				fnScheduleDissolve( target, EML_DISSOLVE_NEUTRINO )

				fnDissolve( NULL, target, element )
			end
		else
			if !( target:IsRagdoll() ) then return end
			
			fnDissolve( NULL, target, element )
		end

		return
	end
	
	if ( element == EML_GRAVRIFLE_BLAST ) then
		if ( target && !IsValid( target ) ) then return end
		
		fnGravrifle( target, attacker, inflictor, origin, true, 0.8, 0 )
		fnScheduleDissolve( target, EML_DISSOLVE_GRAVRIFLE )
			
		if ( target:IsNPC() && !cmd_serverragdolls:GetBool() ) then
			if ( tDestructables[ sTargetClass ] ) then
				target:SetShouldServerRagdoll( false )
			else
				target:SetShouldServerRagdoll( true )
			end
		end
		
		target.m_hGravrifleAttacker = attacker
		target.m_bGravrifleNoChainingRestriction = true
		return
	end
	
	if ( element == EML_DISSOLVE_GRAVRIFLE && cmd_allow_dissolve  ) && ( IsValid( target ) ) then
		fnScheduleDissolve( target, EML_DISSOLVE_GRAVRIFLE )
			
		if ( target:IsNPC() && !cmd_serverragdolls:GetBool() ) then
			if ( tDestructables[ sTargetClass ] ) then
				target:SetShouldServerRagdoll( false )
			else
				target:SetShouldServerRagdoll( true )
			end
		end
		
		if ( target:IsPlayer() && !game.SinglePlayer() ) then
			target:SetShouldServerRagdoll( false )
		end
		
		target.m_hGravrifleAttacker = attacker
		return
	end
	
	-- if ( CLIENT ) then return end

	if ( target == nil || !IsValid( target ) || target:IsWorld() ) then DevNotice( "@SciFiElementals : !Error; Invalid or no target." ) return end
	
	if ( element == EML_FIRE ) then
		if ( CLIENT ) then return end

		if ( !duration ) then 
			duration = 5 
		end
		
		local tClass = target:GetClass()
		
		if ( target:IsWeapon() && IsValid( target:GetOwner() ) ) then 
			DevNotice( "@SciFiElementals : !PanicEnt; '" .. tostring( target ) .. "' can't be set on fire... Ignoring!" ) 
			return 
		end
		
		if ( target.m_bFireproof ) then
			if ( target:IsOnFire() ) then
				target:Extinguish()
				target:SetSchedule( SCHED_WAKE_ANGRY )
				
				if ( IsValid( target:GetEnemy() ) ) then
					target:SetSchedule( SCHED_CHASE_ENEMY )
				end
			end
				
			ParticleEffectAttach( "eml_dps_shock_ozone", PATTACH_POINT_FOLLOW, target, 4 )
			
			target:SetArmor( math.min( target:Armor() + 5, target.m_nArmorMax || 100 ) )
			
			return
		end
		
		if ( target:IsOnFire() ) then
			--[[
			ToDo:
			> Burst of heat damage on "double ignition".
			> particle effect
			> heat-damage stacking workaround?
			> chain status effect?
			]]--
			
			local CDamageInfo = DamageInfo()
			CDamageInfo:SetDamage( 10 )
			CDamageInfo:SetDamageType( bit.bor( DMG_SLASH, DMG_ENERGYBEAM ) )
			CDamageInfo:SetDamageForce( Vector( 0, 0, 0 ) )
			
			if ( IsValid( attacker ) ) then
				CDamageInfo:SetAttacker( attacker )
			end
			
			util.BlastDamageInfo( CDamageInfo, target:EyePos(), 50 )
			
			target:EmitSound( "scifi.dmg.firestack" )
			-- ParticleEffectAttach( "xplo_hit", 0, target, 0 )
			-- ParticleEffectAttach( "eml_generic_heat", 0, target, 0 )
		else
			if ( target:GetParent():IsPlayer() ) then return end
			if ( target:GetCollisionGroup() == COLLISION_GROUP_DISSOLVE ) then return end
			if ( !IsValid( target:GetPhysicsObject() ) || target:IsConstraint() ) then return end
			
			if ( !IsValid( attacker ) ) then
				target:Ignite( duration )
			else 
				if ( target != attacker && target:GetOwner() != attacker ) then
					target:Ignite( duration )
				end
			end
		end

		return
	end

	if ( element == EML_CORROSIVE ) then
		if ( !IsValid( target ) ) then return end
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error; No attacker." ) return end
		if ( !IsValid( inflictor ) ) then DevNotice( "@SciFiElementals : !Warning; No inflictor." ) inflictor = attacker:GetActiveWeapon() return end
		
		if ( SERVER ) && ( target:IsNPC() || target:IsPlayer() ) then
			if ( target:GetNWBool( "edmg_corrosive" ) ~= true ) then
				target:SetNWBool( "edmg_corrosive", true )
				local dps = ents.Create( "dmg_corrosion" )
				dps:SetPos( target:EyePos() + Vector( 0, 0, 1024 ) )
				dps:SetOwner( attacker )
				dps:SetParent( target )

				if ( duration ) then
					dps.LifeTime = duration
				end
				
				dps:Spawn()
				dps:Activate()
			end
		end
	
		return
	end

	if ( element == EML_ICE ) then
		if ( !IsValid( target ) ) then return end
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error; No attacker." ) return end
		
		if ( SERVER ) then
			if ( !damage ) then
				damage = 50
			end
			
			if ( !duration ) then
				duration = 1
			end
			
			if ( target:IsNPC() || target:IsPlayer() ) && ( target:GetMaxHealth() < 200 ) then
				if ( target:GetNWBool( "bliz_frozen" ) ) then 
				
					if ( !IsValid( target.m_hFreezeDamageEntity ) ) then
						return
					end
					
					if ( target:IsNPC() && !target:IsCurrentSchedule( SCHED_NPC_FREEZE ) ) then
						target.m_hFreezeDamageEntity:SetDieTime( target.m_hFreezeDamageEntity:GetDieTime() + duration * damage * 0.025 )
						target.m_hFreezeDamageEntity.FreezeLevel = target.m_hFreezeDamageEntity.FreezeLevel + damage
					end
			
					return 
				end
				
				target:SetNWBool( "bliz_frozen", true )
				
				local dps = ents.Create( "dmg_freezing" )
				dps:SetPos( target:EyePos() + Vector( 0, 0, 1024 ) )
				dps:SetOwner( attacker )
				dps:SetParent( target )
				dps.LifeTime = duration
				-- dps:SetLifeTime( duration )
				dps.FreezeLevel = damage
				
				dps:Spawn()
				dps:Activate()
				
				target.m_hFreezeDamageEntity = target.m_hFreezeDamageEntity || dps
				
				return
			end
		end
		return
	end

	if ( element == EML_ICE_LEGACY ) then
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error, No attacker." ) return end
		if ( !duration ) then duration = 2 end
		
		if ( !IsValid( target ) ) || ( !SERVER ) then return end
		if ( target:GetNWBool( "bliz_frozen" ) ) then return end
		
		if ( ( target:IsNPC() && !target:IsCurrentSchedule( SCHED_NPC_FREEZE ) ) || target:IsPlayer() ) && ( target:GetMaxHealth() < 150 ) then
			if ( target:IsNPC() ) then
				target:SetSchedule( SCHED_NPC_FREEZE )
				target:SetNWBool( "bliz_frozen", true )
			elseif ( target:IsPlayer() ) then
				target:AddFlags( FL_FROZEN )
				target:SetNWBool( "bliz_frozen", true )
			end
			
			if ( target:IsNPC() || target:IsPlayer() ) then
				local ed = EffectData()
				ed:SetOrigin( target:GetPos() )
				ed:SetEntity( target )
				ed:SetScale( duration )
				util.Effect( "cryon_frozen", ed, true, true )
				
				ParticleEffectAttach( "ice_freezing_shortlt", 1, target, 1 )
			end
			
			target:EmitSound( snd_stun_ice )
			
			timer.Create( "FakeFrozenThink"..target:EntIndex(), 0, 60 * duration, function()
				if ( IsValid( target ) ) && ( target:Health() <= 1 && target:GetNWBool( "bliz_frozen" )  ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "bliz_frozen", false )
					if ( target:IsNPC() ) then
						target:SetSchedule( SCHED_WAKE_ANGRY )
					elseif ( target:IsPlayer() ) then
						target:RemoveFlags( FL_FROZEN )
					end
					
					ParticleEffectAttach( "ice_freezing_release", 1, target, 1 )
					target:EmitSound( snd_stun_ice_2 )
					
					if ( IsValid( attacker ) && IsValid( attacker:GetActiveWeapon() ) ) then
						target:TakeDamage( 5, attacker, attacker:GetActiveWeapon() )
						
						if ( target:Health() <= target:GetMaxHealth() * -0.25 ) then
							DoShatterRagdolls( target:EyePos() )
						else
							DoFreezeRagdolls( target:EyePos() )
						end
					end
				end
			end )
			
			timer.Simple( duration, function()
				timer.Remove( "FakeFrozenThink"..target:EntIndex() )
			end )

			timer.Simple( duration, function()
				if ( IsValid( target ) ) && ( SERVER ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "bliz_frozen", false )
					if ( target:IsNPC() ) then
						target:SetSchedule( SCHED_WAKE_ANGRY )
					elseif( target:IsPlayer() ) then
						target:RemoveFlags( FL_FROZEN )
					end
					ParticleEffectAttach( "ice_freezing_release", 1, target, 1 )
					target:EmitSound( snd_stun_ice )
				end
			end )
		end
		return
	end

	if ( element == EML_SHOCK ) then
		-- if ( CLIENT ) then return end
		
		if ( !IsValid( target ) ) then return end
		if !( target:IsPlayer() || target:IsNPC() || target:IsRagdoll() ) then return end
		
		if ( !damage || isnumber( damage ) ) then 
			damage = 20
		end
		
		if ( target:IsPlayer() ) then
			if ( SERVER ) then
				target:SetArmor( target:Armor() - ( damage * amp ) )
				target:ScreenFade( SCREENFADE.IN, Color( 200, 230, 255, 127 ), 0.5, 0.01 )
			end
			
			if ( !game.SinglePlayer() && CLIENT ) || ( SERVER ) then
				local vmEntity = target:GetViewModel()
				if ( IsValid( vmEntity ) ) then
					ParticleEffectAttach( "eml_dps_shock", PATTACH_ABSORIGIN_FOLLOW, vmEntity, 0 )
				end
			end
		end
		
		if ( SERVER ) then
			if ( target:IsNPC() && target:GetMaxHealth() < 250 ) then
				target:SetSchedule( SCHED_FAIL )
				
				if ( target.Armor && isfunction( target.Armor ) && isnumber( target:Armor() ) ) then
					target:SetArmor( target:Armor() - ( damage * amp ) )
				end
			
				local sTargetClass = target:GetClass()
				if ( tDestructables[ sTargetClass ] ) then
					local chance = math.random( 1, 100 )
					
					if ( chance > 39 ) then
						target:Fire( "depleteammo" )
						target:Fire( "respondtochirp" )
					end
					
					if ( chance > 89 ) then
						target:Fire( "selfdestruct" )
						target:Fire( "powerdown" )
						target:Fire( "interactivepowerdown" )
					end
					
					target:SetShouldServerRagdoll( false )
				end
			end
			
			if ( target:IsRagdoll() ) then
				target:Fire( "StartRagdollBoogie", "", 0 )
			end
		end

		if ( !game.SinglePlayer() && CLIENT ) || ( SERVER ) then
			target:EmitSound( snd_stun_shock )
			ParticleEffectAttach( "eml_dps_shock", PATTACH_ABSORIGIN_FOLLOW, target, 0 )
		end
		
		if ( SERVER ) then
			if ( damage > 19 ) && ( math.random( 0, 100 ) > math.min( 50 + ( damage - 20 ), 100 ) ) && ( !emlinfo.NoChaining ) then
				local mx, mn = target:GetModelBounds()
				
				if ( !mx || !mn ) then 
					mx = Vector( 1, 1, 1 )
					mn = Vector( -1, -1, -1 )
				end
				
				local targetsize = ( mx - mn ):Length()
				local vChainOrigin = target:EyePos()
				
				for k, v in pairs( ents.FindInSphere( vChainOrigin, targetsize + ( damage - 20 ) ) ) do
					if !( v:IsNPC() || v:IsPlayer() ) then continue end
					if !( v:VisibleVec( vChainOrigin ) ) then continue end
					
					local myeml = {}
					myeml.Element = EML_SHOCK
					myeml.Target = v
					myeml.Damage = damage * 0.5
					myeml.NoChaining = true
					DoElementalEffect( myeml )						
							
					util.ParticleTracerEx( 
						"tbolt_tracer", 	-- particle system
						vChainOrigin, 		-- startpos
						v:EyePos(), 		-- endpos
						false, 				-- do whiz effect
						-1, 				-- entity index
						1  					-- attachment
					)
				end
			end
		end
		
		return
	end
	
	if ( element == EML_DARK ) then
		if ( !IsValid( target ) ) then return end
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error; No attacker." ) return end
		
		if ( target:GetNWBool( "dark_haunted" ) ) then 
			local iStacks = target:GetNWInt( "dark_haunted_stacks" )
			target:SetNWInt( "dark_haunted_stacks", iStacks + 1 )
			
			ParticleEffectAttach( "umbra_darken_stackup", PATTACH_ABSORIGIN_FOLLOW, target, 1 )
				
			return 
		end

		if ( SERVER ) then
			if ( target:IsNPC() || target:IsPlayer() ) then
				target:SetNWBool( "dark_haunted", true )
				local dps = ents.Create( "dmg_dark" )
				dps:SetPos( target:EyePos() + Vector( 0, 0, 1024 ) )
				dps:SetOwner( attacker )
				dps:SetParent( target )
				
				dps:Spawn()
				dps:Activate()
			end
		end

		return
	end
	
	if ( element == EML_BLIGHT_ENT ) then
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error, No attacker." ) return end
		if ( duration == nil ) then duration = 5 end
		
		if ( ( target:IsNPC() && !target:IsCurrentSchedule( SCHED_NPC_FREEZE ) ) || target:IsPlayer() ) && ( target:GetMaxHealth() < 1000 && target:GetNWBool( "fstar_entangled" ) == false ) then
			if ( target:IsNPC() ) then
				target:SetSchedule( SCHED_NPC_FREEZE )
				target:SetNWBool( "fstar_entangled", true )
				target:SetNPCState( NPC_STATE_IDLE )
			elseif ( target:IsPlayer() ) then
				target:AddFlags( FL_FROZEN )
				target:SetNWBool( "fstar_entangled", true )
			end
			
			if ( target:IsNPC() || target:IsPlayer() ) then
				local fx = EffectData()
				fx:SetEntity( target )
				fx:SetScale( duration )
				
				util.Effect( "celest_blighten", fx, true, !game.SinglePlayer() )
			
				timer.Create( "FakeFrozenThink"..target:EntIndex(), 0, 1024, function()
					if ( IsValid( target ) ) && ( target:Health() <= 1 && target:GetNWBool( "fstar_entangled" )  )  then
						target:SetNWBool( "fstar_entangled", false )
						if ( target:IsNPC() ) then
							target:SetSchedule( SCHED_WAKE_ANGRY )
						elseif ( target:IsPlayer() ) then
							target:RemoveFlags( FL_FROZEN )
						end
						
						ParticleEffectAttach( "fstar_freeze_release", 1, target, 1 )
						target:EmitSound( snd_stun_ebl )
						
						if ( IsValid( attacker ) && IsValid( attacker:GetActiveWeapon() ) ) then
							target:TakeDamage( 5, attacker, attacker:GetActiveWeapon() )
						end
					end
				end )
				
				timer.Simple( duration, function()
					timer.Remove( "FakeFrozenThink"..target:EntIndex() )
				end )

				timer.Simple( duration, function()
					if ( IsValid( target ) ) && ( SERVER ) then
						target:SetNWBool( "fstar_entangled", false )
						if ( target:IsNPC() ) then
							target:SetSchedule( SCHED_FEAR_FACE )
							target:SetSchedule( SCHED_MOVE_AWAY )
							target:SetSchedule( SCHED_BACK_AWAY_FROM_ENEMY )
							target:SetSchedule( SCHED_RUN_FROM_ENEMY )
						elseif( target:IsPlayer() ) then
							target:RemoveFlags( FL_FROZEN )
						end
						
						ParticleEffectAttach( "fstar_freeze_release", 1, target, 1 )
						target:EmitSound( snd_stun_ebl )
					end
				end )
			end
		end

		return
	end
	
	DevNotice( "@SciFiElementals : !Error; Unknown element. See '/base/scifi_elementals.lua' for reference and check your code." )

end

function DoFreezeRagdolls( pos )

	for k, v in pairs ( ents.FindInSphere( pos, 16 ) ) do
		if ( v:IsRagdoll() ) then -- && v:GetNWBool( "IsStatue" ) == false ) then
			local bones = v:GetPhysicsObjectCount()
			v.StatueInfo = {}
			for bone = 1, bones-1 do
				local constraint = constraint.Weld( v, v, 0, bone, 0 )
				
				if ( constraint ) then
						v.StatueInfo[bone] = constraint
				end
				
				local effectdata = EffectData()
				effectdata:SetOrigin( v:GetPhysicsObjectNum( bone ):GetPos() )
				effectdata:SetScale( 1 )
				effectdata:SetMagnitude( 1 )
				util.Effect( "GlassImpact", effectdata, true, true )
			end		
			
			if ( cmd_fx_particles ) then
				ParticleEffectAttach( "ice_freezing", 1, v, 1 )
			end
				
	--		v:EmitSound( snd_stun_ice_2 )
			v:SetMaterial( mat_stun_ice )
			-- v:SetNWBool( "IsStatue", true )

			local vPhys = v:GetPhysicsObject()
			
			if ( IsValid( vPhys ) ) then
				vPhys:AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
				
				construct.SetPhysProp( nil, v, v:EntIndex(), vPhys, { GravityToggle = 1, Material = "concrete_block" } )
			end
		end
		
		if ( TargetClasses[ v:GetClass() ] || v:IsPlayer() ) then
			if ( cmd_fx_particles ) then
				ParticleEffectAttach( "ice_freezing_shortlt", 1, v, 1 )
			end
		end
	end

end

local icegibs = {
	"models/props_wasteland/rockgranite03b.mdl",
	"models/props_wasteland/rockgranite03c.mdl",
	"models/props_wasteland/rockgranite03a.mdl",
	"models/props_wasteland/rockgranite02c.mdl",
	"models/props_wasteland/rockgranite02b.mdl",
	"models/props_wasteland/rockgranite02a.mdl",
}

function DoShatterRagdolls( pos )

	if ( !GetConVar( "sfw_allow_propcreation" ):GetBool() ) then return end
	
	local cmd_particles = GetConVar( "sfw_fx_particles" ):GetBool()

	for k, v in pairs ( ents.FindInSphere( pos, 16 ) ) do
		if ( v:IsRagdoll() ) then
			v:SetNWBool( "IsVaporizing", true )
			
			if ( !CanUseExpensive() ) then return end
			
			local bones = v:GetPhysicsObjectCount()
			local sMin, sMax = v:GetModelBounds()
			local bMax = math.min( GetConVar( "sfw_fx_maxexpensive" ):GetInt(), bones )
			
			ParticleEffectAttach( "ice_freezing_release", 1, v, 1 )
		--	v:EmitSound( snd_stun_ice_2 )

			for bone = 1, bMax do
				local bOrigin, bRotation = v:GetBonePosition( bone )
				
				if ( !bOrigin || !bRotation ) then continue end
				
				local rng1 = math.random( 1, #icegibs )
				local rng2 = math.random( 5, 15 )
				local gibScale = Vector( 0.01, 0.01, 0.01 )
				local gibScaleFactor = ( sMin - sMax ):Length() * ( bone / 10 ) / ( bMax / 8 )
				local gibScaleFinal = math.max( gibScaleFactor / 200, 0.1 )
		--		print( gibScaleFactor, gibScaleFinal )

				local gib = ents.Create( "prop_emptymag" ) -- "prop_physics_multiplayer" )
				gib:SetModel( icegibs[ rng1 ] )
				gib:SetMaterial( mat_stun_ice )
				
				gib.RMdl = icegibs[ rng1 ]
				gib.RMat = mat_stun_ice
				gib.LifeTime = rng2
				gib.CollisionSounds = false
				
				gib:SetPos( bOrigin + Vector( 0, 0, 16 ) )
				gib:SetAngles( bRotation )
				gib:SetModelScale( gibScaleFinal )
				gib:SetCollisionBounds( gibScale * -1, gibScale )
				gib:Spawn()
				
				gib:Activate()
				gib:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
				--gib:Fire( "kill", "", rng2 )
				
				local gPhys = gib:GetPhysicsObject()
				if ( !IsValid( gPhys ) ) then
					gib:Remove()
					return 
				end
				
				gPhys:SetMass( 50 )
				gPhys:SetDragCoefficient( 16 )
				gPhys:ApplyForceOffset( bRotation:Forward() * ( 512 + bone * 2048 ) + bRotation:Up() * ( 1024 + bone * 512 ), pos )
				
				if ( cmd_particles ) then
					ParticleEffectAttach( "cryo_ragshatter", 1, gib, 1 )
						
					if ( rng1 > 3 ) then
						ParticleEffectAttach( "ice_freezing_shortlt", 1, gib, 1 )
					end
					
					if ( rng1 > 4 ) then
						ParticleEffectAttach( "cryo_ragshatter_frags_crystals", 1, gib, 1 )
					end
					
					if ( rng1 * 2 > rng2 ) then
						ParticleEffectAttach( "cryo_ragshatter_frags", 1, gib, 1 )
					end
					
					local effectdata = EffectData()
					effectdata:SetOrigin( gib:GetPos() )
					effectdata:SetScale( 2 )
					effectdata:SetMagnitude( 2 )
					util.Effect( "GlassImpact", effectdata, true, true )
				end
			end

			v:Fire( "kill", "", 0.02 )
		end
	end

end

hook.Add( "OnNPCKilled", "SciFiElementalOnKill", fnPreDeathCleanup )
hook.Add( "PlayerKilled", "SciFiElementalOnKill", fnPreDeathCleanup )
hook.Add( "CreateEntityRagdoll", "SciFiDissolveRagdolls", fnRagdollManager )
hook.Add( "CreateClientsideRagdoll", "SciFiDissolveRagdolls", fnRagdollManager )
hook.Add( "PlayerDeath", "ResetPlayerDissolve", function( victim, inflictor, attacker )
	victim.m_nDissolveType = nil
	
	if ( !IsValid( victim ) || !SERVER ) then return end
	
	victim:SetNWInt( "m_nDissolveType", nil )
end )

-- VJ Base Compatibility Fix --
hook.Add( "EntityRemoved", "SciFiVJBaseFix", function( entTarget )
	if ( IsValid( entTarget ) && entTarget.IsVJBaseSNPC && entTarget.Corpse ) then
		if ( IsValid( entTarget.Corpse ) && entTarget.Corpse:IsRagdoll() ) then
			hook.Call( "CreateEntityRagdoll", nil, entTarget, entTarget.Corpse )
		end
	end
end )