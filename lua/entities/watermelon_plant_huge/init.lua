AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function watermelonCount()
    local wms = ents.FindByClass("watermelon")
    return #wms
end

function ENT:SpawnFunction(ply, tr)
    local SpawnPos = tr.HitPos
    local ent = ents.Create("watermelon_plant_huge")
    ent:SetPos(SpawnPos)
    ent:Spawn()
    return ent
end

local models = {{"models/gm_forest/tree_orientalspruce1.mdl", 0.7}, {"models/gm_forest/tree_oak1.mdl", 0.8}};
local scaleRandomness = 20

function ENT:Initialize()
    local current = math.random(1, #models);
    self:SetModel(models[current][1])
    self.scale = models[current][2] * (math.random(100 - scaleRandomness, 100 + scaleRandomness) / 100)
    self:SetModelScale(self.scale, 0)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():EnableMotion(false)
    self:SetNWBool("RC", true)
    self.mage = GetConVarNumber("rc_watermelonh_life")
    self.age = 0
    self.nextmelon = GetConVarNumber("rc_watermelonh_time")
end

function ENT:OnTakeDamage(dmg)
end

function ENT:Think()
    if GetConVarNumber("rc_remove") == 1 then
        self:Remove()
    end

    if self.age > self.mage then
        self:Remove()
    end
    if self.age > self.nextmelon and watermelonCount() <= GetConVarNumber("rc_watermelon_max") then
        self.nextmelon = self.nextmelon + GetConVarNumber("rc_watermelonh_time") * math.random(90, 110) / 100
        local melon = ents.Create("watermelon")
        local dist = GetConVarNumber("rc_watermelonh_distance")
        melon:SetPos(self:GetPos() + Vector(math.random(-dist, dist), math.random(-dist, dist), 120))
        melon:Spawn()
        melon:SetOwner(self.Owner)
        melon:SetModelScale(GetConVarNumber("rc_watermelonh_size") / 100, 0);
    end

    self.age = self.age + GetConVarNumber("rc_planttime") * GetConVarNumber("rc_speed")
    self:NextThink(CurTime() + GetConVarNumber("rc_planttime"))
    return true
end
