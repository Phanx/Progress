﻿--[[--------------------------------------------------------------------
	Progress
	Basic experience and reputation plugin for DataBroker displays.
	Copyright (c) 2008-2017 Phanx <addons@phanx.net>. All rights reserved.
	https://github.com/Phanx/Progress
	https://mods.curse.com/addons/wow/progress
	https://www.wowinterface.com/downloads/info11032-Progress.html
----------------------------------------------------------------------]]

local GAME_LOCALE = GetLocale()
if GAME_LOCALE:match("^en") then return end

local _, ns = ...
local L = { }
ns.L = L

-- THE REST OF THIS FILE IS AUTOMATICALLY GENERATED.
-- https://wow.curseforge.com/addons/progress/localization/

------------------------------------------------------------------------
-- English
------------------------------------------------------------------------

local CURRENT_LOCALE = GetLocale()
if CURRENT_LOCALE == "enUS" then return end

------------------------------------------------------------------------
-- German
------------------------------------------------------------------------

if CURRENT_LOCALE == "deDE" then

L["Click to toggle the reputation panel."] = "Klicken, um den Ruffenster anzuzeigen."
L["Current XP"] = "Aktuelle EP"
L["Progress"] = "Fortschritt"
L["Rested XP"] = "Erholt EP"
L["To Next Standing"] = "Ruf zum nächsten Einstellung"
L["XP To Level %d"] = "EP zum Stufe 85"
L["XP To Next Level"] = "EP zum nächsten Stufe"

return end

------------------------------------------------------------------------
-- Spanish
------------------------------------------------------------------------

if CURRENT_LOCALE == "esES" then

L["Click to toggle the reputation panel."] = "Haz clic para abrir el panel de reputación."
L["Current XP"] = "PE actual"
L["Progress"] = "Progreso"
L["Rested XP"] = "PE descansado"
L["To Next Standing"] = "Al siguiente prestigio"
L["XP To Level %d"] = "PE al nivel %d"
L["XP To Next Level"] = "PE al siguiente nivel"

return end

------------------------------------------------------------------------
-- Latin American Spanish
------------------------------------------------------------------------

if CURRENT_LOCALE == "esMX" then

L["Click to toggle the reputation panel."] = "Haz clic para abrir el panel de reputación."
L["Current XP"] = "PE actual"
L["Progress"] = "Progreso"
L["Rested XP"] = "PE descansado"
L["To Next Standing"] = "Al siguiente prestigio"
L["XP To Level %d"] = "PE al nivel %d"
L["XP To Next Level"] = "PE al siguiente nivel"

return end

------------------------------------------------------------------------
-- French
------------------------------------------------------------------------

if CURRENT_LOCALE == "frFR" then

L["Click to toggle the reputation panel."] = "Cliquez pour afficher la feuille de réputation."
L["Current XP"] = "PX actuelle"
L["Progress"] = "Progrès"
L["Rested XP"] = "PX reposée"
L["To Next Standing"] = "Rép. au statut supérieur"
L["XP To Level %d"] = "PX au niveau %d"
L["XP To Next Level"] = "PX au niveau suivant"

return end

------------------------------------------------------------------------
-- Italian
------------------------------------------------------------------------

if CURRENT_LOCALE == "itIT" then

L["Click to toggle the reputation panel."] = "Clicca per mostrare il pannello delle reputazioni."
L["Current XP"] = "PE attuali"
L["Progress"] = "Progressi"
L["Rested XP"] = "PE riposato"
L["To Next Standing"] = "Al prestigio successivo"
L["XP To Level %d"] = "PE al livello %d"
L["XP To Next Level"] = "PE al livello successivo"

return end

------------------------------------------------------------------------
-- Brazilian Portuguese
------------------------------------------------------------------------

if CURRENT_LOCALE == "ptBR" then

L["Click to toggle the reputation panel."] = "Clique para mostrar/ocultar o painel de reputação."
L["Current XP"] = "EXP atual"
L["Progress"] = "Progresso"
L["Rested XP"] = "EXP descansando"
L["To Next Standing"] = "Rep. a situação próxima"
L["XP To Level %d"] = "EXP para nível %d"
L["XP To Next Level"] = "EXP para nível seguinte"

return end

------------------------------------------------------------------------
-- Russian
------------------------------------------------------------------------

if CURRENT_LOCALE == "ruRU" then

L["Click to toggle the reputation panel."] = "Щелкните, чтобы открыть окно репутации."
L["Current XP"] = "Текущий опыт"
L["Progress"] = "Прогресс"
L["Rested XP"] = "Отдых опыт"
L["To Next Standing"] = "к следующий отношения"
L["XP To Level %d"] = "к %d-го уровня"
L["XP To Next Level"] = "к следующий уровень"

return end

------------------------------------------------------------------------
-- Korean
------------------------------------------------------------------------

if CURRENT_LOCALE == "koKR" then

L["Click to toggle the reputation panel."] = "클릭 : 평판 창 토글"
L["Current XP"] = "현재 경험치"
L["Rested XP"] = "휴식 경험치"
L["XP To Level %d"] = "%d 레벨까지 경험치"
L["XP To Next Level"] = "다음 레벨까지 경험치"

return end

------------------------------------------------------------------------
-- Simplified Chinese
------------------------------------------------------------------------

if CURRENT_LOCALE == "zhCN" then

L["Click to toggle the reputation panel."] = "点击打开声望面板"
L["Current XP"] = "当前经验"
L["Rested XP"] = "休息奖励"
L["To Next Standing"] = "到下一地位"
L["XP To Level %d"] = "等级%d所需经验"
L["XP To Next Level"] = "离升级所需经验"

return end

------------------------------------------------------------------------
-- Traditional Chinese
------------------------------------------------------------------------

if CURRENT_LOCALE == "zhTW" then

L["Click to toggle the reputation panel."] = "點擊打開聲望面板"
L["Current XP"] = "當前經驗值"
L["Progress"] = "進度"
L["Rested XP"] = "休息獎勵經驗值"
L["XP To Level %d"] = "升至%d級所需經驗值"
L["XP To Next Level"] = "離升級所需經驗值"

return end
