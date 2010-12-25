--[[--------------------------------------------------------------------
	Progress
	DataBroker plugin to show experience and reputation.
	by Phanx < addons@phanx.net >
	Currently maintained by Akkorian < akkorian@hotmail.com >
	Copyright © 2008–2010 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info11032-Progress.html
	http://wow.curse.com/downloads/wow-addons/details/progress.aspx
----------------------------------------------------------------------]]

local _, ns = ...
if not ns then ns = { } _G.Progress = ns end -- WoW China

--[[--------------------------------------------------------------------
	deDE | Deutsch | German
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GetLocale() == "deDE" then
	L["Current Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Progress"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
end

--[[--------------------------------------------------------------------
	esES | Español (EU) | Spanish (Europe)
	esMX | Español (AL) | Spanish (Latin America)
	Last updated: 2010-12-23 by Akkorian
----------------------------------------------------------------------]]

if GetLocale() == "esES" or GetLocale() == "esMX" then
	L["Current Level"] = "Nivel actual"
	L["Current XP"] = "PE actual"
	L["Rested XP"] = "PE descansado"
	L["XP To Next Level"] = "PE al siguiente nivel"
	L["XP To Level %d"] = "PE al nivel %d"
	L["Faction"] = "Facción"
	L["Standing"] = "Prestigio"
	L["Progress"] = "Progreso"
	L["To Next Standing"] = "Al siguiente nivel de prestigio"
	L["Click to toggle the reputation panel."] = "Haz clic para mostrar/ocultar el panel de reputación."
end

--[[--------------------------------------------------------------------
	frFR | Français | French
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GetLocale() == "frFR" then
	L["Current Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Progress"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
end

--[[--------------------------------------------------------------------
	ruRU | Русский | Russian
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GetLocale() == "ruRU" then
	L["Current Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Progress"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
end

--[[--------------------------------------------------------------------
	koKR | 한국어 | Korean
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GetLocale() == "koKR" then
	L["Current Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Progress"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
end

--[[--------------------------------------------------------------------
	zhCN | 简体中文 | Simplified Chinese
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GetLocale() == "zhCN" then
	L["Current Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Progress"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
end

--[[--------------------------------------------------------------------
	zhTW | 正體中文 | Traditional Chinese
	Last updated: YYYY-MM-DD by UNKNOWN < CONTACT INFO >
----------------------------------------------------------------------]]

if GetLocale() == "zhTW" then
	L["Current Level"] = ""
	L["Current XP"] = ""
	L["Rested XP"] = ""
	L["XP To Next Level"] = ""
	L["XP To Level %d"] = ""
	L["Faction"] = ""
	L["Standing"] = ""
	L["Progress"] = ""
	L["To Next Standing"] = ""
	L["Click to toggle the reputation panel."] = ""
end