AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

EFFECT.Speed	= 64000
EFFECT.Length	= 32
EFFECT.Trace	= Material( "particle/muzzleflash_burst_add_upsidedown" )

EFFECT.ParticleCast = false
EFFECT.Time = nil

EFFECT.Color = Color( 255, 20, 0, 255 )

--EFFECT.Speed = 32000

function EFFECT:Init( data )

	self.StartPos = self:GetTracerOrigin( data )
	self.EndPos = data:GetOrigin()
	self.Parent = data:GetEntity()
	
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )

	local diff = ( self.EndPos - self.StartPos )
	
	self.Normal = diff:GetNormal()
	self.StartTime = 0
	self.LifeTime = ( diff:Length() + self.Length ) / self.Speed

end

function EFFECT:Think()

	if ( !self.ParticleCast ) then
		util.ParticleTracerEx( 
			"emg_tracer", 	--particle system
			self.StartPos, 	--startpos
			self.EndPos, 	--endpos
			false, 			--do whiz effect
			-1, 			--entity index
			-1  			--attachment
		)
		
		self.ParticleCast = true
	end

	self.LifeTime = self.LifeTime - FrameTime() * 0.5
	self.StartTime = self.StartTime + FrameTime() * 0.5
	
	return ( self.LifeTime > 0 ) -- CurTime() ) 
	
end

function EFFECT:Render()

	local endDistance = self.Speed * self.StartTime
	local startDistance = endDistance - self.Length
	
	startDistance = math.max( 0, startDistance )
	endDistance = math.max( 0, endDistance )
	
	local startPos = self.StartPos + self.Normal * startDistance
	local endPos = self.StartPos + self.Normal * endDistance * 2

	render.SetMaterial( self.Trace )
	render.DrawBeam( startPos, endPos, 24, 0, 1, self.Color )

	local Fraction = math.Clamp( self.Length / endDistance, 0, 1 )

	local mLight = DynamicLight( -1 )
	if ( mLight ) then
		mLight.pos = startPos
		mLight.r = 255
		mLight.g = 20
		mLight.b = 0
		mLight.brightness = 0.4 + 1 * Fraction
		mLight.Size = 256 + 64 * Fraction
		mLight.Decay = 1024 + 1024 * Fraction
		mLight.Style = 1
		mLight.DieTime = CurTime() + 1
	end

end