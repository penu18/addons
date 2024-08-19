local mat_glow = Material( "models/elemental/neutrinoed" )

function EFFECT:Init( data )

	self.Time = 1.55
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
	
	if ( GetConVar( "sfw_fx_particles" ):GetBool() ) then
		ParticleEffectAttach( "nio_dissolve", PATTACH_ABSORIGIN_FOLLOW, ent, -1 )
	else
		ParticleEffectAttach( "nio_dissolve_cheap", PATTACH_ABSORIGIN_FOLLOW, ent, -1 ) 
	end

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

local pi = math.pi

function EFFECT:RenderOverlay( entity )
		
	local fFraction = ( self.LifeTime - 0.1 - CurTime() ) / self.Time
	local fColFrac = ( fFraction - 0.5 ) * 2
	
	fFraction = math.Clamp( fFraction, 0, 1 )
	fColFrac =  math.Clamp( fColFrac, 0, 1 )
	
	local fFractionReversed = ( 1 - fFraction )

	local EyeNormal = entity:GetPos() - EyePos()
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local Pos = EyePos() + EyeNormal * Distance * 0.01
	local bClipping = self:StartClip( entity, 1 )

	local iFrames = math.Clamp( 24 - ( 24 * fColFrac ), 1, 24 )
	iFrames = math.Round( iFrames, 0 )
	
	mat_glow:SetInt( "$frame", iFrames )
	
	cam.Start3D( Pos, EyeAngles() )
		local amount = math.Clamp( -0.2 + fFraction, 0, 1 )
		render.SetColorModulation( amount, amount, amount )
		render.SetBlend( fColFrac )
	
		render.MaterialOverride()
		entity:DrawModel()

		render.SetColorModulation( 1, 1, 1 )
		render.SetBlend( 1 )
	cam.End3D()

	render.PopCustomClipPlane()
	render.EnableClipping( bClipping )
	
	local evilmath = 2 * 2 ^ ( fFractionReversed * 2 - fFraction )
	evilmath = evilmath * 0.125

	mat_glow:SetFloat( "$FleshBorderWidth", 6 * evilmath )
	mat_glow:SetFloat( "$FleshBorderSoftness", 0.5 * fFraction )
	mat_glow:SetFloat( "$FleshGlossBrightness", 12 * fFractionReversed )
	mat_glow:SetVector( "$selfillumtint", Vector( 0.2, 12, 0.4 ) * fFraction )

end

function EFFECT:RenderParent()
	
	render.SetColorModulation( 1, 3, 1 )
	render.MaterialOverride( mat_glow )
	
	self:DrawModel()
	
	self.SpawnEffect:RenderOverlay( self )

end

function EFFECT:StartClip( model, spd )

	local mn, mx = model:GetRenderBounds()
	local Up = (mx-mn):GetNormal()
	local Bottom =  model:EyePos() + mn
	local Top = model:EyePos() + mx
	
	local fFraction = ( self.LifeTime - CurTime() ) / self.Time
	fFraction = math.Clamp( fFraction / spd, 0, 1 )
	
	local Lerped = LerpVector( fFraction, Top, Bottom )
	
	local normal = Up 
	local distance = normal:Dot( Lerped )
	local bEnabled = render.EnableClipping( true )
	render.PushCustomClipPlane( normal, distance )
	
	local mLight = DynamicLight( self.ParentEntity:EntIndex() * -1 )
	if ( mLight ) then
		mLight.pos = Lerped
		mLight.r = 80
		mLight.g = 255
		mLight.b = 40
		mLight.brightness = 3 * fFraction
		mLight.Size = 180 + 400 * fFraction
		mLight.Decay = 1024
		mLight.Style = 1
		mLight.DieTime = CurTime() + 1
	end

	return bEnabled
	
end