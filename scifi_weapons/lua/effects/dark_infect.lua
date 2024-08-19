local mat_glow = Material( "models/elemental/dark_highlight" )

function EFFECT:Init( data )

	if ( GetConVar( "mat_fillrate" ):GetBool() ) then return end

	self.Time = 1.5
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

function EFFECT:RenderOverlay( entity )

	local Fraction = ( self.LifeTime - CurTime() ) / self.Time

	Fraction = 1 - math.Clamp( Fraction, 0, 1 )

	local EyeNormal = entity:GetPos() - EyePos()
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()

	local Pos = EyePos() + EyeNormal * Distance * 0

	cam.Start3D( Pos, EyeAngles() )
		render.UpdateRefractTexture()
		
		mat_glow:SetFloat( "$SilhouetteThickness", 1 * Fraction + 4 * Fraction * Fraction  )
		mat_glow:SetFloat( "$refractamount", 0.01 * Fraction )
		mat_glow:SetFloat( "$bluramount", 0.01 * Fraction )

		mat_glow:SetVector( "$colortint", Vector( 1, 1, 1 ) - Vector( 2, 2.5, 3 ) * Fraction )
		mat_glow:SetVector( "$SilhouetteColor", Vector( 1, 1, 1 ) - Vector( 2, 5, 8 ) * Fraction )
		
		mat_glow:SetFloat( "$GroundMin", -12 * Fraction )
		mat_glow:SetFloat( "$GroundMax", 2 * Fraction )

		render.MaterialOverride( mat_glow )
		entity:DrawModel()
		render.MaterialOverride()
		
	cam.End3D()

end

function EFFECT:Render()

end

function EFFECT:RenderParent()
	
	self:DrawModel()
	
	self.SpawnEffect:RenderOverlay( self )

end