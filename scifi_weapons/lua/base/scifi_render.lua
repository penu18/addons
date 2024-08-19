--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v18 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Render functions and modular weapon models.			--
-- Kit-bashed weapon models and SCK components.					--
-- All scifi weapons derive information from this base.			--
-- Note, that a weapon can override a derived function.			--
------------------------------------------------------------------
-- Is included by scifi_base.lua								--
------------------------------------------------------------------
-- 				Uses SWEP Construction Kit by Clavus			--
------------------------------------------------------------------

AddCSLuaFile()

SCIFI_INTEGRITY_FLAG_RENDER = 20210727213519

local m_Abs 					= math.abs
local m_Round 					= math.Round
local m_Clamp 					= math.Clamp
local m_AngleDifference 		= math.AngleDifference

local iCompile, iInputLength, sCompile, sInput, tBuffer, iOutput

local SCIFI_SCK_TYPE_MODEL = 0
local SCIFI_SCK_TYPE_SPRITE = 1
local SCIFI_SCK_TYPE_LASER = 2
local SCIFI_SCK_TYPE_QUAD = 3

local function CreateID( sInput )
	if ( !sInput ) then
		return 0
	end

	sInput = tostring( sInput )
	iInputLength = string.len( sInput ) 
	 
	tBuffer = {} 
	
	for iPos=1, iInputLength do 
		local char = string.byte( sInput, iPos, iPos ) 
		tBuffer[ iPos ] = char
	end
	
	sCompile = table.concat( tBuffer )
	
	iCompile = util.StringToType( sCompile, "int" )
	iOutput = bit.tobit( iCompile )
	
	return iOutput
end

local cmd_dxlevel = GetConVar( "mat_dxlevel" )
local cmd_allowsck = GetConVar( "sfw_allow_sck" )

function SWEP:sckInit()
-- print("attempting to initialize sck", self)
	if ( !self.UseSCK ) then return end
	
	if ( CLIENT && system.IsWindows() && GetConVar( "mat_dxlevel" ):GetInt() < 95 ) then
		print( "@SciFiWeapons : !Error; Engine not running on required DirectX backend. Update your graphics drivers." )
	end

	local bSckInit = cmd_allowsck:GetBool()
	if ( !bSckInit ) then return end

	if ( CLIENT ) then
		-- print(self, self.VElements)
		self:CreateModels( self.VElements )
		self:CreateModels( self.WElements )
		-- self:DrawShadow( false )
		
		if ( IsValid( self.Owner ) && self.Owner:IsPlayer() ) then
			local vm = self.Owner:GetViewModel()
			if ( IsValid(vm) ) then
				self:ResetBonePositions( vm )
				
				if ( self.ShowViewModel == false ) then
					vm:SetColor( Color( 255, 255, 255, 0 ) )
					vm:SetMaterial( "Debug/hsv" )			
				end
			end
		end
		
		self.SckInitalized = true
	end

end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetTexture( self.WepSelectIcon )

	y = y + 10
	x = x + 50
	wide = wide / 2

	surface.DrawTexturedRect( x, y,	wide, wide )

	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )

end

function SWEP:SciFiCustomHud( vmEntity, entPlayer, entWeapon )

end

function SWEP:sckDestroy()

	if ( CLIENT ) then
		if ( self.VElements ) then
			for k, v in pairs( self.VElements ) do
				if ( v.modelEnt ) then
					v.modelEnt:Remove()
				end
			end
			
			self.SckInitalized = false
		end
		
		if ( self.WElements ) then
			for k, v in pairs( self.WElements ) do
				if ( v.modelEnt ) then
					v.modelEnt:Remove()
				end
			end
		end
	end
	
end

function SWEP:ResetDeployment()
	
	local cmd_rpworkaround = GetConVar( "sfw_rp_disownondrop" )
	
	if ( cmd_rpworkaround:GetBool() ) then 
		self:SetOwner( NULL )
	end

	local wOwner = self.Owner 

	if ( !wOwner || !IsValid( wOwner ) ) then
		wOwner = self.LastOwner
		
		if ( SERVER ) && ( wOwner && wOwner:IsPlayer() ) then
			net.Start( "SciFiUpdateOwnership" )
			net.WriteEntity( wOwner )
			net.Send( wOwner )
		end
	end

	self:SetAds( false )
	self:EmitSound( "BaseGrenade.StopSounds" )

	if ( IsValid( wOwner ) && CLIENT && wOwner:IsPlayer() ) then
		local vm = wOwner:GetViewModel()

		if ( IsValid( vm ) ) then 
			vm:SetSubMaterial( 0, "" )
			vm:SetSubMaterial( 1, "" )
			vm:SetSubMaterial( 2, "" )
			vm:SetSubMaterial( 3, "" )
			vm:SetSubMaterial( 4, "" )
			
