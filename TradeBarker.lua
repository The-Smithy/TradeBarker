-- TradeBarker: Profession Service Advertiser for TBC Classic
-- Slash command: /tb

TradeBarkerDB = TradeBarkerDB or {}

-------------------------------------------------------------------------------
-- Profession Data (TBC Classic)
-- Each item can optionally have a spellID for creating clickable spell links
-- To find spell IDs: hover over the spell in your spellbook with this macro:
--   /run local n=GameTooltip:GetSpell() if n then local _,id=GetSpellLink(n):match("spell:(%d+)") print(n,id) end
-------------------------------------------------------------------------------
local PROFESSION_DATA = {
    Enchanting = {
        {
            slot = "Weapon",
            items = {
                { name = "Mongoose", spellID = 27984 },
                { name = "Executioner", spellID = 42974 },
                { name = "Soulfrost", spellID = 27982 },
                { name = "Sunfire", spellID = 27981 },
                { name = "Major Spellpower", spellID = 27975 },
                { name = "Major Healing", spellID = 27972 },
                { name = "Major Intellect", spellID = 27968 },
                { name = "Major Agility", spellID = 27967 },
                { name = "Major Striking", spellID = 27971 },
                { name = "Potency", spellID = 27968 },
                { name = "Battlemaster", spellID = 28004 },
                { name = "Spellsurge", spellID = 28003 },
                { name = "Deathfrost", spellID = 46578 },
                { name = "Greater Agility", spellID = 23800 },
            },
        },
        {
            slot = "2H Weapon",
            items = {
                { name = "Major Agility", spellID = 27837 },
                { name = "Savagery", spellID = 27977 },
            },
        },
        {
            slot = "Chest",
            items = {
                { name = "Exceptional Stats", spellID = 27957 },
                { name = "Major Resilience", spellID = 33992 },
                { name = "Defense", spellID = 27960 },
                { name = "Major Spirit", spellID = 33990 },
                { name = "Exceptional Health", spellID = 27957 },
                { name = "Exceptional Mana", spellID = 27958 },
            },
        },
        {
            slot = "Cloak",
            items = {
                { name = "Greater Agility", spellID = 25084 },
                { name = "Subtlety", spellID = 25083 },
                { name = "Spell Penetration", spellID = 34003 },
                { name = "Greater Arcane Resistance", spellID = 27961 },
                { name = "Greater Shadow Resistance", spellID = 27962 },
                { name = "Steelweave", spellID = 27950 },
                { name = "Major Armor", spellID = 27951 },
                { name = "Major Resistance", spellID = 36285 },
            },
        },
        {
            slot = "Boots",
            items = {
                { name = "Boar's Speed", spellID = 34008 },
                { name = "Cat's Swiftness", spellID = 34007 },
                { name = "Dexterity", spellID = 27948 },
                { name = "Fortitude", spellID = 27949 },
                { name = "Surefooted", spellID = 27954 },
                { name = "Vitality", spellID = 35343 },
            },
        },
        {
            slot = "Gloves",
            items = {
                { name = "Major Healing", spellID = 33999 },
                { name = "Spell Strike", spellID = 33997 },
                { name = "Major Strength", spellID = 33995 },
                { name = "Assault", spellID = 33996 },
                { name = "Blasting", spellID = 33993 },
                { name = "Major Spellpower", spellID = 33994 },
            },
        },
        {
            slot = "Bracer",
            items = {
                { name = "Spellpower", spellID = 27917 },
                { name = "Fortitude", spellID = 27914 },
                { name = "Major Defense", spellID = 27913 },
                { name = "Restore Mana Prime", spellID = 27913 },
                { name = "Stats", spellID = 27905 },
                { name = "Superior Healing", spellID = 27911 },
                { name = "Assault", spellID = 33990 },
            },
        },
        {
            slot = "Shield",
            items = {
                { name = "Intellect", spellID = 27944 },
                { name = "Shield Block", spellID = 27945 },
                { name = "Major Stamina", spellID = 27947 },
                { name = "Resistance", spellID = 27946 },
            },
        },
        {
            slot = "Ring",
            items = {
                { name = "Healing Power", spellID = 27927 },
                { name = "Spell Power", spellID = 27924 },
                { name = "Stats", spellID = 27926 },
                { name = "Striking", spellID = 27920 },
            },
        },
    },
    Alchemy = {
        {
            slot = "Flasks",
            items = {
                { name = "Flask of Fortification", spellID = 28518 },
                { name = "Flask of Blinding Light", spellID = 28519 },
                { name = "Flask of Mighty Versatility", spellID = 28520 },
                { name = "Flask of Pure Death", spellID = 28540 },
                { name = "Flask of Relentless Assault", spellID = 28521 },
                { name = "Flask of Supreme Power", spellID = 17559 },
                { name = "Flask of Distilled Wisdom", spellID = 17555 },
                { name = "Flask of the Titans", spellID = 17552 },
                { name = "Flask of Chromatic Resistance", spellID = 17565 },
            },
        },
        {
            slot = "Elixirs",
            items = {
                { name = "Elixir of Major Agility", spellID = 28543 },
                { name = "Elixir of Draenic Wisdom", spellID = 39638 },
                { name = "Elixir of Major Mageblood", spellID = 28549 },
                { name = "Elixir of Healing Power", spellID = 28556 },
                { name = "Elixir of Major Defense", spellID = 28544 },
                { name = "Elixir of Major Firepower", spellID = 28545 },
                { name = "Elixir of Major Shadow Power", spellID = 28553 },
                { name = "Elixir of Major Frost Power", spellID = 28546 },
                { name = "Elixir of Mastery", spellID = 33741 },
                { name = "Elixir of Ironskin", spellID = 39636 },
            },
        },
        {
            slot = "Potions",
            items = {
                { name = "Super Mana Potion", spellID = 28568 },
                { name = "Super Healing Potion", spellID = 28569 },
                { name = "Ironshield Potion", spellID = 28564 },
                { name = "Haste Potion", spellID = 28562 },
                { name = "Destruction Potion", spellID = 28560 },
                { name = "Free Action Potion", spellID = 6624 },
            },
        },
        {
            slot = "Transmutes",
            items = {
                { name = "Primal Might", spellID = 29688 },
                { name = "Earthstorm Diamond", spellID = 32765 },
                { name = "Skyfire Diamond", spellID = 32766 },
                { name = "Primal Fire to Earth", spellID = 28585 },
                { name = "Primal Earth to Water", spellID = 28583 },
                { name = "Primal Water to Air", spellID = 28584 },
                { name = "Primal Air to Fire", spellID = 28582 },
                { name = "Primal Life to Earth", spellID = 28580 },
                { name = "Primal Shadow to Water", spellID = 28581 },
                { name = "Primal Mana to Fire", spellID = 28579 },
            },
        },
    },
    Jewelcrafting = {
        {
            slot = "Meta Gems",
            items = {
                { name = "Insightful Earthstorm Diamond", spellID = 32870 },
                { name = "Bracing Earthstorm Diamond", spellID = 32867 },
                { name = "Powerful Earthstorm Diamond", spellID = 32869 },
                { name = "Relentless Earthstorm Diamond", spellID = 32871 },
                { name = "Chaotic Skyfire Diamond", spellID = 32866 },
                { name = "Destructive Skyfire Diamond", spellID = 32868 },
                { name = "Swift Skyfire Diamond", spellID = 32872 },
                { name = "Mystical Skyfire Diamond", spellID = 32873 },
                { name = "Thundering Skyfire Diamond", spellID = 32874 },
            },
        },
        {
            slot = "Red Gems",
            items = {
                { name = "Delicate Living Ruby", spellID = 28903 },
                { name = "Bold Living Ruby", spellID = 28910 },
                { name = "Runed Living Ruby", spellID = 28912 },
                { name = "Teardrop Living Ruby", spellID = 28914 },
                { name = "Bright Living Ruby", spellID = 28915 },
                { name = "Subtle Living Ruby", spellID = 28936 },
            },
        },
        {
            slot = "Blue Gems",
            items = {
                { name = "Solid Star of Elune", spellID = 28944 },
                { name = "Sparkling Star of Elune", spellID = 28945 },
                { name = "Lustrous Star of Elune", spellID = 28948 },
                { name = "Stormy Star of Elune", spellID = 28950 },
            },
        },
        {
            slot = "Yellow Gems",
            items = {
                { name = "Smooth Dawnstone", spellID = 28916 },
                { name = "Rigid Dawnstone", spellID = 28924 },
                { name = "Thick Dawnstone", spellID = 28927 },
                { name = "Gleaming Dawnstone", spellID = 28933 },
                { name = "Brilliant Dawnstone", spellID = 28936 },
                { name = "Mystic Dawnstone", spellID = 28948 },
            },
        },
        {
            slot = "Orange Gems",
            items = {
                { name = "Inscribed Noble Topaz", spellID = 28918 },
                { name = "Potent Noble Topaz", spellID = 28925 },
                { name = "Luminous Noble Topaz", spellID = 28948 },
                { name = "Glinting Noble Topaz", spellID = 28950 },
                { name = "Wicked Noble Topaz", spellID = 28953 },
            },
        },
        {
            slot = "Green Gems",
            items = {
                { name = "Enduring Talasite", spellID = 28950 },
                { name = "Dazzling Talasite", spellID = 28951 },
                { name = "Jagged Talasite", spellID = 28953 },
                { name = "Radiant Talasite", spellID = 28955 },
            },
        },
        {
            slot = "Purple Gems",
            items = {
                { name = "Glowing Nightseye", spellID = 28955 },
                { name = "Royal Nightseye", spellID = 28957 },
                { name = "Shifting Nightseye", spellID = 28909 },
                { name = "Sovereign Nightseye", spellID = 28925 },
                { name = "Purified Nightseye", spellID = 28948 },
            },
        },
    },
    Blacksmithing = {
        {
            slot = "Weapons",
            items = {
                { name = "Blazefury", spellID = 36125 },
                { name = "Lionheart Executioner", spellID = 36137 },
                { name = "Lionheart Champion", spellID = 34544 },
                { name = "Dragonstrike", spellID = 36136 },
                { name = "Dragonmaw", spellID = 36135 },
                { name = "Stormherald", spellID = 36134 },
                { name = "Deep Thunder", spellID = 34548 },
                { name = "Blazeguard", spellID = 36133 },
                { name = "Felsteel Longblade", spellID = 29569 },
                { name = "Runic Hammer", spellID = 36131 },
                { name = "Fel Edged Battleaxe", spellID = 29568 },
                { name = "Felsteel Whisper Knives", spellID = 36130 },
            },
        },
        {
            slot = "Plate Armor",
            items = {
                { name = "Bulwark of Kings", spellID = 36257 },
                { name = "Bulwark of the Ancient Kings", spellID = 36256 },
                { name = "Breastplate of Kings", spellID = 36256 },
                { name = "Enchanted Adamantite Breastplate", spellID = 31941 },
                { name = "Enchanted Adamantite Belt", spellID = 31943 },
                { name = "Enchanted Adamantite Leggings", spellID = 31942 },
                { name = "Enchanted Adamantite Boots", spellID = 31940 },
                { name = "Khorium Belt", spellID = 29606 },
                { name = "Ragesteel Breastplate", spellID = 29619 },
                { name = "Ragesteel Gloves", spellID = 29620 },
                { name = "Ragesteel Helm", spellID = 29621 },
            },
        },
        {
            slot = "Mail Armor",
            items = {
                { name = "Swiftsteel Bracers", spellID = 29611 },
                { name = "Earthpeace Breastplate", spellID = 29613 },
                { name = "Swiftsteel Shoulders", spellID = 29615 },
                { name = "Fel Iron Chain Coif", spellID = 29556 },
                { name = "Fel Iron Chain Tunic", spellID = 29557 },
                { name = "Fel Iron Chain Bracers", spellID = 29603 },
            },
        },
        {
            slot = "Sharpening/Weightstones",
            items = {
                { name = "Adamantite Sharpening Stone", spellID = 29654 },
                { name = "Adamantite Weightstone", spellID = 29656 },
                { name = "Felsteel Shield Spike", spellID = 29657 },
            },
        },
    },
    Leatherworking = {
        {
            slot = "Drums",
            items = {
                { name = "Drums of Battle", spellID = 35538 },
                { name = "Drums of War", spellID = 29649 },
                { name = "Drums of Restoration", spellID = 35539 },
                { name = "Drums of Speed", spellID = 35540 },
                { name = "Drums of Panic", spellID = 29648 },
            },
        },
        {
            slot = "Leg Armor",
            items = {
                { name = "Nethercobra Leg Armor", spellID = 35549 },
                { name = "Nethercleft Leg Armor", spellID = 35554 },
                { name = "Cobrahide Leg Armor", spellID = 35557 },
                { name = "Clefthide Leg Armor", spellID = 35558 },
            },
        },
        {
            slot = "Armor Kits",
            items = {
                { name = "Vindicator's Armor Kit", spellID = 32457 },
                { name = "Magister's Armor Kit", spellID = 32458 },
                { name = "Knothide Armor Kit", spellID = 32456 },
            },
        },
        {
            slot = "Leather Armor",
            items = {
                { name = "Primalstrike Vest", spellID = 36074 },
                { name = "Primalstrike Bracers", spellID = 36075 },
                { name = "Primalstrike Belt", spellID = 36076 },
                { name = "Windhawk Hauberk", spellID = 36077 },
                { name = "Windhawk Bracers", spellID = 36078 },
                { name = "Windhawk Belt", spellID = 36079 },
                { name = "Living Crystal Breastplate", spellID = 32482 },
                { name = "Golden Dragonstrike Breastplate", spellID = 35582 },
            },
        },
        {
            slot = "Mail Armor",
            items = {
                { name = "Ebon Netherscale Breastplate", spellID = 36349 },
                { name = "Ebon Netherscale Belt", spellID = 36351 },
                { name = "Ebon Netherscale Bracers", spellID = 36352 },
                { name = "Netherstrike Breastplate", spellID = 36353 },
                { name = "Netherstrike Belt", spellID = 36355 },
                { name = "Netherstrike Bracers", spellID = 36357 },
                { name = "Blastguard Pants", spellID = 32485 },
                { name = "Blastguard Boots", spellID = 32488 },
                { name = "Blastguard Belt", spellID = 32489 },
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
    local itemName = type(item) == "table" and item.name or item
    return slot .. ":" .. itemName
end

local function GetItemName(item)
    return type(item) == "table" and item.name or item
end

local function GetItemSpellID(item)
    return type(item) == "table" and item.spellID or nil
end

local function CreateSpellLink(spellID, name)
    if not spellID then return name end
    -- Create a spell link in WoW format: |cff71d5ff|Hspell:ID|h[Name]|h|r
    return string.format("|cff71d5ff|Hspell:%d|h[%s]|h|r", spellID, name)
end

local function UseSpellLinks()
    return TradeBarkerDB._useSpellLinks or false
end

local function SetUseSpellLinks(enabled)
    TradeBarkerDB._useSpellLinks = enabled and true or false
end

-------------------------------------------------------------------------------
-- Preset Management
-------------------------------------------------------------------------------
local presetListFrame

local function GetPresets()
    if not selectedProfession then return {} end
    TradeBarkerDB._presets = TradeBarkerDB._presets or {}
    TradeBarkerDB._presets[selectedProfession] = TradeBarkerDB._presets[selectedProfession] or {}
    return TradeBarkerDB._presets[selectedProfession]
end

local function GetCurrentSelections()
    local selections = {}
    local data = GetProfessionData()
    if not data then return selections end

    for _, group in ipairs(data) do
        for _, item in ipairs(group.items) do
            local key = GetItemKey(group.slot, item)
            if TradeBarkerDB[key] then
                selections[key] = true
            end
        end
    end
    return selections
end

local function SavePreset(name)
    if not selectedProfession then return end
    if not name or name == "" then
        print("|cffff6600[TradeBarker]|r Preset name cannot be empty!")
        return
    end

    local selections = GetCurrentSelections()
    if not next(selections) then
        print("|cffff6600[TradeBarker]|r No items selected to save!")
        return
    end

    local presets = GetPresets()
    table.insert(presets, {
        name = name,
        items = selections
    })

    print("|cff00ff00[TradeBarker]|r Preset '" .. name .. "' saved!")
    return true
end

local function LoadPreset(presetIndex)
    local presets = GetPresets()
    local preset = presets[presetIndex]
    if not preset then return end

    -- Clear all current selections
    local data = GetProfessionData()
    if data then
        for _, group in ipairs(data) do
            for _, item in ipairs(group.items) do
                local key = GetItemKey(group.slot, item)
                TradeBarkerDB[key] = false
            end
        end
    end

    -- Load preset selections
    for key, value in pairs(preset.items) do
        TradeBarkerDB[key] = value
    end

    -- Update UI
    for _, entry in ipairs(checkboxes) do
        entry.cb:SetChecked(TradeBarkerDB[entry.key] or false)
    end

    if previewBox then
        previewBox:SetText("")
    end
    UpdateCharCount()

    print("|cff00ff00[TradeBarker]|r Loaded preset: " .. preset.name)
end

local function QuickSendPreset(presetIndex)
    local presets = GetPresets()
    local preset = presets[presetIndex]
    if not preset then return end

    -- Temporarily load preset
    local originalSelections = GetCurrentSelections()

    -- Clear and load preset
    local data = GetProfessionData()
    if data then
        for _, group in ipairs(data) do
            for _, item in ipairs(group.items) do
                local key = GetItemKey(group.slot, item)
                TradeBarkerDB[key] = false
            end
        end
    end

    for key, value in pairs(preset.items) do
        TradeBarkerDB[key] = value
    end

    -- Send message
    SendToTrade()

    -- Restore original selections
    for _, group in ipairs(data) do
        for _, item in ipairs(group.items) do
            local key = GetItemKey(group.slot, item)
            TradeBarkerDB[key] = false
        end
    end

    for key, value in pairs(originalSelections) do
        TradeBarkerDB[key] = value
    end

    -- Update UI
    for _, entry in ipairs(checkboxes) do
        entry.cb:SetChecked(TradeBarkerDB[entry.key] or false)
    end
end

local function DeletePreset(presetIndex)
    local presets = GetPresets()
    local preset = presets[presetIndex]
    if not preset then return end

    print("|cffff6600[TradeBarker]|r Deleted preset: " .. preset.name)
    table.remove(presets, presetIndex)
end

local function RenamePreset(presetIndex, newName)
    if not newName or newName == "" then return end
    local presets = GetPresets()
    local preset = presets[presetIndex]
    if not preset then return end

    preset.name = newName
    print("|cff00ff00[TradeBarker]|r Preset renamed to: " .. newName)
end

local function MovePreset(presetIndex, direction)
    local presets = GetPresets()
    if direction == "up" and presetIndex > 1 then
        presets[presetIndex], presets[presetIndex - 1] = presets[presetIndex - 1], presets[presetIndex]
    elseif direction == "down" and presetIndex < #presets then
        presets[presetIndex], presets[presetIndex + 1] = presets[presetIndex + 1], presets[presetIndex]
    end
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

    local useLinks = UseSpellLinks()
    local parts = {}

    for _, group in ipairs(data) do
        local selected = {}
        for _, item in ipairs(group.items) do
            local key = GetItemKey(group.slot, item)
            if TradeBarkerDB[key] then
                local itemName = GetItemName(item)
                if useLinks then
                    local spellID = GetItemSpellID(item)
                    if spellID then
                        table.insert(selected, CreateSpellLink(spellID, itemName))
                    else
                        table.insert(selected, itemName)
                    end
                else
                    table.insert(selected, itemName)
                end
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
            local itemName = GetItemName(item)

            local cb = CreateFrame("CheckButton", nil, scrollChild, "UICheckButtonTemplate")
            cb:SetPoint("TOPLEFT", 6, -yOffset)
            cb:SetSize(22, 22)
            cb:SetChecked(TradeBarkerDB[key] or false)
            cb:SetScript("OnClick", function(self)
                TradeBarkerDB[key] = self:GetChecked() and true or false
            end)

            local label = cb:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            label:SetPoint("LEFT", cb, "RIGHT", 4, 0)
            label:SetText(itemName)

            table.insert(checkboxes, { cb = cb, key = key, label = label })
            yOffset = yOffset + 20
        end

        yOffset = yOffset + 8
    end

    scrollChild:SetHeight(yOffset)
end

-------------------------------------------------------------------------------
-- UI: Rebuild Preset List
-------------------------------------------------------------------------------
local function RebuildPresetList()
    if not presetListFrame then return end

    -- Clear existing preset rows
    if presetListFrame._rows then
        for _, row in ipairs(presetListFrame._rows) do
            row:Hide()
            row:SetParent(nil)
        end
    end
    presetListFrame._rows = {}

    local presets = GetPresets()
    local yOffset = 4

    for i, preset in ipairs(presets) do
        local row = CreateFrame("Frame", nil, presetListFrame, "BackdropTemplate")
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
            RenamePreset(i, self:GetText())
            self:ClearFocus()
            RebuildPresetList()
        end)

        -- Load button
        local loadBtn = CreateFlatButton(row, "Load", 45)
        loadBtn:SetHeight(20)
        loadBtn:SetPoint("LEFT", nameBox, "RIGHT", 2, 0)
        loadBtn:SetScript("OnClick", function()
            LoadPreset(i)
        end)

        -- Send button (quick send)
        local sendBtn = CreateFlatButton(row, "Send", 45)
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
            QuickSendPreset(i)
        end)

        -- Delete button
        local delBtn = CreateFlatButton(row, "Del", 30)
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
            DeletePreset(i)
            RebuildPresetList()
        end)

        -- Up button
        local upBtn = CreateFlatButton(row, "↑", 20)
        upBtn:SetHeight(20)
        upBtn:SetPoint("LEFT", delBtn, "RIGHT", 2, 0)
        if i == 1 then
            upBtn:SetAlpha(0.3)
            upBtn:Disable()
        end
        upBtn:SetScript("OnClick", function()
            MovePreset(i, "up")
            RebuildPresetList()
        end)

        -- Down button
        local downBtn = CreateFlatButton(row, "↓", 20)
        downBtn:SetHeight(20)
        downBtn:SetPoint("LEFT", upBtn, "RIGHT", 2, 0)
        if i == #presets then
            downBtn:SetAlpha(0.3)
            downBtn:Disable()
        end
        downBtn:SetScript("OnClick", function()
            MovePreset(i, "down")
            RebuildPresetList()
        end)

        table.insert(presetListFrame._rows, row)
        yOffset = yOffset + 26
    end

    presetListFrame:SetHeight(math.max(60, yOffset))
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
        RebuildPresetList()
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
            RebuildPresetList()
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
    RebuildPresetList()
    if templateBox then
        templateBox:SetText(GetTemplate())
    end
end

-------------------------------------------------------------------------------
-- UI Creation
-------------------------------------------------------------------------------
local function CreateMainFrame()
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
    noProfsText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    noProfsText:SetPoint("CENTER", 0, 20)
    noProfsText:SetText("|cff666666No supported professions detected.|r\n|cff444444Enchanting, Alchemy, Jewelcrafting, Blacksmithing, Leatherworking|r")
    noProfsText:Hide()

    -- Template section
    local templateHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    templateHeader:SetPoint("TOPLEFT", 10, -62)
    templateHeader:SetText("|cff8899aaTemplate|r")

    -- Spell Links checkbox
    local spellLinksCB = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
    spellLinksCB:SetPoint("TOPLEFT", 80, -60)
    spellLinksCB:SetSize(20, 20)
    spellLinksCB:SetChecked(UseSpellLinks())
    spellLinksCB:SetScript("OnClick", function(self)
        SetUseSpellLinks(self:GetChecked())
        -- Clear preview when toggling so user re-previews with new format
        if previewBox then
            previewBox:SetText("")
        end
        UpdateCharCount()
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

    -- Presets section
    local presetsHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    presetsHeader:SetPoint("TOPLEFT", 10, -198)
    presetsHeader:SetText("|cff8899aaPresets|r")

    local savePresetBtn = CreateFlatButton(f, "Save Current", 80)
    savePresetBtn:SetHeight(18)
    savePresetBtn:SetPoint("LEFT", presetsHeader, "RIGHT", 8, 0)
    savePresetBtn:SetScript("OnClick", function()
        -- Create a simple input dialog
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

        local inputPanel = CreatePanel(dialog, nil)
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
            if SavePreset(name) then
                RebuildPresetList()
                dialog:Hide()
            end
        end)

        local okBtn = CreateFlatButton(dialog, "Save", 80)
        okBtn:SetPoint("BOTTOM", 40, 10)
        okBtn:SetScript("OnClick", function()
            local name = input:GetText()
            if SavePreset(name) then
                RebuildPresetList()
                dialog:Hide()
            end
        end)

        local cancelBtn = CreateFlatButton(dialog, "Cancel", 80)
        cancelBtn:SetPoint("BOTTOM", -40, 10)
        cancelBtn:SetScript("OnClick", function()
            dialog:Hide()
        end)

        dialog:Show()
    end)

    local presetsPanel = CreatePanel(f, nil)
    presetsPanel:SetPoint("TOPLEFT", 8, -214)
    presetsPanel:SetPoint("RIGHT", -8, 0)
    presetsPanel:SetHeight(120)

    presetListFrame = CreateFrame("Frame", nil, presetsPanel)
    presetListFrame:SetPoint("TOPLEFT", 4, -4)
    presetListFrame:SetPoint("BOTTOMRIGHT", -4, 4)
    presetListFrame._rows = {}

    -- Checklist scroll area
    local listPanel = CreatePanel(f, nil)
    listPanel:SetPoint("TOPLEFT", 8, -340)
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
