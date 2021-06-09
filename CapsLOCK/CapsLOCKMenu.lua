local PanelTitle = "CapsLOCK"
local Version = "100035.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2                                                    -- Load LibAddonMenu 2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CLLAM2Panel()
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
            text = "Simple Addon To Show If CapsLOCK Is On With Red Text Above The Chat Frame. No More Yelling!",
        },
        [2] = 
        {
            type = "checkbox",
            name = "CapsLOCK On/Off",
            tooltip = "Toggle Overall Addon CapsLOCK On/Off.",
            getFunc = function() return CLSaved.Toggle end,
            setFunc = function(value) CLSaved.Toggle = value CLUpdate() end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
