local addon, ns = ...

local cfg = ns.cfg

local lib = CreateFrame("Frame")  

local func = ns.func




local taunts = {"I'm a button.", "Quit clicking me.", "That's enough.", "Stop it!", "I'm leaving!"};
local widget = CreateFrame("Button", "TauntingButton", UIParent, "UIPanelButtonTemplate");
widget:SetWidth(200); widget:SetHeight(24); widget:SetPoint("CENTER");
widget:RegisterForClicks("AnyUp");
widget:SetScript("OnClick", function (self, button, down)
	self:SetID(1);
	if taunts[self:GetID()] then
	self:SetText(taunts[self:GetID()]);
  CancelUnitBuff("player", "Schattenschutz");
else
self:Hide();
end
end);











  

  
  lib.menu = function(self)
    local unit = self.unit:sub(1, -2)
    local cunit = self.unit:gsub("(.)", string.upper, 1)
    if(unit == "party" or unit == "partypet") then
      ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor", 0, 0)
    elseif(_G[cunit.."FrameDropDown"]) then
      ToggleDropDownMenu(1, nil, _G[cunit.."FrameDropDown"], "cursor", 0, 0)
    end
  end
  
  --moveme func
  lib.moveme = function(f)
    if cfg.allow_frame_movement then
      f:SetMovable(true)
      f:SetUserPlaced(true)
      if not cfg.frames_locked then
        f:EnableMouse(true)
        f:RegisterForDrag("LeftButton","RightButton")
        f:SetScript("OnDragStart", function(self) if IsAltKeyDown() and IsShiftKeyDown() then self:StartMoving() end end)
        f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
      end
    else
      f:IsUserPlaced(false)
    end  
  end  
  
  --init func
  lib.init = function(f)
    f:SetHeight(f.height)
	f:SetWidth(f.width)
	f:SetScale(f.scale)
	if f.mystyle == "player" then
      f:SetPoint("TOPRIGHT",UIParent,"BOTTOM",-127.5,300)
    elseif f.mystyle == "target" then
      f:SetPoint("TOPLEFT",UIParent,"BOTTOM",127.5,300)
    elseif f.mystyle == "tot" then
      f:SetPoint("TOPLEFT",oUF_Simple_TargetFrame.Portrait,"TOPRIGHT",10,0)
    elseif f.mystyle == "focus" then
      f:SetPoint("TOPRIGHT",oUF_Simple_PlayerFrame.Health,"TOPLEFT",-10,0)
    else
      f:SetPoint("CENTER",UIParent,"CENTER",0,0)
    end  
    f.menu = lib.menu
    f:RegisterForClicks("AnyUp")
    f:SetAttribute("*type2", "menu")
    f:SetScript("OnEnter", UnitFrame_OnEnter)
    f:SetScript("OnLeave", UnitFrame_OnLeave)

  end
  
  --fontstring func
  lib.gen_fontstring = function(f, name, size, outline)
    local fs = f:CreateFontString(nil, "OVERLAY")
    fs:SetFont(name, size, outline)
    fs:SetShadowColor(0,0,0,0.3)
    return fs
  end  
  

 



  --gen vengancebar func
lib.gen_vengeancebar = function(f)
    --statusbar
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetHeight(f.height*0.7)
	s:SetWidth(f.Power:GetWidth())
    s:SetPoint("TOPLEFT", f.Power, "BOTTOMLEFT", 0, -10)
	s:SetStatusBarColor(0.4,0.4,0.4)
    --helper
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    func.gen_backdrop(h)
    
   --bg
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(0.2,0.2,0.2,0.5)
    b:SetAllPoints(s)
    
    f.Vengeance = s
   -- f.Vengeance.bg = b    
  end
  
lib.gen_threatbar = function(f)
   --statusbar
   local s = CreateFrame("StatusBar", nil, f)
   s:SetStatusBarTexture(cfg.statusbar_texture)
   s:SetHeight(f.height*0.5)
   s:SetWidth(250-f.height-5-20)
   s:SetPoint("TOPLEFT",f.Power,"TOPRIGHT",35,0)
   s:SetStatusBarColor(0.4,0.4,0.4)
   --helper
   local h = CreateFrame("Frame", nil, s)
   h:SetFrameLevel(0)
   h:SetPoint("TOPLEFT",-5,5)
   h:SetPoint("BOTTOMRIGHT",5,-5)
   func.gen_backdrop(h)
   --bg
   local b = s:CreateTexture(nil, "BACKGROUND")
   b:SetTexture(cfg.statusbar_texture)
   b:SetAllPoints(s)
   f.ThreatBar = s
   f.ThreatBar.bg = b
  end

