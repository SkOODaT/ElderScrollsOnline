local AddName = "TargetMaintenance"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMSavedVariables()                                                                                                     -- Saved Vars
    TMSaved = ZO_SavedVars:New("TargetMaintenance_SavedVariables", 1, nil, 
    { 
        Toggle = true,                          -- On/Off
        -- Target Settings ---------------------------------------------------------------------------------------------------------------------
        TargetFrame = true,
        ImprovedLevel = true,                   -- Always Show LV And Move It/Anchor Name To It
        TextScale = 1.0,
        IconScale = 1.0,
        TIcons = true,
        ReactionColorName = true,               -- Reaction Color On The Target Name
        ReactionColorBar = true,
        DifficultyColorLevel = true,
        DifficultyStars = true,
        -- Target NPC/PET ---------------------------------------------------------------------------------------------------------------------
        CritterLevel = false, 
        CollectableLevel = false, 
        PetLevel = false, 
        NPCLevel = false,                       -- Force NPC Level
        NPCCaption = true,                       -- Toggle NPC Captions
        -- Target Player Information ---------------------------------------------------------------------------------------------------------------------
        TargetInfo = true,                      -- Show On Ally / Player
        TargetName = true,                     
        TargetLevel = true, 
        TargetClass = true,                     -- Class
        TargetRace = true,                      -- Race
        TargetGender = true,                    -- Gender
        TargetAlliance = true,                  -- Alliance
        TargetTitle = true,                     -- Title
        TargetPVP = true, 
        -- Target Informational Tags ---------------------------------------------------------------------------------------------------------------------
        Tags = true,                 
        CritterTags = true, 
        CollectableTags = true, 
        PetTags = true, 
        NPCTags = true, 
        PCTags = true, 
        HostileTags = true, 
        NeturalTags = true,
        DeadTags = true,        
        
        -- Reticle Settings ---------------------------------------------------------------------------------------------------------------------
        ReticleFrame = true,
        RImprovedLevel = true,
        RTextScale = 1.0,
        RIconScale = 1.0,
        RIcons = true,
        RReactionColorName = true,               -- Reaction Color On The Target Name
        RReactionColorReticle = true,
        RDifficultyColorLevel = true,
        RDifficultyStars = true,
        -- Reticle NPC/PET ---------------------------------------------------------------------------------------------------------------------
        RNPCCaption = true,
        -- Reticle Player Information ---------------------------------------------------------------------------------------------------------------------
        RPlayerInfo = true,                     -- Show On Ally / Player
        RPlayerName = true,                    -- Name
        RPlayerLevel = true,                     -- Level
        RPlayerClass = true,                    -- Class
        RPlayerRace = true,                     -- Race
        RPlayerGender = true,                   -- Gender
        RPlayerAlliance = true,                 -- Alliance
        RPlayerTitle = true,                    -- Title
        RPlayerPVP = true,
        -- Reticle Informational Tags ---------------------------------------------------------------------------------------------------------------------
        RTags = true,                 
        RCritterTags = true, 
        RCollectableTags = true, 
        RPetTags = true, 
        RNPCTags = true, 
        RPCTags = true, 
        RHostileTags = true, 
        RNeturalTags = true,
        RDeadTags = true,
        
        RScale = 0.80,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TargetMaintenanceOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    TMSavedVariables()                                                                                                          -- Load Saved Vars
    TMReticleScale()
    TMStartUpOnUpdate()
    TMReticleLoad()
    EVENT_MANAGER:RegisterForEvent("TargetMaintenance_Player", EVENT_PLAYER_ACTIVATED,
    function()
        TMLAM2Panel()                                                                                                          -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("TargetMaintenance_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("TargetMaintenance_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("TargetMaintenance_OnLoad", EVENT_ADD_ON_LOADED, TargetMaintenanceOnLoad)                              -- Load This Bitch
--------------------------------------------------------------------------------------------------------------------------------------------------------------------