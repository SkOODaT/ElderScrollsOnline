local PanelTitle = "SkyShardStatus"
local Version = "100035.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SSSLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/sss",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Simple Addon To Show Current SkyShard Collection Status.",
        },
        [2] = 
        {
            type = "checkbox",
            name = "SkyShardStatus On/Off",
            tooltip = "Toggle Overall Addon SkyShardStatus On/Off.",
            getFunc = function() return SSSaved.Toggle end,
            setFunc = function(value) SSSaved.Toggle = value SSSUpdate() end,
        },
        [3] = 
        {
            type = "checkbox",
            name = "SkyShardStatus Lock On/Off",
            tooltip = "Toggle SkyShardStatus Lock On/Off.",
            getFunc = function() return SSSaved.Lock end,
            setFunc = function(value) SSSaved.Lock = value SSSFrames() end,
        },
        [4] = 
        {
            type = "editbox",
            name = "SkyShardStatus Scale",
            tooltip = "Edit Scale Of SkyShardStatus, UIDefault is 1",
            getFunc = function() return SSSaved.Scale end,
            setFunc = function(Scale) SSSaved.Scale = tonumber(Scale) SSSFrames() end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------