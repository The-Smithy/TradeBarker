# TradeBarker Technical Documentation

## Project Overview

TradeBarker is a World of Warcraft TBC Classic addon that helps crafters advertise their profession services in Trade chat. It generates formatted messages from selected crafting items and supports both plain text and clickable spell links.

**Target Environment:** World of Warcraft TBC Classic (Interface: 20505)
**Language:** Lua with WoW API
**Main File:** TradeBarker.lua
**Slash Commands:** `/tb`, `/tradebarker`

---

## Architecture

### Core Components

1. **Profession Data System** - Static data structure containing all craftable items with spell IDs
2. **UI Framework** - Custom frame-based UI with tabs, checkboxes, and preview
3. **Message Builder** - Constructs trade chat messages from selections
4. **Storage System** - Persistent per-character saved variables
5. **Spell Link System** - Converts text to clickable WoW spell links

### Data Flow

```
User Selection → BuildItemsString() → RenderTemplate() → BuildMessage() → SendToTrade()
                                                                        ↓
                                                                   Preview Display
```

---

## Data Structures

### Profession Data Format

```lua
PROFESSION_DATA = {
    [ProfessionName] = {
        {
            slot = "Category Name",
            items = {
                { name = "Item Name", spellID = 12345 },  -- New format with spell link
                "Item Name"                                -- Legacy format (text only)
            }
        }
    }
}
```

**Supported Professions:**
- Enchanting
- Alchemy
- Jewelcrafting
- Blacksmithing
- Leatherworking

### Saved Variables (TradeBarkerDB)

```lua
TradeBarkerDB = {
    -- Item selections (key: "slot:itemname", value: boolean)
    ["Weapon:Mongoose"] = true,
    ["Boots:Cat's Swiftness"] = false,

    -- Internal settings
    _profession = "Enchanting",              -- Last selected profession
    _useSpellLinks = true,                   -- Spell links toggle state
    _templates = {                           -- Per-profession custom templates
        Enchanting = "Custom template...",
        Alchemy = "Another template..."
    },
    _presets = {                             -- Per-profession saved presets
        Enchanting = {
            {
                name = "Raid Enchants",
                items = {
                    ["Weapon:Mongoose"] = true,
                    ["Boots:Cat's Swiftness"] = true
                }
            },
            {
                name = "Budget Options",
                items = { ... }
            }
        }
    }
}
```

---

## Key Functions

### Helper Functions

#### `GetItemKey(slot, item)`
Generates storage key for an item selection.
```lua
-- Returns: "slot:itemname"
-- Handles both string and table item formats
```

#### `GetItemName(item)` / `GetItemSpellID(item)`
Extract name or spellID from item data (supports both formats).

#### `CreateSpellLink(spellID, name)`
Generates WoW spell link format: `|cff71d5ff|Hspell:ID|h[Name]|h|r`

#### `UseSpellLinks()` / `SetUseSpellLinks(enabled)`
Get/set spell links preference from saved variables.

### Preset Management

#### `GetPresets()`
Returns the preset array for the current profession.

#### `GetCurrentSelections()`
Captures all currently selected items and returns them as a table.

#### `SavePreset(name)`
Saves current selections as a new preset with the given name.
- Validates name is not empty
- Validates at least one item is selected
- Adds preset to end of list

#### `LoadPreset(presetIndex)`
Loads a preset's selections:
1. Clears all current selections
2. Applies preset selections
3. Updates UI checkboxes
4. Clears preview

#### `QuickSendPreset(presetIndex)`
Sends a preset directly to Trade chat without loading it:
1. Saves current selections
2. Temporarily loads preset
3. Sends message to trade
4. Restores original selections
5. Updates UI

**Use case:** Cycle through multiple advertising strategies without disrupting current UI state.

#### `DeletePreset(presetIndex)`
Removes a preset from the list.

#### `RenamePreset(presetIndex, newName)`
Changes a preset's name.

#### `MovePreset(presetIndex, direction)`
Moves preset up or down in the list.
- `direction`: "up" or "down"
- Swaps positions with adjacent preset

#### `RebuildPresetList()`
Regenerates the preset UI:
- Destroys existing preset rows
- Creates new rows for each preset
- Each row contains: name field, Load, Send, Del, ↑, ↓ buttons
- Disables up/down buttons at list boundaries

### Message Building

#### `BuildItemsString()`
**Purpose:** Constructs the `{items}` portion of the message.

**Logic:**
1. Iterate through profession data
2. For each group (slot), collect selected items
3. Apply spell links if enabled
4. Format: `"Slot: item1, item2 | Slot: item3, item4"`

**Returns:** String or nil if no items selected

#### `RenderTemplate(template, profName, itemsStr)`
Replaces `{profession}` and `{items}` placeholders in template.

#### `BuildMessage()`
Combines `BuildItemsString()` + `RenderTemplate()` for final message.

