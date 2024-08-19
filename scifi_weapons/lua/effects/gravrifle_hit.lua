
EFFECT.Mat = Material( "effects/gravrifle_impact" )
EFFECT.Refract = Material( "particle/warp_celest" )

function EFFECT:Init( data )

	local size = 4
	self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )

	local Pos = data:GetOrigin() + data:GetNormal() * 2

	self:SetPos( Pos )

	self:SetAngles( data:GetNormal():Angle() + Angle( 0.01, 0.01, 0.01 ) )

	self.Pos = data:GetOrigin()
	self.Normal = data:GetNormal()

	self.Speed = 0.25
	self.Size = size
	self.Alpha = 255

	self.Life = 0.5

end

function EFFECT:Think()

	self.Alpha = self.Alpha - FrameTime() * 255 * 5 * self.Speed
	self.Size = self.Size + FrameTime() * 128 * self.Speed

	if ( self.Alpha < 0 ) then return false end
	return true

end

function EFFECT:Render()

	if ( self.Alpha < 1 ) then return end
	
	render.SetMaterial( self.Refract )
	render.DrawQuadEasy( self:GetPos(), self:GetAngles():Forward(), self.Size * 3, self.Size * 3, Color( 255, 255, 255, self.Alpha * 0.75 ) )

	render.SetMaterial( self.Mat )
	render.DrawQuadEasy( self:GetPos(), self:GetAngles():Forward(), self.Size, self.Size, Color( 255, 255, 255, self.Alpha ) )
	
	local scale = self.Alpha / 255
	
	self.Mat:SetFloat( "$time", scale )
	self.Mat:SetFloat( "$emissiveBlendStrength", 16 * scale * scale )

end
