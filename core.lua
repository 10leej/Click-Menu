local ClickMenu, namespace = ...
local L = namespace.L
local _, cfg = ... --export config

cfg = {
  MouseButton = 'RightButton', --LeftButton, RightButton, MiddleButton --Only affects minimap integration

  use_Minimap = true, --disabling this forces Click Menu to make a button
  button = {
    location = { "CENTER", UIParent, "CENTER", 0, 0 },
    blizzard_theme = false,
    color = {
      normal = { 0, 0, 0, 0.5 },
      hover = { 0.1, 0.1, 0.1, 0.5 },
      pushed = { 0, 0, 0, 1 },
    },
  },
}


local menuFrame = CreateFrame('Frame', 'ClickMenu', UIParent, 'UIDropDownMenuTemplate')
local menuList = {
  {
    text = L['Micro Menu'],
    isTitle = true,
    notCheckable = true,
  },
  {
    text = L['Character'],
    icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
    func = function()
      securecall(ToggleCharacter, 'PaperDollFrame')
    end,
    notCheckable = true,
  },
  {
    text = L['Spellbook'],
    icon = 'Interface\\MINIMAP\\TRACKING\\Class',
    func = function()
      securecall(ToggleSpellBook, BOOKTYPE_SPELL)
    end,
    notCheckable = true,
  },
  {
    text = L['Talents'],
    icon = 'Interface\\MINIMAP\\TRACKING\\Ammunition',
    func = function()
      if (not PlayerTalentFrame) then
        LoadAddOn('Blizzard_TalentUI')
      end

      if (not GlyphFrame) then
          LoadAddOn('Blizzard_GlyphUI')
      end

      securecall(ToggleTalentFrame)
    end,
    notCheckable = true,
  },
  {
    text = L['Inventory'],
    icon = 'Interface\\MINIMAP\\TRACKING\\Banker',
    func = function()
      securecall(ToggleAllBags)
    end,
    notCheckable = true,
  },
  {
    text = L['Achievements'],
    icon = 'Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Shield',
    func = function()
      securecall(ToggleAchievementFrame)
    end,
    notCheckable = true,
  },
  {
    text = L['Quest Log'],
    icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
    func = function()
      securecall(ToggleFrame, WorldMapFrame)
    end,
    tooltipTitle = securecall(MicroButtonTooltipText, QUESTLOG_BUTTON, 'TOGGLEQUESTLOG'),
    tooltipText = NEWBIE_TOOLTIP_QUESTLOG,
    notCheckable = true,
  },
  {
    text = L['Friends'],
    icon = 'Interface\\FriendsFrame\\PlusManz-BattleNet',
    func = function()
      securecall(ToggleFriendsFrame, 1)
    end,
    notCheckable = true,
  },
  {
    text = L['Guild'],
    icon = 'Interface\\GossipFrame\\TabardGossipIcon',
    arg1 = IsInGuild('player'),
    func = function()
      if (IsTrialAccount()) then
        UIErrorsFrame:AddMessage(ERR_RESTRICTED_ACCOUNT, 1, 0, 0)
      else
        securecall(ToggleGuildFrame)
      end
    end,
    notCheckable = true,
  },
  {
    text = L['Group Finder'],
    icon = 'Interface\\LFGFRAME\\BattleNetWorking0',
    func = function()
      securecall(PVEFrame_ToggleFrame, 'GroupFinderFrame', LFDParentFrame)
    end,
    notCheckable = true,
  },
  {
	text = L['Player vs. Player'], --broke
	icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
	func = function()
		securecall(PVEFrame_ToggleFrame, 'PVPUIFrame', HonorFrame)
	end,
	tooltipTitle = securecall(MicroButtonTooltipText, PLAYER_V_PLAYER, 'TOGGLECHARACTER4'),
	tooltipText = NEWBIE_TOOLTIP_PVP,
	notCheckable = true,
},
  {
    text = L['Dungeon Journal'],
    icon = 'Interface\\MINIMAP\\TRACKING\\Profession',
    func = function()
      securecall(ToggleEncounterJournal)
    end,
    notCheckable = true,
  },
  {
	text = L['Mounts'],--broke
	icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster',
	func = function()
		securecall(ToggleCollectionsJournal, 1)
	end,
	tooltipTitle = securecall(MicroButtonTooltipText, MOUNTS_AND_PETS, 'TOGGLEPETJOURNAL'),
	notCheckable = true,
  },
  {
	text = L['Pets'],--broke
	icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster',
	func = function()
		securecall(ToggleCollectionsJournal, 2)
	end,
	tooltipTitle = securecall(MicroButtonTooltipText, MOUNTS_AND_PETS, 'TOGGLEPETJOURNAL'),
	notCheckable = true,
  },
  {
	text = L['Toy Box'],--broke
	icon = 'Interface\\MINIMAP\\TRACKING\\Reagents',
	func = function()
		securecall(ToggleCollectionsJournal, 3)
	end,
	tooltipTitle = securecall(MicroButtonTooltipText, TOY_BOX, 'TOGGLETOYBOX'),
	notCheckable = true,
  },
  {
	text = L['Heirlooms'],--broke
	icon = 'Interface\\MINIMAP\\TRACKING\\Reagents',
	func = function()
		securecall(ToggleCollectionsJournal, 4)
	end,
	tooltipTitle = securecall(MicroButtonTooltipText, TOY_BOX, 'TOGGLETOYBOX'),
	notCheckable = true,
  },
  {
    text = L["Calender"],--broke
    icon = 'Interface\\Calendar\\UI-Calendar-Button',
    func = function()
      if (not StoreFrame) then
        LoadAddOn('Blizzard_Calendar')
      end
      securecall(Calendar_Toggle)
    end,
    notCheckable = true,
  },
  {
    text = L['Shop'],
    icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
    func = function()
      if (not StoreFrame) then
        LoadAddOn('Blizzard_StoreUI')
      end
      securecall(ToggleStoreUI)
    end,
    notCheckable = true,
  },
  {
    text = L['Support'],
    icon = 'Interface\\CHATFRAME\\UI-ChatIcon-Blizz',
    func = function()
      securecall(ToggleHelpFrame)
    end,
    notCheckable = true,
  },
  {
    text = L['Zone Map'],
    func = function()
      securecall(ToggleBattlefieldMinimap)
    end,
    notCheckable = true,
  },
  {
    text = L['Logout'],
    func = function()
      Logout()
    end,
    notCheckable = true,
  },
  {
    text = L['Quit'],
    func = function()
      ForceQuit()
    end,
    notCheckable = true,
  },
}
if IsAddOnLoaded("Carbonite") or IsAddOnLoaded("Sexymap") or IsAddOnLoaded("Chinchilla") then --check to see if a conflicting addon is loaded
  local button = CreateFrame("Button", nil, mainframe) --if one is we make a button
  button:SetPoint(unpack(cfg.button.location))
  button:SetWidth(50)
  button:SetHeight(25)

  button:SetText("Menu")
  button:SetNormalFontObject("GameFontNormal")

  local ntex = button:CreateTexture()
  if cfg.blizzard_theme then
    ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
  else
    ntex:SetTexture("Interface\\Buttons\\WHITE8x8")
    ntex:SetVertexColor(unpack(cfg.button.color.normal))
  end
  ntex:SetTexCoord(0, 0.625, 0, 0.6875)
  ntex:SetAllPoints()
  button:SetNormalTexture(ntex)

  local htex = button:CreateTexture()
  if blizzard_theme then
    htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
  else
    htex:SetTexture("Interface\\Buttons\\WHITE8x8")
    htex:SetVertexColor(unpack(cfg.button.color.hover))
  end
  htex:SetTexCoord(0, 0.625, 0, 0.6875)
  htex:SetAllPoints()
  button:SetHighlightTexture(htex)

  local ptex = button:CreateTexture()
  if blizzard_theme then
    ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
  else
    ptex:SetTexture("Interface\\Buttons\\WHITE8x8")
    ptex:SetVertexColor(unpack(cfg.button.color.pushed))
  end
  ptex:SetTexCoord(0, 0.625, 0, 0.6875)
  ptex:SetAllPoints()
  button:SetPushedTexture(ptex)

  button:SetScript('OnMouseUp', function(self, button)
    if button == "LeftButton" or button == "RightButton" or button == "MiddleButton" then
      securecall(EasyMenu, menuList, menuFrame, self, 27, 190, 'MENU', 8)
    end
  end)
