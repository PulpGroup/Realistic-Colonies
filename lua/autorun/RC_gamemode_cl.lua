if (CLIENT) then
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
			datastream.StreamToServer( "RC_ChooseTeam_Finish", "headcrab" );
			DermaPanel:Close();
		end
	
		local button2 = vgui.Create( "DButton", DermaPanel )
		button2:SetSize( 100, 30 )
		button2:SetPos( 120, 30 )
		button2:SetText( "Antlion Team" )
		button2.DoClick = function( button2 )
			datastream.StreamToServer( "RC_ChooseTeam_Finish", "antlion" );
			DermaPanel:Close();
		end
 
	end
	datastream.Hook( "RC_ChooseTeam", RC_ChooseTeam );

	function RC_HUD()
		if (GetConVarString("rc_gamemode_enabled") == "1") then 
			draw.DrawText("You are on the "..LocalPlayer():GetNWString("RC_team").."'s team", "BudgetLabel", 50, 30, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT);
		end
	end
	hook.Add("HUDPaint", "RC_HUD", RC_HUD)
end

