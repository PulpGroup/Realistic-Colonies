-- ----------------------------------------------------------------------------------------------
-- Realistic Colonies Base Entity
-- Base for all rc entities
-- 
-- Copyright @ Wamilou and The Surfer
-- ----------------------------------------------------------------------------------------------

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include("shared.lua")

function ENT:SpawnFunction( ply, tr)
	local SpawnPos = tr.HitPos
	local ent = ents.Create( "rc_base_entity" )
	ent:SetPos( SpawnPos + Vector(0,0,15) )
	ent:Spawn()
	return ent
end
 
function ENT:Initialize()
 
	self:SetModel( "models/props_interiors/BathTub01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    -- We don't need to think, we are just a prop after all!
end