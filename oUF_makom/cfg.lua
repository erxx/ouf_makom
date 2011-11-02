  -----------------------------
  -- INIT
  -----------------------------
  
  --get the addon namespace
  local addon, ns = ...
  
  --generate a holder for the config data
  local cfg = CreateFrame("Frame")
  
  -----------------------------
  -- CONFIG
  -----------------------------
  
  cfg.hide = {
	    blizzRaidFrame = true,
	    blizzBuffFrame = true,
	    blizzEnchantWeaponFrame = true,
	    blizzMinimapInfight = true,
	    blizzWatchFrameInfight = true,
  }

  --config variables
  cfg.showplayer = true
  cfg.showtarget = true
  cfg.showtot = true
  --cfg.showpet = true
  cfg.showfocus = true
  cfg.showparty = false
  cfg.showraid = false
  cfg.allow_frame_movement = true
  cfg.frames_locked = false
  
  cfg.statusbar_texture = "Interface\\AddOns\\oUF_makom\\media\\statusbar512x64"
  cfg.backdrop_texture = "Interface\\AddOns\\oUF_makom\\media\\backdrop"
  cfg.backdrop_edge_texture = "Interface\\AddOns\\oUF_makom\\media\\backdrop_edge"
  --cfg.fonttag = "FONTS\\FRIZQT__.ttf"
  cfg.fontnumber = "Interface\\AddOns\\SharedMedia\\font\\REZD.ttf"
  --cfg.font = "Interface\\AddOns\\SharedMedia\\font\\Futura LT Heavy.ttf"
  cfg.font = "FONTS\\font.ttf"
  -----------------------------
  -- HANDOVER
  -----------------------------
  
  --hand the config to the namespace for usage in other lua files (remember: those lua files must be called after the cfg.lua)
  ns.cfg = cfg
