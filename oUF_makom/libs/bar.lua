local addon, ns = ...

local cfg = ns.cfg

local lib = ns.lib

local cast = ns.cast

local func = ns.func

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
	func.gen_backdrop(h)
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
	func.gen_backdrop(h)
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
  		func.gen_backdrop_thin(h)
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
		func.gen_backdrop_thin(h)

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
func.gen_backdrop_thin(h)

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
	  func.gen_backdrop_thin(h)
	  
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
  func.gen_backdrop_thin(h)
  
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
func.gen_backdrop_thin(h)

--bg
f.infobar = s

end
-----------------------------









ns.lib = lib