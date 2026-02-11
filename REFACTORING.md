

# TradeBarker Refactoring Guide

## Overview

TradeBarker has been refactored from a single 1400+ line file into a modular architecture with 6 separate files. This improves maintainability, readability, and makes it easier for multiple developers to work on different features simultaneously.

---

## File Structure

```
TradeBarker/
├── Core.lua              # Core utilities and state (200 lines)
├── ProfessionData.lua    # Profession data tables (350 lines)
├── Presets.lua           # Preset management (160 lines)
├── MessageBuilder.lua    # Message building and sending (160 lines)
├── UI.lua               # All UI creation and management (650 lines)
├── TradeBarker-New.lua  # Main entry point and events (50 lines)
└── TradeBarker.toc      # Addon manifest
```

**Total: ~1570 lines** (old: 1433 lines - the increase is due to better organization and comments)

---

## Module Breakdown

### 1. Core.lua
**Purpose:** Core state management and utility functions

**Contents:**
- Constants (`DEFAULT_TEMPLATE`, `MAX_CHAT_LENGTH`)
- State variables (`selectedProfession`, `detectedProfessions`, UI references)
- Item helper functions (`GetItemKey`, `GetItemName`, `GetItemSpellID`)
- Spell link creation (`CreateSpellLink`)
- Settings management (`UseSpellLinks`, `SetUseSpellLinks`)
- Template functions (`GetTemplate`, `SetTemplate`, `RenderTemplate`)
- Profession detection (`DetectProfessions`)
- UI helpers (`CreatePanel`, `CreateFlatButton`)

**Namespace:** All functions are exposed as `TB.FunctionName()`

---

### 2. ProfessionData.lua
**Purpose:** Contains all crafting data for 5 professions

**Contents:**
- `TB.PROFESSION_DATA` table with spell IDs
- Enchanting (all slots)
- Alchemy (flasks, elixirs, potions, transmutes)
- Jewelcrafting (all gem colors)
- Blacksmithing (weapons, armor, stones)
- Leatherworking (drums, armor, kits)

**Data Structure:**
```lua
TB.PROFESSION_DATA = {
    [ProfessionName] = {
        {
            slot = "Category",
            items = {
                { name = "Item", spellID = 12345 }
            }
        }
    }
}
```

---

### 3. Presets.lua
**Purpose:** Preset management system

**Functions:**
- `TB.GetPresets()` - Returns preset array for current profession
- `TB.GetCurrentSelections()` - Captures all selected items
- `TB.SavePreset(name)` - Saves current selections as preset
- `TB.LoadPreset(index)` - Loads preset into UI
- `TB.QuickSendPreset(index)` - Sends preset without loading
- `TB.DeletePreset(index)` - Removes preset
- `TB.RenamePreset(index, name)` - Changes preset name
- `TB.MovePreset(index, direction)` - Reorders presets

**Dependencies:** Core.lua, MessageBuilder.lua

---

### 4. MessageBuilder.lua
**Purpose:** Message construction and Trade chat posting

**Functions:**
- `TB.BuildItemsString()` - Constructs {items} portion
- `TB.BuildMessage()` - Full message with template
- `TB.UpdateCharCount()` - Updates character counter UI
- `TB.SplitMessage(msg, maxLen)` - Splits long messages
- `TB.SendToTrade()` - Posts to Trade channel

**Dependencies:** Core.lua

---

### 5. UI.lua
**Purpose:** All UI creation and management (largest file)

**Functions:**

#### UI Updates
- `TB.RebuildCheckboxes()` - Regenerates item checklist
- `TB.RebuildPresetList()` - Regenerates preset rows
- `TB.UpdateTabHighlights()` - Updates profession tab styling
- `TB.RebuildTabs()` - Creates profession tabs

#### UI Creation
- `TB.CreateMainFrame()` - Main window
- `TB.CreateTemplateSection()` - Template editor area
- `TB.CreatePreviewSection()` - Message preview area with Preview and Send to Trade buttons
- `TB.CreatePresetsSection()` - Presets list area
- `TB.CreateChecklistSection()` - Scrollable checklist
- `TB.CreateActionButtons()` - Bottom buttons (Select All, Deselect All)
- `TB.ShowSavePresetDialog()` - Preset name input dialog

**Dependencies:** All other modules

---

### 6. TradeBarker-New.lua
**Purpose:** Main entry point, initialization, events

**Contents:**
- SavedVariables initialization
- Event handling (`ADDON_LOADED`, `SKILL_LINES_CHANGED`)
- Slash commands (`/tb`, `/tradebarker`)

**Dependencies:** All other modules

---

## Namespace Pattern

All code uses the `TradeBarker` global namespace (aliased as `TB`):

```lua
-- File header (every file)
TradeBarker = TradeBarker or {}
local TB = TradeBarker

-- Define functions
function TB.MyFunction()
    -- ...
end

-- Use functions
TB.MyFunction()
```

This ensures:
- No global pollution
- All functions are organized under one namespace
- Easy to find where functions are defined
- Prevents naming conflicts

---

## Load Order

The .toc file specifies load order (critical!):

