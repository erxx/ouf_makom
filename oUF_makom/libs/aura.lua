local addon, ns = ...

local cfg = ns.cfg

local lib = ns.lib

--------------------------------
--          DEBUFFS           --
--------------------------------
lib.createDebuffs = function(f)
	b = CreateFrame("Frame", nil, f)
	b.size = 30
	if f.mystyle == "target" then
		b.size = f.height
		b.num = 20
		b.spacing = 10
		b.onlyShowPlayer = false
		b:SetHeight((b.size+b.spacing)*4)
		b:SetWidth(f.width)
		b:SetPoint("TOPLEFT", f.emptybar, "BOTTOMLEFT", 0, -10)---5-b.size
		b.initialAnchor = "TOPLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "DOWN"	  
		b.PostCreateIcon = lib.PostCreateIcon
		b:SetAlpha(0.7)
		f.Debuffs = b
	elseif f.mystyle == "player" then
		b.size = (f.Health:GetWidth()-20)/3 --f.height*2+10
		b.num = 10
		b.spacing = 10
		b.onlyShowPlayer = false
		b:SetHeight(f.height*2+10)
		b:SetWidth(f.width)
		b:SetPoint("BOTTOMLEFT", f.Health, "TOPLEFT", 0, 30)
		b.initialAnchor = "BOTTOMLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "UP"
		b.PostCreateIcon = lib.PostCreateIcon
		f.Debuffs = b
	elseif (f.mystyle == "tot" or f.mystyle == "focus") then
		b.size = f.height
		b.num = 8
		b.spacing = 10
		b.onlyShowPlayer = false
		b:SetHeight((b.size+b.spacing)*4)
		b:SetWidth(4*f.height+3*10)
		b:SetPoint("BOTTOMLEFT", f.Health, "TOPLEFT", 0, 10)
		b.initialAnchor = "BOTTOMLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "UP"
		b.PostCreateIcon = lib.PostCreateIcon
		f.Debuffs = b
	else
		b.num = 8
		b.spacing = 10
		b.onlyShowPlayer = false
		b:SetHeight((b.size+b.spacing)*4)
		b:SetWidth(f.width)
		b:SetPoint("BOTTOMLEFT", f.Health, "TOPLEFT", 0, 10)
		b.initialAnchor = "BOTTOMLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "UP"
		b.PostCreateIcon = lib.PostCreateIcon
		f.Debuffs = b
	end
end

--------------------------------
--          BUFFS             --
--------------------------------
lib.createBuffs = function(f)
	b = CreateFrame("Frame", nil, f)
	b.size = f.height
	b.spacing = 10
	b.onlyShowPlayer = false
	b:SetHeight((b.size+b.spacing)*4)
	b:SetWidth(f.width)
	b:SetPoint("BOTTOMLEFT", f.Health, "TOPLEFT", 0, 10)
	b.initialAnchor = "BOTTOMLEFT"
	b["growth-x"] = "RIGHT"
	b["growth-y"] = "UP"
	b.PostCreateIcon = lib.PostCreateIcon
	if f.mystyle == "target" then
		b.num = 28 
	elseif f.mystyle == "player" then
		b.num = 28
		b.onlyShowPlayer = false
		b:SetPoint("TOPLEFT", f.Portrait, "BOTTOMLEFT", 0, -10)---20-f.height*0.7)
		b.initialAnchor = "TOPLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "DOWN"
	elseif f.mystyle == "focus" then
		b.size = f.height
		b.num = 8
		b.spacing = 10
		b.onlyShowPlayer = false
		b:SetHeight((b.size+b.spacing)*4)
		b:SetWidth(4*f.height+3*10)
		b:SetPoint("TOPLEFT", f.Power, "BOTTOMLEFT", 0, -10)
		b.initialAnchor = "TOPLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "DOWN"
	else
		b.num = 5
	end
f.Buffs = b
end





ns.lib = lib
