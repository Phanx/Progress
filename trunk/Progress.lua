--[[--------------------------------------------------------------------
	Progress
	DataBroker plugin to show experience and reputation.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info11032-Progress.html
	http://www.curse.com/addons/wow/progress
----------------------------------------------------------------------]]

local _, ns = ...

------------------------------------------------------------------------

local L = setmetatable(ns.L or { }, { __index = function(t, k)
	if k == nil then return "" end
	local v = tostring(k)
	t[k] = v
	return v
end })

for k, v in pairs(L) do -- clean up missing translations
	if v == "" then
		L[k] = k
	end
end

L["Level"] = LEVEL
L["Faction"] = FACTION
L["Standing"] = STANDING
L["Reputation"] = REPUTATION

------------------------------------------------------------------------

local defaults = {
	forceRep = false,		-- Show reputation in the tooltip even if below max level
	friendlyNumbers = true,	-- Adds digit grouping to large numbers
	longText = false,		-- Show current level or watched faction on plugin text [NYI]
	shortFactions = true,	-- Abbreviate name shown with longText [NYI]
}

------------------------------------------------------------------------

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

local STANDING_LABEL_MALE = {
	FACTION_STANDING_LABEL1,
	FACTION_STANDING_LABEL2,
	FACTION_STANDING_LABEL3,
	FACTION_STANDING_LABEL4,
	FACTION_STANDING_LABEL5,
	FACTION_STANDING_LABEL6,
	FACTION_STANDING_LABEL7,
	FACTION_STANDING_LABEL8,
}

local STANDING_LABEL_FEMALE = {
	FACTION_STANDING_LABEL1_FEMALE,
	FACTION_STANDING_LABEL2_FEMALE,
	FACTION_STANDING_LABEL3_FEMALE,
	FACTION_STANDING_LABEL4_FEMALE,
	FACTION_STANDING_LABEL5_FEMALE,
	FACTION_STANDING_LABEL6_FEMALE,
	FACTION_STANDING_LABEL7_FEMALE,
	FACTION_STANDING_LABEL8_FEMALE,
}

------------------------------------------------------------------------

local XP_PER_LEVEL = { -- How much XP needed to reach each level
	0, -- 1
	400,
	900,
	1400,
	2100, -- 5
	2800,
	3600,
	4500,
	5400,
	6500, -- 10
	7600,
	8700,
	9800,
	11000,
	12300, -- 15
	13600,
	15000,
	16400,
	17800,
	19300, -- 20
	20800,
	22400,
	24000,
	25500,
	27200, -- 25
	28900,
	30500,
	32200,
	33900,
	36300, -- 30
	38800,
	41600,
	44600,
	48000, -- 35
	51400,
	55000,
	58700,
	62400,
	66200,
	70200, -- 40
	74300,
	78500,
	82800,
	87100,
	91600, -- 45
	96300,
	101000,
	105800,
	110700,
	115700, -- 50
	120900,
	126100,
	131500,
	137000,
	142500, -- 55
	148200,
	154000,
	159900,
	165800,
	172000, -- 60
	290000,
	317000,
	349000,
	386000,
	428000, -- 65
	475000,
	527000,
	585000,
	658000,
	717000, -- 70
	1523800,
	1539600,
	1555700,
	1571800,
	1587900, -- 75
	1604200,
	1620700,
	1637400,
	1653900,
	1670800, -- 80
	1686300,
	2121500,
	4004000,
	5203400,
	9165100, -- 85
}

------------------------------------------------------------------------

local MAX_PLAYER_LEVEL
local XP_TO_MAX_LEVEL = 0

local xpToCurrentLevel = 0
local shortFactions = { }

local math_floor = math.floor
local math_min = math.min
local string_format = string.format

------------------------------------------------------------------------

local Progress = CreateFrame("Frame")
Progress:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) end)
Progress:RegisterEvent("ADDON_LOADED")

------------------------------------------------------------------------

local function Debug(lvl, str, ...)
	if lvl > 0 then return end
	if ... then
		str = str:format(...)
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cffff7f7fProgress:|r "..str)
end

------------------------------------------------------------------------

------------------------------------------------------------------------

function Progress:ADDON_LOADED(addon)
	if addon ~= "Progress" then return end

	if not ProgressDB then
		ProgressDB = defaults
		self.db = ProgressDB
	else
		self.db = ProgressDB
		for k, v in pairs(defaults) do
			if type(self.db[k]) ~= type(defaults[k]) then
				self.db[k] = v
			end
		end
	end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	if IsLoggedIn() then
		self:PLAYER_LOGIN()
	else
		self:RegisterEvent("PLAYER_LOGIN")
	end
end

