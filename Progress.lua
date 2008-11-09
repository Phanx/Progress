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
local XP_TO_LEVEL = {
		 0,       400,     1300,     2700,     4800, 	-- 5
	   7600,     11200,    15700,    21100,    27600, 	-- 10
	  35200,     44000,    54100,    65500,    78400, 	-- 15
	  92800,    108800,   126500,   145900,   167200, 	-- 20
	  190400,   215600,   242900,   272300,   304000, 	-- 25
	  338000,   374400,   413300,   454700,   499000, 	-- 30
	  546400,   597200,   651900,   710500,   773300, 	-- 25
	  840300,   911900,   988000,  1068800,  1154500, 	-- 40
	 1245200,  1341000,  1442000,  1548300,  1660100, 	-- 45
	 1777500,  1900700,  2029800,  2164900,  2306100, 	-- 50
	 2453600,  2607500,  2767900,  2935000,  3108900, 	-- 55
	 3289700,  3477600,  3672600,  3874900,  4084700, 	-- 60
	 4578700,  5153400,  5767800,  6418100,  7100400, 	-- 65 -- TODO: Update for Wrath changes
	 7810600,  8544700,  9298400, 10067300, 10847000, 	-- 70 -- TODO: Update for Wrath changes
	12588500,        0,        0,        0,        0, 	-- 75 -- TODO: Add Wrath data
	       0,        0,        0,        0,        0, 	-- 80 -- TODO: Add Wrath data
}
local MAX_LEVEL = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()] or 80 -- #TODO: Change for Wrath
local XP_TO_MAX_LEVEL = XP_TO_LEVEL[MAX_LEVEL]
local db, shortfactions = ProgressDB, {}
local L = setmetatable(Progress_LOCALS or {}, { __index = function(t, k) rawset(t, k, k) return k end })

local function Debug(lvl, str, ...)
	if lvl > 0 then return end
	if select("#", ...) > 0 then
		str = str:format(...)
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cffff7f7fProgress:|r "..str)
end

local function GetQuadrant(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "BOTTOMLEFT", "BOTTOM", "LEFT" end
	local hhalf = (x > UIParent:GetWidth()/2) and "RIGHT" or "LEFT"
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, vhalf, hhalf
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

function Progress.obj:OnEnter()
	local quad, vhalf, hhalf = GetQuadrant(self)
	local anchpoint = (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(quad, self, anchpoint)

	GameTooltip:AddLine(L["Progress"])

	local needblank
	local myLevel = UnitLevel("player")
	if myLevel < MAX_LEVEL then
		GameTooltip:AddDoubleLine(L["Current Level"], myLevel, nil, nil, nil, 1, 1, 1)
		if myLevel < MAX_LEVEL then
			local cur, max, rest = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
			GameTooltip:AddDoubleLine(L["Current XP"], cur.."/"..max.." ("..floor(cur / max * 100).."%)", nil, nil, nil, 1, 1, 1)
			if rest then
				local restperc
				if rest - (max - cur) > 0 then
					restperc = floor((rest - (max - cur)) / max * 100) + 100
				else
					restperc = floor(rest / max * 100)
				end
				GameTooltip:AddDoubleLine(L["Rested XP"], rest.." ("..restperc..")%", nil, nil, nil, 1, 1, 1)
			end
			GameTooltip:AddDoubleLine(L["XP To Next Level"], max - cur, nil, nil, nil, 1, 1, 1)
			if not IS_WRATH_BUILD then
				GameTooltip:AddDoubleLine(L["XP To Level %d"]:format(MAX_LEVEL), XP_TO_MAX_LEVEL - (XP_TO_LEVEL[myLevel] + cur), nil, nil, nil, 1, 1, 1)
			end
		end
		needblank = true
	end
	if myLevel == MAX_LEVEL or db.forceRep then
		if needblank then
			GameTooltip:AddLine(" ")
			needblank = nil
		end
		local name, standing, min, max, cur = GetWatchedFactionInfo()
		GameTooltip:AddDoubleLine(L["Faction"], name, nil, nil, nil, 1, 1, 1)
		GameTooltip:AddDoubleLine(L["Standing"], STANDING_COLOR[standing].._G["FACTION_STANDING_LABEL"..standing].."|r")
		GameTooltip:AddDoubleLine(L["Progress"], (cur - min).."/"..(max - min), nil, nil, nil, 1, 1, 1)
		if standing < 8 then
			GameTooltip:AddDoubleLine(L["To Next Standing"], max - cur, nil, nil, nil, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(L["Click to open the reputation panel."], 0.2, 1, 0.2)
	GameTooltip:Show()
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
					shortfactions[name] = shortbase:sub(1, 4):gsub("[^%a]", "")
				else
					local shortname = ""
					for word in shortbase:gmatch("[^s%-']+") do
						shortname = shortname..word:sub(1, 1)
					end
					shortfactions[name] = shortname
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
	if UnitLevel("player") == MAX_LEVEL then
		self:RegisterEvent("UPDATE_FACTION")
		self:UnregisterEvent("PLAYER_LEVEL_UP")
		self:UnregisterEvent("PLAYER_XP_UPDATE")
		self:UnregisterEvent("UPDATE_EXHAUSTION")
		hooksecurefunc("SetWatchedFactionIndex", function() self:UpdateText() end)
	end
end

Progress.UPDATE_FACTION = Progress.UpdateText
Progress.UPDATE_EXHAUSTION = Progress.UpdateText
Progress.PLAYER_XP_UPDATE = Progress.UpdateText

Progress:RegisterEvent("PLAYER_LOGIN")