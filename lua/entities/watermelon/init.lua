     AddCSLuaFile( "cl_init.lua" )
     AddCSLuaFile( "shared.lua" )
      
     include('shared.lua')

	function treesCount()
		local wms = ents.FindByClass("watermelon_plant_small")
		return #wms
	end

	 function ENT:SpawnFunction( ply, tr)
		local SpawnPos = tr.HitPos
		local ent = ents.Create( "watermelon" )
		ent:SetPos( SpawnPos + Vector(0,0,15) )
		ent:Spawn()
		return ent
	end

      
    function ENT:Initialize()
		
		self:SetModel("models/props_junk/watermelon01.mdl")
		self:PhysicsInit( SOLID_VPHYSICS ) // Make us work with physics,
		self:SetMoveType( SOLID_VPHYSICS ) // after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS ) // Toolbox 
		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():SetMass( 1 ) 
		self.lastmelon = math.Round(CurTime())
		self.age=0
    end

	function ENT:Think()
		if IsValid(self) then
			if GetConVarNumber("rc_remove")==1 then 
				self:Remove()
			end
		
			if self.age > GetConVarNumber("rc_watermelon_time") then
				local random = math.Round(math.random(0,2))
				if random == 2 and treesCount() <= GetConVarNumber("rc_tree_maxs") then
					local melon = ents.Create("watermelon_plant_small")
					undo.ReplaceEntity(self.Entity,melon)
					melon:SetPos(self:GetPos())
					melon:Spawn()
					melon:SetOwner(self.Owner)
				end
				self:Remove()
			else
				self.age = self.age + GetConVarNumber("rc_watermelon_time")
				self:NextThink( CurTime() + GetConVarNumber("rc_watermelon_time")/GetConVarNumber("rc_speed") )
				return true
			end
		end
	end
	
     
     function ENT:OnTakeDamage(dmg)
		self:Remove()
     end
	 
	    
	/*---------------------------------------------------------
	Name: OnRemove
	Desc: Called just before entity is deleted
	//-------------------------------------------------------*/


	function ENT:OnRemove()
	self:Remove()
	end