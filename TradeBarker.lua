-- TradeBarker: Profession Service Advertiser for TBC Classic
-- Slash command: /tb

TradeBarkerDB = TradeBarkerDB or {}

-------------------------------------------------------------------------------
-- Profession Data (TBC Classic)
-------------------------------------------------------------------------------
local PROFESSION_DATA = {
    Enchanting = {
        {
            slot = "Weapon",
            items = {
                "Mongoose",
                "Executioner",
                "Soulfrost",
                "Sunfire",
                "Major Spellpower",
                "Major Healing",
                "Major Intellect",
                "Major Agility",
                "Major Striking",
                "Potency",
                "Battlemaster",
                "Spellsurge",
                "Deathfrost",
                "Greater Agility",
            },
        },
        {
            slot = "2H Weapon",
            items = {
                "Major Agility",
                "Savagery",
            },
        },
        {
            slot = "Chest",
            items = {
                "Exceptional Stats",
                "Major Resilience",
                "Defense",
                "Major Spirit",
                "Exceptional Health",
                "Exceptional Mana",
            },
        },
        {
            slot = "Cloak",
            items = {
                "Greater Agility",
                "Subtlety",
                "Spell Penetration",
                "Greater Arcane Resistance",
                "Greater Shadow Resistance",
                "Steelweave",
                "Major Armor",
                "Major Resistance",
            },
        },
        {
            slot = "Boots",
            items = {
                "Boar's Speed",
                "Cat's Swiftness",
                "Dexterity",
                "Fortitude",
                "Surefooted",
                "Vitality",
            },
        },
        {
            slot = "Gloves",
            items = {
                "Major Healing",
                "Spell Strike",
                "Major Strength",
                "Assault",
                "Blasting",
                "Major Spellpower",
            },
        },
        {
            slot = "Bracer",
            items = {
                "Spellpower",
                "Fortitude",
                "Major Defense",
                "Restore Mana Prime",
                "Stats",
                "Superior Healing",
                "Assault",
            },
        },
        {
            slot = "Shield",
            items = {
                "Intellect",
                "Shield Block",
                "Major Stamina",
                "Resistance",
            },
        },
        {
            slot = "Ring",
            items = {
                "Healing Power",
                "Spell Power",
                "Stats",
                "Striking",
            },
        },
    },
    Alchemy = {
        {
            slot = "Flasks",
            items = {
                "Flask of Fortification",
                "Flask of Blinding Light",
                "Flask of Mighty Versatility",
                "Flask of Pure Death",
                "Flask of Relentless Assault",
                "Flask of Supreme Power",
                "Flask of Distilled Wisdom",
                "Flask of the Titans",
                "Flask of Chromatic Resistance",
            },
        },
        {
            slot = "Elixirs",
            items = {
                "Elixir of Major Agility",
                "Elixir of Draenic Wisdom",
                "Elixir of Major Mageblood",
                "Elixir of Healing Power",
                "Elixir of Major Defense",
                "Elixir of Major Firepower",
                "Elixir of Major Shadow Power",
                "Elixir of Major Frost Power",
                "Elixir of Mastery",
                "Elixir of Ironskin",
            },
        },
        {
            slot = "Potions",
            items = {
                "Super Mana Potion",
                "Super Healing Potion",
                "Ironshield Potion",
                "Haste Potion",
                "Destruction Potion",
                "Free Action Potion",
            },
        },
        {
            slot = "Transmutes",
            items = {
                "Primal Might",
                "Earthstorm Diamond",
                "Skyfire Diamond",
                "Primal Fire to Earth",
                "Primal Earth to Water",
                "Primal Water to Air",
                "Primal Air to Fire",
                "Primal Life to Earth",
                "Primal Shadow to Water",
                "Primal Mana to Fire",
            },
        },
    },
    Jewelcrafting = {
        {
            slot = "Meta Gems",
            items = {
                "Insightful Earthstorm Diamond",
                "Bracing Earthstorm Diamond",
                "Powerful Earthstorm Diamond",
                "Relentless Earthstorm Diamond",
                "Chaotic Skyfire Diamond",
                "Destructive Skyfire Diamond",
                "Swift Skyfire Diamond",
                "Mystical Skyfire Diamond",
                "Thundering Skyfire Diamond",
            },
        },
        {
            slot = "Red Gems",
            items = {
                "Delicate Living Ruby",
                "Bold Living Ruby",
                "Runed Living Ruby",
                "Teardrop Living Ruby",
                "Bright Living Ruby",
                "Subtle Living Ruby",
            },
        },
        {
            slot = "Blue Gems",
            items = {
                "Solid Star of Elune",
                "Sparkling Star of Elune",
                "Lustrous Star of Elune",
                "Stormy Star of Elune",
            },
        },
        {
            slot = "Yellow Gems",
            items = {
                "Smooth Dawnstone",
                "Rigid Dawnstone",
                "Thick Dawnstone",
                "Gleaming Dawnstone",
                "Brilliant Dawnstone",
                "Mystic Dawnstone",
            },
        },
        {
            slot = "Orange Gems",
            items = {
                "Inscribed Noble Topaz",
                "Potent Noble Topaz",
                "Luminous Noble Topaz",
                "Glinting Noble Topaz",
                "Wicked Noble Topaz",
            },
        },
        {
            slot = "Green Gems",
            items = {
                "Enduring Talasite",
                "Dazzling Talasite",
                "Jagged Talasite",
                "Radiant Talasite",
            },
        },
        {
            slot = "Purple Gems",
            items = {
                "Glowing Nightseye",
                "Royal Nightseye",
                "Shifting Nightseye",
                "Sovereign Nightseye",
                "Purified Nightseye",
            },
        },
    },
    Blacksmithing = {
        {
            slot = "Weapons",
            items = {
                "Blazefury",
                "Lionheart Executioner",
                "Lionheart Champion",
                "Dragonstrike",
                "Dragonmaw",
                "Stormherald",
                "Deep Thunder",
                "Blazeguard",
                "Felsteel Longblade",
                "Runic Hammer",
                "Fel Edged Battleaxe",
                "Felsteel Whisper Knives",
            },
        },
        {
            slot = "Plate Armor",
            items = {
                "Bulwark of Kings",
                "Bulwark of the Ancient Kings",
                "Breastplate of Kings",
                "Enchanted Adamantite Breastplate",
                "Enchanted Adamantite Belt",
                "Enchanted Adamantite Leggings",
                "Enchanted Adamantite Boots",
                "Khorium Belt",
                "Ragesteel Breastplate",
                "Ragesteel Gloves",
                "Ragesteel Helm",
            },
        },
        {
            slot = "Mail Armor",
            items = {
                "Swiftsteel Bracers",
                "Earthpeace Breastplate",
                "Swiftsteel Shoulders",
                "Fel Iron Chain Coif",
                "Fel Iron Chain Tunic",
                "Fel Iron Chain Bracers",
            },
        },
        {
            slot = "Sharpening/Weightstones",
            items = {
                "Adamantite Sharpening Stone",
                "Adamantite Weightstone",
                "Felsteel Shield Spike",
            },
        },
    },
    Leatherworking = {
        {
            slot = "Drums",
            items = {
                "Drums of Battle",
                "Drums of War",
                "Drums of Restoration",
                "Drums of Speed",
                "Drums of Panic",
            },
        },
        {
            slot = "Leg Armor",
            items = {
                "Nethercobra Leg Armor",
                "Nethercleft Leg Armor",
                "Cobrahide Leg Armor",
                "Clefthide Leg Armor",
            },
        },
        {
            slot = "Armor Kits",
            items = {
                "Vindicator's Armor Kit",
                "Magister's Armor Kit",
                "Knothide Armor Kit",
            },
        },
        {
            slot = "Leather Armor",
            items = {
                "Primalstrike Vest",
                "Primalstrike Bracers",
                "Primalstrike Belt",
                "Windhawk Hauberk",
                "Windhawk Bracers",
                "Windhawk Belt",
                "Living Crystal Breastplate",
                "Golden Dragonstrike Breastplate",
            },
        },
        {
            slot = "Mail Armor",
            items = {
                "Ebon Netherscale Breastplate",
                "Ebon Netherscale Belt",
                "Ebon Netherscale Bracers",
                "Netherstrike Breastplate",
                "Netherstrike Belt",
                "Netherstrike Bracers",
                "Blastguard Pants",
                "Blastguard Boots",
                "Blastguard Belt",
            },
        },
    },
}

