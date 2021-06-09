local PanelTitle = "GuildFriendGroupReticle"
local Version = "100034.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibAddonMenu2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GFGLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/gfgr",
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "Shows Guild/Friends/Group Members On The Reticle With Corresponding Icons, Auto Accept Guild/Friend, Group Features Included..",
        },
        [2] =  
        {
            type = "checkbox",
            name = "GuildFriendGroupReticle On/Off",
            tooltip = "Toggle Overall Addon GuildFriendGroupReticle On/Off.",
            getFunc = function() return GFGSaved.Toggle end,
            setFunc = function(value) GFGSaved.Toggle = value end,
        },
        [3] = { -- Guild 
        type = "submenu",
		name = "Guild Toggles",
		tooltip = "Allows User To Modify Guild Options For Reticle",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Guild Text On/Off",
                tooltip = "Toggle Guild Text On/Off.",
                getFunc = function() return GFGSaved.GuildText end,
                setFunc = function(value) GFGSaved.GuildText = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Guild Player Name On/Off",
                tooltip = "Toggle Guild Player Name Text Only On/Off.",
                getFunc = function() return GFGSaved.PNameOn end,
                setFunc = function(value) GFGSaved.PNameOn = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Guild Name On/Off",
                tooltip = "Toggle Guild Name Text Only On/Off.",
                getFunc = function() return GFGSaved.GNameOn end,
                setFunc = function(value) GFGSaved.GNameOn = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Guild Icon On/Off",
                tooltip = "Toggle Guild Icon On/Off.",
                getFunc = function() return GFGSaved.GuildIcon end,
                setFunc = function(value) GFGSaved.GuildIcon = value end,
                },
            [5] = {
                type = "checkbox",
                name = "Guild Reticle Colour On/Off",
                tooltip = "Toggle Guild Reticle Colour On/Off.",
                getFunc = function() return GFGSaved.GuildColor end,
                setFunc = function(value) GFGSaved.GuildColor = value end,
                },
            },
		},
        [4] = { -- Friends 
        type = "submenu",
		name = "Friend Toggles",
		tooltip = "Allows User To Modify Friend Options For Reticle",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Friend Text On/Off",
                tooltip = "Toggle Friend Text On/Off.",
                getFunc = function() return GFGSaved.FriendText end,
                setFunc = function(value) GFGSaved.FriendText = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Friend Icon On/Off",
                tooltip = "Toggle Friend Icon On/Off.",
                getFunc = function() return GFGSaved.FriendIcon end,
                setFunc = function(value) GFGSaved.FriendIcon = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Friend Reticle Colour On/Off",
                tooltip = "Toggle Friend Reticle Colour On/Off.",
                getFunc = function() return GFGSaved.FriendColor end,
                setFunc = function(value) GFGSaved.FriendColor = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Show Friends/NON-Guild On/Off",
                tooltip = "Toggle Show Friends Only For NON-Guild Members On/Off.",
                getFunc = function() return GFGSaved.FriendNonGuild end,
                setFunc = function(value) GFGSaved.FriendNonGuild = value end,
                },
            },
		},
        [5] = { -- Group 
        type = "submenu",
		name = "Group Toggles",
		tooltip = "Allows User To Modify Group Options For Reticle",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Group Text On/Off",
                tooltip = "Toggle Group Text On/Off.",
                getFunc = function() return GFGSaved.GroupText end,
                setFunc = function(value) GFGSaved.GroupText = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Group Icon On/Off.",
                tooltip = "Toggle Group Icon On/Off.",
                getFunc = function() return GFGSaved.GroupIcon end,
                setFunc = function(value) GFGSaved.GroupIcon = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Group Reticle Colour On/Off.",
                tooltip = "Toggle Group Reticle Colour On/Off.",
                getFunc = function() return GFGSaved.GroupColor end,
                setFunc = function(value) GFGSaved.GroupColor = value end,
                },
            },
		},
        [6] = { -- Group 
        type = "submenu",
		name = "Group Accept Toggles",
		tooltip = "Allows User To Modify Auto Group Accept Options",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Guild Group Invites On/Off.",
                tooltip = "Toggle Guild Group Invites On/Off.",
                getFunc = function() return GFGSaved.AcceptGuild end,
                setFunc = function(value) GFGSaved.AcceptGuild = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Friend Group Invites On/Off.",
                tooltip = "Toggle Friend Group Invites On/Off.",
                getFunc = function() return GFGSaved.AcceptFriend end,
                setFunc = function(value) GFGSaved.AcceptFriend = value end,
                },
            },
		},
        [7] =  
        {
            type = "checkbox",
            name = "Debugging On/Off",
            tooltip = "Toggle Debugging On/Off.",
            getFunc = function() return GFGSaved.Debug end,
            setFunc = function(value) GFGSaved.Debug = value end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------   
   
   
   
   
   
   
   
   
   
   
   