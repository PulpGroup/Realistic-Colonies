-- ----------------------------------------------------------------------------------------------
-- Realistic Colonies Base Entity
-- Base for all rc entities
-- 
-- Copyright @ Wamilou and The Surfer
-- ----------------------------------------------------------------------------------------------

include('shared.lua')

ENT.RenderGroup = RENDERGROUP_BOTH
surface.CreateFont( "BudgetLabel", 48, 500, true, true, "RCTitle" )
 
function ENT:Draw()
    self:DrawModel()
	
	local ang = LocalPlayer():EyeAngles()
	local pos = self:GetPos() + self:GetRCDrawOffset()
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
	
	cam.Start3D2D( pos, Angle(0,ang.y,90), 0.2 )
        draw.DrawText(self:GetRCName(), "RCTitle", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
		draw.DrawText(self:GetRCDesc(), "BudgetLabel", 0, 12, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
    cam.End3D2D()
end