AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_sprites = GetConVar( "sfw_fx_sprites" )

ENT.PrintName 		= "Supra: Child"

ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 4
ENT.PhxGrav			= false
ENT.PhxDrag			= true
ENT.PhxDragAmount	= 512
ENT.FxTracer		= "supra_mirv" 
ENT.SndImpact 		= "scifi.supra.parent.hit"
ENT.LifeTime		= 0.92
ENT.OnWater			= PROJECTILE_RULE_XPLODE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "120 130 255 255"
ENT.LightXplode 	= 4
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 300
ENT.LightBrightness	= 1
ENT.LightDieTime	= 0.4
ENT.LightDecay		= 1768
ENT.LightFlareColor	= Color( 120, 130, 255, 80 ) -- Color( 80, 155, 255 )

ENT.MeteorEnabled 			= true
ENT.MeteorAlwaysTrack 		= true
ENT.MeteorDetectionRange 	= 48
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInital 	= 0
ENT.MeteorVelocityScale 	= 0
ENT.MeteorHomingFactor 		= 3
ENT.MeteorAlwaysTrack  		= false
ENT.MeteorSwayScale 		= 1
ENT.MeteorNeverForget 		= true
ENT.MeteorVelocityDecay 	= true
ENT.MeteorVelocityDecayRatio = 1
ENT.MeteorVelocityDecayExponent = 2.5

function ENT:SubInit()

	self:EmitSound( "scifi.supra.child.arm" )

	if ( SERVER ) then
		if ( cmd_sprites:GetBool() ) then
			util.SpriteTrail( 
				self, 								-- parent
				1, 									-- attachment ID
				self.LightFlareColor, 				-- Color
				1, 									-- force additive rendering
				12, 								-- start width
				0, 									-- end width
				0.6,								-- lifetime
				16,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
	end

end

function ENT:SubThink()

	if ( CLIENT ) then
		local fScale = 1 - ( self.DieTime - CurTime() ) / self.LifeTime
		fScale = math.max( fScale, 0 )
		
		self.LightBrightness = 1 * fScale
		self.LightDistance = 300 * fScale
	end

end

function ENT:PhysicsCollide( pCollisionData, phys )

	if ( pCollisionData.HitEntity:IsWorld() ) then 
		phys:ApplyForceCenter( pCollisionData.HitNormal * pCollisionData.Speed * -4 )
	
		return 
	end

	self:XPlode()

end

function ENT:OnRemove()

	self:XPlode()

end

function ENT:XPlode()
	
	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )

	local amp = GetConVar( "sfw_damageamp" ):GetFloat()
	
	self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )

	if ( SERVER ) then
	
		local vOrigin = self:GetPos()
	
		self:DealAoeDamage( DMG_SF_BLIGHT, 12 * amp, vOrigin, 200 )
		self:DealAoeDamage( DMG_BLAST, 12 * amp, vOrigin, 200 )

		ParticleEffect( "supra_c_hit", vOrigin, Angle( 0, 0, 0 ) )
		
		util.ScreenShake( vOrigin, 12, 2, 0.25, 512 )
		self:EmitSound( self.SndImpact )

		local fx1 = EffectData()
		fx1:SetOrigin( vOrigin )
		fx1:SetAngles( Angle( 0, 0, 0 ) )
		fx1:SetRadius( 16 )
		fx1:SetScale( 0.2 )
		fx1:SetNormal( Vector( 0.1, 0.2, 0.6 ) )
		util.Effect( "scifi_aftershock", fx1 )
		
		self:KillSilent()
	
	end
	
	self:EmitSound( "sound/null.wav" )
	
end