-------------------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------------------
local DEFAULT_TEMPLATE = "LFW {profession}! | {items} | PST!"
local MAX_CHAT_LENGTH = 255

local mainFrame
local previewBox
local templateBox
local charCountText
local scrollChild
local scrollFrame
local noProfsText
local checkboxes = {}
local professionTabs = {}
local detectedProfessions = {}
local selectedProfession = nil

local function GetItemKey(slot, item)
    return slot .. ":" .. item
end

local function GetProfessionData()
    if not selectedProfession then return nil end
    return PROFESSION_DATA[selectedProfession]
end

local function GetTemplate()
    if not selectedProfession then return DEFAULT_TEMPLATE end
    TradeBarkerDB._templates = TradeBarkerDB._templates or {}
    return TradeBarkerDB._templates[selectedProfession] or DEFAULT_TEMPLATE
end

local function SetTemplate(text)
    if not selectedProfession then return end
    TradeBarkerDB._templates = TradeBarkerDB._templates or {}
    if text == DEFAULT_TEMPLATE or text == "" then
        TradeBarkerDB._templates[selectedProfession] = nil
    else
        TradeBarkerDB._templates[selectedProfession] = text
    end
end

local function RenderTemplate(template, profName, itemsStr)
    local result = template:gsub("{profession}", profName)
    result = result:gsub("{items}", itemsStr)
    return result
