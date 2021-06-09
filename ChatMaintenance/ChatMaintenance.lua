local AddName = "ChatMaintenance"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHMSavedVariables()
    CHMSaved = ZO_SavedVars:New("ChatMaintenance_SavedVariables", 1, nil, 
    { 
        --Toggle = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
ZO_CreateStringId("SI_BINDING_NAME_RLOAD_UI", "Reload UI")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHMSlashCommands()
    SLASH_COMMANDS["/sc"]           = CHM_HandleExecute
    SLASH_COMMANDS["/d"]            = CHM_HandleDebug
    SLASH_COMMANDS["/rl"]           = CHM_HandleRL
    SLASH_COMMANDS["/reload"]       = CHM_HandleRL
    SLASH_COMMANDS["/clr"]          = CHM_HandleClear
    
    SLASH_COMMANDS["/langen"]       = function() SetCVar("language.2", "en") end
    SLASH_COMMANDS["/langde"]       = function() SetCVar("language.2", "de") end
    SLASH_COMMANDS["/langfr"]       = function() SetCVar("language.2", "fr") end
    SLASH_COMMANDS["/langru"]       = function() SetCVar("language.2", "ru") end
    
    SLASH_COMMANDS["/friend"]       = CHM_RequestFriend
    SLASH_COMMANDS["/unfriend"]     = CHM_RemoveFriend
    SLASH_COMMANDS["/ignore"]       = CHM_AddIgnore
    SLASH_COMMANDS["/unignore"]     = CHM_RemoveIgnore
    
    SLASH_COMMANDS["/ekick"]        = CHM_EKick
    
    SLASH_COMMANDS["/leave"]        = GroupLeave                                        
    SLASH_COMMANDS["/disband"]      = GroupDisband
    SLASH_COMMANDS["/kick"]         = CHM_GroupKick
    SLASH_COMMANDS["/remove"]       = CHM_GroupKick
    
    SLASH_COMMANDS["/g1invite"]     = CHM_GuildInvite1
    SLASH_COMMANDS["/g2invite"]     = CHM_GuildInvite2
    SLASH_COMMANDS["/g3invite"]     = CHM_GuildInvite3
    SLASH_COMMANDS["/g4invite"]     = CHM_GuildInvite4
    SLASH_COMMANDS["/g5invite"]     = CHM_GuildInvite5
    SLASH_COMMANDS["/g1quit"]       = CHM_GuildLeave1
    SLASH_COMMANDS["/g2quit"]       = CHM_GuildLeave2
    SLASH_COMMANDS["/g3quit"]       = CHM_GuildLeave3
    SLASH_COMMANDS["/g4quit"]       = CHM_GuildLeave4
    SLASH_COMMANDS["/g5quit"]       = CHM_GuildLeave5

    SLASH_COMMANDS["/money"]        = CHM_Money
    SLASH_COMMANDS["/mail"]         = CHM_Mail
    SLASH_COMMANDS["/play"]         = CHM_Play
    SLASH_COMMANDS["/repair"]       = CHM_Repair
    SLASH_COMMANDS["/repaircost"]   = CHM_RepairCost
    SLASH_COMMANDS["/location"]     = CHM_Location
    SLASH_COMMANDS["/way"]          = CHM_WayShrine
    SLASH_COMMANDS["/whoami"]       = CHM_Name
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CMPrintText(text)
    ZO_ChatWindowTemplate1Buffer:AddMessage(text)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ChatMaintenanceOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end                                                                          
    CHMSavedVariables()
    CHMSlashCommands()
    EVENT_MANAGER:RegisterForEvent("ChatMaintenance_Player", EVENT_PLAYER_ACTIVATED,
    function()
    CHMLAM2Panel()                                                                                           -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("ChatMaintenance_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("ChatMaintenance_OnLoad", EVENT_ADD_ON_LOADED)
end    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
EVENT_MANAGER:RegisterForEvent("ChatMaintenance_OnLoad", EVENT_ADD_ON_LOADED, ChatMaintenanceOnLoad)                    -- Load This Bitch
--------------------------------------------------------------------------------------------------------------------------------------------------------------------