------------------------------------------------------------------
-- Darken217's Sci-Fi Weapons v18 								--
-- gravrifle_preexplode											--
-- Elemental effect to go along with Helios' elemental effect 	--
------------------------------------------------------------------

--[[
Hypocritical naming convention:
	I encourage you to stick to a specific naming convention for your variables, so you know what you're dealing with.
	I try to stick to a prefix-system to show the datatype assigned to a specific variable. 
	For example bEnabled is a boolean, vPosition is a vector, aRotation an angle and so on. 
	It's not mendatory, but it'll help you keep your code manageable, especially when you get to a point where you experiment around.
]]--

-- The material we'll be writing data to. We'll apply the material to the effect later.
EFFECT.FxMaterial = Material( "models/elemental/gravrifled" )
EFFECT.DeltaTime = 1

local m_sprite = Material( "particle/warp1_warp.vmt" )

-- The default color. This technically equates to "255 153 1020", which is something the engine technically cannot display.
-- However, we're overshooting the color to fake actual light emission, relying on bloom effects along with the emissive glow in the material to create a feeling of "glow".
EFFECT.LightColor = Vector( 1, 0.6, 4 )

-- local mBloom = Material( "bloom/halo_static" )

local cmd_sunbeams = GetConVar( "sfw_fx_individualsunbeams" )
EFFECT.SpriteSize = 64
EFFECT.SpriteAlpha = 128

-- Precache sounds. 
-- Technically this is also done in /base/scifi_sounds.lua, however, we want to adjust the sounds on the fly, which a sound-script created by sound.Add() doesn't allow us to do.
-- Note, that in any other scenario where you don't pass additional data to the EmitSound() function, the sound script addition is the way to go.
local tDistantBlastSounds = {
	Sound( "weapons/calhan/blast_distant1.wav" ),
	Sound( "weapons/calhan/blast_distant2.wav" ),
	Sound( "weapons/calhan/blast_distant3.wav" ),
	Sound( "weapons/calhan/blast_distant4.wav" )
}

