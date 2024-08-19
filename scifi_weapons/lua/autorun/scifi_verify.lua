--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v18 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Verify integrity of base components by comparing    --
-- integrity flags 												--
------------------------------------------------------------------
-- Initialized via autorun.										--
------------------------------------------------------------------

SCIFI_INTEGRITY_FLAG_VERIFY = 20210727213519

local fnIntegrityCheck = function()
	local tCheck = {
		[ "initialize" ] = 			{ flag = SCIFI_INTEGRITY_FLAG_INIT, cl = true, sv = true },
		[ "precache" ] = 			{ flag = SCIFI_INTEGRITY_FLAG_PRECACHE, cl = true, sv = true },
		[ "verify" ] = 				{ flag = SCIFI_INTEGRITY_FLAG_VERIFY, cl = true, sv = true },
		[ "sounds" ] = 				{ flag = SCIFI_INTEGRITY_FLAG_SOUNDS, cl = true, sv = true },
		-- [ "additions" ] = 			{ flag = SCIFI_INTEGRITY_FLAG_ADDITIONS, cl = true, sv = true },
		[ "base/globals" ] = 		{ flag = SCIFI_INTEGRITY_FLAG_GLOBALS, cl = true, sv = true },
		[ "base/hooks" ] = 			{ flag = SCIFI_INTEGRITY_FLAG_HOOKS, cl = true, sv = true },
		[ "base/hud" ] = 			{ flag = SCIFI_INTEGRITY_FLAG_HUD, cl = true, sv = true },
		[ "base/elemental" ] = 		{ flag = SCIFI_INTEGRITY_FLAG_ELEMENTALS, cl = true, sv = true },
		[ "base/render" ] = 		{ flag = SCIFI_INTEGRITY_FLAG_RENDER, cl = true, sv = true },
		[ "base/base" ] = 			{ flag = SCIFI_INTEGRITY_FLAG_SWEP, cl = true, sv = true },
		[ "base/damage" ] = 		{ flag = SCIFI_INTEGRITY_FLAG_DAMAGE, cl = true, sv = true },
		[ "base/projectile" ] = 	{ flag = SCIFI_INTEGRITY_FLAG_SENT, cl = true, sv = true },
		[ "effects/muzzleflash" ] = { flag = SCIFI_INTEGRITY_FLAG_FX, cl = true, sv = false }
	}

	local bIssues = false
	for k, v in pairs( tCheck ) do
		if ( !v || !v.flag || v.flag != SCIFI_INTEGRITY_FLAG_VERIFY ) then
			if ( CLIENT && v.cl != CLIENT ) || ( SERVER && v.sv != SERVER ) then
				continue
			end
			
			bIssues = true
			MsgC( Color( 220, 20, 40 ), "@SciFiWeapons : !Error; Integrity mismatch ("..k.."). Found '"..tostring(v.flag).."', should be '"..SCIFI_INTEGRITY_FLAG_VERIFY.."'.\n" )
		end
	end
	
	if ( bIssues ) then
		MsgC( Color( 220, 20, 40 ), "Make sure there are no outdated base components or files overwriting updated content!\n" )
	
		if ( CLIENT ) then
			-- LocalPlayer():ChatPrint( "SciFi Base detected compatibility issues, check developer console for details." )
			notification.AddLegacy( "SciFi Base detected compatibility issues, check developer console for details.", NOTIFY_ERROR, 15 )
		end
	end
end

-- fnIntegrityCheck()

hook.Add( "InitPostEntity", "ScifiSelfTesting", function()
	-- timer.Simple( 10, function()
		fnIntegrityCheck()
	-- end )
end ) 