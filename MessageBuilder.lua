-- TradeBarker: Message Building and Sending
-- Handles message construction and Trade chat posting

-- Namespace
TradeBarker = TradeBarker or {}
local TB = TradeBarker

-------------------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------------------
local function EscapeForChat(msg)
    -- Escape bare | that are NOT part of a recognized WoW escape sequence,
    -- while leaving spell/item hyperlinks and color codes intact so they
    -- remain clickable in trade chat.
    -- WoW renders "||" as a literal "|" in chat.
    -- Valid escape starters after |: c r H h T t A a K k n |
    msg = msg:gsub("|([^crHhTtAaKkn|])", "||%1")
    return msg
end

-------------------------------------------------------------------------------
-- Message Building
-------------------------------------------------------------------------------
function TB.BuildItemsString()
    local data = TB.GetProfessionData()
    if not data then return nil end

    local useLinks = TB.UseSpellLinks()
    local parts = {}

    for _, group in ipairs(data) do
        local selected = {}
        for _, item in ipairs(group.items) do
            local key = TB.GetItemKey(group.slot, item)
            if TradeBarkerDB[key] then
                local itemName = TB.GetItemName(item)
                if useLinks then
                    local spellID = TB.GetItemSpellID(item)
                    if spellID then
                        table.insert(selected, TB.CreateSpellLink(spellID, itemName))
                    else
                        table.insert(selected, itemName)
                    end
                else
                    table.insert(selected, itemName)
                end
            end
        end
        if #selected > 0 then
            table.insert(parts, table.concat(selected, ", "))
        end
    end

    if #parts == 0 then
        return nil
    end

    return table.concat(parts, " | ")
end

function TB.BuildMessage()
    if not TB.selectedProfession then
        TB.Debug("BuildMessage: selectedProfession is nil")
        return nil
    end
    local template = TB.GetTemplate()
    local itemsStr = TB.BuildItemsString() or ""
    TB.Debug("BuildMessage: template=" .. template)
    TB.Debug("BuildMessage: items=" .. itemsStr)
    local msg = TB.RenderTemplate(template, TB.selectedProfession, itemsStr)
    -- Return nil only if the rendered message is empty
    return msg ~= "" and msg or nil
end

function TB.UpdateCharCount()
    if not TB.charCountText then return end
    local msg = TB.BuildMessage()
    local len = msg and #msg or 0
    if len == 0 then
        TB.charCountText:SetText("|cff5555550 / " .. TB.MAX_CHAT_LENGTH .. "|r")
    elseif len > TB.MAX_CHAT_LENGTH then
        TB.charCountText:SetText("|cffff4444" .. len .. " / " .. TB.MAX_CHAT_LENGTH .. "|r")
    else
        TB.charCountText:SetText("|cff88aa88" .. len .. " / " .. TB.MAX_CHAT_LENGTH .. "|r")
    end
end

-------------------------------------------------------------------------------
-- Message Splitting
-------------------------------------------------------------------------------
function TB.SplitMessage(msg, maxLen)
    if #msg <= maxLen then
        return { msg }
    end

    -- Derive prefix/suffix by rendering template with empty items
    local template = TB.GetTemplate()
    local emptyRender = TB.RenderTemplate(template, TB.selectedProfession, "")
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
        local itemsStr = TB.BuildItemsString()
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
    local itemsStr = TB.BuildItemsString()
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

-------------------------------------------------------------------------------
-- Sending to Trade
-------------------------------------------------------------------------------
function TB.SendToTrade()
    local msg = TB.BuildMessage()
    if not msg then
        print("|cffff6600[TradeBarker]|r No message to send! (profession=" .. tostring(TB.selectedProfession) .. ")")
        return
    end

    local messages = TB.SplitMessage(msg, TB.MAX_CHAT_LENGTH)
    TB.Debug("SendToTrade: " .. #messages .. " part(s)")
    for i, m in ipairs(messages) do
        local stripped = EscapeForChat(m)
        TB.Debug("SendToTrade[" .. i .. "] len=" .. #stripped .. ": " .. stripped)
        if #stripped > TB.MAX_CHAT_LENGTH then
            print("|cffff6600[TradeBarker]|r Message part too long (" .. #stripped .. "/" .. TB.MAX_CHAT_LENGTH .. " chars). Deselect some items!")
            return
        end
        SendChatMessage(stripped, "CHANNEL", nil, 2)
    end
    print("|cff00ff00[TradeBarker]|r Message sent to Trade! (" .. #messages .. " message(s))")
end
