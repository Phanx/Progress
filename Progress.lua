--[[
	Progress
	Experience and reputation plugin for any DataBroker addon.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info11032-Progress.html
	See README for license terms and other information.
--]]

ProgressDB = {				-- Currently, editing this table is the only way to change settings.
	forceRep = false,		-- Show reputation in the tooltip even if below max level
	longText = false,		-- Does nothing yet; will show current level or watched faction on plugin text
	shortFactions = true,	-- Does nothing yet; will abbreviate name shown with longText
}

local STANDING_COLOR = {
	"|cffcc2222", -- Hated
	"|cffff0000", -- Hostile
	"|cffee6622", -- Unfriendly
	"|cffffff00", -- Neutral
	"|cff00ff00", -- Friendly
	"|cff00ff88", -- Honored
	"|cff00ffcc", -- Revered
	"|cff00ffff", -- Exalted
}

local XP_PER_LEVEL = { -- How much XP needed to complete each level
	400,
	900,
	1400,
	2100,
	2800, -- 5
	3600,
	4500,
	5400,
	6500,
	7600, -- 10
	8700,
	9800,
	11000,
	12300,
	13600, -- 15
	15000,
	16400,
	17800,
	19300,
	20800, -- 20
	22400,
	24000,
	25500,
	27200,
	28900, -- 25
	30500,
	32200,
	33900,
	36300,
	38800, -- 30
	41600,
	44600,
	48000,
	51400,
	55000, -- 35
	58700,
	62400,
	66200,
	70200,
	74300, -- 40
	78500,
	82800,
	87100,
	91600,
	96300, -- 45
	101000,
	105800,
	110700,
	115700,
	120900, -- 50
	126100,
	131500,
	137000,
	142500,
	148200, -- 55
	154000,
	159900,
	165800,
	172000,
	290000, -- 60
	317000,
	349000,
	386000,
	428000,
	475000, -- 65
	527000,
	585000,
	658000,
	717000,
	1523800, -- 70
	1539600,
	1555700,
	1571800,
	1587900,
	1604200, -- 75
	1620700,
	1637400,
	1653900,
	1670800,
}
local MAX_LEVEL = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()]

local XP_TO_MAX_LEVEL = 0
for i = 1, MAX_LEVEL - 1 do
	XP_TO_MAX_LEVEL = XP_TO_MAX_LEVEL + XP_PER_LEVEL[i]
end

local xpToCurrentLevel = 0

local db, shortFactions = ProgressDB, {}
local L = setmetatable(PROGRESS_LOCALS or {}, { __index = function(t, k) rawset(t, k, k) return k end })

local function Debug(lvl, str, ...)
	if lvl > 0 then return end
	if select("#", ...) > 0 then
		str = str:format(...)
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cffff7f7fProgress:|r "..str)
end

local Progress = CreateFrame("Frame", "Progress_Frame")
Progress.obj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Progress", {
	type = "data source",
	text = "Progress",
	icon = "Interface\\Icons\\INV_Misc_PocketWatch_02",
	OnClick = function() ToggleCharacter("ReputationFrame") end,
	OnLeave = function() GameTooltip:Hide() end,
})

function Progress:UpdateText()
	Debug(2, "UpdateText")
	if UnitLevel("player") < MAX_LEVEL then
		self.obj.text = UnitXP("player").."/"..UnitXPMax("player")
	elseif GetWatchedFactionInfo() then
		local name, standing, min, max, cur = GetWatchedFactionInfo()
		if name then
			self.obj.text = STANDING_COLOR[standing]..(cur - min).."/"..(max - min).."|r"
		end
	else
		self.obj.text = "Exp/Rep"
	end
end