1. **Core.lua** - Must load first (namespace, utilities)
2. **ProfessionData.lua** - Data tables
3. **Presets.lua** - Preset functions (depends on Core)
4. **MessageBuilder.lua** - Message functions (depends on Core)
5. **UI.lua** - UI functions (depends on all above)
6. **TradeBarker-New.lua** - Initialization (depends on all above)

**Important:** If you change load order, the addon may break!

---

## Migration from Old Structure

### Old File
```lua
-- TradeBarker.lua (1433 lines)
- Profession data
- All functions
- UI creation
- Events
```

### New Structure
```
Core.lua           - Core functions
ProfessionData.lua - Data only
Presets.lua        - Preset management
MessageBuilder.lua - Message building
UI.lua             - UI management
TradeBarker-New.lua- Initialization
```

---

## Benefits

### 1. **Modularity**
- Each file has a single responsibility
- Easy to find specific functionality
- Changes to UI don't affect message building

### 2. **Maintainability**
- Smaller files are easier to understand
- Clear separation of concerns
- Better code organization

### 3. **Collaboration**
- Multiple developers can work on different modules
- Less merge conflicts
- Easier code reviews

### 4. **Testing**
- Can test individual modules
- Mock dependencies easily
- Isolate bugs faster

### 5. **Performance**
- No performance impact (WoW loads all files anyway)
- Same runtime behavior as monolithic version
- Better memory organization

---

## Adding New Features

### Example: Add New Profession

1. **ProfessionData.lua** - Add profession data
```lua
TB.PROFESSION_DATA.Cooking = {
    { slot = "Foods", items = {...} }
}
```

2. **Done!** - The rest of the system handles it automatically

### Example: Add New UI Section

1. **UI.lua** - Create new section function
```lua
function TB.CreateMyNewSection(f)
    -- UI code here
end
```

2. **UI.lua** - Call from `CreateMainFrame()`
```lua
function TB.CreateMainFrame()
    -- ... existing code ...
    TB.CreateMyNewSection(f)
end
```

### Example: Add New Message Feature

1. **MessageBuilder.lua** - Add new function
```lua
function TB.MyMessageFeature()
    -- Logic here
end
```

2. **Use it** - Call from wherever needed
```lua
TB.MyMessageFeature()
```

---

## Debugging

### Check Load Order
```lua
/run print("Core loaded:", TradeBarker.GetItemKey ~= nil)
/run print("Data loaded:", TradeBarker.PROFESSION_DATA ~= nil)
/run print("UI loaded:", TradeBarker.CreateMainFrame ~= nil)
```

### Check Namespace
```lua
/run for k,v in pairs(TradeBarker) do print(k) end
```

### Verify Functions
```lua
/run print(type(TradeBarker.BuildMessage)) -- should be "function"
```

---

## Best Practices

### 1. **Always Use Namespace**
✅ Good:
```lua
function TB.MyFunction()
    TB.OtherFunction()
end
```

❌ Bad:
```lua
function MyFunction()  -- Global pollution!
    OtherFunction()
end
```

### 2. **Keep Files Focused**
- Core.lua = utilities only
- UI.lua = UI only
- Don't mix concerns

### 3. **Document Dependencies**
Add comment at top of each file:
```lua
-- Dependencies: Core.lua, MessageBuilder.lua
```

### 4. **Use Descriptive Names**
✅ `TB.RebuildPresetList()`
❌ `TB.RPL()`

---

## Compatibility

### Backward Compatibility
- SavedVariables format unchanged
- User data migrates automatically
- No /reload required

### Forward Compatibility
- Easy to add new modules
- Can split files further if needed
- Namespace makes expansion simple

---

## File Sizes

| File | Lines | Purpose |
|------|-------|---------|
| Core.lua | ~200 | Utilities |
| ProfessionData.lua | ~350 | Data |
| Presets.lua | ~160 | Presets |
| MessageBuilder.lua | ~160 | Messages |
| UI.lua | ~650 | UI |
| TradeBarker-New.lua | ~50 | Init |
| **Total** | **~1570** | All |

---

## Testing Checklist

After refactoring:
- [ ] Addon loads without errors
- [ ] All professions detected
- [ ] Checkboxes work
- [ ] Preview generates
- [ ] Send to Trade works
- [ ] Presets save/load
- [ ] Quick Send preserves selections
- [ ] Spell links toggle works
- [ ] Template editing works
- [ ] Tabs switch correctly

---

## Rollback Plan

If issues occur, you can revert to monolithic:

1. **TradeBarker.toc:**
```
TradeBarker.lua  # Old file
```

2. Keep new files for reference
3. Merge improvements back into monolith later

---

## Future Improvements

Possible additional splits:

1. **TabManagement.lua** - Profession tab logic
2. **CheckboxManagement.lua** - Checklist logic
3. **DialogsLua** - All popup dialogs
4. **Validation.lua** - Input validation
5. **Constants.lua** - All constants

---

## Summary

The refactored architecture:
- ✅ Same functionality as before
- ✅ Better organized code
- ✅ Easier to maintain
- ✅ Easier to extend
- ✅ Better collaboration
- ✅ No performance cost
- ✅ Backward compatible

**Result:** A professional, maintainable codebase ready for future growth!
