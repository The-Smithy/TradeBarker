-- TradeBarker: UI Management
-- Handles all UI creation, updates, and interactions

-- Namespace
TradeBarker = TradeBarker or {}
local TB = TradeBarker

-------------------------------------------------------------------------------
-- UI: Rebuild Checkboxes
-------------------------------------------------------------------------------
function TB.RebuildCheckboxes()
    for _, entry in ipairs(TB.checkboxes) do
        entry.cb:Hide()
        entry.cb:SetParent(nil)
        entry.label:Hide()
        entry.label:SetParent(nil)
    end
    wipe(TB.checkboxes)

    if TB.scrollChild._headers then
        for _, h in ipairs(TB.scrollChild._headers) do
            h:Hide()
            h:SetParent(nil)
        end
    end
    TB.scrollChild._headers = {}

    local data = TB.GetProfessionData()
    if not data then return end

    local yOffset = 4
    for _, group in ipairs(data) do
        local header = TB.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        header:SetPoint("TOPLEFT", 6, -yOffset)
        header:SetText("|cff8899aa" .. group.slot:upper() .. "|r")
        table.insert(TB.scrollChild._headers, header)
        yOffset = yOffset + 16

        for _, item in ipairs(group.items) do
            local key = TB.GetItemKey(group.slot, item)
            local itemName = TB.GetItemName(item)

            local cb = CreateFrame("CheckButton", nil, TB.scrollChild, "UICheckButtonTemplate")
            cb:SetPoint("TOPLEFT", 6, -yOffset)
            cb:SetSize(22, 22)
            cb:SetChecked(TradeBarkerDB[key] or false)
            cb:SetScript("OnClick", function(self)
                TradeBarkerDB[key] = self:GetChecked() and true or false
            end)

            local label = cb:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            label:SetPoint("LEFT", cb, "RIGHT", 4, 0)
            label:SetText(itemName)

            table.insert(TB.checkboxes, { cb = cb, key = key, label = label })
            yOffset = yOffset + 20
        end

        yOffset = yOffset + 8
    end

    TB.scrollChild:SetHeight(yOffset)
end

