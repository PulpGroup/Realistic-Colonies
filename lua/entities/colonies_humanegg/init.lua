     AddCSLuaFile( "cl_init.lua" )
     AddCSLuaFile( "shared.lua" )
      
     include('shared.lua')
	 
	 function ENT:SpawnFunction( ply, tr)
		local SpawnPos = tr.HitPos + Vector( 0, 0, 15) 
		local ent = ents.Create( "colonies_humanegg" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		return ent
	end

      
    function ENT:Initialize()
		
		self:SetModel("models/props_c17/doll01.mdl")
		self:PhysicsInit( SOLID_VPHYSICS ) // Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS ) // after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS ) // Toolbox 
		self:GetPhysicsObject():Wake()
		self.laid = math.Round(CurTime())
		self:SetNWBool("RC",true)
		
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
		if math.Round(CurTime()) > self.laid + GetConVarNumber("rc_human_eggtime") then
			
			if humanCount() < GetConVarNumber("rc_human_max") then
				local heady = ents.Create("colonies_human")
				undo.ReplaceEntity(self.Entity,heady)
		
				heady:SetPos(self:GetPos()+Vector(0,0,15))
				heady:Spawn()
				heady:SetOwner(self.Owner)
			end
			
			self:Remove()
		
		end
		
		self:NextThink( CurTime() + GetConVarNumber("rc_time") )
		return true
	end 