local AddName = "Vendors"

function VendorSavedVariables()
    VendorSaved = ZO_SavedVars:New("Vendors_SavedVariables", 1, nil, 
    {
        -- TOGGLES
        Toggle = true,
        Recorder = true,
        Alerts = true,
        ----------------------------
        -- CHAT OUTPUT
        VendorOutput = false,
        ----------------------------
        -- PVE VENDORS
        Alchemist = true,
        Armorer = true,
        Armsman = true,
        Banker = true,
        Blacksmith = true,
        Boatswain = true,
        Brewer = true,
        Carpenter = true,
        Chef = true,
        Clothier = true,
        Enchanter = true,
        Grocer = true,
        HallSteward = true,
        Innkeeper = true,
        Leatherworker = true,
        Magister = true,
        Magus = true,
        Merchant = true,
        Mystic = true,
        PackMerchant = true,
        Stablemaster = true,
        Tailor = true,
        Weaponsmith = true,
        Woodworker = true,
        -- PVP VENDORS
        MercenaryMerchant = true,   
        SiegeMerchant = true,
        EliteGearVendor = true,
        -- UNDAUNTED QUARTERMASTERS
        UndauntedQuartermaster = true,
        -- PROFITEER
        Profiteer = true,
        -- FENCE
        Fence = true,
        -- MONEYLENDER
        Moneylender = true,
        -- GUILD VENDORS
        GuildTrader = true,
        -- TG VENDOR
        TheGolden = true,
        ----------------------------
        -- CUSTOM VENDORS
        CustomVendor = true,
        ----------------------------
        -- FILTERS
        VendorFilter = true,        
        CustomFilter = true,
        ----------------------------
        -- ZrMM REFRESH (Minimap Refresh)
        ZrMM = false,
        ----------------------------
        -- DEBUG
        Debug = false, 
        ----------------------------
    })
    VendorSavedAccount = ZO_SavedVars:NewAccountWide("Vendors_SavedVariables", 1, nil, 
    {
        Data = {},
    })
    
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsSaveData(MapName, ...)
    local Data = {...}                                                                                      -- Create table from arguments you pass to the function after mapName
    VendorSavedAccount.Data[MapName] = VendorSavedAccount.Data[MapName] or {}                                             -- If subtable for map does not exists, create a new one
        --d("|cFFFFFFData Saved For:|r", Data)                                                              -- Debug For Save
    table.insert(VendorSavedAccount.Data[MapName], Data)                                                           -- Insert data to the last position in map subtable
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsOnLoad(EventCode, AddonName)
    if AddonName ~= AddName then return end
    VendorSavedVariables()
    VendorsLoadPins()
    EVENT_MANAGER:RegisterForEvent("Vendors", EVENT_PLAYER_ACTIVATED,
    function()
        VendorsLAM2Panel()
        EVENT_MANAGER:UnregisterForEvent("Vendors", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("Vendors_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("Vendors_OnLoad", EVENT_ADD_ON_LOADED, VendorsOnLoad)       