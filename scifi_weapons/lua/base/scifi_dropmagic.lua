--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v18 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Auto-derived by scifi_base.lua								--
-- Also see scifi_globals.lua									--
-- The whole item drop magic happens here.						--
------------------------------------------------------------------

AddCSLuaFile()

local factions = {
	["antlions_common"] = { "npc_antlion", "npc_antlion_worker", "npc_antlion_grub" },
	["antlions_heavy"] = { "npc_antlionguard" },
	["combine_extra"] = { "npc_sniper" },
	["combine_heavy"] = { "npc_hunter", "npc_strider", "npc_gunship" },
	["combine_minor"] = { "npc_metropolice", "npc_stalker" },
	["combine_soldiers"] = { "npc_combine_s" },
	["xenians"]	= { "npc_vortigaunt" },
	["zombies"] = { "npc_zombie", "npc_fastzombie", "npc_poisonzombie", "npc_zombine" }
}

local droptables = {
	["antlions_common"] = { "sfw_eblade", "sfw_pandemic" },
	["antlions_heavy"] = { "sfw_grinder", "sfw_pandemic" },
	["combine_extra"] = { "sfw_phoenix" },
	["combine_heavy"] = { "sfw_pyre", "sfw_hornet" },
	["combine_minor"] = { "sfw_ember" },
	["combine_soldiers"] = { "sfw_hwave", "sfw_phoenix", "sfw_seraphim", "sfw_draco" },
	["xenians"]	= { "sfw_neutrino" },
	["zombies"] = { "sfw_lapis", "sfw_saphyre", "sfw_aquamarine", "sfw_storm" }
}

local items = {
	["0"] = { class = "sfi_supplies", likely = 1 },
	["1"] = { class = "sfi_health", likely = 1 },
	["2"] = { class = "sfi_shield", likely = 1 },
	["3"] = { class = "sfi_upgrade", likely = 0.4 },
}

function GetDrop( npc )

	if ( table.HasValue( factions[ "antlions_common" ], npc:GetClass() ) ) then
		
		return table.Random( droptables[ "antlions_common" ] )
	
	elseif ( table.HasValue( factions[ "antlions_heavy" ], npc:GetClass() ) ) then
	
		return table.Random( droptables[ "antlions_heavy" ] )
	
	elseif ( table.HasValue( factions[ "combine_extra" ], npc:GetClass() ) ) then
	
		return table.Random( droptables[ "combine_extra" ] )
	
	elseif ( table.HasValue( factions[ "combine_heavy" ], npc:GetClass() ) ) then
	
		return table.Random( droptables[ "combine_heavy" ] )
	
	elseif ( table.HasValue( factions[ "combine_minor" ], npc:GetClass() ) ) then
	
		return table.Random( droptables[ "combine_minor" ] )
	
	elseif ( table.HasValue( factions[ "combine_soldiers" ], npc:GetClass() ) ) then
	
		return table.Random( droptables[ "combine_soldiers" ] )
		
	elseif ( table.HasValue( factions[ "xenians" ], npc:GetClass() ) ) then
	
		return table.Random( droptables[ "xenians" ] )
	
	elseif ( table.HasValue( factions[ "zombies" ], npc:GetClass() ) ) then
	
		return table.Random( droptables[ "zombies" ] )
		
	end

end

function GetValidFaction( npc )

	if ( table.HasValue( factions[ "antlions_common" ], npc:GetClass() ) ) or 
	( table.HasValue( factions[ "antlions_heavy" ], npc:GetClass() ) ) or
	( table.HasValue( factions[ "combine_extra" ], npc:GetClass() ) ) or
	( table.HasValue( factions[ "combine_heavy" ], npc:GetClass() ) ) or
	( table.HasValue( factions[ "combine_minor" ], npc:GetClass() ) ) or
	( table.HasValue( factions[ "combine_soldiers" ], npc:GetClass() ) ) or
	( table.HasValue( factions[ "xenians" ], npc:GetClass() ) ) or
	( table.HasValue( factions[ "zombies" ], npc:GetClass() ) ) then
	
		return true

	end

end

hook.Add( "OnNPCKilled", "DropItemOnNPCKilled", function( npc, attacker )

	if ( SERVER ) then
		local cmd_allowdrops = GetConVar( "sfw_allow_supplydrop" ):GetBool()
	
		if ( !cmd_allowdrops ) then return end
		
		local cmd_particles = GetConVar( "sfw_fx_particles" ):GetBool()
		local cmd_debug_chattext = GetConVar( "sfw_debug_obviousdropmessages" ):GetInt()
		local cmd_dropchance_items = GetConVar( "sfw_supplydrop_chance_items" ):GetFloat()
		local cmd_dropchance_weapons = GetConVar( "sfw_supplydrop_chance_weapons" ):GetFloat()

		local cate = math.random( 0, 3 )
		cate = tostring( cate )
		local drop = items[ cate ]

		if ( GetRelChance( cmd_dropchance_items * drop.likely ) ) then
			local ent = ents.Create( drop.class )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( npc:GetPos() + Vector( 0, 0, 42 ) )
			ent:Spawn()
			ent:Activate()
		end
		
		-- Oh gawd, I'm so bored...
		if ( GetRelChance( cmd_dropchance_weapons ) ) && ( GetValidFaction( npc ) ) then
			local ent = ents.Create( GetDrop( npc ) )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( npc:GetPos() + Vector( 0, 0, 42 ) )
			ent:Spawn()
			ent:Activate()
			
			if ( cmd_particles == 1 ) then
				ParticleEffectAttach( "ngen_core_playerfx", 1, ent, 1 )
			end
			
			
			if ( cmd_debug_chattext >= 1 ) then 
				local msg = tostring( npc ) .. " dropped a " .. ent.PrintName .. " (" .. tostring( ent ) .. ")"
				
				if ( cmd_debug_chattext >= 2 ) && ( attacker:IsPlayer() ) then 
					--chat.AddText( Color( 200, 175, 255 ), msg )
					attacker:ChatPrint( msg )
				else
					print( msg )
				end
			end
		end
		
	end
	
end )