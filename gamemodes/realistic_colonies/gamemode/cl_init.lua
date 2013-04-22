include( "shared.lua" )

function RC_ChooseTeam( handler, id, encoded, decoded )

	local DermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself
	DermaPanel:SetPos( ScrW()/2-115, ScrH()/2-40 ) -- Position on the players screen
	DermaPanel:SetSize( 230, 80 ) -- Size of the frame
	DermaPanel:SetTitle( "Choose your team" ) -- Title of the frame
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false ) -- Draggable by mouse?
	DermaPanel:ShowCloseButton( false ) -- Show the close button?
	DermaPanel:MakePopup() -- Show the frame
	
	local button1 = vgui.Create( "DButton", DermaPanel )
	button1:SetSize( 100, 30 )
	button1:SetPos( 10, 30 )
	button1:SetText( "HeadCrab Team" )
	button1.DoClick = function( button1 )
		--datastream.StreamToServer( "RC_ChooseTeam_Finish", "headcrab" );
		net.Start("RC_ChooseTeam_Finish");
		net.WriteString("headcrab");
		net.SendToServer();
		DermaPanel:Close();
	end
	
	local button2 = vgui.Create( "DButton", DermaPanel )
	button2:SetSize( 100, 30 )
	button2:SetPos( 120, 30 )
	button2:SetText( "Antlion Team" )
	button2.DoClick = function( button2 )
		--datastream.StreamToServer( "RC_ChooseTeam_Finish", "antlion" );
		net.Start("RC_ChooseTeam_Finish");
		net.WriteString("antlion");
		net.SendToServer();
		DermaPanel:Close();
	end
 
end
net.Receive( "RC_ChooseTeam", RC_ChooseTeam );

function RC_HUD()
	draw.DrawText("You are on the "..LocalPlayer():GetNWString("RC_team").."'s team", "BudgetLabel", 50, 30, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT);
end
hook.Add("HUDPaint", "RC_HUD", RC_HUD)

