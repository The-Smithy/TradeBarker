-- TradeBarker: Core State and Utilities
-- This file contains core state management and helper functions

-- Namespace
TradeBarker = TradeBarker or {}
local TB = TradeBarker

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
TB.DEFAULT_TEMPLATE = "LFW {profession}! | {items} | PST!"
TB.MAX_CHAT_LENGTH = 255

-------------------------------------------------------------------------------
-- Debug
-------------------------------------------------------------------------------
TB.debugMode = false

local _origErrorHandler = nil

local function TB_ErrorHandler(err)
    print("|cffff4444[TB:ERR]|r " .. tostring(err))
    if _origErrorHandler then
        _origErrorHandler(err)
    end
end

function TB.SetDebugMode(enabled)
    TB.debugMode = enabled
    if enabled then
        _origErrorHandler = geterrorhandler()
        seterrorhandler(TB_ErrorHandler)
    else
        if _origErrorHandler then
            seterrorhandler(_origErrorHandler)
        end
        _origErrorHandler = nil
    end
end

function TB.Debug(msg)
    if TB.debugMode then
        print("|cff888888[TB:DBG]|r " .. tostring(msg))
    end
end

-------------------------------------------------------------------------------
-- State Variables
-------------------------------------------------------------------------------
TB.selectedProfession = nil
TB.detectedProfessions = {}

-- UI References (set by UI.lua)
TB.mainFrame = nil
TB.previewBox = nil
TB.templateBox = nil
TB.charCountText = nil
TB.scrollChild = nil
TB.scrollFrame = nil
TB.noProfsText = nil
TB.presetListFrame = nil
TB.checkboxes = {}
TB.professionTabs = {}

-------------------------------------------------------------------------------
-- Item Helper Functions
-------------------------------------------------------------------------------
function TB.GetItemKey(slot, item)
    local itemName = type(item) == "table" and item.name or item
    return slot .. ":" .. itemName
end

function TB.GetItemName(item)
    return type(item) == "table" and item.name or item
end

function TB.GetItemSpellID(item)
    return type(item) == "table" and item.spellID or nil
end

function TB.CreateSpellLink(spellID, name)
    if not spellID then return name end
    -- Create a spell link in WoW format: |cff71d5ff|Hspell:ID|h[Name]|h|r
    return string.format("|cff71d5ff|Hspell:%d|h[%s]|h|r", spellID, name)
end

-------------------------------------------------------------------------------
-- Settings Functions
-------------------------------------------------------------------------------
function TB.UseSpellLinks()
    return TradeBarkerDB._useSpellLinks or false
end

function TB.SetUseSpellLinks(enabled)
    TradeBarkerDB._useSpellLinks = enabled and true or false
end

function TB.GetProfessionData()
    if not TB.selectedProfession then return nil end
    return TB.PROFESSION_DATA[TB.selectedProfession]
end

function TB.GetTemplate()
    if not TB.selectedProfession then return TB.DEFAULT_TEMPLATE end
    TradeBarkerDB._templates = TradeBarkerDB._templates or {}
    return TradeBarkerDB._templates[TB.selectedProfession] or TB.DEFAULT_TEMPLATE
end

function TB.SetTemplate(text)
    if not TB.selectedProfession then return end
    TradeBarkerDB._templates = TradeBarkerDB._templates or {}
    if text == TB.DEFAULT_TEMPLATE or text == "" then
        TradeBarkerDB._templates[TB.selectedProfession] = nil
    else
        TradeBarkerDB._templates[TB.selectedProfession] = text
    end
end

function TB.RenderTemplate(template, profName, itemsStr)
    TB.Debug("RenderTemplate: prof=" .. tostring(profName) .. " itemsLen=" .. tostring(itemsStr and #itemsStr or 0))
    local result = template:gsub("{profession}", profName or "")
    result = result:gsub("{items}", itemsStr or "")
    TB.Debug("RenderTemplate: result=" .. result)
    return result
end

-------------------------------------------------------------------------------
-- Profession Detection
-------------------------------------------------------------------------------
function TB.DetectProfessions()
    local found = {}
    local numSkills = GetNumSkillLines()
    for i = 1, numSkills do
        local skillName = GetSkillLineInfo(i)
        if TB.PROFESSION_DATA[skillName] then
            table.insert(found, skillName)
        end
    end
    return found
end

-------------------------------------------------------------------------------
-- UI Helper
-------------------------------------------------------------------------------
function TB.CreatePanel(parent, name)
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

function TB.CreateFlatButton(parent, text, width)
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
