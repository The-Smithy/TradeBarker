-- TradeBarker: Macro Management
-- Creates and updates WoW macros for each saved preset

-- Namespace
TradeBarker = TradeBarker or {}
local TB = TradeBarker

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local MACRO_PREFIX = "TB: "
local MACRO_ICON = "INV_Inscription_Tradeskill01"

-------------------------------------------------------------------------------
-- Macro Helpers
-------------------------------------------------------------------------------

-- Generate a macro name from profession and preset name
-- WoW macro names can be up to ~16 chars, so we truncate
local function GetMacroName(profName, presetName)
    -- Format: "TB: PresetName" truncated to 16 chars
    local name = MACRO_PREFIX .. presetName
    if #name > 16 then
        name = name:sub(1, 16)
    end
    return name
end

-- Build the macro body that calls our send function
local function GetMacroBody(profName, presetName)
    -- Use /run to call our macro send function
    -- Escape quotes in preset name
    local safeName = presetName:gsub('"', '\\"')
    local safeProf = profName:gsub('"', '\\"')
    return '/run TradeBarker.MacroSend("' .. safeProf .. '","' .. safeName .. '")'
end

-------------------------------------------------------------------------------
-- Core Macro Functions
-------------------------------------------------------------------------------

-- Send a preset's message to trade chat (called by macros)
function TB.MacroSend(profName, presetName)
    if not profName or not presetName then return end

    TradeBarkerDB._presets = TradeBarkerDB._presets or {}
    local presets = TradeBarkerDB._presets[profName]
    if not presets then
        print("|cffff6600[TradeBarker]|r No presets found for " .. profName)
        return
    end

    -- Find preset by name
    local preset = nil
    for _, p in ipairs(presets) do
        if p.name == presetName then
            preset = p
            break
        end
    end

    if not preset then
        print("|cffff6600[TradeBarker]|r Preset '" .. presetName .. "' not found!")
        return
    end

    -- Save current state
    local origProfession = TB.selectedProfession
    local origSelections = TB.GetCurrentSelections()

    -- Temporarily switch to the preset's profession and selections
    TB.selectedProfession = profName

    -- Clear selections for this profession
    local data = TB.PROFESSION_DATA[profName]
    if data then
        for _, group in ipairs(data) do
            for _, item in ipairs(group.items) do
                local key = TB.GetItemKey(group.slot, item)
                TradeBarkerDB[key] = false
            end
        end
    end

    -- Load preset selections
    for key, value in pairs(preset.items) do
        TradeBarkerDB[key] = value
    end

    -- Send message
    TB.SendToTrade()

    -- Restore original profession and selections
    if data then
        for _, group in ipairs(data) do
            for _, item in ipairs(group.items) do
                local key = TB.GetItemKey(group.slot, item)
                TradeBarkerDB[key] = false
            end
        end
    end

    -- If we were on the same profession, restore those selections
    if origProfession then
        TB.selectedProfession = origProfession
        for key, value in pairs(origSelections) do
            TradeBarkerDB[key] = value
        end
    end

    -- Refresh UI if visible
    if TB.mainFrame and TB.mainFrame:IsShown() then
        for _, entry in ipairs(TB.checkboxes) do
            entry.cb:SetChecked(TradeBarkerDB[entry.key] or false)
        end
    end
end

-- Create or update a macro for a preset
function TB.UpdatePresetMacro(profName, presetName)
    if not profName or not presetName then return end

    local macroName = GetMacroName(profName, presetName)
    local macroBody = GetMacroBody(profName, presetName)

    -- Check if macro already exists
    local existingIndex = GetMacroIndexByName(macroName)

    if existingIndex and existingIndex > 0 then
        -- Update existing macro
        EditMacro(existingIndex, macroName, MACRO_ICON, macroBody)
    else
        -- Check macro limits before creating
        local numGlobal, numPerChar = GetNumMacros()
        if numPerChar < 18 then
            -- Create per-character macro
            CreateMacro(macroName, MACRO_ICON, macroBody, 1)
        elseif numGlobal < 36 then
            -- Fall back to global macro
            CreateMacro(macroName, MACRO_ICON, macroBody, nil)
        else
            print("|cffff6600[TradeBarker]|r Cannot create macro for '" .. presetName .. "' - macro slots full!")
            return
        end
    end
end

-- Delete a macro for a preset
function TB.DeletePresetMacro(profName, presetName)
    if not profName or not presetName then return end

    local macroName = GetMacroName(profName, presetName)
    local existingIndex = GetMacroIndexByName(macroName)

    if existingIndex and existingIndex > 0 then
        DeleteMacro(existingIndex)
    end
end

-- Sync all preset macros (creates/updates macros for all presets)
function TB.SyncAllMacros()
    TradeBarkerDB._presets = TradeBarkerDB._presets or {}

    for profName, presets in pairs(TradeBarkerDB._presets) do
        for _, preset in ipairs(presets) do
            TB.UpdatePresetMacro(profName, preset.name)
        end
    end
end
