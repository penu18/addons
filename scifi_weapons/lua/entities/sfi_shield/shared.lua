AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )
AddCSLuaFile( "entities/sfi_supplies/shared.lua" )
include( "entities/sfi_supplies/shared.lua" )

ENT.PrintName 		= "Shield Orb"
ENT.Purpose			= "Restores 20 shield to the player."
ENT.FxTracer 		= "item_orb_battery"
ENT.FxRemove		= "shk_hit"
ENT.LightColor		= "160 180 255 255"

function ENT:Snack( player )

	if ( player:Armor() == 100 ) then return end

	if ( SERVER ) then
	
	if ( !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Attempted call on non-existing entity! Removing!" ) self:Remove() end
	
	self:EmitSound( self.SndSnack )
	
	ParticleEffectAttach( "stinger_attach", 1, self, 1 )
	ParticleEffectAttach( "item_pfx_battery", 1, player, 1 )
	
	if ( player:Armor() <= 100 ) then
	player:SetArmor( math.Clamp( player:Armor() + 20, 0, 100 ) )
	else
	player:SetArmor( player:Armor() + 10 )
	end
	
	self:Remove()
	
	end
	
end

function ENT:OnTakeDamage( dmginfo )

	ParticleEffect( self.FxRemove, self:GetPos(), Angle( 0, 0, 0 ) )
	
	self:Remove()
	
	return true
	
end