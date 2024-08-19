AddCSLuaFile()

local cmd_fx_forceclient = GetConVarNumber( "sfw_fx_forceclientmuzzle" )
local cmd_fx_muzzlelights = GetConVar( "sfw_fx_muzzlelights" )

EFFECT.ParticleName = "spectra_blast"
EFFECT.Light = nil
EFFECT.LightInfo = nil
EFFECT.LightRule = 0
EFFECT.LifeTime = 0.032
EFFECT.DieTime = 0
EFFECT.World = false

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
				self.World = true
			else
				vmEntity = vmOwner:GetActiveWeapon()
			end
		end
			
		return vmEntity
	end

end

function EFFECT:GetParticleName()

	local name = self.Weapon.VfxMuzzleParticle

	if ( !IsValid( self.Weapon ) ) then 
		name = "ngen_muzzle" 
	end
	
	return name
	
end

function EFFECT:GetParticleAttach()

	local wEntity = self.Weapon
	
	if ( !IsValid( wEntity ) ) then return "muzzle" end

	if ( self.World && wEntity.VfxMuzzleAttachment2 ) then
		return wEntity.VfxMuzzleAttachment2
	end

	return wEntity.VfxMuzzleAttachment
	
end

function EFFECT:Init( data )
	
	if ( !IsValid( self ) ) || ( !IsValid( data:GetEntity() ) ) then return end

	self.Owner = LocalPlayer()
	self.Weapon = data:GetEntity()
	self.Parent = self:GetMuzzleParent()

	if ( !IsValid( self.Parent ) ) then return false end
	if ( !isstring( self.ParticleName ) ) then return false end
	
	local IsAds = ( self.Weapon.SciFiState == SCIFI_STATE_ADS )

	local vmAttach = self.Parent:LookupAttachment( self:GetParticleAttach() )
	
	if ( vmAttach == 0 ) then
		self.Attach = "1"
	else
		self.Attach = vmAttach
	end
	
	self.StartTime = 0
	
	self.DieTime = CurTime() + self.LifeTime

	if ( cmd_fx_forceclient == 1 ) then
		CreateParticleSystem( self.Parent, self.ParticleName, PATTACH_POINT_FOLLOW, self.Attach, nil ) 
	else
		ParticleEffectAttach( self.ParticleName, PATTACH_POINT_FOLLOW, self.Parent, self.Attach )
	end

end

function EFFECT:Think()

	if ( !IsValid( self.Parent ) ) then return false end
	if ( !isstring( self.ParticleName ) ) then return false end

	if ( self.DieTime > CurTime() ) then
		return true
	end
	
	if ( self.Light ) && ( self.Light:IsValid() ) then
		self.Light:Remove()
	end

	return false

end

function EFFECT:Render()
	
end