SCIFI_INTEGRITY_FLAG_INIT = 20210727213519

local SciFiVersion = "Update 18 (v18.6)"
AddCSLuaFile( "base/scifi_sounds.lua" )
include( "base/scifi_sounds.lua" )

if ( CLIENT ) && ( system.IsWindows() && GetConVar( "mat_dxlevel" ):GetInt() < 95 ) then
	MsgC( Color( 220, 20, 40 ), "@SciFiWeapons : !Error; Engine not running on required DirectX backend. Update your graphics drivers.\n" )
end

-- -- 				-- cvar name --						-- def. -- 		-- flags -- 												-- description --
CreateConVar( 		"sfw_allow_dissolve", 					"1", 		FCVAR_ARCHIVE, 												"Enables entity dissolve functions. Effects: sfw_vapor, sfw_neutrino, sfw_seraphim." )
CreateConVar( 		"sfw_allow_experimental", 				"0", 		FCVAR_NONE, 												"(Deprecated?) Enables experimental content. Experimental contents are advanced functions and alternative techniques used by several sci-fi weapons." )
CreateConVar( 		"sfw_allow_advanims", 					"1", 		FCVAR_ARCHIVE, 												"Enable coded animations for all SciFiWeapons. This will disable attacks while sprinting!" )
CreateConVar( 		"sfw_allow_actualspawnoffset", 			"0", 		FCVAR_ARCHIVE, 												"Projectiles will spawn at the actual weapon's muzzle position in the world instead of player's eyes (will not effect all weapons)" )
CreateConVar( 		"sfw_allow_staticspawnoffset", 			"1", 		FCVAR_ARCHIVE, 												"How the 'realistic projectile spawn offset' will be computed. 0 = use weapon's actual muzzle position in the world, 1 = use predefined offset position for players (aligns best with viewmodel impressions), 2 = force predefined for players and NPCs." )
CreateConVar( 		"sfw_allow_supplydrop", 				"0", 		FCVAR_ARCHIVE, 												"Allows random supply-drops from killed NPCs." )
CreateConVar( 		"sfw_allow_propcreation", 				"1", 		FCVAR_ARCHIVE, 												"Enables the creation of temporary props like the sfw_cryon does when detonating underwater." )
CreateConVar( 		"sfw_allow_renderacc", 					"1", 		FCVAR_NONE, 												"Enables/Disables weapon specific render functions like laser pointers or specific ihl." )
CreateConVar( 		"sfw_allow_melee", 						"1", 		FCVAR_ARCHIVE, 												"Server-wide rule to enable/disable passive melee attacks for all scifi weapons." )
CreateConVar( 		"sfw_allow_advanceddamage", 			"0", 		FCVAR_ARCHIVE, 												"Force-enables the new damage and effectivity system. Note, that this may drastically shift damage values. 0 (def.) = disabled; 1 = Enable; 2 = Enable + console feedback." )
CreateConVar( 		"sfw_allow_advanceddamage_bias", 		"1", 		FCVAR_ARCHIVE, 												"Bias the effectivity scale by this amount." )
CreateConVar( 		"sfw_allow_viewbob", 					"1", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "Enable/Disable viewbob effect. Although being most notably while sprinting, this effect is present all time, while carrying a scifi weapon." )
CreateConVar( 		"sfw_allow_viewsway", 					"1", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "Enable/Disable advanced sway effect. This is an experimental feature to rotate the weapon's viewmodel along with a player's eye movement. Restart Required." )
CreateConVar( 		"sfw_allow_legacyzoom", 				"0", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_NONE ), 	"Enables the old zoom mechanic. This should only be used, if CalcView() is overriden and/or the default zoom isn't working!" )
CreateConVar( 		"sfw_allow_stealthfinishers", 			"0", 		FCVAR_ARCHIVE,												"Enables a massive damage boost when using quick melee attacks vs. unaware NPCs." )
CreateConVar( 		"sfw_allow_adsdeltaanim", 				"0", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ),	"Forces aim-down-sights animations to respect delta time steps." )
CreateConVar( 		"sfw_allow_forceserverdissolve", 		"0", 		FCVAR_ARCHIVE, 												"Force server-side ragdolls on entities that are scheduled for dissolve, even if the 'keep corpses' option is disabled" )
CreateConVar( 		"sfw_allow_npccompatibility", 			"1", 		FCVAR_ARCHIVE, 												"Enable weapons to write into NPC data and set spawnfalgs. Disable, if you're experiencing issues." )
CreateConVar( 		"sfw_allow_recoiltoaimvector", 			"0",		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_NONE ), 	"Forces view punch to change the actual aim vector instead of just applying camera sway. Experimental feature." )
CreateConVar( 		"sfw_allow_rtsniperscopes", 			"0",		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "Prefer in-model render-target scopes for certain weapons instead of full-screen overlays." )

CreateConVar( 		"sfw_precachemethod", 					"0", 		FCVAR_ARCHIVE, 												"EFFECTIVE FOR ALL WEAPONS! 0 = Load/cache models the first time they're first used, aka. default cache method. 1 = Force precache all models of a weapon during first init-pass. This may cause lag / long loading times when joining a game or loading into a map but will reduce or entirely prevent spot-loading during the game." )

CreateConVar( 		"sfw_rp_disownondrop", 					"0", 		FCVAR_ARCHIVE, 												"Remove player ownership when dropping a weapon." )
CreateConVar( 		"sfw_rp_forceworlmodelsentitybound",	"0", 		FCVAR_ARCHIVE, 												"Forces world models to be bound to the weapon entity, not the player owning them. Intended as a workaround for DarkRP Common Prop Protection Interface." )