-------------------------------------------------------------------------------
-- UI: Rebuild Preset List
-------------------------------------------------------------------------------
function TB.RebuildPresetList()
    if not TB.presetListFrame then return end

    -- Clear existing preset rows
    if TB.presetListFrame._rows then
        for _, row in ipairs(TB.presetListFrame._rows) do
            row:Hide()
            row:SetParent(nil)
        end
    end
    TB.presetListFrame._rows = {}

    local presets = TB.GetPresets()
    local yOffset = 4

    for i, preset in ipairs(presets) do
        local row = CreateFrame("Frame", nil, TB.presetListFrame, "BackdropTemplate")
        row:SetPoint("TOPLEFT", 4, -yOffset)
        row:SetPoint("RIGHT", -4, 0)
        row:SetHeight(24)
        row:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = 1,
            insets = { left = 1, right = 1, top = 1, bottom = 1 },
        })
        row:SetBackdropColor(0.1, 0.1, 0.12, 0.7)
        row:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.5)

        -- Preset name (editable)
        local nameBox = CreateFrame("EditBox", nil, row)
        nameBox:SetPoint("LEFT", 4, 0)
        nameBox:SetWidth(120)
        nameBox:SetHeight(20)
        nameBox:SetFontObject(GameFontHighlightSmall)
        nameBox:SetAutoFocus(false)
        nameBox:SetText(preset.name)
        nameBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
        nameBox:SetScript("OnEnterPressed", function(self)
            TB.RenamePreset(i, self:GetText())
            self:ClearFocus()
            TB.RebuildPresetList()
        end)

        -- Load button
        local loadBtn = TB.CreateFlatButton(row, "Load", 45)
        loadBtn:SetHeight(20)
        loadBtn:SetPoint("LEFT", nameBox, "RIGHT", 2, 0)
        loadBtn:SetScript("OnClick", function()
            TB.LoadPreset(i)
        end)

        -- Send button (quick send)
        local sendBtn = TB.CreateFlatButton(row, "Send", 45)
        sendBtn:SetHeight(20)
        sendBtn:SetPoint("LEFT", loadBtn, "RIGHT", 2, 0)
        sendBtn:SetBackdropColor(0.1, 0.18, 0.1, 0.9)
        sendBtn:SetBackdropBorderColor(0.3, 0.6, 0.3, 0.8)
        sendBtn:GetFontString():SetTextColor(0.5, 1, 0.5)
        sendBtn:SetScript("OnEnter", function(self)
            self:SetBackdropColor(0.15, 0.28, 0.15, 0.9)
            self:SetBackdropBorderColor(0.4, 0.8, 0.4, 0.8)
            self:GetFontString():SetTextColor(0.7, 1, 0.7)
        end)
        sendBtn:SetScript("OnLeave", function(self)
            self:SetBackdropColor(0.1, 0.18, 0.1, 0.9)
            self:SetBackdropBorderColor(0.3, 0.6, 0.3, 0.8)
            self:GetFontString():SetTextColor(0.5, 1, 0.5)
        end)
        sendBtn:SetScript("OnClick", function()
            TB.QuickSendPreset(i)
        end)

        -- Delete button
        local delBtn = TB.CreateFlatButton(row, "Del", 30)
        delBtn:SetHeight(20)
        delBtn:SetPoint("LEFT", sendBtn, "RIGHT", 2, 0)
        delBtn:SetBackdropColor(0.18, 0.1, 0.1, 0.9)
        delBtn:SetBackdropBorderColor(0.6, 0.3, 0.3, 0.8)
        delBtn:GetFontString():SetTextColor(1, 0.5, 0.5)
        delBtn:SetScript("OnEnter", function(self)
            self:SetBackdropColor(0.28, 0.15, 0.15, 0.9)
            self:SetBackdropBorderColor(0.8, 0.4, 0.4, 0.8)
            self:GetFontString():SetTextColor(1, 0.7, 0.7)
        end)
        delBtn:SetScript("OnLeave", function(self)
            self:SetBackdropColor(0.18, 0.1, 0.1, 0.9)
            self:SetBackdropBorderColor(0.6, 0.3, 0.3, 0.8)
            self:GetFontString():SetTextColor(1, 0.5, 0.5)
        end)
        delBtn:SetScript("OnClick", function()
            TB.DeletePreset(i)
            TB.RebuildPresetList()
        end)

        -- Up button
        local upBtn = TB.CreateFlatButton(row, "^", 20)
        upBtn:SetHeight(20)
        upBtn:SetPoint("LEFT", delBtn, "RIGHT", 2, 0)
        if i == 1 then
            upBtn:SetAlpha(0.3)
            upBtn:Disable()
        end
        upBtn:SetScript("OnClick", function()
            TB.MovePreset(i, "up")
            TB.RebuildPresetList()
        end)

        -- Down button
        local downBtn = TB.CreateFlatButton(row, "v", 20)
        downBtn:SetHeight(20)
        downBtn:SetPoint("LEFT", upBtn, "RIGHT", 2, 0)
        if i == #presets then
            downBtn:SetAlpha(0.3)
            downBtn:Disable()
        end
        downBtn:SetScript("OnClick", function()
            TB.MovePreset(i, "down")
            TB.RebuildPresetList()
        end)

        table.insert(TB.presetListFrame._rows, row)
        yOffset = yOffset + 26
    end

    TB.presetListFrame:SetHeight(math.max(60, yOffset))
end

-------------------------------------------------------------------------------
-- UI: Update Tab Highlights
-------------------------------------------------------------------------------
function TB.UpdateTabHighlights()
    for prof, tab in pairs(TB.professionTabs) do
        if prof == TB.selectedProfession then
            tab:SetBackdropColor(0.2, 0.2, 0.2, 0.9)
            tab:SetBackdropBorderColor(0.8, 0.7, 0.2, 0.9)
            tab:GetFontString():SetTextColor(1, 0.85, 0.1)
        else
            tab:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
            tab:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
            tab:GetFontString():SetTextColor(0.5, 0.5, 0.5)
        end
    end
