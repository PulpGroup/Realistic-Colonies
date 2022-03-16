local npcArray = {}

function registerNpcType(factionName, factionTypes)
    if npcArray[factionName] == nil then
        npcArray[factionName] = {}
    end
    for _, npcType in pairs(factionTypes) do
        table.insert(npcArray, npcType)
    end
end

function giveMeBehavior(npc, factionName, behaviorType)
    for currentFaction, factionTable in pairs(npcArray) do
        if (currentFaction ~= factionName) then
            for key, npcType in pairs(factionTable) do
                npc:AddRelationship(npcType + " " + behaviorType + " 999")
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
