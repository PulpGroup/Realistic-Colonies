-- ----------------------------------------------------------------------------------------------
-- Realistic Colonies Base Entity
-- Base for all rc entities
-- 
-- Copyright @ Wamilou and The Surfer
-- ----------------------------------------------------------------------------------------------

include('shared.lua')

ENT.RenderGroup = RENDERGROUP_BOTH

surface.CreateFont( "RCTitle", {
	font = "BudgetLabel",
	size = 48,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )
surface.CreateFont( "RCDesc", {
	font = "BudgetLabel",
	size = 14,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = true,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function ENT:Draw()
    self:DrawModel()
	
	local ang = LocalPlayer():EyeAngles()
	local pos = self:GetPos() + self:GetRCDrawOffset()
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
	
	local healthColor = Color( (100-self:GetRCHealth())*255 , self:GetRCHealth()*255 , 0  , 255 )
	local hungerColor = Color( self:GetRCHunger()*255 , (100-self:GetRCHunger())*255 , 0  , 255 )
	
	-- On dessine le nom et la description
	cam.Start3D2D( pos, Angle(0,ang.y,90), 0.2 )
        draw.DrawText(self:GetRCName(), "RCTitle", 0, 0, healthColor, TEXT_ALIGN_CENTER )
		draw.DrawText(self:GetRCDesc(), "RCDesc", 0, 44, hungerColor, TEXT_ALIGN_CENTER )
    cam.End3D2D()
end