end

-------------------------------------------------------------------------------
-- UI: Rebuild Tabs Based on Detected Professions
-------------------------------------------------------------------------------
function TB.RebuildTabs()
    for _, tab in pairs(TB.professionTabs) do
        tab:Hide()
        tab:SetParent(nil)
    end
    wipe(TB.professionTabs)

    TB.detectedProfessions = TB.DetectProfessions()

    if #TB.detectedProfessions == 0 then
        TB.selectedProfession = nil
        if TB.noProfsText then
            TB.noProfsText:Show()
        end
        if TB.scrollFrame then
            TB.scrollFrame:Hide()
        end
        TB.RebuildCheckboxes()
        TB.RebuildPresetList()
        return
    end

    if TB.noProfsText then
        TB.noProfsText:Hide()
    end
    if TB.scrollFrame then
        TB.scrollFrame:Show()
    end

    local found = false
    for _, prof in ipairs(TB.detectedProfessions) do
        if prof == TB.selectedProfession then
            found = true
            break
        end
    end
    if not found then
        TB.selectedProfession = TB.detectedProfessions[1]
        TradeBarkerDB._profession = TB.selectedProfession
    end

    -- Create tabs with even spacing
    local padding = 8
    local gap = 4
    local totalGaps = (#TB.detectedProfessions - 1) * gap
    local availableWidth = TB.mainFrame:GetWidth() - padding * 2
    local tabWidth = (availableWidth - totalGaps) / #TB.detectedProfessions

    for i, profName in ipairs(TB.detectedProfessions) do
        local tab = CreateFrame("Button", nil, TB.mainFrame, "BackdropTemplate")
        tab:SetSize(tabWidth, 22)
        tab:SetPoint("TOPLEFT", padding + (i - 1) * (tabWidth + gap), -36)
        tab:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = 1,
            insets = { left = 1, right = 1, top = 1, bottom = 1 },
        })

        local tabText = tab:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        tabText:SetPoint("CENTER")
        tabText:SetText(profName)
        tab:SetFontString(tabText)

        tab:SetScript("OnClick", function()
            TB.selectedProfession = profName
            TradeBarkerDB._profession = profName
            TB.UpdateTabHighlights()
            TB.RebuildCheckboxes()
            TB.RebuildPresetList()
            if TB.templateBox then
                TB.templateBox:SetText(TB.GetTemplate())
            end
            if TB.previewBox then
                TB.previewBox:SetText("")
            end
        end)

        tab:SetScript("OnEnter", function(self)
            if profName ~= TB.selectedProfession then
                self:SetBackdropColor(0.18, 0.18, 0.18, 0.9)
                self:GetFontString():SetTextColor(0.8, 0.8, 0.8)
            end
        end)
        tab:SetScript("OnLeave", function(self)
            if profName ~= TB.selectedProfession then
                self:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
                self:GetFontString():SetTextColor(0.5, 0.5, 0.5)
            end
        end)

        TB.professionTabs[profName] = tab
    end

    TB.UpdateTabHighlights()
    TB.RebuildCheckboxes()
    TB.RebuildPresetList()
    if TB.templateBox then
        TB.templateBox:SetText(TB.GetTemplate())
    end
end