--			bSubMat = false
			
			self:ResetBonePositions( vm )
		end
	end

end

function SWEP:OnRemove()
	
	self:ResetDeployment()
	self:sckDestroy()
	
end

local cmd_ct_hboxscale = GetConVar( "sfw_debug_culltraces_hboxscale" )
local cmd_ct_falloffangle = GetConVar( "sfw_debug_culltraces_falloffangle" )
local cmd_noownershipmodel = GetConVar( "sfw_rp_forceworlmodelsentitybound" )

function SWEP:IsVisibleToLocalPlayer()

	local vis = true
	local vCam

	if ( SERVER ) then
		if ( IsValid( self.Owner ) ) then
			vCam = self.Owner:GetViewEntity()
		else
			return false
		end
	else
		vCam = GetViewEntity()
	end
	
	if ( !vCam ) then
		return false
	end
	
	if ( self.Owner == vCam ) then
		return true
	end

	local mins, maxs = self:GetCollisionBounds()
	local hboxscale = cmd_ct_hboxscale:GetFloat()
	
	mins = mins * hboxscale
	maxs = maxs * hboxscale
	
	local vOrigin = EyePos()
	local wOrigin = self:GetPos()
	
	local vData = {}
	local vResult = {}
	
	vData.start = wOrigin
	vData.endpos = vOrigin
	vData.mins = mins
	vData.maxs = maxs
	vData.filter = self
	vData.ignoreworld = false
	vData.output = vResult

	util.TraceHull( vData )

	if ( vResult.HitWorld ) then
		vis = false

		self:DrawShadow( vis )
		
		return vis
	end

	local angVCam = vCam:EyeAngles()
	local angTrace = vResult.Normal:Angle()
	
	local x = m_AngleDifference( angVCam.pitch, angTrace.pitch )
	local y = m_AngleDifference( angVCam.yaw, angTrace.yaw )
	local z = m_AngleDifference( angVCam.roll, angTrace.roll )
	x = m_Abs( x )
	y = m_Abs( y )
	z = m_Abs( z )
	
	local iFallOff = cmd_ct_falloffangle:GetInt()

	if ( x > iFallOff || y > iFallOff || z > iFallOff ) then
		vis = true
	else
		vis = false
	end
	
	self:DrawShadow( vis )

	return vis

end

if CLIENT then
	
	-- local csmodels = {}
	
	local rSuppressEngineLighting 	= render.SuppressEngineLighting
	local rPushFlashlightMode 		= render.PushFlashlightMode
	local rPopFlashlightMode 		= render.PopFlashlightMode
	local rSetColorModulation 		= render.SetColorModulation
	local rSetBlend 				= render.SetBlend
	local rSetMaterial 				= render.SetMaterial
	local rDrawBeam 				= render.DrawBeam
	local rDrawSprite 				= render.DrawSprite

	local cmd_sprites = GetConVar( "sfw_fx_sprites" ):GetBool()
	local cmd_projextureshadows = GetConVar( "sfw_fx_projexturemodelshadows" )
	local cmd_adsblur = GetConVar( "sfw_allow_adsblur" )
	local cmd_renderacc = GetConVar( "sfw_allow_renderacc" )
	local vmAngleDelayed = Angle( 0, 0, 0 )
	
	local vLaserTargetDirection = Vector( 0, 0, 0 )
	
	-- I'd love to you util.IsValidModel() at this point, but for some reason it doesn't properly work on client. --
	local function IsValidModelFile( model )
		if ( !isstring( model ) ) then 
			return false
		end
		
		if ( !string.find( model, ".mdl" ) ) then
			DevMsg( "@SciFiWeapons : !Error ; Failed to create model ('" .. model .. "'). Check file path? Have you added .mdl at the end?" )
			return false
		end
		
		if ( !file.Exists ( model, "GAME" ) ) then
			DevMsg( "@SciFiWeapons : !Error ; Failed create model, file not found. ('" .. model .."')." )
			return false
		end
		
		return true
	end
	
	local bIsAds, bAdsBlurred
	local fBlur, fSize, fAdsBlurScale = 0, 0, 0

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn( vm )
	-- PrintTable( csmodels )
		if ( !IsValid( self.Owner ) || !IsValid( self ) ) then 
			DevMsg( "@" .. self:GetClass() .. " : !Error; Failed to verify owner or weapon." ) 
			return 
		end

		if ( !IsValid( vm ) ) then return end
	
		bIsAds = ( self.SciFiState == SCIFI_STATE_ADS )
		if ( self.AdsBlur ) && ( cmd_adsblur:GetBool() ) then
			fBlur = self.AdsBlurIntensity * fAdsBlurScale
			fSize = self.AdsBlurSize * fAdsBlurScale
			
			if ( bIsAds ) then
				DrawToyTown( fBlur, fSize )

				if ( fAdsBlurScale == 1 ) then
					bAdsBlurred = true
				end
					
				if ( !bAdsBlurred ) then
					fAdsBlurScale = math.Approach( fAdsBlurScale, 1, FrameTime() * 6 )
				end
			else
				if ( fAdsBlurScale == 0 ) then
					bAdsBlurred = false
				end

				if ( bAdsBlurred ) then
					fAdsBlurScale = math.Approach( fAdsBlurScale, 0, FrameTime() * 8 )
				end
			end
		end
		
		if ( cmd_renderacc:GetBool() ) then
			self:AddAcc()
		end

