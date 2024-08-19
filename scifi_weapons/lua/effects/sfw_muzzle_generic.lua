AddCSLuaFile()

SCIFI_INTEGRITY_FLAG_FX = 20210727213519

local cmd_fx_forceclient = GetConVar( "sfw_fx_forceclientmuzzle" )
local cmd_fx_muzzlelights = GetConVar( "sfw_fx_muzzlelights" )
local cmd_fx_cinematic = GetConVar( "sfw_fx_cinematicmuzzles" )

EFFECT.ParticleName = ""
EFFECT.Light = nil
EFFECT.LightInfo = nil
EFFECT.LightRule = 0
EFFECT.LifeTime = 0.04
EFFECT.DieTime = 0
EFFECT.World = false
EFFECT.Origin = Vector()
EFFECT.Rotation = Angle()

local mBloom = Material( "bloom/halo_static_2" )

EFFECT.CheckVis = nil
EFFECT.CheckVisInfo = {
	start = Vector( 0, 0, 0 ),
	endpos = Vector( 0, 0, 0 ),
	mask = MASK_VISIBLE_AND_NPCS
}

function EFFECT:GetMuzzleParent()

	if ( CLIENT ) then
		local pEntity = self.Owner || LocalPlayer()
		local vmEntity = self.Weapon
		
		if( !IsValid( vmEntity ) ) then return pEntity end
		if( !game.SinglePlayer() && vmEntity:IsEFlagSet( EFL_DORMANT ) ) then return end

		local vmOwner = vmEntity:GetOwner()

		if( IsValid( vmOwner ) ) then
			if( !pEntity:ShouldDrawLocalPlayer() && vmOwner == pEntity ) then
				vmEntity = vmOwner:GetViewModel()
			else
				vmEntity = vmOwner:GetActiveWeapon()
				self.World = true
			end
		end
			
		return vmEntity
	end

end

function EFFECT:GetParticleName()

	if ( !IsValid( self.Weapon ) ) then return end

	local name = self.Weapon.VfxMuzzleParticle
	
	if ( !name || !isstring( name ) ) then
		name = "ngen_muzzle" 
	end
	
	return name
	
end

function EFFECT:GetParticleAttach()

	if ( !IsValid( self.Weapon ) ) then print("defaulting...") return "muzzle" end

	if ( self.World && self.Weapon.VfxMuzzleAttachment2 ) then
		return self.Weapon.VfxMuzzleAttachment2
	end

	return self.Weapon.VfxMuzzleAttachment
	
end

function EFFECT:GetLightInfo( data )

	local wEntity = self.Weapon

	if ( !IsValid( wEntity ) ) then return end

	local lightinfo = {}
	lightinfo.rule = wEntity.VfxMuzzleRule
	lightinfo.color = wEntity.VfxMuzzleColor
	lightinfo.brightness = wEntity.VfxMuzzleBrightness
	lightinfo.farz = wEntity.VfxMuzzleFarZ
	lightinfo.fov = wEntity.VfxMuzzleFOV
	lightinfo.texture = wEntity.VfxMuzzleProjexture
	
	return lightinfo
	
end

function EFFECT:Init( data )
	
	if ( !IsValid( self ) ) || ( !IsValid( data:GetEntity() ) ) then return end

	self.Owner = LocalPlayer()
	self.Weapon = data:GetEntity()
	self.Parent = self:GetMuzzleParent()
	self.ParticleName = self:GetParticleName()

	if ( !IsValid( self.Parent ) ) then return false end
	if ( !isstring( self.ParticleName ) ) then return false end
	
	local iLightSetting = cmd_fx_muzzlelights:GetInt()
	self.LightRule = math.min( iLightSetting, self.Weapon.VfxMuzzleRule )
	
	if ( !isnumber( self.LightRule ) ) then
		self.LightRule = 0
	end

	if ( self.LightRule > 0 ) then
		self.LightInfo = self:GetLightInfo()
	end

	local vmAttach = self.Parent:LookupAttachment( self:GetParticleAttach() )
	
	if ( vmAttach == 0 ) then
		self.Attach = "1"
	else
		self.Attach = vmAttach
	end	

	local att = self.Parent:GetAttachment( self.Attach )
			
	if ( !att ) then return end

	local ang = att.Ang
	local pos = att.Pos
	
	self.Rotation = ang
	self.Origin = pos
	
	self.StartTime = 0
	
	if ( !game.SinglePlayer() && self.Weapon:GetOwner() == self.Owner ) then -- cheat
		self.LifeTime = self.LifeTime * 0.006
		
		if ( self.LightInfo ) then
			self.LightInfo.brightness = self.LightInfo.brightness * 0.15
		end
	end
	
	self.DieTime = CurTime() + self.LifeTime

	local bForceClient = cmd_fx_forceclient:GetBool()

	if ( bForceClient ) then
		local vfxMuzzleFlash = CreateParticleSystem( self.Parent, self.ParticleName, PATTACH_POINT_FOLLOW, self.Attach, nil ) 
		
		if ( self.Owner == LocalPlayer() ) && ( !self.Owner:ShouldDrawLocalPlayer() && self.Parent == LocalPlayer():GetViewModel() ) then
			vfxMuzzleFlash:SetIsViewModelEffect( true )
			vfxMuzzleFlash:Restart()
		end
	else
		-- For some reason, Source reduces particle systems that are attached to the player or a player-owned entity when in 3rd person. This is a work-around.
		if ( self.Owner == LocalPlayer() ) && ( self.Owner:ShouldDrawLocalPlayer() ) then
			ParticleEffect( self.ParticleName, self.Origin, self.Rotation, NULL )
		else
			ParticleEffectAttach( self.ParticleName, PATTACH_POINT_FOLLOW, self.Parent, self.Attach )
		end
	end