CreateConVar( 		"sfw_damageamp", 						"1", 		FCVAR_ARCHIVE, 												"A multiplayer to the amount of damage dealt by the SciFi weapons." )
CreateConVar( 		"sfw_sk_trace_maxchilds", 				"10", 		FCVAR_ARCHIVE, 												"Caps how many projectiles can be spawned by the sfw_trace's secondary fire." )
CreateConVar( 		"sfw_sk_maxacc", 						"30", 		FCVAR_NONE, 												"Sets the overall warmup level shared by all SciFiWeapons. The higher this value is, the higher will be the spread of continuous fire. It also affects the maximum firerate, some weapons can scale up to." )
CreateConVar( 		"sfw_sk_grinder_physdmgscale", 			"2", 		FCVAR_NONE, 												"Sets the grinder's damage scale. The convar input 1, 2, 3 is equal to the damage output of 5, 100, 500." )
--CreateConVar( 	"sfw_sk_vapor_dissolvedmg", 			"1", 		FCVAR_ARCHIVE, 												"The weapon_vapor will only dissolve prop_ragdoll entities. Set this to 0 if you want to keep ragdolls." )
CreateConVar( 		"sfw_sk_phasma_enableoverpower", 		"0", 		FCVAR_NONE, 												"It slices and dices and it never gets dull!" )
CreateConVar( 		"sfw_sk_pulsar_echosnd", 				"1", 		FCVAR_ARCHIVE, 												"Enables additional echo sounds. Disable this if the overall sound looses quality and / or begans to stutter." )
CreateConVar( 		"sfw_sk_vapor_entitydissolver", 		"0", 		FCVAR_ARCHIVE, 												"Enables the use of 'env_entity_dissolver' for sfw_vapor's altfire. This can and will destroy any props, ragdolls, weapons, NPCs and some world funcs within range!" )
CreateConVar( 		"sfw_sk_vapor_enableoverpower", 		"0", 		FCVAR_NONE, 												"It's a helluva thing..." )
CreateConVar( 		"sfw_sk_stinger_usemtar", 				"1", 		FCVAR_ARCHIVE, 												"Determins whether the stinger's secondary fire uses meteor targeting system to home in on targets or if it just heads straight to the next target in range." )
CreateConVar( 		"sfw_sk_vortex_autokillthreshold",		"32", 		FCVAR_ARCHIVE,  											"The maximum amount of entities that the vortex should be allowed to handle. Once reached, the vortex will straight out kill overflowing entities, regardless of their health or class." )
CreateConVar( 		"sfw_sk_jotunn_uselegacydisplay",		"0",		FCVAR_ARCHIVE,												"Use old holo-scope for Jotunn bow." )
CreateConVar( 		"sfw_supplydrop_chance_items", 			"15", 		FCVAR_ARCHIVE, 												"Sets the server-wide drop chance for SciFi supplies." )
CreateConVar( 		"sfw_supplydrop_chance_weapons", 		"0.008", 	FCVAR_ARCHIVE, 												"Sets the server-wide drop chance for SciFi weapons." )
CreateConVar( 		"sfw_meteor_ignoreallies", 				"1", 		FCVAR_ARCHIVE, 												"Targeting projectiles will ignore NPCs that are allied to the player." )
CreateConVar( 		"sfw_adsmspeedscale", 					"1", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ),	"The global multiplier for mouse sensitivity while aiming down sights with any scifi weapon" )
CreateConVar( 		"sfw_adsmspeedadaptive", 				"1", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ),	"Enable to have weapon's aim-down-sights mouse sensitivtiy multiplier scale dynamically with the weapon's zoom FOV." )
CreateConVar( 		"sfw_toggleaim", 						"0", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ),	"Enable to have weapons aimdown sights / swap to hip-fire on a single button press instead of holding the aim button." )

CreateConVar( 		"sfw_fx_lightemission", 				"1", 		FCVAR_ARCHIVE, 												"Allows physical projectiles to emit dynamic lights in mid-air." )
CreateConVar( 		"sfw_fx_lightemission_force_legacy", 	"0", 		FCVAR_NONE, 												"Uses server-sided lighting entities for dynamic projectile light emission instead of the client-side alternative." )
CreateConVar( 		"sfw_fx_maxexpensive", 					"8", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_NONE ), 	"The global maximum of expensive dissolve particles, that can be created by elemental effects. Once reached, the cheap version will be used, if available." )
CreateConVar( 		"sfw_fx_projexturelighting",			"0", 		FCVAR_ARCHIVE, 												"Enables scifi-entities to use projected textures for lighting in addition to their normal light emission. 0 = Disable all, 1 = Determined by entity, 2 = Force all." )
CreateConVar( 		"sfw_fx_projexturemodelshadows", 		"0",		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "Enables projected texures on sck-models. This may be very performance intensive, especially with a high sck element count." )
CreateConVar( 		"sfw_fx_inspectblur", 					"0", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "Enables DOF effects for inspection screen." )
CreateConVar( 		"sfw_fx_inspectblur_strength", 			"4", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_NONE ), 	"Blur intensity." )
CreateConVar( 		"sfw_fx_forceclientmuzzle", 			"0", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "Forces muzzle flash particles to be spawned and handled client-side only. Note: This works exclusively for SWEP.DoMuzzleEffect() and the 'sfw_muzzle_generic' effect." )
CreateConVar( 		"sfw_fx_cinematicmuzzles", 				"0", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "Make muzzle flashes even flashier with this brand new cvar! But wait, there is more: It's not related to particles, but is scripted, so it's available on all bright muzzles in different colors and sizes while hitting perf in ways barely explored before!" )
CreateConVar( 		"sfw_fx_individualsunbeams", 			"1", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "Enable individual sunbeam effects. This may cause issues with other post-processing effects that use multiply render-target hooks." )