function Progress.obj:OnTooltipShow(tooltip)
	tooltip = tooltip or GameTooltip

	tooltip:AddLine(L["Progress"])

	local needblank
	local myLevel = UnitLevel("player")
	if myLevel < MAX_LEVEL then
		tooltip:AddDoubleLine(L["Current Level"], myLevel, nil, nil, nil, 1, 1, 1)
		if myLevel < MAX_LEVEL then
			local cur, max, rest = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
			tooltip:AddDoubleLine(L["Current XP"], cur.."/"..max.." ("..floor(cur / max * 100).."%)", nil, nil, nil, 1, 1, 1)
			if rest then
				local restperc
				if rest - (max - cur) > 0 then
					restperc = floor((rest - (max - cur)) / max * 100) + 100
				else
					restperc = floor(rest / max * 100)
				end
				tooltip:AddDoubleLine(L["Rested XP"], rest.." ("..restperc..")%", nil, nil, nil, 1, 1, 1)
			end
			tooltip:AddDoubleLine(L["XP To Next Level"], max - cur, nil, nil, nil, 1, 1, 1)
			tooltip:AddDoubleLine(L["XP To Level %d"]:format(MAX_LEVEL), XP_TO_MAX_LEVEL - (xpToCurrentLevel + cur), nil, nil, nil, 1, 1, 1)
		end
		needblank = true
	end
	if myLevel == MAX_LEVEL or db.forceRep then
		if needblank then
			tooltip:AddLine(" ")
			needblank = nil
		end
		local name, standing, min, max, cur = GetWatchedFactionInfo()
		tooltip:AddDoubleLine(L["Faction"], name, nil, nil, nil, 1, 1, 1)
		tooltip:AddDoubleLine(L["Standing"], STANDING_COLOR[standing].._G["FACTION_STANDING_LABEL"..standing].."|r")
		tooltip:AddDoubleLine(L["Progress"], (cur - min).."/"..(max - min), nil, nil, nil, 1, 1, 1)
		if standing < 8 then
			tooltip:AddDoubleLine(L["To Next Standing"], max - cur, nil, nil, nil, 1, 1, 1)
		end
	end
	tooltip:AddLine(" ")
	tooltip:AddLine(L["Click to open the reputation panel."], 0.2, 1, 0.2)
	tooltip:Show()
end

Progress:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) end)

function Progress:PLAYER_LOGIN()
	db = ProgressDB
	self:PLAYER_LEVEL_UP()

	if UnitLevel("player") < MAX_LEVEL then
		self:RegisterEvent("PLAYER_XP_UPDATE")
		self:RegisterEvent("UPDATE_EXHAUSTION")
	else
		self:RegisterEvent("UPDATE_FACTION")
		self:RegisterEvent("PLAYER_LEVEL_UP")
		hooksecurefunc("SetWatchedFactionIndex", function() return self:UpdateText() end)
	end
--[[
	local name, isHeader, isCollapsed, isWatched
	local n = GetNumFactions()
	for i = 1, n do
		name, _, _, _, _, _, _, _, isHeader, isCollapsed = GetFactionInfo(i)
		if isHeader then
			if name == L["Inactive"] then
				do break end
			elseif isCollapsed then
				ExpandFactionHeader(i)
				n = GetNumFactions()
				i = 1
			end
		end
	end
	for i = 1, n do
		name, _, _, _, _, _, _, _, isHeader, _, isWatched = GetFactionInfo(i)
		if not isHeader then
			if isWatched then
				db.watch = i

				local shortbase = name:gsub("^"..L["The"], "")
				local words = 0
				for word in shortbase:gmatch("[%s]+") do
					words = words + 1
				end
				if words == 1 then
					shortFactions[name] = shortbase:sub(1, 4):gsub("[^%a]", "")
				else
					local shortname = ""
					for word in shortbase:gmatch("[^s%-']+") do
						shortname = shortname..word:sub(1, 1)
					end
					shortFactions[name] = shortname
				end
			end
		end
	end
--]]
	self:UpdateText()

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

function Progress:PLAYER_LEVEL_UP()
	local level = UnitLevel("player")
	if level == MAX_LEVEL then
		xpToCurrentLevel = XP_TO_MAX_LEVEL
		self:RegisterEvent("UPDATE_FACTION")
		self:UnregisterEvent("PLAYER_LEVEL_UP")
		self:UnregisterEvent("PLAYER_XP_UPDATE")
		self:UnregisterEvent("UPDATE_EXHAUSTION")
		hooksecurefunc("SetWatchedFactionIndex", function() self:UpdateText() end)
	else
		xpToCurrentLevel = 0
		if level > 1 then
			for i = 1, level - 1 do
				xpToCurrentLevel = xpToCurrentLevel + XP_PER_LEVEL[i]
			end
		end
	end
end

Progress.UPDATE_FACTION = Progress.UpdateText
Progress.UPDATE_EXHAUSTION = Progress.UpdateText
Progress.PLAYER_XP_UPDATE = Progress.UpdateText

Progress:RegisterEvent("PLAYER_LOGIN")