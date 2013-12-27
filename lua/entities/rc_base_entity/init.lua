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
 
function ENT:Use( activator, caller )
    return
end