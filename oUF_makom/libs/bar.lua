local addon, ns = ...

local cfg = ns.cfg

local lib = ns.lib

-----------------------------
-- HEALTHBAR
-----------------------------
lib.gen_hpbar = function(f)
	local s = CreateFrame("StatusBar", nil, f)
	s:SetStatusBarTexture(cfg.statusbar_texture)
	if f.mystyle == "tot" then
		s:SetHeight(f.height*0.5)
		s:SetWidth(4*f.height+3*10)
		s:SetPoint("TOPLEFT",0,0)
 	elseif f.mystyle == "focus" then
		s:SetHeight(f.height)
		s:SetWidth(4*f.height+3*10)
		s:SetPoint("TOPRIGHT",0,0)
 	elseif f.mystyle == "raid" then
		s:SetHeight(f.height)
		s:SetWidth(f.width)
		s:SetPoint("TOPLEFT",0,0)
		s:SetOrientation("VERTICAL")
 	else
		s:SetHeight(f.height)
		s:SetWidth(f.width)
		s:SetPoint("CENTER",0,0)
	end

	--helper
	local h = CreateFrame("Frame", nil, s)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	lib.gen_backdrop(h)
	--bg
	local b = s:CreateTexture(nil, "BACKGROUND")
	b:SetTexture(1,0,0)
	b:SetAllPoints(s)
	f.Health = s
	f.Health.bg = b
end
-----------------------------


