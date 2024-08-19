AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.PrintName				= "'Fenris' energy blade"
SWEP.Author					= "Darken217, Kilburn, robotboy655, MaxOfS2D & Tenrys"
SWEP.ItemRank 				= 16

SWEP.Purpose				= "An standart flux-stream blade."
SWEP.Instructions			= "Mouse1 to strike, Mouse2 to stab/dash. Hitting a target will decrease the blade's charge."

SWEP.Slot					= 0
SWEP.SlotPos				= 4

SWEP.ViewModel				= "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel				= "models/weapons/w_knife_t.mdl"
SWEP.HoldType 				= "knife"
SWEP.HoldTypeSprint			= "normal"
SWEP.DeploySpeed 			= 2.8
SWEP.ViewModelFOV			= 64
SWEP.Weight					= 1

SWEP.SciFiSkin				= "vgui/white"
SWEP.SciFiWorld 			= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_vapor.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SciFiEnergy"

SWEP.Secondary.Automatic	= true

SWEP.ViewModelSprintAng 	= Angle( -10, -10, 0 )
SWEP.ViewModelShift = false

SWEP.SciFiFamily			= { "vtec", "melee_simple", "useshook", "infammo", "autoregen" }
SWEP.SciFiWorldStats		= { 
	["1"] = { text = "Damage: 				 25, +25", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				 --", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Impact, Energy", color = Color( 110, 180, 255 ) },
	["4"] = { text = "Attack speed: 	(max.) 2.5", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Range: 						 82 units", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate: 60", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Damage is positively effected by the wielder's movement speed.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Damage decreases with lower blade charge.", color = Color( 180, 180, 180 ) },
--	["9"] = { text = "... They ask for your allegiance, and you shall give it ...", color = Color( 255, 20, 20 ) }
}

SWEP.SciFiWorldStats		= {
	Primary = {
		DamageComposition = "20, 25",
		DamageAmount = 20,
		DamageAttackRange = 64,
		DamageType = { DMG_SLASH, DMG_SF_VAPOR },
		FireRate = { 
			{ RateTitle = "swing", RateDelay = 0.4 }, 
		},
	},

	CoreRechargeRate = 16
}


SWEP.ViewModelMeleePos		= Vector( 2, 4, -2 )
SWEP.ViewModelMeleeAng		= Angle( 10, 20, -20 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.45
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 5
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.HitDistance			= 64

SWEP.SciFiRegenDelay		= 0.8

SWEP.VElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2.476, 4.776), angle = Angle(-4.618, 70.052, 72), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 3, 4.2), angle = Angle(173.481, 70, 95), size = Vector(0.402, 0.547, 1.536), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2.476, 2), angle = Angle(-4.618, 70.052, 72), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 2, -2), angle = Angle(173.481, 70, 95), size = Vector(0.402, 0.547, 1.536), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18, 6, 2.2), angle = Angle(170, 70, 102), size = Vector(0.402, 0.547, 3), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf_legacy", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 5.5, 3), angle = Angle(-4.618, 72, 72), size = Vector(0.402, 0.547, 3), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf_legacy", skin = 0, bodygroup = {} },
	["1++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 3, 2), angle = Angle(-4.618, 70.052, 72), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf_legacy", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["0"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2.476, 4.776), angle = Angle(-4.618, 70.052, 82), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 3, 4.2), angle = Angle(173.481, 70, 85), size = Vector(0.402, 0.547, 1.536), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2.476, 3), angle = Angle(-4.618, 70.052, 82), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0+++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 2, -2), angle = Angle(173.481, 70, 85), size = Vector(0.402, 0.547, 1.536), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["1"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12, 5.5, 1), angle = Angle(170, 70, 90), size = Vector(0.402, 0.547, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/energy_surf_legacy", skin = 0, bodygroup = {} },
	["1+"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13, 5.5, 2), angle = Angle(-4.618, 72, 82), size = Vector(0.402, 0.547, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/energy_surf_legacy", skin = 0, bodygroup = {} },
	["1++"] = { type = SCIFI_SCK_TYPE_MODEL, model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 3, 2), angle = Angle(-4.618, 70.052, 82), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/misc/energy_surf_legacy", skin = 0, bodygroup = {} }
}

-- resource.AddSingleFile( "weapons/eblade/eblade_idle.wav" )

local EnergyLoop = Sound( "Scifi.Blade.Idle" )
local SwingElectric = { "Scifi.Blade.Swing01", "Scifi.Blade.Swing02", "Scifi.Blade.Swing03" }
local HitElectric = { "Scifi.Blade.Hit.Electric01", "Scifi.Blade.Hit.Electric02" }
local HitDefault = Sound( "Scifi.Blade.Hit" )
local comfort = 0

function SWEP:SubInit()

	self.NextRegenTime = 0
	comfort = 52

end

function SWEP:AddAcc()

	local viewmodel = self.Owner:GetViewModel()
	local muzzle = self.VElements[ "1++" ].modelEnt
	
	self:SetNWEntity( "blade", muzzle )
	
end

function SWEP:AddWAcc()

	if ( self.Owner == NULL ) then
	
		self.WElements[ "1" ].material = "vgui/white" 
		self.WElements[ "1+" ].material = "vgui/white" 
		self.WElements[ "1++" ].material = "vgui/white"
		
	else
	
		self.WElements[ "1" ].material = "models/weapons/misc/energy_surf_legacy"
		self.WElements[ "1+" ].material = "models/weapons/misc/energy_surf_legacy"
		self.WElements[ "1++" ].material = "models/weapons/misc/energy_surf_legacy"

	end

end

SWEP.DataTables = {
	{ dType = "Float", dName = "NextMeleeAttack" },
	{ dType = "Float", dName = "NextIdle" }
}

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )

end

function SWEP:Think()

	if ( self.Owner:GetActiveWeapon() ~= self.Weapon ) then return end

	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()
	
	if ( IsExistent( self ) ) and ( IsExistent( self:GetNWEntity( "blade" ) ) ) then
	
		local blade = self:GetNWEntity( "blade" )
		local vm_blade = self.Owner:GetVelocity()
		local velo = math.Clamp( ( math.Round( ( math.abs( vm_blade.y ) + math.abs( vm_blade.x ) + math.abs( vm_blade.z ) ) ) / 3000 ), 0.01, 0.25 )

		if ( CLIENT ) then
			EmitSound( "weapons/eblade/eblade_idle.wav", blade:GetPos(), blade:EntIndex(), CHAN_STATIC, velo, 50, SND_CHANGE_PITCH, 60 + velo * 10 )
		end
		
		if ( self:GetNWBool( "eblade_active" ) == true ) then
		--	CreateParticleSystem( blade, "blade_glow", PATTACH_POINT_FOLLOW, 1, Vector( 0, 0, 0 ) ) 
		--	ParticleEffectAttach( "blade_glow", PATTACH_POINT_FOLLOW, blade, 0 ) -- wtf, garry? why you rekt this function?
			self:SetNWBool( "eblade_active", false )
		end
	
	end
	
	if ( idletime > 0 && CurTime() > idletime ) and ( SERVER ) then

		vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle_cycle" ) )

		self:UpdateNextIdle()

	end

	local meleetime = self:GetNextMeleeAttack()

	if ( meleetime > 0 && CurTime() > meleetime ) then

		self:DealDamage()

		self:SetNextMeleeAttack( 0 )

	end
	
	if ( SERVER ) then
		
		if( self.NextRegenTime <= CurTime() ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) then 
				self.Weapon:SetClip1( self.Weapon:Clip1() + 1 ) 
			end
		end
		
		if ( self.Weapon:Clip1() >= 101 ) then
			self.Weapon:SetClip1( 100 )
		end
	
	end
	
	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:Deploy()

	if ( self.Owner:IsNPC() ) then self:Remove() end --Those NPC-peasants aren't mighty enough to use this weapon.

	local vm = self.Owner:GetViewModel()
	local vmatt = vm:GetBonePosition( vm:LookupBone( "v_weapon.Knife_Handle" ) )
	local wmatt = vm:GetBonePosition( vm:LookupBone( "ValveBiped.Bip01_R_Hand" ) )
	
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
	
	self:UpdateNextIdle()
	
	self:SetClip1( 60 )
	
	if ( GetConVarNumber( "sfw_fx_particles" ) >= 1 ) then
		if ( SERVER ) then
			local fx2 = ents.Create( "light_dynamic" )
			if ( !IsValid( fx2 ) ) then return end
			fx2:SetKeyValue( "_light", "70 110 255 255" )
			fx2:SetKeyValue( "spotlight_radius", 64 )
			fx2:SetKeyValue( "distance", 320 )
			fx2:SetKeyValue( "brightness", 1 )
			fx2:SetPos( vmatt + self:GetViewModelEnt():GetAngles():Up() * 40 + self.Owner:GetAimVector() * 0.5 )
			fx2:Spawn()
			fx2:SetParent( self )
			self:SetNWEntity( "glow", fx2 )
		end
		


		if ( CLIENT ) then
			local dlight = DynamicLight( self:EntIndex() ) -- Tonight at eleven: DOOOOOM!
			if ( dlight ) then
				dlight.pos = vmatt
				dlight.r = 70
				dlight.g = 110
				dlight.b = 255
				dlight.brightness = 1
				dlight.Decay = 1024
				dlight.Size = 1024
				dlight.DieTime = CurTime() + 1
			end
		end
	end
	
	return true
	
end

function SWEP:ResetDeployment()

	if ( IsValid( self.Owner ) && CLIENT && self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) then 
			vm:SetSubMaterial( 0, "" )
			vm:SetSubMaterial( 1, "" )
			vm:SetSubMaterial( 2, "" )
			vm:SetSubMaterial( 3, "" )
			vm:SetSubMaterial( 4, "" )
		end
	end
	
	if ( IsExistent( self ) ) and ( IsExistent( self:GetNWEntity( "glow" ) ) ) and ( SERVER ) then
	self:GetNWEntity( "glow" ):Remove()
	end
	
end