lib.gen_altpowerbar = function(f)
	--statusbar
	local s = CreateFrame("StatusBar", nil, f)
	s:SetStatusBarTexture(cfg.statusbar_texture)
	s:SetHeight(f.height)
	s:SetWidth(235)
	--s:SetPoint("BOTTOMLEFT",UIParent,"BOTTOM",-127.5+35,300+100+35+10)
	s:SetPoint("TOPLEFT",f.Power,"BOTTOMRIGHT",10,-40)
	s:SetStatusBarColor(0.4,0.4,0.4)
	--helper
	local h = CreateFrame("Frame", nil, s)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	func.gen_backdrop(h)
	--bg
	local b = s:CreateTexture(nil, "BACKGROUND")
	b:SetTexture(cfg.statusbar_texture)
	b:SetAllPoints(s)
	f.AltPowerBar = s
	f.AltPowerBar.bg = b
	end

lib.gen_swingbar = function(f)
	--statusbar
	local s = CreateFrame("Frame", nil, self)
	f:SetFrameLevel(0)
	s:SetWidth(130)
	s:SetHeight(1)
	s:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 100)
	s.texture = cfg.statusbar_texture
	s.color = {1, 0, 0, 0.8}
	s.textureBG = cfg.statusbar_texture
	s.colorBG = {0, 0, 0, 0.8}
	
	s.disableMelee = false
	s.disableRanged = false
	s.hideOoc = false
	
	f.Swing = s
		
end









  -----------------------------
  -- STRINGS
  -----------------------------
 
 -- Name
 lib.gen_name = function(f,bar)
    --name text strings
	if f.mystyle == "tot" then
      local name = lib.gen_fontstring(bar, cfg.font, 13 , "THINOUTLINE")
      name:SetPoint("LEFT", bar, "LEFT", 2, 0)
      name:SetJustifyH("LEFT")
      f:Tag(name, "[makom:classcolor][mono:longname]")
	elseif f.mystyle == "target" then
		local name = lib.gen_fontstring(bar, cfg.font, 13 , "THINOUTLINE")
		name:SetPoint("LEFT", bar, "LEFT", 2, 0)
		name:SetJustifyH("LEFT")
		f:Tag(name, "[makom:classcolor][mono:longname]")
	elseif f.mystyle == "focus" then
	    local name = lib.gen_fontstring(bar, cfg.font, 13, "OUTLINE")
	    name:SetPoint("LEFT", bar, "LEFT", 2, 0)
	    name:SetJustifyH("LEFT")
	    f:Tag(name, "[makom:classcolor][mono:longname]")
	elseif f.mystyle == "raid" then
		local name = lib.gen_fontstring(bar, cfg.font, 13 , "NONE")
		name:SetPoint("CENTER", bar, "TOP", 0, -(bar:GetHeight()/3))
		name:SetJustifyH("CENTER")
		f:Tag(name, "[makom:classcolor][mono:longname]")
	else
	
	end
end

 lib.gen_curhp = function(f,bar)
    --lvl text strings
	if f.mystyle == "target" then
	  local name = lib.gen_fontstring(bar, cfg.fontnumber, 30, "OUTLINE")
      name:SetPoint("RIGHT", f.Health, "RIGHT", 0, 0)
      name:SetJustifyH("RIGHT")
	  f:Tag(name, "[makom:classcolor][makom:hp]")
	elseif f.mystyle == "player" then
	  local name = lib.gen_fontstring(bar, cfg.fontnumber, 30, "OUTLINE")
	  name:SetPoint("RIGHT", f.Health, "RIGHT", 0, 0)
      name:SetJustifyH("RIGHT")
	  f:Tag(name, "[makom:classcolor][makom:hp]")
	else
	
	end
end

lib.gen_pppercent = function(f,bar)
 	--hppercent text strings
 	if f.mystyle == "target" then
 		local name = lib.gen_fontstring(bar, cfg.font, 13 , "OUTLINE")
 		name:SetPoint("CENTER", f.Power, "CENTER", 0, 0)
 		name:SetJustifyH("RIGHT")
 		f:Tag(name, "[makom:classcolor][makom:perpp]")
 	elseif f.mystyle == "tot" then
		local name = lib.gen_fontstring(bar, cfg.fontnumber, 33 , "OUTLINE")
		name:SetPoint("BOTTOMRIGHT", f.Health, "BOTTOMRIGHT", 0, -2)
		name:SetJustifyH("RIGHT")
		f:Tag(name, "[makom:classcolor][makom:perhp]")
 	elseif f.mystlye == "player" then
		local name = lib.gen_fontstring(bar, cfg.font, 13 , "THINOUTLINE")
		name:SetPoint("CENTER", bar, "CENTER", 2, 0)
		name:SetJustifyH("CENTER")
		f:Tag(name, "[makom:classcolor][makom:perpp]")
	else
	
	end
end

