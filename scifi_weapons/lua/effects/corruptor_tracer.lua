AddCSLuaFile()
if ( CLIENT ) then
TRACER_FLAG_USEATTACHMENT	= 0x0002
end
EFFECT.Speed 	= 12000
EFFECT.Length	= 64
EFFECT.Normal 	= Vector( 0, 0, 0 )
EFFECT.ParticleCast = false
EFFECT.Time = nil

function EFFECT:GetTracerOrigin( data )
	if ( CLIENT ) then
		local start = data:GetStart()

		if( bit.band( data:GetFlags(), TRACER_FLAG_USEATTACHMENT ) == TRACER_FLAG_USEATTACHMENT ) then
			local entity = data:GetEntity()
			
			if( !IsValid( entity ) ) then 
				return start 
			end
			
			if( !game.SinglePlayer() && entity:IsEFlagSet( EFL_DORMANT ) ) then 
				return start 
			end
			
			local bFirstPersonFix = false
			
			if( entity:IsWeapon() && entity:IsCarriedByLocalPlayer() ) then
				local pl = entity:GetOwner()
				if( IsValid( pl ) ) then
					local vm = pl:GetViewModel()
					if( IsValid( vm ) and not LocalPlayer():ShouldDrawLocalPlayer() ) then
						if ( game.SinglePlayer() ) && ( entity:GetSciFiState() == SCIFI_STATE_ADS && entity:Clip1() > 2 ) then
							bFirstPersonFix = true
						end
						
						entity = vm
					else 					
						if( entity.WorldModel ) then
							entity:SetModel( entity.WorldModel )
						end
					end
				end
			end

			local attachment = entity:GetAttachment( data:GetAttachment() )
			if( attachment ) then
				start = attachment.Pos
				
				if ( bFirstPersonFix ) then
					-- debugoverlay.Line( start, start + attachment.Ang:Forward() * 32, 4, Color( 255, 0, 0 ), true )
					-- debugoverlay.Line( start, start + attachment.Ang:Up() * 32, 4, Color( 0, 255, 0 ), true )
					-- debugoverlay.Line( start, start + attachment.Ang:Right() * 32, 4, Color( 0, 0, 255 ), true )
					start = start + attachment.Ang:Up() * -24 + attachment.Ang:Right() * 4
					-- debugoverlay.Cross( start, 16, 4, color_white, true )
				end
			end

		end
		
		return start
	end
end

function EFFECT:Init( data )

	self.StartPos = self:GetTracerOrigin( data )
	self.EndPos = data:GetOrigin()
	self.Parent = data:GetEntity()
	
--	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )

	local diff = ( self.EndPos - self.StartPos )
	
	self.Normal = diff:GetNormal()
	self.StartTime = 0
	
	if ( !self.LifeTime ) then
		self.LifeTime = ( diff:Length() + self.Length ) / self.Speed
	else
		self.LifeTime = CurTime() + self.LifeTime
	end
	
end

function EFFECT:Render()

	local endDistance = self.Speed * self.StartTime
	local startDistance = endDistance - self.Length
	
	startDistance = math.max( 0, startDistance )
	endDistance = math.max( 0, endDistance )

	local startPos = self.StartPos + self.Normal * startDistance
	local endPos = self.StartPos + self.Normal * endDistance
	
end

function EFFECT:Think()
	
	if ( !self.ParticleCast ) then
		util.ParticleTracerEx( 
			"corruptor_tracer", 	--particle system
			self.StartPos, 	--startpos
			self.EndPos, 	--endpos
			true, 			--do whiz effect
			-1, 			--entity index
			-1  			--attachment
		)
		
		self.ParticleCast = true
	end
	
	if ( !self.Time ) then	
		self.Time = self.LifeTime + CurTime()
	end
	
	local Fraction = math.max( 0, ( self.Time - CurTime() ) / self.LifeTime )
	
	local difforigin = self.EndPos - self.StartPos
	local lightorigin = self.StartPos + ( difforigin * ( 1 - Fraction ) ) 

	local dlight = DynamicLight( -1 )
	if ( dlight ) then
		dlight.pos = lightorigin
		dlight.r = 230
		dlight.g = 60
		dlight.b = 40
		dlight.brightness = 1 * Fraction
		dlight.Size = 120 + 120 * Fraction
		dlight.Decay = 1024
		dlight.Style = 1
		dlight.DieTime = CurTime() + FrameTime() * 2
	end
	
	return false

end