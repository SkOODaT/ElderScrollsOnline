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
            text = "Addon to customize the compass",
        },
        [2] = 
        {
            type = "checkbox",
            name = "Addon enabled",
            tooltip = "Toggle if the addon is enabled",
            getFunc = function() return COMSaved.Toggle end,
            setFunc = function(value) COMSaved.Toggle = value COMFramesUpdate() COMAdjustCompass() end,
        },
        [3] = 
        {
            type = "checkbox",
            name = "Compass lock",
            tooltip = "Toggle compass lock",
            getFunc = function() return COMSaved.Lock end,
            setFunc = function(value) COMSaved.Lock = value COMAdjustCompass() end,
        },
        [4] = 
        {
            type = "slider",
            name = "Compass icon scale",
            tooltip = "Edit compass scale (due to a bug, cannot go over 1)",
            getFunc = function() return COMSaved.Scale end,
            setFunc = function(Scale) COMSaved.Scale = tonumber(Scale) COMFramesUpdate() end,
            min = 0,
            max = 1,
            step = 0.01,
            decimals = 2,
        },
        [5] = 
        {
            type = "editbox",
            name = "Compass height in pixels",
            tooltip = "Edit height of the compass",
            getFunc = function() return COMSaved.Height end,
            setFunc = function(Height) COMSaved.Height = tonumber(Height) COMFramesUpdate() end,
        },
        [6] = 
        {
            type = "editbox",
            name = "Compass width in pixels",
            tooltip = "Edit width of the compass",
            getFunc = function() return COMSaved.Width end,
            setFunc = function(Width) COMSaved.Width = tonumber(Width) COMFramesUpdate() end,
        },
        [7] = 
        {
            type = "slider",
            name = "Compass center pin text scale",
            tooltip = "Edit compass center pin text scale",
            getFunc = function() return COMSaved.TextScale end,
            setFunc = function(TextScale) COMSaved.TextScale = tonumber(TextScale) COMFramesUpdate() end,
            min = 0,
            max = 3,
            step = 0.1,
            decimals = 1,
        },
        [8] = 
        {
            type = "slider",
            name = "Compass background transparency",
            tooltop = "Edit compass background transparency",
            getFunc = function() return COMSaved.Alpha end,
            setFunc = function(value) COMSaved.Alpha = tonumber(value) COMFramesUpdate() end,
            min = 0,
            max = 1,
            step = 0.1,
            decimals = 1,
        }
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------