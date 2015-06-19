     AddCSLuaFile( "cl_init.lua" )
     AddCSLuaFile( "shared.lua" )
      
     include('shared.lua')
	 
	function watermelonCount()
		local wms = ents.FindByClass("watermelon")
		return #wms
	end

	function treemCount()
		local wms = ents.FindByClass("watermelon_plant_medium")
		return #wms
	end
	 
	 function ENT:SpawnFunction( ply, tr)
		local SpawnPos = tr.HitPos
		local ent = ents.Create( "watermelon_plant_small" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		return ent
	end

      
    function ENT:Initialize()
		
		self:SetModel("models/props_foliage/shrub_01a.mdl")
		self:SetSolid( SOLID_VPHYSICS ) // Toolbox
		self:SetNWBool("RC",true)
		self.age=0
		self.nextmelon=GetConVarNumber("rc_watermelons_time")
		
    end
     
     function ENT:OnTakeDamage(dmg)
     end
	 	    
	function ENT:Think()
		if GetConVarNumber("rc_remove")==1 then 
			self:Remove()
		end
		
		if self.age > GetConVarNumber("rc_watermelonb_life") then
			local random = math.Round(math.random(0,3))
			if random == 3 and treemCount() <= GetConVarNumber("rc_tree_maxm") then
				local melon = ents.Create("watermelon_plant_medium")
				undo.ReplaceEntity(self.Entity,melon)
				melon:SetPos(self:GetPos())
				melon:Spawn()
				melon:SetOwner(self.Owner)
			end
			self:Remove()
		end
		if self.age > self.nextmelon  and watermelonCount() <= GetConVarNumber("rc_watermelon_max") then
			self.nextmelon = GetConVarNumber("rc_watermelons_time") + self.age
			local melon = ents.Create("watermelon")
			local dist = GetConVarNumber("rc_watermelons_distance")
			melon:SetPos(self:GetPos()+Vector(math.random(-dist,dist),math.random(-dist,dist),40))
			melon:Spawn()
			melon:SetOwner(self.Owner)
			melon:SetModelScale(GetConVarNumber("rc_watermelons_size")/100,0);
		end
		
		self.age = self.age + 1
		self:NextThink( CurTime() + GetConVarNumber("rc_planttime") )
		return true
	end 