AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function treesCount()
    local wms = ents.FindByClass("watermelon_plant_small")
    return #wms
end

function ENT:SpawnFunction(ply, tr)
    local SpawnPos = tr.HitPos
    local ent = ents.Create("watermelon")
    ent:SetPos(SpawnPos + Vector(0, 0, 15))
    ent:Spawn()
    return ent
end

function ENT:Initialize()

    self:SetModel("models/props_junk/watermelon01.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self:GetPhysicsObject():SetMass(1)
    self.lastmelon = math.Round(CurTime())
    self:SetNWInt("Food", GetConVarNumber("rc_food_melon"))
    self.age = 0
    rc_api.setFood(self, "plant")
end

function ENT:OnTakeDamage(dmg)
    self:Remove()
end

--[[---------------------------------------------------------
	Name: OnRemove
	Desc: Called just before entity is deleted
	---------------------------------------------------------]]

function ENT:OnRemove()
    self:Remove()
end

function ENT:Think()
    if GetConVarNumber("rc_remove") == 1 then
        self:Remove()
    end

    if self.age > GetConVarNumber("rc_watermelon_time") then

        local random = math.Round(math.random(0, 2))
        if random == 2 and treesCount() <= GetConVarNumber("rc_tree_maxs") then
            local melon = ents.Create("watermelon_plant_small")
            undo.ReplaceEntity(self.Entity, melon)
            melon:SetPos(self:GetPos() - Vector(0, 0, 7))
            melon:Spawn()
            melon:SetOwner(self.Owner)
        end
        self:Remove()
    end

    self.age = self.age + GetConVarNumber("rc_planttime") * GetConVarNumber("rc_speed")
    self:NextThink(CurTime() + GetConVarNumber("rc_planttime"))
    return true
end