CreateConVar( 		"sfw_debug_showaimassist",				"0",		FCVAR_NONE,													"Visualize aim assist vectors, if applicable. Red = Player's aim vector, Blue = Magnetism vector, Green = Aim-assisted vector for the shot." )
CreateConVar( 		"sfw_debug_showanimscaling", 			"0",		FCVAR_NONE, 												"1 = Show animation scaling. Usefull for adjusting animation speed values and checking for potential leakages and conflict potential." )
CreateConVar( 		"sfw_debug_showdmgranges", 				"0", 		FCVAR_NONE, 												"1 = Shows damage fields. 2 = Shows additional information in the up-right corner of the screen. 3 = Prints that additional information to the console. Requires developer 1." )
CreateConVar( 		"sfw_debug_showemlinfo", 				"0", 		FCVAR_NONE, 												"1 = Shows information about elemental infos created. 2 = Print the entire emlinfo into the console. Requires developer 1." )
CreateConVar( 		"sfw_debug_force_itemhalo", 			"0", 		FCVAR_NONE, 												"Forces the rendering of item highlights on the screen. Those are usually exclusive to weapons, dropped by NPCs." )
CreateConVar( 		"sfw_debug_preventautoequip", 			"0", 		FCVAR_ARCHIVE, 												"Disables automatic weapon pickup for development reasons." )
CreateConVar( 		"sfw_debug_legacydeathevent",			"0", 		FCVAR_NONE,													"Use the old projectile death event with Entity:Remove() instead of scheduling the death silently." )
CreateConVar( 		"sfw_debug_forcenewhitmechanic", 		"0", 		FCVAR_ARCHIVE,												"Projectiles will cause xplode events OnTrigger/OnTouch instead of or in addition to OnCollision." )
CreateConVar( 		"sfw_debug_culltraces", 				"0", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ),	"Traces from a weapon's world entity to any non-owning player to eventually prevent rendering if the LOS is blocked." )
CreateConVar( 		"sfw_debug_culltraces_hboxscale", 		"0.8", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ),	"Multiplier to the world model's hitbox for trace reference to prevent unintended culling scenarios in the outmost hacky way." )
CreateConVar( 		"sfw_debug_culltraces_falloffangle", 	"90", 		bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ),	"At which angle to the viewer weapons should NOT be drawn, ragardless of positive tracing pass." )

CreateConVar( 		"vh_campaign", 							"1", 		FCVAR_ARCHIVE,												"Cool story, bro." )

--CreateClientConVar( "sfw_perfrule", 						"3", 							true, false )
--CreateClientConVar( "sfw_allow_hudinfo", 					"0", 							true, false )
CreateClientConVar( "sfw_allow_sck", 						"1", 							true, false )
CreateClientConVar( "sfw_allow_sck_autocleanup", 			"0", 							true, false )
CreateClientConVar( "sfw_allow_adsblur", 					"1", 							true, false )
CreateClientConVar( "sfw_allow_firelightemission", 			"0", 							true, false )
CreateClientConVar( "sfw_fx_bloomscale", 					"1", 							false, false )
CreateClientConVar( "sfw_fx_bloomstyle", 					"-1", 							false, false )
CreateClientConVar( "sfw_fx_particles", 					"1", 							true, false )
CreateClientConVar( "sfw_fx_sprites", 						"1", 							true, false )
CreateClientConVar( "sfw_fx_heat", 							"0", 							true, false )
CreateClientConVar( "sfw_fx_suppressonzoom", 				"0", 							true, false )
CreateClientConVar( "sfw_fx_muzzlelights", 					"2", 							true, false )
CreateClientConVar( "sfw_cw_model", 						"models/weapons/c_smg1.mdl", 	true, false )
CreateClientConVar( "sfw_cw_model_fov", 					"54", 							true, false )
CreateClientConVar( "sfw_cw_pfire_delay", 					"0.4", 							false, true)
CreateClientConVar( "sfw_cw_pfire_tech", 					"", 							false, true )
CreateClientConVar( "sfw_cw_pfire_pcount", 					"1", 							false, false )
CreateClientConVar( "sfw_cw_sfire_delay", 					"0.4", 							false, true )
CreateClientConVar( "sfw_cw_sfire_tech", 					"zoom", 						false, true )
CreateClientConVar( "sfw_cw_sfire_pcount", 					"1", 							false, false )
CreateClientConVar( "sfw_cw_zoom_fov", 						"", 							true, true )
CreateClientConVar( "sfw_cw_allow_shelleject", 				"1", 							false, false )
CreateClientConVar( "sfw_kb_inspect", 						"-1", 							true, false )
CreateClientConVar( "sfw_debug_obviousdropmessages", 		"0", 							true, false )

cvars.AddChangeCallback( "sfw_allow_experimental", function( sfw_allow_experimental, value_old, value_new )
	print( "@SciFiWeapons : !ValueChanged; Reload required to take effect." )
	if ( GetConVarNumber( "sfw_allow_experimental" ) >= 1 ) then
		print( "You've enabled experimental content. Use at your own risk...\n" )
	end
end )

cvars.AddChangeCallback( "sfw_allow_sck", function( sfw_allow_sck, value_old, value_new )
	print( "@SciFiWeapons : !ValueChanged; Reload/Refresh required to take effect." )
end )

cvars.AddChangeCallback( "sfw_cw_model", function( sfw_cw_model, value_old, value_new )
	print( "@SciFiWeapons : !ValueChanged; Reload/Refresh required to take effect." )
end )

