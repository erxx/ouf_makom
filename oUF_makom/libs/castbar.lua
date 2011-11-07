local addon, ns = ...

local cfg = ns.cfg

local lib = ns.lib

local cast = ns.cast

local func = ns.func

local channelingTicks = {
	-- warlock
	[GetSpellInfo(689)] = 3, -- "Drain Life"
	[GetSpellInfo(5740)] = 4, -- "Rain of Fire"
	-- druid
	[GetSpellInfo(44203)] = 4, -- "Tranquility"
	[GetSpellInfo(16914)] = 10, -- "Hurricane"
	-- priest
	--[GetSpellInfo(15407)] = 3, -- "Mind Flay"
	[GetSpellInfo(48045)] = 5, -- "Mind Sear"
	[GetSpellInfo(47540)] = 2, -- "Penance"
	-- mage
	[GetSpellInfo(5143)] = 5, -- "Arcane Missiles"
	[GetSpellInfo(10)] = 5, -- "Blizzard"
	[GetSpellInfo(12051)] = 4, -- "Evocation"
}
local ticks = {}

cast.setBarTicks = function(castBar, ticknum)
	if ticknum and ticknum > 0 then
		local delta = castBar:GetWidth() / ticknum
		for k = 1, ticknum-1 do
			if not ticks[k] then
				ticks[k] = castBar:CreateTexture(nil, 'OVERLAY')
				ticks[k]:SetTexture(cfg.statusbar_texture)
				ticks[k]:SetVertexColor(0.8, 0.8, 0.8)
				ticks[k]:SetWidth(1)
				ticks[k]:SetHeight(castBar:GetHeight())
			end
			ticks[k]:ClearAllPoints()
			ticks[k]:SetPoint("CENTER", castBar, "LEFT", delta * k, 0 )
			ticks[k]:Show()
		end
	else
		for k, v in pairs(ticks) do
			v:Hide()
		end
	end
end


cast.PostCastStart = function(self, unit, name, rank, text)
	if (UnitCanAttack("player", "target") and unit == "target" and self.interrupt) then
		self:SetStatusBarColor(1, 0, 0, 0.7)
	elseif unit == "player" then
		if self.casting then
			cast.setBarTicks(self, 0)
			self:SetStatusBarColor(0.4,0.4,0.4,1)
		else
			local spell = UnitChannelInfo(unit)
			self.channelingTicks = channelingTicks[spell] or 0
			cast.setBarTicks(self, self.channelingTicks)
			self:SetStatusBarColor(0.4,0.4,0.4,1)
		end
	else
		self:SetStatusBarColor(0.4,0.4,0.4,1)	
	end
end

cast.PostCastStop = function(self, unit, name, rank, castid)
	cast.setBarTicks(self, 0)
end


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
	func.gen_backdrop(h)

	local b = s:CreateTexture(nil, "BACKGROUND")
	b:SetTexture(cfg.statusbar_texture)
	b:SetAllPoints(s)
	b:SetVertexColor(0.4*0.3,0.4*0.3,0.4*0.3,0.7)  

	--text
	local txt = lib.gen_fontstring(s, cfg.font, 13, "THINOUTLINE")
	txt:SetPoint("LEFT", 2, 0)
	txt:SetJustifyH("LEFT")
	--spark
	sp = s:CreateTexture(nil, "OVERLAY")
	sp:SetBlendMode("ADD")
	sp:SetAlpha(0.5)
	sp:SetHeight(s:GetHeight()*2.5)
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

	--helper2 for icon
	if f.mystyle ~= "player" then
		local h2 = CreateFrame("Frame", nil, s)
		h2:SetFrameLevel(0)
		h2:SetPoint("TOPLEFT",i,"TOPLEFT",-5,5)
		h2:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",5,-5)
		func.gen_backdrop(h2)
	else
		local h2 = CreateFrame("Frame", nil, s)
		h2:SetFrameLevel(0)
		h2:SetPoint("TOPLEFT",i,"TOPLEFT",-5,5)
		h2:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",5,-5)
		func.gen_backdrop(h2)
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

	
	s.PostCastStart = cast.PostCastStart
	s.PostChannelStart = cast.PostCastStart
	s.PostCastStop = cast.PostCastStop
	s.PostChannelStop = cast.PostCastStop
	

	f.Castbar = s

	if f.mystyle ~= "player" then
		f.Castbar.Text = txt
		f.Castbar.Icon = i
		f.Castbar.Time = t
		--f.Castbar.Spark = sp
		--f.Castbar.Shield = s1
	else
		f.Castbar.Icon = i
	end
	--f.Castbar.Time = t
	--f.Castbar.Icon = i
	--f.Castbar.Text = txt
end
-----------------------------

ns.lib = lib