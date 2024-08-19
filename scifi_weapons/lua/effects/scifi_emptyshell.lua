local mat = "models/black"

EFFECT.Parent 		= NULL
EFFECT.Time 		= 5
EFFECT.Origin 		= Vector( 0, 0, 0 )
EFFECT.Angles 		= Angle( 0, 0, 0 )
EFFECT.Radius 		= 16
EFFECT.Velocity 	= Vector( 0, 0, 0 )
EFFECT.Model 		= "models/weapons/rifleshell.mdl"

function EFFECT:Init( data )

	self.Parent 	= data:GetEntity() || self.Parent
	self.Origin 	= data:GetOrigin() || self.Origin
	self.Angles 	= data:GetAngles() || self.Angles
	self.Radius 	= data:GetRadius() || 16
	self.Velocity 	= data:GetNormal() || self.Velocity

	self.Time 		= math.max( data:GetScale(), 0.01 ) || self.Time
	self.LifeTime 	= CurTime() + self.Time

	self:SetModel( self.Model )
	
end

function EFFECT:Think()

--	local grav = physenv.GetGravity() * 1
	local velo = self.Velocity * Vector( 1, 1, -60 ) * 1
	
	print( velo )
	
	self:SetPos( self:GetPos() + velo )
	
	if ( self.LifeTime > CurTime() ) then
		return true
	end
			
	return false
	
end

function EFFECT:Render()

	--self:SetPos( self.Origin )
	self:SetAngles( self.Angles )
	self:SetMaterial( mat )
	self:DrawModel()
	
	self:SetModelScale( 0.2 )

	if ( self.LifeTime - CurTime() < 1 ) then 
	--	render.SetBlend( self.LifeTime - CurTime() )
	end

end