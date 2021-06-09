local PanelTitle = "CurrentCoin"
local Version = "100035.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CCLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/cnc",
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
            name = "CurrentCoin On/Off",
            tooltip = "Toggle Overall Addon CurrentCoin On/Off.",
            getFunc = function() return CCSaved.Toggle end,
            setFunc = function(value) CCSaved.Toggle = value CCFramesUpdate() end,
        },
        [3] = 
        {
            type = "checkbox",
            name = "CurrentCoin Lock On/Off",
            tooltip = "Lock CurrentCoin Placement On/Off.",
            getFunc = function() return CCSaved.Lock end,
            setFunc = function(value) CCSaved.lock = value CCFramesUpdate() end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
