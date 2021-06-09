local PanelTitle = "CompassMaintenance"
local Version = "100035.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CPMLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/cps",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Simple Addon To Move and Size The Compass.",
        },
        [2] = 
        {
            type = "checkbox",
            name = "CompassMaintenance On/Off.",
            tooltip = "Toggle Overall Addon CompassMaintenance On/Off.",
            getFunc = function() return COMSaved.Toggle end,
            setFunc = function(value) COMSaved.Toggle = value COMFramesUpdate() COMAdjustCompass() end,
        },
        [3] = 
        {
            type = "checkbox",
            name = "CompassMaintenance Lock On/Off.",
            tooltip = "Toggle Compass Lock On/Off.",
            getFunc = function() return COMSaved.Lock end,
            setFunc = function(value) COMSaved.Lock = value COMAdjustCompass() end,
        },
        [4] = 
        {
            type = "editbox",
            name = "Compass Scale.",
            tooltip = "Edit Scale Of Compass, UIDefault is 1 (Patch 1.2.3 Caused Scaleing Bugs :S)",
            getFunc = function() return COMSaved.Scale end,
            setFunc = function(Scale) COMSaved.Scale = tonumber(Scale) COMFramesUpdate() end,
        },
        [5] = 
        {
            type = "editbox",
            name = "Compass Height.",
            tooltip = "Edit Height Of Compass",
            getFunc = function() return COMSaved.Height end,
            setFunc = function(Height) COMSaved.Height = tonumber(Height) COMFramesUpdate() end,
        },
        [6] = 
        {
            type = "editbox",
            name = "Compass Width.",
            tooltip = "Edit Width Of Compass, UIDefault is 1",
            getFunc = function() return COMSaved.Width end,
            setFunc = function(Width) COMSaved.Width = tonumber(Width) COMFramesUpdate() end,
        },
        [7] = 
        {
            type = "editbox",
            name = "Compass Center Pin Text Scale.",
            tooltip = "Edit Compass Center Pin Text Scale On/Off.",
            getFunc = function() return COMSaved.TextScale end,
            setFunc = function(TextScale) COMSaved.TextScale = tonumber(TextScale) COMFramesUpdate() end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------