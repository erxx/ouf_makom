local addon, ns = ...

local cfg = ns.cfg

local lib = ns.lib

local func = ns.func


lib.gen_chatpanel = function(f)
if cfg.showpanels then
	local s = CreateFrame("Frame", nil, f)
	s:SetFrameStrata("BACKGROUND")
	s:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 10)
	s:SetPoint("TOPRIGHT", f.Portrait, "BOTTOMLEFT",-10-f.width,-10-1*(f.height+10))

	--helper
	local h = CreateFrame("Frame", nil, s)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	func.gen_backdrop_thin(h)
	--bg
	f.chatpanel = s
end
end

lib.gen_bottomright = function(f)
if cfg.showpanels then
	local s = CreateFrame("Frame", nil, f)
	s:SetFrameStrata("BACKGROUND")
	s:SetHeight(f.height)
	s:SetWidth(f.chatpanel:GetHeight()-f.height-10)
	s:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 10)
	
	--helper
	local h = CreateFrame("Frame", nil, s)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	func.gen_backdrop_thin(h)
	--bg
	f.sldt = s
	
	
	local s1 = CreateFrame("Frame", nil, f)
	s1:SetFrameStrata("BACKGROUND")
	s1:SetHeight((f.chatpanel:GetHeight())-f.height-10)
	s1:SetWidth(s1:GetHeight())
	s1:SetPoint("BOTTOMRIGHT", f.sldt, "TOPRIGHT", 0, 10)
	
	--helper
	local h1 = CreateFrame("Frame", nil, s1)
	h1:SetFrameLevel(0)
	h1:SetPoint("TOPLEFT",-5,5)
	h1:SetPoint("BOTTOMRIGHT",5,-5)
	func.gen_backdrop_thin(h1)
	--bg
	f.minimap = s1
	
	
	local s2 = CreateFrame("Frame", nil, f)
	s2:SetFrameStrata("BACKGROUND")
	s2:SetHeight((f.chatpanel:GetHeight()-10)*5/9)
	s2:SetWidth(f.chatpanel:GetHeight()+20)
	s2:SetPoint("BOTTOMRIGHT", f.sldt, "BOTTOMLEFT", -10, 0)
	
	--helper
	local h2 = CreateFrame("Frame", nil, s2)
	h2:SetFrameLevel(0)
	h2:SetPoint("TOPLEFT",-5,5)
	h2:SetPoint("BOTTOMRIGHT",5,-5)
	func.gen_backdrop_thin(h2)
	--bg
	f.skada1 = s2
	
	
	local s3 = CreateFrame("Frame", nil, f)
	s3:SetFrameStrata("BACKGROUND")
	s3:SetHeight((f.chatpanel:GetHeight()-10)*4/9)
	s3:SetWidth(f.chatpanel:GetHeight()+20)
	s3:SetPoint("BOTTOMRIGHT", f.skada1, "TOPRIGHT", 0, 10)
	
	--helper
	local h3 = CreateFrame("Frame", nil, s3)
	h3:SetFrameLevel(0)
	h3:SetPoint("TOPLEFT",-5,5)
	h3:SetPoint("BOTTOMRIGHT",5,-5)
	func.gen_backdrop_thin(h3)
	--bg
	f.skada2 = s3

end
end


ns.lib = lib