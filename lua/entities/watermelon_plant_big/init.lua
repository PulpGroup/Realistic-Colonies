     AddCSLuaFile( "cl_init.lua" )
     AddCSLuaFile( "shared.lua" )
      
     include('shared.lua')
	 
	function watermelonCount()
		local wms = ents.FindByClass("watermelon")
		return #wms
	end


	function treehCount()
		local wms = ents.FindByClass("watermelon_plant_huge")
		return #wms
	end
	 
	 function ENT:SpawnFunction( ply, tr)
		local SpawnPos = tr.HitPos
		local ent = ents.Create( "watermelon_plant_big" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		return ent
	end

      
    function ENT:Initialize()
		
		self:SetModel("models/props_foliage/tree_deciduous_01a.mdl")
		self:PhysicsInit( SOLID_VPHYSICS ) // Make us work with physics,
		self:SetSolid( SOLID_VPHYSICS ) // Toolbox 
		self:GetPhysicsObject():EnableMotion(false)
		self:SetNWBool("RC",true)
		self.mage=GetConVarNumber("rc_watermelonb_life")
		self.age = 0
		self.nextmelon=GetConVarNumber("rc_watermelonb_time")
    end
     
     function ENT:OnTakeDamage(dmg)
     end
	 	    
	function ENT:Think()
		if GetConVarNumber("rc_remove")==1 then 
			self:Remove()
		end
		
		if self.age > self.mage then
		
			local random = math.Round(math.random(0,3))
			if random == 3 and treehCount() <= GetConVarNumber("rc_tree_maxh") then
				local melon = ents.Create("watermelon_plant_huge")
				undo.ReplaceEntity(self.Entity,melon)
				melon:SetPos(self:GetPos())
				melon:Spawn()
				melon:SetModelScale(GetConVarNumber("rc_watermelonb_size")/100,0);
				melon:SetOwner(self.Owner)
			end
			self:Remove()
		end
		if self.age > self.nextmelon  and watermelonCount() <= GetConVarNumber("rc_watermelon_max") then
			self.nextmelon = self.nextmelon + GetConVarNumber("rc_watermelonb_time")*math.random(90,110)/100
			local melon = ents.Create("watermelon")
			local dist = GetConVarNumber("rc_watermelonb_distance")
			melon:SetPos(self:GetPos()+Vector(math.random(-dist,dist),math.random(-dist,dist),80))
			melon:Spawn()
			melon:SetOwner(self.Owner)
			melon:SetModelScale(GetConVarNumber("rc_watermelonb_size")/100,0);
		end
		
		self.age = self.age + GetConVarNumber("rc_planttime")*GetConVarNumber("rc_speed")
		self:NextThink( CurTime() + GetConVarNumber("rc_planttime") )
		return true
	end 