end

local function DetectProfessions()
    local found = {}
    local numSkills = GetNumSkillLines()
    for i = 1, numSkills do
        local skillName = GetSkillLineInfo(i)
        if PROFESSION_DATA[skillName] then
            table.insert(found, skillName)
        end
    end
    return found
end

local function BuildItemsString()
    local data = GetProfessionData()
    if not data then return nil end

    local parts = {}
    for _, group in ipairs(data) do
        local selected = {}
        for _, item in ipairs(group.items) do
            local key = GetItemKey(group.slot, item)
            if TradeBarkerDB[key] then
                table.insert(selected, item)
            end
        end
        if #selected > 0 then
            table.insert(parts, group.slot .. ": " .. table.concat(selected, ", "))
        end
    end

    if #parts == 0 then
        return nil
    end

    return table.concat(parts, " | ")
end

local function BuildMessage()
    local itemsStr = BuildItemsString()
    if not itemsStr then return nil end

    local template = GetTemplate()
    return RenderTemplate(template, selectedProfession, itemsStr)
end

local function UpdateCharCount()
    if not charCountText then return end
    local msg = BuildMessage()
    local len = msg and #msg or 0
    if len == 0 then
        charCountText:SetText("|cff5555550 / " .. MAX_CHAT_LENGTH .. "|r")
    elseif len > MAX_CHAT_LENGTH then
        charCountText:SetText("|cffff4444" .. len .. " / " .. MAX_CHAT_LENGTH .. "|r")
    else
        charCountText:SetText("|cff88aa88" .. len .. " / " .. MAX_CHAT_LENGTH .. "|r")
    end
end

