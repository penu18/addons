AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

function EFFECT:Think()

	util.ParticleTracerEx( 
		"spr_tracer", 	--particle system
		self.StartPos, 	--startpos
		self.EndPos, 	--endpos
		true, 			--do whiz effect
		-1, 			--entity index
		-1  			--attachment
	)
	
	return false
	
end
