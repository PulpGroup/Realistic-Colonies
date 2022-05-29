local npcArray = {}

function registerNpcType(factionName, factionTypes)
    -- PrintMessage(HUD_PRINTTALK, factionName)
    if npcArray[factionName] == nil then
        npcArray[factionName] = {}
    end
    for _, npcType in pairs(factionTypes) do
        npcArray[factionName][npcType] = true;
    end
end

function giveMeBehavior(npc, factionName, behaviorType)
    for currentFaction, factionTable in pairs(npcArray) do
        -- PrintMessage(HUD_PRINTTALK, currentFaction)
        if (currentFaction ~= factionName) then
            -- PrintMessage(HUD_PRINTTALK, factionName .. " " .. currentFaction)
            for npcType, _ in pairs(factionTable) do
                -- PrintMessage(HUD_PRINTTALK, npcType .. " " .. behaviorType .. " 999")
                npc:AddRelationship(npcType .. " " .. behaviorType .. " 999")
            end
        end
    end

end

function makeunFriendly(npc, factionName)
    giveMeBehavior(npc, factionName, 'D_HT');
end
function makeFriendly(npc, factionName)
    giveMeBehavior(npc, factionName, 'D_NU');
end
function makeFear(npc, factionName)
    giveMeBehavior(npc, factionName, 'D_FR');
end
