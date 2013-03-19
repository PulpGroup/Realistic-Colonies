// Show debug info?
local debug = true
 
//----------------------------------------------
//Author Info
//----------------------------------------------
SWEP.Author             = "wamilou"
SWEP.Contact            = "wamilou@gmail.com"
SWEP.Purpose            = ""
SWEP.Instructions       = "Left click : Select entity, right click : order :D and reload to open the build menu :P"
//----------------------------------------------
 
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
    if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType );
	end
	
	self:SetNWEntity("selectedEnt", nil);
	self:SetNWVector("color", Vector(255,255,255));
end 
 
//--------------------------------------------
// Called when it reloads 
//--------------------------------------------
function SWEP:Reload()
	
end
 
 
//--------------------------------------------
// Called each frame when the Swep is active
//--------------------------------------------
function SWEP:Think()
	if(SERVER) then
		self:SetColor(255,255,255,0); -- Faire disparaitre le pistolet
		
		if(self:GetNWEntity("selectedEnt") != nil and self:GetNWEntity("selectedEnt"):IsValid()) then
			self:GetNWEntity("selectedEnt"):SetColor(0,0,255,255);
		end
	end
end 
 
//--------------------------------------------
// Called when the player Shoots
//--------------------------------------------
function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace();
	
	if(self:GetNWEntity("selectedEnt") != nil and self:GetNWEntity("selectedEnt"):IsValid()) then
		local color = self:GetNWVector("color");
	
		self:GetNWEntity("selectedEnt"):SetColor(color.x,color.y,color.z,255);
		self:GetNWEntity("selectedEnt"):SetNWBool("isSelected", false);
		
		self:SetNWEntity("selectedEnt", nil);
	end
	
	if(trace.Entity != nil and trace.Entity:IsValid() and rc_api.isNpc(trace.Entity)==true) then	
		if( GetConVarString("rc_gamemode_enabled") == "1" ) then
			if self.Owner:GetNWString("RC_team")=="antlion" and rc_api.isAntlion(trace.Entity)==true then
				self:SetNWEntity("selectedEnt", trace.Entity);
				local r,g,b,a = trace.Entity:GetColor();
				self:SetNWVector("color", Vector(r,g,b));
				trace.Entity:SetNWBool("isSelected", true);
				trace.Entity:SetColor(0,0,255,255);
			end
			if self.Owner:GetNWString("RC_team")=="headcrab" and rc_api.isHeadcrab(trace.Entity)==true then
				self:SetNWEntity("selectedEnt", trace.Entity);
				local r,g,b,a = trace.Entity:GetColor();
				self:SetNWVector("color", Vector(r,g,b));
				trace.Entity:SetNWBool("isSelected", true);
				trace.Entity:SetColor(0,0,255,255);
			end
		else
			self:SetNWEntity("selectedEnt", trace.Entity);
			local r,g,b,a = trace.Entity:GetColor();
			self:SetNWVector("color", Vector(r,g,b));
			trace.Entity:SetNWBool("isSelected", true);
			trace.Entity:SetColor(0,0,255,255);
		end
	end
end
 
 
//--------------------------------------------
// Called when the player Uses secondary attack
//--------------------------------------------
function SWEP:SecondaryAttack()
	local trace = self.Owner:GetEyeTrace();
	
	if( self:GetNWEntity("selectedEnt") != nil and self:GetNWEntity("selectedEnt"):IsValid() and self:GetNWEntity("selectedEnt"):IsNPC() ) then
		
		if( trace.Entity != nil and trace.Entity:IsValid() ) then
			self:GetNWEntity("selectedEnt"):SetTarget(trace.Entity);
			self:GetNWEntity("selectedEnt"):AddEntityRelationship( trace.Entity, D_HT, 999 );
			self:SetNWEntity("lastAttack", trace.Entity );
			
			self:GetNWEntity("selectedEnt"):SetLastPosition(trace.Entity:GetPos());
			self:GetNWEntity("selectedEnt"):SetSchedule(71);
		else					
			self:GetNWEntity("selectedEnt"):SetLastPosition(trace.HitPos);
			self:GetNWEntity("selectedEnt"):SetSchedule(71);
			
			if( self:GetNWEntity("lastAttack") != nil and self:GetNWEntity("lastAttack"):IsValid() ) then
				self:GetNWEntity("selectedEnt"):AddEntityRelationship( self:GetNWEntity("lastAttack"), D_LI, 999 );
			
				self:SetNWEntity("lastAttack", nil);
			end
		end
		
	end
end