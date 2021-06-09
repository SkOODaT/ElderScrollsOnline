local PanelTitle = "SorcererMaintenance"
local Version = "100035.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SOMLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/som",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Addon To Notifiy You If Your Pet Has Dissapeared As It Does VERY Often, And Mage Light Support.",
        },
        [2] =
        {
            type = "checkbox",
            name = "Toggle OverAll SorcererMaintenance On/Off.",
            tooltip = "Toggle Overall Addon SorcererMaintenance On/Off.",
            getFunc = function() return SOMSaved.Toggle end,
            setFunc = function(value) SOMSaved.Toggle = value end,
        },
        [3] = {  
        type = "submenu",
		name = "Pet Options",
		tooltip = "Allows User To Modify Pet Settings And Alerts.",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Pet OverAll Toggle On/Off.",
                tooltip = "Toggle Overall Addon Pet Alerts On/Off.",
                getFunc = function() return SOMSaved.PetToggle end,
                setFunc = function(value) SOMSaved.PetToggle = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Pet Chat Output On/Off.",
                tooltip = "Toggle Pet Chat Output Easily On/Off.",
                getFunc = function() return SOMSaved.PetChat end,
                setFunc = function(value) SOMSaved.PetChat = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Pet Alert Output On/Off.",
                tooltip = "Toggle Pet Alert Output On/Off. (Top Right Corner Of Screen)",
                getFunc = function() return SOMSaved.PetAlert end,
                setFunc = function(value) SOMSaved.PetAlert = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Pet PSBT Notifications On/Off.",
                tooltip = "Toggle Pet PSBT Notifications On/Off. (Only Use If PSBT Is Installed)",
                getFunc = function() return SOMSaved.PetPSBT end,
                setFunc = function(value) SOMSaved.PetPSBT = value end,
                },
            [5] = {
                type = "checkbox",
                name = "Pet Sound Notifications On/Off.",
                tooltip = "Toggle Pet Sound Notifications On/Off.",
                getFunc = function() return SOMSaved.PetSound end,
                setFunc = function(value) SOMSaved.PetSound = value end,
                },
            },
		},
        [4] = {  
        type = "submenu",
		name = "Mage Light Options",
		tooltip = "Allows User To Modify Mage Light Settings And Alerts.",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Mage Light OverAll Toggle On/Off.",
                tooltip = "Toggle Overall Addon Mage Light Alerts On/Off.",
                getFunc = function() return SOMSaved.MLToggle end,
                setFunc = function(value) SOMSaved.MLToggle = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Mage Light Chat Output On/Off.",
                tooltip = "Toggle Mage Light Chat Output Easily On/Off.",
                getFunc = function() return SOMSaved.MLChat end,
                setFunc = function(value) SOMSaved.MLChat = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Mage Light Alert Output On/Off. (Top Right Corner Of Screen)",
                tooltip = "Toggle Mage Light Alert Output On/Off.",
                getFunc = function() return SOMSaved.MLAlert end,
                setFunc = function(value) SOMSaved.MLAlert = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Mage Light PSBT Notifications On/Off.",
                tooltip = "Toggle Mage Light PSBT Notifications On/Off. (Only Use If PSBT Is Installed)",
                getFunc = function() return SOMSaved.MLPSBT end,
                setFunc = function(value) SOMSaved.MLPSBT = value end,
                },
            [5] = {
                type = "checkbox",
                name = "Mage Light Sound Notifications On/Off.",
                tooltip = "Toggle Mage Light Sound Notifications On/Off.",
                getFunc = function() return SOMSaved.MLSound end,
                setFunc = function(value) SOMSaved.MLSound = value end,
                },
            },
		},
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------