--[[--------------------------------------------------------------------
	Progress
	DataBroker plugin to show experience and reputation.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info11032-Progress.html
	http://www.curse.com/addons/wow/progress

	Please DO NOT upload this addon to other websites, or post modified
	versions of it. However, you are welcome to include a copy of it
	WITHOUT CHANGES in compilations posted on Curse and/or WoWInterface.
	You are also welcome to use any/all of its code in your own addon, as
	long as you do not use my name or the name of this addon ANYWHERE in
	your addon, including its name, outside of an optional attribution.
----------------------------------------------------------------------]]

local _, ns = ...

------------------------------------------------------------------------

local L = setmetatable( ns.L or { }, { __index = function( t, k )
	if k == nil then return "" end
	local v = tostring( k )
	t[k] = v
	return v
end } )

for k, v in pairs( L ) do -- clean up missing translations
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
      0,      400,      900,     1400,     2100,     2800,     3600,     4500,     5400,     6500, -- 10
   6080,     6960,     7840,     8800,     9840,    10800,    12000,    13120,    14240,    15400, -- 20
  16640,    17920,    19200,    20400,    21760,    23123,    24400,    25760,    21120,    29040, -- 30
  31040,    33280,    35680,    38400,    41120,    44000,    46960,    49920,    52960,    56160, -- 40
  74300,    78500,    82800,    87100,    91600,    96300,   101000,   105800,   110700,   115700, -- 50
 120900,   126100,   131500,   137000,   142500,   148200,   154000,   159900,   165800,   172000, -- 60
 290000,   317000,   349000,   386000,   428000,   475000,   527000,   585000,   648000,   717000, -- 70
 812700,   821000,   830000,   838000,   847000,   855300,   865000,   873000,   882000,   891000, -- 80
1686300,  2121500,  2642640,  3434200,  4582500,  8670000, 10050000, 12650000, 15250000, 18370000, -- 90
-- 100
}

------------------------------------------------------------------------

local XP_TO_MAX_LEVEL = 0
local MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL_TABLE[ GetExpansionLevel() ]
for i = #XP_PER_LEVEL + 1, MAX_PLAYER_LEVEL do
	-- workaround for new expansions without data yet
	XP_PER_LEVEL[ i ] = XP_PER_LEVEL[ i - 1 ]
end
for i = 1, MAX_PLAYER_LEVEL do
	XP_TO_MAX_LEVEL = XP_TO_MAX_LEVEL + XP_PER_LEVEL[ i ]
end

local xpToCurrentLevel = 0
local shortFactions = {}

------------------------------------------------------------------------

local Progress = CreateFrame( "Frame" )
Progress:SetScript( "OnEvent", function( self, event, ... ) return self[event] and self[event]( self, ... ) end )
Progress:RegisterEvent( "ADDON_LOADED" )

------------------------------------------------------------------------

local function Debug( lvl, str, ... )
	if lvl > 0 then return end
	if ... then
		str = str:format( ... )
	end
	DEFAULT_CHAT_FRAME:AddMessage( "|cffff7f7fProgress:|r " .. str )
end

------------------------------------------------------------------------

function Progress:ADDON_LOADED( addon )
	if addon ~= "Progress" then return end

	if not ProgressDB then
		ProgressDB = defaults
		self.db = ProgressDB
	else
		self.db = ProgressDB
		for k, v in pairs( defaults ) do
			if type( self.db[k] ) ~= type( defaults[k] ) then
				self.db[k] = v
			end
		end
	end

	self:UnregisterEvent( "ADDON_LOADED" )
	self.ADDON_LOADED = nil

	if IsLoggedIn() then
		self:PLAYER_LOGIN()
	else
		self:RegisterEvent( "PLAYER_LOGIN" )
	end
end

function Progress:PLAYER_LOGIN()
	self.obj = LibStub( "LibDataBroker-1.1" ):NewDataObject( "Progress", {
		type  = "data source",
		icon  = "Interface\\Icons\\INV_Misc_PocketWatch_02",
		label = L["Progress"],
		text  = UNKNOWN,
		OnClick = function() ToggleCharacter( "ReputationFrame" ) end,
		OnTooltipShow = function( tooltip ) return Progress:UpdateTooltip( tooltip ) end,
	} )

	self:PLAYER_LEVEL_UP()

	if UnitLevel( "player" ) < MAX_PLAYER_LEVEL then
		self:RegisterEvent( "PLAYER_XP_UPDATE" )
		self:RegisterEvent( "UPDATE_EXHAUSTION" )
	else
		self:RegisterEvent( "UPDATE_FACTION" )
		self:RegisterEvent( "PLAYER_LEVEL_UP" )
		hooksecurefunc( "SetWatchedFactionIndex", function() return self:UpdateText() end )
	end
	self:UpdateText()

	self.UPDATE_FACTION = self.UpdateText
	self.UPDATE_EXHAUSTION = self.UpdateText
	self.PLAYER_XP_UPDATE = self.UpdateText

	self:RegisterEvent( "PLAYER_LOGOUT" )

	self:UnregisterEvent( "PLAYER_LOGIN" )
	self.PLAYER_LOGIN = nil
end

function Progress:PLAYER_LOGOUT()
	for k, v in pairs( self.db ) do
		if defaults[k] == v then
			self.db[k] = nil
		end
	end
end

