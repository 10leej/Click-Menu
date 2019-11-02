-- Right click menu
local menuFrame = CreateFrame("Frame", "BobMinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {
        text = "MicroMenu",
        isTitle = true,
        notCheckable = true,
    },
    {
        text = "Character",
        icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
        func = function()
            securecall(ToggleCharacter, 'PaperDollFrame')
        end,
        notCheckable = true,
    },
    {
        text = "Spellbook",
        icon = 'Interface\\MINIMAP\\TRACKING\\Class',
        func = function()
            securecall(ToggleSpellBook, BOOKTYPE_SPELL)
        end,
        tooltipTitle = securecall(MicroButtonTooltipText, SPELLBOOK_ABILITIES_BUTTON, 'TOGGLESPELLBOOK'),
        tooltipText = NEWBIE_TOOLTIP_SPELLBOOK,
        notCheckable = true,
    },
    {
        text = "Talents",
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
        tooltipTitle = securecall(MicroButtonTooltipText, TALENTS_BUTTON, 'TOGGLETALENTS'),
        tooltipText = NEWBIE_TOOLTIP_TALENTS,
        notCheckable = true,
    },
    {
        text = "Quest Log",
        icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
        func = function()
            securecall(ToggleFrame, QuestLogFrame)
        end,
        tooltipTitle = securecall(MicroButtonTooltipText, QUESTLOG_BUTTON, 'TOGGLEQUESTLOG'),
        tooltipText = NEWBIE_TOOLTIP_QUESTLOG,
        notCheckable = true,
    },
    {
        text = "Friends",
        icon = 'Interface\\FriendsFrame\\PlusManz-BattleNet',
        func = function()
            securecall(ToggleFriendsFrame, 1)
        end,
        notCheckable = true,
    },
    {
        text = "Guild",
        icon = 'Interface\\GossipFrame\\TabardGossipIcon',
        arg1 = IsInGuild('player'),
        func = function()
            if (IsTrialAccount()) then
                UIErrorsFrame:AddMessage(ERR_RESTRICTED_ACCOUNT, 1, 0, 0)
            else
                securecall(ToggleFriendsFrame, 3)
            end
        end,
        notCheckable = true,
    },
    {
        text = "Support",
        icon = 'Interface\\CHATFRAME\\UI-ChatIcon-Blizz',
        func = function()
            securecall(ToggleHelpFrame)
        end,
        tooltipTitle = HELP_BUTTON,
        tooltipText = NEWBIE_TOOLTIP_HELP,
        notCheckable = true,
    },
	   {
        text = "Game Menu",
        isTitle = true,
        notCheckable = true,
    },
    {
        text = "System",
        func = function()
            VideoOptionsFrame:Show()
        end,
        notCheckable = true,
    },
    {
        text = "Interface",
        func = function()
            InterfaceOptionsFrame:Show()
        end,
        notCheckable = true,
    },
    {
        text = "Macro",
        func = function()
            ShowMacroFrame()
        end,
        notCheckable = true,
    },
    {
        text = "Key Bindings",
        func = function()
			if (not KeyBindingFrame) then
				KeyBindingFrame_LoadUI()
			end
            KeyBindingFrame:Show()
        end,
        notCheckable = true,
    },
}

--Make it work
Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == "RightButton" then
		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)	
	else
		Minimap_OnClick(self)
	end
end)