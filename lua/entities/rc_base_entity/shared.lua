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

function ENT:Initialize()
	if SERVER then
		self:SetModel( "models/props_interiors/BathTub01a.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	 
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
	end
	
	self.ThinkInterval = 0.01 -- NE PAS MODIFIER !
	
	self.RCThinkIterator = 0 -- NE PAS MODIFIER !
	self.RCThinkInterval = 1 -- Peut être modifier pour changer l'interval de calcul
end

function ENT:SetupDataTables() 
 	self:NetworkVar( "String",	0, "RCName" , { KeyName = "rcname", Edit = { type = "String" } } );
	self:NetworkVar( "String",	1, "RCDesc" , { KeyName = "rcdesc", Edit = { type = "String" } } );	
	self:NetworkVar( "String",	2, "RCClass" , { KeyName = "rcclass", Edit = { type = "String" } } );
	
	self:NetworkVar( "Entity",	0, "RCEntity" , { KeyName = "rcdrawoffset", Edit = { type = "Entity" } } );
	
	self:NetworkVar( "Int",	0, "RCHealth" , { KeyName = "rchealth", Edit = { type = "Int" , min=0 , max=100 } } );
	self:NetworkVar( "Int",	1, "RCHunger" , { KeyName = "rchunger", Edit = { type = "Int" , min=0 , max=100 } } );
	self:NetworkVar( "Int",	2, "RCAge" , { KeyName = "rcage", Edit = { type = "Int" , min=0 , max=1000 } } )
	
	self:NetworkVar( "Vector",	0, "RCDrawOffset" , { KeyName = "rcdrawoffset", Edit = { type = "Vector" } } );		
end

function ENT:DoRCAnimation() -- Pour créer des animations fluides 8D
end

function ENT:DoRCThink() -- La nouvelle fonction permettant le calcul pour les entities RC
end 

function ENT:Think()
	if self.RCThinkIterator >= (self.RCThinkInterval*100) then
		self:DoRCThink()
		self.RCThinkIterator = 0
	end
	self.RCThinkIterator = self.RCThinkIterator + 1
	
	self:DoRCAnimation()

    self:NextThink( CurTime() + self.ThinkInterval )
	return true
end