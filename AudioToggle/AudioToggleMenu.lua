local PanelTitle = "AudioToggle"
local Version = "100034.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ATLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/aut",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Simple Addon To Mute Music/Sounds/Dialogue With A Keybind. (Good For Music Playing In Winamp)",
        },
        [2] = 
        {
            type = "checkbox",
            name = "AudioToggle On/Off",
            tooltip = "Toggle Overall Addon AudioToggle On/Off.",
            getFunc = function() return ATSaved.Toggle end,
            setFunc = function(value) ATSaved.Toggle = value end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------