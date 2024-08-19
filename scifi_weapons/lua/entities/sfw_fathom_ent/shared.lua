AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

local lightflare = Material( "effects/led_glow" ) --"effects/redflare" )

ENT.PrintName 		= "fathom grenade"
--ENT.SvThinkDelay 	= 0
ENT.RMdl 			= "models/catalyst/items/biocontainer.mdl"
ENT.RMat 			= "models/weapons/fathom/biocontainer" 
ENT.RShadows 		= true
ENT.Phx 			= SOLID_VPHYSICS
ENT.PhxSProp 		= "Metal"
ENT.PhxSSize 		= nil
ENT.PhxGrav			= true
ENT.PhxDrag			= true
ENT.PhxMass			= 5
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "gunsmoke"
ENT.SndImpact 		= "BaseExplosionEffect.Sound" --"scifi.seraph.fire1"
ENT.LifeTime		= 2
ENT.KillSilentDelay = 0.1
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= true
ENT.LightExplode 	= 24
ENT.LightColor		= "240 110 80 255"
ENT.LightSpotRadius	= 32
ENT.LightDistance	= 32
ENT.LightBrightness	= 1
ENT.LightFlareMat 	= lightflare
ENT.LightFlareColor = nil --Color( 255, 255, 255 )
ENT.LightFlareAlpha	= 160
ENT.LightFlareSize 	= 0.24
ENT.DieTick 		= 0

function ENT:SubInit( ent )

	if ( SERVER ) then
		if ( GetConVarNumber( "sfw_fx_sprites" ) == 1 ) then
			util.SpriteTrail( 
				ent, 								-- parent
				1, 									-- attachment ID
				string.ToColor( self.LightColor ), 	-- Color
				1, 									-- force additive rendering
				2, 									-- start width
				0, 									-- end width
				0.2,								-- lifetime
				16,									-- texture resulution
				"effects/beam_nocolor.vmt" 			-- texture
			)
		end
		
		ent:SetXPloding( false )
	end
	
end

function ENT:SubThink()
	
	if ( SERVER ) then
		local frac = self.DieTime - CurTime()
		local mul = self.LifeTime - frac
		local step = ( frac / 16 ) * frac

		if ( self.DieTick < CurTime() ) then
			self:EmitSound( "buttons/button16.wav", 60, 100 + 30 * mul, 0.5, CHAN_STATIC )

			self.DieTick = CurTime() + step
		end

		if ( self.DieTime <= CurTime() ) && ( !self:GetXPloding() ) then
			self:XPlode()
		end
	end

end

function ENT:PhysicsCollide( data, phys )
	
	if ( data.Speed > 72 ) then 
		self:EmitSound( "Grenade.ImpactHard" )
	end
	
	if ( IsValid( data.Entity ) ) && ( !data.Entity:IsWorld() ) then
		data.PhysObject:SetVelocity( data.PhysObject:GetVelocity() * 0.4 )
	end
	
	if ( self.LauncherMode ) && ( !self:GetXPloding() ) then
		self:XPlode()
	end
	
end

function ENT:XPlode()

	if ( self:GetXPloding() ) then return end
	
	self:SetXPloding( true )

	local amp = GetConVarNumber( "sfw_damageamp" )
	local pos = self:GetPos()

	if ( SERVER ) then
		self:DealAoeDamage( DMG_SF_CORROSIVE, 4 * amp, pos, 256 )
		
		local tIndex = ents.FindInSphere( pos, 512 )
		local tEntity
		local pOwner = self.Owner --:GetValidOwner()
		
		ParticleEffect( "fathom_blast", pos, Angle( 0, 0, 0 ), pOwner )
		util.Decal( "beersplash", pos, pos - Vector( 0, 0, 8 ) )
		
		self:EmitSound( "scifi.fathom.explode" )
		
		util.ScreenShake( pos, 64, 512, 0.8, 256 )

		for i=1, #tIndex do 
			local tValue = tIndex[ i ]
			
			if ( !tEntity ) && ( IsValid( tValue ) ) && ( tValue:IsNPC() || ( tValue:IsPlayer() && tValue ~= pOwner ) ) then
				tEntity = tValue
			end
		end

		local childs = 0
		for childs = 0, 4 do
		--	local tEntity = tIndex[ math.random( 1, #tIndex ) ]
			
			local child = ents.Create( "sfw_fathom_child" )
			if ( !IsValid( child ) ) then return end
			child:SetPos( pos )
			child:SetOwner( pOwner )
			child:Spawn()
			child:Activate()
			
			if ( IsValid( tEntity ) ) then
				child.TargetEntity = tEntity
				child.TargetHomingSpeed = math.random( 6, 12 )
			end
			
			local cphys = child:GetPhysicsObject()
			if ( !IsValid( cphys ) ) then child:KillSilent() end
			cphys:ApplyForceCenter( Vector( math.random( -256, 256 ), math.random( -256, 256 ), math.random( 64, 256 ) ) )
		end

		self:KillSilent()
	end
	
end