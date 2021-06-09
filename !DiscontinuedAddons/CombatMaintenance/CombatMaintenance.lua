local AddName = "CombatMaintenance"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Timer = 0                                                                                                         -- Set Timer Var To Zero To Start
local TValue = 75                                                                                                       -- How Long The Timer Runs   
local EVTimer = 10                                                                                                      -- Event Timer Value Set To 10 (0.01 Seconds) Very Fast
local StuffOn = false                                                                                                   -- Set Weapon and Helm Var To False To Start             
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
ZO_CreateStringId("SI_BINDING_NAME_HELMET_TOGGLE", "Helmet Toggle")                                                     -- Helmet Binding
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CBMSavedVariables()                                                                                            -- Saved Vars
    CBMSaved = ZO_SavedVars:New("CombatMaintenance_SavedVariables", 1, nil, 
    {
        Toggle = true,
        Weapon = true,
        Pair = true,
        Helmet = true,
    })                                                           
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CBMUpdate()
    if not CBMSaved.Toggle then return end                                                                              -- If The Addon Isn't Enabled Return
    if IsUnitInCombat("player") then return end                                                                         -- If Player Is In Combat Return
    if not StuffOn then return end                                                                                      -- If Weapon and Helm Var On Then  
    if Timer > TValue then                                                                                              -- If Timer Is Above TValue
        if CBMSaved.Weapon then                                                                                         -- Is Weapon Toggle On In Settings?
            TogglePlayerWield()                                                                                         -- Toggle Weapon Once Away ~ Thiers A Bug In ESO That Sticks Stowing Occasionally
        end
        if CBMSaved.Helmet then                                                                                         -- Is Helmet Toggle On In Settings?
            CBMHelmOff()                                                                                                -- Hide Helm Once
        end
        StuffOn = false                                                                                                 -- Weapon and Helm Var Set To False
        Timer = 0                                                                                                       -- Timer Set To Zero Again
        EVENT_MANAGER:UnregisterForUpdate("CombatMaintenance_Update", CBMUpdate)                                           -- Unregister Update For Timer After Helm and Weapon Fires Once
    else
        Timer = Timer + 1                                                                                               -- Else Set Timer To Plus 1 And Add To Base   
        --d(Timer)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CombatMaintenanceOnCombat() 
    if not CBMSaved.Toggle then return end                                                                              -- Is Addon Enabled
    if not IsUnitInCombat("player") then return end                                                                     -- Player In Combat?
    CBMHelmOn()                                                                                                         -- Show Helm
    StuffOn = true                                                                                                      -- Weapon and Helm Var Set To True
    EVENT_MANAGER:RegisterForUpdate("CombatMaintenance_Update", EVTimer, CBMUpdate)                                        -- Register Update For Timer
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CBMPairChanged()
    if not CBMSaved.Toggle then return end                                                                              -- If The Addon Isn't Enabled Return
    if not CBMSaved.Pair then return end                                                                                -- Is Pair Toggle On In Settings?
    if IsUnitInCombat("player") then return end                                                                         -- If Player Is In Combat Return
    TogglePlayerWield()                                                                                                 -- Toggle Weapon Once Away ~ Thiers A Bug In ESO That Sticks Stowing Occasionally
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CBMSlashHelm()                                                                                                 -- Helm Slash Command
    if GetSetting(SETTING_TYPE_IN_WORLD, IN_WORLD_UI_SETTING_HIDE_HELM) == "1" then
        CBMHelmOn()
    else
        CBMHelmOff()
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CBMOffHelm()                                                                                                   -- Option Toggle Refresh Off/Put Helm On, On/Take Helm Off
    if not CBMSaved.Helmet and GetSetting(SETTING_TYPE_IN_WORLD, IN_WORLD_UI_SETTING_HIDE_HELM) == "1" then             -- Get Helmet Status (Not Equiped)
        CBMHelmOn()
    elseif CBMSaved.Helmet and GetSetting(SETTING_TYPE_IN_WORLD, IN_WORLD_UI_SETTING_HIDE_HELM) == "0" then             -- Get Helmet Status (Equiped)
        CBMHelmOff()
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CBMHelmOn()
    SetSetting(SETTING_TYPE_IN_WORLD, IN_WORLD_UI_SETTING_HIDE_HELM, "0" )                                              -- Put Helmet On
end
function CBMHelmOff()
    SetSetting(SETTING_TYPE_IN_WORLD, IN_WORLD_UI_SETTING_HIDE_HELM, "1" )                                              -- Take Helmet Off
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CombatMaintenanceOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    CBMSavedVariables()
    SLASH_COMMANDS["/helm"] = CBMSlashHelm 
    EVENT_MANAGER:RegisterForEvent("CombatMaintenance_Player", EVENT_PLAYER_ACTIVATED,
    function()
    CBMLAM2Panel()                                                                                                          -- Start Settings Panel
        EVENT_MANAGER:RegisterForEvent("CombatMaintenance_OnPair", EVENT_ACTIVE_WEAPON_PAIR_CHANGED, CBMPairChanged)
        EVENT_MANAGER:UnregisterForEvent("CombatMaintenance_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("CombatMaintenance_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("CombatMaintenance_OnLoad", EVENT_ADD_ON_LOADED, CombatMaintenanceOnLoad)                          -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("CombatMaintenance_OnCombat", EVENT_PLAYER_COMBAT_STATE, CombatMaintenanceOnCombat)                -- Combat Event 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------