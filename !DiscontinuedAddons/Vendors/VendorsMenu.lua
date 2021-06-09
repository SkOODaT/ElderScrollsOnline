local PanelTitle = "Vendors"
local Author = "SkOODaT" 
local Version = "100015.1"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0")                                                     -- Load LibAddonMenu 2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/vend",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Automatically Mark Vendor NPCs Onto The Map On Interaction Succesor To Merchants Addon",
        },
        [2] = -- Toggle
        {
            type = "checkbox",
            name = "Vendors On/Off",
            tooltip = "Toggle Overall Addon Vendors On/Off.",
            getFunc = function() return VendorSaved.Toggle end,
            setFunc = function(value) VendorSaved.Toggle = value VendorsRefresh() end,
        },
        [3] = -- Scanner
        {
            type = "checkbox",
            name = "Vendors NPC Data Recording On/Off",
            tooltip = "Toggle Vendors NPC Data Recording On/Off.",
            getFunc = function() return VendorSaved.Recorder end,
            setFunc = function(value) VendorSaved.Recorder = value end,
        },
        [4] = -- Scanner
        {
            type = "checkbox",
            name = "Database Alerts And Sound On/Off",
            tooltip = "Toggle Vendors Database Alerts And Sound On/Off.",
            getFunc = function() return VendorSaved.Alerts end,
            setFunc = function(value) VendorSaved.Alerts = value end,
        },
        [5] = -- Chat Output
        {
            type = "checkbox",
            name = "Vendors Chat Logging Output On/Off",
            tooltip = "Toggle Vendors Chat Logging Output On/Off.",
            getFunc = function() return VendorSaved.VendorOutput end,
            setFunc = function(value) VendorSaved.VendorOutput = value end,
        },
        [6] = { -- PVE Vendors
		type = "submenu",
		name = "Vendor Toggles",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "Alchemists On/Off",
				tooltip = "Toggle Alchemists On/Off.",
				getFunc = function() return VendorSaved.Alchemist end,
				setFunc = function(value) VendorSaved.Alchemist = value VendorsRefresh() end,
			},
			[2] = {
				type = "checkbox",
				name = "Armorers On/Off",
				tooltip = "Toggle Armorers On/Off.",
				getFunc = function() return VendorSaved.Armorer end,
				setFunc = function(value) VendorSaved.Armorer = value VendorsRefresh() end,
			},
            [3] = {
				type = "checkbox",
				name = "Armsmans On/Off",
				tooltip = "Toggle Armsmans On/Off.",
				getFunc = function() return VendorSaved.Armsman end,
				setFunc = function(value) VendorSaved.Armsman = value VendorsRefresh() end,
			},
            [4] = {
				type = "checkbox",
				name = "Banker On/Off",
				tooltip = "Toggle Banker On/Off.",
				getFunc = function() return VendorSaved.Banker end,
				setFunc = function(value) VendorSaved.Banker = value VendorsRefresh() end,
			},
            [5] = {
				type = "checkbox",
				name = "Blacksmiths On/Off",
				tooltip = "Toggle Blacksmiths On/Off.",
				getFunc = function() return VendorSaved.Blacksmith end,
				setFunc = function(value) VendorSaved.Blacksmith = value VendorsRefresh() end,
			},
            [6] = {
				type = "checkbox",
				name = "Boatswain On/Off",
				tooltip = "Toggle Boatswains On/Off.",
				getFunc = function() return VendorSaved.Boatswain end,
				setFunc = function(value) VendorSaved.Boatswain = value VendorsRefresh() end,
			},
            [7] = {
				type = "checkbox",
				name = "Brewers On/Off",
				tooltip = "Toggle Brewers On/Off.",
				getFunc = function() return VendorSaved.Brewer end,
				setFunc = function(value) VendorSaved.Brewer = value VendorsRefresh() end,
			},
            [8] = {
				type = "checkbox",
				name = "Carpenters On/Off",
				tooltip = "Toggle Carpenters On/Off.",
				getFunc = function() return VendorSaved.Carpenter end,
				setFunc = function(value) VendorSaved.Carpenter = value VendorsRefresh() end,
			},
            [9] = {
				type = "checkbox",
				name = "Chefs On/Off",
				tooltip = "Toggle Chefs On/Off.",
				getFunc = function() return VendorSaved.Chef end,
				setFunc = function(value) VendorSaved.Chef = value VendorsRefresh() end,
			},
            [10] = {
				type = "checkbox",
				name = "Clothiers On/Off",
				tooltip = "Toggle Clothiers On/Off.",
				getFunc = function() return VendorSaved.Clothier end,
				setFunc = function(value) VendorSaved.Clothier = value VendorsRefresh() end,
			},
            [11] = {
				type = "checkbox",
				name = "Enchanters On/Off",
				tooltip = "Toggle Enchanters On/Off.",
				getFunc = function() return VendorSaved.Enchanter end,
				setFunc = function(value) VendorSaved.Enchanter = value VendorsRefresh() end,
			},
            [12] = {
				type = "checkbox",
				name = "Grocers On/Off",
				tooltip = "Toggle Grocers On/Off.",
				getFunc = function() return VendorSaved.Grocer end,
				setFunc = function(value) VendorSaved.Grocer = value VendorsRefresh() end,
			},
            [13] = {
				type = "checkbox",
				name = "HallStewards On/Off",
				tooltip = "Toggle HallStewards On/Off.",
				getFunc = function() return VendorSaved.HallSteward end,
				setFunc = function(value) VendorSaved.HallSteward = value VendorsRefresh() end,
			},
            [14] = {
				type = "checkbox",
				name = "Innkeepers On/Off",
				tooltip = "Toggle Innkeepers On/Off.",
				getFunc = function() return VendorSaved.Innkeeper end,
				setFunc = function(value) VendorSaved.Innkeeper = value VendorsRefresh() end,
			},
            [15] = {
				type = "checkbox",
				name = "Leatherworkers On/Off",
				tooltip = "Toggle Leatherworkers On/Off.",
				getFunc = function() return VendorSaved.Leatherworker end,
				setFunc = function(value) VendorSaved.Leatherworker = value VendorsRefresh() end,
			},
            [16] = {
				type = "checkbox",
				name = "Magisters On/Off",
				tooltip = "Toggle Magisters On/Off.",
				getFunc = function() return VendorSaved.Magister end,
				setFunc = function(value) VendorSaved.Magister = value VendorsRefresh() end,
			},
            [17] = {
				type = "checkbox",
				name = "Magus On/Off",
				tooltip = "Toggle Magus On/Off.",
				getFunc = function() return VendorSaved.Magus end,
				setFunc = function(value) VendorSaved.Magus = value VendorsRefresh() end,
			},
            [18] = {
				type = "checkbox",
				name = "Merchants On/Off",
				tooltip = "Toggle Merchants On/Off.",
				getFunc = function() return VendorSaved.Merchant end,
				setFunc = function(value) VendorSaved.Merchant = value VendorsRefresh() end,
			},
            [19] = {
				type = "checkbox",
				name = "Mystics On/Off",
				tooltip = "Toggle Mystics On/Off.",
				getFunc = function() return VendorSaved.Mystic end,
				setFunc = function(value) VendorSaved.Mystic = value VendorsRefresh() end,
			},
            [20] = {
				type = "checkbox",
				name = "PackMerchants On/Off",
				tooltip = "Toggle PackMerchants On/Off.",
				getFunc = function() return VendorSaved.PackMerchant end,
				setFunc = function(value) VendorSaved.PackMerchant = value VendorsRefresh() end,
			},
            [21] = {
				type = "checkbox",
				name = "Stablemasters On/Off",
				tooltip = "Toggle Stablemasters On/Off.",
				getFunc = function() return VendorSaved.Stablemaster end,
				setFunc = function(value) VendorSaved.Stablemaster = value VendorsRefresh() end,
			},
            [22] = {
				type = "checkbox",
				name = "Tailors On/Off",
				tooltip = "Toggle Tailors On/Off.",
				getFunc = function() return VendorSaved.Tailor end,
				setFunc = function(value) VendorSaved.Tailor = value VendorsRefresh() end,
			},
            [23] = {
				type = "checkbox",
				name = "Weaponsmiths On/Off",
				tooltip = "Toggle Weaponsmiths On/Off.",
				getFunc = function() return VendorSaved.Weaponsmith end,
				setFunc = function(value) VendorSaved.Weaponsmith = value VendorsRefresh() end,
			},
            [24] = {
				type = "checkbox",
				name = "Woodworkers On/Off",
				tooltip = "Toggle Woodworkers On/Off.",
				getFunc = function() return VendorSaved.Woodworker end,
				setFunc = function(value) VendorSaved.Woodworker = value VendorsRefresh() end,
			},
                },
		},
        [7] = { -- PVP Vendors
		type = "submenu",
		name = "PVPVendor Toggles",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "Mercenary Merchants On/Off",
				tooltip = "Toggle Mercenary Merchants On/Off.",
				getFunc = function() return VendorSaved.MercenaryMerchant end,
				setFunc = function(value) VendorSaved.MercenaryMerchant = value VendorsRefresh() end,
			},
			[2] = {
				type = "checkbox",
				name = "Siege Merchants On/Off",
				tooltip = "Toggle Siege Merchants On/Off.",
				getFunc = function() return VendorSaved.SiegeMerchant end,
				setFunc = function(value) VendorSaved.SiegeMerchant = value VendorsRefresh() end,
			},
            [3] = {
				type = "checkbox",
				name = "Elite Gear Vendor On/Off",
				tooltip = "Toggle Elite Gear Vendor On/Off.",
				getFunc = function() return VendorSaved.EliteGearVendor end,
				setFunc = function(value) VendorSaved.EliteGearVendor = value VendorsRefresh() end,
			},
                },
		},
        [8] = { -- UNDAUNTED QUARTERMASTERS
		type = "submenu",
		name = "Undaunted Quartermasters Toggle",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "Undaunted Quartermasters On/Off",
				tooltip = "Toggle Undaunted Quartermasters On/Off.",
				getFunc = function() return VendorSaved.UndauntedQuartermaster end,
				setFunc = function(value) VendorSaved.UndauntedQuartermaster = value VendorsRefresh() end,
			},
                },
		},
        [9] = { -- PROFITEER
		type = "submenu",
		name = "Profiteer Toggle",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "Profiteers On/Off",
				tooltip = "Toggle Profiteers On/Off.",
				getFunc = function() return VendorSaved.Profiteer end,
				setFunc = function(value) VendorSaved.Profiteer = value VendorsRefresh() end,
			},
                },
		},
        [10] = { -- FENCE
		type = "submenu",
		name = "Fence Toggle",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "Fences On/Off",
				tooltip = "Toggle Fences On/Off.",
				getFunc = function() return VendorSaved.Fence end,
				setFunc = function(value) VendorSaved.Fence = value VendorsRefresh() end,
			},
                },
		},
        [11] = { -- MONEYLENDER
		type = "submenu",
		name = "Moneylender Toggle",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "Moneylenders On/Off",
				tooltip = "Toggle Moneylenders On/Off.",
				getFunc = function() return VendorSaved.Moneylender end,
				setFunc = function(value) VendorSaved.Moneylender = value VendorsRefresh() end,
			},
                },
		},
        [12] = { -- GUILD VENDOR
		type = "submenu",
		name = "GuildVendor Toggles",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "Guild Traders On/Off",
				tooltip = "Toggle Guild Traders On/Off.",
				getFunc = function() return VendorSaved.GuildTrader end,
				setFunc = function(value) VendorSaved.GuildTrader = value VendorsRefresh() end,
			},
                },
		},
        [13] = { -- TG VENDOR
		type = "submenu",
		name = "The Golden Traders Toggles",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "The Golden Traders On/Off",
				tooltip = "Toggle The Golden Traders On/Off.",
				getFunc = function() return VendorSaved.TheGolden end,
				setFunc = function(value) VendorSaved.TheGolden = value VendorsRefresh() end,
			},
                },
		},
        [14] = { -- Custom Vendors
		type = "submenu",
		name = "Custom Toggles",
		tooltip = "Allows User To Modify Vendors Shown",	
		controls = {
			[1] = {
				type = "checkbox",
				name = "Custom Vendors On/Off",
				tooltip = "Toggle OddBall Custom Vendorss On/Off.",
				getFunc = function() return VendorSaved.CustomVendor end,
				setFunc = function(value) VendorSaved.CustomVendor = value VendorsRefresh() end,
			},
                },
		},
        [15] = 
        {
            type = "checkbox",
            name = "MiniMap Refresh On/Off",
            tooltip = "MiniMap Instantly Refresh On/Off. (No Pin Delay - Will Cause Lag Jot Mouseing Over New NPC To Database)",
            getFunc = function() return VendorSaved.ZrMM end,
            setFunc = function(value) VendorSaved.ZrMM = value end,
        },
        [16] = -- Debug Output
        {
            type = "checkbox",
            name = "Debugging On/Off",
            tooltip = "Toggle Debugging On/Off.",
            getFunc = function() return VendorSaved.Debug end,
            setFunc = function(value) VendorSaved.Debug = value end,
        },
        [17] =
        {
            type = "description",
            text = "Credit To Mitsarugi For The Original Idea And Thanks To Harven, Garkin For API Help",
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsRefresh()
    ZO_WorldMap_UpdateMap()                                                                                  
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------