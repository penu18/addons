local mat_glow = Material( "models/elemental/burned_glow" )

function EFFECT:Init( data )

	self.Time = 2.2
	self.LifeTime = CurTime() + self.Time
	
	local ent = data:GetEntity()
	
	if ( !IsValid( ent ) ) then return end
	if ( !ent:GetModel() ) then return end
	
	self.ParentEntity = ent
	self:SetModel( ent:GetModel() )	
	self:SetPos( ent:GetPos() )
	self:SetAngles( ent:GetAngles() )
	self:SetParent( ent )
	self.Flags = data:GetFlags()
	
	self.ParentEntity.RenderOverride = self.RenderParent
	self.ParentEntity.SpawnEffect = self

end

function EFFECT:Think( )

	if ( !IsValid( self.ParentEntity ) ) then return false end
	
	local PPos = self.ParentEntity:GetPos()
	self:SetPos( PPos + (EyePos() - PPos):GetNormal() )
	
	if ( self.LifeTime > CurTime() ) then
		return true
	end
	
	self.ParentEntity.RenderOverride = nil
	self.ParentEntity.SpawnEffect = nil
			
	return false
	
end

function EFFECT:Render()

	if ( self.Flags == 8 ) then
		self:RenderOverlay( self.ParentEntity )
	end

end

function EFFECT:RenderOverlay( entity )
	
	local Fraction = ( self.LifeTime - CurTime() ) / self.Time
	local ColFrac = ( Fraction - 0.5 ) * 2
	
	Fraction = math.Clamp( Fraction, 0, 1 )
	ColFrac =  math.Clamp( ColFrac, 0, 1 )

	local EyeNormal = entity:GetPos() - EyePos()
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local Pos = EyePos() + EyeNormal * Distance * 0.01
	local bClipping = self:StartClip( entity, 0.5 )
	
	local amount = math.Clamp( 1 - Fraction, 0, 0.5 )
	render.SetColorModulation( 1 - amount, 1.1 - amount, 1 - amount )
	
	cam.Start3D( Pos, EyeAngles() )
		render.MaterialOverride()
		entity:DrawModel()
	cam.End3D()
	
	render.PopCustomClipPlane()
	render.EnableClipping( bClipping )

end

function EFFECT:RenderParent()

	local bones = self:GetBoneCount()
	for bone = 1, bones-1 do
		local scale = self:GetManipulateBoneScale( bone )
		self:ManipulateBoneScale( bone, scale * 0.996 )
	end	
	
	local bClipping = self.SpawnEffect:StartClip( self, 0.4 )
	
	render.SetColorModulation( 0.72, 4, 0.2 )
	render.MaterialOverride( mat_glow )
	
	self:DrawModel()
	
	render.PopCustomClipPlane()
	render.EnableClipping( bClipping )
	
	self.SpawnEffect:RenderOverlay( self )
	
end

function EFFECT:StartClip( model, spd )

	local mn, mx = model:GetRenderBounds()
	local Up = (mx-mn):GetNormal()
	local Bottom =  model:EyePos() + mn
	local Top = model:EyePos() + mx
	
	local Fraction = ( self.LifeTime - CurTime() ) / self.Time
	Fraction = math.Clamp( Fraction / spd, 0, 1 )
	
	local Lerped = LerpVector( Fraction, Top, Bottom )

	local normal = Up 
	local distance = normal:Dot( Lerped )
	local bEnabled = render.EnableClipping( true )
	render.PushCustomClipPlane( normal, distance )

	return bEnabled
	
end
