Config = {
    Marker = {
        type = 21,
        size = vector3(0.5, 0.5, 0.5),
        color = { r = 253, g = 19, b = 57, a = 200 },
        drawDistance = 10.0
    },
    Shops = {
        ["police"] = {
            locations = {
                vector3(442.1994, -988.1259, 34.3)
            },
            items = {
                {
                    name = "WEAPON_CARBINERIFLE", -- Item name
                    label = "Karabiner",          -- Item Label
                    amount = 5,                   -- Amount given per purchase
                    price = 3000,                 -- Price of the item
                    minGrade = 1,                 -- Minimum job grade required
                    specifiedGradesOnly = {},     -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = true               -- Is the item a weapon
                },
                {
                    name = "WEAPON_SMG",      -- Item name
                    label = "SMG",            -- Item Label
                    amount = 5,               -- Amount given per purchase
                    price = 2500,             -- Price of the item
                    minGrade = 1,             -- Minimum job grade required
                    specifiedGradesOnly = {}, -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = true           -- Is the item a weapon
                },
                {
                    name = "WEAPON_COMBATPISTOL", -- Item name
                    label = "Kampfpistole",       -- Item Label
                    amount = 1,                   -- Amount given per purchase
                    price = 800,                  -- Price of the item
                    minGrade = 1,                 -- Minimum job grade required
                    specifiedGradesOnly = {},     -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = true               -- Is the item a weapon
                },
                {
                    name = "WEAPON_NIGHTSTICK", -- Item name
                    label = "Schlagstock",      -- Item Label
                    amount = 1,                 -- Amount given per purchase
                    price = 250,                -- Price of the item
                    minGrade = 1,               -- Minimum job grade required
                    specifiedGradesOnly = {},   -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = true             -- Is the item a weapon
                },
                {
                    name = "WEAPON_FLASHLIGHT", -- Item name
                    label = "Taschenlampe",     -- Item Label
                    amount = 1,                 -- Amount given per purchase
                    price = 150,                -- Price of the item
                    minGrade = 1,               -- Minimum job grade required
                    specifiedGradesOnly = {},   -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = true             -- Is the item a weapon
                },
                {
                    name = "WEAPON_PEPPERSPRAY", -- Item name
                    label = "Pfefferspray",      -- Item Label
                    amount = 1,                  -- Amount given per purchase
                    price = 99,                  -- Price of the item
                    minGrade = 0,                -- Minimum job grade required
                    specifiedGradesOnly = {},    -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = true              -- Is the item a weapon
                },
                {
                    name = "WEAPON_ANTIDOTE", -- Item name
                    label = "Antidote",       -- Item Label
                    amount = 1,               -- Amount given per purchase
                    price = 29,               -- Price of the item
                    minGrade = 0,             -- Minimum job grade required
                    specifiedGradesOnly = {}, -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = true           -- Is the item a weapon
                },
                {
                    name = "GADGET_PARACHUTE", -- Item name
                    label = "Falschirm",       -- Item Label
                    amount = 1,                -- Amount given per purchase
                    price = 800,               -- Price of the item
                    minGrade = 0,              -- Minimum job grade required
                    specifiedGradesOnly = {},  -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = true            -- Is the item a weapon
                },
                {
                    name = "magazin",         -- Item name
                    label = "Magazin",        -- Item Label
                    amount = 1,               -- Amount given per purchase
                    price = 20,               -- Price of the item
                    minGrade = 1,             -- Minimum job grade required
                    specifiedGradesOnly = {}, -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = false          -- Is the item a weapon
                },
                {
                    name = "armor",           -- Item name
                    label = "Schutzweste",    -- Item Label
                    amount = 1,               -- Amount given per purchase
                    price = 20,               -- Price of the item
                    minGrade = 1,             -- Minimum job grade required
                    specifiedGradesOnly = {}, -- Only these grades can access (overrides minGrade if not empty)
                    isWeapon = false          -- Is the item a weapon
                },
            }
        }
    }
}