function SWEP:PrimaryAttack()

	self:SetNWBool( "eblade_active", true )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	local anim = ""
	
	if ( GetRelChance( comfort ) ) then
		self.Owner:ViewPunch( Angle( 0, 2, 0 ) )
		anim = "midslash1"
		comfort = comfort - 10
	else
		self.Owner:ViewPunch( Angle( 0, -2, 0 ) )
		anim = "midslash2"
		comfort = comfort + 10
	end
	
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( SwingElectric[ math.random( 1, #SwingElectric ) ] )

	local weaken = 0.4 + ( self:GetSciFiACC() / 30 )
	
	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 )
	
	self:SetNextPrimaryFire( CurTime() + weaken )
	self:SetNextSecondaryFire( CurTime() + weaken + 0.1 )

	self.NextRegenTime = CurTime() + self.SciFiRegenDelay
	
	self:AddSciFiACC( 12 )

end

function SWEP:SecondaryAttack()

	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
	
	local tr = self.Owner:GetEyeTrace()
	
	if ( tr.Entity && !tr.HitWorld ) then
		--self.Owner:SetVelocity( self.Owner:EyeAngles():Forward() * 1024 + Vector( 0, 0, 64 ) )
		local pos = self.Owner:GetPos()
		local tpos = tr.HitPos
		local dist = pos:Distance( tpos )
		
		if ( dist <= 512 ) then
			self.Owner:SetVelocity( self.Owner:EyeAngles():Forward() * 4 * dist )
		--	self.SciFiState = SCIFI_STATE_MELEE_RETIRE
		end
	end
			
	self:SetNWBool( "eblade_active", true )

	anim = "stab"
	self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( SwingElectric[ math.random( 1, #SwingElectric ) ] )
		
	local weaken = 0.6 + ( self:GetSciFiACC() / 30 )
	
	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.26 )
	
	self:SetNextPrimaryFire( CurTime() + weaken )
	self:SetNextSecondaryFire( CurTime() + weaken + 0.1)

	self.NextRegenTime = CurTime() + self.SciFiRegenDelay * 1.5
	
	self:AddSciFiACC( 22 )
	
end

function SWEP:DealDamage()

	local anim = self:GetSequenceName( self.Owner:GetViewModel():GetSequence() )
	local amp = GetConVarNumber( "sfw_damageamp" )
	local playervelo = self.Owner:GetVelocity()
	local velo = math.Clamp( ( math.Round( ( math.abs( playervelo.y ) + math.abs( playervelo.x ) + math.abs( playervelo.z ) ) ) * 0.5 ), 1, 10 )

	self.Owner:LagCompensation( true )
	
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

	if ( !IsValid( tr.Entity ) ) then 
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -16, -16, -8 ),
			maxs = Vector( 16, 16, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end

	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
	
		self:EmitSound( HitElectric[ math.random( 1, #HitElectric ) ] )
		
		util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
		
		if ( anim == "stab" ) then
			ParticleEffect( "blade_hit", tr.HitPos, self.Owner:EyeAngles(), self )
		else
			ParticleEffect( "saphyre_hit", tr.HitPos, self.Owner:EyeAngles(), self )
		end
	
		if ( self:Clip1() > 0 ) then
				if ( !game.SinglePlayer() && SERVER ) then
				local fx2 = ents.Create( "light_dynamic" )
				if ( !IsValid( fx2 ) ) then return end
				fx2:SetKeyValue( "_light", "70 110 255 255" )
				fx2:SetKeyValue( "spotlight_radius", 256 )
				fx2:SetKeyValue( "distance", 512 )
				fx2:SetKeyValue( "brightness", 2 )
				fx2:SetPos( tr.HitPos )
				fx2:Spawn()
				fx2:Fire( "kill", "", 0.12 )
				end
			self:EmitSound( HitDefault )
		end
	
	end

	local hit = false
	
	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then

		local dmginfo = DamageInfo()
		local dmgforce = self.Owner:GetRight() * 1024 + self.Owner:GetForward() * 8192 + playervelo * 24
	
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )

		if ( self:Clip1() > 25 ) then
		--	self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_NEVERGIB ), 25 * amp, self.Owner:GetShootPos() + self.Owner:GetAimVector() * 16, 64 )
			for k,v in pairs ( ents.FindInSphere( tr.HitPos, self.HitDistance / 2 ) ) do
				if ( v ~= self.Owner ) && ( v:GetOwner() ~= self.Owner ) then
					self:DealDirectDamage( bit.bor( DMG_AIRBOAT, DMG_NEVERGIB ), 25 * amp, v, self.Owner, dmgforce )
				end
			end
			dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_NEVERGIB ) )
			self:TakePrimaryAmmo( math.Clamp( 25, 0, self:Clip1() ) )
		-- else
			-- dmginfo:SetDamage( 25 * amp + velo )
		end
		
		dmginfo:SetDamage( 20 * amp + velo )
		
		dmginfo:SetDamageForce( dmgforce )

		tr.Entity:TakeDamageInfo( dmginfo )
		
		hit = true
		
	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos )
		end
	end

	self:SetNWBool( "eblade_active", false )

	self.Owner:LagCompensation( false )

end