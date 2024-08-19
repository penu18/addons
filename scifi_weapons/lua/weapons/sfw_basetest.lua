AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

function SWEP:SecondaryAttack()

	if ( !self.Owner:KeyDown( IN_USE ) ) then return end

	if (  !self:CanPrimaryAttack( 1 ) ) then return end
	self:SetNextSecondaryFire( CurTime() + 0.6 )
	
	local viewmodel = self:GetViewModelEnt()
	
	if ( SERVER ) then
	
		local ent = ents.Create( "sfp_base" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 34000 + self:GetProjectileSpreadVector() * (self:GetSciFiACC() * 5500) )
		
	end
	
	if ( self.Owner:IsPlayer() ) then
	
		self.Owner:ViewPunch( Angle( math.random( -1.25, -2.5 ), math.random( 0, 0.918 ), math.random( 0, 0.918 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		
		self:AddSciFiACC( 4.2 )
		
	end
	
	DoMuzzleEffect()
	
	if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) and ( self:GetSciFiACC() >= ( GetConVarNumber( "sfw_sk_maxacc" ) * 0.82 ) ) then
		ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	end
	
	self:EmitSound( "scifi.vapor.fire1" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self:TakePrimaryAmmo( 2 )
	
end