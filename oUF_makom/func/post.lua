local addon, ns = ...
local cfg = ns.cfg
local func = ns.func
local auras = CreateFrame("Frame")

auras.PostCreateIcon = function(self, button)
	button.cd:SetReverse()
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.icon:SetDrawLayer("BACKGROUND")
	--count
	button.count:ClearAllPoints()
	button.count:SetJustifyH("RIGHT")
	button.count:SetPoint("TOPRIGHT", 2, 2)
	button.count:SetTextColor(0.7,0.7,0.7)
	
	--rightclick cancelaura support playerframe
	if self.__owner.unit == "player" then
	button:SetScript("OnMouseUp", function(self, button)
		CancelUnitBuff("player", self:GetID())
		end
		)
	end
		
	--helper
	local h = CreateFrame("Frame", nil, button)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	func.gen_backdrop(h)
	
end

ns.auras = auras
-----------------------------------
-----------------------------------
local cast = CreateFrame("Frame")


ns.cast = cast




