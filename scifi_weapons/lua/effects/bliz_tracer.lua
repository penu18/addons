AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

EFFECT.Speed	= 13000
EFFECT.Length	= 64
EFFECT.Trace	= Material( "effects/bliz_needlez" )
EFFECT.Halo		= Material( "effects/blueflare1" )
EFFECT.FlyBy	= "npc/manhack/mh_blade_snick1.wav"

function EFFECT:Init( data )

	self.StartPos = self:GetTracerOrigin( data )
	self.EndPos = data:GetOrigin()
	self.Parent = data:GetEntity()
	
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )

	local diff = ( self.EndPos - self.StartPos )
	
	self.Normal = diff:GetNormal()
	self.StartTime = 0
	self.LifeTime = ( diff:Length() + self.Length ) / self.Speed
	
	if ( IsValid( self.Parent ) and ( !self.Parent:IsWeapon() or !self.Parent:IsCarriedByLocalPlayer() ) ) then

		local dist, pos, time = util.DistanceToLine( self.StartPos, self.EndPos, EyePos() )
		if( dist <= 100 ) then
			EmitSound( self.FlyBy, pos, self.Parent:EntIndex(), CHAN_STATIC, 1, 100, 0, math.random( 80, 120 ) )
		end

	end

end

function EFFECT:Render()

	local endDistance = self.Speed * self.StartTime
	local startDistance = endDistance - self.Length
	
	startDistance = math.max( 0, startDistance )
	endDistance = math.max( 0, endDistance )
	
	local startPos = self.StartPos + self.Normal * startDistance
	local endPos = self.StartPos + self.Normal * endDistance * 2
	
--	render.SetMaterial( self.Halo )
--	render.DrawSprite( startPos, 32, 32, Color( 255, 255, 255, 10 ) )

	render.SetMaterial( self.Trace )
	render.DrawBeam( startPos, endPos, 8, 0, 1, Color( 255, 255, 255, 255 ) )
	
	local dlight = DynamicLight( -1 )
	if ( dlight ) then
		dlight.pos = endPos
		dlight.r = 210
		dlight.g = 205
		dlight.b = 255
		dlight.brightness = 2
		dlight.Decay = 2048
		dlight.Size = 128
		dlight.DieTime = CurTime() + 1
	end

end