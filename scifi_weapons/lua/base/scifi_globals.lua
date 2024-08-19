--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v18 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Stores global functions like IsExistent and stuff. 	--
------------------------------------------------------------------
-- Is included by scifi_base.lua								--
------------------------------------------------------------------

SCIFI_INTEGRITY_FLAG_GLOBALS = 20210727213519

SCIFI_STATE_IDLE = 0
SCIFI_STATE_SPRINT = 1
SCIFI_STATE_ADS = 2
SCIFI_STATE_MELEE_ATTACK = 3
SCIFI_STATE_MELEE_RETIRE = 4
SCIFI_STATE_RELOADING = 5

SCIFI_SCK_TYPE_MODEL = 0
SCIFI_SCK_TYPE_SPRITE = 1
SCIFI_SCK_TYPE_LASER = 2
SCIFI_SCK_TYPE_QUAD = 3

AddCSLuaFile()

function DevMsg( text )

	if ( !GetConVar( "developer" ):GetBool() ) then return end
	
	print( text )

end

function ArrangeElements( minvalue, maxvalue )

	if ( amt == nil ) then
		amt = minvalue
		return amt
	end
 
	if ( ( amt + 1 ) >= maxvalue ) then 
		amt = minvalue 
		return amt 
	end 

	if ( amt >= minvalue ) then
		amt = amt + 1
		return amt
	end 

end

function IsExistent( ent )

	if ( ent == nil ) or ( ent == NULL ) then
	
	return false
	
	end
	
	return true

end

function IsVisibleToEntity( ent1, observer )

	local vistrace = util.TraceEntity( {
		start = ent1:GetPos(),
		endpos = observer:GetPos(),
		filter = function( ent ) if ( ent == ent1 ) or ( ent:IsRagdoll() ) then return false else return true end end,
		mask = MASK_SHOT,
		ignoreworld = false
	}, ent1 )

	if ( vistrace.Entity == observer ) or ( vistrace.HitPos:Distance( observer:GetPos() ) <= 1 ) then
		return true
	else
		return false
	end

end

function DLightFade( light, minradius, maxradius, fadeamt, dietime )
		
	local brightness = maxbright
	local range = maxradius
	local srange = range / 2
	
	timer.Create( "daylightdies" .. light:EntIndex(), 0, 0, function()
	
		range = range - fadeamt
		srange = range / 2
		
		if ( light == NULL ) then 
			timer.Remove( "daylightdies" .. light:EntIndex() ) 
		else
			light:Fire( "distance", range, 0 )
			light:Fire( "spotlight_distance", srange, 0 )
		end
		
		if ( range == minradius ) then
			timer.Remove( "daylightdies" .. light:EntIndex() )
		end
		
	end )
	
	timer.Create( "SafeRemoveTimer" .. light:EntIndex(), dietime, 0, function()
	
		timer.Remove( "daylightdies" .. light:EntIndex() )
		timer.Remove( "SafeRemoveTimer" .. light:EntIndex() )
		
	end )
	
end

function GetRelChance( perc ) 

	local rng = math.random( 0.000, 100.000 )
	
	if ( rng < perc ) then
	
		return true
	
	else 
	
		return false
	
	end

end