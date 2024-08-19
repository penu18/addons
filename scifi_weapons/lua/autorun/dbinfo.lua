include( "autorun/scifi_init.lua" )

local PANEL = {}

local color_bg_default		= Color( 150, 150, 150, 195 )
local color_bg_caption		= Color( 157, 160, 165, 75 ) --Color( 100, 100, 100, 180 )
local color_default			= Color( 150, 150, 150, 255 )
local color_default_2		= Color( 157, 160, 165, 255 ) --Color( 100, 100, 100, 180 )
local color_default_3		= Color( 117, 120, 125, 255 )
local color_default_opaq	= Color( 80, 80, 80, 180 )
local color_highlight		= Color( 220, 220, 220, 255 )

function PANEL:Init()

--	local w, h = self:GetSize()

	self:SetTitle( "SciFiWeapons - Update 17 'Obsidian Skies' (v17.1.0)" )
--	self:InvalidateLayout( true )
	self:SetSize( ScrW() * 0.4, ScrH() * 0.82 ) --( 720, 405 )
--	self:SetSizable( true )
--	self:SetPaintShadow( true )
	self:SetPos( ScrW() * 0.01, ScrH() * 0.05 )
	
	self.btnClose:SetDisabled( false )
	self.btnClose.Paint = function( panel, w, h ) draw.RoundedBox( 6, -1, 4, w * 1.05, h * 0.4, Color( 200, 20, 40, 255 ) ) end
	
	self.btnMaxim:SetDisabled( true )
	self.btnMaxim.Paint = function( panel, w, h )  end
	
	self.btnMinim:SetDisabled( true )
	self.btnMinim.Paint = function( panel, w, h )  end
	
	local sheet = vgui.Create( "DPropertySheet", self )	
	sheet.Paint = function( self, w, h ) draw.RoundedBox( 6, 0, 22, w, h - 22, color_default_2 ) end
	self.ContentPanel = sheet
	self.ContentPanel:InvalidateLayout( true )
	self.ContentPanel:Dock( FILL )
	self.ContentPanel:Center()
	
	local panel1 = vgui.Create( "DPanel", sheet )
	panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, color_default_2 ) end
	sheet:AddSheet( "Debug Settings", panel1, "icon16/computer.png" )

	local panel2 = vgui.Create( "DPanel", sheet )
	panel2.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, color_default_2 ) end
	sheet:AddSheet( "Debug Graphics", panel2, "icon16/monitor_link.png" )

	local panel3 = vgui.Create( "DPanel", sheet )
	panel3.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, color_default_2 ) end
	sheet:AddSheet( "Engine Graphics", panel3, "icon16/color_wheel.png" )
	
	local spanel1 = vgui.Create( "DScrollPanel", panel1 )
	spanel1:SetParent( panel1 )
	spanel1:SetSize( 700, 360 )
	spanel1:InvalidateLayout( true )
	spanel1:Dock( FILL )
	spanel1:Center()

	local offset = 8

	local dcbox0 = vgui.Create( "DCheckBoxLabel" )
	dcbox0:SetParent( spanel1 )
	dcbox0:SetPos( 16, offset )
	dcbox0:SetText( "Show animation scaling." )
	dcbox0:SetConVar( "sfw_debug_showanimscaling" )
	dcbox0:SizeToContents()
	offset = offset + 20

	local dcbox1 = vgui.Create( "DCheckBoxLabel" )
	dcbox1:SetParent( spanel1 )
	dcbox1:SetPos( 16, offset )
	dcbox1:SetText( "Force delta-timed interpolation speed for basic, scripted viewmodel animations (i.e. sprint, ads, etc...)." )
	dcbox1:SetConVar( "sfw_allow_adsdeltaanim" )
	dcbox1:SizeToContents()
	offset = offset + 20
		
	local dcbox2 = vgui.Create( "DCheckBoxLabel" )
	dcbox2:SetParent( spanel1 )
	dcbox2:SetPos( 16, offset )
	dcbox2:SetText( "Show current mouse/keyboard input on the screen." )
	dcbox2:SetConVar( "sfw_debug_kbinfo" )
	dcbox2:SizeToContents()
	offset = offset + 20	
	
	local dcbox3 = vgui.Create( "DCheckBoxLabel" )
	dcbox3:SetParent( spanel1 )
	dcbox3:SetPos( 16, offset )
	dcbox3:SetText( "Disable automatic weapon pickup." )
	dcbox3:SetConVar( "sfw_debug_preventautoequip" )
	dcbox3:SizeToContents()
	offset = offset + 20

	local dcbox5 = vgui.Create( "DCheckBoxLabel" )
	dcbox5:SetParent( spanel1 )
	dcbox5:SetPos( 16, offset )
	dcbox5:SetText( "Enable advanced damage effectivities." )
	dcbox5:SetConVar( "sfw_allow_advanceddamage" )
	dcbox5:SizeToContents()
	offset = offset + 20
	
	local dcbox7 = vgui.Create( "DCheckBoxLabel" )
	dcbox7:SetParent( spanel1 )
	dcbox7:SetPos( 16, offset )
	dcbox7:SetText( "Force projectiles to use the old death event." )
	dcbox7:SetConVar( "sfw_debug_legacydeathevent" )
	dcbox7:SizeToContents()
	offset = offset + 20
	
	local dcbox8 = vgui.Create( "DCheckBoxLabel" )
	dcbox8:SetParent( spanel1 )
	dcbox8:SetPos( 16, offset )
	dcbox8:SetText( "Force projectiles to cause xplode events OnTrigger/OnTouch instead of or in addition to OnCollision." )
	dcbox8:SetConVar( "sfw_debug_forcenewhitmechanic" )
	dcbox8:SizeToContents()
	offset = offset + 20
	
	local dcbox9 = vgui.Create( "DCheckBoxLabel" )
	dcbox9:SetParent( spanel1 )
	dcbox9:SetPos( 16, offset )
	dcbox9:SetText( "Enable stealth finisher damage for quick melee attacks (if those are available)." )
	dcbox9:SetConVar( "sfw_allow_stealthfinishers" )
	dcbox9:SizeToContents()
	offset = offset + 40
	
	local dDLabel_0 = vgui.Create( "DLabel", spanel1 )
	--DLabel_0:Center()
	dDLabel_0:SetPos( 166, offset )
	dDLabel_0:SetWrap( true )
	dDLabel_0:SetSize( 256, 52 )
	dDLabel_0:SetText( "Visualize damage ranges and damgage events. 1 = draw dmg ranges, 2 = show detailed info, 3 = print info into console." )
	offset = offset + 20
	
	local dsldr0 = vgui.Create( "DNumSlider", spanel1 )
	dsldr0:SetPos( -86, offset )
	dsldr0:SetSize( 250, 15 )
	dsldr0:SetMin( 0 )
	dsldr0:SetMax( 3 )
	dsldr0:SetDecimals( 0 )
	dsldr0:SetConVar( "sfw_debug_showdmgranges" )
	offset = offset + 40
	
	local dDLabel_1 = vgui.Create( "DLabel", spanel1 )
	--DLabel_0:Center()
	dDLabel_1:SetPos( 166, offset )
	dDLabel_1:SetWrap( true )
	dDLabel_1:SetSize( 256, 52 )
	dDLabel_1:SetText( "Show informations and visualizations about the elemental effect system. 1 = show ranges, 2 = print elemental info to console." )
	offset = offset + 20
	
	local dsldr1 = vgui.Create( "DNumSlider", spanel1 )
	dsldr1:SetPos( -86, offset )
	dsldr1:SetSize( 250, 15 )
	dsldr1:SetMin( 0 )
	dsldr1:SetMax( 2 )
	dsldr1:SetDecimals( 0 )
	dsldr1:SetConVar( "sfw_debug_showemlinfo" )
	offset = offset + 40
	
	local dcbox6 = vgui.Create( "DCheckBoxLabel" )
	dcbox6:SetParent( spanel1 )
	dcbox6:SetPos( 16, offset )
	dcbox6:SetText( "Campaign mode (required for the below to work)" )
	dcbox6:SetConVar( "vh_campaign" )
	dcbox6:SizeToContents()
	offset = offset + 20
	
	local WTextLabel = vgui.Create( "DLabel", spanel1 )
	--DLabel_0:Center()
	WTextLabel:SetPos( 16, offset )
	WTextLabel:SetWrap( true )
	WTextLabel:SetSize( 512, 32 )
	WTextLabel:SetText( "Add a weapon to default loadout (ToDo: Improve!)" )
	offset = offset + 30
	
	local WTextEntry = vgui.Create( "DTextEntry", spanel1 )
	WTextEntry:SetPos( 16, offset )
	WTextEntry:SetSize( 256, 20 )
	WTextEntry:SetText( "" )
	WTextEntry.OnEnter = function( self )
		RunConsoleCommand( "vh_campaign_loadout", "add", self:GetValue() )
	end
	offset = offset + 40
	
	local DButton = vgui.Create( "DButton", spanel1 )
	DButton:SetPos( 16, offset )
	DButton:SetText( "Print current Loadout protocol into console." )
	DButton:SetSize( 140, 20 )
	DButton.DoClick = function()
		RunConsoleCommand( "vh_campaign_loadout", "print" )
	end
	offset = offset + 30
	
	local DButton = vgui.Create( "DButton", spanel1 )
	DButton:SetPos( 16, offset )
	DButton:SetText( "Clear Loadout Protocol" )
	DButton:SetSize( 140, 20 )
	DButton.DoClick = function()
		RunConsoleCommand( "vh_campaign_loadout", "clear" )
	end
	offset = offset + 30

	local btn_disarm = vgui.Create( "DButton", spanel1 )
	btn_disarm:SetPos( 16, offset )
	btn_disarm:SetText( "Disarm player" )
	btn_disarm:SetSize( 140, 20 )
	btn_disarm.DoClick = function()
		RunConsoleCommand( "vh_campaign_removegear" )
	end
	offset = offset + 30
	
	local dcbox6 = vgui.Create( "DCheckBoxLabel" )
	dcbox6:SetParent( spanel1 )
	dcbox6:SetPos( 16, offset )
	dcbox6:SetText( "Automatically add recently picked up weapons to the loadout." )
	dcbox6:SetConVar( "vh_campaign_loadout_autocompose" )
	dcbox6:SizeToContents()
	offset = offset + 20
			
	function spanel1:Paint( w, h )
	--	draw.RoundedBox( 3, 0, 0, w, h, color_default_opaq )
	end

	local spanel2 = vgui.Create( "DScrollPanel", panel2 )
	spanel2:SetParent( panel2 )
	spanel2:SetSize( 700, 360 )
	spanel2:InvalidateLayout( true )
	spanel2:Dock( FILL )
	spanel2:Center()
	
	offset = 8
	
	local Pan2Label0 = vgui.Create( "DLabel", spanel2 )
	Pan2Label0:SetPos( 8, offset )
	Pan2Label0:SetWrap( true )
	Pan2Label0:SetSize( 128, 16 )
	Pan2Label0:SetText( "Particles and VFX" )
	offset = offset + 20
	
	local Pan2CBox0 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox0:SetParent( spanel2 )
	Pan2CBox0:SetPos( 16, offset )
	Pan2CBox0:SetText( "Allow expensive particles (note, that some entities don't have cheap particles to fall back to. \nThe expensive one will be used instead.)" )
	Pan2CBox0:SetConVar( "sfw_fx_particles" )
	Pan2CBox0:SizeToContents()
	offset = offset + 30
	
	local Pan2CBox15 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox15:SetParent( spanel2 )
	Pan2CBox15:SetPos( 16, offset )
	Pan2CBox15:SetText( "Enable individual sunbeam effects. This may cause issues with other post-processing effects that use multiply render-target hooks." )
	Pan2CBox15:SetConVar( "sfw_fx_individualsunbeams" )
	Pan2CBox15:SizeToContents()
	offset = offset + 30

	local Pan2CBox1 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox1:SetParent( spanel2 )
	Pan2CBox1:SetPos( 16, offset )
	Pan2CBox1:SetText( "Create heat/gunsmoke particles." )
	Pan2CBox1:SetConVar( "sfw_fx_heat" )
	Pan2CBox1:SizeToContents()
	offset = offset + 25

	local Pan2CBox3 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox3:SetParent( spanel2 )
	Pan2CBox3:SetPos( 16, offset )
	Pan2CBox3:SetText( "Force generic muzzle effects to be spawned and handled completely clientside, avoiding any prediction." )
	Pan2CBox3:SetConVar( "sfw_fx_forceclientmuzzle" )
	Pan2CBox3:SizeToContents()
	offset = offset + 20

	local Pan2CBox16 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox16:SetParent( spanel2 )
	Pan2CBox16:SetPos( 16, offset )
	Pan2CBox16:SetText( "Adds cinematic flare effects to all scifi muzzle flashes. Will have an impact on performance and shouldn't be used if you have a large number of scifi weapons active and in use at a time." )
	Pan2CBox16:SetConVar( "sfw_fx_cinematicmuzzles" )
	Pan2CBox16:SizeToContents()
	offset = offset + 20

	local Pan2CBox4 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox4:SetParent( spanel2 )
	Pan2CBox4:SetPos( 16, offset )
	Pan2CBox4:SetText( "Prevent muzzle effects from spawning while aiming down sights." )
	Pan2CBox4:SetConVar( "sfw_fx_suppressonzoom" )
	Pan2CBox4:SizeToContents()
	offset = offset + 20
	
	local Pan2Slider1Label = vgui.Create( "DLabel", spanel2 )
	--DLabel_0:Center()
	Pan2Slider1Label:SetPos( 166, offset )
	Pan2Slider1Label:SetWrap( true )
	Pan2Slider1Label:SetSize( 256, 52 )
	Pan2Slider1Label:SetText( "Maximum amount of expensive particle systems that can be spawned by the EML system." )
	offset = offset + 20
	
	local Pan2Slider1 = vgui.Create( "DNumSlider", spanel2 )
	Pan2Slider1:SetPos( -86, offset )
	Pan2Slider1:SetSize( 250, 15 )
	Pan2Slider1:SetMin( 0 )
	Pan2Slider1:SetMax( 64 )
	Pan2Slider1:SetDecimals( 0 )
	Pan2Slider1:SetConVar( "sfw_fx_maxexpensive" )
	offset = offset + 40
	
	local Pan2Label1 = vgui.Create( "DLabel", spanel2 )
	Pan2Label1:SetPos( 8, offset )
	Pan2Label1:SetWrap( true )
	Pan2Label1:SetSize( 128, 16 )
	Pan2Label1:SetText( "Lightning" )
	offset = offset + 20

	local Pan2CBox5 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox5:SetParent( spanel2 )
	Pan2CBox5:SetPos( 16, offset )
	Pan2CBox5:SetText( "SciFi Entities (usually projectiles) emit light." )
	Pan2CBox5:SetConVar( "sfw_fx_lightemission" )
	Pan2CBox5:SizeToContents()
	offset = offset + 20

	local Pan2CBox6 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox6:SetParent( spanel2 )
	Pan2CBox6:SetPos( 16, offset )
	Pan2CBox6:SetText( "Force light emission to be accomplished the old way \nby spawning and parenting a secondary lighting entity (light_dynamic)." )
	Pan2CBox6:SetConVar( "sfw_fx_lightemission_force_legacy" )
	Pan2CBox6:SizeToContents()
	offset = offset + 20
	
	local Pan2Slider0Label = vgui.Create( "DLabel", spanel2 )
	--DLabel_0:Center()
	Pan2Slider0Label:SetPos( 166, offset )
	Pan2Slider0Label:SetWrap( true )
	Pan2Slider0Label:SetSize( 256, 52 )
	Pan2Slider0Label:SetText( "Projected texture lightning. 0 = Disable all, 1 = Determined by entity, 2 = Force all." )
	offset = offset + 20
	
	local Pan2Slider0 = vgui.Create( "DNumSlider", spanel2 )
	Pan2Slider0:SetPos( -86, offset )
	Pan2Slider0:SetSize( 250, 15 )
	Pan2Slider0:SetMin( 0 )
	Pan2Slider0:SetMax( 2 )
	Pan2Slider0:SetDecimals( 0 )
	Pan2Slider0:SetConVar( "sfw_fx_projexturelighting" )
	offset = offset + 40
	
	local Pan2Slider7Label = vgui.Create( "DLabel", spanel2 )
	--DLabel_0:Center()
	Pan2Slider7Label:SetPos( 166, offset )
	Pan2Slider7Label:SetWrap( true )
	Pan2Slider7Label:SetSize( 256, 52 )
	Pan2Slider7Label:SetText( "Muzzle flash lights. 0 = none, 1 = dynamic, 2 = projection (no shadows), 3 = projection" )
	offset = offset + 20

	local Pan2Slider7 = vgui.Create( "DNumSlider", spanel2 )
	Pan2Slider7:SetPos( -86, offset )
	Pan2Slider7:SetSize( 250, 15 )
	Pan2Slider7:SetMin( 0 )
	Pan2Slider7:SetMax( 3 )
	Pan2Slider7:SetDecimals( 0 )
	Pan2Slider7:SetConVar( "sfw_fx_muzzlelights" )
	offset = offset + 40

	local Pan2CBox7 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox7:SetParent( spanel2 )
	Pan2CBox7:SetPos( 16, offset )
	Pan2CBox7:SetText( "Enable light emission (clientside) for burning entities. \nThis rule is applied global and WILL have an impact on performance when you have a lot of burning gibs around." )
	Pan2CBox7:SetConVar( "sfw_allow_firelightemission" )
	Pan2CBox7:SizeToContents()
	offset = offset + 40
	
	local Pan2Label2 = vgui.Create( "DLabel", spanel2 )
	Pan2Label2:SetPos( 8, offset )
	Pan2Label2:SetWrap( true )
	Pan2Label2:SetSize( 128, 16 )
	Pan2Label2:SetText( "LightFlare and fake bloom" )
	offset = offset + 20
	
	local DScrollPanel = vgui.Create( "DScrollPanel", panel3 )
	DScrollPanel:SetParent( panel3 )
	DScrollPanel:SetSize( 700, 360 )
	DScrollPanel:InvalidateLayout( true )
	DScrollPanel:Dock( FILL )
	DScrollPanel:Center()

	local Pan2CBox8 = vgui.Create( "DCheckBoxLabel" )
	Pan2CBox8:SetParent( spanel2 )
	Pan2CBox8:SetPos( 16, offset )
	Pan2CBox8:SetText( "Enable sprites. (required for LightFlare to work)" )
	Pan2CBox8:SetConVar( "sfw_fx_sprites" )
	Pan2CBox8:SizeToContents()
	offset = offset + 20
	
	local Pan2Slider3Label = vgui.Create( "DLabel", spanel2 )
	--DLabel_0:Center()
	Pan2Slider3Label:SetPos( 166, offset )
	Pan2Slider3Label:SetWrap( true )
	Pan2Slider3Label:SetSize( 256, 52 )
	Pan2Slider3Label:SetText( "LightFlare bloom scale. This adjusts size as well as brightness / opacity." )
	offset = offset + 20
	
	local Pan2Slider3 = vgui.Create( "DNumSlider", spanel2 )
	Pan2Slider3:SetPos( -86, offset )
	Pan2Slider3:SetSize( 250, 15 )
	Pan2Slider3:SetMin( 0 )
	Pan2Slider3:SetMax( 32 )
	Pan2Slider3:SetDecimals( 1 )
	Pan2Slider3:SetConVar( "sfw_fx_bloomscale" )
	offset = offset + 40
	
	local choices = {
		[1] = { name = "Default", id = "-1" },
		[2] = { name = "Garry-style", id = "1" },
		[3] = { name = "Cinematic", id = "2" }
	}
	
	local Pan2ComBox0Label = vgui.Create( "DLabel", spanel2 )
	Pan2ComBox0Label:SetPos( 166, offset )
	Pan2ComBox0Label:SetWrap( true )
	Pan2ComBox0Label:SetSize( 256, 52 )
	Pan2ComBox0Label:SetText( "LightFlare bloom style. This is the texture referred to when rendering LightFlare. \nNote, that entities can override the bloom style choices." )
	offset = offset + 20
	
	local Pan2ComBox0 = vgui.Create( "DComboBox" )
	Pan2ComBox0:SetPos( 16, offset )
	Pan2ComBox0:SetSize( 128, 20 )
	Pan2ComBox0:SetParent( spanel2 )
	Pan2ComBox0:SetValue( choices[math.abs(GetConVarNumber( "sfw_fx_bloomstyle" ))].name )
	Pan2ComBox0:AddChoice( choices[1].name )
	Pan2ComBox0:AddChoice( choices[2].name )
	Pan2ComBox0:AddChoice( choices[3].name )
	Pan2ComBox0.OnSelect = function( panel, index, value )
	print( index )
		RunConsoleCommand( "sfw_fx_bloomstyle", choices[index].id )
	end
	
