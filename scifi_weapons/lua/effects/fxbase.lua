-- based on nomad's tracer by Chad Barrett --
-- edited for the use with SciFiWeapons by Darken217 --

AddCSLuaFile()
if ( CLIENT ) then
TRACER_FLAG_USEATTACHMENT	= 0x0002
end
EFFECT.Speed	= 6500
EFFECT.Length	= 64
EFFECT.Normal 	= Vector( 0, 0, 0 )

function EFFECT:GetTracerOrigin( data )
	if ( CLIENT ) then
		local vOrigin = data:GetStart()

		if ( bit.band( data:GetFlags(), TRACER_FLAG_USEATTACHMENT ) == TRACER_FLAG_USEATTACHMENT ) then
			local entParent = data:GetEntity()
			
			if ( !IsValid( entParent ) ) then 
				return vOrigin 
			end
			
			if ( !game.SinglePlayer() && entParent:IsEFlagSet( EFL_DORMANT ) ) then 
				return vOrigin 
			end
			
			if( entParent:IsWeapon() && entParent:IsCarriedByLocalPlayer() ) then
				local entPlayer = entParent:GetOwner()
				if ( IsValid( entPlayer ) ) then
					local entViewModel = entPlayer:GetViewModel()
					if ( IsValid( entViewModel ) && !LocalPlayer():ShouldDrawLocalPlayer() ) then
						entParent = entViewModel
					else 					
						if ( entParent.WorldModel ) then
							entParent:SetModel( entParent.WorldModel )
						end
					end
				end
			end

			local attachment = entParent:GetAttachment( data:GetAttachment() )
			if ( attachment ) then
				vOrigin = attachment.Pos
			end

		end
		
		return vOrigin
	end
end

function EFFECT:Init( data )

	self.StartPos = self:GetTracerOrigin( data )
	self.EndPos = data:GetOrigin()
	self.Parent = data:GetEntity()
	
--	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )

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

	self.LifeTime = self.LifeTime - FrameTime()
	self.StartTime = self.StartTime + FrameTime()
	
	return self.LifeTime > 0

end

function EFFECT:Render()

	local endDistance = self.Speed * self.StartTime
	local startDistance = endDistance - self.Length
	
	startDistance = math.max( 0, startDistance )
	endDistance = math.max( 0, endDistance )

	local startPos = self.StartPos + self.Normal * startDistance
	local endPos = self.StartPos + self.Normal * endDistance
	
end