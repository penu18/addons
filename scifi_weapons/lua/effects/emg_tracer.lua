AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

EFFECT.ParticleCast = false
EFFECT.Time = nil

EFFECT.Speed = 32000
function EFFECT:Think()

	if ( !self.ParticleCast ) then
		util.ParticleTracerEx( 
			"emg_tracer", 	--particle system
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
		mLight.r = 255
		mLight.g = 0
		mLight.b = 10
		mLight.brightness = 0.4 + 0.2 * Fraction
		mLight.Size = 128 + 64 * Fraction
		mLight.Decay = 1024 + 1024 * Fraction
		mLight.Style = 1
		mLight.DieTime = CurTime() + 1
	end
	
	return ( self.Time > CurTime() ) 
	
end