--	function DScrollPanel:Paint( w, h )
	--	draw.RoundedBox( 3, 0, 0, w, h, color_default_opaq )
--	end
	
	local DLabel_0 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_0:SetPos( 10, 0 )
	DLabel_0:SetWrap( true )
	DLabel_0:SetText( "CPU handling" )
	
	local cbox0 = vgui.Create( "DCheckBoxLabel" )
	cbox0:SetParent( DScrollPanel )
	cbox0:SetPos( 25, 25 )
	cbox0:SetText( "Multi-core CPU support (Experimental!)" )
	cbox0:SetConVar( "gmod_mcore_test" )
	cbox0:SizeToContents()

	local cbox1 = vgui.Create( "DCheckBoxLabel" )
	cbox1:SetParent( DScrollPanel )
	cbox1:SetPos( 25, 45 )
	cbox1:SetText( "Shadow manager in multiple threads" )
	cbox1:SetConVar( "r_threaded_client_shadow_manager" )
	cbox1:SizeToContents()
	
	local cbox2 = vgui.Create( "DCheckBoxLabel" )
	cbox2:SetParent( DScrollPanel )
	cbox2:SetPos( 25, 65 )
	cbox2:SetText( "Rendering in multiple threads" )
	cbox2:SetConVar( "r_threaded_renderables" )
	cbox2:SizeToContents()	
	
	local cbox3 = vgui.Create( "DCheckBoxLabel" )
	cbox3:SetParent( DScrollPanel )
	cbox3:SetPos( 25, 85 )
	cbox3:SetText( "Multi thread particle computation" )
	cbox3:SetConVar( "r_threaded_particles" )
	cbox3:SizeToContents()	
	
	local cbox4 = vgui.Create( "DCheckBoxLabel" )
	cbox4:SetParent( DScrollPanel )
	cbox4:SetPos( 25, 105 )
	cbox4:SetText( "Multi thread bone setup" )
	cbox4:SetConVar( "cl_threaded_bone_setup" )
	cbox4:SizeToContents()	
	
	local cbox5 = vgui.Create( "DCheckBoxLabel" )
	cbox5:SetParent( DScrollPanel )
	cbox5:SetPos( 25, 125 )
	cbox5:SetText( "Multi thread leaf system (client)" )
	cbox5:SetConVar( "cl_threaded_client_leaf_system" )
	cbox5:SizeToContents()
	
	local DLabel_1 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_1:SetPos( 10, 160 )
	DLabel_1:SetSize( 200, 15 )
	DLabel_1:SetWrap( false )
	DLabel_1:SetText( "Materials and texture handling" )
	
	local sldr0 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr0:SetPos( 25, 185 )
	sldr0:SetSize( 250, 15 )
	sldr0:SetText( "Material queue mode" )
	sldr0:SetMin( -1 )
	sldr0:SetMax( 2 )
	sldr0:SetDecimals( 0 )
	sldr0:SetConVar( "mat_queue_mode" )
	
	local DLabel_2 = vgui.Create( "DLabel", DScrollPanel )
	DLabel_2:SetPos( 260, 185 )
	DLabel_2:SetSize( 400, 15 )
	DLabel_2:SetWrap( false )
	DLabel_2:SetText( "(-1 = default, 0 = synchronous single thread, 2 = queued multithreaded)" )
	
	local cbox6 = vgui.Create( "DCheckBoxLabel" )
	cbox6:SetParent( DScrollPanel )
	cbox6:SetPos( 25, 205 )
	cbox6:SetText( "Auto. precache textures" )
	cbox6:SetConVar( "mat_loadtextures" )
	cbox6:SizeToContents()
	
	local DLabel_3 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_3:SetPos( 10, 240 )
	DLabel_3:SetSize( 200, 15 )
	DLabel_3:SetWrap( false )
	DLabel_3:SetText( "Bloom effects" )
	
	local cbox7 = vgui.Create( "DCheckBoxLabel" )
	cbox7:SetParent( DScrollPanel )
	cbox7:SetPos( 25, 265 )
	cbox7:SetText( "Force bloom effect" )
	cbox7:SetConVar( "mat_force_bloom" )
	cbox7:SizeToContents()
	
	local sldr1 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr1:SetPos( 25, 290 )
	sldr1:SetSize( 250, 15 )
	sldr1:SetText( "Bloom effect scale (may not have a visible effect on some HDR maps)" )
	sldr1:SetMin( 0.1 )
	sldr1:SetMax( 32 )
	sldr1:SetDecimals( 1 )
	sldr1:SetConVar( "mat_bloomscale" )
	
	local sldr2 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr2:SetPos( 25, 315 )
	sldr2:SetSize( 250, 15 )
	sldr2:SetText( "Scalar factor" )
	sldr2:SetMin( 0.1 )
	sldr2:SetMax( 16 )
	sldr2:SetDecimals( 2 )
	sldr2:SetConVar( "mat_bloom_scalefactor_scalar" )
	
	local sldr3 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr3:SetPos( 25, 340 )
	sldr3:SetSize( 250, 15 )
	sldr3:SetText( "Bloom tint exponent" )
	sldr3:SetMin( 0.01 )
	sldr3:SetMax( 64 )
	sldr3:SetDecimals( 2 )
	sldr3:SetConVar( "r_bloomtintexponent" )
	
	local DLabel_4 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_4:SetPos( 10, 375 )
	DLabel_4:SetSize( 200, 15 )
	DLabel_4:SetWrap( false )
	DLabel_4:SetText( "Gamma, brightness and contrast" )
	
	local sldr4 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr4:SetPos( 25, 400 )
	sldr4:SetSize( 250, 15 )
	sldr4:SetText( "Monitor Gamma" )
	sldr4:SetMin( 1.6 )
	sldr4:SetMax( 2.6 )
	sldr4:SetDecimals( 1 )
	sldr4:SetConVar( "mat_monitorgamma" )
	
	local cbox8 = vgui.Create( "DCheckBoxLabel" )
	cbox8:SetParent( DScrollPanel )
	cbox8:SetPos( 25, 425 )
	cbox8:SetText( "Advanced monitor gamma (TV-Gamma)" )
	cbox8:SetConVar( "mat_monitorgamma_tv_enabled" )
	cbox8:SizeToContents()
	
	local sldr5 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr5:SetPos( 25, 450 )
	sldr5:SetSize( 250, 15 )
	sldr5:SetText( "Gamma" )
	sldr5:SetMin( 1 )
	sldr5:SetMax( 5 )
	sldr5:SetDecimals( 1 )
	sldr5:SetConVar( "mat_monitorgamma_tv_exp" )
	
	local sldr6 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr6:SetPos( 25, 475 )
	sldr6:SetSize( 250, 15 )
	sldr6:SetText( "Maximum brightness" )
	sldr6:SetMin( 100 )
	sldr6:SetMax( 300 )
	sldr6:SetDecimals( 0 )
	sldr6:SetConVar( "mat_monitorgamma_tv_range_max" )
	
	local sldr7 = vgui.Create( "DNumSlider", DScrollPanel )
	sldr7:SetPos( 25, 500 )
	sldr7:SetSize( 250, 15 )
	sldr7:SetText( "Contrast range" )
	sldr7:SetMin( -64 )
	sldr7:SetMax( 64 )
	sldr7:SetDecimals( 1 )
	sldr7:SetConVar( "mat_monitorgamma_tv_range_min" )
	
	local DLabel_4 = vgui.Create( "DLabel", DScrollPanel )
	--DLabel_0:Center()
	DLabel_4:SetPos( 10, 535 )
	DLabel_4:SetSize( 200, 15 )
	DLabel_4:SetWrap( false )
	DLabel_4:SetText( "Misc. and performance options" )
	
	local cbox9 = vgui.Create( "DCheckBoxLabel" )
	cbox9:SetParent( DScrollPanel )
	cbox9:SetPos( 25, 560 )
	cbox9:SetText( "Enable/Disable specularity. Will cause a material reload upon change." )
	cbox9:SetConVar( "mat_specular" )
	cbox9:SizeToContents()
	
	local cbox10 = vgui.Create( "DCheckBoxLabel" )
	cbox10:SetParent( DScrollPanel )
	cbox10:SetPos( 25, 585 )
	cbox10:SetText( "Enable/Disable shadows being rendered to textures. This may conflict with other addons/shaders." )
	cbox10:SetConVar( "r_shadowrendertotexture" )
	cbox10:SizeToContents()
	
	local DComboBox = vgui.Create( "DComboBox" )
	DComboBox:SetPos( 25, 610 )
	DComboBox:SetSize( 128, 20 )
	DComboBox:SetParent( DScrollPanel )
	DComboBox:SetValue( GetConVarNumber( "r_flashlightdepthres" ) )
	DComboBox:AddChoice( 64 )
	DComboBox:AddChoice( 128 )
	DComboBox:AddChoice( 256 )
	DComboBox:AddChoice( 512 )
	DComboBox:AddChoice( 1024 )
	DComboBox:AddChoice( 2048 )
	DComboBox:AddChoice( 4096 )
	DComboBox.OnSelect = function( panel, index, value )
	RunConsoleCommand( "r_flashlightdepthres", value )
	end
	
	local DLabel_5 = vgui.Create( "DLabel", DScrollPanel )
	DLabel_5:SetPos( 160, 610 )
	DLabel_5:SetSize( 400, 15 )
	DLabel_5:SetWrap( false )
	DLabel_5:SetText( "Projected texture resolution (as seen with flashlights, lamps, etc.)" )
	
	local cbox0 = vgui.Create( "DCheckBoxLabel" )
	cbox0:SetParent( DScrollPanel )
	cbox0:SetPos( 25, 640 )
	cbox0:SetText( "Force postprocess in one pass. Disabling this may cause PP to desynch." )
	cbox0:SetConVar( "mat_postprocessing_combine" )
	cbox0:SizeToContents()
	
	local DLabel_99 = vgui.Create( "DLabel", DScrollPanel )
	DLabel_99:SetPos( 10, 680 )
	DLabel_99:SetSize( 30, 30 )
	DLabel_99:SetWrap( false )
	DLabel_99:SetText( "" )
	
