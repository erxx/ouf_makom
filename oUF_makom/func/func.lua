local addon, ns = ...
local cfg = ns.cfg
local func = CreateFrame("Frame")

--backdrop table
local backdrop_tab = { 
	bgFile = cfg.backdrop_texture, 
	edgeFile = cfg.backdrop_edge_texture,
	tile = false,
	tileSize = 0, 
	edgeSize = 5, 
	insets = { 
  		left = 5, 
  		right = 5, 
  		top = 5, 
  		bottom = 5,
	},
}
  
--backdrop func
func.gen_backdrop = function(f)
f:SetBackdrop(backdrop_tab);
f:SetBackdropColor(0,0,0,0.8)
f:SetBackdropBorderColor(0,0,0,1)
end
  
func.gen_backdrop_thin = function(f)
f:SetBackdrop(backdrop_tab);
f:SetBackdropColor(0,0,0,0.5)
f:SetBackdropBorderColor(0,0,0,0.7)
end




ns.func = func