rc_api = {};

-- Savoir si une entity est de RC
function rc_api.isRC(ent)
    if ent ~= nil and ent:IsValid() then
        return ent:GetNWBool("RC", false);
    end
    return false;
end

-- Savoir si une entity est de la nourriture valable pour un npc.
function rc_api.isValidFood(npc, ent)
    if (rc_api.isFood(ent)) then
        return (ent:GetNWString("rc_class", "") ~= npc:GetNWString("rc_class", ""));
    end
    return false;
end
-- Savoir si une entity est de la nourriture
function rc_api.isFood(ent)
    if (rc_api.isRC(ent)) then
        return ent:GetNWBool("Eatable", false);
    else
        return false;
    end
end

-- Savoir si une entity est un npc de RC
function rc_api.isNpc(ent)
    if (rc_api.isRC(ent)) then
        return ent:GetNWBool("HC", false);
    else
        return false;
    end
end

-- Savoir si une entity est un zombie/headcrab
function rc_api.isHeadcrab(ent)
    if (rc_api.isNpc(ent)) then
        return (ent:rc_class() == "headcrab");
    else
        return false;
    end
end

-- Savoir si une entity est un antlion
function rc_api.isAntlion(ent)
    if (rc_api.isNpc(ent)) then
        return (ent:rc_class() == "antlion");
    else
        return false;
    end
end

-- Prend la nourriture la plus proche
function rc_api.getNearestFood(ent)
    local pos = ent:GetPos();
    local dist = GetConVarNumber("rc_searchrad");
    local objectsList = ents.FindInSphere(pos, dist);
    local eating = nil;

    for _, newFood in pairs(objectsList) do
        if (rc_api.isValidFood(ent, newFood) and newFood:GetNWBool("Targetable", false)) then
            local newFoodDist = newFood:GetPos():Distance(pos)
            if (newFoodDist < dist) then
                eating = newFood;
                dist = newFoodDist;
            end
        end
    end
    if (rc_api.isValidFood(ent, eating)) then
        eating:SetNWBool("Targetable", false);
    end
    return eating;
end

function rc_api.setFood(ent, str)
    ent:SetNWBool("RC", true)
    ent:SetNWBool("Eatable", true)
    ent:SetNWBool("Targetable", true)
    ent:SetNWString("rc_class", str)
end

function rc_api.removeNPC(ent)
    if (rc_api.isFood(ent.melon)) then
        ent.melon:SetNWBool("Targetable", true)
    end
    ent:Remove()
end
