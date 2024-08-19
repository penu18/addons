local mat_dark = Material( "models/elemental/burned" )
local mat_glow = Material( "models/elemental/burned_glow" )

local cmd_sunbeams = GetConVar( "sfw_fx_individualsunbeams" )

EFFECT.Origin = Vector( 0, 0, 0 )
EFFECT.Edge = Vector( 0, 0, 0 )
EFFECT.Direction = false
EFFECT.DirectionSet = false

function EFFECT:Init( data )

	self.Time = 1.46
	self.LifeTime = CurTime() + self.Time
	
	local ent = data:GetEntity()
	
	if ( !IsValid( ent ) ) then return end
	if ( !ent:GetModel() ) then return end
	
	self.ParentEntity = ent
	
	self:SetModel( ent:GetModel() )	
	self:SetPos( ent:GetPos() )
	self:SetAngles( ent:GetAngles() )
	self:SetParent( ent )
	self.Normal = data:GetNormal()
	self.Flags = data:GetFlags()

	self.ParentEntity.RenderOverride = self.RenderParent
	self.ParentEntity.SpawnEffect = self
	
	self.Origin = data:GetOrigin() || self:GetPos()

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
	local bClipping = self:StartClip( entity, 1 )
	
	cam.Start3D( Pos, EyeAngles() )
		render.MaterialOverride( mat_dark )
		entity:DrawModel()
		render.MaterialOverride( 0 )
	cam.End3D()

	render.PopCustomClipPlane()
	render.EnableClipping( bClipping )
	
	local bSunBeams = cmd_sunbeams:GetBool()
	if ( !bSunBeams ) then return end 
	
	local screen = Pos
	local vNormal = screen - EyePos()
	
	local dot = ( vNormal:Dot( EyeVector() ) - 0.8 ) * 5
	if ( dot <= 0 ) then return end

	screen = screen + ( vNormal * 16384 )
	screen = screen:ToScreen()
	
	local w, h = ScrW(), ScrH()

	local glowX, glowY = screen.x, screen.y
	DrawSunbeams( 0.7, 0.1 * ( 1 - Fraction ), 0.1 * Fraction, glowX / w, glowY / h )


end


function EFFECT:RenderParent()

	local bClipping = self.SpawnEffect:StartClip( self, 0.86 )
	
	render.SetColorModulation( 12, 2, 1.6 )
	render.MaterialOverride( mat_glow )
	
	self:DrawModel()
	
	render.SetColorModulation( 0.6, 0.56, 0.52 )
	
	render.PopCustomClipPlane()
	render.EnableClipping( bClipping )
	
	self.SpawnEffect:RenderOverlay( self )

end

function EFFECT:StartClip( model, spd )

	local mn, mx = model:GetRenderBounds()
	local me = model:EyePos()
	local mc = model:OBBCenter()

	local Top, Bottom, Up
	
	if ( !self.DirectionSet ) then
		self.Direction = ( self.Origin:Dot( mc ) > 0 )
		self.DirectionSet = true
	end
	
	if ( self.Direction ) then
		Top = me + mn
		Bottom = me + mx
		Up = (mx-mn):GetNormal()
	else
		Top = me + mx
		Bottom = me + mn
		Up = (mn-mx):GetNormal()
	end

	local Fraction = ( self.LifeTime - CurTime() ) / self.Time
	Fraction = math.Clamp( Fraction / spd, 0, 1 )
	
	local Lerped = LerpVector( Fraction, Bottom, Top )
	
	local normal = ( Bottom - Top ):GetNormal()
	local distance = normal:Dot( Lerped )
	local bEnabled = render.EnableClipping( true )
	render.PushCustomClipPlane( normal, distance ) 
	
	local mLight = DynamicLight( -1 )
	if ( mLight ) then
		mLight.pos = Lerped
		mLight.r = 255
		mLight.g = 90
		mLight.b = 10
		mLight.brightness = ( 1 - Fraction ) + 2 * Fraction
		mLight.Size = 200 + 320 * Fraction
		mLight.Decay = 1024
		mLight.Style = 1
		mLight.DieTime = CurTime() + 1
	end

	return bEnabled
	
end