#### `SplitMessage(msg, maxLen)`
Splits messages exceeding 255 characters into multiple parts.
- Preserves template prefix/suffix
- Splits on `" | "` boundaries
- Returns array of messages

### UI Functions

#### `RebuildCheckboxes()`
Dynamically generates checkboxes for current profession:
1. Clears existing checkboxes
2. Reads profession data
3. Creates header + checkboxes for each slot/item
4. Binds to saved variables

#### `RebuildTabs()`
Detects character professions and creates profession tabs.
- Only shows tabs for learned professions
- Auto-selects first profession if none selected
- Restores last selected profession from saved variables

#### `UpdateTabHighlights()`
Visual feedback for selected profession tab.

#### `DetectProfessions()`
Scans character skill lines using `GetNumSkillLines()` and `GetSkillLineInfo()`.

---

## UI Layout

```
┌─────────────────────────────────────────┐
│ TradeBarker                          [X]│  ← Title bar
├─────────────────────────────────────────┤
│ [Enchanting] [Alchemy] [Jewelcrafting] │  ← Profession tabs
├─────────────────────────────────────────┤
│ Template: [✓] Use Spell Links  0/255   │  ← Template header
│ ┌─────────────────────────────────┐ [R]│
│ │ LFW {profession}! | {items} | PST│ [e]│  ← Template editor + Reset
│ └─────────────────────────────────┘ [s]│
│                                     [e]│
│ Preview:                            [t]│
│ ┌─────────────────────────────────────┐│
│ │ (message preview appears here)      ││  ← Message preview
│ └─────────────────────────────────────┘│
├─────────────────────────────────────────┤
│ Presets: [Save Current]                 │  ← Presets header
│ ┌─────────────────────────────────────┐│
│ │Raid Enchants [Load][Send][Del][↑][↓]││  ← Preset rows
│ │Budget Options[Load][Send][Del][↑][↓]││
│ │Premium Gems  [Load][Send][Del][↑][↓]││
│ └─────────────────────────────────────┘│
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐│
│ │ WEAPON                              ││
│ │ ☐ Mongoose                          ││  ← Scrollable checklist
│ │ ☐ Executioner                       ││
│ │ BOOTS                               ││
│ │ ☐ Cat's Swiftness                   ││
│ └─────────────────────────────────────┘│
├─────────────────────────────────────────┤
│[Select All][Deselect All][Preview][Send]│  ← Action buttons
└─────────────────────────────────────────┘
```

---

## Spell Link System

### How It Works

1. **Data Storage:** Each item can have optional `spellID` field
2. **Toggle State:** User enables "Use Spell Links" checkbox
3. **Link Generation:** `CreateSpellLink()` formats spell link escape sequences
4. **Message Building:** `BuildItemsString()` conditionally uses links vs plain text

### Spell Link Format

WoW uses special escape sequences for clickable links:
```lua
"|cff71d5ff|Hspell:27984|h[Mongoose]|h|r"
-- |c = color start
-- ff71d5ff = RGBA color (light blue)
-- |H = hyperlink start
-- spell:27984 = link type and spell ID
-- |h = hyperlink text start
-- [Mongoose] = display text
-- |h = hyperlink text end
-- |r = reset formatting
```

### Finding Spell IDs

Use this macro to extract spell IDs from the spellbook:
```lua
/run local n=GameTooltip:GetSpell() if n then local _,id=GetSpellLink(n):match("spell:(%d+)") print(n,id) end
```

**Process:**
1. Hover over spell in profession window
2. Macro prints: "Mongoose 27984"
3. Add to data: `{ name = "Mongoose", spellID = 27984 }`

---

## Message Templates

### Placeholder System

- `{profession}` - Replaced with profession name (e.g., "Enchanting")
- `{items}` - Replaced with generated item list (required)

### Default Template
```lua
"LFW {profession}! | {items} | PST!"
```

### Custom Templates
Stored per-profession in `TradeBarkerDB._templates`.
Reset to default by setting value to `nil`.

### Validation
Template must contain `{items}` placeholder or will be rejected.

---

## Event Handling

### ADDON_LOADED
- Initializes `TradeBarkerDB`
- Restores selected profession
- Creates main UI frame
- Attempts initial profession detection

### SKILL_LINES_CHANGED
- Re-scans character professions
- Rebuilds profession tabs
- Handles learning new professions

---

## Character Limit Handling

WoW Trade chat has a 255-character limit.

### Auto-Split Logic

1. Calculate full message length
2. If ≤ 255 chars, send as single message
3. If > 255 chars:
   - Extract template prefix/suffix
   - Split items list on `" | "` boundaries
   - Build multiple messages, each ≤ 255 chars
   - Preserve prefix/suffix in each part

### Character Counter
- Green: 1-255 characters (valid)
- Red: > 255 characters (will be split)
- Gray: 0 characters (no selection)

