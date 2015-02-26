--[[--------------------------------------------------------------------
	Progress
	Basic experience and reputation plugin for DataBroker displays.
	Copyright (c) 2008-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info11032-Progress.html
	http://www.curse.com/addons/wow/progress
	https://github.com/Phanx/Progress
----------------------------------------------------------------------]]

local GAME_LOCALE = GetLocale()
if GAME_LOCALE:match("^en") then return end

local _, ns = ...
local L = { }
ns.L = L

--[[--------------------------------------------------------------------
	deDE | German | Deutsch
	Last updated: 2014-11-07 by Phanx
----------------------------------------------------------------------]]

if GAME_LOCALE == "deDE" then
	L["Progress"] = "Fortschritt"
	L["Current XP"] = "Aktuelle EP"
	L["Rested XP"] = "Erholte EP"
	L["To Next Level"] = "Zur nächsten Stufe"
	L["To Level %d"] = "Zur Stufe %d"
	L["To Next Standing"] = "Zur nächsten Einstellung"
	L["Click to toggle the reputation panel."] = "Klick, um den Ruffenster anzuzeigen."
return end

--[[--------------------------------------------------------------------
	esES / esMX | European / Latin American Spanish | Español de España / America latina
	Last updated: 2014-11-07 by Phanx
----------------------------------------------------------------------]]

if GAME_LOCALE == "esES" or GetLocale() == "esMX" then
	L["Progress"] = "Progreso"
	L["Current XP"] = "PE actual"
	L["Rested XP"] = "PE descansado"
	L["To Next Level"] = "Al siguiente nivel"
	L["To Level %d"] = "Al nivel %d"
	L["To Next Standing"] = "Al siguiente prestigio"
	L["Click to toggle the reputation panel."] = "Haz clic para abrir el panel de reputación."
return end

--[[--------------------------------------------------------------------
	frFR | French | Français
	Last updated: 2014-11-07 by Phanx
----------------------------------------------------------------------]]

if GAME_LOCALE == "frFR" then
	L["Progress"] = "Progrès"
	L["Current XP"] = "PX actuelle"
	L["Rested XP"] = "PX reposée"
	L["To Next Level"] = "Au niveau suivant"
	L["To Level %d"] = "Au niveau %d"
	L["To Next Standing"] = "Au statut supérieur"
	L["Click to toggle the reputation panel."] = "Cliquez pour afficher la feuille de réputation."
return end

--[[--------------------------------------------------------------------
	itIT | Italian | Italiano
	Last updated: 2012-08-26 by Phanx
----------------------------------------------------------------------]]

if GAME_LOCALE == "itIT" then
	L["Progress"] = "Progressi"
	L["Current XP"] = "PE attuali"
	L["Rested XP"] = "PE riposato"
	L["To Next Level"] = "Al livello successivo"
	L["To Level %d"] = "Al livello %d"
	L["To Next Standing"] = "Al prestigio successivo"
	L["Click to toggle the reputation panel."] = "Clicca per mostrare il pannello delle reputazioni."
return end

--[[--------------------------------------------------------------------
	ptBR | Portuguese (Brazil) | Português (Brasil)
	Last updated: 2011-12-05 by Phanx
----------------------------------------------------------------------]]

if GAME_LOCALE == "ptBR" then
	L["Progress"] = "Progresso"
	L["Current XP"] = "EXP atual"
	L["Rested XP"] = "EXP descansando"
	L["To Next Level"] = "Para nível seguinte"
	L["To Level %d"] = "Para nível %d"
	L["To Next Standing"] = "Para situação próxima"
	L["Click to toggle the reputation panel."] = "Clique para mostrar/ocultar o painel de reputação."
return end

--[[--------------------------------------------------------------------
	ruRU | Russian | Русский
	Last updated: 2011-03-14 by Phanx
----------------------------------------------------------------------]]

if GAME_LOCALE == "ruRU" then
	L["Progress"] = "Прогресс"
	L["Current XP"] = "Текущий опыт"
	L["Rested XP"] = "Отдых опыт"
	L["To Next Level"] = "к следующий уровня"
	L["To Level %d"] = "к %d-го уровня"
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
--	L["To Next Level"] = ""
--	L["To Level %d"] = ""
--	L["To Next Standing"] = ""
--	L["Click to toggle the reputation panel."] = ""
return end

--[[--------------------------------------------------------------------
	zhCN | Simplified Chinese | 简体中文
	Last updated: 2012-10-16 by okaydud
----------------------------------------------------------------------]]

if GAME_LOCALE == "zhCN" then
--	L["Progress"] = ""
	L["Current XP"] = "当前经验"
	L["Rested XP"] = "休息奖励"
	L["To Next Level"] = "离升级所需经验"
	L["To Level %d"] = "等级%d所需经验"
	L["To Next Standing"] = "到下一地位"
	L["Click to toggle the reputation panel."] = "点击打开声望面板"
return end

--[[--------------------------------------------------------------------
	zhTW | Traditional Chinese | 繁體中文
	Last updated: YYYY-MM-DD by UNKNOWN
----------------------------------------------------------------------]]

if GAME_LOCALE == "zhTW" then
--	L["Progress"] = ""
--	L["Current XP"] = ""
--	L["Rested XP"] = ""
--	L["To Next Level"] = ""
--	L["To Level %d"] = ""
--	L["To Next Standing"] = ""
--	L["Click to toggle the reputation panel."] = ""
return end