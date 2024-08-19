AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Stinger"
ENT.ThinkDelay		= 0.1

ENT.PhxCGroup 		= COLLISION_GROUP_NONE
ENT.PhxSSize		= 2
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "stinger_core_small_2"
ENT.SndImpact 		= "scifi.stinger.explode"
ENT.LifeTime		= 5
ENT.OnWater			= PROJECTILE_RULE_KILLME
ENT.OnImpact 		= PROJECTILE_RULE_IGNORE
ENT.LightEmit		= true
ENT.LightColor		= "255 190 255 255"
ENT.LightSpotRadius	= 256
ENT.LightDistance	= 320
ENT.LightBrightness	= 1.25

ENT.MeteorEnabled 			= false
ENT.MeteorDetectionRange 	= 256
ENT.MeteorIgnoreworld 		= true
ENT.MeteorVelocityInital 	= 1
ENT.MeteorVelocityScale 	= 1
ENT.MeteorHomingFactor 		= 1
ENT.MeteorAlwaysTrack  		= false
ENT.MeteorSwayScale 		= 1
ENT.MeteorVelocityDecay 	= false
ENT.MeteorNeverForget 		= true

function ENT:SubInit()
	
	self:SetNWBool( "IsAttached", false )
	self:SetNWBool( "IsXPloding", false )
		
end

function ENT:SubThink()
	
	if ( self:GetNWBool( "HomingEnabled" ) == true ) and ( self:GetNWBool( "IsAttached" ) == false ) then

		if ( GetConVarNumber( "sfw_sk_stinger_usemtar" ) == 0 ) then
			if ( SERVER ) then
				for k, v in pairs( ents.FindInSphere( self:GetPos(), 786 ) ) do 
					if ( v:IsNPC() ) then
					self:GetPhysicsObject():ApplyForceCenter( ( v:GetPos() - self:GetPos()   ) * ( 2 * ( self:GetPos():Distance( v:GetPos() )  ) ) )
					end
					if ( v:IsPlayer() ) and ( v ~= self.Owner ) then
					self:GetPhysicsObject():ApplyForceCenter( ( v:GetPos() - self:GetPos()   ) * ( 2 * ( self:GetPos():Distance( v:GetPos() )  ) ) )
					end
				end
			end
		else
			if ( !self.MeteorEnabled ) then
				self.MeteorEnabled = true
			end
		end
		
	end
	
	if ( self:GetNWBool( "IsAttached" ) == true ) then
			if ( self.MeteorEnabled ) then
				self.MeteorEnabled = false
			end
		
		--local parent = constraint.FindConstraintEntity( self, "elastic" )
	
		--if ( parent:GetClass() == "sting_sfire" ) then 
		--	constraint.RemoveConstraints( self, "elastic" )  
		--	self:GetNWBool( "IsAttached", false )
		--end
			
	end
	
end

function ENT:OnTakeDamage( dmginfo )

	if ( self:GetXPloding() ) then return end
	
	self:Remove()
	
	return true
	
end

function ENT:Touch( otherEntity )

	if ( CLIENT ) then return end
	
	local tr = self:GetTouchTrace()
	
	if ( self:GetNWBool( "IsAttached" ) == true ) then return end
	
	if ( tr.HitSky ) then return end
	
	if ( tr.HitWorld ) then return end
	
	if ( tr.HitNonWorld ) then
		if ( self:GetNWBool( "IsAttached" ) == false ) then
			
			if ( !tr.Entity:IsPlayer() ) and ( tr.Entity:GetClass() ~= "sting_sfire" ) and ( tr.Entity:GetClass() ~= "sting_pfire" ) and ( tr.Entity ~= nil ) and ( tr.Entity ~= NULL ) then 
			
				DevMsg( tr.Entity )
				ParticleEffectAttach( "stinger_attach", 1, self, 1 )
				self:EmitSound( "scifi.stinger.attach" )
				
				local weld = constraint.Weld( tr.Entity, self, tr.PhysicsBone, 0, 0 ) --, true, false )

				if ( tr.Entity:IsNPC() ) then
					self:SetParent( tr.Entity )
				end
				
				self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
				self:SetNWBool( "IsAttached", true )
				
			else
			
				DevMsg( "@sfw_stinger : !PanicENT (" .. tr.Entity:GetClass() .. "); Attempting to unstick sting_sfire:[" .. self:EntIndex() .. "]!" )
				
			return end
			
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

	self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_BLAST ), 60 * amp, self:GetPos(), 160 )

	local fx2 = ents.Create( "light_dynamic" )
	if ( !IsValid( fx2 ) ) then return end
	fx2:SetKeyValue( "_light", "255 172 255 255" )
	fx2:SetKeyValue( "spotlight_radius", 280 )
	fx2:SetKeyValue( "distance", 512 )
	fx2:SetKeyValue( "brightness", 2 )
	fx2:SetPos( self:GetPos() )
	fx2:SetParent( self )
	fx2:Spawn()
	fx2:Fire( "kill", "", 0.115 )

	ParticleEffect( "stinger_explode_2", self:GetPos(), Angle( 0, 0, 0 ) )

	self:Fire( "hurt", "", 0 )
	self:EmitSound( self.SndImpact )
	
	end

end