-------------------------------------------------------------------------------
-- UI Creation: Main Frame
-------------------------------------------------------------------------------
function TB.CreateMainFrame()
    local f = CreateFrame("Frame", "TradeBarkerFrame", UIParent, "BackdropTemplate")
    f:SetSize(360, 740)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)
    f:SetFrameStrata("DIALOG")

    -- Dark flat backdrop
    f:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    f:SetBackdropColor(0.06, 0.06, 0.08, 0.95)
    f:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)

    -- Title bar area
    local titleBar = CreateFrame("Frame", nil, f, "BackdropTemplate")
    titleBar:SetPoint("TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", -1, -1)
    titleBar:SetHeight(30)
    titleBar:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
    })
    titleBar:SetBackdropColor(0.1, 0.1, 0.12, 0.9)

    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("LEFT", 10, 0)
    title:SetText("|cffe0e0e0TradeBarker|r")

    -- Close button (minimal X)
    local closeBtn = CreateFrame("Button", nil, titleBar)
    closeBtn:SetSize(28, 28)
    closeBtn:SetPoint("RIGHT", -2, 0)
    local closeTxt = closeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    closeTxt:SetPoint("CENTER")
    closeTxt:SetText("|cff888888x|r")
    closeBtn:SetScript("OnEnter", function() closeTxt:SetText("|cffff4444x|r") end)
    closeBtn:SetScript("OnLeave", function() closeTxt:SetText("|cff888888x|r") end)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- "No professions" message
    TB.noProfsText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    TB.noProfsText:SetPoint("CENTER", 0, 20)
    TB.noProfsText:SetText("|cff666666No supported professions detected.|r\n|cff444444Enchanting, Alchemy, Jewelcrafting, Blacksmithing, Leatherworking|r")
    TB.noProfsText:Hide()

    TB.CreateTemplateSection(f)
    TB.CreatePreviewSection(f)
    TB.CreatePresetsSection(f)
    TB.CreateChecklistSection(f)
    TB.CreateActionButtons(f)

    return f
end

-------------------------------------------------------------------------------
-- UI Creation: Template Section
-------------------------------------------------------------------------------
function TB.CreateTemplateSection(f)
    -- Template section
    local templateHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    templateHeader:SetPoint("TOPLEFT", 10, -62)
    templateHeader:SetText("|cff8899aaTemplate|r")

    -- Spell Links checkbox
    local spellLinksCB = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
    spellLinksCB:SetPoint("TOPLEFT", 80, -60)
    spellLinksCB:SetSize(20, 20)
    spellLinksCB:SetChecked(TB.UseSpellLinks())
    spellLinksCB:SetScript("OnClick", function(self)
        TB.SetUseSpellLinks(self:GetChecked())
        if TB.previewBox then
            TB.previewBox:SetText("")
        end
        TB.UpdateCharCount()
    end)

    local spellLinksLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    spellLinksLabel:SetPoint("LEFT", spellLinksCB, "RIGHT", 2, 0)
    spellLinksLabel:SetText("|cff8899aaUse Spell Links|r")
    spellLinksLabel:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Use Spell Links", 1, 1, 1)
        GameTooltip:AddLine("When enabled, items will be linked as clickable spells in trade chat (requires spell IDs to be configured).", nil, nil, nil, true)
        GameTooltip:Show()
    end)
    spellLinksLabel:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    TB.charCountText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    TB.charCountText:SetPoint("TOPRIGHT", -10, -62)
    TB.charCountText:SetText("|cff5555550 / " .. TB.MAX_CHAT_LENGTH .. "|r")

    local templatePanel = TB.CreatePanel(f, nil)
    templatePanel:SetPoint("TOPLEFT", 8, -76)
    templatePanel:SetPoint("RIGHT", -48, 0)
    templatePanel:SetHeight(50)

    TB.templateBox = CreateFrame("EditBox", nil, templatePanel)
    TB.templateBox:SetPoint("TOPLEFT", 6, -6)
    TB.templateBox:SetPoint("BOTTOMRIGHT", -6, 6)
    TB.templateBox:SetAutoFocus(false)
    TB.templateBox:SetFontObject(GameFontHighlightSmall)
    TB.templateBox:SetMultiLine(true)
    TB.templateBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    TB.templateBox:SetScript("OnEditFocusLost", function(self)
        local text = self:GetText():gsub("\n", " ")
        self:SetText(text)
        if not text:find("{items}") then
            print("|cffff6600[TradeBarker]|r Template must contain {items} placeholder! Resetting.")
            self:SetText(TB.GetTemplate())
            return
        end
        TB.SetTemplate(text)
        TB.UpdateCharCount()
    end)

    local resetBtn = TB.CreateFlatButton(f, "Reset", 36)
    resetBtn:SetHeight(50)
    resetBtn:SetPoint("LEFT", templatePanel, "RIGHT", 4, 0)
    resetBtn:SetScript("OnClick", function()
        TB.SetTemplate(TB.DEFAULT_TEMPLATE)
        TB.templateBox:SetText(TB.DEFAULT_TEMPLATE)
        TB.UpdateCharCount()
    end)