end

function EFFECT:Think()

	if ( !IsValid( self.Parent ) ) then return false end
	if ( !isstring( self.ParticleName ) ) then return false end

	if ( self.LightRule > 0 ) && ( self.LightInfo ) && ( self.Attach ) then
		local ang = self.Rotation
		local pos = self.Origin + ang:Forward() * 4 + VectorRand()
	
		if ( self.LightRule > 1 ) && ( !self.Light ) then
			self.Light = ProjectedTexture()
		end
		
		local fScale = ( self.DieTime - CurTime() ) / ( self.LifeTime * 0.6 )
		fScale = math.Clamp( fScale, 0, 1 )
		
		local fBrightness = self.LightInfo.brightness * fScale

		if ( self.LightRule > 1 ) && ( self.Light:IsValid() ) then
			self.Light:SetPos( pos )
			self.Light:SetAngles( ang )
			self.Light:SetColor( self.LightInfo.color )
			self.Light:SetBrightness( fBrightness )
			self.Light:SetFOV( self.LightInfo.fov )
			self.Light:SetNearZ( 16 )
			self.Light:SetFarZ( self.LightInfo.farz )
			self.Light:SetTexture( self.LightInfo.texture )
			
			if ( self.LightRule > 2 ) then
				self.Light:SetEnableShadows( true )
			else
				self.Light:SetEnableShadows( false )
			end
			
			self.Light:Update()
		else
			local dlight = DynamicLight( -1 )
			if ( dlight ) then
				dlight.pos = pos
				dlight.r = self.LightInfo.color.r
				dlight.g = self.LightInfo.color.g
				dlight.b = self.LightInfo.color.b
				dlight.brightness = fBrightness * 2
				dlight.Decay = 2048
				dlight.Size = self.LightInfo.farz
				dlight.DieTime = CurTime() + self.LifeTime
			end
		end
	end

	if ( self.DieTime > CurTime() ) then
		return true
	end
	
	if ( self.Light ) && ( self.Light:IsValid() ) then
		self.Light:Remove()
	end

	return false

end

function EFFECT:Render()

	if ( !cmd_fx_cinematic:GetBool() ) then return end
	if ( !self.LightInfo ) then return end

	local fBloomScale = self.LightInfo.brightness
	
	if ( fBloomScale <= 0 ) then return end

	local ply = GetViewEntity()
	local pos = self.Origin
	
	local plyview = ply:EyeAngles():Forward()
	local eyeview = ply:EyePos()
	local entview = pos - eyeview

	if ( !self.CheckVis ) then
		self.CheckVisInfo.start = pos
		self.CheckVisInfo.endpos = eyeview
		
		self.CheckVis = util.TraceLine( self.CheckVisInfo )
	end

	if ( self.CheckVis.HitWorld ) then return end

	local isvisible	= ( self.DieTime - CurTime() ) / self.LifeTime

	local color_1 = self.LightInfo.color
	local alpha = color_1.a * 0.6 * isvisible
	local bscale = 64
	local iscale = math.Clamp( math.tan( plyview:Dot( entview:GetNormalized() ) ) - 0.4, 0, 1 )

	render.SetMaterial( mBloom )

	local size = fBloomScale * isvisible * ( bscale * iscale )
	local color = Color( color_1.r, color_1.g, color_1.b, alpha * iscale )
	
	if !( self.Parent:GetOwner() == ply ) then
		size = size * 2.4
		alpha = alpha * 4
	end

	render.DrawSprite( pos, size * 1.2, size * 1, Color( color.r * 0.1, color.b * 0.1, color.b * 0.4, color.a ) )
	render.DrawSprite( pos, size * 0.8, size * 1.2, color )

end