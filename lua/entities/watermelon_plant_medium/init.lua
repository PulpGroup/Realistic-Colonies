AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function watermelonCount()
    local wms = ents.FindByClass("watermelon")
    return #wms
end

function treebCount()
    local wms = ents.FindByClass("watermelon_plant_big")
    return #wms
end

function ENT:SpawnFunction(ply, tr)
    local SpawnPos = tr.HitPos
    local ent = ents.Create("watermelon_plant_medium")
    ent:SetPos(SpawnPos)
    ent:Spawn()
    return ent
end

function ENT:Initialize()
    self:SetModel("models/props_foliage/tree_deciduous_03b.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():EnableMotion(false)
    self:SetNWBool("RC", true)
    self.mage = GetConVarNumber("rc_watermelonm_life")
    self.age = 0
    self.nextmelon = GetConVarNumber("rc_watermelonm_time")
end

function ENT:OnTakeDamage(dmg)
end

function ENT:Think()
    if GetConVarNumber("rc_remove") == 1 then
        self:Remove()
    end

    if self.age > self.mage then
        local random = math.Round(math.random(0, 2))
        if random == 2 and treebCount() <= GetConVarNumber("rc_tree_maxb") then
            local melon = ents.Create("watermelon_plant_big")
            undo.ReplaceEntity(self.Entity, melon)
            melon:SetPos(self:GetPos())
            melon:Spawn()
            melon:SetOwner(self.Owner)
        end
        self:Remove()
    end
    if self.age > self.nextmelon and watermelonCount() <= GetConVarNumber("rc_watermelon_max") then
        self.nextmelon = self.nextmelon + GetConVarNumber("rc_watermelonm_time") * math.random(90, 110) / 100
        local melon = ents.Create("watermelon")
        local dist = GetConVarNumber("rc_watermelonm_distance")
        melon:SetPos(self:GetPos() + Vector(math.random(-dist, dist), math.random(-dist, dist), 60))
        melon:Spawn()
        melon:SetOwner(self.Owner)
        melon:SetModelScale(GetConVarNumber("rc_watermelonm_size") / 100, 0);
    end

    self.age = self.age + GetConVarNumber("rc_planttime") * GetConVarNumber("rc_speed")
    self:NextThink(CurTime() + GetConVarNumber("rc_planttime"))
    return true
end
