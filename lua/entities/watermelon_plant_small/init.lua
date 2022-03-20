AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function watermelonCount()
    local wms = ents.FindByClass("watermelon")
    return #wms
end

function treemCount()
    local wms = ents.FindByClass("watermelon_plant_medium")
    return #wms
end

function ENT:SpawnFunction(ply, tr)
    local SpawnPos = tr.HitPos
    local ent = ents.Create("watermelon_plant_small")
    ent:SetPos(SpawnPos)
    ent:Spawn()
    return ent
end

local models = {{"models/props_foliage/shrub_01a.mdl", 0.8}, {"models/props_foliage/cattails.mdl", 0.5}};
local scaleRandomness = 20

function ENT:Initialize()
    local current = math.random(1, #models);
    self:SetModel(models[current][1])
    self.scale = models[current][2] * (math.random(100 - scaleRandomness, 100 + scaleRandomness) / 100)
    self:SetModelScale(0.2 * self.scale, 0)
    self:SetAngles(Angle(0, math.random(0, 360), 0))
    self:SetSolid(SOLID_VPHYSICS)
    self:SetNWBool("RC", true)
    self.mage = GetConVarNumber("rc_watermelons_life")
    self.age = 0
    self.nextmelon = GetConVarNumber("rc_watermelons_time")
end

function ENT:OnTakeDamage(dmg)
end

function ENT:Think()

    if self.age < self.mage / 2 then
        self:SetModelScale((0.2 + 1.6 * self.age / self.mage) * self.scale, GetConVarNumber("rc_planttime"));
    end
    if GetConVarNumber("rc_remove") == 1 then
        self:Remove()
    end

    if self.age > self.mage then
        local random = math.Round(math.random(0, 2))
        if random == 2 and treemCount() <= GetConVarNumber("rc_tree_maxm") then
            local melon = ents.Create("watermelon_plant_medium")
            undo.ReplaceEntity(self.Entity, melon)
            melon:SetPos(self:GetPos())
            melon:Spawn()
            melon:SetOwner(self.Owner)
        end
        self:Remove()
    end
    if self.age > self.nextmelon and watermelonCount() <= GetConVarNumber("rc_watermelon_max") then
        self.nextmelon = self.nextmelon + GetConVarNumber("rc_watermelons_time") * math.random(90, 110) / 100
        local melon = ents.Create("watermelon")
        local dist = GetConVarNumber("rc_watermelons_distance")
        melon:SetPos(self:GetPos() + Vector(math.random(-dist, dist), math.random(-dist, dist), 40))
        melon:Spawn()
        melon:SetOwner(self.Owner)
        melon:SetModelScale(self:GetModelScale() / self.scale * GetConVarNumber("rc_watermelons_size") / 100, 0);
    end

    self.age = self.age + GetConVarNumber("rc_planttime") * GetConVarNumber("rc_speed")
    self:NextThink(CurTime() + GetConVarNumber("rc_planttime"))
    return true
end
