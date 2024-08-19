--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v18 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Damage dealing functions. 							--
------------------------------------------------------------------
-- Has to be included by a weapon via AddCSLuaFile()			--
------------------------------------------------------------------

AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )

SCIFI_INTEGRITY_FLAG_DAMAGE = 20210727213519

local cmd_debug_showdmgranges = GetConVar( "sfw_debug_showdmgranges" )

function SWEP:DealDirectDamage( dmgtype, dmgamt, target, attacker, dmgforce )

	if ( !IsValid( target ) ) then return end
	if ( !dmgforce ) then dmgforce = Vector( 0, 0, 1 ) end
	
	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	dmg:SetAttacker( attacker )
	dmg:SetInflictor( self )
	dmg:SetDamageForce( dmgforce )
	dmg:SetDamage( dmgamt )
	
	-- if ( target:IsPlayer() || target:IsNPC() ) then
		target:TakeDamageInfo( dmg ) 
	-- end
	
	local iDebug = cmd_debug_showdmgranges:GetInt()
	
	if ( iDebug >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring( self ).." dealt "..tostring( dmgamt ).." ("..tostring( dmgtype )..") damage vs. "..tostring( target ) )
	end
	
	if ( iDebug == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring( self ).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage vs. "..tostring( target ).."\n" )
	end
	
end

function SWEP:DealAoeDamage( dmgtype, dmgamt, src, range, dmgforce, dmgforcemul )
	if ( !dmgforce || !isvector( dmgforce ) ) then dmgforce = Vector( 0, 0, 1 ) end
	if ( !dmgforcemul ) then dmgforcemul = dmgamt * 0.1 end

	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( self.Owner == NULL || self == NULL ) then
		dmg:SetAttacker( Entity( 0 ) )
	else
		dmg:SetAttacker( self.Owner )
	end
	dmg:SetInflictor( self )
	dmg:SetDamageForce( dmgforce * dmgforcemul )
	dmg:SetDamage( dmgamt )
	
	util.BlastDamageInfo( dmg, src, range )
	
	local iDebug = cmd_debug_showdmgranges:GetInt()
	
	if ( iDebug >= 1 ) then
		debugoverlay.Sphere( src, range, 0.5, Color( 255, 100, 100, 20 ), false )
		debugoverlay.Sphere( src, range / 2, 0.5, Color( 255, 50, 50, 25 ), false ) 
	end
	
	if ( iDebug >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.."  ("..tostring( dmgtype )..") damage, within "..range.." units." )
	end
	
	if ( iDebug == 3 ) then
		MsgC( Color( 200, 175, 80 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.."  ("..tostring( dmgtype )..") damage, within "..range.." units.\n" )
	end
	
end

function SWEP:DealAoeDamageOverTime( dmgtype, dmgamt, src, range, lifetime, tickdelay, parent )

	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( self.Owner == "NULL" ) or ( self.Owner == nil ) then
		dmg:SetAttacker( ents.GetByIndex( 0 ) )
	else
		dmg:SetAttacker( self.Owner )
	end
	dmg:SetInflictor( self )
	dmg:SetDamageForce( Vector( 0, 0, 1 ) )
	dmg:SetDamage( dmgamt )
	
	local iDebug = cmd_debug_showdmgranges:GetInt()
	
	if ( iDebug >= 1 ) then
		debugoverlay.Sphere( src, range, lifetime, Color( 200, 175, 80, 10 ), false ) 
		debugoverlay.Sphere( src, range / 2, lifetime, Color( 255, 205, 120, 25 ), false ) 
	end
	
	if ( iDebug >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units with a lifetime of "..lifetime.." seconds." )
	end
	
	if ( iDebug == 3 ) then
		MsgC( Color( 200, 175, 80 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units with a lifetime of "..lifetime.." seconds.\n" )
	end

	timer.Create( "hurt" .. parent:EntIndex(), tickdelay, 300, function()
		util.BlastDamageInfo( dmg, src, range )
	end )
	
	timer.Create( "SafeRemoveTimer".. parent:EntIndex(), lifetime, 0, function()
		timer.Remove( "hurt" .. parent:EntIndex() )
		timer.Remove( "SafeRemoveTimer" .. parent:EntIndex() )
	end )

end