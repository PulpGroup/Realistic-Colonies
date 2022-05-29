AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function antlionCount()
    local hcs = ents.FindByClass("colonies_antlion")
    return #hcs
end

local hctypes = {"npc_antlion"}
local currentTeam = "antlion"
registerNpcType(currentTeam, hctypes)

function ENT:SpawnFunction(ply, tr)
    if antlionCount() < GetConVarNumber("rc_antlion_max") then
        local SpawnPos = tr.HitPos
        local ent = ents.Create("colonies_antlion")
        ent:SetPos(SpawnPos)
        ent:Spawn()
        return ent
    end
    return nil
end

function ENT:Initialize()
    self.npc = ents.Create(hctypes[math.random(1, #hctypes)])
    local spawnflags = SF_NPC_ALWAYSTHINK
    self.npc:SetKeyValue("spawnflags", spawnflags)
    self.npc:SetPos(self:GetPos())
    self.npc:Spawn()
    self.npc:Activate()
    self.npc:SetOwner(self.Owner)
    -- self.npc:SetModelScale(Vector(0.5, 0.5, 0.5));

    -- set color and value
    self.name = coloniesnames[math.random(1, #coloniesnames)]
    self.nextegg = GetConVarNumber("rc_antlion_maturetime") + GetConVarNumber("rc_antlion_pregtime") +
                       math.Round(math.random(-2, 2))
    self.melon = nil
    self.mhunger = GetConVarNumber("rc_antlion_mhunger")
    self.hunger = self.mhunger * 0.25
    self.age = 0
    self.npc:SetNWInt("G", 0)
    self.npc:SetNWInt("R", 0)
    self.npc:SetNWInt("Z", 5)

    self.maxhp = 30
    self.hpregen = 1
    self.scale = 0.2

    self.npc:SetNWString("HCname", self.name)
    self.npc:SetNWString("rc_class", currentTeam)
    self.npc:SetNWBool("HC", true)
    self.npc:SetNWBool("RC", true)
    self.npc:SetNWBool("isSelected", false)

    -- setup disposition
    if GetConVarNumber("rc_antlion_hateplayers") == 0 then
        self.npc:AddRelationship("player D_NU 999")
    end


    if GetConVarNumber("rc_spreadthelove") == 0 then
        makeFear(self.npc, currentTeam);
    else
        makeFriendly(self.npc,currentTeam)
    end

    self.npc:SetModelScale(self.scale, 0);
    self.npc:SetHealth(self.maxhp / 2);
    self.npc:SetNWInt("HChealth", self.npc:Health());
end

function ENT:OnTakeDamage(dmg)

end

--[[---------------------------------------------------------
	Name: OnRemove
	Desc: Called just before entity is deleted
	---------------------------------------------------------]]
function ENT:OnRemove()
    -- kill the npc
    if IsValid(self.npc) == true then
        self.npc:Remove(0)
    end
end

function ENT:Think()

    self.age = self.age + GetConVarNumber("rc_time") * GetConVarNumber("rc_speed")
    self.hunger = self.hunger + GetConVarNumber("rc_antlion_hunger") * GetConVarNumber("rc_time") *
                      GetConVarNumber("rc_speed")

    if (IsValid(self.npc) ~= true) then
        local meat = ents.Create("colonies_antlionmeat")
        meat:SetPos(self:GetPos() + Vector(0, 0, 10010))
        meat:SetModelScale(self.scale, 0);
        meat:Spawn();
        rc_api.removeNPC(self);
    else
        if GetConVarNumber("rc_remove") == 1 then
            self:Remove()
        end

        if GetConVarNumber("rc_spreadthelove") == 0 and self.hunger > GetConVarNumber("rc_antlion_mhunger") *
            GetConVarNumber("rc_veryhungry") / 100 then
            self.npc:AddRelationship("npc_antlion D_HT 999")
        else
            self.npc:AddRelationship("npc_antlion D_LI 999")
        end

        -- POS for the meat
        self:SetPos(self.npc:GetPos() - Vector(0, 0, 10000))

        if self.age > GetConVarNumber("rc_antlion_lifespan") then
            rc_api.removeNPC(self);
            if GetConVarNumber("rc_printevents") >= 2 then
                PrintMessage(HUD_PRINTTALK, "Antlion " .. self.name .. " died (age).")
            end
        end

        if self.npc:GetNWBool("isSelected") == false then
            self.npc:SetColor(Color(255, 255, 255, 255))
        end

        -- eating script
        if self.hunger > GetConVarNumber("rc_antlion_mhunger") * GetConVarNumber("rc_hungry") / 100 then

            -- dieing of starvation thing
            if self.hunger >= self.mhunger then
                self.npc:SetHealth(self.npc:Health() - 1 * GetConVarNumber("rc_speed") * GetConVarNumber("rc_time"))
                if (self.npc:Health() <= 0) then
                    if GetConVarNumber("rc_printevents") >= 1 then
                        PrintMessage(HUD_PRINTTALK, "antlion " .. self.name .. " died (starvation).")
                    end
                    local meat = ents.Create("colonies_antlionmeat")
                    meat:SetPos(self:GetPos() + Vector(0, 0, 10010))
                    meat:SetModelScale(self.scale, 0);
                    meat:Spawn()
                    rc_api.removeNPC(self);
                end
            end

            if IsValid(self.melon) then
                self.npc:SetLastPosition(self.melon:GetPos())
                self.npc:SetSchedule(SCHED_FORCED_GO_RUN)
                -- eating stuff
                if (self.npc:GetPos():Distance(self.melon:GetPos()) < 32) then
                    self.melon:Remove()
                    self.hunger = self.hunger - self.melon:GetNWInt("Food", 0) * self.melon:GetModelScale()
                    if self.hunger < 0 then
                        self.hunger = 0
                    end
                end
            else
                self.melon = rc_api.getNearestFood(self.npc)
            end

        else
            if self.npc:Health() < self.maxhp then
                self.npc:SetHealth(self.npc:Health() + self.hpregen * GetConVarNumber("rc_speed") *
                                       GetConVarNumber("rc_time"))
            end

            -- Laying egg time
            if self.age > self.nextegg and antlionCount() <= GetConVarNumber("rc_antlion_max") and self.hunger <=
                self.mhunger / 2 then
                local rand = math.Round(math.random(1, 2))
                for i = 1, rand do
                    local egg = ents.Create("colonies_antlionegg")
                    egg:SetPos(self.npc:GetPos() + Vector(0, 0, 15))
                    egg:Spawn()
                end
                self.nextegg = self.age + GetConVarNumber("rc_antlion_pregtime") + math.Round(math.random(-2, 2))
            end
        end

        if self.age <= GetConVarNumber("rc_antlion_maturetime") * 0.25 then
            self.scale = 0.2 + (2 * self.age / GetConVarNumber("rc_antlion_maturetime")) * (0.8)
            self.npc:SetModelScale(self.scale, GetConVarNumber("rc_time"));
        elseif self.age <= GetConVarNumber("rc_antlion_maturetime") * 0.75 then

        elseif self.age <= GetConVarNumber("rc_antlion_maturetime") then
            self.scale = 0.5 +
                             (2 * (self.age - GetConVarNumber("rc_antlion_maturetime") * 0.75) /
                                 GetConVarNumber("rc_antlion_maturetime"))
            self.npc:SetModelScale(self.scale, GetConVarNumber("rc_time"));

            if GetConVarNumber("rc_spreadthelove") == 0 then
                makeunFriendly(self.npc, currentTeam);
            end
        end

        self.npc:SetNWInt("HCage", self.age)
        self.npc:SetNWInt("HChunger", self.hunger)
        self.npc:SetNWInt("HChealth", self.npc:Health());
        self.npc:SetNWInt("G", 255 * (self.mhunger - self.hunger) / self.hunger)
        self.npc:SetNWInt("R", 255 * self.hunger / self.mhunger)
        self.npc:SetNWInt("Z", 5 + 65 * self.scale)
        self:NextThink(CurTime() + GetConVarNumber("rc_time"))
        return true
    end
end
