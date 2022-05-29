AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:SpawnFunction(ply, tr)
    local SpawnPos = tr.HitPos + Vector(0, 0, 15)
    local ent = ents.Create("colonies_combineegg")
    ent:SetPos(SpawnPos)
    ent:Spawn()
    return ent
end

function ENT:Initialize()

    self:SetModel("models/props_c17/doll01.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self.laid = math.Round(CurTime())
    self:SetNWBool("RC", true)
    self:SetNWBool("Eatable", true)
    self:SetNWString("rc_class", "human")
    self:SetNWInt("Food", GetConVarNumber("rc_food_human_egg"))
    self:SetColor(Color(128, 128, 255, 255))

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
    if math.Round(CurTime()) > self.laid + GetConVarNumber("rc_human_eggtime") / GetConVarNumber("rc_speed") then

        if combineCount() < GetConVarNumber("rc_human_max") then
            local heady = ents.Create("colonies_combine")
            undo.ReplaceEntity(self.Entity, heady)

            heady:SetPos(self:GetPos() + Vector(0, 0, 15))
            heady:Spawn()
            heady:SetOwner(self.Owner)
        end

        self:Remove()

    end

    self:NextThink(CurTime() + GetConVarNumber("rc_human_eggtime") / GetConVarNumber("rc_speed"))
    return true
end