cvars.AddChangeCallback( "sfw_fx_bloomstyle", function( sfw_fx_bloomstyle, value_old, value_new )
	print( "@SciFiWeapons : !ValueChanged; Reload/Refresh required to take effect." )
end )

concommand.Add( 
	"sfw_vindex_clear", 
	
	function( pl, cmd, args )
		if ( GetConVarNumber( "sfw_sk_vapor_entitydissolver" ) == 1 ) then
			for k, v in pairs ( ents.FindByName( "vprze" ) ) do
				print( v )
				v:SetKeyValue( "targetname", v:GetClass() )
			end
			print( "@SciFiWeapons : Vapor index cleared!" )
		elseif( GetConVarNumber( "sfw_sk_vapor_entitydissolver" ) == 0 ) then
			print( "@SciFiWeapons : !NoExperimental; !Error; Set 'sfw_sk_vapor_entitydissolver' to 1" )
		end
	end, 

	"Removes all listed entities from vapor index. Their targetname will be defaulted to normal. Use this command, if a player has been added to vapor index.",
	
	0 
)

concommand.Add( 
	"sfw_reset", 
	
	function( pl, cmd, args )
	RunConsoleCommand( "sfw_allow_actualspawnoffset", "0" )
	RunConsoleCommand( "sfw_allow_recoiltoaimvector", "0" )
	RunConsoleCommand( "sfw_allow_adsblur", "1" )
	RunConsoleCommand( "sfw_allow_advanceddamage", "0" )
	RunConsoleCommand( "sfw_allow_advanims", "1" )
	RunConsoleCommand( "sfw_allow_dissolve", "1" )
	RunConsoleCommand( "sfw_allow_experimental", "0" )
	RunConsoleCommand( "sfw_allow_melee", "1" )
	RunConsoleCommand( "sfw_allow_propcreation", "1" )
	RunConsoleCommand( "sfw_allow_forceserverdissolve", "0" )
	RunConsoleCommand( "sfw_allow_sck", "1" )
	RunConsoleCommand( "sfw_allow_supplydrop", "0" )
	RunConsoleCommand( "sfw_allow_viewbob", "0" )
	RunConsoleCommand( "sfw_allow_viewsway", "1" )
	RunConsoleCommand( "sfw_allow_rtsniperscopes", "0" )
	RunConsoleCommand( "sfw_damageamp", "1.00" )
	RunConsoleCommand( "sfw_fx_heat", "0" )
	RunConsoleCommand( "sfw_fx_lightemission", "1" )
	RunConsoleCommand( "sfw_fx_muzzlelights", "2" )
	RunConsoleCommand( "sfw_fx_particles", "1" )
	RunConsoleCommand( "sfw_fx_sprites", "1" )
	RunConsoleCommand( "sfw_fx_suppressonzoom", "0" )
	RunConsoleCommand( "sfw_meteor_ignoreallies", "1" )
	RunConsoleCommand( "sfw_sk_grinder_physdmgscale", "2" )
	RunConsoleCommand( "sfw_sk_maxacc", "30" )
	RunConsoleCommand( "sfw_sk_pulsar_echosnd", "1" )
	RunConsoleCommand( "sfw_sk_stinger_usemtar", "1" )
	RunConsoleCommand( "sfw_sk_trace_maxchilds", "10" )
	RunConsoleCommand( "sfw_sk_vortex_autokillthreshold", "32" )
	RunConsoleCommand( "sfw_supplydrop_chance_items", "15" )
	RunConsoleCommand( "sfw_supplydrop_chance_weapons", "0.008" )
--	RunConsoleCommand( "sfw_do_melee", "0" )
	MsgC( Color( 255, 80, 80 ), "@SciFiWeapons : !Reset; All values have been restored to default.\n" )
	end, 

	"Resets all SciFiWeapons convars to default values.",
	
	0 
)

game.AddAmmoType( 
	{
		name = "SciFiAmmo",
		--dmgtype = bit.bor( DMG_BULLET, DMG_GENERIC ),
		tracer = TRACER_LINE_AND_WHIZ,
		plydmg = 10,
		npcdmg = 10,
		force = 64,
		minsplash = 2,
		maxsplash = 8,
		maxcarry = 0,
	}
)

game.AddAmmoType(
	{
		name = "SciFiEnergy",
		--dmgtype = DMG_SF_ENERGY,
		force = 0,
		maxsplash = 1,
		minsplash = 0,
		maxcarry = 0,
		flags = 0
	}
)

game.AddAmmoType(
	{
		name = "InferiantCharge",
		--dmgtype = DMG_SF_ENERGY,
		force = 0,
		maxsplash = 1,
		minsplash = 0,
		maxcarry = 300,
		flags = 0
	}
)

