AddCSLuaFile()
AddCSLuaFile( "base/scifi_projectile.lua" )
include( "base/scifi_projectile.lua" )
AddCSLuaFile( "entities/sfi_supplies/shared.lua" )
include( "entities/sfi_supplies/shared.lua" )

ENT.PrintName 		= "Health Orb"
ENT.Purpose			= "Restores 20 health to the player."
ENT.FxTracer 		= "item_orb_health"
ENT.FxRemove		= "pest_hit"
ENT.LightColor		= "150 255 80 255"

function ENT:Snack( player )

	if ( player:Health() == player:GetMaxHealth() ) then return end

	if ( SERVER ) then
	
	if ( !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Attempted call on non-existing entity! Removing!" ) self:Remove() end
	
	self:EmitSound( self.SndSnack )
	
	ParticleEffectAttach( "stinger_attach", 1, self, 1 )
	ParticleEffectAttach( "item_pfx_health", 1, player, 1 )
	
	if ( player:Health() <= 100 ) then
	player:SetHealth( math.Clamp( player:Health() + 20, 0, 100 ) )
	else
	player:SetHealth( player:Health() + 10 )
	end
	
	self:Remove()
	
	end
	
end

function ENT:OnTakeDamage( dmginfo )

	ParticleEffect( self.FxRemove, self:GetPos(), Angle( 0, 0, 0 ) )
	
	self:Remove()
	
	return true
	
end