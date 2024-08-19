AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

EFFECT.Speed	= 13000
EFFECT.Length	= 64
EFFECT.Trace	= Material( "effects/gunshiptracer" )
EFFECT.Halo		= Material( "effects/combine_halo" )
EFFECT.FlyBy	= "weapons/neutrino/flyby.wav"

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

function EFFECT:Render()

	local endDistance = self.Speed * self.StartTime
	local startDistance = endDistance - self.Length
	
	startDistance = math.max( 0, startDistance )
	endDistance = math.max( 0, endDistance )
	
	local startPos = self.StartPos + self.Normal * startDistance
	local endPos = self.StartPos + self.Normal * endDistance * 2
	
	render.SetMaterial( self.Halo )
	render.DrawSprite( endPos, 18, 18, Color( 85, 255, 0, 255 ) )

	render.SetMaterial( self.Trace )
	render.DrawBeam( startPos, endPos, 64, 0, 1, Color( 85, 255, 0, 255 ) )
end