local function SciFiWeaponsSettings( CPanel )
	
	CPanel:Help( "" )
	CPanel:ControlHelp( "General Settings" )
	CPanel:NumSlider( "Damage multiplier", "sfw_damageamp", 0.1, 10, 2 )
	CPanel:CheckBox( "NPCs drop supply items upon death.", "sfw_allow_supplydrop" )
	CPanel:NumSlider( "Overall supply drop chance", "sfw_supplydrop_chance_items", 0, 100, 0 )
	CPanel:Help( "(dropchance effects only SciFi item drops.)" )
	
	CPanel:Help( "" )
	CPanel:ControlHelp( "Visuals and effects" )
	CPanel:CheckBox( "Additional particle effects *", "sfw_fx_particles" )
	CPanel:CheckBox( "Additional sprite effects", "sfw_fx_sprites" )
	CPanel:CheckBox( "Heat particle effects *", "sfw_fx_heat" )
	CPanel:CheckBox( "Flashlight shadows on weapon models *", "sfw_fx_projexturemodelshadows" )
	CPanel:CheckBox( "Glowing projectiles", "sfw_fx_lightemission" )
	CPanel:CheckBox( "Individual sun beam effcts", "sfw_fx_individualsunbeams" )
	CPanel:NumSlider(  "Muzzle flash lights *", "sfw_fx_muzzlelights", 0, 3, 0 )
	CPanel:Help( "0 = none, 1 = cheap, 2 = dynamic, 3 = realtime" )
	CPanel:CheckBox( "Suppress muzzle-effects while zooming.", "sfw_fx_suppressonzoom" )
	CPanel:CheckBox( "Prop creation (like ice and stuff...) *", "sfw_allow_propcreation" )
	CPanel:NumSlider( "Limit expensive effects *", "sfw_fx_maxexpensive", 0, 16, 0 )
	CPanel:CheckBox( "depth of field on zoom *", "sfw_allow_adsblur" )
	CPanel:CheckBox( "depth of field on inspecting *", "sfw_fx_inspectblur" )
	CPanel:NumSlider( "Blur strength", "sfw_fx_inspectblur_strength", 0.1, 16, 0 )
--	CPanel:CheckBox( "Draw custom Hud elements", "sfw_allow_hudinfo" )

	CPanel:Help( "" )
	CPanel:ControlHelp( "Weapon specific settings" )
	CPanel:CheckBox( "Allow dissolve effects.\nDestroys props or ragdolls.", "sfw_allow_dissolve" )
	CPanel:CheckBox( "Force server-side dissolve *", "sfw_allow_forceserverdissolve" )
	CPanel:Help( "This will create high-detail dissolve events, even if 'keep corpses' is disabled.\nThis effects ONLY the npc that is about to be dissolved.\nEverything else still won't create ragdolls." )
	CPanel:CheckBox( "Enable experimental collision model for projectiles.", "sfw_debug_forcenewhitmechanic" )
	CPanel:Help( "This is intended to fix projectiles not colliding with NPCs that do not have a proper collision model, such as the majority of NextBots." )
	CPanel:CheckBox( "Meteor targeting ignores allied NPCs.", "sfw_meteor_ignoreallies" )
	CPanel:CheckBox( "Zeala uses realistic lighting.*", "sfw_fx_projexturelighting" )
	CPanel:NumSlider( "Zeala auto-kill threshold *", "sfw_sk_vortex_autokillthreshold", 2, 46, 0 )
	CPanel:CheckBox( "Use old hud for Jotunn bow.", "sfw_sk_jotunn_uselegacydisplay" )
	
	CPanel:Help( "" )
	CPanel:ControlHelp( "Controls and Gameplay" )
	CPanel:NumSlider( "Zoom sensitivity multiplier", "sfw_adsmspeedscale", 0.01, 1, 10 )
	CPanel:CheckBox( "Use toggle-aim instead of hold-to-aim.", "sfw_toggleaim" )
	CPanel:CheckBox( "Use in-model scopes for certain weapons instead of fullscreen overlays.", "sfw_allow_rtsniperscopes" )
	CPanel:CheckBox( "Projectiles use realistic spawn offset.", "sfw_allow_actualspawnoffset" )
	CPanel:Help( "Projectiles will have a slight offset when hip-firing." )
	CPanel:CheckBox( "Force weapon punch to change actual aim vector \ninstead of just applying camera sway.", "sfw_allow_recoiltoaimvector" )
	CPanel:Help( "Experimental feature. Does NOT change internal/weapon specific recoil logic." )
	
	CPanel:CheckBox( "Advanced Animations.", "sfw_allow_advanims" )
	CPanel:Help( "(!) Disabling advanced animations restores a Half-Life-esque sprint behaviour. \n Advanced animtions are required for view-bob and -sway to work as intended." )
	CPanel:CheckBox( "View-bob", "sfw_allow_viewbob" )
	CPanel:CheckBox( "Viewmodel sway", "sfw_allow_viewsway" )
	
	CPanel:Help( "" )
	CPanel:CheckBox( "Enable quick-melee attacks", "sfw_allow_melee" )
	CPanel:Help( "(!) Melee is NOT bound to a key by default. You have to bind it manually by typing \n 'bind *your key here* +grenade2' \ninto the console. (keep in mind, that gmod can't save key bindings, if the game crashes)" )

	CPanel:AddControl( "Numpad", { Label = "Inspect Weapon", Command = "sfw_kb_inspect", ButtonSize = 22 } )
	
	CPanel:Help( "" )
	CPanel:Help( "* Setting may drastically reduce performance on some PCs." )
	CPanel:Help( "" )
	CPanel:Button( "Reset to default settings", "sfw_reset" )
	
	local uiWS = CPanel:Button( "Rate/Comment", "echo test" )
	uiWS.DoClick = function()
		gui.OpenURL( "https://steamcommunity.com/sharedfiles/filedetails/?id=420970650" )
	end
	
	local uiWS = CPanel:Button( "Report a bug", "echo test" )
	uiWS.DoClick = function()
		gui.OpenURL( "https://steamcommunity.com/workshop/filedetails/discussion/420970650/618458030671342431/" )
	end
	
	-- local uiDono = CPanel:Button( "Support this project" )
	-- uiDono.DoClick = function()
		-- gui.OpenURL( "https://paypal.me/darken217" )
	-- end
	
	CPanel:Help( SciFiVersion )
	CPanel:Help( "" )

end

