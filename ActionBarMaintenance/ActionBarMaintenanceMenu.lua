local PanelTitle = "ActionBarMaintenance"
local Version = "100035.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ABMLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/abm",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Simple Addon To Scale The Actionbar And Hide The Background.",
        },
        [2] = 
        {
            type = "checkbox",
            name = "ActionBarMaintenance On/Off",
            tooltip = "Toggle Overall Addon ActionBarMaintenance On/Off.",
            getFunc = function() return ABSaved.Toggle end,
            setFunc = function(value) ABSaved.Toggle = value ABFramesUpdate() end,
        },
        [3] = 
        {
            type = "checkbox",
            name = "ActionBar BackGround Hide On/Off",
            tooltip = "Toggle ActionBar BackGround On/Off.",
            getFunc = function() return ABSaved.BGHide end,
            setFunc = function(value) ABSaved.BGHide = value ABFramesUpdate() end,
        },
        [4] = 
        {
            type = "editbox",
            name = "ActionBar Scale",
            tooltip = "Edit Scale Of ActonBar, UIDefault is 1",
            getFunc = function() return ABSaved.Scale end,
            setFunc = function(Scale) ABSaved.Scale = tonumber(Scale) ABFramesUpdate() end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
