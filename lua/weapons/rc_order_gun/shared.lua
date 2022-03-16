-- Show debug info?
local debug = true
SWEP.Author = "wamilou"
SWEP.Contact = "wamilou@gmail.com"
SWEP.Purpose = ""
SWEP.Instructions = "Left click : Select entity, right click : order :D and reload to open the build menu :P"

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.ViewModel = "models/weapons/v_pist_finger1.mdl";
SWEP.WorldModel = "models/weapons/w_pistol.mdl";

SWEP.base = "weapon_base"
SWEP.Category = "Realistic Colonies";
SWEP.HoldType = "pistol";

SWEP.Primary.Clipsize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
    if (SERVER) then
        self:SetWeaponHoldType(self.HoldType);
    end

    self:SetNWEntity("selectedEnt", nil);
    self:SetNWVector("color", Vector(255, 255, 255));
end

function SWEP:Reload()

end

-- Called each frame when the Swep is active
function SWEP:Think()
    if (SERVER) then
        self:SetColor(Color(255, 255, 255, 0)); -- Faire disparaitre le pistolet

        if (IsValid(self:GetNWEntity("selectedEnt"))) then
            self:GetNWEntity("selectedEnt"):SetColor(Color(0, 0, 255, 255));
        end
    end
end

function SWEP:PrimaryAttack()
    local trace = self.Owner:GetEyeTrace();

    if (IsValid(self:GetNWEntity("selectedEnt"))) then
        self:GetNWEntity("selectedEnt"):SetNWBool("isSelected", false);
        self:GetNWEntity("selectedEnt"):SetColor(255, 255, 255);

        self:SetNWEntity("selectedEnt", nil);
    end

    if (IsValid(trace.Entity) and rc_api.isNpc(trace.Entity) == true) then
        if (GetConVarString("rc_gamemode_enabled") == "1") then
            if self.Owner:GetNWString("RC_team") == "antlion" and rc_api.isAntlion(trace.Entity) == true then
                self:SetNWEntity("selectedEnt", trace.Entity);
                local r, g, b, a = trace.Entity:GetColor();
                trace.Entity:SetNWBool("isSelected", true);
                trace.Entity:SetColor(0, 0, 255, 255);
            end
            if self.Owner:GetNWString("RC_team") == "headcrab" and rc_api.isHeadcrab(trace.Entity) == true then
                self:SetNWEntity("selectedEnt", trace.Entity);
                local r, g, b, a = trace.Entity:GetColor();
                trace.Entity:SetNWBool("isSelected", true);
                trace.Entity:SetColor(0, 0, 255, 255);
            end
        else
            self:SetNWEntity("selectedEnt", trace.Entity);
            local r, g, b, a = trace.Entity:GetColor();
            trace.Entity:SetNWBool("isSelected", true);
            trace.Entity:SetColor(0, 0, 255, 255);
        end
    end
end

function SWEP:SecondaryAttack()
    local trace = self.Owner:GetEyeTrace();

    local NPC = self:GetNWEntity("selectedEnt")

    if (IsValid(NPC) and NPC:IsNPC()) then

        if (IsValid(trace.Entity)) then
            if (IsValid(self:GetNWEntity("lastAttack"))) then
                if (trace.Entity == self:GetNWEntity("lastAttack")) then
                    NPC:AddEntityRelationship(self:GetNWEntity("lastAttack"), D_LI, 999);
                    self:SetNWEntity("lastAttack", nil);
                    return
                end
                NPC:AddEntityRelationship(self:GetNWEntity("lastAttack"), D_LI, 999);
                self:SetNWEntity("lastAttack", nil);
            end

            NPC:SetTarget(trace.Entity);
            NPC:AddEntityRelationship(trace.Entity, D_HT, 999);
            self:SetNWEntity("lastAttack", trace.Entity);

            -- useless :D
            -- NPC:SetLastPosition(trace.Entity:GetPos());
            -- NPC:SetSchedule(71);
        else
            NPC:SetLastPosition(trace.HitPos);
            NPC:SetSchedule(71);

            if (IsValid(self:GetNWEntity("lastAttack"))) then
                NPC:AddEntityRelationship(self:GetNWEntity("lastAttack"), D_LI, 999);
                self:SetNWEntity("lastAttack", nil);
            end
        end

    end
end