---

## Extension Points

### Adding New Professions

1. Add profession data to `PROFESSION_DATA`:
```lua
NewProfession = {
    {
        slot = "Category",
        items = {
            { name = "Item", spellID = 12345 }
        }
    }
}
```

2. Profession will auto-detect if character has learned it

### Adding New Items

Add to appropriate slot in profession data:
```lua
items = {
    { name = "New Enchant", spellID = 99999 }
}
```

### Custom Templates

Users can create per-profession templates via UI.
No code changes needed.

---

## UI Customization

### Frame Styling

All UI elements use consistent backdrop styling:
```lua
backdrop = {
    bgFile = "Interface\\Buttons\\WHITE8x8",
    edgeFile = "Interface\\Buttons\\WHITE8x8",
    edgeSize = 1,
    insets = { left = 1, right = 1, top = 1, bottom = 1 }
}
```

Colors follow a dark theme:
- Background: `(0.06, 0.06, 0.08, 0.95)`
- Borders: `(0.3, 0.3, 0.3, 0.8)`
- Accents: Blue/cyan for highlights

### Button Creation

`CreateFlatButton(parent, text, width)` - Standardized button factory with hover effects.

---

## Performance Considerations

- **Profession Detection:** Cached in `detectedProfessions` table
- **Checkbox Creation:** Destroyed and rebuilt on profession switch (acceptable for small lists)
- **Message Building:** Performed on-demand (preview/send), not continuously
- **Saved Variables:** Only writes on change, not every frame

---

## Known Limitations

1. **Max Message Length:** 255 characters (WoW API limitation)
2. **Profession Detection:** Requires skill lines to be loaded (may need `/reload` after learning new profession)
3. **Spell ID Accuracy:** Some spell IDs may vary between TBC versions (Anniversary vs Original)
4. **Trade Channel:** Only works in cities with Trade channel access

---

## Testing Checklist

### Functionality
- [ ] Profession detection works for all 5 professions
- [ ] Checkboxes persist between sessions
- [ ] Template editing and reset work
- [ ] Spell links toggle works
- [ ] Preview shows correct output
- [ ] Messages send to Trade channel
- [ ] Long messages split correctly
- [ ] Character counter updates

### Presets
- [ ] Save Current creates new preset with dialog
- [ ] Load preset replaces current selections
- [ ] Quick Send preserves current selections
- [ ] Delete preset removes it from list
- [ ] Rename preset updates name on Enter
- [ ] Up/Down buttons reorder presets
- [ ] Presets are per-profession
- [ ] Presets persist between sessions
- [ ] Empty name validation works
- [ ] No-items-selected validation works

### UI
- [ ] Frame is draggable
- [ ] Tabs switch professions correctly
- [ ] Scroll area works for long lists
- [ ] Select All / Deselect All work
- [ ] Tooltips display correctly

### Edge Cases
- [ ] No professions learned (shows warning)
- [ ] Empty selection (shows error on send)
- [ ] Template without {items} (rejected)
- [ ] Not in city (error message)
- [ ] Character at exactly 255 chars

---

## Future Enhancement Ideas

- Support for other professions (Cooking, Fishing, etc.)
- Macro integration for faster posting
- Cooldown timer for trade spam protection
- Import/export item selections
- Multi-profession messages (combine multiple professions)
- Sound notifications
- Integration with guild recruitment channels
- Support for custom channel selection

---

## File Structure

```
TradeBarker/
├── TradeBarker.lua      # Main addon code (~1000 lines)
├── TradeBarker.toc      # Addon manifest
├── README.md            # User documentation
└── CLAUDE.md            # This technical documentation
```

---

## Version History

- **1.1.0** - Presets system (current)
  - Save, name, and manage multiple item selection presets
  - Quick Send feature for cycling through presets
  - Reorderable preset list with inline renaming
  - Per-character, per-profession preset storage

- **1.0.0** - Initial release with spell link support for all 5 professions
  - Enchanting, Alchemy, Jewelcrafting, Blacksmithing, Leatherworking
  - Spell link toggle
  - Template customization
  - Auto-split long messages
  - Per-character saved variables

---

## Debugging Tips

### Enable Lua Errors
```
/console scriptErrors 1
```

### Check Saved Variables
```lua
/run print(TradeBarkerDB._profession)
/run print(TradeBarkerDB["Weapon:Mongoose"])
```

### Test Message Building
```lua
/run print(BuildMessage())  -- Won't work (local function)
-- Use Preview button instead
```

### Verify Spell Links
Toggle "Use Spell Links" on/off and compare preview output.

---

## Contact & Support

**Author:** Tidalz - US Nightslayer
**Issues:** Report bugs or request features in the project repository
**WoW API Reference:** https://wowpedia.fandom.com/wiki/World_of_Warcraft_API

---

*Last Updated: 2026-02-10*
