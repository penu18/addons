AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local cmd_sprites = GetConVar( "sfw_fx_sprites" )

ENT.PrintName 		= "Supra: Parent"

ENT.PhxMass 		= 4
ENT.PhxGrav			= true
ENT.FxTracer 		= "supra_nade"
ENT.FxImpact 		= "supra_p_hit"

ENT.SndImpact 		= "scifi.vapor.nade.explo"

ENT.LifeTime		= 120
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "210 190 255 255"
ENT.LightXplode 	= 4
ENT.LightSpotRadius	= 200
ENT.LightDistance	= 300
ENT.LightBrightness	= 1
ENT.LightDieTime	= 0.4
ENT.LightDecay		= 1768
ENT.LightFlareColor	= Color( 120, 130, 255, 64 ) -- Color( 80, 155, 255 )
ENT.LightFlareAlpha	= 16
ENT.LightFlareSize 	= 0.8
ENT.SoundEmit		= true
ENT.SoundFile 		= "scifi.spectra.flyby.heavy"
ENT.Charge 			= 0

function ENT:SubInit()

	if ( SERVER ) then
		if ( cmd_sprites:GetBool() ) then
			util.SpriteTrail( 
				self, 								-- parent
				1, 									-- attachment ID
				self.LightFlareColor, 				-- Color
				1, 									-- force additive rendering
				48, 									-- start width
				0, 									-- end width
				0.2,								-- lifetime
				32,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
	end

end

function ENT:SubThink()
	
end

function ENT:PhysicsCollide( data, phy )

	self:XPlode( data )
	
end

function ENT:XPlode( tCollisionData )

	if ( self:GetXPloding() ) then return end

	self:SetXPloding( true )

	local amp = GetConVar( "sfw_damageamp" ):GetFloat()
	
	if ( SERVER ) then
		local pos = self:GetPos()

		local entTarget = tCollisionData.HitEntity
		
		if ( IsValid( entTarget ) ) then
			if !( entTarget:IsPlayer() || entTarget:IsNPC() ) && ( !entTarget:IsWorld() ) then
				entTarget = entTarget:GetParent()
				
				if ( !IsValid( entTarget ) ) then
					entTarget = NULL
				end
			end

			if ( IsValid( entTarget ) ) then
				pos = tCollisionData.HitPos
				self:DealDirectDamage( bit.bor( DMG_BULLET, DMG_BUCKSHOT, DMG_BLAST ), 24 * amp, entTarget, self:GetValidOwner(), tCollisionData.HitNormal, true )
			end
		else
			self:DealAoeDamage( bit.bor( DMG_BULLET, DMG_BUCKSHOT, DMG_BLAST ), 24 * amp, pos, 128 )
		end
		
		self:DealAoeDamage( DMG_SF_BLIGHT, 12 * amp, pos, 256 )

		local childs = 1
		local childsmax = math.max( 8 * ( self.Charge / 100 ), 2 )
		
		local tIndex = {}
		for k, v in pairs( ents.FindInSphere( pos, 512 ) ) do
			if ( v:IsNPC() || v:IsPlayer() ) && ( v != self.Owner ) then
				tIndex[ #tIndex + 1 ] = v
			else
				continue
			end
		end
		
		table.sort( tIndex, function( entFirst, entSecond )
			if !( IsValid( entFirst ) && IsValid( entSecond ) ) then
				return true
			end

			local vOrigin = self:GetPos()
			
			local iDistFirst, iDistSecond = vOrigin:Distance( entFirst:GetPos() ), vOrigin:Distance( entSecond:GetPos() )
			
			return iDistFirst < iDistSecond
		end )
		
		local bSingleTargetFocus = false
		
		if ( #tIndex > 0 && pos:Distance( tIndex[ 1 ]:GetPos() ) < 96 ) then
			bSingleTargetFocus = true
		end

		local iLastValidTargetID = 0
		for childs = 1, childsmax do 
			local child = ents.Create( "supra_nade_child" )
			if ( !IsValid( child ) ) then return end
			child:SetPos( pos )
			child:SetOwner( self:GetValidOwner() )
			child:Spawn()
			child:Activate()
			child:SetPhysicsAttacker( self.Owner, 10 )
			
			local cphys = child:GetPhysicsObject()
			if ( !IsValid( cphys ) ) then child:KillSilent() end
			cphys:ApplyForceCenter( VectorRand() * 512 )
			
			local cTarget
			
			if ( bSingleTargetFocus ) then
				cTarget = tIndex[ 1 ]
			else
				cTarget = tIndex[ childs ]
			
				if ( childs > #tIndex ) && ( !cTarget || !IsValid( cTarget ) ) then
					cTarget = tIndex[ iLastValidTargetID ]
				else
					iLastValidTargetID = childs
				end
			end

			if ( IsValid( cTarget ) ) then
				child:SetMTarEntity( cTarget )

				-- debugoverlay.Line( pos, cTarget:EyePos(), 4, color_white, true )
				-- debugoverlay.Text( cTarget:EyePos(), tostring( cTarget ) .. ", " .. childs, 4 )
			end
		end

		ParticleEffect( self.FxImpact, pos, Angle( 1, 1, 1 ) )
		
		self:EmitSound( self.SndImpact )

		util.ScreenShake( pos, 64, 2, 0.6, 600 )

		local fx1 = EffectData()
		fx1:SetOrigin( pos )
		fx1:SetAngles( Angle( 0, 0, 0 ) )
		fx1:SetRadius( 20 )
		fx1:SetScale( 0.3 )
		fx1:SetNormal( Vector( 0.1, 0.2, 0.6 ) )
		util.Effect( "scifi_aftershock", fx1 )
		
		self:KillSilent()
	end

end

function ENT:ImpactTrace( tr, dmgtype )
	
    return true
	
end