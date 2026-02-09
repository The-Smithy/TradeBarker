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