local function SplitMessage(msg, maxLen)
    if #msg <= maxLen then
        return { msg }
    end

    -- Derive prefix/suffix by rendering template with empty items
    local template = GetTemplate()
    local emptyRender = RenderTemplate(template, selectedProfession, "")
    -- Find where the empty items placeholder is by splitting on it
    local prefixEnd = emptyRender:find("{items}")
    local prefix, suffix
    if prefixEnd then
        -- Template still has literal {items} — shouldn't happen, but handle gracefully
        prefix = emptyRender:sub(1, prefixEnd - 1)
        suffix = emptyRender:sub(prefixEnd + 7)
    else
        -- The empty render has prefix..suffix with nothing in between
        -- We find the split point by comparing the full message with the empty render
        local fullLen = #msg
        local emptyLen = #emptyRender
        local itemsLen = fullLen - emptyLen
        -- Find where items start by locating the items string in the message
        local itemsStr = BuildItemsString()
        local itemsStart = msg:find(itemsStr, 1, true)
        if itemsStart then
            prefix = msg:sub(1, itemsStart - 1)
            suffix = msg:sub(itemsStart + #itemsStr)
        else
            -- Fallback: can't split intelligently, return as-is
            return { msg }
        end
    end

    -- Split the items portion on " | " boundaries
    local itemsStr = BuildItemsString()
    local segments = {}
    for seg in string.gmatch(itemsStr, "[^|]+") do
        seg = seg:match("^%s*(.-)%s*$")
        if seg ~= "" then
            table.insert(segments, seg)
        end
    end

    local messages = {}
    local current = prefix
    for i, seg in ipairs(segments) do
        local testLine = current .. seg .. " | "
        if #testLine + #suffix > maxLen and current ~= prefix then
            -- Trim trailing " | " and close this message
            table.insert(messages, current:match("^(.-)%s*|?%s*$") .. suffix)
            current = prefix .. seg .. " | "
        else
            current = current .. seg .. " | "
        end
    end
    if current ~= prefix then
        table.insert(messages, current:match("^(.-)%s*|?%s*$") .. suffix)
    end

    return messages
end

local function SendToTrade()
    local msg = BuildMessage()
    if not msg then
        print("|cffff6600[TradeBarker]|r No items selected!")
        return
    end

    local channelNum = GetChannelName("Trade")
    if not channelNum or channelNum == 0 then
        channelNum = GetChannelName("Trade - City")
        if not channelNum or channelNum == 0 then
            print("|cffff6600[TradeBarker]|r You must be in a city with Trade channel to send!")
            return
        end
    end

    local messages = SplitMessage(msg, MAX_CHAT_LENGTH)
    for _, m in ipairs(messages) do
        if #m > MAX_CHAT_LENGTH then
            print("|cffff6600[TradeBarker]|r Message part too long (" .. #m .. "/" .. MAX_CHAT_LENGTH .. " chars). Deselect some items!")
            return
        end
        SendChatMessage(m, "CHANNEL", nil, channelNum)
    end
    print("|cff00ff00[TradeBarker]|r Message sent to Trade! (" .. #messages .. " message(s))")
end

-------------------------------------------------------------------------------
-- UI Helpers
-------------------------------------------------------------------------------
local function CreatePanel(parent, name)
    local panel = CreateFrame("Frame", name, parent, "BackdropTemplate")
    panel:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    panel:SetBackdropColor(0, 0, 0, 0.3)
    panel:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
    return panel
end

local function CreateFlatButton(parent, text, width)
    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetSize(width or 80, 22)
    btn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    btn:SetBackdropColor(0.15, 0.15, 0.15, 0.9)
    btn:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8)

    local label = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("CENTER")
    label:SetText(text)
    btn:SetFontString(label)

    btn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.25, 0.25, 0.25, 0.9)
        self:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8)
    end)
    btn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.15, 0.15, 0.15, 0.9)
        self:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8)
    end)

    return btn
end

-------------------------------------------------------------------------------
-- UI: Rebuild Checkboxes
-------------------------------------------------------------------------------
local function RebuildCheckboxes()
    for _, entry in ipairs(checkboxes) do
        entry.cb:Hide()
        entry.cb:SetParent(nil)
        entry.label:Hide()
        entry.label:SetParent(nil)
    end
    wipe(checkboxes)

    if scrollChild._headers then
        for _, h in ipairs(scrollChild._headers) do
            h:Hide()
            h:SetParent(nil)
        end
    end
    scrollChild._headers = {}

    local data = GetProfessionData()
    if not data then return end

    local yOffset = 4
    for _, group in ipairs(data) do
        local header = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        header:SetPoint("TOPLEFT", 6, -yOffset)
        header:SetText("|cff8899aa" .. group.slot:upper() .. "|r")
        table.insert(scrollChild._headers, header)
        yOffset = yOffset + 16

        for _, item in ipairs(group.items) do
            local key = GetItemKey(group.slot, item)
            local cb = CreateFrame("CheckButton", nil, scrollChild, "UICheckButtonTemplate")
            cb:SetPoint("TOPLEFT", 6, -yOffset)
            cb:SetSize(22, 22)
            cb:SetChecked(TradeBarkerDB[key] or false)
            cb:SetScript("OnClick", function(self)
                TradeBarkerDB[key] = self:GetChecked() and true or false
            end)

            local label = cb:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            label:SetPoint("LEFT", cb, "RIGHT", 4, 0)
            label:SetText(item)

            table.insert(checkboxes, { cb = cb, key = key, label = label })
            yOffset = yOffset + 20
        end

        yOffset = yOffset + 8
    end

    scrollChild:SetHeight(yOffset)
end

