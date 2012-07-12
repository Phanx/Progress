--[[--------------------------------------------------------------------
	Progress
	DataBroker plugin to show experience and reputation.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info11032-Progress.html
	http://www.curse.com/addons/wow/progress
----------------------------------------------------------------------]]

local GAME_LOCALE = GetLocale()
if GAME_LOCALE:match("^en") then return end

local _, ns = ...
local L = { }
ns.L = L

--[[--------------------------------------------------------------------
	deDE | German | Deutsch
	Last updated: 2011-03-14 by Akkorian
----------------------------------------------------------------------]]

if GAME_LOCALE == "deDE" then
	L["Progress"] = "Fortschritt"
	L["Current XP"] = "Aktuelle EP"
	L["Rested XP"] = "Erholt EP"
	L["XP To Next Level"] = "EP zum nächsten Stufe"
	L["XP To Level %d"] = "EP zum Stufe 85"
	L["To Next Standing"] = "Ruf zum nächsten Einstellung"
	L["Click to toggle the reputation panel."] = "Klicken, um den Ruffenster anzuzeigen."
return end

--[[--------------------------------------------------------------------
	esES/esMX | Spanish (Europe/Latin America) | Español (Europa/América Latina)
	Last updated: 2011-03-14 by Akkorian
----------------------------------------------------------------------]]

if GAME_LOCALE == "esES" or GetLocale() == "esMX" then
	L["Progress"] = "Progreso"
	L["Current XP"] = "PE actual"
	L["Rested XP"] = "PE descansado"
	L["XP To Next Level"] = "PE al siguiente nivel"
	L["XP To Level %d"] = "PE al nivel %d"
	L["To Next Standing"] = "Al siguiente prestigio"
	L["Click to toggle the reputation panel."] = "Haz clic para abrir el panel de reputación."
return end

--[[--------------------------------------------------------------------
	frFR | French | Français
	Last updated: 2011-03-14 by Akkorian
----------------------------------------------------------------------]]

if GAME_LOCALE == "frFR" then
	L["Progress"] = "Progrès"
	L["Current XP"] = "PX actuelle"
	L["Rested XP"] = "PX reposée"
	L["XP To Next Level"] = "PX au niveau suivant"
	L["XP To Level %d"] = "PX au niveau %d"
	L["To Next Standing"] = "Rép. au statut supérieur"
	L["Click to toggle the reputation panel."] = "Cliquez pour afficher la feuille de réputation."
return end

--[[--------------------------------------------------------------------
	itIT | Italian | Italiano
	Last updated: YYYY-MM-DD by UNKNOWN
----------------------------------------------------------------------]]

if GAME_LOCALE == "itIT" then
--	L["Progress"] = ""
--	L["Current XP"] = ""
--	L["Rested XP"] = ""
--	L["XP To Next Level"] = ""
--	L["XP To Level %d"] = ""
--	L["To Next Standing"] = ""
--	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	ptBR | Portuguese (Brazil) | Português (Brasil)
	Last updated: 2011-12-05 by Phanx
----------------------------------------------------------------------]]

if GAME_LOCALE == "ptBR" then
	L["Progress"] = "Progresso"
	L["Current XP"] = "EXP atual"
	L["Rested XP"] = "EXP descansando"
	L["XP To Next Level"] = "EXP para nível seguinte"
	L["XP To Level %d"] = "EXP para nível %d"
	L["To Next Standing"] = "Rep. a situação próxima"
	L["Click to toggle the reputation panel."] = "Clique para mostrar/ocultar o painel de reputação."
return end

--[[--------------------------------------------------------------------
	ruRU | Russian | Русский
	Last updated: 2011-03-14 by Akkorian
----------------------------------------------------------------------]]

if GAME_LOCALE == "ruRU" then
	L["Progress"] = "Прогресс"
	L["Current XP"] = "Текущий опыт"
	L["Rested XP"] = "Отдых опыт"
	L["XP To Next Level"] = "к следующий уровня"
	L["XP To Level %d"] = "к %d-го уровня"
	L["To Next Standing"] = "к следующий отношения"
	L["Click to toggle the reputation panel."] = "Щелкните, чтобы открыть окно репутации."
return end

--[[--------------------------------------------------------------------
	koKR | Korean | 한국어
	Last updated: YYYY-MM-DD by UNKNOWN
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
	zhCN | Simplified Chinese | 简体中文
	Last updated: YYYY-MM-DD by UNKNOWN
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
	zhTW | Traditional Chinese | 繁體中文
	Last updated: YYYY-MM-DD by UNKNOWN
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