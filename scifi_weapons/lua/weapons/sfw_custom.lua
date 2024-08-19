AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )
AddCSLuaFile( "base/scifi_techs.lua" )
include( "base/scifi_techs.lua" )
include( "weapons/sfw_pulsar.lua" )
include( "weapons/sfw_blizzard.lua" )
include( "weapons/sfw_phoenix.lua" )
include( "weapons/sfw_trace.lua" )
include( "weapons/sfw_thunderbolt.lua" )
include( "weapons/sfw_hellfire.lua" )
include( "weapons/sfw_storm.lua" )
include( "weapons/sfw_grinder.lua" )
include( "weapons/sfw_vapor.lua" )
include( "weapons/sfw_acidrain.lua" )
include( "weapons/sfw_cryon.lua" )
include( "weapons/sfw_neutrino.lua" )
include( "weapons/sfw_stinger.lua" )
include( "weapons/sfw_hwave.lua" )
include( "weapons/sfw_saphyre.lua" )
include( "weapons/sfw_seraphim.lua" )

SWEP.Purpose				= "An experimental technology which can adapt multiple different weapon systems at a time."
SWEP.Instructions			= "See Sci-Fi settings in the spawn menu to configure this weapon."

SWEP.Spawnable				= true
SWEP.AdminOnly				= true

SWEP.ViewModel				= GetConVarString( "sfw_cw_model" ) --"models/weapons/c_" .. GetConVarString( "sfw_cw_model" ) .. ".mdl" --This way is probably easier, but whatever...
SWEP.WorldModel				= "models/weapons/w_smg1.mdl" --"models/weapons/w_" .. GetConVarString( "sfw_cw_model" ) .. ".mdl"
SWEP.SciFiSkin				= ""
SWEP.SciFiSkin_1			= ""
SWEP.SciFiSkin_2			= ""
SWEP.SciFiSkin_3			= ""
SWEP.SciFiSkin_4			= ""

SWEP.DefaultSwayScale		= 2.0
SWEP.DefaultBobScale		= 2.0
SWEP.SprintSwayScale		= 4.4
SWEP.SprintBobScale			= 4.2

SWEP.ViewModelHomePos		= Vector( 0, 0, 0 )
SWEP.ViewModelHomeAng		= Angle( 0, 0, 0 )
SWEP.ViewModelSprintPos		= Vector( 4, 0.72, -0.8 )
SWEP.ViewModelSprintAng		= Angle( -15, 40, -5 ) --Angle( -10, 35, -5 )
SWEP.ViewModelSprintSway 	= 1
SWEP.ViewModelDuckPos		= Vector( -1, 0, 1 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -5 )
SWEP.ViewModelMeleePos		= Vector( 18, 12, -6 )
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -90 )
SWEP.ViewModelInspectable 	= true
SWEP.ViewModelMenuPos		= Vector( 12, 3.2, -6 )
SWEP.ViewModelMenuAng		= Angle( 20, 35, -10 )
SWEP.ViewModelReloadAnim 	= false
SWEP.ViewModelReloadPos		= Vector( -1, -1, 0 )
SWEP.ViewModelReloadAng		= Angle( -2, 2, 0 )

SWEP.ViewModelFOV			= GetConVarNumber( "sfw_cw_model_fov" )

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_custom.vmt" )
end

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false

SWEP.PrintName				= "Custom Sci-Fi weaponry"
SWEP.Slot					= 0
SWEP.SlotPos				= 0

SWEP.SciFiFamily			= { "custom", "magic", "infammo" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "I wonder what that does...", color = Color( 180, 180, 180 ) },
}

SWEP.AdsPos 				= Vector( 0, 0, 0 )
SWEP.AdsAng 				= Vector( 0, 0, 0 )
SWEP.AdsFov					= GetConVarNumber( "sfw_cw_zoom_fov" )

SWEP.SprintAnim				= false
SWEP.SprintAnimIdle			= false

SWEP.ViewModelBoneMods = {
}

local amp = GetConVarNumber( "sfw_damageamp" )
local pfx = GetConVarNumber( "sfw_fx_particles" )

function SWEP:Initialize()

	self:SetWeaponHoldType( "smg" )
	self:SetNetworkedInt( "Zoom", 0 )
	self:SetNetworkedInt( "FireMode", 0 )
	
	FireMode = 0
	fmchange = 1

end

function SWEP:Equip()

	if ( self.Owner:IsPlayer() ) then
		self.Owner:SendHint( "sfw_custom_equip_1", 0.05 )
		self.Owner:SendHint( "sfw_custom_equip_2", 0.15 )	
	end
	
end

function SWEP:Think()
	
	if ( GetConVarString( "sfw_cw_sfire_tech" ) == "zoom" ) then
		self:Ads()
		self.AdsFov = GetConVar( "sfw_cw_zoom_fov" ):GetInt()
	end
	
	if ( self.Owner:IsNPC() ) then
		self:SetClip1( 1 )
	end
	
	self:SciFiMath()
	self:SciFiMelee()
	self:Anims()
	
end

