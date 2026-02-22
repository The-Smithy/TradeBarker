-- TradeBarker: Main Entry Point
-- Handles initialization, events, and slash commands
-- Version: 1.1.0

-- Initialize saved variables
TradeBarkerDB = TradeBarkerDB or {}

-- Namespace
TradeBarker = TradeBarker or {}
local TB = TradeBarker

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("SKILL_LINES_CHANGED")
eventFrame:RegisterEvent("PLAYER_LOGIN")

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "TradeBarker" then
        TradeBarkerDB = TradeBarkerDB or {}
        TB.selectedProfession = TradeBarkerDB._profession or nil
        TB.mainFrame = TB.CreateMainFrame()
        TB.mainFrame:Hide()
        -- Attempt initial detection (skills may not be ready yet)
        TB.RebuildTabs()
        print("|cff00ccff[TradeBarker]|r Loaded! Type /tb to open.")
        self:UnregisterEvent("ADDON_LOADED")
    elseif event == "PLAYER_LOGIN" then
        -- Sync all preset macros (macro API available after login)
        TB.SyncAllMacros()
        self:UnregisterEvent("PLAYER_LOGIN")
    elseif event == "SKILL_LINES_CHANGED" then
        if TB.mainFrame then
            TB.RebuildTabs()
        end
    end
end)

-------------------------------------------------------------------------------
-- Slash Commands
-------------------------------------------------------------------------------
SLASH_TRADEBARKER1 = "/tb"
SLASH_TRADEBARKER2 = "/tradebarker"

SlashCmdList["TRADEBARKER"] = function(msg)
    local cmd = msg and msg:match("^%s*(%S*)") or ""
    cmd = cmd:lower()

    if cmd == "debug" then
        TB.SetDebugMode(not TB.debugMode)
        print("|cff00ccff[TradeBarker]|r Debug mode " .. (TB.debugMode and "|cff00ff00ON|r (Lua errors will print to chat)" or "|cffff4444OFF|r"))

    elseif cmd == "info" then
        print("|cff00ccff[TradeBarker]|r === Debug Info ===")
        print("  Profession : " .. tostring(TB.selectedProfession))
        print("  Template   : " .. tostring(TB.GetTemplate()))
        print("  SpellLinks : " .. tostring(TB.UseSpellLinks()))
        local msg2 = TB.BuildMessage()
        print("  Message    : " .. tostring(msg2))
        print("  Msg length : " .. tostring(msg2 and #msg2 or 0))
        local numGlobal, numPerChar = GetNumMacros()
        print("  Macros     : " .. numPerChar .. "/18 char, " .. numGlobal .. "/36 global")
        local profs = TB.detectedProfessions or {}
        print("  Detected   : " .. (#profs > 0 and table.concat(profs, ", ") or "none"))

    elseif cmd == "help" then
        print("|cff00ccff[TradeBarker]|r Commands:")
        print("  /tb          - Toggle addon window")
        print("  /tb debug    - Toggle debug logging")
        print("  /tb info     - Print current addon state")
        print("  /tb help     - Show this help")

    else
        if TB.mainFrame then
            if TB.mainFrame:IsShown() then
                TB.mainFrame:Hide()
            else
                TB.mainFrame:Show()
            end
        end
    end
end
