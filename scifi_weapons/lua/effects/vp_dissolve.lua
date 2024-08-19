local mGlobal = Material( "models/elemental/vapored" )
local cmd_sunbeams = GetConVar( "sfw_fx_individualsunbeams" )

-- local mGlobalRaw = file.Read( "materials/models/elemental/vapored.vmt", "GAME" )
-- mGlobalRaw:lower()

-- local tMaterialCache = mGlobal:GetKeyValues()
-- local tMaterialReference = {}

-- for key, value in pairs( tMaterialCache ) do
	-- if !( string.find( mGlobalRaw, key:lower(), 1, false ) ) then
		-- print("filtering out", key )
		-- continue
	-- end
	
	-- tMaterialReference[ key ] = value
-- end

function EFFECT:Init( data )

	self.Time = 1.05
	self.LifeTime = CurTime() + self.Time

	self.mOverlay = mGlobal --CreateMaterial( "vapor_dissolve_overlay", "VertexLitGeneric", tMaterialReference )

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
	
	if ( GetConVar( "sfw_fx_particles" ):GetBool() ) then
		ParticleEffectAttach( "vp_dissolve", PATTACH_ABSORIGIN_FOLLOW, ent, -1 )
	else
		ParticleEffectAttach( "vp_dissolve_cheap", PATTACH_ABSORIGIN_FOLLOW, ent, -1 ) 
	end
	
	self.ParentEntity:SetMaterial( "dev/hide" )

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

function EFFECT:RenderParent()
	
	self.SpawnEffect:RenderOverlay( self )

end

function EFFECT:RenderOverlay( entity )

	render.SetColorModulation( 1, 2, 3 )
	render.MaterialOverride( self.mOverlay )
	
	local fFraction = ( self.LifeTime - 0.1 - CurTime() ) / self.Time
	local fColFrac = ( fFraction - 0.5 ) * 2
	
	fFraction = math.Clamp( fFraction, 0, 1 )
	fColFrac =  math.Clamp( fColFrac, 0, 1 )
	
	local fFractionReversed = ( 1 - fFraction )

	local EyeNormal = entity:GetPos() - EyePos()
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local Pos = EyePos() + EyeNormal * Distance * 0.01

--	local iFrames = math.Clamp( 24 - ( 24 * fColFrac ), 1, 24 )
--	iFrames = math.Round( iFrames, 0 )
	
--	self.mOverlay:SetInt( "$frame", iFrames )
	
	local evilmath = 2 * 2 ^ ( fFractionReversed * 2 - fFraction )
	evilmath = evilmath * 0.125

	self.mOverlay:SetFloat( "$FleshBorderWidth", 6 * evilmath )
	self.mOverlay:SetFloat( "$FleshBorderSoftness", 0.5 * fFraction )
	self.mOverlay:SetFloat( "$FleshGlossBrightness", 12 * fFractionReversed )
	self.mOverlay:SetVector( "$selfillumtint", Vector( 2.2, 2.3, 4 ) * fFraction )

	local mn, mx = entity:GetRenderBounds()
	local Up = (mx-mn):GetNormal()
	local Bottom =  entity:EyePos() + mn
	local Top = entity:EyePos() + mx

	local Lerped = LerpVector( fFraction, Top, Bottom )
	
	local normal = Up 
	local distance = normal:Dot( Lerped )
	
	local mLight = DynamicLight( self.ParentEntity:EntIndex() * -1 )
	if ( mLight ) then 
		mLight.pos = Lerped
		mLight.r = 0
		mLight.g = 20
		mLight.b = 255
		mLight.brightness = 3 * fFraction
		mLight.Size = 180 + 400 * fFraction
		mLight.Decay = 1024
		mLight.Style = 1
		mLight.DieTime = CurTime() + 1
	end
	
	entity:DrawModel()
	
	render.SetColorModulation( 1, 1, 1 )
	render.MaterialOverride()
	
	local bSunBeams = cmd_sunbeams:GetBool()
	if ( !bSunBeams ) then return end 
	
	local screen = Lerped
	local vNormal = screen - EyePos()
	
	local dot = ( vNormal:Dot( EyeVector() ) - 0.8 ) * 5
	if ( dot <= 0 ) then return end

	screen = screen + ( vNormal * 16384 )
	screen = screen:ToScreen()
	
	local glowSize = math.max( 0.05 * fFraction, 0.001 ) -- math.max( mn:Length() * 0.0005, 0.01 )
	
	local w, h = ScrW(), ScrH()

	local glowX, glowY = screen.x, screen.y
	DrawSunbeams( 0.85, 0.4 * ( 1 - fFraction ), glowSize, glowX / w, glowY / h )
	
end