function Progress:PLAYER_LEVEL_UP()
	local level = UnitLevel( "player" )
	if level == MAX_PLAYER_LEVEL then
		xpToCurrentLevel = XP_TO_MAX_LEVEL
		self:RegisterEvent( "UPDATE_FACTION" )
		self:UnregisterEvent( "PLAYER_LEVEL_UP" )
		self:UnregisterEvent( "PLAYER_XP_UPDATE" )
		self:UnregisterEvent( "UPDATE_EXHAUSTION" )
		hooksecurefunc( "SetWatchedFactionIndex", function() self:UpdateText() end )
	else
		xpToCurrentLevel = 0
		if level > 1 then
			for i = 1, level do
				xpToCurrentLevel = xpToCurrentLevel + XP_PER_LEVEL[i]
			end
		end
	end
end

------------------------------------------------------------------------

local grouped = "%1" .. LARGE_NUMBER_SEPERATOR
if GetLocale() == "ruRU" then
	grouped = "%1 " -- Blizzard forgot to define LARGE_NUMBER_SEPERATOR in the Russian client
end

local function GroupDigits( num )
	if not num then return 0 end
	if abs( num ) < 10000 then return num end

	local neg = num < 0 and "-" or ""
	local left, mid, right = strmatch( tostring( abs( num ) ), "^([^%d]*%d)(%d*)(.-)$" )
	return format( "%s%s%s%s", neg, left, strrev( gsub( strrev( mid ), "(%d%d%d)", grouped ) ), right )
end

function Progress:UpdateText()
	Debug( 2, "UpdateText" )
	if UnitLevel( "player" ) < MAX_PLAYER_LEVEL then
		local cur, max = UnitXP( "player" ), UnitXPMax( "player" )
		self.obj.text = format( "%s (%d%%)", GroupDigits( max - cur ), floor( cur / max * 100 + 0.5 ) )
		return
	end

	local name, standing, min, max, cur = GetWatchedFactionInfo()
	if name then
		max, cur = max - min, cur - min
		if max > 0 then -- avoid "integer overflow attentping to store -1.#IND" ???
			self.obj.text = format( "%s%s (%d%%)|r", STANDING_COLOR[standing], GroupDigits( max - cur ), floor( cur / max * 100 + 0.5 ) )
			return
		end
	end

	self.obj.text = L["Progress"]
end

function Progress:UpdateTooltip( tooltip )
	tooltip:AddLine( L["Progress"], 1, 1, 1 )
	tooltip:AddLine( " " )

	local needblank
	local myLevel = UnitLevel( "player" )
	if myLevel < MAX_PLAYER_LEVEL then
		tooltip:AddDoubleLine( L["Level"], myLevel, nil, nil, nil, 1, 1, 1 )
		if myLevel < MAX_PLAYER_LEVEL then
			local cur, max, rest = UnitXP( "player" ), UnitXPMax( "player" ), GetXPExhaustion()
			local total = xpToCurrentLevel + cur
			tooltip:AddDoubleLine( L["Current XP"], format( "%s / %s (%d%%)", GroupDigits( cur ), GroupDigits( max ), floor( cur / max * 100 + 0.5 ) ), nil, nil, nil, 1, 1, 1 )
			if rest then
				tooltip:AddDoubleLine( L["Rested XP"], format( "%s (%s%%)", GroupDigits( rest ), floor( rest / max * 100 + 0.5 ) ), nil, nil, nil, 1, 1, 1 )
			end
			tooltip:AddDoubleLine( L["XP To Next Level"], GroupDigits( max - cur ), nil, nil, nil, 1, 1, 1 )
			tooltip:AddLine( " " )
			tooltip:AddDoubleLine( format( L["XP To Level %d"], MAX_PLAYER_LEVEL ), GroupDigits( XP_TO_MAX_LEVEL - total ), nil, nil, nil, 1, 1, 1 )
			tooltip:AddDoubleLine( " ", format( "%d%%", floor( total / XP_TO_MAX_LEVEL * 100 + 0.5 ) ), nil, nil, nil, 1, 1, 1 )
		end
		needblank = true
	end
	if myLevel == MAX_PLAYER_LEVEL or self.db.forceRep then
		local name, standing, min, max, cur = GetWatchedFactionInfo()
		if name then
			if needblank then
				tooltip:AddLine( " " )
				needblank = nil
			end
			min, max, cur = 0, max - min, cur - min
			tooltip:AddDoubleLine( L["Faction"], name, nil, nil, nil, 1, 1, 1 )
			tooltip:AddDoubleLine( L["Standing"], format( "%s%s|r", STANDING_COLOR[standing], UnitSex( "player" ) == 3 and STANDING_LABEL_FEMALE[standing] or STANDING_LABEL_MALE[standing] ) )
			tooltip:AddDoubleLine( L["Reputation"], format( "%s / %s (%d%%)", GroupDigits( cur ), GroupDigits( max ), floor( cur / max * 100 + 0.5 ) ), nil, nil, nil, 1, 1, 1 )
			if standing < 8 then
				tooltip:AddDoubleLine( L["To Next Standing"], GroupDigits( max - cur ), nil, nil, nil, 1, 1, 1 )
			end
		end
	end
	tooltip:AddLine( " " )
	tooltip:AddLine( L["Click to toggle the reputation panel."] )
	tooltip:Show()
end