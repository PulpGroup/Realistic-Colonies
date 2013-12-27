    AddCSLuaFile( "cl_init.lua" )
    AddCSLuaFile( "shared.lua" )
	include("shared.lua")
	
	function humanCount()
		local hcs = ents.FindByClass("colonies_human")
		return #hcs
	end
	
	local hctypes = {
		"npc_citizen"
	}
	
	function ENT:SpawnFunction( ply, tr)
		if humanCount() < GetConVarNumber("rc_human_max") then
			local SpawnPos = tr.HitPos
			local ent = ents.Create( "colonies_human" )
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
		self.nextegg = GetConVarNumber("rc_human_maturetime") + GetConVarNumber("rc_human_pregtime") + math.Round(math.random(-2,2))
		self.npc.melon=nil
		self.hunger = 0
		self.mhunger = GetConVarNumber("rc_headcrab_mhunger")
		self.age=0
		self.npc:SetNWInt("G",0)
		self.npc:SetNWInt("R",0)
		self.npc:SetNWInt("Z",5)
		
		self.maxhp = 50
		self.hpregen = 1
		self.scale = 0.1
		
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
			self.npc:AddRelationship("npc_human D_NU 999")
			self.npc:AddRelationship("npc_npc_human_black D_NU 999")
			self.npc:AddRelationship("npc_zombie D_NU 999")
		end
		
		self.npc:SetModelScale(self.scale,0);
		self.npc:SetHealth(5);
		self.npc:SetNWInt("HChealth", self.npc:Health() );
		
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
	
		self.hunger = self.hunger + GetConVarNumber("rc_human_hunger")*GetConVarNumber("rc_time")*GetConVarNumber("rc_speed")
		self.npc:SetNWInt("HChunger",self.hunger)
		
		if( !IsValid(self.npc) ) then
			local meat = ents.Create("colonies_humanmeat")
			meat:SetPos(self:GetPos()+Vector(0,0,10010))
			meat:SetModelScale(self.scale,0);
			meat:Spawn()
			self:Remove()
		else
			if GetConVarNumber("rc_remove")==1 then 
				self:Remove()
			end
			
			-- POS for the meat
			self:SetPos(self.npc:GetPos()-Vector(0,0,10000))

			if self.age >  GetConVarNumber("rc_human_lifespan") then
				self:Remove()
				if GetConVarNumber("rc_printevents") == 1 then
					PrintMessage(HUD_PRINTTALK,"headcrab "..self.name.." died (age).")
				end
			end

			if self.age > GetConVarNumber("rc_human_maturetime") and self.npc:GetNWBool("isSelected")==false  then
				self.npc:SetColor( Color(255,255,255,255) )
			end

			if self.age > self.nextegg and headcrabCount() <= GetConVarNumber("rc_human_max") and self.hunger <= self.mhunger then
				local egg = ents.Create("colonies_humanegg")
				egg:SetPos(self.npc:GetPos()+Vector(0,0,15))
				egg:Spawn()
				self.nextegg = self.age + GetConVarNumber("rc_human_pregtime") + math.Round(math.random(-2,2))
			end
			
			
			--eating script
			if self.hunger > 40 then
			
				--dieing of starvation thing
				if self.hunger >= self.mhunger then
					self.npc:SetHealth(self.npc:Health()-1*GetConVarNumber("rc_speed")*GetConVarNumber("rc_time"))
					if(self.npc:Health() <= 0) then
						if GetConVarNumber("rc_printevents") == 1 then
							PrintMessage(HUD_PRINTTALK,"headcrab "..self.name.." died (starvation).")
						end
						local meat = ents.Create("colonies_humanmeat")
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
							if  thent:GetClass() == "watermelon" or thent:GetClass() == "colonies_antlionmeat" or thent:GetClass() == "colonies_headcrabmeat"
							or thent:GetClass() == "colonies_headcrabegg" or thent:GetClass() == "colonies_antliobegg" then
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
					--eat antlionmeat
					elseif thent:GetClass() == "colonies_antlionmeat" then
						thent:Remove()
						self.hunger = self.hunger - 60*thent:GetModelScale()
						break
					--eat headcrabmeat
					elseif thent:GetClass() == "colonies_headcrabmeat" then
						thent:Remove()
						self.hunger = self.hunger - 35*thent:GetModelScale()
						break
					-- headcrab egg
					elseif thent:GetClass() == "colonies_headcrabegg" then
						thent:Remove()
						self.hunger = self.hunger - 30*thent:GetModelScale()
						break
					-- antlion egg
					elseif thent:GetClass() == "colonies_antlionegg" then
						thent:Remove()
						self.hunger = self.hunger - 50*thent:GetModelScale()
						break
					end
				end
				if self.hunger < 0 then
					self.hunger = 0
				end
			else
				if self.npc:Health() < self.maxhp then
					self.npc:SetHealth(self.npc:Health()+self.hpregen*GetConVarNumber("rc_speed")*GetConVarNumber("rc_time"))
				end
			end
			self.npc:SetNWInt("HChealth", self.npc:Health() );
			if self.age <= GetConVarNumber("rc_human_maturetime") then
				self.scale = 0.1 + (self.age/GetConVarNumber("rc_human_maturetime"))*(0.9)
				self.npc:SetModelScale(self.scale,GetConVarNumber("rc_time"));
			end
			self.npc:SetNWInt("G",255*(self.mhunger-self.hunger)/self.hunger)
			self.npc:SetNWInt("R",255*self.hunger/self.mhunger)
			self.npc:SetNWInt("Z",5 + 75*self.scale)
			self:NextThink( CurTime() + GetConVarNumber("rc_time") )
			return true
		end
	end