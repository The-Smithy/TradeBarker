# TradeBarker

A World of Warcraft TBC Classic addon that helps crafters advertise their profession services in Trade chat.

## Supported Professions

- **Enchanting** - Weapon, 2H Weapon, Chest, Cloak, Boots, Gloves, Bracer, Shield, Ring enchants
- **Alchemy** - Flasks, Elixirs, Potions, Transmutes
- **Jewelcrafting** - Meta, Red, Blue, Yellow, Orange, Green, and Purple gem cuts
- **Blacksmithing** - Weapons, Plate Armor, Mail Armor, Sharpening/Weightstones
- **Leatherworking** - Drums, Leg Armor, Armor Kits, Leather Armor, Mail Armor

## Features

- **Profession Tabs** - Switch between professions using tabs at the top of the window
- **Item Selection** - Pick which items/services you want to advertise from a categorized checklist
- **Presets** - Save, name, and quick-send predefined item selections (NEW!)
- **Spell Links** - Toggle between plain text and clickable spell links in trade chat
- **Message Preview** - Preview your generated Trade chat message before sending
- **Character Counter** - Live counter shows message length vs the 255-character trade chat limit
- **Auto-Split** - Automatically splits long messages into multiple parts to stay within the limit
- **Message Templates** - Customize the message format per-profession using `{profession}` and `{items}` placeholders
- **Saved Selections** - Your selections are saved per-character between sessions (including last selected profession and templates)
- **Draggable UI** - Move the window anywhere on screen

## Usage

Type `/tb` or `/tradebarker` to open the addon window.

1. Select a profession tab (only your character's professions are shown)
2. Check the items/services you can craft and want to advertise
3. Click **Preview** to see the generated message
4. Click **Send to Trade** to post to Trade chat (you must be in a city)

Use **Select All** / **Deselect All** to quickly toggle all items for the current profession.

## Presets

Presets allow you to save frequently-used item selections for quick access. Perfect for managing different advertising strategies (e.g., "Raid Enchants", "Budget Options", "Popular Gems").

### Creating Presets

1. Select the items you want to include
2. Click **Save Current** in the Presets section
3. Enter a name for your preset
4. Click **Save**

### Using Presets

Each preset row has several buttons:

- **Load** - Loads the preset's selections into the UI (replaces current selections)
- **Send** - Instantly sends the preset to Trade chat without loading it (preserves current selections)
- **Del** - Deletes the preset
- **↑/↓** - Reorders presets in the list
- **Name field** - Click to rename the preset (press Enter to save)

### Quick Send

The **Send** button is particularly useful for cycling through multiple advertising strategies without changing your current selections. For example:
1. Keep your main setup loaded
2. Quickly send "Budget Enchants" preset
3. Wait a few minutes
4. Quickly send "Premium Enchants" preset
5. Your original selections remain unchanged

Presets are saved per-character and per-profession.

## Spell Links

Enable **"Use Spell Links"** checkbox (below the Template header) to post clickable spell links instead of plain text. When people click these links in trade chat, they'll see the actual crafting spell with mats and details.

**Example:**
- Without Spell Links: `LFW Enchanting! | Weapon: Mongoose, Executioner | PST!`
- With Spell Links: `LFW Enchanting! | Weapon: [Mongoose], [Executioner] | PST!` (clickable links)

### Adding Spell IDs

Spell IDs are included for all professions (Enchanting, Alchemy, Jewelcrafting, Blacksmithing, and Leatherworking). To add missing ones or update incorrect IDs:

1. Create this macro:
```
/run local n=GameTooltip:GetSpell() if n then local _,id=GetSpellLink(n):match("spell:(%d+)") print(n,id) end
```

2. Hover over the spell in your profession window with the macro's tooltip active
3. The spell name and ID will print to your chat
4. Edit [TradeBarker.lua](TradeBarker.lua) and add the `spellID` to the item:
```lua
{ name = "Mongoose", spellID = 27984 }
```

## Message Templates

The message format is customizable via the **Template** field at the top of the window. Each profession can have its own template. Use these placeholders:

- `{profession}` — replaced with the profession name (e.g. "Enchanting")
- `{items}` — replaced with the auto-generated item list (required)

**Default template:**
```
LFW {profession}! | {items} | PST!
```

**Example outputs:**
```
LFW Enchanting! | Weapon: Mongoose, Executioner | Boots: Cat's Swiftness | PST!
LFW Alchemy! | Flasks: Flask of Fortification | Transmutes: Primal Might | PST!
```

**Custom template example:**
```
WTS {profession} services! {items} -- whisper me!
```

Click **Reset** to restore the default template.

## Installation

Copy the `TradeBarker` folder into your WoW AddOns directory:

```
World of Warcraft/_anniversary_/Interface/AddOns/TradeBarker/
```

## Author

Tidalz - US Nightslayer