--[[
Init
--
Runs on effect creation
--
Initialize the effect and pass the EffectData() passed by util.Effect().
Effect-specific data, like EFFECT.ParentEntity is defined in here.
]]--
function EFFECT:Init( data )

	if ( GetConVar( "mat_fillrate" ):GetBool() ) then return end

	-- Effects loop ad-infinitum, until emergency cleanup (don't rely on this) or until the parent entity is removed.
	-- Life-time is calculated by determining a point in time at which the effect should self-terminate (see EFFECT.Think()).
	self.Time = data:GetScale()
	self.Origin = data:GetOrigin()
	self.LifeTime = CurTime() + self.Time
	
	local ent = data:GetEntity()
	
	if ( !IsValid( ent ) ) then return end
	if ( !ent:GetModel() ) then return end
	
	-- Check whether or not the parent entity is the current player.
	-- If so, target the viewmodel, so it has a proper 1st-person representation.
	local entPlayer = LocalPlayer()
	if ( ent == entPlayer ) && ( !entPlayer:ShouldDrawLocalPlayer() ) then
		self.ViewModel = true -- Set ViewModel to true, we'll look this up later in EFFECT.RenderOverlay().
			
		ent = entPlayer:GetHands()
	end
	
	self.ParentEntity = ent
	
	-- Self-terminate in case the entity's RenderOverride slot is already taken. (usually by a dissolve effect)
	if ( self.ParentEntity.RenderOverride ) then
		return
	end
	
	-- Apply the target entity's model to this effect, effectively creating a mesh-layer.
	self:SetModel( ent:GetModel() )	
	self:SetPos( ent:GetPos() )
	self:SetAngles( ent:GetAngles() )
	self:SetParent( ent )
	
	self.ParentEntity.RenderOverride = self.RenderParent
	self.ParentEntity.SpawnEffect = self
	
	-- Write a randomized value to the effect's target material. This is not mandatory but can be useful create a more "individualized" appearance and reduce repititiveness.
	self.FxMaterial:SetVector( "$emissiveBlendScrollVector", Vector( 0.1, 0.15 ) * ( 14 - data:GetScale() ) )

end

--[[
Think 
--
Runs every frame as long as the effect lives.
--
Handle timed events and self-termination.
Returns TRUE as long as the effect's survival conditions are met (valid parent, CurTime() < Expiration Time).
Returns FALSE when the effect should self-terminate. 
]]--
function EFFECT:Think( )

	-- Self-terminate if the parent entity is invalid.
	if ( !IsValid( self.ParentEntity ) ) then return false end

	-- Offset the effect slightly towards the player's eyes, so the overlay doesn't intersect with the actual model and always appears on top.
	local vParentOrigin = self.ParentEntity:GetPos()
	self:SetPos( vParentOrigin + ( EyePos() - vParentOrigin ):GetNormal() )
	
	-- Determine how much "life time" the effect has left until self-termination.
	local DieTime = self.LifeTime - CurTime()
	
	-- The sound-effect is not stretched. Play the "pre-explode" sound in case the remaining lifetime is equal or less than half-a-second.
	if ( DieTime <= 0.58 && self.DeltaTime >= 0.58 ) then
		self.ParentEntity:EmitSound( "scifi.gravrifle.preexplode" )
	end
	
	-- Write a delta-time. We use this value to compare between current frame and last frame to determine an exact moment in time.
	self.DeltaTime = DieTime
	
	if ( self.LifeTime > CurTime() ) then
		return true
	end
	
	self.ParentEntity:StopSound( "scifi.gravrifle.preexplode" )
	
	-- Start of death-event
	self.ParentEntity.RenderOverride = nil
	self.ParentEntity.SpawnEffect = nil
	
	-- Emit explosion sound on client. Note, that this will not always take place, depending on the entity it's called on. See /scifi_base/scifi_elementals.lua
	
	local sParentClass = self.ParentEntity:GetClass()	
	local bIsRagdoll = ( sParentClass == "prop_ragdoll" || sParentClass == "class C_HL2MPRagdoll" ) -- apparently, entity.IsRagdoll() does no longer work for clientside ragdolls, i.e. player ragdoll entities. This will have to make due.
	if ( game.SinglePlayer() && !bIsRagdoll ) || ( !game.SinglePlayer() && bIsRagdoll ) then
		self.ParentEntity:EmitSound( "scifi.gravrifle.blast" )
	end

	-- Determine the distance between the player (or otherwise current view entity, i.e. a gmod_cameraprop) and the explosion.
	-- We use 4000 as an arbitrary falloff distance at which the explosion will not be heard anymore and 0.3 as maximum playback volume.
	local iDistance = vParentOrigin:Distance( EyePos() )
	local fVolume = math.Clamp( iDistance / 4000, 0, 0.3 )

	if ( fVolume > 0.06 ) then
		EmitSound( tDistantBlastSounds[ math.random( 1, #tDistantBlastSounds ) ], vParentOrigin, -1, CHAN_STATIC, fVolume, SNDLVL_95dB, SND_NOFLAGS, math.random( 90, 110 ) )
	end
	
	-- Self-termination		
	return false
	
end

--[[
Render function. This is default for effects, but since we have a custom one (EFFECT.RenderOverlay) 
]]--
function EFFECT:Render()

end

--[[
Render the effect
--
Runs every frame as long as the effect lives.
--
The core function of the effect. Work with the acquired data, make the effect happen.
In here, we're creating dynamic light emission and write data into the override material.
We're also rendering the overlay mesh.
]]--
function EFFECT:RenderOverlay( entParent )
	
	-- Calculate a scale that is relative to the life-time. This scales from 0 to 1.
	local fFraction = 1 - ( self.LifeTime - CurTime() ) / self.Time
	
	-- Clamp the fraction (see above) between 0 and 1. This is a safety percussion. 
	-- Mathematically, there should be no reason to do this, however, if the player is suffereing from very low FPS the timing could be off, causing fFraction to get out of the desired bounds.
	fFraction = math.Clamp( fFraction, 0, 1 )
	
	local vOrigin = entParent:GetPos()
	local vEyeOrigin = EyePos()
	local EyeNormal = vOrigin - vEyeOrigin
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local vOffset
	
	if ( self.ViewModel ) then
		-- We're arbitrarily assuming that the viewmodel FOV is 54 (default for HL2 weapons unless altered by a mod).
		local iFov = 54
		local entWeapon = LocalPlayer():GetActiveWeapon()
		if ( IsValid( entWeapon ) && entWeapon.ViewModelFOV ) then
			iFov = entWeapon.ViewModelFOV
		end
		
		local add = -54 + iFov
		add = add * 0.3
		
		-- Offset the effect away from the player, because it would otherwise be "inside" them and thus "behind" the camera. 
		-- This is INCREDIBLY hacky.
		vOffset = EyeAngles():Forward() * ( 12 - add )
	else
		-- Offset the effect slightly towards the player's eyes, so the overlay doesn't intersect with the actual model and always appears on top.
		vOffset = EyeNormal * Distance * 0.01
	end
	
	-- Set the mesh-overlay's position.
	local Pos = vEyeOrigin + vOffset
	
	local entOwner
	if ( self.ViewModel ) then
		entOwner = entParent:GetOwner()
	else
		entOwner = entParent
	end

	-- Since the effect's appearence is pretty irratic, we'd like the dynamic light to act in a similar manner.
	-- We're using a sine function of the current time and a randomized value to create apparently randomized flicker.
	-- Finally, the fFraction value (see above) to scale it according to life-time, creating a "increasing" feeling.
	local fFlicker = math.sin( CurTime() * math.random( 16, 64 ) ) + 1.2 * fFraction
	local fStrength = fFraction * 2 ^ ( fFraction * 1.2 )
	
	-- Determine the light emission's location. We're idealy choosing the target entity's root bone.
	-- On a typical Valve-esque bone rig, this will be at or around the pelvis. On non-ragdoll entities (i.e. prop_physics), bone "0" will of course be the only bone present.
	local vLightOrigin = entOwner:GetBonePosition( 0 )
	if ( !entOwner:IsRagdoll() ) then
		vLightOrigin = entOwner:GetPos() + entOwner:OBBCenter()
	end
	
	-- Create the dynamic light.
	local dlight = DynamicLight( entOwner:EntIndex() )
	if ( dlight ) then
		dlight.pos = vLightOrigin
		dlight.r = math.min( self.LightColor.r * 10, 255 ) 	-- Remember the "color overshooting" we did above.
		dlight.g = math.min( self.LightColor.g * 10, 255 ) 	-- Note, that DynamicLight() is unable to display colors like 256, it'll effectively break and mutate the color.
		dlight.b = math.min( self.LightColor.b * 10, 255 )
		dlight.brightness = 2 * fFraction					-- Scale the brightness with the fFraction.
		dlight.Size = ( 600 + 400 * fFlicker ) * fFraction 	-- Don't just multiply .Size with fFraction, since the light will appear too small or won't be visible to the player. We'll be using a base size and add an increasing size to it. 
		dlight.Decay = 2048
		dlight.Style = 1									-- Light style "1" is mildly flickering on its own already, but we'll add our flicker created above regardless.
		dlight.DieTime = CurTime() + self.Time				-- Technically we're setting the lifetime to an unnecessarily long value, but since we're overwriting the light each frame anyway, it doesn't matter at all.
	end

	-- Write data into the material --
	-- See developer.valvesoftware.com for the specific material effects, most notably $EmissiveBlend and $Flesh.
	-- Essentially, we're using the effects created for the Vortigaunt teleport scene and the Alyx healing scene, like we did in many other effects before.
	-- The arbitrary values used here have been determined through fine tuning and gut-feeling.
	self.FxMaterial:SetFloat( "$emissiveBlendStrength", fStrength ) 		-- Scale the brightness of the purple swirl effect.
	self.FxMaterial:SetFloat( "$FleshBorderSoftness", 0.1 * fFraction )		-- Scale the black-hole effect to grow until it covers the entire model. 
	self.FxMaterial:SetFloat( "$FleshBorderWidth", 7 - fStrength * 3 )		-- Different value, but the goal is the same as above. ^
	self.FxMaterial:SetFloat( "$time", fFraction )							-- $time is equal to CurTime() inside materials unless otherwise specified. We'll write it equal to the effect's lifetime so the effects behave according to their internal time.
	self.FxMaterial:SetVector( "$energycolor", self.LightColor * fStrength )			-- $energycolor is a placeholder variable used inside the material. It's the color applied to glow emissions, so we don't have to write colors to multiple values via lua and let the engine do the copy-pasta for us.

	--[[--- Ignore this one. Gmod doesn't support this cinematic feature ------
	]]-------------------------------------------------------------------------	
	self.FxMaterial:SetFloat( "$SphereMaskRadius", 72 * fFraction )
	self.FxMaterial:SetFloat( "$FleshGlobalOpacity", 1 * fStrength )
	
	if ( self.Origin ) then
		self.FxMaterial:SetVector( "$SphereMaskOrigin", self.Origin )
	else
		self.FxMaterial:SetVector( "$SphereMaskOrigin", origin )
	end
	
	-- Create a 3d rendering context at the offset position and actually draw the mesh-overlay with the effect material.
	cam.Start3D( Pos, EyeAngles() )
		render.MaterialOverride( self.FxMaterial )
		entParent:DrawModel()
		render.MaterialOverride() -- Don't forget to reset MaterialOverride() once you've set it, so you don't break literally everything that ever wanted to apply a material.
	cam.End3D()
	
	local fSpriteScale = math.Clamp( -0.4 + fFraction * 1.4, 0, 1 )

	local color_1 = Color( 255, 255, 255, 255 )
	color_1.a = self.SpriteAlpha * fSpriteScale

	local size = ( entOwner:BoundingRadius() + self.SpriteSize ) * fSpriteScale

	render.SetMaterial( m_sprite )
	render.DrawSprite( vLightOrigin, size, size, color_1 )
	
	-- Finish here unless individual sunbeams are enabled.
	local bSunBeams = cmd_sunbeams:GetBool()
	if ( !bSunBeams ) then return end 
	
	local screen = vLightOrigin				-- The soon-to-be "sun" origin.
	local vNormal = screen - vEyeOrigin		-- Normal pointing from our view point towards the effect.
	
	-- Compute the dot product of the normal (essentially a floating point number that is positive if you look at it, negative when you don't).
	-- See http://wiki.garrysmod.com/page/Vector/Dot for details.
	local dot = ( vNormal:Dot( EyeVector() ) - 0.8 ) * 5
	if ( dot <= 0 ) then return end -- Stop if we're facing away.

	-- The sunbeam effect requires you to be very, very far away
	screen = screen + ( vNormal * 16384 )
	
	-- Since the sunbeam effect is 2d, we're determing the position on screen, relateive to screen size to properly position the sun effect.
	screen = screen:ToScreen()
	
	local w, h = ScrW(), ScrH()
	local glowX, glowY = screen.x, screen.y
	
	-- Draw the sun effect. See /postprocessing/sunbeams.lua or http://wiki.garrysmod.com/page/Global/DrawSunbeams for details.
	DrawSunbeams( 0.85, 0.1 * fStrength, 0.04 - fStrength * 0.01, glowX / w, glowY / h )

end

--[[
Render the effect
--
Runs every frame as long as the effect lives.
--
Draw the parent with the original model and call the actual render function EFFECT.RenderOverlay().
]]--
function EFFECT:RenderParent()
	
	-- Draw the target entity.
	self:DrawModel()
	
	-- Draw the effect and pass the effect.
	self.SpawnEffect:RenderOverlay( self )

end