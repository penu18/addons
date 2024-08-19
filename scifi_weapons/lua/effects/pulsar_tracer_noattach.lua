AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

EFFECT.Speed	= 6500 --16000
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

	util.ParticleTracerEx( 
		"pulsar_beam", 	--particle system
		self.StartPos, 	--startpos
		self.EndPos, 	--endpos
		true, 			--do whiz effect
		-1, 			--entity index
		-1  			--attachment
	)
	
	return false
	
end
