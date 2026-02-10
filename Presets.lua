-- TradeBarker: Preset Management
-- Handles saving, loading, and managing item selection presets

-- Namespace
TradeBarker = TradeBarker or {}
local TB = TradeBarker

-------------------------------------------------------------------------------
-- Preset Functions
-------------------------------------------------------------------------------
function TB.GetPresets()
    if not TB.selectedProfession then return {} end
    TradeBarkerDB._presets = TradeBarkerDB._presets or {}
    TradeBarkerDB._presets[TB.selectedProfession] = TradeBarkerDB._presets[TB.selectedProfession] or {}
    return TradeBarkerDB._presets[TB.selectedProfession]
end

function TB.GetCurrentSelections()
    local selections = {}
    local data = TB.GetProfessionData()
    if not data then return selections end

    for _, group in ipairs(data) do
        for _, item in ipairs(group.items) do
            local key = TB.GetItemKey(group.slot, item)
            if TradeBarkerDB[key] then
                selections[key] = true
            end
        end
    end
    return selections
end

function TB.SavePreset(name)
    if not TB.selectedProfession then return end
    if not name or name == "" then
        print("|cffff6600[TradeBarker]|r Preset name cannot be empty!")
        return
    end

    local selections = TB.GetCurrentSelections()
    if not next(selections) then
        print("|cffff6600[TradeBarker]|r No items selected to save!")
        return
    end

    local presets = TB.GetPresets()
    table.insert(presets, {
        name = name,
        items = selections
    })

    print("|cff00ff00[TradeBarker]|r Preset '" .. name .. "' saved!")
    return true
end

function TB.LoadPreset(presetIndex)
    local presets = TB.GetPresets()
    local preset = presets[presetIndex]
    if not preset then return end

    -- Clear all current selections
    local data = TB.GetProfessionData()
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

    -- Update UI
    for _, entry in ipairs(TB.checkboxes) do
        entry.cb:SetChecked(TradeBarkerDB[entry.key] or false)
    end

    if TB.previewBox then
        TB.previewBox:SetText("")
    end
    TB.UpdateCharCount()

    print("|cff00ff00[TradeBarker]|r Loaded preset: " .. preset.name)
end

function TB.QuickSendPreset(presetIndex)
    local presets = TB.GetPresets()
    local preset = presets[presetIndex]
    if not preset then return end

    -- Temporarily load preset
    local originalSelections = TB.GetCurrentSelections()

    -- Clear and load preset
    local data = TB.GetProfessionData()
    if data then
        for _, group in ipairs(data) do
            for _, item in ipairs(group.items) do
                local key = TB.GetItemKey(group.slot, item)
                TradeBarkerDB[key] = false
            end
        end
    end

    for key, value in pairs(preset.items) do
        TradeBarkerDB[key] = value
    end

    -- Send message
    TB.SendToTrade()

    -- Restore original selections
    for _, group in ipairs(data) do
        for _, item in ipairs(group.items) do
            local key = TB.GetItemKey(group.slot, item)
            TradeBarkerDB[key] = false
        end
    end

    for key, value in pairs(originalSelections) do
        TradeBarkerDB[key] = value
    end

    -- Update UI
    for _, entry in ipairs(TB.checkboxes) do
        entry.cb:SetChecked(TradeBarkerDB[entry.key] or false)
    end
end

function TB.DeletePreset(presetIndex)
    local presets = TB.GetPresets()
    local preset = presets[presetIndex]
    if not preset then return end

    print("|cffff6600[TradeBarker]|r Deleted preset: " .. preset.name)
    table.remove(presets, presetIndex)
end

function TB.RenamePreset(presetIndex, newName)
    if not newName or newName == "" then return end
    local presets = TB.GetPresets()
    local preset = presets[presetIndex]
    if not preset then return end

    preset.name = newName
    print("|cff00ff00[TradeBarker]|r Preset renamed to: " .. newName)
end

function TB.MovePreset(presetIndex, direction)
    local presets = TB.GetPresets()
    if direction == "up" and presetIndex > 1 then
        presets[presetIndex], presets[presetIndex - 1] = presets[presetIndex - 1], presets[presetIndex]
    elseif direction == "down" and presetIndex < #presets then
        presets[presetIndex], presets[presetIndex + 1] = presets[presetIndex + 1], presets[presetIndex]
    end
end
