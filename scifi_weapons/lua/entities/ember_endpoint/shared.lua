AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "Ember laser"

ENT.PhxCGroup 		= COLLISION_GROUP_IN_VEHICLE
ENT.PhxSSize		= 0.1
ENT.PhxMass 		= 1
ENT.PhxGrav			= false
ENT.PhxDrag			= false
ENT.FxTracer 		= "hwave_tracer_line"
ENT.LightEmit		= true
ENT.LightColor		= "255 120 10 255"
ENT.LightSpotRadius	= 240
ENT.LightDistance	= 280
ENT.LightBrightness	= 1
ENT.LightStyle		= 1

local panicents = {
	ember_endpoint,
	light_dynamic
}
		
function ENT:Initialize()

	local size = self.PhxSSize
	
	self:PhysicsInit( self.Phx )
	self:SetMoveType( self.PhxMType )
	self:PhysicsInitSphere( size, self.PhxSProp )
	self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
	self:SetCollisionGroup( self.PhxCGroup )
	self:DrawShadow( false )
	self:SetNoDraw( false )
	self:SetElasticity( self.PhxElastic )
	self:SetMaterial( "vgui/white" )
	
	self:AddEFlags( EFL_NO_WATER_VELOCITY_CHANGE )
	
	local phys = self:GetPhysicsObject()
	if ( !IsValid( phys ) ) then self:Remove() return end
	phys:EnableGravity( self.PhxGrav )
	phys:EnableDrag( self.PhxDrag )
	phys:SetMass( self.PhxMass )
	phys:AddGameFlag( FVPHYSICS_WAS_THROWN )
	
	if ( SERVER ) then

	if ( self.LightEmit == true ) and ( GetConVarNumber( "sfw_allow_lightemission" ) == 1 ) then
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", self.LightColor )
		fx:SetKeyValue( "spotlight_radius", self.LightSpotRadius )
		fx:SetKeyValue( "distance", self.LightDistance )
		fx:SetKeyValue( "brightness", self.LightBrightness )
		fx:SetKeyValue( "style", self.LightStyle )
		fx:SetPos( self:GetPos() )
		fx:SetParent( self )
		fx:Spawn()	
	end

	end
	
	if ( self.FxTracer ~= nil ) then
		ParticleEffectAttach( self.FxTracer, 1, self, 1 )
	end
	
	if ( CLIENT ) && ( GetConVarNumber( "sfw_fx_particles" ) >= 1 ) then
		self.PixVis = util.GetPixelVisibleHandle()
	end
	
end

function ENT:Think()

	if ( SERVER ) then

		if ( !IsValid( self.Owner ) || !IsExistent( self.Owner ) ) || ( self.Owner:GetActiveWeapon():GetClass() ~= "sfw_ember" ) || ( self.Owner:GetActiveWeapon():GetNWBool( "ember_active" ) ~= true ) then
			self:Remove()
		else
			self:SetAngles( self.Owner:EyeAngles() )
			self:SetPos( self:GetNWVector( "laser_endpoint" ) )
		end

		self:XPlode()
	
	end
	
end

function ENT:OnTakeDamage( CTakeDamageInfo )

end

function ENT:PhysicsCollide( data, phys )

end

function ENT:XPlode()

	local amp = GetConVarNumber( "sfw_damageamp" )
	
	if ( SERVER ) then
	
	--self:DealPointDamage( bit.bor( DMG_DIRECT, DMG_PREVENT_PHYSICS_FORCE ), math.random( 8, 12 ) * amp, self:GetPos(), 32 )
	
	if ( self:WaterLevel() < 1 ) then
		self:DealAoeDamage( bit.bor( DMG_GENERIC, DMG_BURN ), math.random( 3, 4 ) * amp, self:GetPos(), 4 )
	end
	
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 8 ) ) do
		local iDmg = math.random( 6, 10 ) * amp
	
		if ( v:GetClass() == "func_breakable" || v:GetClass() == "prop_physics" ) then
			iDmg = iDmg * 10
		end
	
		if ( v:IsOnFire() ) then
			iDmg = iDmg * 1.5
		end
		
		self:DealDirectDamage( bit.band( DMG_DIRECT, DMG_PREVENT_PHYSICS_FORCE ), iDmg, v )
		
		if ( GetRelChance( 25 ) && self:WaterLevel() < 1 ) then
			if ( table.HasValue( panicents, v:GetClass() ) ) or ( v:GetOwner() == self.Owner ) or ( v == self.Owner ) then 
				DevMsg( "@sfw_ember : !PanicENT; Found " .. v:GetClass() .. "... Ignoring!" )
			else
				if ( IsValid( v:GetPhysicsObject() ) && v:GetPhysicsObject():GetMaterial() ~= "metal" ) then
					DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 2 } )
				end
			end
		end
	end
	
	self:EmitSound( "scifi.ember.burn" )
	
	end
	
end