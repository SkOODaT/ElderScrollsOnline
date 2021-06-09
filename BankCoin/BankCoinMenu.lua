local PanelTitle = "BankCoin"
local Version = "100035.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BCLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/bnc",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Simple Addon To Show How Much Gold Is In The Bank.",
        },
        [2] = 
        {
            type = "checkbox",
            name = "BankCoin On/Off",
            tooltip = "Toggle Overall Addon BankCoin On/Off.",
            getFunc = function() return BCSaved.Toggle end,
            setFunc = function(value) BCSaved.Toggle = value BCFramesUpdate() end,
        },
        [3] = 
        {
            type = "checkbox",
            name = "BankCoin Lock On/Off",
            tooltip = "Lock BankCoin Placement On/Off.",
            getFunc = function() return BCSaved.Lock end,
            setFunc = function(value) BCSaved.lock = value BCFramesUpdate() end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
