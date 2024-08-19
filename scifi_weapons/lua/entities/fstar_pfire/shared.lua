AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Falling Star"
ENT.SvThinkDelay	= 0.02
-- ENT.NewHitMechanic 	= true
ENT.CollisionProxySize = Vector( 32, 32, 32 )
ENT.ProjectileImpactRule = bit.bor( PROJECTILE_IMPACT_PHYSICS, PROJECTILE_IMPACT_TRACECAST )
ENT.PhxSSize		= 8
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= true
ENT.PhxDragAmount 	= 512
ENT.FxTracer		= "fstar_tracer" 
ENT.SndImpact 		= "scifi.vapor.hit"
ENT.LifeTime		= 0.7
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "80 120 255 255"
ENT.LightSpotRadius	= 256
ENT.LightDistance	= 512
ENT.LightBrightness	= 1
ENT.LightFlareSize 	= 0.6
ENT.SoundEmit		= false

ENT.MeteorEnabled 			= true
ENT.MeteorDetectionRange 	= 32
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInitial 	= 1
ENT.MeteorVelocityScale 	= 1
ENT.MeteorHomingFactor 		= 64
ENT.MeteorAlwaysTrack  		= false
ENT.MeteorSwayScale 		= 12
ENT.MeteorVelocityDecay 	= false
ENT.MeteorNeverForget 		= true
-- ENT.MeteorSelfDestruct 		= true

function ENT:SubThink()
	
	if ( SERVER ) && ( IsValid( self) ) && ( !self:GetMTarLocked() ) then
		self:GetPhysicsObject():ApplyForceCenter( VectorRand() * 64 )
	end

end

function ENT:XPlode( pCollisionData )

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )

	if ( SERVER ) then
		local pos = self:GetPos()
		if ( pCollisionData ) then
			pos =  pCollisionData.HitPos
		end
		
		self:DealAoeDamage( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ), 12 * amp, pos, 64 ) -- Remember: This 33540137 is the ultimate damage type...
		for k,v in pairs ( ents.FindInSphere( pos, 64 ) ) do
			self:DealDirectDamage( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ), 8 * amp, v, self:GetValidOwner() )
			if ( GetRelChance( 5 ) ) then
				DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 0.6, Attacker = self.Owner } )
			end
		end
			
		local fx2 = ents.Create( "light_dynamic" )
		if ( !IsValid( fx2 ) ) then return end
		fx2:SetKeyValue( "_light", "100 140 255 255" )
		fx2:SetKeyValue( "spotlight_radius", 320 )
		fx2:SetKeyValue( "distance", 640 )
		fx2:SetKeyValue( "brightness", 3 )
		fx2:SetPos( pos )
		fx2:Spawn()
		fx2:Fire( "kill", "", 0.115 )
		
		ParticleEffect( "fstar_hit", pos, Angle( 0, 0, 0 ) )
		
		util.ScreenShake( pos, 16, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
		
		self:KillSilent()
	end
	
end