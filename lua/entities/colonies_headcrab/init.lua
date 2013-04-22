    AddCSLuaFile( "cl_init.lua" )
    AddCSLuaFile( "shared.lua" )
	include("shared.lua")
	
	function headcrabCount()
		local hcs = ents.FindByClass("colonies_headcrab")
		return #hcs
	end
	
	local hctypes = {
		"npc_headcrab",
		"npc_headcrab_black"
	}
	
	function ENT:SpawnFunction( ply, tr)
		if headcrabCount() < GetConVarNumber("rc_headcrab_max") then
			local SpawnPos = tr.HitPos
			local ent = ents.Create( "colonies_headcrab" )
			ent:SetPos( SpawnPos )
			ent:Spawn()
			return ent
		end
		return nil
	end
      
    function ENT:Initialize()	
		
		local crab = ents.Create(hctypes[math.random(1,#hctypes)])
		self.npc = crab
		local spawnflags = SF_NPC_ALWAYSTHINK 
		self.npc:SetKeyValue("spawnflags",spawnflags)
		self.npc:SetPos(self:GetPos())
		self.npc:Spawn()
		self.npc:Activate()
		self.npc:SetOwner(self.Owner)
		
		--set color and value
		self.name = coloniesnames[math.random(1,#coloniesnames)]
		self.nextegg = GetConVarNumber("rc_headcrab_maturetime") + GetConVarNumber("rc_headcrab_pregtime") + math.Round(math.random(-2,2))
		self.npc.melon=nil
		self.hunger = 0
		self.age=0
		
		self.maxhp = 20
		self.hpregen = 1
		self.scale = 0.5
		
		self.npc:SetNWString("HCname",self.name)
		self.npc:SetNWBool("HC",true)
		self.npc:SetNWBool("RC",true)
		self.npc:SetNWBool("isSelected",false)
		
		--setup disposition
		if GetConVarNumber("rc_hateplayers") == 0 then
			self.npc:AddRelationship("player D_NU 999")
		end
		
		if GetConVarNumber("rc_spreadthelove") == 1 then
			self.npc:AddRelationship("npc_antlion D_NU 999")
			self.npc:AddRelationship("npc_headcrab D_NU 999")
			self.npc:AddRelationship("npc_npc_headcrab_black D_NU 999")
			self.npc:AddRelationship("npc_zombie D_NU 999")
		end
		
		if(SERVER) then
			self.npc:SetModelScale(self.scale,0);
			self.npc:SetHealth(5);
			self.npc:SetNWInt("HChealth", self.npc:Health() );
		end
		
    end
     
     function ENT:OnTakeDamage(dmg)
    
     end
	 
	    
	/*---------------------------------------------------------
	Name: OnRemove
	Desc: Called just before entity is deleted
	//-------------------------------------------------------*/
	function ENT:OnRemove()
		-- kill the npc
		if IsValid(self.npc) == true then
			self.npc:Remove(0)
		end
	end
  
   
	function ENT:Think()
	
		self.age = self.age+ GetConVarNumber("rc_time")*GetConVarNumber("rc_speed")
		self.npc:SetNWInt("HCage",self.age)
	
		self.hunger = self.hunger + GetConVarNumber("rc_headcrab_hunger")*GetConVarNumber("rc_time")*GetConVarNumber("rc_speed")
		self.npc:SetNWInt("HChunger",self.hunger)
	
		if(SERVER and IsValid(self.npc) ) then
			self.npc:SetNWInt("HChealth", self.npc:Health() );
			if self.age <= GetConVarNumber("rc_headcrab_maturetime") then
				self.scale = 0.5 + (self.age/GetConVarNumber("rc_headcrab_maturetime"))*(0.5)
				self.npc:SetModelScale(self.scale,GetConVarNumber("rc_time"));
			end
		end
	
		if GetConVarNumber("rc_remove")==1 then 
			self:Remove()
		end

		--Is the headrab still alive?
		if IsValid(self.npc) == false then
			local meat = ents.Create("colonies_hmeat")
			meat:SetPos(self:GetPos()+Vector(0,0,10010))
			meat:SetModelScale(self.scale,0);
			meat:Spawn()
			self:Remove()
		else

		if GetConVarNumber("rc_spreadthelove") == 0 and self.hunger>GetConVarNumber("rc_headcrab_mhunger")*0.70 then
			self.npc:AddRelationship("npc_headcrab D_HT 999")
			self.npc:AddRelationship("npc_npc_headcrab_black D_HT 999")
			self.npc:AddRelationship("npc_zombie D_HT 999")
		else
			self.npc:AddRelationship("npc_headcrab D_LI 999")
			self.npc:AddRelationship("npc_npc_headcrab_black D_LI 999")
			self.npc:AddRelationship("npc_zombie D_LI 999")
		end

		

		-- POS for the meat
		self:SetPos(self.npc:GetPos()-Vector(0,0,10000))

		if self.age >  GetConVarNumber("rc_headcrab_lifespan") then
			self:Remove()
			if GetConVarNumber("rc_printevents") == 1 then
				PrintMessage(HUD_PRINTTALK,"Headcrab "..self.name.." died (age).")
			end
		end

		if self.age > GetConVarNumber("rc_headcrab_maturetime") and self.npc:GetNWBool("isSelected")==false  then
			self.npc:SetColor( Color(255,255,255,255) )
		end

		if self.age > self.nextegg and headcrabCount() <= GetConVarNumber("rc_headcrab_max") then
			local rand = math.Round(math.random(1,2.4))
			for i=1,rand do
				local egg = ents.Create("colonies_headcrabegg")
				egg:SetPos(self.npc:GetPos()+Vector(0,0,15))
				egg:Spawn()
			end
			self.nextegg = self.age + GetConVarNumber("rc_headcrab_pregtime") + math.Round(math.random(-2,2))
		end
		
		
		--eating script
		if self.hunger > 40 then
		
			--dieing of starvation thing
			if self.hunger >= GetConVarNumber("rc_headcrab_mhunger") then
				self.npc:SetHealth(self.npc:Health()-1)
				if(self.npc:Health() <= 0) then
					if GetConVarNumber("rc_printevents") == 1 then
						PrintMessage(HUD_PRINTTALK,"headcrab "..self.name.." died (starvation).")
					end
					local meat = ents.Create("colonies_hmeat")
					meat:SetPos(self:GetPos()+Vector(0,0,10010))
					meat:SetModelScale(self.scale,0);
					meat:Spawn()
					self:Remove()
				end
			end
			
			if self.hunger>45 then
			
				--seaching food stuff
				local closest = GetConVarNumber("rc_searchrad")
				local sphents = ents.FindInSphere(self.npc:GetPos(),GetConVarNumber("rc_searchrad"))
				for i, thent in ipairs(sphents) do
					if IsValid(thent) and thent:GetPos():Distance(self.npc:GetPos())<closest then
						if  thent:GetClass() == "watermelon" or thent:GetClass() == "colonies_ameat" or thent:GetClass() == "colonies_hmeat" then
							closest = thent:GetPos():Distance(self.npc:GetPos())
							self.npc:SetLastPosition(thent:GetPos()+Vector(0,0,0))
							self.npc:SetSchedule(71)
							self.npc.melon = thent
						end
					end
				end
				
				if IsValid(self.npc.melon) then
					self.npc:SetLastPosition(self.npc.melon:GetPos()+Vector(0,0,0))
					self.npc:SetSchedule(71)
				end
			end 
			-- eating stuff
			local sphents = ents.FindInSphere(self.npc:GetPos(),32)
			for i, thent in ipairs(sphents) do
				--eat Watermelon
				if thent:GetClass() == "watermelon" then
					thent:Remove()
					self.hunger = self.hunger - 50*thent:GetModelScale()
					break
				--eat Ameat
				elseif thent:GetClass() == "colonies_ameat" then
					thent:Remove()
					self.hunger = self.hunger - 60*thent:GetModelScale()
					break
				--eat Hmeat
				elseif thent:GetClass() == "colonies_hmeat" then
					thent:Remove()
					self.hunger = self.hunger - 35*thent:GetModelScale()
					break
				end
			end
			if self.hunger < 0 then
				self.hunger = 0
			end
		else
			if self.npc:Health() < self.maxhp then
				self.npc:SetHealth(self.npc:Health()+self.hpregen)
			end
		end
		self:NextThink( CurTime() + GetConVarNumber("rc_time") )
		return true
	end
end