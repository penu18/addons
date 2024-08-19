AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Zeala Nade"
ENT.ProjectileImpactRule = bit.bor( PROJECTILE_IMPACT_PHYSICS, PROJECTILE_IMPACT_TRACECAST )
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.RMdl 			= ""
ENT.PhxSSize		= 8
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "zeala_nade" 
ENT.SndImpact 		= ""
ENT.LifeTime		= 10
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnImpact 		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightColor		= "149 155 255 255"
ENT.LightSpotRadius	= 256
ENT.LightDistance	= 512
ENT.LightBrightness	= 1
ENT.LightFlareAlpha = 16
ENT.LightFlareColor = Color( 107, 111, 182, 255 )
ENT.LightFlareSize 	= 1
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.spectra.flyby.heavy"
--[[
function ENT:SubThink( ent )

	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	local trData = {}
	local trResult = {}
	local trSize = Vector( 8, 8, 8 )

	trData.start 		= eOrigin
	trData.endpos 		= eOrigin
	trData.filter 		= { self, self.Owner }
	trData.mins 		= trSize * -1
	trData.maxs 		= trSize
	trData.mask 		= MASK_SHOT_HULL
	--trData.ignoreworld 	= true
	trData.output 		= trResult
	
	util.TraceHull( trData )
	
	if ( SERVER ) && ( trResult.Hit ) then
		if ( trResult.HitSky ) then
			self:KillSilent()
			return
		end
	
		if ( !self:GetXPloding() ) then
			self:XPlode( trResult )
		end
	end
	
end
]]--
function ENT:OnTakeDamage( CTakeDamageInfo )

	if ( self:GetXPloding() ) then return end

	local InfEntity = CTakeDamageInfo:GetInflictor()
	local InfClass	= InfEntity:GetClass()
	local origin = self:GetPos()
	
	if ( SERVER ) && ( InfClass == "sfw_vortex_world" ) then
	
		local amp = GetConVarNumber( "sfw_damageamp" )
		self:DealAoeDamage( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ), 16 * amp, origin, 512 )
		
		ParticleEffect( "zeala_burst", origin, Angle( 0, 0, 0 ) )
		
		util.ScreenShake( origin, 4, 8, 0.25, 256 )
		self:EmitSound( "scifi.zeala.burst" )
		
		self:KillSilent()
	end

end

function ENT:XPlode( pCollisionData )

	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )
	
	if ( SERVER ) then
		local pos = self:GetPos()
		
		if ( pCollisionData ) then
			pos = ( pCollisionData.HitNormal * -72 ) + pCollisionData.HitPos
		end
		
		local vortex = ents.Create( "sfw_vortex_world" )
		if ( !IsValid( vortex ) ) then return end
		vortex:SetPos( pos )
		vortex:SetAngles( Angle( 0, 0, 0 ) )
		vortex:SetOwner( self:GetValidOwner() )
		vortex:Spawn()
		
		self:KillSilent()
	end
	
end