AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "bloom/halo_static_2" )

ENT.PrintName 		= "ngen missile cheap"
ENT.SvThinkDelay 	= 0
ENT.RMdl 			= "models/props_bts/rocket.mdl"
ENT.RMat 			= "models/props_bts/rocket_sentry" 
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSProp 		= "Metal"
ENT.PhxSSize 		= 0.1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.PhxMass			= 1
ENT.PhxElastic		= 3200
ENT.FxTracer 		= nil
ENT.SndImpact 		= "BaseExplosionEffect.Sound" --"scifi.seraph.fire1"
ENT.LifeTime		= 6
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "255 140 80 255" --"80 10 4 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 220
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = Color( 255, 140, 80 )
ENT.LightFlareAlpha	= 80
ENT.LightFlareAdd 	= true 	
ENT.LightFlareSize 	= 0.24

ENT.MeteorEnabled 			= true
ENT.MeteorDetectionRange 	= 64
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInital 	= 64
ENT.MeteorVelocityScale 	= 2
ENT.MeteorHomingFactor 		= 512
ENT.MeteorAlwaysTrack  		= true
ENT.MeteorSwayScale 		= 2
ENT.MeteorVelocityDecay 	= false
ENT.MeteorNeverForget 		= true

function ENT:SubInit( ent, phys )
	
	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 								-- parent
				1, 									-- attachment ID
				Color( 46, 42, 3, 80 ), 			-- Color
				false, 								-- force additive rendering
				2, 									-- start width
				0, 									-- end width
				0.6,								-- lifetime
				32,									-- texture resulution
				"particle/beam_smoke_02.vmt" 		-- texture
			)
		end

		ent:SetXPloding( false )
		
		self.SwayOffset = math.random( -1024, 1024 )
	end
	
end

function ENT:SubThink( ent, phys )
	
	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()
	local eHoming = Vector( 0, 0, 0 )
	
	if ( !self.TargetEntity ) && ( IsValid( self.Owner ) ) then
		self.TargetEntity = self.Owner:GetEyeTrace().Entity
	end

	local trData = {}
	local trResult = {}
	local trSize = Vector( 1, 4, 4 )

	trData.start 		= eOrigin - eOffset * 4
	trData.endpos 		= eOrigin + eOffset * 4
	trData.filter 		= function( ent ) 	
							if !( ent || IsValid( ent ) ) then 
								return false
							end
							
							if ( ent:GetClass() == self.ClassName ) then
								return false
							end
							
							if ( ent == self || ent == self.Owner || ent:GetOwner() == self.Owner ) then 
								return false
							end

							return true 
						end
	
	trData.mins 		= trSize * -1
	trData.maxs 		= trSize
	trData.mask 		= MASK_SHOT_HULL
	trData.ignoreworld 	= false --true
	trData.output 		= trResult

	util.TraceHull( trData )

	local lnData = {}
	local lnResult = {}

	lnData.start 		= eOrigin - eOffset * 6
	lnData.endpos 		= eOrigin + eOffset * 6
	lnData.filter 		= trData.filter
	lnData.mask 		= MASK_SHOT_HULL
	lnData.ignoreworld 	= false
	lnData.output 		= lnResult
	
	util.TraceLine( lnData )
	
	if ( SERVER ) then
		if ( trResult.HitSky || lnResult.HitSky ) && ( !self:GetXPloding() ) then
			self:SetXPloding( true )
			self:Remove()
		end

		if ( lnResult.Hit || trResult.Hit ) && ( !self:GetXPloding() ) then
			local data
			if ( trResult.Hit ) then
	--			print("hull")
				data = trResult
			else
	--			print("line")
				data = lnResult
			end
			
			self:XPlode( data )
		end
		
		local phys = self:GetPhysicsObject()
		if ( !IsValid( phys ) ) then return end
		
		local fTime = CurTime() + self.SwayOffset
		local mSin, mCos = math.sin( fTime * ( 12 + self.SwayOffset * 0.01 ) ), math.cos( fTime * 12 )
		
		local vSway = Vector( mSin, mCos, mSin * 0.5 + mCos * 2 ) * ( 2 + mCos )
		vSway = vSway * 32

		if ( IsValid( self.Owner ) && self.Owner:IsNPC() ) then
		--	self:SetAngles( self.Owner:GetAimVector():Angle() )
		end	
		
		local tEntity = self.TargetEntity

		if ( IsValid( tEntity ) && ( tEntity:IsNPC() || tEntity:IsPlayer() ) ) then
			local tOrigin = tEntity:EyePos()

		--	self:SetAngles( eOffset:Angle() )
			eHoming = ( tOrigin - eOrigin )
		else
			eOffset = eOffset * 1024
		end
		
		local vVelocity = ( eOffset * 4 + eHoming ) * ( 4 + 4 * ( 1 + mSin ) ) + vSway
		
		phys:ApplyForceCenter( vVelocity )
		self:SetAngles( vVelocity:GetNormal():Angle() )
	end

end

function ENT:PhysicsCollide( data, phys )
	
	if ( data.Speed > 72 ) then 
		self:EmitSound( "Grenade.ImpactHard" )
	end

	if ( !self:GetXPloding() ) then
		self:XPlode()
	end
	
end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	util.Decal( "scorch", self:GetPos(), self:GetPos() - Vector( 0, 0, 8 ) )

	if ( SERVER ) then

		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_AIRBOAT ), 30 * amp, self:GetPos(), 180 )
		self:DealAoeDamage( DMG_BLAST, 30 * amp, self:GetPos(), 180 )
	--	self:DealAoeDamage( DMG_BLAST, 8 * amp, self:GetPos(), 512 )
		
		-- local fx = ents.Create( "light_dynamic" )
		-- if ( !IsValid( fx ) ) then return end
		-- fx:SetKeyValue( "_light", "255 170 120 255" )
		-- fx:SetKeyValue( "spotlight_radius", 512 )
		-- fx:SetKeyValue( "distance", 512 )
		-- fx:SetKeyValue( "brightness", 4 )
		-- fx:SetPos( self:GetPos() )
		-- fx:Spawn()
		
	--	ParticleEffect( "spr_explosion_large_smoshroom", fx:GetPos() + Vector( 0, 0, 24 ), Angle( 1, 1, 1 ), self:GetValidOwner() )
	--	ParticleEffect( "xplo_hit", fx:GetPos() + Vector( 0, 0, 32 ), Angle( 1, 1, 1 ), self:GetValidOwner() )
		ParticleEffect( "eml_generic_blast", self:GetPos(), Angle( 1, 1, 1 ), self:GetValidOwner() )
		
		self:EmitSound( "BaseExplosionEffect.Sound" )
		--fx:EmitSound( "explode_4" )
		util.ScreenShake( self:GetPos(), 2048, 512, 1.2, 512 )
		
		self:KillSilent()
		-- SafeRemoveEntityDelayed( fx, 0.16 )
		
	end
	
end