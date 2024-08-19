AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )

ENT.PrintName 		= "fathom child"
ENT.PhxCGroup 		= COLLISION_GROUP_DEBRIS
ENT.PhxSSize 		= 12
ENT.PhxGrav			= false
ENT.PhxDrag			= true
ENT.PhxMass			= 6
ENT.PhxElastic		= 3200
ENT.FxTracer 		= "fathom_cloud"
ENT.LifeTime		= 6
ENT.OnWater			= PROJECTILE_RULE_IGNORE
ENT.OnDamaged		= PROJECTILE_RULE_XPLODE
ENT.LightEmit		= false
ENT.SoundEmit		= true
ENT.SoundFile		= "scifi.fathom.idle"
ENT.SoundRate 		= 0.8
ENT.TargetEntity = nil
ENT.TargetHomingSpeed = 12
ENT.NextTick = 0

function ENT:SubThink()

	local target = self.TargetEntity
	
	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()
	local eVelo = self:GetVelocity()
	local eVeloDir = eVelo:Angle()

	local phys = self:GetPhysicsObject()

	if ( SERVER ) then
		if ( IsValid( target ) ) then
			if ( target:IsPlayer() && !target:Alive() ) then
				self.TargetEntity = NULL
			end
		
			local tOrigin = Vector( 0, 0, 0 )
			local tEyes = target:EyePos()

			if ( tEyes ) then
				tOrigin = tEyes
			else
				tOrigin = target:GetPos()
			end

			self:SetAngles( eVeloDir )
			phys:ApplyForceCenter( ( tOrigin - eOrigin ) * self.TargetHomingSpeed )
		else
			phys:ApplyForceCenter( VectorRand() * 512 )
		end
		
		if ( self.NextTick <= CurTime() ) then
			local size = 64
			local trData = {}
			local trResult = {}
			local trSize = Vector( size, size, size )
		
			if ( !self.TargetEntity || !IsValid( self.TargetEntity ) ) then
				size = 128
			end

			trData.start 		= eOrigin - eOffset * size
			trData.endpos 		= eOrigin + eOffset * size
			trData.filter 		= function( ent ) if ( ent:Health() <= 0 ) then return false else return true end end --{ self, self.Owner, }
			trData.mins 		= trSize * -1
			trData.maxs 		= trSize
			trData.mask 		= MASK_SHOT_HULL
			trData.ignoreworld 	= true
			trData.output 		= trResult
			
			util.TraceHull( trData )

			if ( trResult.Hit && trResult.Entity:Health() > 0 ) then
				self:XPlode( trResult )
			end
			
			if ( !self.TargetEntity || !IsValid( self.TargetEntity ) ) && ( trResult.Entity:IsNPC() || trResult.Entity:IsPlayer() ) then
				self.TargetEntity = trResult.Entity
			end
			
			self.NextTick = CurTime() + 0.2
		end
		
		if ( self:WaterLevel() == 3 ) then
			self.DieTime = self.DieTime - 0.5
		end
		
		if ( self:IsOnFire() ) then
			self.DieTime = self.DieTime - 1
		end
	end

end

function ENT:PhysicsCollide( data, phys )
	
	if ( data.Speed > 72 ) then 
		self:EmitSound( "Flesh_Bloody.ImpactHard" )
	end
	
	if ( data.Speed > 128 ) && ( IsValid( phys ) ) then
		phys:ApplyForceCenter( data.HitNormal * -data.Speed )
	end
	
end

function ENT:OnRemove()

	if ( SERVER ) then
		local pos = self:GetPos()
		local ang = self:GetAngles()
		
		ParticleEffect( "fathom_death", pos, ang )
	end

end

function ENT:XPlode( pCollisionData )

	local amp = GetConVarNumber( "sfw_damageamp" )
	local pos = self:GetPos()

	if ( !pCollisionData ) then return end
	local target = pCollisionData.Entity

	if ( SERVER ) then
		self:EmitSound( "scifi.dmg.acidburn" )
		
		if !( !IsValid( target ) || target:IsWorld() || target == self ) then 
			local amp = GetConVarNumber( "sfw_damageamp" )
			
			local iDamage = ( 4 - ( 4 * pCollisionData.Fraction ) ) * amp
			
			if ( pCollisionData.HitGroup == HITGROUP_HEAD ) then
				iDamage = iDamage * 2
			end
			
			local pOwner = self:GetValidOwner()

			self:DealDirectDamage( DMG_SF_CORROSIVE, iDamage, target, pOwner, Vector( 0, 0, 0 ) )
				
			target:Fire( "HitByBugbait", "", 0 )
			
			if ( GetRelChance( 2 ) && ( IsValid( pOwner ) ) ) then
				if ( target:IsNPC() || target:IsPlayer() ) then
					DoElementalEffect( { Element = EML_CORROSIVE, Target = target, Attacker = pOwner, Inflictor = pOwner } )
				end
			end
		end
	end
	
end