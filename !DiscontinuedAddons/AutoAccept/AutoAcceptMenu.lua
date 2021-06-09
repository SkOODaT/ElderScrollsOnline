local PanelTitle = "AutoAccept"
local Version = "100004.2"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0")                                                     -- Load LibAddonMenu 2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AALAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/ata",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Simple Addon To Auto Accept Guild/Friend Group Invites.",
        },
        [2] = 
        {
            type = "checkbox",
            name = "AutoAcceptToggle On/Off",
            tooltip = "Toggle Overall Addon AutoAccept On/Off.",
            getFunc = function() return AASaved.Toggle end,
            setFunc = function(value) AASaved.Toggle = value end,
        },
        [3] = 
        {
            type = "checkbox",
            name = "Guild Group Invites On/Off.",
            tooltip = "AutoAccept Guild Member Group Invites On/Off.",
            getFunc = function() return AASaved.Guild end,
            setFunc = function(value) AASaved.Guild = value end,
        },
        [4] = 
        {
            type = "checkbox",
            name = "Friend Group Invites On/Off.",
            tooltip = "AutoAccept Friend Group Invites On/Off.",
            getFunc = function() return AASaved.Friend end,
            setFunc = function(value) AASaved.Friend = value end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------