else --if there's no addon enabled we load the config up top
  if cfg.use_Minimap then
    Minimap:SetScript('OnMouseUp', function(self, button)
      if button == cfg.MouseButton then
        securecall(EasyMenu, menuList, menuFrame, self, 27, 190, 'MENU', 8)	
      else
        Minimap_OnClick(self)
      end
    end)
  else --use a button
    local button = CreateFrame("Button", nil, mainframe)
    button:SetPoint(unpack(cfg.button.location))
    button:SetWidth(50)
    button:SetHeight(25)

    button:SetText("Menu")
    button:SetNormalFontObject("GameFontNormal")

    local ntex = button:CreateTexture()
    if cfg.blizzard_theme then
      ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
    else
      ntex:SetTexture("Interface\\Buttons\\WHITE8x8")
      ntex:SetVertexColor(unpack(cfg.button.color.normal))
    end
    ntex:SetTexCoord(0, 0.625, 0, 0.6875)
    ntex:SetAllPoints()
    button:SetNormalTexture(ntex)

    local htex = button:CreateTexture()
    if blizzard_theme then
      htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
    else
      htex:SetTexture("Interface\\Buttons\\WHITE8x8")
      htex:SetVertexColor(unpack(cfg.button.color.hover))
    end
    htex:SetTexCoord(0, 0.625, 0, 0.6875)
    htex:SetAllPoints()
    button:SetHighlightTexture(htex)

    local ptex = button:CreateTexture()
    if blizzard_theme then
      ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
    else
      ptex:SetTexture("Interface\\Buttons\\WHITE8x8")
      ptex:SetVertexColor(unpack(cfg.button.color.pushed))
    end
    ptex:SetTexCoord(0, 0.625, 0, 0.6875)
    ptex:SetAllPoints()
    button:SetPushedTexture(ptex)

    button:SetScript('OnMouseUp', function(self, button)
      if button == "LeftButton" or button == "RightButton" or button == "MiddleButton" then
        securecall(EasyMenu, menuList, menuFrame, self, 27, 190, 'MENU', 8)
      end
    end)
  end
end
