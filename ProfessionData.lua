-- TradeBarker: Profession Data
-- All profession data with spell IDs for TBC Classic
--
-- To find spell IDs: hover over the spell in your spellbook with this macro:
--   /run local n=GameTooltip:GetSpell() if n then local _,id=GetSpellLink(n):match("spell:(%d+)") print(n,id) end

-- Namespace
TradeBarker = TradeBarker or {}
local TB = TradeBarker

-------------------------------------------------------------------------------
-- Profession Data (TBC Classic)
-------------------------------------------------------------------------------
TB.PROFESSION_DATA = {
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
                { name = "Black Planar Edge", spellID = 36128 },
                { name = "Wicked Edge of the Planes", spellID = 36126 },
                { name = "Fireguard", spellID = 29571 },
                { name = "Lunar Crescent", spellID = 29570 },
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
                { name = "Khorium Boots", spellID = 29605 },
                { name = "Belt of the Guardian", spellID = 29628 },
                { name = "Ragesteel Breastplate", spellID = 29619 },
                { name = "Ragesteel Gloves", spellID = 29620 },
                { name = "Ragesteel Helm", spellID = 29621 },
                { name = "Wildguard Helm", spellID = 29617 },
                { name = "Wildguard Leggings", spellID = 29616 },
                { name = "Wildguard Breastplate", spellID = 29618 },
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
                { name = "Fel Sharpening Stone", spellID = 29653 },
                { name = "Fel Weightstone", spellID = 29655 },
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
                { name = "Gloves of the Living Touch", spellID = 35562 },
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