-----------------------------
-- HEALPREDICTIONBAR
-----------------------------
lib.gen_healpredictionbar = function(f)
local mhpb = CreateFrame('StatusBar', nil, f)
mhpb:SetPoint('TOPLEFT', f.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
mhpb:SetPoint('BOTTOMLEFT', f.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
mhpb:SetWidth(200)
mhpb:SetStatusBarTexture(cfg.statusbar_texture)
mhpb:SetStatusBarColor(0, 1, 0.5, 0.7)

local ohpb = CreateFrame('StatusBar', nil, f)
ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
ohpb:SetWidth(200)
ohpb:SetStatusBarTexture(cfg.statusbar_texture)
ohpb:SetStatusBarColor(0, 1, 0, 0.7)

-- Register it with oUF
f.HealPrediction = {
-- status bar to show my incoming heals
myBar = mhpb,

-- status bar to show other peoples incoming heals
otherBar = ohpb,

-- amount of overflow past the end of the health bar
maxOverflow = 1.05,
}
end
-----------------------------


-----------------------------
-- POWERBAR
-----------------------------
lib.gen_ppbar = function(f)
	local s = CreateFrame("StatusBar", nil, f)
	s:SetStatusBarTexture(cfg.statusbar_texture)
	s:SetHeight(f.height*0.5)
	s:SetWidth(f.width)
	if f.mystyle == "target" then
		s:SetPoint("TOPLEFT", f.Health, "BOTTOMLEFT", 0, -10)
		s:SetWidth(f.width-(f.height*3+10*2)-10)
	elseif f.mystyle == "player" then
		s:SetPoint("TOPRIGHT", f.Health, "BOTTOMRIGHT", 0, -10)
		s:SetWidth(f.width-(f.height*3+10*2)-10)
	elseif f.mystyle == "focus" then
		s:SetPoint("TOPRIGHT",f.Health,"BOTTOMRIGHT",0,-10)
		s:SetWidth(4*f.height+3*10)
	else
		s:SetPoint("TOP",f,"BOTTOM",0,-10)
	end
	
	--helper
	local h = CreateFrame("Frame", nil, s)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	lib.gen_backdrop(h)
	--bg
	local b = s:CreateTexture(nil, "BACKGROUND")
	b:SetTexture(cfg.statusbar_texture)
	b:SetAllPoints(s)
	f.Power = s
	f.Power.bg = b
end
-----------------------------


-----------------------------
-- EMPTYBAR
-----------------------------
lib.gen_emptybar = function(f)
	if f.mystyle == "player" then
		local s = CreateFrame("StatusBar", nil, f)
		s:SetFrameStrata("BACKGROUND")
		s:SetHeight(f.Power:GetHeight())
		s:SetWidth((f.Health:GetWidth()-20)/3)
		s:SetPoint("BOTTOMLEFT", f.Health, "TOPLEFT", 0, 10)
  		--helper
  		local h = CreateFrame("Frame", nil, s)
		h:SetFrameLevel(0)
  		h:SetPoint("TOPLEFT",-5,5)
  		h:SetPoint("BOTTOMRIGHT",5,-5)
  		lib.gen_backdrop_thin(h)
  		--bg
		f.emptybar = s
	elseif f.mystyle == "target" then
		local s = CreateFrame("StatusBar", nil, f)
		s:SetFrameStrata("BACKGROUND")
		s:SetHeight(f.height)
		s:SetWidth(f.Power:GetWidth()/4)
		s:SetPoint("TOPLEFT", f.Power, "BOTTOMLEFT", 0, -10)
		--helper
		local h = CreateFrame("Frame", nil, s)
		h:SetFrameLevel(0)
		h:SetPoint("TOPLEFT",-5,5)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		lib.gen_backdrop_thin(h)

		h:SetAlpha(0)
		f.emptybar = s
elseif f.mystyle == "tot" then
--statusbar
local s = CreateFrame("StatusBar", nil, f)
s:SetFrameStrata("BACKGROUND")
s:SetHeight(f.height*0.7)
s:SetWidth(4*f.height+3*10)
s:SetPoint("TOPLEFT", f.Health, "BOTTOMLEFT", 0, -10)
--helper
local h = CreateFrame("Frame", nil, s)
h:SetFrameLevel(0)
h:SetPoint("TOPLEFT",-5,5)
h:SetPoint("BOTTOMRIGHT",5,-5)
lib.gen_backdrop_thin(h)

--bg
f.emptybar = s
--
end


end
-----------------------------


-----------------------------
-- EMPTYBAR2
-----------------------------
lib.gen_emptybar2 = function(f)
  	if f.mystyle == "player" then
	  local s = CreateFrame("StatusBar", nil, f)
	  s:SetFrameStrata("BACKGROUND")
	  s:SetHeight(f.Power:GetHeight())
	  s:SetWidth((f.Health:GetWidth()-20)/3)
	  s:SetPoint("TOPLEFT", f.emptybar, "TOPRIGHT", 10, 0)
	  --helper
	  local h = CreateFrame("Frame", nil, s)
	  h:SetFrameLevel(0)
	  h:SetPoint("TOPLEFT",-5,5)
	  h:SetPoint("BOTTOMRIGHT",5,-5)
	  lib.gen_backdrop_thin(h)
	  
	  --bg
	  f.emptybar2 = s
	else
	
	end
end
-----------------------------


-----------------------------
-- EMPTYBAR3
-----------------------------
lib.gen_emptybar3 = function(f)
  if f.mystyle == "player" then
  --statusbar
  local s = CreateFrame("StatusBar", nil, f)
  s:SetFrameStrata("BACKGROUND")
  s:SetHeight(f.Power:GetHeight())
  s:SetWidth((f.Health:GetWidth()-20)/3)
  s:SetPoint("TOPLEFT", f.emptybar2, "TOPRIGHT", 10, 0)
  --helper
  local h = CreateFrame("Frame", nil, s)
  h:SetFrameLevel(0)
  h:SetPoint("TOPLEFT",-5,5)
  h:SetPoint("BOTTOMRIGHT",5,-5)
  lib.gen_backdrop_thin(h)
  
  --bg
  f.emptybar3 = s
else
end
end   
-----------------------------


-----------------------------
-- INFOBAR
-----------------------------
lib.gen_infobar = function(f)
  --statusbar
  local s = CreateFrame("StatusBar", nil, f)
  s:SetFrameStrata("BACKGROUND")
  s:SetHeight(f.height)
  s:SetWidth((f.Health:GetHeight()+f.Power:GetHeight()+10)*1.618)
  if f.mystyle == "target" then
  s:SetPoint("TOPLEFT", f.Portrait, "BOTTOMLEFT", 0, -10)
else
s:SetPoint("TOP",f,"BOTTOM",0,-10)
end
--helper
local h = CreateFrame("Frame", nil, s)
h:SetFrameLevel(0)
h:SetPoint("TOPLEFT",-5,5)
h:SetPoint("BOTTOMRIGHT",5,-5)
lib.gen_backdrop_thin(h)

--bg
f.infobar = s

end
-----------------------------



-----------------------------
-- CASTBAR
-----------------------------
lib.gen_castbar = function(f)
	local s = CreateFrame("StatusBar", "oUF_SimpleCastbar"..f.mystyle, f)
	s:SetHeight(f.height*0.5)
	if f.mystyle == "player" then
		s:SetWidth(235)
		s:SetPoint("TOPLEFT",f.Power,"TOPRIGHT",10,0)
		s:SetStatusBarTexture(cfg.statusbar_texture)
		s:SetStatusBarColor(0.4,0.4,0.4)--(1,0.8,0,1)
	elseif f.mystyle == "target" then
		s:SetWidth(235+40+20)
		s:SetHeight(f.height)
		s:SetPoint("BOTTOMRIGHT",f.Power,"TOPLEFT",20,210)
		s:SetStatusBarTexture(cfg.statusbar_texture)
		s:SetStatusBarColor(0.4,0.4,0.4)--(1,0.8,0,1)
	else
		s:SetWidth(f.width-f.height-5)
		s:SetPoint("BOTTOM",f,"TOP",0,5)
	end

	--helper
	local h = CreateFrame("Frame", nil, s)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	lib.gen_backdrop(h)
	
	local b = s:CreateTexture(nil, "BACKGROUND")
	b:SetTexture(cfg.statusbar_texture)
	b:SetAllPoints(s)
	b:SetVertexColor(0.4*0.3,0.4*0.3,0.4*0.3,0.7)  

	--text
	local txt = lib.gen_fontstring(s, cfg.font, 13, "THINOUTLINE")
	txt:SetPoint("LEFT", 2, 0)
	txt:SetJustifyH("LEFT")
	--time
	local t = lib.gen_fontstring(s, cfg.font, 13, "THINOUTLINE")
	t:SetPoint("RIGHT", -2, 0)
	txt:SetPoint("RIGHT", t, "LEFT", -5, 0)
	--icon
	local i = s:CreateTexture(nil, "ARTWORK")
	i:SetWidth(f.height)
	i:SetHeight(f.height)
	if f.mystyle ~= "player" then
		--i:SetPoint("RIGHT", s, "LEFT", -5, 0) <--links
		i:SetPoint("TOPLEFT", s, "BOTTOMLEFT", 0, -10)--<--links unten
	else
		i:SetPoint("TOPLEFT", s, "BOTTOMLEFT", 0, -10)
	end
	i:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	--shield
	local s1 = s:CreateTexture(nil, "OVERLAY")
	s1:SetSize(100, 100)
	s1:SetPoint("CENTER", Castbar)

	--helper2 for icon
	if f.mystyle ~= "player" then
		local h2 = CreateFrame("Frame", nil, s)
		h2:SetFrameLevel(0)
		h2:SetPoint("TOPLEFT",i,"TOPLEFT",-5,5)
		h2:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",5,-5)
		lib.gen_backdrop(h2)
	else
		local h2 = CreateFrame("Frame", nil, s)
		h2:SetFrameLevel(0)
		h2:SetPoint("TOPLEFT",i,"TOPLEFT",-5,5)
		h2:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",5,-5)
		lib.gen_backdrop(h2)
	end

	if f.mystyle == "player" then
		--latency only for player unit
		local z = s:CreateTexture(nil,"OVERLAY")
		z:SetTexture(cfg.statusbar_texture)
		--z:SetVertexColor(0,0,0,0)
		z:SetVertexColor(0.6,0,0,0.6)
		z:SetPoint("TOPRIGHT")
		z:SetPoint("BOTTOMRIGHT")
		s.SafeZone = z
	end

	f.Castbar = s
	
	if f.mystyle ~= "player" then
		f.Castbar.Text = txt
		f.Castbar.Icon = i
		f.Castbar.Time = t
		f.Castbar.Shield = s1
	else
		f.Castbar.Icon = i
	end
	--f.Castbar.Time = t
	--f.Castbar.Icon = i
	--f.Castbar.Text = txt
end
-----------------------------
checkShield = function(f,unit,...)
	if f.Castbar.interrupt and UnitCanAttack("player", unit) then
		f.Castbar:SetStatusBarColor(0.6,0.6,0.6,1)   --we want to recolor the statusbar in case the shield pops up
		--f.Castbar.bg:SetVertexColor(0.2,0.2,0.2,0.7) --in case you have a background set
	else
		f.Castbar:SetStatusBarColor(0.4,0.4,0.4)       --back to normal
		--f.Castbar.bg:SetVertexColor(0.2,0.2,0,0.7)   --in case you have a background set
	end
end
-----------------------------






























ns.lib = lib