end

-------------------------------------------------------------------------------
-- UI Creation: Preview Section
-------------------------------------------------------------------------------
function TB.CreatePreviewSection(f)
    local previewLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    previewLabel:SetPoint("TOPLEFT", 10, -130)
    previewLabel:SetText("|cff8899aaPreview|r")

    local previewBtn = TB.CreateFlatButton(f, "Preview", 72)
    previewBtn:SetHeight(18)
    previewBtn:SetPoint("LEFT", previewLabel, "RIGHT", 8, 0)
    previewBtn:SetScript("OnClick", function()
        local msg = TB.BuildMessage()
        if msg then
            TB.previewBox:SetText(msg)
            TB.UpdateCharCount()
            local msgs = TB.SplitMessage(msg, TB.MAX_CHAT_LENGTH)
            if #msgs > 1 then
                print("|cffffd200[TradeBarker]|r Message will be split into " .. #msgs .. " parts.")
            end
        else
            TB.previewBox:SetText("(no items selected)")
            TB.UpdateCharCount()
        end
    end)

    local sendBtn = TB.CreateFlatButton(f, "Send to Trade", 90)
    sendBtn:SetHeight(18)
    sendBtn:SetPoint("LEFT", previewBtn, "RIGHT", 4, 0)
    sendBtn:SetBackdropColor(0.1, 0.18, 0.1, 0.9)
    sendBtn:SetBackdropBorderColor(0.3, 0.6, 0.3, 0.8)
    sendBtn:GetFontString():SetTextColor(0.5, 1, 0.5)
    sendBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.15, 0.28, 0.15, 0.9)
        self:SetBackdropBorderColor(0.4, 0.8, 0.4, 0.8)
        self:GetFontString():SetTextColor(0.7, 1, 0.7)
    end)
    sendBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.1, 0.18, 0.1, 0.9)
        self:SetBackdropBorderColor(0.3, 0.6, 0.3, 0.8)
        self:GetFontString():SetTextColor(0.5, 1, 0.5)
    end)
    sendBtn:SetScript("OnClick", function()
        TB.SendToTrade()
    end)

    local previewPanel = TB.CreatePanel(f, nil)
    previewPanel:SetPoint("TOPLEFT", 8, -144)
    previewPanel:SetPoint("RIGHT", -8, 0)
    previewPanel:SetHeight(50)

    TB.previewBox = CreateFrame("EditBox", nil, previewPanel)
    TB.previewBox:SetPoint("TOPLEFT", 6, -6)
    TB.previewBox:SetPoint("BOTTOMRIGHT", -6, 6)
    TB.previewBox:SetAutoFocus(false)
    TB.previewBox:SetFontObject(GameFontHighlightSmall)
    TB.previewBox:SetMultiLine(true)
    TB.previewBox:EnableMouse(true)
    TB.previewBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
end

-------------------------------------------------------------------------------
-- UI Creation: Presets Section
-------------------------------------------------------------------------------
function TB.CreatePresetsSection(f)
    local presetsHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    presetsHeader:SetPoint("TOPLEFT", 10, -198)
    presetsHeader:SetText("|cff8899aaPresets|r")

    local savePresetBtn = TB.CreateFlatButton(f, "Save Current", 80)
    savePresetBtn:SetHeight(18)
    savePresetBtn:SetPoint("LEFT", presetsHeader, "RIGHT", 8, 0)
    savePresetBtn:SetScript("OnClick", function()
        TB.ShowSavePresetDialog()
    end)

    local presetsPanel = TB.CreatePanel(f, nil)
    presetsPanel:SetPoint("TOPLEFT", 8, -214)
    presetsPanel:SetPoint("RIGHT", -8, 0)
    presetsPanel:SetHeight(120)

    TB.presetListFrame = CreateFrame("Frame", nil, presetsPanel)
    TB.presetListFrame:SetPoint("TOPLEFT", 4, -4)
    TB.presetListFrame:SetPoint("BOTTOMRIGHT", -4, 4)
    TB.presetListFrame._rows = {}
