local Spell = {}
Spell.LearnTime = 1200
Spell.Description = [[
    The Killing curse.
    Inflicts instant painless death.
]]
Spell.Category = HpwRewrite.CategoryNames.General
Spell.FlyEffect = "hpw_avadaked_main"
Spell.ImpactEffect = "hpw_avadaked_impact"
Spell.ApplyDelay = 0.5
Spell.ForceAnim = { ACT_VM_PRIMARYATTACK_1, ACT_VM_PRIMARYATTACK_2 }
Spell.SpriteColor = Color(60, 255, 160)
Spell.DoSparks = true

Spell.NodeOffset = Vector(938, -511, 0)

function Spell:Draw(spell)
    self:DrawGlow(spell)
end

function Spell:OnSpellSpawned(wand, spell)
    sound.Play("ambient/wind/wind_snippet2.wav", spell:GetPos(), 75, 255)
    spell:EmitSound("ambient/wind/wind_snippet2.wav", 80, 255)
    wand:PlayCastSound()
end

function Spell:OnFire(wand)
    return true
end

function Spell:OnCollide(spell, data)
    local ent = data.HitEntity

    if IsValid(ent) then
        if ent:IsNPC() or ent:IsPlayer() then
            local casterPos = self.Owner:GetPos()
            local radius = 100 -- Çemberin yarıçapı

            local angle = math.random(0, 360)
            local offset = Vector(math.cos(math.rad(angle)) * radius, math.sin(math.rad(angle)) * radius, 0)

            local targetPos = casterPos + offset
            local groundHeight = util.TraceLine({
                start = targetPos,
                endpos = targetPos - Vector(0, 0, 1000),
                mask = MASK_SOLID_BRUSHONLY
            }).HitPos.z

            if targetPos.z < groundHeight then
                targetPos.z = groundHeight + 10 -- Yerden 10 birim yükseklikte ışınlanma
            end

            local direction = (targetPos - casterPos):GetNormalized()
            local traceResult = util.TraceHull({
                start = casterPos,
                endpos = casterPos + direction * 1000,
                filter = self.Owner,
                mins = Vector(-16, -16, -16),
                maxs = Vector(16, 16, 16)
            })

            if traceResult.Hit then
                local eyePos = self.Owner:EyePos()
                local eyeDirection = self.Owner:EyeAngles():Forward()
                local traceResult2 = util.TraceHull({
                    start = eyePos,
                    endpos = eyePos + eyeDirection * 1000,
                    filter = self.Owner,
                    mins = Vector(-16, -16, -16),
                    maxs = Vector(16, 16, 16)
                })

                if traceResult2.Hit and traceResult2.Entity == ent then
                    local targetDirection = (targetPos - casterPos):GetNormalized()
                    local distance = (targetPos - casterPos):Length()
                    local targetPosOffset = casterPos + targetDirection * (distance - radius) -- Çemberin merkezinden uzaklaşan nokta

                    targetPos = targetPosOffset
                else
                    return -- Işınlanma iptal edilir
                end
            end

            ent:SetPos(targetPos)
        end
    end
end

HpwRewrite:AddSpell("Seen", Spell)
