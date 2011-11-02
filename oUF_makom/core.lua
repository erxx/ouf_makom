  local addon, ns = ...
  local cfg = ns.cfg
  local lib = ns.lib

  -----------------------------
  -- STYLE FUNCTIONS
  -----------------------------

  local function genToTStyle(self)
  
    lib.init(self)
    lib.gen_hpbar(self)
    lib.gen_healpredictionbar(self)
	lib.gen_emptybar(self)
	lib.gen_name(self,self.emptybar)
	lib.gen_hppercent(self,self.Health)
	lib.gen_curhp(self,self.Health)
	lib.gen_smartlevel(self,self.Health)
  end
  
  local function genfocusStyle(self)
  	lib.init(self)
  	lib.gen_hpbar(self)
  	lib.gen_ppbar(self)
  	lib.gen_name(self,self.Health)
  end
  
  local function genPlayerStyle(self)
    lib.init(self)
    lib.gen_hpbar(self)
    lib.gen_healpredictionbar(self)
    lib.gen_ppbar(self)
    lib.gen_emptybar(self)
    lib.gen_emptybar2(self)
    lib.gen_emptybar3(self)
    lib.gen_portrait(self)
    lib.gen_name(self,self.emptybar)
    lib.gen_hppercent(self,self.Health)
    lib.gen_pppercent(self,self.Power)
    lib.gen_curhp(self,self.Health)
    lib.gen_restingicon(self)
    lib.gen_vengeancebar(self)
    lib.gen_castbar(self)
    lib.gen_swingbar(self)
    lib.gen_altpowerbar(self)
    lib.createBuffs(self)
    lib.createDebuffs(self)
    end
  
  local function genTargetStyle(self)
    lib.init(self)
    lib.gen_hpbar(self)
    lib.gen_healpredictionbar(self)
    lib.gen_raidicon(self,30)
    lib.gen_ppbar(self)
	lib.gen_emptybar(self)
	lib.gen_portrait(self)
	lib.gen_name(self,self.Health)
	lib.gen_hppercent(self,self.Health)
	lib.gen_pppercent(self,self.Power)
	lib.gen_curhp(self,self.Health)
	lib.gen_smartlevel(self,self.Health)
	lib.gen_castbar(self)
	lib.gen_swingbar(self)
	lib.createBuffs(self)
	lib.createDebuffs(self)	
  end
  
  local function genRaidStyle(self)
  	lib.init(self)
  	lib.gen_hpbar(self)
  	lib.gen_name(self,self.Health)
  end

  --the player style
  local function CreatePlayerStyle(self)
    --style specific stuff
    self.height = 20
    self.width = self.height*7+10*6
    self.scale = 1
    self.mystyle = "player"
    genPlayerStyle(self)
    self.Health:SetStatusBarColor(0.4,0.4,0.4)
    self.Health.bg.multiplier = 0.3
    self.Health.Smooth = true
    self.Power.colorClass = true
    self.Power.bg.multiplier = 0.3
    self.Power.Smooth = true
  end  
  
  --the target style
  local function CreateTargetStyle(self)
    --style specific stuff
    self.height = 20
    self.width = self.height*7+10*6
    
    self.scale = 1
    self.mystyle = "target"
    genTargetStyle(self)
    self.Health.frequentUpdates = true
    self.Health:SetStatusBarColor(0.4,0.4,0.4)
    self.Health.bg.multiplier = 0.3
    self.Health.Smooth = true
    self.Power.colorClass = true
    self.Power.bg.multiplier = 0.3
    self.Power.Smooth = true
    self.Castbar.PostCastStart = checkShield(self)
    self.Castbar.PostChannelStart = checkShield(self)
    self.Castbar:SetAlpha(0.9)
  end  
  
  --the tot style
  local function CreateToTStyle(self)
  	--[[self.height = 40
  	self.width = 55
  	self.scale = 1
  	self.mystyle = "raid"
  	genRaidStyle(self)
  	self.Health:SetStatusBarColor(0.4,0.4,0.4)
  	self.Health.bg.multiplier = 0.3
  	self.Health.bg:SetTexture(0.8,0.8,0.8)

  	self.mystyle = "tot"]]
  
  --style specific stuff
    self.width = 50
    self.height = 20
    self.scale = 1
    self.mystyle = "tot"
    genToTStyle(self)
    self.Health:SetStatusBarColor(0.4,0.4,0.4)
    self.Health.bg.multiplier = 0.3
    --self.Power.colorPower = true
    --self.Power.bg.multiplier = 0.3
    lib.createDebuffs(self)
  end 
  
  --the focus style
  local function CreateFocusStyle(self)
    
    --style specific stuff
    self.width = 180
    self.height = 20
    self.scale = 1
    self.mystyle = "focus"
    genfocusStyle(self)
    self.Health:SetStatusBarColor(0.4,0.4,0.4)
    self.Health.frequentUpdates = true
    --self.Health.colorDisconnected = true
    --self.Health.colorHappiness = true
    --self.Health.colorClass = true
    --self.Health.colorReaction = true
    --self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.3
    self.Power.bg.multiplier = 0.3
    self.Power.colorClass = true
    self.Power.bg.multiplier = 0.3
    self.Power.Smooth = true
    --lib.gen_castbar(self)
    lib.createDebuffs(self)
    lib.createBuffs(self)
  end  
  
  --the pet style
  local function CreatePetStyle(self)
    --style specific stuff
    self.width = 180
    self.height = 25
    self.scale = 0.8
    self.mystyle = "pet"
    genStyle(self)
    self.Health.frequentUpdates = true
    self.Health.colorDisconnected = true
    self.Health.colorHappiness = true
    self.Health.colorClass = true
    self.Health.colorReaction = true
    self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.3
    lib.gen_castbar(self)
    lib.gen_altpowerbar(self)
    lib.gen_portrait(self)
    lib.createDebuffs(self)
  end  

  --the party style
  local function CreatePartyStyle(self)
    --style specific stuff
    self.width = 180
    self.height = 25
    self.scale = 0.8
    self.mystyle = "party"
    genStyle(self)
    self.Health.frequentUpdates = true
    self.Health.colorDisconnected = true
    self.Health.colorHappiness = true
    self.Health.colorClass = true
    self.Health.colorReaction = true
    self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.3
    lib.gen_portrait(self)
    lib.createDebuffs(self)
  end
  
  --the raid style
  local function CreateRaidStyle(self)
  --style specific stuff
  self.width = 130
  self.height = 25
  self.scale = 0.8
  self.mystyle = "raid"
  genStyle(self)
  self.Health.frequentUpdates = true
  self.Health.colorDisconnected = true
  self.Health.colorHappiness = true
  self.Health.colorClass = true
  self.Health.colorReaction = true
  self.Health.colorHealth = true
  self.Health.bg.multiplier = 0.3
  self.Power.colorPower = true
  self.Power.bg.multiplier = 0.3
  end   

  -----------------------------
  -- SPAWN UNITS
  -----------------------------

  if cfg.showplayer then
    oUF:RegisterStyle("oUF_SimplePlayer", CreatePlayerStyle)
    oUF:SetActiveStyle("oUF_SimplePlayer")
    oUF:Spawn("player", "oUF_Simple_PlayerFrame")  
  end
  
  if cfg.showtarget then
    oUF:RegisterStyle("oUF_SimpleTarget", CreateTargetStyle)
    oUF:SetActiveStyle("oUF_SimpleTarget")
    oUF:Spawn("target", "oUF_Simple_TargetFrame")  
  end

  if cfg.showtot then
    oUF:RegisterStyle("oUF_SimpleToT", CreateToTStyle)
    oUF:SetActiveStyle("oUF_SimpleToT")
    oUF:Spawn("targettarget", "oUF_Simple_ToTFrame")  
  end
  
  if cfg.showfocus then
    oUF:RegisterStyle("oUF_SimpleFocus", CreateFocusStyle)
    oUF:SetActiveStyle("oUF_SimpleFocus")
    oUF:Spawn("focus", "oUF_Simple_FocusFrame")  
  end
  
  if cfg.showpet then
    oUF:RegisterStyle("oUF_SimplePet", CreatePetStyle)
    oUF:SetActiveStyle("oUF_SimplePet")
    oUF:Spawn("pet", "oUF_Simple_PetFrame")  
  end
  
  if cfg.showparty then
    oUF:RegisterStyle("oUF_SimpleParty", CreatePartyStyle)
    oUF:SetActiveStyle("oUF_SimpleParty")

   local party = oUF:SpawnHeader("oUF_Party", nil, "party", "showParty", true, "showPlayer", true, "yOffset", -50)
   party:SetPoint("TOPLEFT", 70, -20)
  end
  
  if cfg.showraid then
    oUF:RegisterStyle("oUF_SimpleRaid", CreateRaidStyle)
    oUF:SetActiveStyle("oUF_SimpleRaid")
    local raid = {}
    for i = 1, NUM_RAID_GROUPS do
    	raid[i] = oUF:SpawnHeader("oUF_Raid"..i, nil, "raid",  "groupFilter", i, "showRaid", true, "yOffSet", -20)
    	if i == 1 then
    		raid[i]:SetPoint("TOPLEFT", 10, -20)
    	else
  			raid[i]:SetPoint("TOPLEFT", raid[i-1], "TOPRIGHT", -15, 0)
  		end
  	end
  end
  