-------------------------------------------------------------------------------
-- UI: Update Tab Highlights
-------------------------------------------------------------------------------
local function UpdateTabHighlights()
    for prof, tab in pairs(professionTabs) do
        if prof == selectedProfession then
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
local function RebuildTabs()
    for _, tab in pairs(professionTabs) do
        tab:Hide()
        tab:SetParent(nil)
    end
    wipe(professionTabs)

    detectedProfessions = DetectProfessions()

    if #detectedProfessions == 0 then
        selectedProfession = nil
        if noProfsText then
            noProfsText:Show()
        end
        if scrollFrame then
            scrollFrame:Hide()
        end
        RebuildCheckboxes()
        return
    end

    if noProfsText then
        noProfsText:Hide()
    end
    if scrollFrame then
        scrollFrame:Show()
    end

    local found = false
    for _, prof in ipairs(detectedProfessions) do
        if prof == selectedProfession then
            found = true
            break
        end
    end
    if not found then
        selectedProfession = detectedProfessions[1]
        TradeBarkerDB._profession = selectedProfession
    end

    -- Create tabs with even spacing
    local padding = 8
    local gap = 4
    local totalGaps = (#detectedProfessions - 1) * gap
    local availableWidth = mainFrame:GetWidth() - padding * 2
    local tabWidth = (availableWidth - totalGaps) / #detectedProfessions

    for i, profName in ipairs(detectedProfessions) do
        local tab = CreateFrame("Button", nil, mainFrame, "BackdropTemplate")
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
            selectedProfession = profName
            TradeBarkerDB._profession = profName
            UpdateTabHighlights()
            RebuildCheckboxes()
            if templateBox then
                templateBox:SetText(GetTemplate())
            end
            if previewBox then
                previewBox:SetText("")
            end
        end)

        tab:SetScript("OnEnter", function(self)
            if profName ~= selectedProfession then
                self:SetBackdropColor(0.18, 0.18, 0.18, 0.9)
                self:GetFontString():SetTextColor(0.8, 0.8, 0.8)
            end
        end)
        tab:SetScript("OnLeave", function(self)
            if profName ~= selectedProfession then
                self:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
                self:GetFontString():SetTextColor(0.5, 0.5, 0.5)
            end
        end)

        professionTabs[profName] = tab
    end

    UpdateTabHighlights()
    RebuildCheckboxes()
    if templateBox then
        templateBox:SetText(GetTemplate())
    end
end

