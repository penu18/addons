if(CLIENT) then
  surface.CreateFont("HealthFont", {
		font = "coolvetica",
		size = 30,
		shadow = false,
	})
  surface.CreateFont("HealthNumberFont", {
		font = "coolvetica",
		size = 25,
		shadow = false,
	})
  function HealthBar()  
  if GetConVarNumber("npchp_showbar") == 1 && LocalPlayer():GetNWInt("HealthBarDisable") == 0 then
      local tr = util.GetPlayerTrace( LocalPlayer(), LocalPlayer():GetAimVector() )
      local trace = util.TraceLine( tr )
      if (!trace.Hit) then return end
      if (!trace.HitNonWorld) then return end
      local font = "TargetID"
      local length = LocalPlayer():GetNWInt("LookingHealth") / LocalPlayer():GetNWInt("LookingMaxHealth") * 150
      local x, y = gui.MousePos()
	  if(GetConVarNumber("npchp_shownpcname") != 0) then
		draw.SimpleText(trace.Entity:GetClass(), "HealthFont", x+100, y + 20, Color(255,255,255,255),1,1) 
	  end
      if LocalPlayer():GetNWInt("LookingHealth") != 0 && LocalPlayer():GetNWInt("LookingMaxHealth") >= LocalPlayer():GetNWInt("LookingHealth") then
        surface.SetDrawColor( 255,0,0,255 )
        surface.DrawRect( x + 20, y + 40, 150, 15 )
        surface.SetDrawColor( 0,255,0,255 )
        surface.DrawRect( x + 20, y + 40, length, 15 )
        surface.SetDrawColor( 0,0,0,255 )
        surface.DrawRect( x + 16, y + 40, 4, 15 )
        surface.DrawRect( x + 170, y + 40, 5, 15 )
        surface.DrawRect( x + 16, y + 36, 159, 4 )
        surface.DrawRect( x + 16, y + 55, 159, 4 )
        surface.DrawRect( x + 15, y + 42, 1, 13 )
        surface.DrawRect( x + 175, y + 42, 1, 13 )
        surface.DrawRect( x + 14, y + 44, 1, 9 )
        surface.DrawRect( x + 176, y + 44, 1, 9 )
		if(GetConVarNumber("npchp_healthtext") == 1) then
			draw.SimpleText(LocalPlayer():GetNWInt("LookingHealth") .. "/" .. LocalPlayer():GetNWInt("LookingMaxHealth"), "HealthNumberFont", x + 90, y + 49, Color(0,0,255,255),1,1)
		end
      elseif LocalPlayer():GetNWInt("LookingHealth") != 0 && LocalPlayer():GetNWInt("LookingMaxHealth") <= LocalPlayer():GetNWInt("LookingHealth") then
        surface.SetDrawColor( 255,0,0,255 )
        surface.DrawRect( x + 20, y + 40, 150, 15 )
        surface.SetDrawColor( 0,255,0,255 )
        surface.DrawRect( x + 20, y + 40, 150, 15 )
		if(GetConVarNumber("npchp_healthtext") == 1) then
			draw.SimpleText(LocalPlayer():GetNWInt("LookingHealth") .. "/" .. LocalPlayer():GetNWInt("LookingMaxHealth"), "HealthNumberFont", x + 90, y + 49, Color(0,0,255,255),1,1) 
		end
	  end
    end
  end
  hook.Add("HUDPaint", "bleh", HealthBar)
  CreateClientConVar("npchp_showbar", 1, true, false)
  CreateClientConVar("npchp_shownpcname", 1, true, false)
  CreateClientConVar("npchp_healthtext", 1, true, false)
else

  AddCSLuaFile("healthbar.lua")
  function HealthBarGetHealth()  
   for k, v in pairs(player.GetAll()) do
      local tr = util.GetPlayerTrace( v, v:GetAimVector() )
      local trace = util.TraceLine( tr )
      if (!trace.Hit) then return end
      if (!trace.HitNonWorld) then return end
      v:SetNWInt("LookingHealth",trace.Entity:Health())
      v:SetNWInt("LookingMaxHealth",trace.Entity:GetMaxHealth())
      if GetConVarNumber("sv_showhealthbar") == 0 then
      v:SetNWInt("HealthBarDisable",1)
      else
      v:SetNWInt("HealthBarDisable",0)
      end
   end 
  end
  hook.Add("Think", "NpcHudGetHealth", HealthBarGetHealth)
  CreateConVar("sv_showhealthbar", 1)
end
      