end

function PANEL:Paint( w, h )


	draw.RoundedBox( 6, 0, 0, w, h, color_bg_caption )
	draw.RoundedBox( 6, 4.6, 30, w - 10, h - 35, color_default_3 )
	
--	draw.RoundedBoxEx( 6, 0, 0, w, h * 0.0625, color_bg_caption, true, true, false, false )
	
end

function PANEL:SwitchTo( name )

	self.ContentPanel:SwitchToName( name )
	
end

if ( CLIENT ) then

	local vguiExampleWindow = vgui.RegisterTable( PANEL, "DFrame" )

	local SciFiConPanel = nil

	concommand.Add( 

		"+sfw_debug_ui", 
		
		function( player, command, arguments, args )
			if ( IsValid( SciFiConPanel ) ) then
				SciFiConPanel:Remove()
			return end
			SciFiConPanel = vgui.CreateFromTable( vguiExampleWindow )
			SciFiConPanel:SwitchTo( args )
			SciFiConPanel:MakePopup()
			--SciFiConPanel:Center()
		end, 
		nil, 
		"", 
		{ FCVAR_DONTRECORD } 
	)

	concommand.Add( 

		"-sfw_debug_ui", 
		
		function( player, command, arguments, args )
			if ( IsValid( SciFiConPanel ) ) then
				for k,v in pairs( SciFiConPanel:GetChildren() ) do
					if ( IsValid( v ) ) then
						v:Remove()
					end
				end
				SciFiConPanel:Remove()
			end
		end, 
		nil, 
		"", 
		{ FCVAR_DONTRECORD } 
	)
	
end