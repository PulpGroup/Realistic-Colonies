rc_api = {};

-- Savoir si une entity est de RC
function rc_api.isRC(ent)
	if ent!=nil and ent:IsValid() then
		if ( ent:GetNWBool("RC") ) then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

-- Savoir si une entity est de la nourriture
function rc_api.isFood(ent)
	if ( rc_api.isRC(ent) ) then
		if  ent:GetClass() == "watermelon" or ent:GetClass() == "colonies_hmeat" or ent:GetClass() == "colonies_ameat" then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

-- Savoir si une entity est un npc de RC
function rc_api.isNpc(ent)
	if ( ent:GetClass() == "npc_headcrab" or ent:GetClass() == "npc_headcrab_black" or ent:GetClass() == "npc_zombie" or ent:GetClass() == "npc_antlion" or ent:GetClass() == "npc_citizen") then
		if( ent:GetNWBool("HC") == true ) then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

-- Savoir si une entity est un zombie/headcrab
function rc_api.isHeadcrab(ent)
	if ( rc_api.isNpc(ent) ) then
		if( ent:GetClass() == "npc_headcrab" or ent:GetClass() == "npc_headcrab_black" or ent:GetClass() == "npc_zombie" ) then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

-- Savoir si une entity est un antlion
function rc_api.isAntlion(ent)
	if ( rc_api.isNpc(ent) and ent:GetClass() == "npc_antlion" ) then
		return true;
	else
		return false;
	end
end

-- Prend la nourriture la plus proche
function rc_api.getNearestFood(ent)
	local pos = ent:GetPos();
	local objets = ents.FindInSphere(pos, GetConVarNumber("rc_searchrad") );
	local dist = GetConVarNumber("rc_searchrad");
	local eating = nil;
	
	for k, v in pairs(objets) do
		if( rc_api.isFood(v) ) then
			if(v:GetPos():Distance(pos) < dist) then
				eating = v;
				dist = v:GetPos():Distance(pos);
			end
		end
	end
	
	return eating;
end