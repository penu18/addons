local Spell = {}
Spell.Category = HpwRewrite.CategoryNames.General
Spell.Description = [[Etrafınızda yoğun bir ışık patlaması yaratır.]]

function Spell:OnSpellCast(caster)
    -- Işık patlaması görsel efekti
    ParticleEffect("light_explosion", caster:GetPos(), Angle(0, 0, 0), nil)
end

function Spell:OnCollide(spell, data)
    local pos = spell:GetPos()
    local radius = 200 -- Yarı çap

    -- Çevredeki düşmanlara hasar ver ve dostlara sağlık ekle
    local entities = ents.FindInSphere(pos, radius)
    for _, ent in pairs(entities) do
        if IsValid(ent) then
            if ent:IsNPC() or ent:IsPlayer() then
                local damage = 10
                ent:TakeDamage(damage, spell:GetCaster(), spell:GetCaster())
            elseif ent:IsPlayer() then
                local healAmount = 10
                ent:SetHealth(ent:Health() + healAmount)
            end
        end
    end
end

HpwRewrite:AddSpell("Elementalis Işık Patlaması", Spell)