lib.gen_hppercent = function(f,bar)
    --hppercent text strings
	if f.mystyle == "target" then
      local name = lib.gen_fontstring(bar, cfg.fontnumber, 30 , "OUTLINE")
	  name:SetPoint("CENTER", f.Portrait, "CENTER", 0, 0)
      name:SetJustifyH("RIGHT")
	  f:Tag(name, "[makom:classcolor][makom:perhp]")
    elseif f.mystyle == "tot" then
	  local name = lib.gen_fontstring(bar, cfg.fontnumber, 33 , "OUTLINE")
      name:SetPoint("BOTTOMRIGHT", f.Health, "BOTTOMRIGHT", 0, -2)
      name:SetJustifyH("RIGHT")
	  f:Tag(name, "[makom:classcolor][makom:perhp]")
	elseif f.mystyle == "player" then
	  local name = lib.gen_fontstring(bar, cfg.fontnumber, 30 , "OUTLINE")
	  name:SetPoint("CENTER", f.Portrait, "CENTER", 0, 0)
	  name:SetJustifyH("RIGHT")
	  f:Tag(name, "[makom:classcolor][makom:perhp]")
	else
	  --local name = lib.gen_fontstring(bar, cfg.font, 13 , "THINOUTLINE")
      --name:SetPoint("CENTER", bar, "CENTER", 2, 0)
      --name:SetJustifyH("CENTER")
	  --f:Tag(name, "TEST")
    end
	
    
end

lib.gen_smartlevel = function(f,bar)
    --lvl text strings
    local name = lib.gen_fontstring(bar, cfg.font, 13 , "THINOUTLINE")
	if f.mystyle == "target" then
      name:SetPoint("TOPRIGHT", f.Portrait, "TOPRIGHT", -2, -2)
      name:SetJustifyH("RIGHT")
	  f:Tag(name, "[makom:classcolor][smartlevel]")
    else
    end

end
 
lib.gen_hpstrings = function(f)
    --health/name text strings
    local name = lib.gen_fontstring(f.Health, cfg.font, 13 , "THINOUTLINE")
    name:SetPoint("LEFT", f.Health, "LEFT", 2, 0)
    name:SetJustifyH("LEFT")
    
    local hpval = lib.gen_fontstring(f.Health, cfg.font, 13, "THINOUTLINE")
    hpval:SetPoint("RIGHT", f.Health, "RIGHT", -2, 0)
    --this will make the name go "..." when its to long
    name:SetPoint("RIGHT", hpval, "LEFT", -5, 0)
    
    f:Tag(name, "[name]")
    f:Tag(hpval, "[curhp]/[perhp]%")
  end



-----------------------------
-- PORTRAIT
-----------------------------
lib.gen_portrait = function(f)

    --local p = CreateFrame("PlayerModel", nil, f)
    if f.mystyle == "target" then
	  local p = CreateFrame("PlayerModel", nil, f)
	  p:SetHeight(f.Power:GetHeight()+f.emptybar:GetHeight()+10)
	  p:SetWidth(f.height*3+10*2)
      p:SetPoint("TOPLEFT", f.Power, "TOPRIGHT", 10, 0)
	  --helper
      local h = CreateFrame("Frame", nil, p)
      h:SetFrameLevel(0)
      h:SetPoint("TOPLEFT",-5,5)
      h:SetPoint("BOTTOMRIGHT",5,-5)
      func.gen_backdrop(h)
  
      f.Portrait = p
	
    elseif f.mystyle == "player" then
	  local p = CreateFrame("PlayerModel", nil, f)
	  p:SetWidth(f.height*3+10*2)
	  p:SetHeight(f.Power:GetHeight()+f.Health:GetHeight()+10)--f.Power:GetHeight()+f.Health:GetHeight()+10
      p:SetPoint("TOPLEFT", f.Health, "BOTTOMLEFT", 0, -10)
	  --helper
      local h = CreateFrame("Frame", nil, p)
      h:SetFrameLevel(0)
      h:SetPoint("TOPLEFT",-5,5)
      h:SetPoint("BOTTOMRIGHT",5,-5)
      func.gen_backdrop(h)
  
      f.Portrait = p
	  
	elseif f.mystyle == "tot" then
	else
	
	  local p = CreateFrame("PlayerModel", nil, f)
	  p:SetWidth((f.Health:GetHeight()+f.Power:GetHeight()+10)*1.618)
	  p:SetHeight(f.Health:GetHeight()+f.Power:GetHeight()+10)
      p:SetPoint("TOPRIGHT", f, "TOPLEFT", -5, 0)
	  --helper
      local h = CreateFrame("Frame", nil, p)
      h:SetFrameLevel(0)
      h:SetPoint("TOPLEFT",-5,5)
      h:SetPoint("BOTTOMRIGHT",5,-5)
      func.gen_backdrop(h)
  
      f.Portrait = p
    end
  end
----------------------------- 

  -----------------------------
  -- HANDOVER
  -----------------------------
  
  --hand the lib to the namespace for further usage...this is awesome because you can reuse functions in any of your layout files
  ns.lib = lib