AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:SpawnFunction(ply, tr)
    local SpawnPos = tr.HitPos
    local ent = ents.Create("colonies_humanmeat")
    ent:SetPos(SpawnPos + Vector(0, 0, 15))
    ent:Spawn()
    return ent
end

function ENT:Initialize()

    self:SetModel("models/Gibs/HGIBS_spine.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self:SetColor(Color(255, 0, 0, 255))
    self.lastmelon = math.Round(CurTime())
    rc_api.setFood(self, "human")
    self:SetNWInt("Food", GetConVarNumber("rc_food_human_meat"))
end

function ENT:Think()
    if GetConVarNumber("rc_remove") == 1 then
        self:Remove()
    end
    if math.Round(CurTime()) > self.lastmelon + GetConVarNumber("rc_meat_time") / GetConVarNumber("rc_speed") then
        self:Remove()
    end

    self:NextThink(CurTime() + GetConVarNumber("rc_time") / GetConVarNumber("rc_speed"))
    return true
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
