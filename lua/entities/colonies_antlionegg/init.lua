AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:SpawnFunction(ply, tr)
    local SpawnPos = tr.HitPos
    local ent = ents.Create("colonies_antlionegg")
    ent:SetPos(SpawnPos)
    ent:Spawn()
    return ent
end

function ENT:Initialize()

    self:SetModel("models/props_junk/watermelon01.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self:SetMaterial("models/debug/debugwhite")
    self.laid = math.Round(CurTime())
    rc_api.setFood(self, "antlion")
    self:SetNWInt("Food", GetConVarNumber("rc_food_antlion_egg"))

end

function ENT:OnTakeDamage(dmg)
    self:Remove()
end

--[[---------------------------------------------------------
	Name: OnRemove
	Desc: Called just before entity is deleted
	---------------------------------------------------------]]
function ENT:OnRemove()

end

function ENT:Think()
    if GetConVarNumber("rc_remove") == 1 then
        self:Remove()
    end

    if math.Round(CurTime()) > self.laid + GetConVarNumber("rc_antlion_eggtime") / GetConVarNumber("rc_speed") then
        if antlionCount() < GetConVarNumber("rc_antlion_max") then
            local heady = ents.Create("colonies_antlion")
            undo.ReplaceEntity(self.Entity, heady)
            heady:SetPos(self:GetPos() + Vector(0, 0, 15))
            heady:Spawn()
            heady:SetOwner(self.Owner)
        end
        self:Remove()
    end

    self:NextThink(CurTime() + GetConVarNumber("rc_antlion_eggtime") / GetConVarNumber("rc_speed"))
    return true
end
