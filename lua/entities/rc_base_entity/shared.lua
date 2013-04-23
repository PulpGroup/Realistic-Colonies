-- ----------------------------------------------------------------------------------------------
-- Realistic Colonies Base Entity
-- Base for all rc entities
-- 
-- Copyright @ Wamilou and The Surfer
-- ----------------------------------------------------------------------------------------------

ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName		= "RC Base Entity"
ENT.Author			= "wamilou"
ENT.Contact			= ""
ENT.Purpose			= "Base Entity for RC"
ENT.Instructions	= "Base Entity for RC - Don't spawn it !"

ENT.Category = "Realistic Colonies" -- Catégorie pour les entités RC
  
ENT.Spawnable	= true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true

ENT.Editable = true -- Permet de debugguer !

function ENT:SetupDataTables() 
 	self:NetworkVar( "String",	0, "RCName" , { KeyName = "rcname", Edit = { type = "String" } } );
	self:NetworkVar( "String",	1, "RCDesc" , { KeyName = "rcdesc", Edit = { type = "String" } } );
	self:NetworkVar( "Entity",	2, "RCEntity" , { KeyName = "rcdrawoffset", Edit = { type = "Entity" } } );
	self:NetworkVar( "String",	3, "RCClass" , { KeyName = "rcclass", Edit = { type = "String" } } );
	self:NetworkVar( "Float",	0, "RCHealth" , { KeyName = "rchealth", Edit = { type = "Float" , min=0 } } );
	self:NetworkVar( "Float",	1, "RCHunger" , { KeyName = "rchunger", Edit = { type = "Float" , min=0 } } );
	
	self:NetworkVar( "Vector",	2, "RCDrawOffset" , { KeyName = "rcdrawoffset", Edit = { type = "Vector" } } );		
end