EFFECT.FxMaterial = Material( "models/elemental/blightened" )

function EFFECT:Init( data )

	if ( GetConVar( "mat_fillrate" ):GetBool() ) then return end

	self.Time = data:GetScale()
	self.Origin = data:GetOrigin()
	self.LifeTime = CurTime() + self.Time
	
	local ent = data:GetEntity()
	
	if ( !IsValid( ent ) ) then return end
	if ( !ent:GetModel() ) then return end
			
	local pEntity = LocalPlayer()

	if ( ent == pEntity ) && ( !pEntity:ShouldDrawLocalPlayer() ) then
		self.ViewModel = true
			
		ent = pEntity:GetHands()
	end
	
	self.ParentEntity = ent
	
	if ( self.ParentEntity.RenderOverride ) then
		return
	end
	
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
	self:SetPos( PPos + ( EyePos() - PPos ):GetNormal() )
	
	local DieTime = self.LifeTime - CurTime()
	
	self.DeltaTime = DieTime
	
	if ( !self.ParticleCast ) then
		if ( self.Time >= 2 ) then
			ParticleEffectAttach( "fstar_freeze_catch", PATTACH_ABSORIGIN_FOLLOW, self.ParentEntity, 1 )
		end

		if ( self.ViewModel ) then
			local pOwner = self.ParentEntity:GetOwner()
			
			pOwner:ScreenFade( SCREENFADE.IN, Color( 210, 240, 255, 80 ), self.Time * 0.5, self.Time * 0.5 )
			pOwner:SetDSP( 32, false )
			
			self.FxMaterial:SetVector( "$emissiveBlendScrollVector", Vector( -1, -1 ) )
		end
		
		self.ParticleCast = true
	end
	
	if ( self.LifeTime > CurTime() ) then
		return true
	end
	
	self.ParentEntity:StopParticlesNamed( "fstar_freeze_catch" )
	
	self.ParentEntity.RenderOverride = nil
	self.ParentEntity.SpawnEffect = nil

	return false
	
end

function EFFECT:Render()

end

function EFFECT:RenderOverlay( entity )
		
	local Fraction = 1 - ( self.LifeTime - CurTime() ) / self.Time
	
	Fraction = math.Clamp( Fraction, 0, 1 )
	
	local origin = entity:GetPos()

	local EyeOrigin = EyePos()
	local EyeNormal = origin - EyeOrigin
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local offset 
	
	if ( self.ViewModel ) then
		local iFov = 54
		local wEntity = LocalPlayer():GetActiveWeapon()
		if ( IsValid( wEntity ) && wEntity.ViewModelFOV ) then
			iFov = wEntity.ViewModelFOV
		end
		
		local add = -54 + iFov
		add = add * 0.3
		
		offset = EyeAngles():Forward() * ( 12 - add )
	else
		offset = EyeNormal * Distance * 0.01
	end
	
	local Pos = EyeOrigin + offset

	local clr = Vector( 120, 130, 255 ) / 255

	local fStrength = 2.2 - ( Fraction * 2 ^ ( Fraction * 1 ) )
	
	local owner
	if ( self.ViewModel ) then
		owner = entity:GetOwner()
	else
		owner = entity
	end

	self.FxMaterial:SetFloat( "$emissiveBlendStrength", fStrength )
	self.FxMaterial:SetFloat( "$time", Fraction )
	self.FxMaterial:SetVector( "$energycolor", clr * fStrength )
	
	cam.Start3D( Pos, EyeAngles() )
		render.MaterialOverride( self.FxMaterial )
		entity:DrawModel()
		render.MaterialOverride()
	cam.End3D()
	
	if ( self.ViewModel && self.ParentEntity:GetOwner() == LocalPlayer() ) then
		DrawMaterialOverlay( "models/elemental/blightened", 0 )
	end

end

function EFFECT:RenderParent()
	
	self:DrawModel()
	
	self.SpawnEffect:RenderOverlay( self )

end