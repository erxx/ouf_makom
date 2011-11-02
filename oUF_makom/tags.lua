oUF.Tags['mono:color'] = function(u, r)
	local _, class = UnitClass(u)
	local reaction = UnitReaction(u, "player")
	
	if (UnitIsTapped(u) and not UnitIsTappedByPlayer(u)) then
		return hex(oUF.colors.tapped)
	elseif (u == "pet") and GetPetHappiness() then
		return hex(oUF.colors.happiness[GetPetHappiness()])
	elseif (UnitIsPlayer(u)) then
		return hex(oUF.colors.class[class])
	elseif reaction then
		return hex(oUF.colors.reaction[reaction])
	else
		return hex(1, 1, 1)
	end
end
oUF.TagEvents['mono:color'] = 'UNIT_REACTION UNIT_HEALTH UNIT_POWER'

local SVal = function(val)
if val then
	if (val >= 1e6) then
        return ("%.1fm"):format(val / 1e6)
	elseif (val >= 1e3) then
		return ("%.1fk"):format(val / 1e3)
	else
		return ("%d"):format(val)
	end
end
end


-- calculating the ammount of latters
local function utf8sub(string, i, dots)
	if string then
	local bytes = string:len()
	if bytes <= i then
		return string
	else
		local len, pos = 0, 1
		while pos <= bytes do
			len = len + 1
			local c = string:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end
		if len == i and pos <= bytes then
			return string:sub(1, pos - 1)--..(dots and '..' or '')
		else
			return string
		end
	end
	end
end

oUF.Tags['mono:longname'] = function(u, r)
	local name = UnitName(r or u)
	return utf8sub(name,15, true)--16
end
oUF.TagEvents['mono:longname'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION'

-- health value tags
oUF.Tags['makom:hp']  = function(u)
  if UnitIsDead(u) or UnitIsGhost(u) or not UnitIsConnected(u) then
    return oUF.Tags['mono:DDG'](u)
  else
	local curhp = UnitHealth(u)
    if (u == "target" or u == "player") then
	  return SVal(curhp)
	else
	  return SVal(curhp)
	end
  end
end
oUF.TagEvents['makom:hp'] = 'UNIT_HEALTH UNIT_CONNECTION'

oUF.Tags['makom:perhp']  = function(u)
	if UnitIsDead(u) or UnitIsGhost(u) or not UnitIsConnected(u) then
		return oUF.Tags['mono:DDG'](u)
	else
		local per = oUF.Tags['perhp'](u)
		if ((u == "target" or u == "player") and per~=100) then
			local mult = 10^(1)
			local perhp = 100*UnitHealth(u)/UnitHealthMax(u)
			return math.floor(perhp * mult + 0.5) / mult
		else
			return
		end
	
	
		--[[local per = oUF.Tags['perhp'](u)
		
		if ((u == "target" or u == "player") and per~=100) then
			return per
		else
			return
		end]]
	end
end
oUF.TagEvents['makom:perhp'] = 'UNIT_HEALTH UNIT_CONNECTION'

oUF.Tags['makom:pp']  = function(u)
	if UnitIsDead(u) or UnitIsGhost(u) or not UnitIsConnected(u) then
		return oUF.Tags['mono:DDG'](u)
	else
		local curpp = UnitPower(u)
		if (u == "target" or u == "player") then
			return SVal(curpp)
		else
			return SVal(curpp)
		end
	end
end
oUF.TagEvents['makom:pp'] = 'UNIT_POWER UNIT_CONNECTION'

oUF.Tags['makom:perpp']  = function(u)
	local per = oUF.Tags['perpp'](u)
	if ((u == "target" or u == "player") and (per~=100 and per~=0)) then
		return per
	else
		return
	end
end
oUF.TagEvents['makom:perpp'] = 'UNIT_POWER UNIT_CONNECTION'




-- unit status tag
oUF.Tags['mono:DDG'] = function(u)
	if not UnitIsConnected(u) then
		return "|cffCFCFCF D/C|r"
	elseif UnitIsGhost(u) then
		return "|cffCFCFCF Ghost|r"
	elseif UnitIsDead(u) then
		return "|cffCFCFCF Dead|r"
	end
end
oUF.TagEvents['mono:DDG'] = 'UNIT_NAME_UPDATE UNIT_HEALTH UNIT_CONNECTION'--'UNIT_MAXHEALTH'

-- unit status tag
oUF.Tags['makom:mob'] = function(u)
	if (not UnitIsFriend("player", "target") == true) then
		return "mob"
	else
		return "friend"
	end
end
oUF.TagEvents['makom:mob'] = 'UNIT_HEALTH UNIT_CONNECTION'

oUF.Tags['makom:classcolor'] = function(unit)
	local reaction = UnitReaction(unit, "player")
	if UnitIsPlayer(unit) then
		s = oUF.Tags["raidcolor"](unit)
		return s
	else
		r, g, b = 0.84,0.75,0.65
		return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
	end
end
oUF.TagEvents['makom:classcolor'] = 'UNIT_POWER'