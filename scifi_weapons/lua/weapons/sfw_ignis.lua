AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

SWEP.Spawnable = false
SWEP.AdminSpawnable = false

--SWEP.Purpose				= "The HS12-CF emits a short-ranged laser. That's basically it."
--SWEP.Instructions			= "Hold Mouse1 to activate the laser. Energy needs to regenerate."
SWEP.ItemRank 				= 10

SWEP.ViewModelFOV			= 54

SWEP.ViewModel				= "models/weapons/cstrike/c_smg_p90.mdl" --"models/weapons/c_physcannon.mdl"
SWEP.WorldModel				= "models/weapons/w_physics.mdl"

--SWEP.SciFiSkin				= "vgui/white"
--SWEP.SciFiWorld 			= "vgui/white"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_hfire.vmt" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "smg1"

SWEP.PrintName				= "sfw_ignis"
SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.SciFiFamily			= { "elemental", "hitscanbullets", "autoregen" }

SWEP.AdsPos 				= Vector(-4.55, 0, 0.8)
SWEP.ViewModelHomePos		= Vector(0, 0, 0)
SWEP.ReloadTime 			= 4

local snd_stop = "ambient/fire/mtov_flame2.wav"
local snd_start = "ambient/fire/gascan_ignite1.wav"
local dAmmo = 0

function SWEP:Initialize()

	self:SetWeaponHoldType( "pistol" )
	
	self:sckInit()

	self.NextFlame = 0

end

function SWEP:Think()
	
	if ( self.Owner:IsPlayer() ) then
		local viewmodel = self.Owner:GetViewModel()
		
		if ( self.Owner:KeyDown( IN_ATTACK ) ) && ( self:Clip1() > 0 ) && ( self:GetNextPrimaryFire() <= CurTime() ) then
			if ( self.NextFlame <= CurTime() ) then
				ParticleEffectAttach( "flathr", 4, viewmodel, viewmodel:LookupAttachment("1") )
				
				if ( CLIENT ) then
					local dlight = DynamicLight( self:EntIndex() )
					if ( dlight ) then
						dlight.pos = self:GetProjectileSpawnPos() + self.Owner:EyeAngles():Forward() * 32
						dlight.r = 255
						dlight.g = 120
						dlight.b = 60
						dlight.brightness = 2
						dlight.Decay = 786
						dlight.Size = 512
						dlight.DieTime = CurTime() + 0.1
					end
				end
				
				if ( !game.SinglePlayer() || SERVER ) && ( self.NextFlame < CurTime() ) then
					local bullet = {}
					bullet.Num = 6
					bullet.Src = self.Owner:GetShootPos()
					bullet.Dir = self.Owner:GetAimVector()
					bullet.Spread = Vector( .2, .2, 0 )
					bullet.Distance = 300
					bullet.Tracer = 0
					bullet.Force = 0
					bullet.HullSize = 32
					bullet.Damage = math.random( 1, 4 ) * GetConVarNumber( "sfw_damageamp" )
					bullet.AmmoType = "SciFiAmmo"
					bullet.Callback = function( attacker, tr, dmginfo )
						dmginfo:SetDamageType( bit.bor( DMG_DIRECT, DMG_NEVERGIB ) )

					--	if ( tr.Hit && tr.Entity && !tr.Entity ) then
							ParticleEffect( "xplo_hit_cheap", tr.HitPos, tr.Normal:Angle(), self )
							
							self:DealAoeDamage( bit.bor( DMG_DIRECT, DMG_BURN ), dmginfo:GetDamage(), tr.HitPos, 64 )
							
							if ( SERVER ) then
								DoElementalEffect( { Element = EML_FIRE, Target = tr.Entity, Duration = 2 } )
							end
					--	end
					end
				
					self.Owner:FireBullets( bullet, false )

					self:TakePrimaryAmmo( 1 )
				end
				
				self.NextFlame = CurTime() + 0.1
			end
		end
		
		if ( self.Owner:KeyReleased( IN_ATTACK ) || ( self:GetNextPrimaryFire() < CurTime() && self:CanReload() && !self:CanPrimaryAttack( 0 ) && dAmmo > 1 ) ) then
			self:StopSound( "PhysicsCannister.ThrusterLoop" )
	
			if ( self:Clip1() == 0 ) then
				self:SetNextPrimaryFire( CurTime() + 0.2 )
			end
			
			if ( !game.SinglePlayer() || SERVER ) then
				self:EmitSound( snd_stop, 60, math.random( 100, 100 ), 1, CHAN_STATIC )
			end
		end
		
		dAmmo = self:Clip1()
	end
	
	self:Ads()
	self:Anims()
	self:SciFiMath()
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

end

function SWEP:PrimaryAttack()
		
	self:EmitSound( snd_start, 60, math.random( 100, 100 ), 1, CHAN_STATIC )
	self:EmitSound( "PhysicsCannister.ThrusterLoop", 60, math.random( 100, 100 ), 1, CHAN_WEAPON )

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( CLIENT ) then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetProjectileSpawnPos() + self.Owner:EyeAngles():Forward() * 32
			dlight.r = 255
			dlight.g = 120
			dlight.b = 60
			dlight.brightness = 2
			dlight.Decay = 786
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.1
		end
		
	--	self:EmitSound( "ExtinguisherJet.TurnOn" )
	end

	return true

end