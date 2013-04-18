CreateConVar( "rc_gamemode_enabled", "0", FCVAR_UNREGISTERED );

local last_gm = "";

local function enableRC_GM(CVar, PreviousValue, NewValue)
	if (PreviousValue != NewValue and NewValue == "1") then
	
		-- Tue tous les joueurs
		for k, v in pairs(player.GetAll()) do
			v:Kill();
		end	

		last_gm = gmod.GetGamemode().Name;
		gmod.GetGamemode().Name = "Realistic Colonies 2";
	
	else
		gmod.GetGamemode().Name = last_gm;
	end
end
cvars.AddChangeCallback("rc_gamemode_enabled", enableRC_GM);

-- Donne au joueur l'order gun
function RC_PlayerSet( ply )
 
	if( GetConVarString("rc_gamemode_enabled") == "1" ) then
		ply:Give("rc_order_gun"); 
		ply:SelectWeapon("rc_order_gun");
 
		return true;
	end
	
end 
hook.Add( "PlayerLoadout", "RC_PlayerSet", RC_PlayerSet);

-- Lors du spawn du joueur
function RC_PlayerSpawn( ply )
	if( GetConVarString("rc_gamemode_enabled") == "1" ) then
		datastream.StreamToClients( ply, "RC_ChooseTeam", nil );
	end
end
hook.Add( "PlayerSpawn", "RC_PlayerSpawn", RC_PlayerSpawn );

function RC_ChooseTeam_Finish( pl, handler, id, encoded, decoded )
 
	pl:SetNWString("RC_team", decoded);
 
end
//datastream.Hook( "RC_ChooseTeam_Finish", RC_ChooseTeam_Finish );