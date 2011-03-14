--[[--------------------------------------------------------------------
	Progress
	DataBroker plugin to show experience and reputation.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info11032-Progress.html
	http://wow.curse.com/downloads/wow-addons/details/progress.aspx
----------------------------------------------------------------------]]

local GAME_LOCALE = GetLocale()
if GAME_LOCALE:match("^en") then return end

local _, ns = ...
local L = { }
ns.L = L

--[[--------------------------------------------------------------------
	deDE | Deutsch | German
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GAME_LOCALE == "deDE" then
--	L["Progress"] = ""
--	L["Current XP"] = ""
--	L["Rested XP"] = ""
--	L["XP To Next Level"] = ""
--	L["XP To Level %d"] = ""
--	L["To Next Standing"] = ""
--	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	esES | Español (EU) | Spanish (Europe)
	esMX | Español (AL) | Spanish (Latin America)
	Last updated: 2010-12-23 by Akkorian
----------------------------------------------------------------------]]

if GAME_LOCALE == "esES" or GetLocale() == "esMX" then
	L["Progress"] = "Progreso"
	L["Current XP"] = "PE actual"
	L["Rested XP"] = "PE descansado"
	L["XP To Next Level"] = "PE al siguiente nivel"
	L["XP To Level %d"] = "PE al nivel %d"
	L["To Next Standing"] = "Al siguiente prestigio"
	L["Click to toggle the reputation panel."] = "Haz clic para mostrar/ocultar\nel panel de reputación."
return end

--[[--------------------------------------------------------------------
	frFR | Français | French
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GAME_LOCALE == "frFR" then
--	L["Progress"] = ""
--	L["Current XP"] = ""
--	L["Rested XP"] = ""
--	L["XP To Next Level"] = ""
--	L["XP To Level %d"] = ""
--	L["To Next Standing"] = ""
--	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	ruRU | Русский | Russian
	Last updated: 2011-03-14 by Akkorian
----------------------------------------------------------------------]]

if GAME_LOCALE == "ruRU" then
	L["Progress"] = "Прогресс"
	L["Current XP"] = "Текущий опыт"
	L["Rested XP"] = "Отдых опыт"
	L["XP To Next Level"] = "к следующий уровень"
	L["XP To Level %d"] = "к %d-го уровня"
	L["To Next Standing"] = "к следующий отношения"
	L["Click to toggle the reputation panel."] = "Щелкните, чтобы открыть окно репутации."
return end

--[[--------------------------------------------------------------------
	koKR | 한국어 | Korean
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GAME_LOCALE == "koKR" then
--	L["Progress"] = ""
--	L["Current XP"] = ""
--	L["Rested XP"] = ""
--	L["XP To Next Level"] = ""
--	L["XP To Level %d"] = ""
--	L["To Next Standing"] = ""
--	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	zhCN | 简体中文 | Simplified Chinese
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GAME_LOCALE == "zhCN" then
--	L["Progress"] = ""
--	L["Current XP"] = ""
--	L["Rested XP"] = ""
--	L["XP To Next Level"] = ""
--	L["XP To Level %d"] = ""
--	L["To Next Standing"] = ""
--	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	zhTW | 正體中文 | Traditional Chinese
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GAME_LOCALE == "zhTW" then
--	L["Progress"] = ""
--	L["Current XP"] = ""
--	L["Rested XP"] = ""
--	L["XP To Next Level"] = ""
--	L["XP To Level %d"] = ""
--	L["To Next Standing"] = ""
--	L["Click to toggle the reputation panel."] = ""
return end