-------------------------------------------------------------------------------
-- UI Creation
-------------------------------------------------------------------------------
local function CreateMainFrame()
    local f = CreateFrame("Frame", "TradeBarkerFrame", UIParent, "BackdropTemplate")
    f:SetSize(360, 600)
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
    noProfsText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    noProfsText:SetPoint("CENTER", 0, 20)
    noProfsText:SetText("|cff666666No supported professions detected.|r\n|cff444444Enchanting, Alchemy, Jewelcrafting, Blacksmithing, Leatherworking|r")
    noProfsText:Hide()

    -- Template section
    local templateHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    templateHeader:SetPoint("TOPLEFT", 10, -62)
    templateHeader:SetText("|cff8899aaTemplate|r")

    charCountText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    charCountText:SetPoint("TOPRIGHT", -10, -62)
    charCountText:SetText("|cff5555550 / " .. MAX_CHAT_LENGTH .. "|r")

    local templatePanel = CreatePanel(f, nil)
    templatePanel:SetPoint("TOPLEFT", 8, -76)
    templatePanel:SetPoint("RIGHT", -48, 0)
    templatePanel:SetHeight(50)

    templateBox = CreateFrame("EditBox", nil, templatePanel)
    templateBox:SetPoint("TOPLEFT", 6, -6)
    templateBox:SetPoint("BOTTOMRIGHT", -6, 6)
    templateBox:SetAutoFocus(false)
    templateBox:SetFontObject(GameFontHighlightSmall)
    templateBox:SetMultiLine(true)
    templateBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    templateBox:SetScript("OnEditFocusLost", function(self)
        local text = self:GetText():gsub("\n", " ")
        self:SetText(text)
        if not text:find("{items}") then
            print("|cffff6600[TradeBarker]|r Template must contain {items} placeholder! Resetting.")
            self:SetText(GetTemplate())
            return
        end
        SetTemplate(text)
        UpdateCharCount()
    end)

    local resetBtn = CreateFlatButton(f, "Reset", 36)
    resetBtn:SetHeight(50)
    resetBtn:SetPoint("LEFT", templatePanel, "RIGHT", 4, 0)
    resetBtn:SetScript("OnClick", function()
        SetTemplate(DEFAULT_TEMPLATE)
        templateBox:SetText(DEFAULT_TEMPLATE)
        UpdateCharCount()
    end)

    -- Preview section (below template)
    local previewLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    previewLabel:SetPoint("TOPLEFT", 10, -130)
    previewLabel:SetText("|cff8899aaPreview|r")

    local previewPanel = CreatePanel(f, nil)
    previewPanel:SetPoint("TOPLEFT", 8, -144)
    previewPanel:SetPoint("RIGHT", -8, 0)
    previewPanel:SetHeight(50)

    previewBox = CreateFrame("EditBox", nil, previewPanel)
    previewBox:SetPoint("TOPLEFT", 6, -6)
    previewBox:SetPoint("BOTTOMRIGHT", -6, 6)
    previewBox:SetAutoFocus(false)
    previewBox:SetFontObject(GameFontHighlightSmall)
    previewBox:SetMultiLine(true)
    previewBox:EnableMouse(true)
    previewBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

    -- Checklist scroll area
    local listPanel = CreatePanel(f, nil)
    listPanel:SetPoint("TOPLEFT", 8, -200)
    listPanel:SetPoint("BOTTOMRIGHT", -8, 38)

    scrollFrame = CreateFrame("ScrollFrame", "TradeBarkerScrollFrame", listPanel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 2, -2)
    scrollFrame:SetPoint("BOTTOMRIGHT", -22, 2)

    scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(scrollFrame:GetWidth() or 280, 1)
    scrollFrame:SetScrollChild(scrollChild)

    -- Bottom button row
    local selectAllBtn = CreateFlatButton(f, "Select All", 72)
    selectAllBtn:SetPoint("BOTTOMLEFT", 8, 8)
    selectAllBtn:SetScript("OnClick", function()
        for _, entry in ipairs(checkboxes) do
            entry.cb:SetChecked(true)
            TradeBarkerDB[entry.key] = true
        end
    end)

    local deselectAllBtn = CreateFlatButton(f, "Deselect All", 72)
    deselectAllBtn:SetPoint("LEFT", selectAllBtn, "RIGHT", 4, 0)
    deselectAllBtn:SetScript("OnClick", function()
        for _, entry in ipairs(checkboxes) do
            entry.cb:SetChecked(false)
            TradeBarkerDB[entry.key] = false
        end
    end)

    local previewBtn = CreateFlatButton(f, "Preview", 72)
    previewBtn:SetPoint("LEFT", deselectAllBtn, "RIGHT", 4, 0)
    previewBtn:SetScript("OnClick", function()
        local msg = BuildMessage()
        if msg then
            previewBox:SetText(msg)
            UpdateCharCount()
            local msgs = SplitMessage(msg, MAX_CHAT_LENGTH)
            if #msgs > 1 then
                print("|cffffd200[TradeBarker]|r Message will be split into " .. #msgs .. " parts.")
            end
        else
            previewBox:SetText("(no items selected)")
            UpdateCharCount()
        end
    end)

    local sendBtn = CreateFlatButton(f, "Send", 72)
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
        SendToTrade()
    end)

    return f
end

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("SKILL_LINES_CHANGED")
eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "TradeBarker" then
        TradeBarkerDB = TradeBarkerDB or {}
        selectedProfession = TradeBarkerDB._profession or nil
        mainFrame = CreateMainFrame()
        mainFrame:Hide()
        -- Attempt initial detection (skills may not be ready yet)
        RebuildTabs()
        print("|cff00ccff[TradeBarker]|r Loaded! Type /tb to open.")
        self:UnregisterEvent("ADDON_LOADED")
    elseif event == "SKILL_LINES_CHANGED" then
        if mainFrame then
            RebuildTabs()
        end
    end
end)

-- Slash command
SLASH_TRADEBARKER1 = "/tb"
SLASH_TRADEBARKER2 = "/tradebarker"
SlashCmdList["TRADEBARKER"] = function()
    if mainFrame then
        if mainFrame:IsShown() then
            mainFrame:Hide()
        else
            mainFrame:Show()
        end
    end
end
