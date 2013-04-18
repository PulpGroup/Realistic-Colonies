if (CLIENT) then
	function drawHCInfo ( )
		if LocalPlayer():GetEyeTraceNoCursor().Entity:IsValid() then
			local hc = LocalPlayer():GetEyeTraceNoCursor().Entity;
			if hc:IsValid() and rc_api.isNpc(hc)==true then
				draw.DrawText("Name: "..hc:GetNWString("HCname").."\nHunger: "..hc:GetNWInt("HChunger").." Age: "..hc:GetNWInt("HCage"),"BudgetLabel",ScrW()/2,ScrH()/2,Color(255,255,255,255),1)
			end
		end
	end
	hook.Add("HUDPaint","ALInfo",drawHCInfo)
	
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
					
					
					local red = (hc:GetNWInt("HChunger")/100)*255;
					local green = ( (100-hc:GetNWInt("HChunger"))/100 )*255;
					local alpha = (1-dist/mdist)* 255
					
					if hc:GetClass() == "npc_zombie" then
						screen_pos = ( hc:GetPos()+Vector(0,0,80)*hc:GetModelScale() ):ToScreen();
					elseif hc:GetClass() == "npc_antlion" then
						screen_pos = ( hc:GetPos()+Vector(0,0,70)*hc:GetModelScale() ):ToScreen();
					else
						screen_pos = ( hc:GetPos()+Vector(0,0,40)*hc:GetModelScale() ):ToScreen();
					end					
					
					if hc:GetClass() == "npc_antlion" then
						red = (hc:GetNWInt("HChunger")/GetConVarNumber("rc_antlion_mhunger"))*255;
						green = (GetConVarNumber("rc_antlion_mhunger")-hc:GetNWInt("HChunger"))/hc:GetNWInt("HChunger")*255;
					elseif hc:GetClass() == "npc_zombie" then
						red = (hc:GetNWInt("HChunger")/GetConVarNumber("rc_zombie_mhunger"))*255;
						green = (GetConVarNumber("rc_zombie_mhunger")-hc:GetNWInt("HChunger"))/hc:GetNWInt("HChunger")*255;
					else
						red = (hc:GetNWInt("HChunger")/GetConVarNumber("rc_headcrab_mhunger"))*255;
						green = (GetConVarNumber("rc_headcrab_mhunger")-hc:GetNWInt("HChunger"))/hc:GetNWInt("HChunger")*255;
					end
					
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