end

-------------------------------------------------------------------------------
-- UI Creation: Checklist Section
-------------------------------------------------------------------------------
function TB.CreateChecklistSection(f)
    local listPanel = TB.CreatePanel(f, nil)
    listPanel:SetPoint("TOPLEFT", 8, -340)
    listPanel:SetPoint("BOTTOMRIGHT", -8, 38)

    TB.scrollFrame = CreateFrame("ScrollFrame", "TradeBarkerScrollFrame", listPanel, "UIPanelScrollFrameTemplate")
    TB.scrollFrame:SetPoint("TOPLEFT", 2, -2)
    TB.scrollFrame:SetPoint("BOTTOMRIGHT", -22, 2)

    TB.scrollChild = CreateFrame("Frame", nil, TB.scrollFrame)
    TB.scrollChild:SetSize(TB.scrollFrame:GetWidth() or 280, 1)
    TB.scrollFrame:SetScrollChild(TB.scrollChild)
end

-------------------------------------------------------------------------------
-- UI Creation: Action Buttons
-------------------------------------------------------------------------------
function TB.CreateActionButtons(f)
    local selectAllBtn = TB.CreateFlatButton(f, "Select All", 72)
    selectAllBtn:SetPoint("BOTTOMLEFT", 8, 8)
    selectAllBtn:SetScript("OnClick", function()
        for _, entry in ipairs(TB.checkboxes) do
            entry.cb:SetChecked(true)
            TradeBarkerDB[entry.key] = true
        end
    end)

    local deselectAllBtn = TB.CreateFlatButton(f, "Deselect All", 72)
    deselectAllBtn:SetPoint("LEFT", selectAllBtn, "RIGHT", 4, 0)
    deselectAllBtn:SetScript("OnClick", function()
        for _, entry in ipairs(TB.checkboxes) do
            entry.cb:SetChecked(false)
            TradeBarkerDB[entry.key] = false
        end
    end)
end

-------------------------------------------------------------------------------
-- Dialog: Save Preset
-------------------------------------------------------------------------------
function TB.ShowSavePresetDialog()
    local dialog = CreateFrame("Frame", "TradeBarkerSavePresetDialog", UIParent, "BackdropTemplate")
    dialog:SetSize(300, 120)
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
    dialog:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 2,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    dialog:SetBackdropColor(0.06, 0.06, 0.08, 0.95)
    dialog:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.9)

    local title = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", 0, -10)
    title:SetText("Save Preset")

    local label = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("TOPLEFT", 10, -35)
    label:SetText("Preset name:")

    local inputPanel = TB.CreatePanel(dialog, nil)
    inputPanel:SetPoint("TOPLEFT", 10, -50)
    inputPanel:SetPoint("RIGHT", -10, 0)
    inputPanel:SetHeight(25)

    local input = CreateFrame("EditBox", nil, inputPanel)
    input:SetPoint("TOPLEFT", 4, -4)
    input:SetPoint("BOTTOMRIGHT", -4, 4)
    input:SetAutoFocus(true)
    input:SetFontObject(GameFontHighlightSmall)
    input:SetScript("OnEscapePressed", function() dialog:Hide() end)
    input:SetScript("OnEnterPressed", function(self)
        local name = self:GetText()
        if TB.SavePreset(name) then
            TB.RebuildPresetList()
            dialog:Hide()
        end
    end)

    local okBtn = TB.CreateFlatButton(dialog, "Save", 80)
    okBtn:SetPoint("BOTTOM", 40, 10)
    okBtn:SetScript("OnClick", function()
        local name = input:GetText()
        if TB.SavePreset(name) then
            TB.RebuildPresetList()
            dialog:Hide()
        end
    end)

    local cancelBtn = TB.CreateFlatButton(dialog, "Cancel", 80)
    cancelBtn:SetPoint("BOTTOM", -40, 10)
    cancelBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)

    dialog:Show()
end
