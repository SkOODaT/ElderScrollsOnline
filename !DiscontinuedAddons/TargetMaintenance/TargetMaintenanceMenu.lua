local PanelTitle = "TargetMaintenance"
local Version = "100015.1"
local Author = "SkOODaT"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0")                                                     -- Load LibAddonMenu 2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMForceLevels()
    if TMSaved.ImprovedLevel == true then
        TMSaved.NPCLevel = false
        TMSaved.CritterLevel = false
        TMSaved.CollectableLevel = false
        TMSaved.PetLevel = false
    else
        TMSaved.NPCLevel = true
        TMSaved.CritterLevel = true
        TMSaved.CollectableLevel = true
        TMSaved.PetLevel = true
    end
end 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMLAM2Panel()
    local PanelData = 
    {
        type = "panel",
        name = PanelTitle,
        author = Author,
        version = Version,
        slashCommand = "/tmn",
        registerForRefresh = true,
    }
    local OptionsData = 
    {
        [1] =
        {
            type = "description",
            text = "More Information Added To The Target Unit Frame And A Reticle Unit Frame, Player info, Critters, Difficulity Stars, Better Level, Scale Fully Customizable.",  
        },
        [2] =  
        {
            type = "checkbox",
            name = "TargetMaintenance On/Off",
            tooltip = "Toggle Overall Addon TargetMaintenance Easily On/Off.",
            getFunc = function() return TMSaved.Toggle end,
            setFunc = function(value) TMSaved.Toggle = value end,
        },
        [3] =  
        {
            type = "checkbox",
            name = "Target Frame Modifications On/Off",
            tooltip = "Toggle Target Frame Modifications On/Off.",
            getFunc = function() return TMSaved.TargetFrame end,
            setFunc = function(value) TMSaved.TargetFrame = value end,
        },
        [4] = {  
        type = "submenu",
		name = "Target Frame Options",
		tooltip = "Allows User To Modify Target Frame Settings",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Target Frame Improved Levels On/Off",
                tooltip = "Toggle Target Frame Improved Levels/Vlevels On/Off. (Moves Level To Top Of Target Name)",
                getFunc = function() return TMSaved.ImprovedLevel end,
                setFunc = function(value) TMSaved.ImprovedLevel = value TMForceLevels() end,
                },
            [2] = {
                type = "editbox",
                name = "Target Text Scale",
                tooltip = "Edit Target Frame Scale Of All Text, UIDefault is 1",
                getFunc = function() return TMSaved.TextScale end,
                setFunc = function(TextScale) TMSaved.TextScale = tonumber(TextScale) end,
                },
            [3] = {
                type = "checkbox",
                name = "Target Frame Champion-Rank Icons On/Off",
                tooltip = "Toggle Target Frame Champion-Rank Icons On/Off.",
                getFunc = function() return TMSaved.TIcons end,
                setFunc = function(value) TMSaved.TIcons = value end,
                },
            [4] = {
                type = "editbox",
                name = "Target Champion-Rank Icon Scale",
                tooltip = "Edit Target Frame Scale Of Champion-Rank Icon, UIDefault is 1",
                getFunc = function() return TMSaved.IconScale end,
                setFunc = function(IconScale) TMSaved.IconScale = tonumber(IconScale) end,
                },
            [5] = {
                type = "checkbox",
                name = "Target Frame Reaction Color Names On/Off",
                tooltip = "Toggle Target Frame Reaction Colors On Names On/Off.",
                getFunc = function() return TMSaved.ReactionColorName end,
                setFunc = function(value) TMSaved.ReactionColorName = value end,
                },
            [6] = {
                type = "checkbox",
                name = "Target Frame Reaction Color Bar On/Off",
                tooltip = "Toggle Target Frame Reaction Colors On Bar On/Off.",
                getFunc = function() return TMSaved.ReactionColorBar end,
                setFunc = function(value) TMSaved.ReactionColorBar = value end,
                },
            [7] = {
                type = "checkbox",
                name = "Target Frame Difficulty Color Levels On/Off",
                tooltip = "Toggle Target Frame Difficulty Colors On Levels On/Off.",
                getFunc = function() return TMSaved.DifficultyColorLevel end,
                setFunc = function(value) TMSaved.DifficultyColorLevel = value end,
                },
            [8] = {
                type = "checkbox",
                name = "Target Frame Difficulity Stars |cFF0000*|r|cFF0000*|r On/Off",
                tooltip = "Toggle Target Frame Difficulity Stars |cFF0000*|r|cFF0000*|r On/Off.",
                getFunc = function() return TMSaved.DifficultyStars end,
                setFunc = function(value) TMSaved.DifficultyStars = value end,
                },
            [9] = {
                type = "checkbox",
                name = "Target Frame Names On/Off",
                tooltip = "Toggle Target Frame Names On/Off.",
                getFunc = function() return TMSaved.TargetName end,
                setFunc = function(value) TMSaved.TargetName = value end,
                },
            [10] = {
                type = "checkbox",
                name = "Target Frame Levels On/Off",
                tooltip = "Toggle Target Frame Levels On/Off.",
                getFunc = function() return TMSaved.TargetLevel end,
                setFunc = function(value) TMSaved.TargetLevel = value end,
                },
            },
		},
        [5] = {  
        type = "submenu",
		name = "Target Frame Player/NPC Options",
		tooltip = "Allows User To Modify Target Frame Player Settings",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Target Player Class/Race/Gender/Alliance/Title On/Off",
                tooltip = "Toggle Target Player Class/Race/Gender/Alliance/Title On/Off.",
                getFunc = function() return TMSaved.TargetInfo end,
                setFunc = function(value) TMSaved.TargetInfo = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Target Player Class On/Off",
                tooltip = "Toggle Target Target Class On/Off.",
                getFunc = function() return TMSaved.TargetClass end,
                setFunc = function(value) TMSaved.TargetClass = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Target Player Race On/Off",
                tooltip = "Toggle Target Target Race On/Off.",
                getFunc = function() return TMSaved.TargetRace end,
                setFunc = function(value) TMSaved.TargetRace = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Target Player Gender On/Off",
                tooltip = "Toggle Target Target Gender On/Off.",
                getFunc = function() return TMSaved.TargetGender end,
                setFunc = function(value) TMSaved.TargetGender = value end,
                },
            [5] = {
                type = "checkbox",
                name = "Target Player Alliance On/Off",
                tooltip = "Toggle Target Player Alliance On/Off.",
                getFunc = function() return TMSaved.TargetAlliance end,
                setFunc = function(value) TMSaved.TargetAlliance = value end,
                },
            [6] = {
                type = "checkbox",
                name = "Target Player Title On/Off",
                tooltip = "Toggle Target Player Title On/Off.",
                getFunc = function() return TMSaved.TargetTitle end,
                setFunc = function(value) TMSaved.TargetTitle = value end,
                },
            },
		},
        [6] = {  
        type = "submenu",
		name = "Target Frame NPC/Pet Options",
		tooltip = "Allows User To Modify Target Frame NPC/Pet Settings",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Force NPC Levels/Vlevels On/Off",
                tooltip = "Force NPC Levels/Vlevels On/Off. (Doesnt Apply If Improved Levels/Vlevels Are On)",
                getFunc = function() return TMSaved.NPCLevel end,
                setFunc = function(value) TMSaved.NPCLevel = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Force Critter Levels/Vlevels On/Off",
                tooltip = "Force Critter Levels/Vlevels On/Off. (Doesnt Apply If Improved Levels/Vlevels Are On)",
                getFunc = function() return TMSaved.CritterLevel end,
                setFunc = function(value) TMSaved.CritterLevel = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Force Collectable Levels/Vlevels On/Off",
                tooltip = "Force Collectable Levels/Vlevels On/Off. (Doesnt Apply If Improved Levels/Vlevels Are On)",
                getFunc = function() return TMSaved.CollectableLevel end,
                setFunc = function(value) TMSaved.CollectableLevel = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Force Pet Levels/Vlevels On/Off",
                tooltip = "Force NPC/Pet Levels/Vlevels On/Off. (Doesnt Apply If Improved Levels/Vlevels Are On)",
                getFunc = function() return TMSaved.PetLevel end,
                setFunc = function(value) TMSaved.PetLevel = value end,
                },
            [5] = {
                type = "checkbox",
                name = "Target NPC Captions On/Off",
                tooltip = "Toggle Target NPC Captions On/Off.",
                getFunc = function() return TMSaved.NPCCaption end,
                setFunc = function(value) TMSaved.NPCCaption = value end,
                },
            },
		},
        [7] = { 
        type = "submenu",
		name = "Target Frame Tag Options",
		tooltip = "Allows User To Modify Target Frame Tag Settings",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "All Informational Target Tags On/Off",
                tooltip = "Toggle All Informational Tags On/Off.",
                getFunc = function() return TMSaved.Tags end,
                setFunc = function(value) TMSaved.Tags = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Target Critter Tags On/Off",
                tooltip = "Toggle Critter Tags On/Off.",
                getFunc = function() return TMSaved.CritterTags end,
                setFunc = function(value) TMSaved.CritterTags = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Target Collectable Tags On/Off",
                tooltip = "Toggle Target Collectable Tags On/Off.",
                getFunc = function() return TMSaved.CollectableTags end,
                setFunc = function(value) TMSaved.CollectableTags = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Target Pet Tags On/Off",
                tooltip = "Toggle Target Pet Tags On/Off.",
                getFunc = function() return TMSaved.PetTags end,
                setFunc = function(value) TMSaved.PetTags = value end,
                },
            [5] = {
                type = "checkbox",
                name = "Target NPC Tags On/Off",
                tooltip = "Toggle Target NPC Tags On/Off.",
                getFunc = function() return TMSaved.NPCTags end,
                setFunc = function(value) TMSaved.NPCTags = value end,
                },
            [6] = {
                type = "checkbox",
                name = "Target PC Tags On/Off",
                tooltip = "Toggle Target PC Tags On/Off.",
                getFunc = function() return TMSaved.PCTags end,
                setFunc = function(value) TMSaved.PCTags = value end,
                },
           
            [7] = {
                type = "checkbox",
                name = "Target Hostile Tags On/Off",
                tooltip = "Toggle Target Hostile Tags On/Off.",
                getFunc = function() return TMSaved.HostileTags end,
                setFunc = function(value) TMSaved.HostileTags = value end,
                },
            [8] = {
                type = "checkbox",
                name = "Target Netural Tags On/Off",
                tooltip = "Toggle Target Netural Tags On/Off.",
                getFunc = function() return TMSaved.NeturalTags end,
                setFunc = function(value) TMSaved.NeturalTags = value end,
                },
            [9] = {
                type = "checkbox",
                name = "Target Dead Tags On/Off",
                tooltip = "Toggle Target Dead Tags On/Off.",
                getFunc = function() return TMSaved.DeadTags end,
                setFunc = function(value) TMSaved.DeadTags = value end,
                },
            [10] = {
                type = "checkbox",
                name = "Target PVP Tags On/Off",
                tooltip = "Toggle Target PVP Tags On/Off.",
                getFunc = function() return TMSaved.TargetPVP end,
                setFunc = function(value) TMSaved.TargetPVP = value end,
                },
            },   
        },
        [8] =  
        {
            type = "checkbox",
            name = "Reticle Frame On/Off",
            tooltip = "Toggle Reticle Frame On/Off.",
            getFunc = function() return TMSaved.ReticleFrame end,
            setFunc = function(value) TMSaved.ReticleFrame = value end,
        },
        [9] = {  
        type = "submenu",
		name = "Reticle Frame Options",
		tooltip = "Allows User To Modify Reticle Frame Settings",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Reticle Frame Improved Levels On/Off",
                tooltip = "Toggle Reticle Frame Improved Levels/Vlevels On/Off. (Moves Level To Top Of Target Name)",
                getFunc = function() return TMSaved.RImprovedLevel end,
                setFunc = function(value) TMSaved.RImprovedLevel = value end,
                },
            [2] = {
                type = "editbox",
                name = "Reticle Text Scale",
                tooltip = "Edit Reticle Frame Scale Of All Text, UIDefault is 1",
                getFunc = function() return TMSaved.RTextScale end,
                setFunc = function(RTextScale) TMSaved.RTextScale = tonumber(RTextScale) end,
                },
            [3] = {
                type = "checkbox",
                name = "Reticle Frame Champion-Rank Icons On/Off",
                tooltip = "Toggle Reticle Frame Champion-Rank Icons On/Off.",
                getFunc = function() return TMSaved.RIcons end,
                setFunc = function(value) TMSaved.RIcons = value end,
                },
            [4] = {
                type = "editbox",
                name = "Reticle Champion-Rank Icon Scale",
                tooltip = "Edit Reticle Frame Scale Of Champion-Rank Icon, UIDefault is 1",
                getFunc = function() return TMSaved.RIconScale end,
                setFunc = function(RIconScale) TMSaved.RIconScale = tonumber(RIconScale) end,
                },
            [5] = {
                type = "checkbox",
                name = "Reticle Frame Reaction Color Names On/Off",
                tooltip = "ToggleReticle Frame Reaction Colors On Names On/Off.",
                getFunc = function() return TMSaved.RReactionColorName end,
                setFunc = function(value) TMSaved.RReactionColorName = value end,
                },
            [6] = {
                type = "checkbox",
                name = "Reticle Frame Reaction Color Retcile On/Off",
                tooltip = "ToggleReticle Frame Reaction Colors On Reticle On/Off.",
                getFunc = function() return TMSaved.RReactionColorReticle end,
                setFunc = function(value) TMSaved.RReactionColorReticle = value end,
                },
            [7] = {
                type = "checkbox",
                name = "Reticle Frame Difficulty Color Levels On/Off",
                tooltip = "Toggle Reticle Frame Difficulty Colors On Levels On/Off.",
                getFunc = function() return TMSaved.RDifficultyColorLevel end,
                setFunc = function(value) TMSaved.RDifficultyColorLevel = value end,
                },
            [8] = {
                type = "checkbox",
                name = "Reticle Frame Difficulity Stars |cFF0000*|r|cFF0000*|r On/Off",
                tooltip = "Toggle Reticle Frame Difficulity Stars |cFF0000*|r|cFF0000*|r On/Off.",
                getFunc = function() return TMSaved.RDifficultyStars end,
                setFunc = function(value) TMSaved.RDifficultyStars = value end,
                },
            [9] = {
                type = "checkbox",
                name = "Reticle Frame Names On/Off",
                tooltip = "Toggle Reticle Frame Names On/Off.",
                getFunc = function() return TMSaved.RPlayerName end,
                setFunc = function(value) TMSaved.RPlayerName = value end,
                },
            [10] = {
                type = "checkbox",
                name = "Reticle Frame Levels On/Off",
                tooltip = "Toggle Reticle Frame Levels On/Off.",
                getFunc = function() return TMSaved.RPlayerLevel end,
                setFunc = function(value) TMSaved.RPlayerLevel = value end,
                },
            },
		},
        [10] = { 
        type = "submenu",
		name = "Reticle Frame Player Options",
		tooltip = "Allows User To Modify Reticle Frame Player Settings",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Reticle Player Class/Race/Gender On/Off",
                tooltip = "Toggle Reticle Player Class/Race/Gender On/Off.",
                getFunc = function() return TMSaved.RPlayerInfo end,
                setFunc = function(value) TMSaved.RPlayerInfo = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Reticle Player Class On/Off",
                tooltip = "Toggle Reticle Player Class On/Off.",
                getFunc = function() return TMSaved.RPlayerClass end,
                setFunc = function(value) TMSaved.RPlayerClass = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Reticle Player Race On/Off",
                tooltip = "Toggle Reticle Player Race On/Off.",
                getFunc = function() return TMSaved.RPlayerRace end,
                setFunc = function(value) TMSaved.RPlayerRace = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Reticle Player Gender On/Off",
                tooltip = "Toggle Reticle Player Gender On/Off.",
                getFunc = function() return TMSaved.RPlayerGender end,
                setFunc = function(value) TMSaved.RPlayerGender = value end,
                },
            [5] = {
                type = "checkbox",
                name = "Reticle Player Alliance On/Off",
                tooltip = "Toggle Reticle Player Alliance On/Off.",
                getFunc = function() return TMSaved.RPlayerAlliance end,
                setFunc = function(value) TMSaved.RPlayerAlliance = value end,
                },
            [6] = {
                type = "checkbox",
                name = "Reticle Player Title On/Off",
                tooltip = "Toggle Reticle Player Title On/Off.",
                getFunc = function() return TMSaved.RPlayerTitle end,
                setFunc = function(value) TMSaved.RPlayerTitle = value end,
                },
            },   
        },
        [11] = {  
        type = "submenu",
		name = "Reticle Frame NPC/Pet Options",
		tooltip = "Allows User To Modify Reticle Frame NPC/Pet Settings",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "Reticle NPC Captions On/Off",
                tooltip = "Toggle Reticle NPC Captions On/Off.",
                getFunc = function() return TMSaved.RNPCCaption end,
                setFunc = function(value) TMSaved.RNPCCaption = value end,
                },
            },
		},
        [12] = { 
        type = "submenu",
		name = "Reticle Frame Tag Options",
		tooltip = "Allows User To Modify Raticle Frame Tag Settings",	
		controls = {
            [1] = {
                type = "checkbox",
                name = "All Reticle Informational Tags On/Off",
                tooltip = "Toggle All Reticle Informational Tags On/Off.",
                getFunc = function() return TMSaved.RTags end,
                setFunc = function(value) TMSaved.RTags = value end,
                },
            [2] = {
                type = "checkbox",
                name = "Reticle Critter Tags On/Off",
                tooltip = "Toggle Reticle Critter Tags On/Off.",
                getFunc = function() return TMSaved.RCritterTags end,
                setFunc = function(value) TMSaved.RCritterTags = value end,
                },
            [3] = {
                type = "checkbox",
                name = "Reticle Collectable Tags On/Off",
                tooltip = "Toggle Reticle Collectable Tags On/Off.",
                getFunc = function() return TMSaved.RCollectableTags end,
                setFunc = function(value) TMSaved.RCollectableTags = value end,
                },
            [4] = {
                type = "checkbox",
                name = "Reticle Pet Tags On/Off",
                tooltip = "Toggle Reticle Pet Tags On/Off.",
                getFunc = function() return TMSaved.RPetTags end,
                setFunc = function(value) TMSaved.RPetTags = value end,
                },
            [5] = {
                type = "checkbox",
                name = "Reticle NPC Tags On/Off",
                tooltip = "Toggle Reticle NPC Tags On/Off.",
                getFunc = function() return TMSaved.RNPCTags end,
                setFunc = function(value) TMSaved.RNPCTags = value end,
                },
            [6] = {
                type = "checkbox",
                name = "Reticle PC Tags On/Off",
                tooltip = "Toggle Reticle PC Tags On/Off.",
                getFunc = function() return TMSaved.RPCTags end,
                setFunc = function(value) TMSaved.RPCTags = value end,
                },
            [7] = {
                type = "checkbox",
                name = "Reticle Hostile Tags On/Off",
                tooltip = "Toggle Reticle Hostile Tags On/Off.",
                getFunc = function() return TMSaved.RHostileTags end,
                setFunc = function(value) TMSaved.RHostileTags = value end,
                },
            [8] = {
                type = "checkbox",
                name = "Reticle Netural Tags On/Off",
                tooltip = "Toggle Reticle Netural Tags On/Off.",
                getFunc = function() return TMSaved.RNeturalTags end,
                setFunc = function(value) TMSaved.RNeturalTags = value end,
                },
            [9] = {
                type = "checkbox",
                name = "Reticle Dead Tags On/Off",
                tooltip = "Toggle Reticle Dead Tags On/Off.",
                getFunc = function() return TMSaved.RDeadTags end,
                setFunc = function(value) TMSaved.RDeadTags = value end,
                },
            [10] = {
                type = "checkbox",
                name = "Reticle PVP Tags On/Off",
                tooltip = "Toggle Reticle PVP Tags On/Off.",
                getFunc = function() return TMSaved.RPlayerPVP end,
                setFunc = function(value) TMSaved.RPlayerPVP = value end,
                },
            },   
        },
        [13] =  
        {
            type = "editbox",
            name = "Edit Reticle Scale.",
            tooltip = "Edit Reticle Scale. UIDefault is 1",
            getFunc = function() return TMSaved.RScale end,
            setFunc = function(RScale) TMSaved.RScale = tonumber(RScale) end,
        },
    }   
    LAM2:RegisterAddonPanel(PanelTitle.."LAM2Options", PanelData)
    LAM2:RegisterOptionControls(PanelTitle.."LAM2Options", OptionsData)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------      