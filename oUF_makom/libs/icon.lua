local addon, ns = ...

local cfg = ns.cfg

local lib = ns.lib

-----------------------------
-- ICONS
-----------------------------

-- RAIDicon
lib.gen_raidicon = function(f,size)
	if f.mystyle == "target" then
		local RaidIcon = f.Health:CreateTexture(nil, 'OVERLAY')
		RaidIcon:SetSize(size, size)
		RaidIcon:SetPoint("BOTTOM", f.Health, "TOPRIGHT", 0, -size/3)
		
		f.RaidIcon = RaidIcon
	else

	end
end

-- Resting
lib.gen_restingicon = function(f)
	local Resting = f.Portrait:CreateTexture(nil, 'OVERLAY')
	Resting:SetSize(25, 25)
	Resting:SetPoint("CENTER", f.Portrait, "TOPLEFT", 0, 0)
	
	f.Resting = Resting
end

ns.lib = lib