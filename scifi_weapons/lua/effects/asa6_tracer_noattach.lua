AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

EFFECT.ParticleCast = false
EFFECT.Time = nil
EFFECT.Speed = 12000
EFFECT.Length	= 64

function EFFECT:Init( data )

	self.StartPos = data:GetStart() --self:GetTracerOrigin( data )
	self.EndPos = data:GetOrigin()
	self.Parent = data:GetEntity()
	
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )

	local diff = ( self.EndPos - self.StartPos )
	
	self.Normal = diff:GetNormal()
	self.StartTime = 0
	
	if ( !self.LifeTime ) then
		self.LifeTime = ( diff:Length() + self.Length ) / self.Speed
	else
		self.LifeTime = CurTime() + self.LifeTime
	end
	
end

function EFFECT:Think()
	
	if ( !self.ParticleCast ) then
		util.ParticleTracerEx( 
			"asa6_tracer", 	--particle system
			self.StartPos, 	--startpos
			self.EndPos, 	--endpos
			false, 			--do whiz effect
			-1, 			--entity index
			-1  			--attachment
		)
		
		self.ParticleCast = true
	end
	
	if ( !self.Time ) then	
		self.Time = self.LifeTime + CurTime()
	end
	
	local Fraction = math.max( 0, ( self.Time - CurTime() ) / self.LifeTime )
	
	local difforigin = self.EndPos - self.StartPos
	local lightorigin = self.StartPos + ( difforigin * ( 1 - Fraction ) ) 

	local mLight = DynamicLight( -1 )
	if ( mLight ) then
		mLight.pos = lightorigin
		mLight.r = 120
		mLight.g = 130
		mLight.b = 255
		mLight.brightness = 4 * Fraction
		mLight.Size = 180 + 200 * Fraction
		mLight.Decay = 1024
		mLight.Style = 1
		mLight.DieTime = CurTime() + 1
	end

	return ( self.Time > CurTime() )
	
end
