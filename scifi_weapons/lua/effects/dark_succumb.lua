local mat_glow = Material( "models/elemental/darkened.vmt" )

EFFECT.DecalTime = 0

EFFECT.Origin = Vector( 0, 0, 0 )
EFFECT.Edge = Vector( 0, 0, 0 )
EFFECT.Direction = false
EFFECT.DirectionSet = false


function EFFECT:Init( data )

	self.Time = 3.1
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

	ParticleEffectAttach( "umbra_succumb", PATTACH_ABSORIGIN_FOLLOW, ent, 0 ) 
	
	self.Origin = data:GetOrigin() || self:GetPos()

end

local m_decal = Material( util.DecalMaterial( "beersplash" ) )

function EFFECT:Think( )

	if ( !IsValid( self.ParentEntity ) ) then return false end
	
	local PPos = self.ParentEntity:GetPos()
	local PNormal = ( EyePos() - PPos ):GetNormal()
	self:SetPos( PPos + PNormal )
	
	if ( self.LifeTime > CurTime() ) then
		if ( self.DecalTime < CurTime() ) then
			-- util.Decal( "beersplash", PPos + Vector( 0, 0, 24 ), PPos - Vector( 0, 0, 24 ), self.Parent )
			util.DecalEx( m_decal, self.ParentEntity, PPos, self.Edge * -1, color_white, 256, 256 )

			-- debugoverlay.Line( PPos, PPos - self.Edge * 64, 0.2, color_white, true )
			-- debugoverlay.Cross( PPos, 16, 0.2, color_white, true )
			
			self.DecalTime = CurTime() + 0.2
		end
	
		return true
	end
	
	self.ParentEntity.RenderOverride = nil
	self.ParentEntity.SpawnEffect = nil

	local bones = self.ParentEntity:GetBoneCount()
	for bone = 1, bones-1 do
		local scale = self.ParentEntity:GetManipulateBoneScale( bone )
		self.ParentEntity:ManipulateBoneScale( bone, Vector( 1, 1, 1 ) )
	end	
			
	return false
	
end

function EFFECT:Render()

	if ( self.Flags == 8 ) then
		self:RenderOverlay( self.ParentEntity )
	end

end

function EFFECT:RenderOverlay( entity )
	
	local fFraction = ( self.LifeTime - CurTime() ) / self.Time
	fFraction = math.Clamp( fFraction, 0, 1 )

	local EyeNormal = entity:GetPos() - EyePos()
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local Pos = EyePos() + EyeNormal * Distance * 0.01
	local bClipping = self:StartClip( entity, 0.6 )
	
	cam.Start3D( Pos, EyeAngles() )
		render.MaterialOverride( mat_glow )
		entity:DrawModel()
		render.MaterialOverride()
	cam.End3D()
	
	render.PopCustomClipPlane()
	render.EnableClipping( bClipping )
	
--	local evilmath = 2 * 2 ^ ( fFractionReversed - fFraction )
--	evilmath = evilmath * 0.125

end

function EFFECT:RenderParent()

	local fx = self.SpawnEffect
	local fFraction = ( fx.LifeTime - CurTime() ) / ( fx.Time * 0.6 )
	fFraction = math.Clamp( fFraction, 0, 1 )

	local fFractionReversed = ( 1 - fFraction ) * 2
	
--	render.SetBlend( fFraction )

	local fBoneScalar = ( 1 - ( 1 - fFraction ) * 0.04 )

	local bones = self:GetBoneCount()
	for bone = 1, bones-1 do
		local scale = self:GetManipulateBoneScale( bone )
		self:ManipulateBoneScale( bone, scale * fBoneScalar )
	end	
	
	local bClipping = self.SpawnEffect:StartClip( self, 0.4 )
	
	render.SetColorModulation( 1 - fFractionReversed, 1 - fFractionReversed, 1 - fFractionReversed )
	
	mat_glow:SetFloat( "$FleshBorderWidth", math.max( 4 * fFraction - 4 * fFractionReversed, 0 ) )
	
	render.MaterialOverride()
	self:DrawModel()
	
	render.SetColorModulation( 1, 1, 1 )
	
--	render.SetBlend( 1 )
	
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
	
	local normal = ( Bottom - Top ):GetNormal() -- Up 
	local distance = normal:Dot( Lerped )
	local bEnabled = render.EnableClipping( true )
	render.PushCustomClipPlane( normal, distance )
	
	self.Edge = normal

	local mLight = DynamicLight( self.ParentEntity:EntIndex() * -1 )
	if ( mLight ) then
		local fLightFrac = ( self.LifeTime - CurTime() ) / ( self.Time * 0.5 )
		fLightFrac = math.Clamp( 1 - fLightFrac, 0, 1 )
		local mScale = math.sin( fLightFrac * 2 )

		mLight.pos = Lerped
		mLight.r = 230
		mLight.g = 60
		mLight.b = 40
		mLight.brightness = 1 * mScale
		mLight.Size = 80 + 200 * mScale
		mLight.Decay = 512
		mLight.Style = 1
		mLight.DieTime = CurTime() + 1
	end

	return bEnabled
	
end