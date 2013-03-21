     AddCSLuaFile( "cl_init.lua" )
     AddCSLuaFile( "shared.lua" )
      
     include('shared.lua')
	 
	function watermelonCount()
		local wms = ents.FindByClass("watermelon")
		return #wms
	end


	function treefCount()
		local wms = ents.FindByClass("watermelon_plant")
		return #wms
	end
	 
	 function ENT:SpawnFunction( ply, tr)
		local SpawnPos = tr.HitPos
		local ent = ents.Create( "watermelon_plant_grow" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		return ent
	end

      
    function ENT:Initialize()
		
		self:SetModel("models/props_foliage/tree_deciduous_01a.mdl")
		self:PhysicsInit( SOLID_VPHYSICS ) // Make us work with physics,
		self:SetSolid( SOLID_VPHYSICS ) // Toolbox 
		self:GetPhysicsObject():EnableMotion(false)
		self.lastmelon_plant = math.Round(CurTime())
		self.lastmelon = math.Round(CurTime())
		self:SetNWBool("RC",true)
		self.age=0
		self.nextmelon=GetConVarNumber("rc_watermelonbg_time")
		
    end
     
     function ENT:OnTakeDamage(dmg)
     end
	 	    
	function ENT:Think()
		if GetConVarNumber("rc_remove")==1 then 
			self:Remove()
		end
		
		self.age = self.age + GetConVarNumber("rc_planttime")*GetConVarNumber("rc_speed")
		if self.age > GetConVarNumber("rc_watermelonbgg_time") and treefCount() <= GetConVarNumber("rc_tree_max") then
			local melon = ents.Create("watermelon_plant")
			undo.ReplaceEntity(self.Entity,melon)
			melon:SetPos(self:GetPos()+Vector(0,0,0))
			melon:Spawn()
			melon:SetOwner(self.Owner)
			self:Remove()
		end
		if self.age > self.nextmelon  and watermelonCount() <= GetConVarNumber("rc_watermelon_max") then
			self.nextmelon = GetConVarNumber("rc_watermelonbg_time") + self.age
			local melon = ents.Create("watermelon")
			local dist = GetConVarNumber("rc_watermelong_distance")
			melon:SetPos(self:GetPos()+Vector(math.random(-dist,dist),math.random(-dist,dist),200))
			melon:Spawn()
			melon:SetOwner(self.Owner)
			self.lastmelon = math.Round(CurTime())
		end
		self:NextThink( CurTime() + GetConVarNumber("rc_planttime") )
		return true
	end 