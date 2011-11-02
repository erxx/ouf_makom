local addon, ns = ...
local cfg = ns.cfg
local cast = CreateFrame("Frame")

cast.PostCastStart = function(self, unit, name, rank, text)
	if unit == "target" and self.interrupt then
		self:SetStatusBarColor(0, 1, 0, 0.7)
	else
		self:SetStatusBarColor(0.4,0.4,0.4,1)
	end
end

ns.cast = cast