local function SFWCustomWeaponSettings( CPanel )
	
	CPanel:Help( "" )
	CPanel:ControlHelp( "Presets" )
	
	local config = {
		sfw_cw_model = "models/weapons/c_smg1.mdl",
		sfw_cw_pfire_tech = "",
		sfw_cw_pfire_delay = 0.45,
		sfw_cw_pfire_pcount = 1,
		sfw_cw_sfire_tech = "zoom",
		sfw_cw_sfire_delay = 0.45,
		sfw_cw_sfire_pcount = 1,
		sfw_cw_zoom_fov = 45,
		sfw_cw_allow_shelleject  = 0
	}
	
	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "scifiarmory", Options = { [ "#preset.default" ] = config }, CVars = table.GetKeys( config ) } )
	CPanel:Help( "" )
	CPanel:ControlHelp( "General settings" )
	
	local model = {Label = "Weapon model", MenuButton = 0, Options={}, CVars = { "sfw_cw_model" }}
		model["Options"][".357 Revolver"]				= { sfw_cw_model = "models/weapons/c_357.mdl" }
		model["Options"]["Crossbow"]					= { sfw_cw_model = "models/weapons/c_crossbow.mdl" }
		model["Options"]["AR2 pulse rifle"]				= { sfw_cw_model = "models/weapons/c_irifle.mdl" }
		model["Options"]["Gravitygun"]					= { sfw_cw_model = "models/weapons/c_physcannon.mdl" }
		model["Options"]["9mm Pistol"]					= { sfw_cw_model = "models/weapons/c_pistol.mdl" }
		model["Options"]["Rocket launcher"]				= { sfw_cw_model = "models/weapons/c_rpg.mdl" }
		model["Options"]["Shotgun"]						= { sfw_cw_model = "models/weapons/c_shotgun.mdl" }
		model["Options"]["SMG"]							= { sfw_cw_model = "models/weapons/c_smg1.mdl" }
		model["Options"]["Physics gun"]					= { sfw_cw_model = "models/weapons/c_superphyscannon.mdl" } -- @Garry : You're lazy. So am I...
		model["Options"]["Garry's tool gun"]			= { sfw_cw_model = "models/weapons/c_toolgun.mdl" }
			
	CPanel:AddControl( "ComboBox", model )
	CPanel:Help( "To apply the new model, you have to reload the map." )
	CPanel:Help( "To use 3rd party models, use the convar sfw_cw_model. (3rd party models may have compatibility issues!)" )
	CPanel:NumSlider( "Viewmodel FOV", "sfw_cw_model_fov", 1, 100, 0 )
	CPanel:Help( "" )
	CPanel:CheckBox( "Shell effects", "sfw_cw_allow_shelleject" )
	
	
	CPanel:Help( "" )
	CPanel:ControlHelp( "Primary fire settings" )
	CPanel:NumSlider( "Primary fire delay", "sfw_cw_pfire_delay", 0.01, 3, 2 )
	CPanel:NumSlider( "Primary fire projectile count", "sfw_cw_pfire_pcount", 1, 24, 0 )
		
		local pfsys = {Label = "Weapon system to mount", MenuButton = 0, Options={}, CVars = { "sfw_cw_pfire_tech" }}
			pfsys["Options"]["Trace"]						= { sfw_cw_pfire_tech = "trace_primary" }
			pfsys["Options"]["Trace (secondary)"]			= { sfw_cw_pfire_tech = "trace_secondary" }
