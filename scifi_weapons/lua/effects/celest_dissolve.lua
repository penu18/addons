local mat_glow = Material( "models/elemental/celest_dissolve" )

local cmd_sunbeams = GetConVar( "sfw_fx_individualsunbeams" )

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
	local bClipping = self:StartClip( entity, 1 )

	local amount = math.Clamp( -0.2 + Fraction, 0, 1 )
	render.SetColorModulation( amount, amount, amount )
	
	cam.Start3D( Pos, EyeAngles() )
		render.MaterialOverride()
		entity:DrawModel()
	cam.End3D()

	render.PopCustomClipPlane()
	render.EnableClipping( bClipping )

end

function EFFECT:RenderParent()

	local bClipping = self.SpawnEffect:StartClip( self, 0.7 )
	
	render.SetColorModulation( 6, 8, 12 )
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
	
	local bSunBeams = cmd_sunbeams:GetBool()
	if ( !bSunBeams ) then return bEnabled end 
	
	local screen = Lerped
	local vNormal = screen - EyePos()
	
	local dot = ( vNormal:Dot( EyeVector() ) - 0.8 ) * 5
	if ( dot <= 0 ) then return bEnabled end

	screen = screen + ( vNormal * 16384 )
	screen = screen:ToScreen()
	
	local glowSize = math.max( mn:Length() * 0.0005, 0.01 )
	
	local w, h = ScrW(), ScrH()

	local glowX, glowY = screen.x, screen.y
	DrawSunbeams( 0.95, 0.1, glowSize, glowX / w, glowY / h )

	return bEnabled
	
end