--		if ( !bSubMat ) then
			vm:SetSubMaterial( 0, self.SciFiSkin )
			vm:SetSubMaterial( 1, self.SciFiSkin_1 )
			vm:SetSubMaterial( 2, self.SciFiSkin_2 )
			vm:SetSubMaterial( 3, self.SciFiSkin_3 )
			vm:SetSubMaterial( 4, self.SciFiSkin_4 )

--			bSubMat = true
--		end

		if ( !self.VElements ) then return end
		
		self:UpdateBonePositions( vm )

		if ( !self.vRenderOrder ) then
			self.vRenderOrder = {}

			local tSckData = self.VElements
--			local tRenderOrder = self.vRenderOrder 
			
			for k, v in pairs( tSckData ) do
--				tRenderOrder[ #tRenderOrder + 1 ] = k
				if ( isstring( v.type ) ) then
					DevMsg( "@" .. self:GetClass() .. " : !Error; Outdated SCK element data. Check your code." ) 
					continue
				end
				-- phase9 -- 
				-- if ( v.type == SCIFI_SCK_TYPE_MODEL ) then
					-- table.insert(self.vRenderOrder, 1, k)
				-- elseif ( v.type == SCIFI_SCK_TYPE_SPRITE || v.type == SCIFI_SCK_TYPE_QUAD || v.type == SCIFI_SCK_TYPE_LASER ) then
					-- table.insert(self.vRenderOrder, k)
				-- end
				-- print( k, v, v.type )
				if ( v.type == SCIFI_SCK_TYPE_MODEL ) then
					table.insert( self.vRenderOrder, 1, k )
					-- print( k, "model", 1 )
				else
					table.insert( self.vRenderOrder, #self.vRenderOrder + 1, k )
					-- print( k, "not model", #self.vRenderOrder + 1 )
				end
			end
		end

		for k, name in ipairs( self.vRenderOrder ) do
			local v = self.VElements[name]
			if ( !v ) then self.vRenderOrder = nil break end
			if ( v.hide ) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if ( !v.bone ) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if ( !pos ) then continue end
			
			if ( v.type == SCIFI_SCK_TYPE_MODEL && IsValid( model ) ) then

				if ( v.color.a ) && ( v.color.a < 1 ) then
					continue
				end
				
				local fw, rt, up = ang:Forward(), ang:Right(), ang:Up()

				local mOrigin = pos
				mOrigin = mOrigin + v.pos.x * fw
				mOrigin = mOrigin + v.pos.y * rt
				mOrigin = mOrigin + v.pos.z * up

				model:SetPos( mOrigin )
				
				local mAngles = ang
				mAngles:RotateAroundAxis( mAngles:Up(), v.angle.y )
				mAngles:RotateAroundAxis( mAngles:Right(), v.angle.p )
				mAngles:RotateAroundAxis( mAngles:Forward(), v.angle.r )

				model:SetAngles( mAngles )
		
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				--[[
				local iBones = model:GetBoneCount()
				if ( iBones > 1 ) then
					for i=0, iBones do
						model:ManipulateBoneScale( i, v.size )
					end
				else
					model:ManipulateBoneScale( 0, v.size )
				end
				]]--
				local mCurrent = model:GetMaterial()
				
				if ( v.material == "" || !v.material ) then
					model:SetMaterial("")
				elseif ( mCurrent != v.material ) then
					model:SetMaterial( v.material )
				end
			
				if ( v.submat && istable( v.submat ) ) then
					for i=0, #v.submat do
						if ( v.submat[ i ] ) then
							local sCurrent = model:GetSubMaterial( i )
							if ( sCurrent != v.submat[ i ] ) then
								model:SetSubMaterial( i, v.submat[ i ] )
							end
						end
					end
				end

				if ( v.skin && v.skin != model:GetSkin() ) then
					model:SetSkin(v.skin)
				end
				
				if ( v.bodygroup ) then
					for k, v in pairs( v.bodygroup ) do
						if ( model:GetBodygroup( k ) != v ) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if ( v.surpresslightning ) then
					rSuppressEngineLighting( true )
				end
				
				
				local colorbuffer = ( 1 / 255 )
				rSetColorModulation( v.color.r * colorbuffer, v.color.g * colorbuffer, v.color.b * colorbuffer )
				rSetBlend( v.color.a * colorbuffer )

				--model:SetRenderOrigin( pos )
				--model:SetRenderAngles( ang )
				
				model:DrawModel()
				
				if ( v.DrawShadow ) then
					model:CreateShadow()
				end

				if ( !v.surpresslightning ) && ( cmd_projextureshadows:GetBool() ) then
					rPushFlashlightMode( true )
					model:DrawModel()
					rPopFlashlightMode()
				end

				rSetBlend( 1 )
				rSetColorModulation( 1, 1, 1 )
				
				if (v.surpresslightning) then
					rSuppressEngineLighting( false )
				end
				
				model._adv_colours = false
				model._adv_colours_cache = false
				model._adv_colours_mats = false
				
			elseif ( v.type == SCIFI_SCK_TYPE_SPRITE && sprite ) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				rSetMaterial(sprite)
				rDrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif ( v.type == SCIFI_SCK_TYPE_QUAD && v.draw_func ) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				
				ang:RotateAroundAxis( ang:Up(), v.angle.y + 180 )
				ang:RotateAroundAxis( ang:Right(), v.angle.p )
				ang:RotateAroundAxis( ang:Forward(), v.angle.r + 180 )
				-- phase9 -- 
				cam.Start3D2D( drawpos, ang, v.size )
					-- print( "@scifi_render : Creating rendering context for quad '", k, "'", drawpos, ang, v.size )
	
	-- surface.SetDrawColor( 255, 0, 255, 255 )
	-- surface.DrawRect( 0, 0, 512, 512 ) 
					v.draw_func( self, drawpos, ang, v.size )
				cam.End3D2D()
				
			elseif ( v.type == SCIFI_SCK_TYPE_LASER ) then
				if ( v.disabled ) then continue end
			
				local laser_color1 = Color( v.color.r, v.color.g, v.color.b, 115)
				local laser_color2 = Color( v.color.r, v.color.g, v.color.b, 225)
				local laser_color3 = Color( v.color.r, v.color.g, v.color.b, 60)
				
				if ( !v.range ) then
					v.range = 8192
				end

				--local mObject = vm:LookupBone( v.bone )
				local mPosition, mAngles = pos, ang --vm:GetBonePosition( mObject )
				local mOffset = v.pos
				local fw, rt, up = mAngles:Forward(), mAngles:Right(),  mAngles:Up()
				
				mAngles:RotateAroundAxis( up, v.angle.y )
				mAngles:RotateAroundAxis( rt, v.angle.p )
				mAngles:RotateAroundAxis( fw, v.angle.r )
				
				local mDirection = mAngles:Forward()

				local mOrigin = mPosition + fw * mOffset.x + rt * mOffset.y + up * mOffset.z
				
				if ( v.NeverAutoFocus ) then
					vLaserTargetDirection = mDirection
				else
					-- local fSpeed = FrameTime() * 48
					if ( self:GetSciFiState() == SCIFI_STATE_ADS && !self.NeverAutoFocus ) then
						-- vLaserTargetDirection = LerpVector( fSpeed, vLaserTargetDirection, self.Owner:GetEyeTrace().HitPos )
						vLaserTargetDirection = EyeAngles():Forward()
					else
						-- vLaserTargetDirection = LerpVector( fSpeed, vLaserTargetDirection, lasertrace.HitPos )
						vLaserTargetDirection = mDirection
					end
				end
				
				local lasertrace = util.TraceLine( {
					start = mOrigin,
					endpos = mOrigin + mDirection * v.range,
					filter = function( ent ) if ( ent == self.Owner || ent:GetOwner() == self.Owner ) then return false else return true end end,
					mask = MASK_OPAQUE_AND_NPCS
				} )

				vmAngleDelayed = LerpAngle( 0.8, vmAngleDelayed, ang )
			--	vmAngleDelayed = mApproachAngle( vmAngleDelayed, ang, 0.4 )
				
				local lAngles = ang.pitch + ang.yaw + ang.roll
				local mDelayed = vmAngleDelayed.pitch + vmAngleDelayed.yaw + vmAngleDelayed.roll

				local mBlurRaw = m_Round( m_Abs( lAngles - mDelayed ) / 1, 2 )
				local mBlur = m_Clamp( mBlurRaw, 0, 4.2 ) + 1
				local mLength = 1 * ( lasertrace.Fraction * 10 )

				rSetMaterial( self.mat_laser_glow )
				rDrawSprite( lasertrace.StartPos, v.dot_size, v.dot_size, laser_color2 )
				if ( lasertrace.Hit && !lasertrace.HitSky ) then
					rDrawSprite( lasertrace.HitPos, v.dot_size, v.dot_size, laser_color2 )
				end
				
				if ( self.mat_laser_haze ) then
					rSetMaterial( self.mat_laser_haze )
					rDrawBeam( lasertrace.HitPos, lasertrace.HitPos - mDirection * 4 * v.dot_size, v.haze_size, 0, 1, laser_color1 )
				end
				
				if ( self.mat_laser_line ) then
					rSetMaterial( self.mat_laser_line )
					rDrawBeam( lasertrace.StartPos, lasertrace.HitPos, v.line_size * mBlur, 0, mLength, laser_color3 )
				end
			end
			
		end

	end

	local cmd_wmodel_culltracing = GetConVar( "sfw_debug_culltraces" ):GetBool()
	local cmd_wmodel_culldist = GetConVar( "cl_detaildist" ):GetInt()
	
	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		if ( self.debug_noworldmodels ) then
			return
		end
	
		if ( cmd_wmodel_culltracing ) && ( !self:IsVisibleToLocalPlayer() ) then
			return
		end
		
		if ( cmd_renderacc:GetBool() ) then
			self:AddWAcc()
		end
		
		-- local pOrigin, wOrigin = LocalPlayer():GetPos(), self:GetPos()
		-- if ( pOrigin:Distance( wOrigin ) > cmd_wmodel_culldist * 2 ) then
			-- return
		-- end

		if ( self.ShowWorldModel == nil || self.ShowWorldModel ) then
			self:DrawModel()
		end
		
		if ( self.SciFiWorld ) then
			self:SetMaterial( self.SciFiWorld )
		end

		if ( !self.WElements ) then return end
		
		if ( !self.wRenderOrder ) then
			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if ( v.type == SCIFI_SCK_TYPE_MODEL || v.type == SCIFI_SCK_TYPE_QUAD ) then
					table.insert(self.wRenderOrder, 1, k)
				elseif ( v.type == SCIFI_SCK_TYPE_SPRITE|| v.type == SCIFI_SCK_TYPE_LASER ) then
					table.insert(self.wRenderOrder, k)
				end
			end
		end
		
		local bone_ent
		if ( IsValid( self.Owner ) && !cmd_noownershipmodel:GetBool() ) then
			bone_ent = self.Owner
		else
			bone_ent = self
		end

		for k, name in pairs( self.wRenderOrder ) do
			local v = self.WElements[name]
			if ( !v ) then self.wRenderOrder = nil break end
			if ( v.hide ) then continue end
			
			local pos, ang
			
			if ( v.bone ) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end

			if ( !pos ) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial

			if ( v.type == SCIFI_SCK_TYPE_MODEL && IsValid( model ) ) then
				if ( v.color.a ) && ( v.color.a < 1 ) then
					continue
				end
				
				local fw, rt, up = ang:Forward(), ang:Right(), ang:Up()

				local mOrigin = pos
				mOrigin = mOrigin + v.pos.x * fw
				mOrigin = mOrigin + v.pos.y * rt
				mOrigin = mOrigin + v.pos.z * up

				model:SetPos( mOrigin )
				
				local mAngles = ang
				mAngles:RotateAroundAxis( mAngles:Up(), v.angle.y )
				mAngles:RotateAroundAxis( mAngles:Right(), v.angle.p )
				mAngles:RotateAroundAxis( mAngles:Forward(), v.angle.r )

				model:SetAngles( mAngles )
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				local mCurrent = model:GetMaterial()
				
				if ( v.material == "" || !v.material ) then
					model:SetMaterial("")
				elseif ( mCurrent != v.material ) then
					model:SetMaterial( v.material )
				end
			
				if ( v.submat && istable( v.submat ) ) then
					for i=0, #v.submat do
						if ( v.submat[ i ] ) then
							local sCurrent = model:GetSubMaterial( i )
							if ( sCurrent != v.submat[ i ] ) then
								model:SetSubMaterial( i, v.submat[ i ] )
							end
						end
					end
				end

				if ( v.skin && v.skin != model:GetSkin() ) then
					model:SetSkin(v.skin)
				end
				
				if ( v.bodygroup ) then
					for k, v in pairs( v.bodygroup ) do
						if ( model:GetBodygroup( k ) != v ) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if ( v.surpresslightning ) then
					rSuppressEngineLighting( true )
				end
				
				
				local colorbuffer = ( 1 / 255 )
				rSetColorModulation( v.color.r * colorbuffer, v.color.g * colorbuffer, v.color.b * colorbuffer )
				rSetBlend( v.color.a * colorbuffer )

				model:DrawModel()

				if ( !v.surpresslightning ) && ( cmd_projextureshadows:GetBool() ) then
					rPushFlashlightMode( true )
					model:DrawModel()
					rPopFlashlightMode()
				end

				rSetBlend( 1 )
				rSetColorModulation( 1, 1, 1 )
				
				if (v.surpresslightning) then
					rSuppressEngineLighting( false )
				end
				
				model._adv_colours = false
				model._adv_colours_cache = false
				model._adv_colours_mats = false
				
			elseif ( v.type == SCIFI_SCK_TYPE_SPRITE && sprite ) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				rSetMaterial(sprite)
				rDrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif ( v.type == SCIFI_SCK_TYPE_QUAD && v.draw_func ) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
				
			elseif ( v.type == SCIFI_SCK_TYPE_LASER ) && ( cmd_sprites ) then

				if ( v.disabled ) then continue end

				local laseralpha = v.color.a || 255
				local laser_color1 = Color( v.color.r, v.color.g, v.color.b, laseralpha * 0.45 )
				local laser_color2 = Color( v.color.r, v.color.g, v.color.b, laseralpha * 0.88 )
				local laser_color3 = Color( v.color.r, v.color.g, v.color.b, laseralpha * 0.24 )
				
				if ( !v.range ) then
					v.range = 8192
				end

				--local mObject = vm:LookupBone( v.bone )
				local mPosition, mAngles = pos, ang --vm:GetBonePosition( mObject )
				local mOffset = v.pos
				local fw, rt, up = mAngles:Forward(), mAngles:Right(),  mAngles:Up()
				
				mAngles:RotateAroundAxis( up, v.angle.y )
				mAngles:RotateAroundAxis( rt, v.angle.p )
				mAngles:RotateAroundAxis( fw, v.angle.r )
				
				local mDirection = mAngles:Forward()

				local mOrigin = mPosition + fw * mOffset.x + rt * mOffset.y + up * mOffset.z
				
				local lasertrace = util.TraceLine( {
					start = mOrigin,
					endpos = mOrigin + mDirection * v.range,
					filter = function( ent ) if ( ent == self.Owner || ent:GetOwner() == self.Owner ) then return false else return true end end,
					mask = MASK_OPAQUE_AND_NPCS
				} )

				local mLength = 1 * ( lasertrace.Fraction * 10 )

				rSetMaterial( self.mat_laser_glow )
				rDrawSprite( lasertrace.StartPos, v.dot_size, v.dot_size, laser_color2 )
				if ( lasertrace.Hit && !lasertrace.HitSky ) then
					rDrawSprite( lasertrace.HitPos, v.dot_size, v.dot_size, laser_color2 )
				end
				
				if ( self.mat_laser_haze ) then
					rSetMaterial( self.mat_laser_haze )
					rDrawBeam( lasertrace.HitPos, lasertrace.HitPos - mDirection * 4 * v.dot_size, v.haze_size, 0, 1, laser_color1 )
				end
				
				if ( self.mat_laser_line ) then
					rSetMaterial( self.mat_laser_line )
					rDrawBeam( lasertrace.StartPos, lasertrace.HitPos, v.line_size, 0, mLength, laser_color3 )
				end
			end
		end
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		local bone, pos, ang
		
		if ( tab.rel && tab.rel != "" && tab.rel != tab ) then
			local v = basetab[tab.rel]
			
			if ( !v ) then return end
			
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if ( !pos ) then return end

			pos = pos + v.pos.x * ang:Forward()
			pos = pos + v.pos.y * ang:Right()
			pos = pos + v.pos.z * ang:Up()
			
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)	
		else
			bone = ent:LookupBone(bone_override || tab.bone)

			if ( !bone ) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if ( m ) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if ( IsValid( self.Owner ) && self.Owner:IsPlayer() && ent == self.Owner:GetViewModel() && self.ViewModelFlip ) then
				ang.r = -ang.r
			end
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )
		if (!tab) then return end

		for k, v in pairs( tab ) do
			if ( v.type == SCIFI_SCK_TYPE_MODEL && v.model && v.model != "" && ( !IsValid( v.modelEnt ) || v.createdModel != v.model ) && IsValidModelFile( v.model ) ) then
				
				v.modelEnt = ClientsideModel( v.model, RENDERGROUP_VIEWMODEL_TRANSLUCENT )
				
				-- print( "@" .. self:GetClass() .. " : created " .. tostring( v.modelEnt ) )
				
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos( self:GetPos() )
					v.modelEnt:SetAngles( self:GetAngles() )
					v.modelEnt:SetParent( self )
					v.modelEnt:SetNoDraw( true )
					-- v.modelEnt:DrawShadow( true )
					v.createdModel = v.model
				
					v._adv_colours = false
					v._adv_colours_cache = false
					v._adv_colours_mats = false
				else
					v.modelEnt = nil
				end
				-- if ( v.modelEnt ) then
					-- csmodels[ #csmodels + 1 ] = v.modelEnt
				-- end
			elseif (v.type == SCIFI_SCK_TYPE_SPRITE && v.sprite && v.sprite != "" && (!v.spriteMaterial || v.createdSprite != v.sprite) 
				and file.Exists("materials/"..v.sprite..".vmt", "GAME") ) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
			end
		end
	end
	
	function SWEP:UpdateBonePositions(vm)
		if ( self.ViewModelBoneMods ) then
			if ( !vm:GetBoneCount() ) then return end
			
			local loopthrough = self.ViewModelBoneMods
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone( k )

				if ( !bone ) then continue end
				
				local vBoneScale = Vector( v.scale.x, v.scale.y, v.scale.z )
				local vBoneOrigin = Vector( v.pos.x, v.pos.y, v.pos.z )
				-- local ms = Vector( 1, 1, 1 )
				
				-- vBoneScale = vBoneScale * ms
				
				local vScaleCurrent = vm:GetManipulateBoneScale( bone )
				
				if ( vScaleCurrent != vBoneScale ) then
					vm:ManipulateBoneScale( bone, vBoneScale )
				end
				
				if ( vScaleCurrent != v.angle ) then
					vm:ManipulateBoneAngles( bone, v.angle )
				end

				if ( vScaleCurrent != vBoneOrigin ) then
					vm:ManipulateBonePosition( bone, vBoneOrigin )
				end
			end
		else
			self:ResetBonePositions( vm )
		end
	end
--[[
	local allbones = {}
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
			--	allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
]]--
	function SWEP:ResetBonePositions( vm )
	
		vm = vm || self.Owner:GetViewModel()
		
		if ( !IsValid( vm ) || !vm:GetBoneCount() ) then return end
		
		vm:SetPlaybackRate( 1 )
		
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
		if ( !IsValid( self.Owner )) then return end
		
		if ( self.WorldModelBoneMods ) then
			for i=0, self.Owner:GetBoneCount() do
				self.Owner:ManipulateBoneScale( i, Vector(1, 1, 1) )
				self.Owner:ManipulateBoneAngles( i, Angle(0, 0, 0) )
				self.Owner:ManipulateBonePosition( i, Vector(0, 0, 0) )
			end
		end
	end
	
end