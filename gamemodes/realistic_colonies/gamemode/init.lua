AddCSLuaFile("cl_init.lua");

-- Donne au joueur l'order gun
function RC_PlayerSet( ply )
	ply:Give("rc_order_gun"); 
	ply:SelectWeapon("rc_order_gun");
 
	return true;	
end 
hook.Add( "PlayerLoadout", "RC_PlayerSet", RC_PlayerSet);

-- Lors du spawn du joueur
function RC_PlayerSpawn( ply )
	--datastream.StreamToClients( ply, "RC_ChooseTeam", nil );
	net.Start("RC_ChooseTeam");
	net.Send(ply);
end
hook.Add( "PlayerSpawn", "RC_PlayerSpawn", RC_PlayerSpawn );

function RC_ChooseTeam_Finish( length, client )
	local team = net.ReadString();
	pl:SetNWString("RC_team", team);
end
net.Receive("RC_ChooseTeam_Finish", RC_ChooseTeam_Finish);