--			pfsys["Options"]["Thunderbolt"]					= { sfw_cw_pfire_tech = "thunderbolt" }
			pfsys["Options"]["Hellfire"]					= { sfw_cw_pfire_tech = "hellfire_primary" }
			pfsys["Options"]["Hellfire grenade"]			= { sfw_cw_pfire_tech = "hellfire_secondary" }
			pfsys["Options"]["Storm (single)"]				= { sfw_cw_pfire_tech = "storm_single" }
			pfsys["Options"]["Storm (volley)"]				= { sfw_cw_pfire_tech = "storm_multi" }
			pfsys["Options"]["Grinder"]						= { sfw_cw_pfire_tech = "grinder" }
			pfsys["Options"]["Pulsar (cascade beam)"]		= { sfw_cw_pfire_tech = "pulsar_primary" }
			pfsys["Options"]["Pulsar (electric pulse)"]		= { sfw_cw_pfire_tech = "pulsar_secondary" }
			pfsys["Options"]["Vapor"]						= { sfw_cw_pfire_tech = "vapor_primary" }
			pfsys["Options"]["Vapor (secondary)"]			= { sfw_cw_pfire_tech = "vapor_secondary" }
			pfsys["Options"]["Acidrain (gas cloud)"]		= { sfw_cw_pfire_tech = "acidrain_primary" }
			pfsys["Options"]["Acidrain (corrosive MIRV)"]	= { sfw_cw_pfire_tech = "acidrain_secondary" }
			pfsys["Options"]["Bane rifle"]					= { sfw_cw_pfire_tech = "bane" }
			pfsys["Options"]["RNG99 Synergy rifle"]			= { sfw_cw_pfire_tech = "synrifle" }
			pfsys["Options"]["Missile swarmer"]				= { sfw_cw_pfire_tech = "swarmer" }
			pfsys["Options"]["Grenade launcher"]			= { sfw_cw_pfire_tech = "nade" }
			pfsys["Options"]["Flechette shotgun"]			= { sfw_cw_pfire_tech = "flechette" }
			pfsys["Options"]["VK CA3 rifle"]				= { sfw_cw_pfire_tech = "ca3" }
			pfsys["Options"]["VK CA72 rifle"]				= { sfw_cw_pfire_tech = "ca72" }
			pfsys["Options"]["VK PSD-H rifle"]				= { sfw_cw_pfire_tech = "pest" }
			pfsys["Options"]["VK HLK explosive rifle"]		= { sfw_cw_pfire_tech = "xplo" }
			pfsys["Options"]["MTM CX33 grenade"]			= { sfw_cw_pfire_tech = "ca3_nade" }
			pfsys["Options"]["T3i cryogenic grenade"]		= { sfw_cw_pfire_tech = "cryo" }
			pfsys["Options"]["Veho CMB plasma rifle"]		= { sfw_cw_pfire_tech = "veho" }
			pfsys["Options"]["MTM Neutrino cannon"]			= { sfw_cw_pfire_tech = "neutrino" }
			pfsys["Options"]["Stinger"]						= { sfw_cw_pfire_tech = "stinger" }
			pfsys["Options"]["Stinger (secondary)"]			= { sfw_cw_pfire_tech = "stinger_secondary" }
			pfsys["Options"]["T3i NVX Blizzard"]			= { sfw_cw_pfire_tech = "blizzard" }
			pfsys["Options"]["HS24 Heatwave"]				= { sfw_cw_pfire_tech = "heatwave" }
			pfsys["Options"]["HS24 Sapphire"]				= { sfw_cw_pfire_tech = "saphyre" }
			pfsys["Options"]["HS107 Phoenix"]				= { sfw_cw_pfire_tech = "phoenix" }
			pfsys["Options"]["HS20-40 Seraphim"]			= { sfw_cw_pfire_tech = "seraphim" }
			pfsys["Options"]["MTM CX33 guided missile"]		= { sfw_cw_pfire_tech = "mtmgm" }
			pfsys["Options"]["Vapor Grenade"]				= { sfw_cw_pfire_tech = "vapor_nade" }
			pfsys["Options"]["HS200-X Grenade"]				= { sfw_cw_pfire_tech = "charwave" }
			pfsys["Options"]["Pandemic Bolt"]				= { sfw_cw_pfire_tech = "pandemic" }
			pfsys["Options"]["Flamethrower"]				= { sfw_cw_pfire_tech = "flathr" }
			pfsys["Options"]["Falling Star (primary)"]		= { sfw_cw_pfire_tech = "fstar_primary" }
			pfsys["Options"]["Falling Star (secondary)"]	= { sfw_cw_pfire_tech = "fstar_secondary" }
			pfsys["Options"]["Hornet"]						= { sfw_cw_pfire_tech = "hornet" }
			pfsys["Options"]["Flare Gun"]					= { sfw_cw_pfire_tech = "flare" }
			pfsys["Options"]["Spectra (fire)"]				= { sfw_cw_pfire_tech = "spectra_fire" }
			pfsys["Options"]["Spectra (corrosive)"]			= { sfw_cw_pfire_tech = "spectra_crsv" }
			pfsys["Options"]["Spectra (ice)"]				= { sfw_cw_pfire_tech = "spectra_cryo" }
			pfsys["Options"]["Prisma"]						= { sfw_cw_pfire_tech = "prisma" }
			pfsys["Options"]["Supra"]						= { sfw_cw_pfire_tech = "supra" }
			pfsys["Options"]["T3i Jotunn"]					= { sfw_cw_pfire_tech = "jotunn" }
			pfsys["Options"]["VPR binary"]					= { sfw_cw_pfire_tech = "vp_binary" }
			pfsys["Options"]["HS46-C Draco"]				= { sfw_cw_pfire_tech = "draco" }
			pfsys["Options"]["Air strike beacon"] 			= { sfw_cw_pfire_tech = "flare3" }
			pfsys["Options"]["Zeala"] 						= { sfw_cw_pfire_tech = "zeala" }
			pfsys["Options"]["Vectra (single)"]			 	= { sfw_cw_pfire_tech = "vectra" }
			pfsys["Options"]["Vectra (volley)"]			 	= { sfw_cw_pfire_tech = "vectra_volley" }
			pfsys["Options"]["Astra (carbine)"]			 	= { sfw_cw_pfire_tech = "astra_light" }
			pfsys["Options"]["Astra (sniper)"]				= { sfw_cw_pfire_tech = "astra_heavy" }
			pfsys["Options"]["Wrath"]					 	= { sfw_cw_pfire_tech = "wrath_normal" }
			pfsys["Options"]["Wrath (charged)"]				= { sfw_cw_pfire_tech = "wrath_charged" }
			pfsys["Options"]["*nothing*"]					= { sfw_cw_pfire_tech = "" }

	
		CPanel:AddControl( "ComboBox", pfsys )
		
	CPanel:Help( "" )
	CPanel:ControlHelp( "Secondary fire settings" )
	CPanel:NumSlider( "Zoom value", "sfw_cw_zoom_fov", 10, 75, 1 )
	CPanel:NumSlider( "Secondary fire delay", "sfw_cw_sfire_delay", 0.01, 3, 2 )
	CPanel:NumSlider( "Secondary fire projectile count", "sfw_cw_sfire_pcount", 1, 24, 0 )
		
		local sfsys = {Label = "Weapon system to mount", MenuButton = 0, Options={}, CVars = { "sfw_cw_sfire_tech" }}
			sfsys["Options"]["Trace"]						= { sfw_cw_sfire_tech = "trace_primary" }
			sfsys["Options"]["Trace (secondary)"]			= { sfw_cw_sfire_tech = "trace_secondary" }
