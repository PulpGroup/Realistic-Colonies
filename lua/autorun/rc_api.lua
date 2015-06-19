rc_api = {};

-- Savoir si une entity est de RC
function rc_api.isRC(ent)
	if ent!=nil and ent:IsValid() then
		return ent:GetNWBool("RC",false);
	end
	return false;
end

-- Savoir si une entity est de la nourriture valable pour un npc.
function rc_api.isValidFood(npc,ent)
	if ( rc_api.isFood(ent) ) then
		return (ent:GetNWString("rc_class","") != npc:GetNWString("rc_class",""));
	end
	return false;
end
-- Savoir si une entity est de la nourriture
function rc_api.isFood(ent)
	if ( rc_api.isRC(ent) ) then
		return ent:GetNWBool("Eatable",false);
	else
		return false;
	end
end

-- Savoir si une entity est un npc de RC
function rc_api.isNpc(ent)
	if ( rc_api.isRC(ent) ) then
		return ent:GetNWBool("HC",false);
	else
		return false;
	end
end

-- Savoir si une entity est un zombie/headcrab
function rc_api.isHeadcrab(ent)
	if ( rc_api.isNpc(ent) ) then
		return (ent:rc_class() == "headcrab");
	else
		return false;
	end
end

-- Savoir si une entity est un antlion
function rc_api.isAntlion(ent)
	if ( rc_api.isNpc(ent) ) then
		return (ent:rc_class() == "antlion");
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
		if( rc_api.isValidFood(ent,v) ) then
			if ( v:GetPos():Distance(pos) < dist ) then
				eating = v;
				dist = v:GetPos():Distance(pos);
			end
		end
	end
	
	return eating;
end