function Progress:PLAYER_LOGIN()
	MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()]

	for i = 1, MAX_PLAYER_LEVEL do
		local xp = XP_PER_LEVEL[i]
		if not xp then
			-- temp workaround for new expansions without data yet
			xp = XP_PER_LEVEL[i-1]
			XP_PER_LEVEL[i] = xp
		end
		XP_TO_MAX_LEVEL = XP_TO_MAX_LEVEL + xp
	end

	self.obj = LibStub("LibDataBroker-1.1"):NewDataObject("Progress", {
		type  = "data source",
		icon  = "Interface\\Icons\\INV_Misc_PocketWatch_02",
		label = L["Progress"],
		text  = UNKNOWN,
		OnClick = function() ToggleCharacter("ReputationFrame") end,
		OnTooltipShow = function(tip) return Progress:UpdateTooltip(tip) end,
	})

	self:PLAYER_LEVEL_UP()

	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		self:RegisterEvent("PLAYER_XP_UPDATE")
		self:RegisterEvent("UPDATE_EXHAUSTION")
	else
		self:RegisterEvent("UPDATE_FACTION")
		self:RegisterEvent("PLAYER_LEVEL_UP")
		hooksecurefunc("SetWatchedFactionIndex", function() return self:UpdateText() end)
	end
	self:UpdateText()

	self.UPDATE_FACTION = self.UpdateText
	self.UPDATE_EXHAUSTION = self.UpdateText
	self.PLAYER_XP_UPDATE = self.UpdateText

	self:RegisterEvent("PLAYER_LOGOUT")

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

function Progress:PLAYER_LOGOUT()
	for k, v in pairs(self.db) do
		if defaults[k] == v then
			self.db[k] = nil
		end
	end
end

function Progress:PLAYER_LEVEL_UP()
	local level = UnitLevel("player")
	if level == MAX_PLAYER_LEVEL then
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

------------------------------------------------------------------------

local groupmark = "%1" .. (tonumber("1.1") and "." or ",")

local function GroupDigits(num)
	if not num then return 0 end
	if abs(num) < 10000 then return num end

	local neg = num < 0 and "-" or ""
	local left, mid, right = tostring(abs(num)):match("^([^%d]*%d)(%d*)(.-)$")
	return ("%s%s%s%s"):format(neg, left, mid:reverse():gsub("(%d%d%d)", groupmark):reverse(), right)
end

function Progress:UpdateText()
	Debug(2, "UpdateText")
	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		local cur, max = UnitXP("player"), UnitXPMax("player")
		self.obj.text = ("%s (%d%%)"):format(GroupDigits(max - cur), math.floor(cur / max * 100 + 0.5))
	else
		local name, standing, min, max, cur = GetWatchedFactionInfo()
		if name then
			self.obj.text = ("%s%s (%d%%)|r"):format(STANDING_COLOR[standing], GroupDigits((max - min) - (cur - min)), math_floor((cur - min) / (max - min) * 100))
		else
			self.obj.text = L["Progress"]
		end
	end
end

function Progress:UpdateTooltip(tooltip)
	tooltip:AddLine(L["Progress"], 1, 1, 1)
	tooltip:AddLine(" ")

	local needblank
	local myLevel = UnitLevel("player")
	if myLevel < MAX_PLAYER_LEVEL then
		tooltip:AddDoubleLine(L["Level"], myLevel, nil, nil, nil, 1, 1, 1)
		if myLevel < MAX_PLAYER_LEVEL then
			local cur, max, rest = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
			tooltip:AddDoubleLine(L["Current XP"], ("%s / %s (%d%%)"):format(GroupDigits(cur), GroupDigits(max), math_floor(cur / max * 100 + 0.5)), nil, nil, nil, 1, 1, 1)
			if rest then
				tooltip:AddDoubleLine(L["Rested XP"], ("%s (%s%%)"):format(GroupDigits(rest), math_floor(rest / max * 1000 / 10 + 0.5)), nil, nil, nil, 1, 1, 1)
			end
			tooltip:AddDoubleLine(L["XP To Next Level"], GroupDigits(max - cur), nil, nil, nil, 1, 1, 1)
			tooltip:AddLine(" ")
			tooltip:AddDoubleLine(L["XP To Level %d"]:format(MAX_PLAYER_LEVEL), GroupDigits(XP_TO_MAX_LEVEL - (xpToCurrentLevel + cur)), nil, nil, nil, 1, 1, 1)
		end
		needblank = true
	end
	if myLevel == MAX_PLAYER_LEVEL or self.db.forceRep then
		local name, standing, min, max, cur = GetWatchedFactionInfo()
		if name then
			if needblank then
				tooltip:AddLine(" ")
				needblank = nil
			end
			tooltip:AddDoubleLine(L["Faction"], name, nil, nil, nil, 1, 1, 1)
			tooltip:AddDoubleLine(L["Standing"], format("%s%s|r", STANDING_COLOR[standing], UnitSex("player") == 3 and STANDING_LABEL_FEMALE[standing] or STANDING_LABEL_MALE[standing]))
			tooltip:AddDoubleLine(L["Reputation"], format("%s / %s (%d%%)", GroupDigits(cur - min), GroupDigits(max - min), math_floor(cur / max * 100 + 0.5)), nil, nil, nil, 1, 1, 1)
			if standing < 8 then
				tooltip:AddDoubleLine(L["To Next Standing"], GroupDigits(max - cur), nil, nil, nil, 1, 1, 1)
			end
		end
	end
	tooltip:AddLine(" ")
	tooltip:AddLine(L["Click to toggle the reputation panel."])
	tooltip:Show()
end