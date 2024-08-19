AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_sprites = GetConVar( "sfw_fx_sprites" )

ENT.PrintName 		= "Astra Bolt"
ENT.SvThinkDelay 	= 0
ENT.ClThinkDelay 	= 0
ENT.PhxMaxVelocity 	= 16000
ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 20
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "astra_bolt" 
ENT.SndImpact 		= "scifi.spectra.hit" -- "scifi.eblade.hit"
ENT.LifeTime		= 4
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "120 130 255 255"
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 300
ENT.LightBrightness	= 1
ENT.LightDieTime	= 0.1
ENT.LightDecay		= 1768
ENT.LightFlareColor	= Color( 80, 155, 255 )
ENT.LightFlareSize 	= 0.8
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.spectra.flyby"

function ENT:SubInit()

	self:SetXPloding( false )

	if ( SERVER ) then
		if ( cmd_sprites:GetBool() ) then
			util.SpriteTrail( 
				self, 								-- parent
				1, 									-- attachment ID
				self.LightFlareColor, 			 	-- Color
				1, 									-- force additive rendering
				6, 									-- start width
				0, 									-- end width
				0.04,								-- lifetime
				16,									-- texture resulution
				"particle/beam_fire_nocolor_add.vmt" 			-- texture
			)
		end
	end
	
end

local sTargetBone = "ValveBiped.Bip01_Head1"

local function GetHeadBone( entTarget )

	if ( !IsValid( entTarget ) ) then return end

	local iGroupCount = entTarget:GetHitBoxGroupCount()
	
	if ( !iGroupCount ) then return end
	
	for iGroupID = 0, iGroupCount - 1 do
		local iHBoxCount = entTarget:GetHitBoxCount( iGroupID )

		for iHboxID = 0, iHBoxCount - 1 do
			local bone = entTarget:GetHitBoxBone( iHboxID, iGroupID )
			
			if ( entTarget:GetBoneName( bone ) == sTargetBone ) then
				return bone
			end
		end
	end

end

function ENT:SubThink()

	local entTarget = self:GetNWEntity( "target" )

	if ( SERVER ) then
		local eOrigin = self:GetPos()
		local eAngles = self:GetAngles()
		local eOffset = eAngles:Forward()
		local phys = self:GetPhysicsObject()
		
		if( IsValid( self.Owner ) && IsValid( entTarget ) ) then
			if ( IsValid( entTarget ) && ( entTarget:IsNPC() || entTarget:IsPlayer() ) ) then
				if ( entTarget:IsNPC() && entTarget:Disposition( self.Owner ) ~= D_LI ) || ( entTarget:IsPlayer() && entTarget != self.Owner ) then
				--	local vBullsEye = entTarget:EyePos()
					
					local HeadBone = GetHeadBone( entTarget )
					
					local vBullsEye
					if ( HeadBone ) then
						vBullsEye = entTarget:GetBonePosition( HeadBone )
					else
						vBullsEye = entTarget:EyePos()
					end

					self:SetAngles( self:GetVelocity():Angle() )
					phys:ApplyForceCenter( ( vBullsEye - eOrigin ) * 512 )
				end
			end
		else
			phys:ApplyForceCenter( eOffset * 16384 )
		end	

		local trData = {}
		local trResult = {}
		local trSize = Vector( 24, 12, 12 )

		trData.start 		= eOrigin - eOffset * 24
		trData.endpos 		= eOrigin + eOffset * 24
		trData.filter 		= { self, self.Owner }
		trData.mins 		= trSize * -1
		trData.maxs 		= trSize
		trData.mask 		= MASK_SHOT_HULL
		trData.ignoreworld 	= true
		trData.output 		= trResult
		
		util.TraceHull( trData )
		
		if ( SERVER ) && ( trResult.Hit ) then
			self:XPlode( trResult )
		end
	end

end

function ENT:XPlode( pCollisionData )
	
	if ( self:GetXPloding() ) then return end

	local phys = self:GetPhysicsObject()
	if ( phys ) then
		phys:EnableMotion( false )
	end
	
	self:SetXPloding( true ) 
	
	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetPos()
			dlight.r = 200
			dlight.g = 220
			dlight.b = 255
			dlight.brightness = 512
			dlight.Decay = 1024
			dlight.Size = self.LightDistance * 3
			dlight.DieTime = CurTime() + 1
		end
	end
	
	if ( SERVER ) then
		local pos = pCollisionData.HitPos - pCollisionData.HitNormal * 2 -- self:GetPos()
		local ang = self:GetAngles()
		local dmg_1 = 12 * GetConVarNumber( "sfw_damageamp" )
		
		if ( pCollisionData.Entity ) && ( !pCollisionData.HitWorld ) then
			local tPhys = pCollisionData.Entity:GetPhysicsObject()
			if ( IsValid( tPhys ) ) then
				tPhys:ApplyForceCenter( ang:Forward() * 8192 )
			end
		end

		self:DealPointDamage( bit.bor( DMG_BULLET, DMG_NEVERGIB ), dmg_1, self:GetPos(), 512, 1, 4 )

		ParticleEffect( "astra_hit", pos, ang )
		if ( self:WaterLevel() > 0 ) then
			ParticleEffect( "event_onwater_remove", pos, ang )
		end
		util.ScreenShake( pos, 12, 14, 0.25, 256 )
		
		self:EmitSound( self.SndImpact )
		self:KillSilent()
	end
	
end

function ENT:ImpactTrace( tr, dmgtype, AirboatGunImpact )
	
    return true
	
end