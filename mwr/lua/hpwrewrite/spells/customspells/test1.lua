local Spell = {}
Spell.LearnTime = 360
Spell.Category = HpwRewrite.CategoryNames.Misc
Spell.Description = [[
    Makes the caster vanish from sight,
    becoming invisible to others.
    The invisibility lasts for 10 seconds,
    during which the caster's speed is doubled.
]]

Spell.CanSelfCast = true
Spell.ApplyFireDelay = 1

function Spell:OnFire(wand)
    local caster = self.Owner

    caster:SetRenderMode(RENDERMODE_TRANSALPHA) -- Görünmezlik için render modunu değiştir
    caster:SetColor(ColorAlpha(caster:GetColor(), 0)) -- Karakterin renginin alfasını 0 yap

    -- Hızı iki katına çıkar
    local originalSpeed = caster:GetWalkSpeed()
    local originalRunSpeed = caster:GetRunSpeed()
    caster:SetWalkSpeed(originalSpeed * 4)
    caster:SetRunSpeed(originalRunSpeed * 4)

    timer.Simple(10, function()
        if IsValid(caster) then
            caster:SetRenderMode(RENDERMODE_NORMAL) -- Görünmezlik sona erdiğinde render modunu geri al
            caster:SetColor(ColorAlpha(caster:GetColor(), 255)) -- Karakterin renginin alfasını geri getir

            -- Hızı orijinal değerine döndür
            caster:SetWalkSpeed(originalSpeed)
            caster:SetRunSpeed(originalRunSpeed)
        end
    end)
end

HpwRewrite:AddSpell("Vanish", Spell)