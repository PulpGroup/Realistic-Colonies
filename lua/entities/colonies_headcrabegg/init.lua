     AddCSLuaFile( "cl_init.lua" )
     AddCSLuaFile( "shared.lua" )
      
     include('shared.lua')
	 
	 function ENT:SpawnFunction( ply, tr)
		local SpawnPos = tr.HitPos + Vector( 0, 0, 15) 
		local ent = ents.Create( "colonies_headcrabegg" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		return ent
	end

      
    function ENT:Initialize()
		
		self:SetModel("models/props_junk/PopCan01a.mdl")
		self:PhysicsInit( SOLID_VPHYSICS ) // Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS ) // after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS ) // Toolbox 
		self:GetPhysicsObject():Wake()
		self:SetMaterial("models/debug/debugwhite")
		self.laid = math.Round(CurTime())
		self:SetNWBool("RC",true)
		self:SetNWBool("Eatable",true)
		self:SetNWString("rc_class","headcrab")
		self:SetNWInt("Food",GetConVarNumber("rc_food_headcrab_egg"))
    end
     
     function ENT:OnTakeDamage(dmg)
     self:Remove()
     end
	 
	    
	/*---------------------------------------------------------
	Name: OnRemove
	Desc: Called just before entity is deleted
	//-------------------------------------------------------*/
	function ENT:OnRemove()

	end
  
    
	function ENT:Think()
		if GetConVarNumber("rc_remove")==1 then 
			self:Remove()
		end
		if math.Round(CurTime()) > self.laid + GetConVarNumber("rc_headcrab_eggtime")/GetConVarNumber("rc_speed") then
			
			if headcrabCount() < GetConVarNumber("rc_headcrab_max") then
				local heady = ents.Create("colonies_headcrab")
				undo.ReplaceEntity(self.Entity,heady)
		
				heady:SetPos(self:GetPos()+Vector(0,0,15))
				heady:Spawn()
				heady:SetOwner(self.Owner)
			end
			
			self:Remove()
		
		end
		
		self:NextThink( CurTime() + GetConVarNumber("rc_antlion_eggtime")/GetConVarNumber("rc_speed") )
		return true
	end 