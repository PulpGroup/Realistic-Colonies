


if (CLIENT) then
	CreateClientConVar("rc_view", 768, true, false) --distance of view.
	
	function drawName ( )
		local mdist = GetConVarNumber("rc_view")
		if mdist == 0 then
			mdist=768
		end
		
		for k, v in pairs( ents.GetAll() ) do
			local hc = v;
			local dist = hc:GetPos():Distance( LocalPlayer():GetPos() );
			
			if rc_api.isNpc(hc)==true and dist < mdist then
					local screen_pos = nil;
					
					
					local red = hc:GetNWInt("R");
					local green = hc:GetNWInt("G");
					local alpha = (1-dist/mdist)* 255;
					
					screen_pos = (Vector(0,0,hc:GetNWInt("Z")) + hc:GetPos()):ToScreen();
					
					local text = "Health : "..math.Round(hc:GetNWInt("HChealth"))
					if math.Round(hc:GetNWInt("HChealth")) <= 0 then
						text = "Health : Dead"
					end
					
					if(screen_pos.visible == true) then
						draw.DrawText(hc:GetNWString("HCname").." ("..hc:GetNWInt("HCage")..")", "BudgetLabel", screen_pos.x, screen_pos.y, Color(red, green, 0, alpha), TEXT_ALIGN_CENTER);
						draw.DrawText(text , "BudgetLabel", screen_pos.x, screen_pos.y+20, Color(red, green, 0, alpha), TEXT_ALIGN_CENTER);
					end
			end
		end
	end
	hook.Add("HUDPaint","drawName",drawName);
end