--			sfsys["Options"]["Thunderbolt"]					= { sfw_cw_sfire_tech = "thunderbolt" }
			sfsys["Options"]["Hellfire"]					= { sfw_cw_sfire_tech = "hellfire_primary" }
			sfsys["Options"]["Hellfire grenade"]			= { sfw_cw_sfire_tech = "hellfire_secondary" }
			sfsys["Options"]["Storm (single)"]				= { sfw_cw_sfire_tech = "storm_single" }
			sfsys["Options"]["Storm (volley)"]				= { sfw_cw_sfire_tech = "storm_multi" }
			sfsys["Options"]["Grinder"]						= { sfw_cw_sfire_tech = "grinder" }
			sfsys["Options"]["Pulsar (cascade beam)"]		= { sfw_cw_sfire_tech = "pulsar_primary" }
			sfsys["Options"]["Pulsar (electric pulse)"]		= { sfw_cw_sfire_tech = "pulsar_secondary" }
			sfsys["Options"]["Vapor"]						= { sfw_cw_sfire_tech = "vapor_primary" }
			sfsys["Options"]["Vapor (secondary)"]			= { sfw_cw_sfire_tech = "vapor_secondary" }
			sfsys["Options"]["Acidrain (gas cloud)"]		= { sfw_cw_sfire_tech = "acidrain_primary" }
			sfsys["Options"]["Acidrain (corrosive MIRV)"]	= { sfw_cw_sfire_tech = "acidrain_secondary" }
			sfsys["Options"]["Bane rifle"]					= { sfw_cw_sfire_tech = "bane" }
			sfsys["Options"]["RNG99 Synergy rifle"]			= { sfw_cw_sfire_tech = "synrifle" }
			sfsys["Options"]["Missile swarmer"]				= { sfw_cw_sfire_tech = "swarmer" }
			sfsys["Options"]["Grenade launcher"]			= { sfw_cw_sfire_tech = "nade" }
			sfsys["Options"]["Flechette shotgun"]			= { sfw_cw_sfire_tech = "flechette" }
			sfsys["Options"]["MTM VK CX33 grenade"]			= { sfw_cw_sfire_tech = "ca3_nade" }
			sfsys["Options"]["T3i Cryogenic grenade"]		= { sfw_cw_sfire_tech = "cryo" }
			sfsys["Options"]["Stinger"]						= { sfw_cw_sfire_tech = "stinger" }
			sfsys["Options"]["Stinger (secondary)"]			= { sfw_cw_sfire_tech = "stinger_secondary" }
			sfsys["Options"]["HS24 Heatwave"]				= { sfw_cw_sfire_tech = "heatwave" }
			sfsys["Options"]["HS24 Sapphire"]				= { sfw_cw_sfire_tech = "saphyre" }
			sfsys["Options"]["MTM CX33 guided missile"]		= { sfw_cw_sfire_tech = "mtmgm" }
			sfsys["Options"]["Vapor Grenade"]				= { sfw_cw_sfire_tech = "vapor_nade" }
			sfsys["Options"]["HS200-X Grenade"]				= { sfw_cw_sfire_tech = "charwave" }
			sfsys["Options"]["Pandemic Bolt"]				= { sfw_cw_sfire_tech = "pandemic" }
			sfsys["Options"]["Falling Star (primary)"]		= { sfw_cw_sfire_tech = "fstar_primary" }
			sfsys["Options"]["Falling Star (secondary)"]	= { sfw_cw_sfire_tech = "fstar_secondary" }
			sfsys["Options"]["Hornet"]						= { sfw_cw_sfire_tech = "hornet" }
			sfsys["Options"]["Flare Gun"]					= { sfw_cw_sfire_tech = "flare" }
			sfsys["Options"]["Spectra (fire)"]				= { sfw_cw_sfire_tech = "spectra_fire" }
			sfsys["Options"]["Spectra (corrosive)"]			= { sfw_cw_sfire_tech = "spectra_crsv" }
			sfsys["Options"]["Spectra (ice)"]				= { sfw_cw_sfire_tech = "spectra_cryo" }
			sfsys["Options"]["Prisma"]						= { sfw_cw_sfire_tech = "prisma" }
			sfsys["Options"]["Supra"]						= { sfw_cw_sfire_tech = "supra" }
			sfsys["Options"]["T3i Jotunn"]					= { sfw_cw_sfire_tech = "jotunn" }
			sfsys["Options"]["Air strike beacon"] 			= { sfw_cw_sfire_tech = "flare3" }
			sfsys["Options"]["Zeala"] 						= { sfw_cw_sfire_tech = "zeala" }
			sfsys["Options"]["Vectra (single)"]			 	= { sfw_cw_sfire_tech = "vectra" }
			sfsys["Options"]["Vectra (volley)"]			 	= { sfw_cw_sfire_tech = "vectra_volley" }
			sfsys["Options"]["Astra (carbine)"]			 	= { sfw_cw_sfire_tech = "astra_light" }
			sfsys["Options"]["Astra (sniper)"]				= { sfw_cw_sfire_tech = "astra_heavy" }
			sfsys["Options"]["Wrath"]					 	= { sfw_cw_sfire_tech = "wrath_normal" }
			sfsys["Options"]["Wrath (charged)"]				= { sfw_cw_sfire_tech = "wrath_charged" }
			sfsys["Options"]["Zoom"]						= { sfw_cw_sfire_tech = "zoom" }
	
		CPanel:AddControl( "ComboBox", sfsys )
		
end

hook.Add( "PopulateToolMenu", "PopulateScifiweaponsMenus", function()

	spawnmenu.AddToolMenuOption( 
	"Utilities", 
	"SciFi Weapons", 
	"ScifiWeaponsClient", 
	"Settings", 
	"", 
	"", 
	SciFiWeaponsSettings 
	)
	
	spawnmenu.AddToolMenuOption( 
	"Utilities", 
	"SciFi Weapons", 
	"ScifiCWeaponClient", 
	"Custom Weapon Settings", 
	"", 
	"", 
	SFWCustomWeaponSettings 
	)

end )