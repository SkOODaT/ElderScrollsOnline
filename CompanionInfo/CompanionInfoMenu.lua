local PanelTitle = "CompanionInfo"
local Version = "100035.18"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CILAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/cic",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Simple Addon To Show Active Companion Info.",
        },
        [2] = 
        {
            type = "header",
            name = "General"
        },
        [3] = 
        {
            type = "checkbox",
            name = "CompanionInfo On/Off",
            tooltip = "Toggle Overall Addon CompanionInfo On/Off.",
            getFunc = function() return CISaved.Toggle end,
            setFunc = function(value) CISaved.Toggle = value if CISaved.Toggle then CIFramesShow() else CIFramesHide() end end,
        },
        [4] = 
        {
            type = "checkbox",
            name = "Lock On/Off",
            tooltip = "Lock CompanionInfo Placement On/Off.",
            getFunc = function() return CISaved.Lock end,
            setFunc = function(value) CISaved.Lock = value CILock() end,
        },
        [5] =
        {
            type = "checkbox",
            name = "Companion Compass Hide On/Off",
            tooltip = "Hide Companion Icon On Compass.",
            getFunc = function() return CISaved.CompassHide end,
            setFunc = function(value) CISaved.CompassHide = value CompassHide() end,
        },
        [6] = 
        {
            type = "header",
            name = "Main Frame Settings"
        },
        [7] = 
        {
            type = "checkbox",
            name = "Main Frame Icon On/Off",
            tooltip = "Change CompanionInfo Main Frame Icon On/Off.",
            getFunc = function() return CISaved.MainIcon end,
            setFunc = function(value) CISaved.MainIcon = value CIFramesUpdate() end,
        },
        [8] = 
        {
            type = "checkbox",
            name = "Main Frame Name On/Off",
            tooltip = "Change CompanionInfo Main Frame Name On/Off.",
            getFunc = function() return CISaved.MainName end,
            setFunc = function(value) CISaved.MainName = value CIFramesUpdate() end,
        },
        [9] = 
        {
            type = "checkbox",
            name = "Main Frame Name Short On/Off",
            tooltip = "Change CompanionInfo Main Frame Name Short On/Off.",
            getFunc = function() return CISaved.MainNameShort end,
            setFunc = function(value) CISaved.MainNameShort = value CIFramesUpdate() end,
        },
        [10] = 
        {
            type = "checkbox",
            name = "Main Frame Level On/Off",
            tooltip = "Change CompanionInfo Main Frame Level On/Off.",
            getFunc = function() return CISaved.MainLevel end,
            setFunc = function(value) CISaved.MainLevel = value CIFramesUpdate() end,
        },
        [11] = 
        {
            type = "checkbox",
            name = "Main Frame XP Raw On/Off",
            tooltip = "Change CompanionInfo Main Frame XP Raw On/Off.",
            getFunc = function() return CISaved.MainRawXP end,
            setFunc = function(value) CISaved.MainRawXP = value CIFramesUpdate() end,
        },
        [12] = 
        {
            type = "checkbox",
            name = "Main Frame XP Percent On/Off",
            tooltip = "Change CompanionInfo Main Frame XP Percent On/Off.",
            getFunc = function() return CISaved.MainPercentXP end,
            setFunc = function(value) CISaved.MainPercentXP = value CIFramesUpdate() end,
        },
        [13] = 
        {
            type = "checkbox",
            name = "Main Frame XP Gains On/Off",
            tooltip = "Change CompanionInfo Main Frame XP Gains On/Off.",
            getFunc = function() return CISaved.MainGainXP end,
            setFunc = function(value) CISaved.MainGainXP = value CIFramesUpdate() end,
        },
        [14] = 
        {
            type = "checkbox",
            name = "Main Frame Rapport Level On/Off",
            tooltip = "Change CompanionInfo Main Frame Rap Level On/Off.",
            getFunc = function() return CISaved.MainLevelRap end,
            setFunc = function(value) CISaved.MainLevelRap = value CIFramesUpdate() end,
        },
        [15] = 
        {
            type = "checkbox",
            name = "Main Frame Previous Rapport On/Off",
            tooltip = "Change CompanionInfo Main Frame Previous Rapport On/Off.",
            getFunc = function() return CISaved.MainPrevRap end,
            setFunc = function(value) CISaved.MainPrevRap = value CIFramesUpdate() end,
        },
        [16] = 
        {
            type = "checkbox",
            name = "Main Frame Changed Rapport On/Off",
            tooltip = "Change CompanionInfo Main Frame Changed Rapport On/Off.",
            getFunc = function() return CISaved.MainChangedRap end,
            setFunc = function(value) CISaved.MainChangedRap = value CIFramesUpdate() end,
        },
        [17] = 
        {
            type = "checkbox",
            name = "Main Frame Current Rapport On/Off",
            tooltip = "Change CompanionInfo Main Frame Current Rapport On/Off.",
            getFunc = function() return CISaved.MainCurrentRap end,
            setFunc = function(value) CISaved.MainCurrentRap = value CIFramesUpdate() end,
        },
        [18] = 
        {
            type = "checkbox",
            name = "Main Frame Rapport Description On/Off",
            tooltip = "Change CompanionInfo Main Frame Rapport Description On/Off.",
            getFunc = function() return CISaved.MainDescRap end,
            setFunc = function(value) CISaved.MainDescRap = value CIFramesUpdate() end,
        },
        [19] = 
        {
            type = "header",
            name = "Text Colors"
        },
        [20] =
        {
            type = "editbox",
            name = "Text Colors",
            tooltip = "Change All CompanionInfo Text Colors.",
            getFunc = function() return CISaved.TextColor end,
            setFunc = function(value) CISaved.TextColor = value CIFramesUpdate() end,
        },
    }
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
