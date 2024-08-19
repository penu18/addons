local mat_glow = Material( "models/effects/scifi_aftershock" )
local mat = "models/effects/scifi_aftershock"

EFFECT.Parent 		= NULL
EFFECT.Time 		= 0.4
EFFECT.Origin 		= Vector( 0, 0, 0 )
EFFECT.Angles 		= Angle( 0, 0, 0 )
EFFECT.Radius 		= 16
EFFECT.Color 		= Vector( 0, 0, 0 )
EFFECT.SphereModel 	= "models/effects/shocksphere.mdl"

function EFFECT:Init( data )

	self.Parent 	= data:GetEntity() || self.Parent
	self.Origin 	= data:GetOrigin() || self.Origin
	self.Angles 	= data:GetAngles() || self.Angles
	self.Radius 	= data:GetRadius() || 16
	self.Color 		= data:GetNormal() || self.Color

	self.Time 		= math.max( data:GetScale(), 0.01 ) || self.Time
	self.LifeTime 	= CurTime() + self.Time

	self:SetModel( self.SphereModel )
	
end

function EFFECT:Think( )
	
	if ( self.LifeTime > CurTime() ) then
		return true
	end
			
	return false
	
end

function EFFECT:Render()

	local frac = math.Truncate( ( self.LifeTime - CurTime() ) / self.Time, 3 )
	local mul = 1 - frac

	local radius = 1 * self.Radius

	mat_glow:SetFloat( "$SilhouetteThickness", 1 - 1 * frac )
	mat_glow:SetFloat( "$RefractAmount", 0.01 * frac )
	mat_glow:SetFloat( "$BlurAmount", 0.01 * frac )
	mat_glow:SetVector( "$SilhouetteColor", self.Color * 10 * frac )

	self:SetPos( self.Origin )
	self:SetAngles( self.Angles )
	self:SetMaterial( mat )
	self:DrawModel()
	self:SetModelScale( radius * mul )
	self:SetParent( self.Parent )

	render.SetBlend( frac )
	render.SetMaterial( mat_glow )

end