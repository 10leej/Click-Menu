--The beginnings of a localization so even everyone can read our menu
local ClickMenu, namespace = ...

local L = setmetatable({
  ['Achievements'] = ACHIEVEMENTS,
  ['Calendar'] = 'Calendar', -- no Blizz global string for this
  ['Character'] = CHARACTER,
  ['Dungeon Journal'] = ENCOUNTER_JOURNAL,
  ['Friends'] = FRIENDS,
  ['Group Finder'] = GROUP_FINDER, -- actually 'Dungeon Finder' in English
  ['Guild'] = GUILD,
  ['Inventory'] = INVENTORY_TOOLTIP,
  ['Logout'] = LOGOUT,
  ['Micro Menu'] = 'Micro Menu', -- no Blizz global string for this
  ['Mounts'] = MOUNTS,
  ['Pets'] = PETS,
  ['Player vs. Player'] = PLAYER_V_PLAYER,
  ['Quest Log'] = QUESTLOG_BUTTON,
  ['Quit'] = QUIT,
  ['Shop'] = BLIZZARD_STORE, -- Blizz terminology uses 'Shop' instead of 'Store'
  ['Spellbook'] = SPELLBOOK,
  ['Support'] = GAMEMENU_HELP,
  ['Talents'] = TALENTS,
  ['Toy Box'] = TOY_BOX,
  ['Zone Map'] = BATTLEFIELD_MINIMAP,
}, { __index = function(t, k)
  local v = tostring(k)
  rawset(t, k, v)
  return v
end })

namespace.L = L

local GAME_LOCALE = GetLocale()
if GAME_LOCALE == 'deDE' then
  L['Micro Menu'] = 'Mikromenü'
  L['Calendar'] = 'Kalender'
elseif GAME_LOCALE == 'esES' or GAME_LOCALE == 'esMX' then
  L['Micro Menu'] = 'Micro menú'
  L['Calendar'] = 'Calendario'
elseif GAME_LOCALE == 'frFR' then
  L['Micro Menu'] = 'Micro menu'
  L['Calendar'] = 'Calendrier'
elseif GAME_LOCALE == 'itIT' then
  L['Micro Menu'] = 'Micro menu'
  L['Calendar'] = 'Calendario'
elseif GAME_LOCALE == 'ptBR' then
  L['Micro Menu'] = 'Mini Menu'
  L['Calendar'] = 'Calendário'
elseif GAME_LOCALE == 'ruRU' then
  L['Micro Menu'] = 'Микроменю'
  L['Calendar'] = 'Календарь'
elseif GAME_LOCALE == 'koKR' then
  L['Micro Menu'] = '게임 메뉴'
  L['Calendar'] = '달력'
elseif GAME_LOCALE == 'zhCN' then
  L['Micro Menu'] = '微型主菜单'
  L['Calendar'] = '日历'
elseif GAME_LOCALE == 'zhTW' then
  L['Micro Menu'] = '微型選單'
  L['Calendar'] = '曆'
end