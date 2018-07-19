local ClickMenu, namespace = ...
local L = namespace.L

--Our one and only config option, should probably add this in game
local MouseButton = 'RightButton' --LeftButton, RightButton, MiddleButton

--End config
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
        text = L['Specialization'],
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
		text = L['Map & Quest Log'],
		icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
		func = function()
			securecall(ToggleFrame, WorldMapFrame)
		end,
			tooltipTitle = securecall(MicroButtonTooltipText, QUESTLOG_BUTTON, 'TOGGLEQUESTLOG'),
			tooltipText = NEWBIE_TOOLTIP_QUESTLOG,
			notCheckable = true,
	},
    {
        text = L['Social'],
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
        text = L['Collections'],
        icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster',
        func = function()
            securecall(TogglePetJournal, 1)
        end,
        notCheckable = true,
    },
	{
		text = L["Calender"],--broke
		icon = 'Interface\\Calendar\\UI-Calendar-Button',
		func = function()
			LoadAddOn('Blizzard_Calendar')
			Calendar_Toggle()
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
--[[ Need to fix, was broke in 8.0
    {
        text = L['Battlefield Map'],
        func = function()
            securecall(ToggleBattlefieldMinimap)
        end,
        notCheckable = true,
    },
]]

}
Minimap:SetScript('OnMouseUp', function(self, button)
	if button == MouseButton then
		securecall(EasyMenu, menuList, menuFrame, self, 27, 190, 'MENU', 8)	
	else
		Minimap_OnClick(self)
	end
end)
