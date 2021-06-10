local PanelTitle = "AutoLantern"
local Version = "100035.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ALLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/aln",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Automatically Uses Lantern Memento.",
        },
        [2] =
        {
            type = "checkbox",
            name = "Toggle OverAll AutoLantern On/Off.",
            tooltip = "Toggle Overall Addon AutoLantern On/Off.",
            getFunc = function() return ALSaved.Toggle end,
            setFunc = function(value) ALSaved.Toggle = value end,
        },
        [3] =
        {
            type = "checkbox",
            name = "Toggle Reticle Refresh On/Off.",
            tooltip = "Toggle AutoLantern Refresh On Reticle On/Off.",
            getFunc = function() return ALSaved.Reticle end,
            setFunc = function(value) ALSaved.Reticle = value end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------