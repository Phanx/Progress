--[[--------------------------------------------------------------------
	Progress
	DataBroker plugin to show experience and reputation.
	by Phanx < addons@phanx.net >
	Currently maintained by Akkorian < akkorian@hotmail.com >
	Copyright © 2008–2010 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info11032-Progress.html
	http://wow.curse.com/downloads/wow-addons/details/progress.aspx
----------------------------------------------------------------------]]

local locale = GetLocale()
if locale:match("^en") then return end

local _, ns = ...
if not ns then ns = { } _G.Progress = ns end -- WoW China

local L = { }
ns.L = L

--[[--------------------------------------------------------------------
	deDE | Deutsch | German
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if locale == "deDE" then
	L["Progress"] = ""
	L["Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Reputation"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	esES | Español (EU) | Spanish (Europe)
	esMX | Español (AL) | Spanish (Latin America)
	Last updated: 2010-12-23 by Akkorian
----------------------------------------------------------------------]]

if locale == "esES" or GetLocale() == "esMX" then
	L["Progress"] = "Progreso"
	L["Level"] = "Nivel"
	L["Current XP"] = "PE actual"
	L["Rested XP"] = "PE descansado"
	L["XP To Next Level"] = "PE al siguiente nivel"
	L["XP To Level %d"] = "PE al nivel %d"
	L["Faction"] = "Facción"
	L["Standing"] = "Prestigio"
	L["Reputation"] = "Reputación"
	L["To Next Standing"] = "Al siguiente prestigio"
	L["Click to toggle the reputation panel."] = "Haz clic para mostrar/ocultar\nel panel de reputación."
return end

--[[--------------------------------------------------------------------
	frFR | Français | French
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if locale == "frFR" then
	L["Progress"] = ""
	L["Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Reputation"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	ruRU | Русский | Russian
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if locale == "ruRU" then
	L["Progress"] = ""
	L["Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Reputation"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	koKR | 한국어 | Korean
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if locale == "koKR" then
	L["Progress"] = ""
	L["Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Reputation"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	zhCN | 简体中文 | Simplified Chinese
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if locale == "zhCN" then
	L["Progress"] = ""
	L["Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Reputation"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	zhTW | 正體中文 | Traditional Chinese
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if locale == "zhTW" then
	L["Progress"] = ""
	L["Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Reputation"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
return end