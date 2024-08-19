AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Stinger"

ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxSSize		= 2
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "stinger_core_small"
ENT.SndImpact 		= "scifi.stinger.explode"
ENT.LifeTime		= 5
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnImpact 		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "110 190 255 255"
ENT.LightSpotRadius	= 256
ENT.LightDistance	= 320
ENT.LightBrightness	= 1.25

function ENT:SubInit()
	
	self:SetNWBool( "IsAttached", false )
	self:SetNWBool( "IsXPloding", false )
		
end

function ENT:OnTakeDamage( dmginfo )

	if ( self:GetXPloding() ) then return end
	
	self:Remove()
	
	return true
	
end

function ENT:Touch( otherEntity )

	if ( CLIENT ) then return end
	
	if ( self:GetNWBool( "IsAttached" ) == true ) then return end

	local tr = self:GetTouchTrace()
	local hitPos = tr.HitPos
	
	if ( tr.HitSky ) then return end
	
	if ( tr.HitWorld ) then return end
	
	if ( tr.HitNonWorld ) then
		if ( self:GetNWBool( "IsAttached" ) == false ) then
			DevMsg( tr.Entity )
			ParticleEffectAttach( "stinger_attach", 1, self, 1 )
			self:EmitSound( "scifi.stinger.attach" )
			
			if ( tr.Entity:IsPlayer() ) or ( tr.Entity:GetClass() == "sting_pfire" ) then 
				DevMsg( "@sfw_stinger : !PanicENT (" .. tr.Entity:GetClass() .. "); Attempting to unstick sting_pfire:[" .. self:EntIndex() .. "]!" )
			return end
			
			local weld = constraint.Weld( tr.Entity, self, tr.PhysicsBone, 0, 0 ) --, true, false )
			if ( tr.Entity:IsNPC() ) then
				self:SetParent( tr.Entity )
			end
			self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
			self:SetNWBool( "IsAttached", true )
		end
	end
	
end

function ENT:PhysicsCollide( data, phy )

	if ( GetConVarNumber( "sfw_fx_particles" ) == 1 ) then
		ParticleEffect( "stinger_bounce", self:GetPos(), Angle( 1, 2, 3 ), self )
	end
	
end

function ENT:OnRemove()

	if ( !self:GetXPloding() ) then
		self:XPlode()
	end

end

function ENT:XPlode()

	local amp = GetConVarNumber( "sfw_damageamp" )

	if ( SERVER ) then
	
	self:SetXPloding( true )
	
	constraint.RemoveAll( self )

	self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_BLAST ), 80 * amp, self:GetPos(), 160 )

	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx2 ) ) then return end
	fx2:SetKeyValue( "_light", "110 172 255 255" )
	fx2:SetKeyValue( "spotlight_radius", 280 )
	fx2:SetKeyValue( "distance", 512 )
	fx2:SetKeyValue( "brightness", 2 )
	fx2:SetPos( self:GetPos() )
	fx2:SetParent( self )
	fx2:Spawn()
	fx2:Fire( "kill", "", 0.115 )

	ParticleEffect( "stinger_explode", self:GetPos(), Angle( 0, 0, 0 ) )

	self:Fire( "hurt", "", 0 )
	self:EmitSound( self.SndImpact )
	
	end

end