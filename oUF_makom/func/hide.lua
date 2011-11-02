local addon, ns = ...

local cfg = ns.cfg

if cfg.hide.blizzBuffFrame then BuffFrame:Hide() end-- Blizzard Buff Frame

if cfg.hide.blizzEnchantWeaponFrame then TemporaryEnchantFrame:Hide() end-- Blizzard Weapon Enchant Frame

if cfg.hide.blizzMinimapInfight then -- Blizzard Minimap Frame
	MinimapCluster:RegisterEvent("PLAYER_REGEN_ENABLED")
	MinimapCluster:RegisterEvent("PLAYER_REGEN_DISABLED")
	MinimapCluster:HookScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_ENABLED" then
			MinimapCluster:Show()
			elseif event == "PLAYER_REGEN_DISABLED" then
			MinimapCluster:Hide()
		end
	end)
end

if cfg.hide.blizzWatchFrameInfight then -- Blizzard Quest Tracker Frame
	WatchFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	WatchFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	WatchFrame:HookScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_ENABLED" then
			WatchFrame:Show()
		elseif event == "PLAYER_REGEN_DISABLED" then
			WatchFrame:Hide()
		end
	end)
end

if cfg.hide.blizzRaidFrame then -- Blizzard Raid Frame
	if not IsRaidLeader() and not IsRaidOfficer() then
		CompactRaidFrameManager:UnregisterAllEvents()
		CompactRaidFrameManager:Hide()
		CompactRaidFrameManager:SetScript("OnShow",CompactRaidFrameManager.Hide)
	end
		CompactRaidFrameContainer:UnregisterAllEvents()
		CompactRaidFrameContainer:Hide()
		CompactRaidFrameContainer:SetScript("OnShow",CompactRaidFrameContainer.Hide)
end
