local PanelTitle = "ChatMaintenance"
local Version = "100034.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHMLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/chm",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Simple Addon To Do Several Chat Slash Commands.",
        },
        [2] =
        {
            type = "description",
            text = "|c66FF33/d|r, |c66FF33/sc|r - Print And Scripting Commmands.",
        },
        [3] =
        {
            type = "description",
            text = "|c66FF33/rl|r, |c66FF33/reload|r - Reload Commands Or Keybinding.",
        },
        [4] =
        {
            type = "description",
            text = "|c66FF33/clr|r, |c66FF33/clr all|r, |c66FF33/clr tabs|r - Clear Chat Commands.",
        },
        [5] =
        {
            type = "description",
            text = "|c66FF33/friend|r, |c66FF33/unfriend|r, |c66FF33/ignore|r, |c66FF33/unignore|r - Social Commands.",
        },
        [6] =
        {
            type = "description",
            text = "|c66FF33/leave|r, |c66FF33/disband|r, |c66FF33/kick|r, |c66FF33/remove|r - Grouping Commands.",
        },
        [7] =
        {
            type = "description",
            text = "|c66FF33/g1invite|r, |c66FF33/g1quit|r (|c66FF332|r,|c66FF333|r,|c66FF334|r,|c66FF335|r) - Guild Commands.",
        },
        [8] =
        {
            type = "description",
            text = "|c66FF33/money|r, |c66FF33/mail|r, |c66FF33/play|r, |c66FF33/repair|r, |c66FF33/repaircost|r, |c66FF33/location|r, |c66FF33/way|r, |c66FF33/whoami|r - Commands.",
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------