function SWEP:Attack( tech, pcount )

	local viewmodel = self:GetViewModelEnt()
	local av = self.Owner:GetAimVector() + ( Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -5, 5 ) ) * 0.00155 * pcount )
	
	if ( tech == "asa6" ) then
		if ( SERVER ) then
			local ent = ents.Create( "asa6_powershot" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() ) --+ Angle( 90, 0, 0 ) )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )
			ent.LauncherMode = true
			ent.Charge = 10
			
			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 480000 )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.01, -0.1 ), math.random( -0.01, -0.1 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			
			self:AddSciFiACC( 2 )
		
		end
		ParticleEffectAttach( "ngen_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		self:EmitSound( "scifi.mamba.fire.default0" )
		self:EmitSound( "scifi.mamba.fire.default1" )
	
	elseif ( tech == "basetest" ) then
		if ( SERVER ) then
			local ent = ents.Create( "sfp_base" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 340000 + ( Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -5, 5 ) ) * 0.11 ) * ( self:GetSciFiACC() * 1500 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.01, -0.1 ), math.random( -0.01, -0.1 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			
			self:AddSciFiACC( 2 )
		
		end
		ParticleEffectAttach( "ngen_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		self:EmitSound( "cat.vk21.pfire" )
		
	elseif ( tech == "trace_primary" ) then
		if ( SERVER ) then
			local ent = ents.Create( "trace_pfire" )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 34000 )
		end
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.8, -2 ), math.random( 0, 0.15 ), math.random( 0, 0.15 ) ) )
		end
		
		ParticleEffectAttach( "trace_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.trace.fire1" )
	
	elseif ( tech == "trace_secondary" ) then
		if ( SERVER ) then
			local ent = ents.Create( "trace_sfire" )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 34000 )
		end
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.8, -2 ), math.random( 0, 0.15 ), math.random( 0, 0.15 ) ) )
		end
		
		ParticleEffectAttach( "trace_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.trace.fire1" )
	
	elseif ( tech == "thunderbolt" ) then
		self:thrown( 1000000000, 136195729, 0.75, amp )
			self:thrown( 1000000000, 136195729, 0.75, amp )
		ParticleEffectAttach( "electrical_arc_01_parent", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		local fx = ents.Create( "light_dynamic" )
		if ( !IsValid( fx ) ) then return end
		fx:SetKeyValue( "_light", "0 180 255 255" )
		fx:SetKeyValue( "spotlight_radius", 180 )
		fx:SetKeyValue( "distance", 270 )
		fx:SetKeyValue( "brightness", 1 )
		fx:SetKeyValue( "style", 6 )
		fx:SetPos( viewmodel:GetPos() )
		fx:SetParent( viewmodel )
		fx:Spawn()
		fx:Fire( "Kill", "", 0.2 )
		self:EmitSound( "scifi.tbolt.throw" )
	
	elseif ( tech == "hellfire_primary" ) then
		if ( SERVER ) then
		
			local ent = ents.Create( "hfire_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 10000000000000 + ( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -10, 10 ) ) * 661999 ) * (self:GetSciFiACC() * 5500) )
			
			SafeRemoveEntityDelayed( ent, 10 )
			
		end
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.25, -2.5 ), math.random( 0, 0.8 ), math.random( 0, 0.5 ) ) * ( self:GetSciFiACC() * 0.0051 ) )
		end
		
		self:AddSciFiACC( 4 )

		ParticleEffectAttach( "hellfire_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.hfire.fire1" )
	
	elseif ( tech == "hellfire_secondary" ) then
		self:nade()
		ParticleEffectAttach( "hellfire_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -3.5, 0, 0 ) )
		end
		
		self:EmitSound( "scifi.hfire.fire1" )
	
	elseif ( tech == "storm_single" ) then
		self:Storm( 1000000000, amp )
		ParticleEffectAttach( "storm_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.storm.fire3" )
	
	elseif ( tech == "storm_multi" ) then
		self:Storm( 1000000000, amp )
			self:Storm( 50000000000, amp )
				self:Storm( 50000000000, amp )
					self:Storm( 50000000000, amp )
						self:Storm( 100000000000, amp )
							self:Storm( 100000000000, amp )
		ParticleEffectAttach( "storm_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.storm.fire1" )
	
	elseif ( tech == "grinder" ) then
		self:HeavyBullet()
		ParticleEffectAttach( "grinder_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "weapons/rng1/fire.wav" )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.8, -2 ), math.random( 0, 0.3 ), math.random( 0, 0.3 ) ) * ( self:GetSciFiACC() * 0.01 ) )
		end
		
		self:AddSciFiACC( 3 )
	
	elseif ( tech == "pulsar_primary" ) then
		if ( self.Owner:IsPlayer() ) then
			self:Pulse()
			self:EmitSound( "scifi.pulsar.fire" )
			self.Owner:ViewPunch( Angle( math.random( -0.4, -2.4 ), math.random( 0, 0.15 ), math.random( 0, 0.15 ) ) )
		elseif ( self.Owner:IsNPC() ) then
			self:NPCPulse()
			self:EmitSound( "scifi.pulsar.fire" )
		end
	
	elseif ( tech == "pulsar_secondary" ) then
	self:AltFire()
	self:EmitSound( "scifi.pulsar.altfire" )
	
	elseif ( tech == "vapor_primary" ) then
	
		if ( SERVER ) then
			local ent = ents.Create( "vapor_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 34000 + ( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -10, 10 ) ) * 0.002 ) * (self:GetSciFiACC() * 5500) )
		end

		ParticleEffectAttach( "vapor_muzzle_small", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -1.25, -2.5 ), math.random( 0, 0.918 ), math.random( 0, 0.918 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		end
		
		self:AddSciFiACC( 3.2 )

		self:EmitSound( "scifi.vapor.fire1" )
		
	elseif ( tech == "vapor_secondary" ) then
	
		if ( SERVER ) then
			local ent = ents.Create( "vapor_sfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 7200 )
		end
		
		ParticleEffectAttach( "vapor_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "weapons/vapor/sfire_fire.wav" )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -4, 0, 0 ) )
		end
	
	elseif ( tech == "acidrain_primary" ) then
		acidrain_firemode = 0
		self:CorroSpit( 20, 10, 1 )
		self:EmitSound( "weapons/corro/fire.wav" )
	
	elseif ( tech == "acidrain_secondary" ) then
		acidrain_firemode = 1
		self:CorroSpit( 10, 10, 1 )
		self:EmitSound( "weapons/corro/fire.wav" )
	
	elseif ( tech == "bane" ) then
		self:bane()
		ParticleEffectAttach( "dark_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -0.217, 0, 0 ) )
		end
		
	elseif ( tech == "synrifle" ) then
		self:SynBullet()
	
	elseif ( tech == "swarmer" ) then
		if ( SERVER ) then
			local ent = ents.Create( "rpg_missile" )
			if (  !IsValid( ent ) ) then return end
			ent:SetPos( self.Owner:GetShootPos() + self.Owner:EyeAngles():Forward() * 32 )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:Spawn()
			ent:SetKeyValue( "damage", 200 )
			ent:SetSaveValue( "m_flDamage", 200 )
			ent:SetVelocity( av * 2500 )
			ent:SetOwner( self.Owner )
		end
	
	elseif ( tech == "nade" ) then
		if ( SERVER ) then
			local ent = ents.Create( "npc_grenade_frag" )
			if (  !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( AngleRand() )
			ent:Spawn()
			ent:Fire( "settimer", 0.15, 10 )

			ent:AddCallback( "PhysicsCollide", function( boom ) 
				ent:Fire( "settimer", 0.3, 0 )
				ent:Fire( "ignite", "", 0.31 )
			end )
			
			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			
			ParticleEffectAttach( "gunsmoke", 4, ent, 1 )
			
			phys:ApplyForceCenter( av * 2560 )
			phys:SetMass( 20 )
		end
	
	elseif ( tech == "flechette" ) then
		if ( !IsMounted( "ep2" ) ) then print( "@sfw_custom : !Error, No ep2 mounted." ) return end
		self:flechgun( 1 )
			self:flechgun( 2 )
				self:flechgun( 3 )
					self:flechgun( 4 )
						self:flechgun( 5 )
							self:flechgun( 6 )
								self:flechgun( 6 )
									self:flechgun( 7 )
										self:flechgun( 7 )
		ParticleEffectAttach( "vapor_muzzle_small", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )					
		self:EmitSound( "NPC_Hunter.FlechetteShoot" )
	
	elseif ( tech == "ca3_nade" ) then
		if ( SERVER ) then
			local ent = ents.Create( "sfw_frag_ent" )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent.NextTick = CurTime() + 5.5
			ent.LauncherMode = true

			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 7200 + Vector( 0, 0, 16 ) )
		end
		ParticleEffectAttach( "ngen_muzzle_2", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "Weapon_SMG1.Double" )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -3.5, 0, 0 ) )
		end
	
	elseif ( tech == "ca3" ) then
		self:CA3( self:GetSciFiACC() )
		ParticleEffectAttach( "ngen_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:DrawMuzzleLight( "120 110 255 90" , 155, 500, 0.05 )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.1, -0.5 ), math.random( -0.1, -0.3 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		end
		
		if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) and ( self:GetSciFiACC() >= ( GetConVarNumber( "sfw_sk_maxacc" ) * math.random( 0.2, 0.9 ) ) ) then
			ParticleEffectAttach( "gunsmoke", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		end
		
		self:AddSciFiACC( 2 )
	
	elseif ( tech == "ca72" ) then
		self:CA72( self:GetSciFiACC() )
		ParticleEffectAttach( "vapor_muzzle_evensmaller", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.1, -0.3 ), math.random( -0.1, -0.3 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		end
		
		self:AddSciFiACC( 2 )
	
	elseif ( tech == "pest" ) then
		self:PEST( self:GetSciFiACC() )
		ParticleEffectAttach( "pest_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.1, -0.3 ), math.random( -0.1, -0.3 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		end
		
		self:AddSciFiACC( 2 )
	
	elseif ( tech == "xplo" ) then
		self:XPLO( self:GetSciFiACC() )
		ParticleEffectAttach( "grinder_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.1, -0.3 ), math.random( -0.1, -0.3 ) ) * ( self:GetSciFiACC() * 0.1 ) )
		end
		
		self:AddSciFiACC( 2 )
	
	elseif ( tech == "cryo" ) then
		if ( SERVER ) then
			local ent = ents.Create( "sfw_cryon_ent" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
			ent:SetAngles( self.Owner:EyeAngles() + Angle( math.random( 10, 80 ), 40, 0 ) )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )
			ent.NextTick = CurTime() + 5.5
			ent.LauncherMode = true
			
			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 7200 + Vector( 0, 0, 16 ) )
		end
	
	elseif ( tech == "mtmgm" ) then
		if ( SERVER ) then
			local ent = ents.Create( "mtm_missile" )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 34000 )
		end
		
	elseif ( tech == "missile1" ) then
		if ( SERVER ) then
			local ent = ents.Create( "sfw_frag_missile_ap" )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 512 )
		end
		
	elseif ( tech == "missile2" ) then
		if ( SERVER ) then
			local ent = ents.Create( "sfw_frag_missile_av" )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 512 )
		end
		
	elseif ( tech == "vapor_nade" ) then
		if ( SERVER ) then
			local ent = ents.Create( "vapor_nade" )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 7200 + Vector( 0, 0, 16 ) )
		end
		
		ParticleEffectAttach( "vapor_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.vapor.nade.launch" )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
		end
	
	elseif ( tech == "veho" ) then
		self:VhAr( self:GetSciFiACC() )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.4, -1.0 ), 0, 0 ) * ( self:GetSciFiACC() * 0.1 ) )
		end
		
		self:AddSciFiACC( 2 )
	
	elseif( tech == "neutrino" ) then
		self:EpicImpact()
		ParticleEffectAttach( "nio_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.neutrino.fire" )	
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -0.2, 0, 0 ) )
		end
	
	elseif( tech == "stinger" ) then
		if ( SERVER ) then
			local ent = ents.Create( "sting_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 2800 )
			
			self:EmitSound( "scifi.stinger.fire" )
		end
		ParticleEffectAttach( "stinger_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
	elseif( tech == "stinger_secondary" ) then
		if ( SERVER ) then
			local ent = ents.Create( "sting_sfire" )
			if ( !IsValid( ent ) ) then return end	
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:SetNWBool( "HomingEnabled", true ) 
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject()
			if (  !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 512 + ( Vector( math.random( -1, 1 ), math.random( -1, 1 ), math.random( -1, 1 ) ) * 16 ) )
		end
		ParticleEffectAttach( "stinger_muzzle_2", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.stinger.fire" )
			
	elseif ( tech == "shk" ) then
		self:Shk()
		
	elseif ( tech == "heatwave" ) then
		if ( SERVER ) then
			local ent = ents.Create( "hwave_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 340000 + ( Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -5, 5 ) ) * 0.11 ) * ( self:GetSciFiACC() * 1500 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.01, -0.1 ), math.random( -0.01, -0.1 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			
			self:AddSciFiACC( 2.4 )
		
		end
		ParticleEffectAttach( "hwave_muzzle_finish", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		--if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) and ( self:GetSciFiACC() >= 31 ) then
		--	ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		--end
		
		if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) and ( self:GetSciFiACC() >= 14 ) then
			ParticleEffectAttach( "hwave_debris_small", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		end
		
		self:EmitSound( "scifi.hwave.fire1" )
		
	elseif ( tech == "charwave" ) then
		if ( SERVER ) then
			local ent = ents.Create( "hwave_grenade" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 42090 + self.Owner:EyeAngles():Up() * 5120 )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.01, -0.1 ), math.random( -0.01, -0.1 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			
			self:AddSciFiACC( 2.4 )
		
		end
		ParticleEffectAttach( "hwave_muzzle_finish", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		self:EmitSound( "scifi.hfire.fire1" )
		
	elseif ( tech == "saphyre" ) then
		if ( SERVER ) then
			local ent = ents.Create( "saph_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 340000 + ( Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -5, 5 ) ) * 0.11 ) * ( self:GetSciFiACC() * 1500 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.01, -0.1 ), math.random( -0.01, -0.1 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			
			self:AddSciFiACC( 2.4 )
		
		end
		ParticleEffectAttach( "saphyre_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		self:EmitSound( "scifi.saph.fire1" )
		
	elseif ( tech == "pandemic" ) then
		if ( SERVER ) then
			local ent = ents.Create( "panda_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 1599 + VectorRand() * 150 )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.25, -1.5 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) )
			self:AddSciFiACC( 10 )
		end
		
		ParticleEffectAttach( "panda_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
	--	self:EmitSound( "scifi.seraph.fire1" )
		self:EmitSound( "cat.pest.pfire" )
		
	elseif ( tech == "phoenix" ) then
		self:PeleFire()
		
	elseif ( tech == "seraphim" ) then
	self:SeraphFire()
		
	elseif ( tech == "blizzard" ) then
		self:CryoDart()
		
	elseif ( tech == "flathr" ) then
		local bullet = {}
		bullet.Num = 2
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( .05, .05, 0 )
		bullet.Distance = 200
		bullet.Tracer = 0
		bullet.Force = 0
		bullet.HullSize = 16
		bullet.Damage = math.random( 1, 3 ) * GetConVarNumber( "sfw_damageamp" )
--		bullet.AmmoType = "SciFiAmmo"
		bullet.Callback = function( attacker, tr, dmginfo )
			dmginfo:SetDamageType( bit.bor( DMG_DIRECT, DMG_NEVERGIB ) )
		end
		
		self.Owner:FireBullets( bullet, false )
		
		local firetrace = util.TraceLine( {
			start = self.Owner:EyePos(),
			endpos = self.Owner:GetShootPos() + av * 200,
			filter = function( ent ) if ( ent == self.Owner || ent:GetOwner() == self.Owner ) then return false else return true end end,
			mask = MASK_SHOT_HULL
		} )
		
		self:DealAoeDamage( DMG_BURN, math.random( 1, 3 ) * GetConVarNumber( "sfw_damageamp" ), firetrace.HitPos, 64 )
		
		ParticleEffectAttach( "flathr", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
	
	elseif ( tech == "fstar_primary" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "fstar_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 500 + ( Vector( math.random( -1, 1 ), math.random( -1, 1 ), math.random( -1, 1 ) ) * 0.001 ) * (self:GetSciFiACC() * 5500) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -1.25, -2.5 ), math.random( 0, 0.918 ), math.random( 0, 0.918 ) ) * ( self:GetSciFiACC() * 0.05 ) )
			self:AddSciFiACC( 4.2 )
		end
		
		ParticleEffectAttach( "fstar_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.fstar.fire1" )
	
	elseif ( tech == "fstar_secondary" ) then
		if ( SERVER ) then
			local ent = ents.Create( "fstar_sfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 7200 )
		end
		
		ParticleEffectAttach( "fstar_muzzle_altfire", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.fstar.altfireshoot" )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
		end
		
	elseif ( tech == "hornet" ) then
		if ( SERVER ) then
			local ent = ents.Create( "hornet_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 3200000 )
		end
		
		ParticleEffectAttach( "fstar_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.hornet.pfire" )
		
		if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( -0.2, 0, 0 ) )
		end
		
	elseif ( tech == "spectra_fire" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "spectra_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )
			ent:SetNWInt( "Elemental", 1 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 34000 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 28 + self:GetSciFiACC() * 20 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 3 )
		end
		
		ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.spectra.fire2" )
		
	elseif ( tech == "spectra_crsv" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "spectra_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )
			ent:SetNWInt( "Elemental", 2 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 34000 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 28 + self:GetSciFiACC() * 20 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 3 )
		end
		
		ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.spectra.fire2" )
		
	elseif ( tech == "spectra_cryo" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "spectra_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )
			ent:SetNWInt( "Elemental", 3 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 34000 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 28 + self:GetSciFiACC() * 20 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 3 )
		end

		ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.spectra.fire2" )
		
	elseif ( tech == "prisma" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "spectra_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 32000 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 72 + self:GetSciFiACC() * 17 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 3 )
		end
		
		ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.spectra.fire1.nosilence" )
	
	elseif ( tech == "supra" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "supra_nade_parent" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 3200 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 72 + self:GetSciFiACC() * 17 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -1.2, -2 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 3 )
		end
		
		ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.supra.fire1" )
		
	elseif ( tech == "flare" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "sfi_flare" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:SetMass( 2 )
			phys:ApplyForceCenter( av * 4600 + Vector( 0, 0, 12 ) )
		end
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( -1, 0, 0 ) * ( self:GetSciFiACC() * 0.05 ) )
			self:AddSciFiACC( 2.2 )
		end
		
		ParticleEffectAttach( "moby_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.hfire.fire1" )
	
	elseif ( tech == "flare2" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "sfi_flare" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self.Owner:GetEyeTrace().HitPos + Vector( 0, 0, 8 ) )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:SetMass( 2 )
			phys:ApplyForceCenter( Vector( 0, 0, 4600 ) + self.Owner:EyeAngles():Forward() )
		end
		
		self:EmitSound( "NPC_CombineCamera.Active" )
	
	elseif ( tech == "flare3" ) then
		
		if ( SERVER ) then
			local ent = ents.Create( "sfi_flare_osm" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self.Owner:GetEyeTrace().HitPos + Vector( 0, 0, 8 ) )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:SetMass( 2 )
			phys:ApplyForceCenter( Vector( 0, 0, 3400 ) + self.Owner:EyeAngles():Forward() )
		end
		
		self:EmitSound( "NPC_CombineCamera.Active" )
		
	elseif ( tech == "jotunn" ) then
		
		local ent = ents.Create( "jotunn_arrow" )
		if ( !IsValid( ent ) ) then return end
		if (self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( self.Owner:GetShootPos() )
		end
		ent:SetAngles( self.Owner:EyeAngles() ) --+ Angle( 0, 0, 90 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( av * 25600 )
		
		ent:SetNWInt( "charge", 100 )
		
	elseif ( tech == "draco" ) then
		
		local ent = ents.Create( "drac_pfire" )
		if ( !IsValid( ent ) ) then return end
		if (self.SciFiState ~= SCIFI_STATE_ADS ) then
			ent:SetPos( self:GetProjectileSpawnPos() )
		else
			ent:SetPos( self.Owner:GetShootPos() )
		end
		ent:SetAngles( self.Owner:EyeAngles() ) --+ Angle( 0, 0, 90 ) )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( av * 25600 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 12 + self:GetSciFiACC() * 10 ) )
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:ViewPunch( Angle( math.random( -0.6, -0.8 ), math.random( 0, 0.03 ), math.random( 0, 0.03 ) ) * ( 1 + self:GetSciFiACC() * 0.1 ) )
			self:AddSciFiACC( 4 )
		end
		
		ParticleEffectAttach( "drake_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		
		if ( SERVER ) && ( cmd_heat == 1 ) && ( self:GetSciFiACC() >= 20 ) then
			ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		end

		self:EmitSound( "scifi.drake.fire1" )

	elseif ( tech == "vp_binary" ) then
		self:VpBinFire()
		
	elseif ( tech == "vectra" ) then
		local ent = ents.Create( "vectra_pfire" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( av * 3200 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 12 + self:GetSciFiACC() * 10 ) )
		
		ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.astra.lightfire" )
		
	elseif ( tech == "vectra_volley" ) then
		local counter = 0
		
		repeat
			local pos = self:GetProjectileSpawnPos()
			local ang = av:Angle()
			local up = ang:Up()
			local rt = ang:Right()
			
			if ( counter ) then
				if ( counter == 1 ) then
					pos = pos + rt * 20
				elseif ( counter == 2 ) then
					pos = pos + rt * -20
				elseif ( counter == 3 ) then
					pos = pos + rt * 12 + up * 12
				elseif ( counter == 4 ) then
					pos = pos + rt * 12 + up * -12
				elseif ( counter == 5 ) then
					pos = pos + rt * -12 + up * 12
				elseif ( counter == 6 ) then
					pos = pos + rt * -12 + up * -12
				elseif ( counter == 7 ) then
					pos = pos + up * -20
				end
			end
			
			local ent = ents.Create( "vectra_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( pos )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 3200 )
			
			counter = counter + 1
		until ( counter == 7 )
		
		ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.astra.lightfire" )

	elseif ( tech == "zeala" ) then
		local ent = ents.Create( "zeala_nade" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( av * 3200 )
		
		ParticleEffectAttach( "spectra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.zeala.fire" )

	elseif ( tech == "astra_light" ) then
		if ( SERVER ) then

			if ( self.Charge >= 120 ) then
				self:SetNextPrimaryFire( CurTime() + 0.6 )
				self.ScifiRegenNext = CurTime() + 2
				self.Charge = 50
				self:EmitSound( "scifi.pulsar.charge.decrease" )
				return
			else
				self:SetNextPrimaryFire( CurTime() + 0.12 )
				self.ScifiRegenNext = CurTime() + 1
			end
			
			local ent = ents.Create( "astra_pfire" )
			if ( !IsValid( ent ) ) then return end
			ent:SetPos( self:GetProjectileSpawnPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			ent:SetPhysicsAttacker( self.Owner, 10 )
			
			local mins = Vector( -24, -24, -24 )
			local maxs = Vector( 24, 24, 24 )
			local tr = util.TraceHull( {
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + av * 8192,
				filter = function( ent ) if ( IsValid( ent ) && ( ent:IsNPC() || ( ent:IsPlayer() && ent ~= self.Owner ) ) && ( ent:GetClass() ~= "astra_pfire" ) ) then return true end end,
				mins = mins,
				maxs = maxs,
				mask = MASK_SHOT_HULL,
				ignoreworld = true
			} )

			ent:SetNWEntity( "target", tr.Entity )

			local phys = ent:GetPhysicsObject()
			if ( !IsValid( phys ) ) then ent:Remove() return end
			phys:ApplyForceCenter( av * 256000 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 1 + self:GetSciFiACC() * 8 ) )
		end
		
		ParticleEffectAttach( "astra_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.astra.lightfire" )
		
	elseif ( tech == "astra_heavy" ) then
		local cmdDamage = GetConVarNumber( "sfw_damageamp" )

		local pOwnerAV = self.Owner:GetAimVector()
		local pOwnerSP = self.Owner:GetShootPos()
		
		local vmEntity = self:GetViewModelEnt()
		local vmAttachMuzzle = vmEntity:LookupAttachment( "muzzle" )
		
		local ptru = {}
		ptru.Num = 1
		ptru.Spread = Vector( 0, 0 )
		ptru.Tracer = 0
		ptru.Distance = 512
		ptru.Damage = 8 * cmdDamage
		ptru.Callback = function( attacker, tr, dmginfo )
			util.ParticleTracerEx( 
				"astra_beam_ptru",
				tr.StartPos,
				tr.HitPos,
				self:EntIndex(),
				0,
				-1
			)

			ParticleEffect( "ngen_hit_sparks_2", tr.HitPos, tr.Normal:Angle(), self )
		end

		local bullet = {}
		bullet.Num = 1
		bullet.Src = pOwnerSP
		bullet.Dir = pOwnerAV
		bullet.Tracer = 1
		bullet.HullSize = 0.6
		bullet.TracerName = "astra_beam"
		bullet.Damage = 36 * cmdDamage
		bullet.Force = 4
		bullet.Spread = Vector( 0, 0 )
		bullet.Callback = function( attacker, tr, dmginfo )
			dmginfo:SetDamageType( bit.band( DMG_RADIATION, DMG_AIRBOAT, DMG_BLAST ) )
			
			if ( tr.HitSky ) then return end
							
			if ( tr.HitGroup == HITGROUP_HEAD ) then
				dmginfo:SetDamage( dmginfo:GetDamage() * 2 )
			end	
			
			if ( tr.HitGroup == HITGROUP_CHEST ) then
				dmginfo:SetDamage( dmginfo:GetDamage() * 1.5 )
			end
			
			ptru.Src = tr.HitPos + pOwnerAV * 8
			ptru.Dir = tr.Normal + pOwnerAV

			self.Owner:FireBullets( ptru, false )
			
			ParticleEffect( "astra_hit_heavy", tr.HitPos, pOwnerAV:Angle(), self )
		end

		self.Owner:FireBullets( bullet, false )
		
		ParticleEffectAttach( "astra_muzzle_heavy", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.astra.heavyfire" )

	elseif ( tech == "wrath_normal" ) && ( SERVER ) then
		local ent = ents.Create( "celest_w_pfire" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( av * 1024 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 12 + self:GetSciFiACC() * 10 ) )
		
		ParticleEffectAttach( "celest_wrath_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.spectra.fire2" )
		
	elseif ( tech == "wrath_charged" ) && ( SERVER )  then
		local ent = ents.Create( "celest_w_pfire" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )
		ent.UseChargeMode = true

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( av * 8000 + Vector( math.random( -5, 5 ), math.random( -5, 5 ), math.random( -2, 10 ) ) * ( 12 + self:GetSciFiACC() * 10 ) )
		
		ParticleEffectAttach( "celest_wrath_muzzle", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.astra.lightfire" )
		
	elseif ( tech == "fireball" ) && ( SERVER )  then
		local ent = ents.Create( "sfw_fireball_ent" )
		if ( !IsValid( ent ) ) then return end
		ent:SetPos( self:GetProjectileSpawnPos() )
		ent:SetAngles( self.Owner:EyeAngles() )
		ent:SetOwner( self.Owner )
		ent:Spawn()
		ent:Activate()
		ent:SetPhysicsAttacker( self.Owner, 10 )

		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		phys:ApplyForceCenter( av * 8192 + Vector( 0, 0, 512 ) )
		
		ParticleEffectAttach( "ngen_muzzle_4", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		self:EmitSound( "scifi.hfire.pfire" )
		
	elseif ( tech == "" ) then
		self:EmitSound( "Weapon_Pistol.Empty" )
		DevMsg( "@sfw_custom : !Error; 'sfw_cw_pfire_tech' was not set!" )
		if ( self.Owner:IsPlayer() ) then
		debugoverlay.Text( self.Owner:GetEyeTrace().HitPos, "No function set", 1 )
		else
		debugoverlay.Text( viewmodel:GetPos(), "No function set", 1 )
		end
	end
	
	if ( tech ~= "" ) then
		if ( GetConVarNumber( "sfw_fx_heat" ) == 1 ) and ( self:GetSciFiACC() >= ( GetConVarNumber( "sfw_sk_maxacc" ) * 0.82 ) ) then
			ParticleEffectAttach( "nrg_heat", 4, viewmodel, viewmodel:LookupAttachment("muzzle") )
		end
	end
	
end

function SWEP:CanPrimaryAttack()

	return true
	
end

function SWEP:CanAltFire()

	return true
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if ( GetConVarNumber( "sfw_cw_allow_shelleject" ) == 0 ) then
		if ( event == 6001 ) then return true end
	end

	if ( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	if ( SERVER ) then return end
	
	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
	effectdata:SetNormal( tr.HitNormal )

	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "flathr" ) then
		
		if ( self.Owner:IsNPC() ) then return end
		if ( tr.MatType == MAT_GLASS ) then return true end
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 255
			dlight.g = 120
			dlight.b = 90
			dlight.brightness = 2
			dlight.Decay = 512
			dlight.Size = 512
			dlight.DieTime = CurTime() + 1
		end
		
		return true
		
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "ca3" ) then
		ParticleEffect( "ngen_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
		sound.Play( "cat.ca3.hit", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
		
		if ( self.Owner:IsNPC() ) then return end
		if ( tr.MatType == MAT_GLASS ) then return end
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 120
			dlight.g = 110
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "pest" ) then
		ParticleEffect( "pest_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
		
		if ( self.Owner:IsNPC() ) then return end
		if ( tr.MatType == MAT_GLASS ) then return end
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 190
			dlight.g = 255
			dlight.b = 2
			dlight.brightness = 2
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "ca72" ) then
		ParticleEffect( "nrg_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
		
		if ( self.Owner:IsNPC() ) then return end
		if ( tr.MatType == MAT_GLASS ) then return end
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 0
			dlight.g = 80
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
		sound.Play( "weapons/vapor/pfire_hit_weak.wav", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "xplo" ) then
		ParticleEffect( "xplo_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
		sound.Play( "ambient/fire/gascan_ignite1.wav", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
		util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
		
		if ( self.Owner:IsNPC() ) then return end		
		if ( tr.MatType == MAT_GLASS ) then return end
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 255
			dlight.g = 95
			dlight.b = 20
			dlight.brightness = 2
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "veho" ) then
		ParticleEffect( "vh_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
		sound.Play( "cat.ca3.hit", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
		
		if ( self.Owner:IsNPC() ) then return end		
		if ( tr.MatType == MAT_GLASS ) then return end
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 255
			dlight.g = 10
			dlight.b = 25
			dlight.brightness = 2
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "shk" ) then
		ParticleEffect( "shk_hit", tr.HitPos, Angle( 0, 0, 0 ), self )
		sound.Play( "scifi.tbolt.throw", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
		
		if ( self.Owner:IsNPC() ) then return end		
		if ( tr.MatType == MAT_GLASS ) then return end
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = tr.HitPos
			dlight.r = 150
			dlight.g = 145
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2048
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "phoenix" ) then
		ParticleEffect( "pele_hit", tr.HitPos, self.Owner:EyeAngles(), self )
		sound.Play( "scifi.hwave.hit", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
		
		if ( self.Owner:IsPlayer() ) then
			if ( tr.MatType == MAT_GLASS ) then return end
			local dlight = DynamicLight( self:EntIndex() + math.random( 2, 1024 ) + CurTime() ) -- Tonight at eleven: DOOOOOM!
			if ( dlight ) then
				dlight.pos = tr.HitPos 
				dlight.r = 255
				dlight.g = 130
				dlight.b = 100
				dlight.brightness = 2
				dlight.Decay = 2048
				dlight.Size = 256
				dlight.DieTime = CurTime() + 0.5
			end
		end
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "seraphim" ) then
		if ( SERVER ) then
			for k,v in pairs( ents.FindInSphere( tr.HitPos, 8 ) ) do
				DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 2 } )
			end
		end
		
		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
		effectdata:SetNormal( tr.HitNormal )
		
		ParticleEffect( "hwave_hit", tr.HitPos, self.Owner:EyeAngles(), self )
		ParticleEffect( "gunsmoke", tr.HitPos, Angle( 0, 0, 0 ), self )
		
		if ( GetRelChance( 20 ) ) then
		sound.Play( "scifi.hwave.hit", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
		end
		
		if ( self.Owner:IsPlayer() ) then
			if ( tr.MatType == MAT_GLASS ) then return end
			local dlight = DynamicLight( self:EntIndex() + math.random( 2, 1024 ) + CurTime() ) -- Tonight at eleven: DOOOOOM!
			if ( dlight ) then
				dlight.pos = tr.HitPos 
				dlight.r = 255
				dlight.g = 130
				dlight.b = 100
				dlight.brightness = 2
				dlight.Decay = 2048
				dlight.Size = 256
				dlight.DieTime = CurTime() + 0.5
			end
		end
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "blizzard" ) then
		ParticleEffect( "ice_impact_heavy", tr.HitPos, Angle( 0, 0, 0 ), self )
		
		sound.Play( "Glass.Strain", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 95, 102 ), 1.0 )
		util.Decal( "bulletproof", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "pulsar_secondary" ) then
		ParticleEffect( "pulsar_hit_weak", tr.HitPos, Angle( 0, 0, 0 ), self )
		sound.Play( "weapons/tbolt/tbolt_fx2.wav", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 90, 100 ), 1.0 )
		if ( self.Owner:IsPlayer() ) then
			if ( tr.MatType == MAT_GLASS ) then return end
			local dlight = DynamicLight( self:EntIndex() )
			if ( dlight ) then
				dlight.pos = tr.HitPos
				dlight.r = 140
				dlight.g = 140
				dlight.b = 255
				dlight.brightness = 2
				dlight.Decay = 2048
				dlight.Size = 256
				dlight.DieTime = CurTime() + 0.5
			end
		end
	end
	
	if ( GetConVarString( "sfw_cw_pfire_tech" ) == "neutrino" ) then
		ParticleEffect( "nio_impact", tr.HitPos, Angle( 0, 0, 0 ), self )
		sound.Play( "scifi.neutrino.impact", tr.HitPos, SOUNDLVL_GUNFIRE, math.random( 95, 102 ), 1.0 )
		util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
		
		if ( self.Owner:IsNPC() ) then
			if ( GetConVarNumber( "sfw_allow_dissolve" ) ~= 1 ) then return end
			timer.Create( "dissolve" .. self:EntIndex(), 0.01, 25, function() 
				for k, v in pairs ( ents.FindInSphere( tr.HitPos, 100 ) ) do
					if ( v:IsRagdoll() ) and ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
						v:SetNWBool( "IsVaporizing", true )
						local phys = v:GetPhysicsObject()
						
						local bones = v:GetPhysicsObjectCount()
						local b = v:GetNWBool( "gravity_disabled" )

						for  i=0, bones-1 do
							local grav = v:GetPhysicsObjectNum( i )
							if ( IsValid( grav ) ) then
								grav:EnableGravity( b )
							end
						end
						
						if ( !IsValid( phys ) ) then v:Remove() return end
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 20 )
						
						v:DrawShadow( false )
						v:SetNoDraw( false )
						v:SetMaterial( "models/elemental/burned" )
						v:SetRenderMode( RENDERMODE_TRANSADD )
						v:SetColor( Color( 20, 100, 0, 175 ) )
						v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
						ParticleEffectAttach( "nio_dissolve", 1, v, -1 ) 
						v:Fire( "kill", "", 1 )
						v:EmitSound( "scifi.neutrino.dissolve" )
					end
				end
				timer.Remove( "dissolve" .. self:EntIndex() )
			end )
		end
	end
	
	return false
	
end

function SWEP:PrimaryAttack()

	local pcount = 0
	local wfunc = ""
	local delay = 0.4
	local count = 1
	
	if ( !game.SinglePlayer() && CLIENT ) || ( game.SinglePlayer() ) then
		local wfunc = GetConVarString( "sfw_cw_pfire_tech" )
		local delay = GetConVarNumber( "sfw_cw_pfire_delay" )
		local count = GetConVarNumber( "sfw_cw_pfire_pcount" )
	end
	
	wfunc = GetConVarString( "sfw_cw_pfire_tech" )
	delay = GetConVarNumber( "sfw_cw_pfire_delay" )
	count = GetConVarNumber( "sfw_cw_pfire_pcount" )
	
	self:SetNextPrimaryFire( CurTime() + delay )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	repeat
		self:Attack( wfunc, count )
		pcount = pcount + 1
		if ( pcount > 1 ) then
			self:AddSciFiACC( self:GetSciFiACC() * 1.25 )
		end
	until pcount == math.Clamp( count, 1, 128 )
	
	pcount = 0
	
end

function SWEP:SecondaryAttack()

	local pcount = 0
	
	self:SetNextSecondaryFire( CurTime() + GetConVarNumber( "sfw_cw_sfire_delay" ) )
	
	if ( GetConVarString( "sfw_cw_sfire_tech" ) ~= "zoom" ) then
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		repeat
			self:Attack( GetConVarString( "sfw_cw_sfire_tech" ), GetConVarNumber( "sfw_cw_sfire_pcount" ) )
			pcount = pcount + 1
			if ( pcount > 1 ) then
				self:AddSciFiACC( self:GetSciFiACC() * 1.25 )
			end
		until pcount == math.Clamp( GetConVarNumber( "sfw_cw_sfire_pcount" ), 1, 128 )
	end
	
	pcount = 0
	
end

function SWEP:Reload()
	
end