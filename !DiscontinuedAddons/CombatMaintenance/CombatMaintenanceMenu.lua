local PanelTitle = "CombatMaintenance"
local Version = "100010.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0")                                                     -- Load LibAddonMenu 2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CBMLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/cbm",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Auto Weapon and Helmet, Shows Helm In Combat Hides Out... And Stow Weapon After Set Change",
        },
        [2] = 
        {
            type = "checkbox",
            name = "CombatMaintenance On/Off",
            tooltip = "Toggle Overall Addon CombatMaintenance On/Off.",
            getFunc = function() return CBMSaved.Toggle end,
            setFunc = function(value) CBMSaved.Toggle = value end,
        },
        [3] = 
        {
            type = "checkbox",
            name = "Auto Weapon Sheathe On/Off",
            tooltip = "Automatically Sheathe Weapon When End Of Combat On/Off.",
            getFunc = function() return CBMSaved.Weapon end,
            setFunc = function(value) CBMSaved.Weapon = value end,
        },
        [4] = 
        {
            type = "checkbox",
            name = "Auto Weapon Sheathe PairChange On/Off",
            tooltip = "Automatically Sheathe Weapon When Pair Swaping If Not In Combat On/Off.",
            getFunc = function() return CBMSaved.Pair end,
            setFunc = function(value) CBMSaved.Pair = value end,
        },
        [5] = 
        {
            type = "checkbox",
            name = "Auto Helmet Stow On/Off",
            tooltip = "Automatically Stow Helmet When End Of Combat On/Off.",
            getFunc = function() return CBMSaved.Helmet end,
            setFunc = function(value) CBMSaved.Helmet = value CBMOffHelm() end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------