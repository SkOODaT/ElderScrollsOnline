--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_HandleDebug(objectToOutput)                                                                   
    SLASH_COMMANDS["/script"](objectToOutput)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_HandleExecute(code)
    SLASH_COMMANDS["/script"](code)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_HandleRL()
    ReloadUI("ingame")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_HandleClear(_param)
    if( _param == "all" ) then
        for i = 1, GetNumChatContainerTabs(1), 1 do
            _G["ZO_ChatWindowTemplate"..i.."Buffer"]:Clear()
        end
    elseif( _param == "tabs" ) then
        for i = 1, GetNumChatContainerTabs(1), 1 do
            _G["ZO_ChatWindowTemplate"..i.."Buffer"]:Clear()
        end
    else
        for i = 1, GetNumChatContainerTabs(1), 1 do
            if( _G["ZO_ChatWindowTabTemplate"..i]:GetDrawLevel()==2) then
                _G["ZO_ChatWindowTemplate"..i.."Buffer"]:Clear()
            end
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_RequestFriend(text)
    local Target
    local Note
    Target, Note = string.match(text, "(@%w+),?%s?(.*)")
    if Target == nil or Target == "" then
        Target, Note = string.match(text, "([%w%s]+),%s?(.*)")
    end
    if Target == nil or Target == "" then
        Target = string.match(text, "([%w%s]+)")
    end
    RequestFriend(Target, Note)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_RemoveFriend(text)
    if text == nil then return end
    if not IsFriend(text) then
        CMPrintText("You Are Not Friends With \""..text.."\"")
        return
    end
    RemoveFriend(text)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_AddIgnore(text)
    local Target
    local Note
    Target, Note = string.match(text, "(@%w+),?%s?(.*)")
    if Target == nil or Target == "" then
        Target, Note = string.match(text, "([%w%s]+),%s?(.*)")
    end
    if Target == nil or Target == "" then
        Target = string.match(text, "([%w%s]+)")
    end
    if Target == nil then Target = "" end
    if Note == nil then Note = "" end
    AddIgnore(Target)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_RemoveIgnore(text)
    if text == nil then return end
    if not IsIgnored(text) then
        CMPrintText("You Are Not Ignoring \""..text.."\"")
        return
    end
    RemoveIgnore(text)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GroupKick(text)
    local Name = ""
    if text == nil then
        text = ""
    end
    if (IsPlayerInGroup(text.."^Mx")) then
        Name = text.."^Mx"
    elseif (IsPlayerInGroup(text.."^Fx")) then
        Name = text.."^Fx"
    else
        CMPrintText("Player \""..text.."\" Is Not In Your Group.");
        return
    end
    GroupKickByName(Name)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildInvite(guildId, displayName)
    if guildId == nil then
        return
    end
    if displayName == nil then
        return
    end
    if guildId > GetNumGuilds() then
        CMPrintText("You Do Not Have A Guild "..guildId..".");
        return
    end
    GuildInvite(guildId, displayName)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildLeave(guildId)
    if guildId == nil then
        return
    end
    if guildId > GetNumGuilds() then
        CMPrintText("You Do Not Have A Guild "..guildId..".");
        return
    end
    GuildLeave(guildId)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildInvite1(text)
    CHM_GuildInvite(1, text)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildInvite2(text)
    CHM_GuildInvite(2, text)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildInvite3(text)
    CHM_GuildInvite(3, text)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildInvite4(text)
    CHM_GuildInvite(4, text)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildInvite5(text)
    CHM_GuildInvite(5, text)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildLeave1()
    CHM_GuildLeave(1)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildLeave2()
    CHM_GuildLeave(2)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildLeave3()
    CHM_GuildLeave(3)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildLeave4()
    CHM_GuildLeave(4)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_GuildLeave5()
    CHM_GuildLeave(5)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_Money()
    local Cash = GetCurrentMoney()
    local Bank = GetBankedMoney()
    CMPrintText("Cash: |cFFFC96"..tostring(Cash).."|r Gold.")
    CMPrintText("Bank: |cFFFC96"..tostring(Bank).."|r Gold.")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_Mail(text)
    if ( text ~= "" ) then
        CMPrintText("|c66FF33Sending Mail...|r")
        local To, Sub, Body = text:match("(%S+)%s*(%S+)%s*(.*)")
        SendMail( To, Sub, Body)
    else
        CMPrintText("Usage: |c66FF33/mail [To] [Subject] [Body]|r")
        CMPrintText("Send An In Game Mail To Another Player.")
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_Play()
    CMPrintText("Time Played: |c66FF33"..tostring(Round(GetSecondsPlayed("player")/86400,2)).."|r days.")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_Repair()
    CMPrintText("|c66FF33Attempting Repair...|r")
    RepairAll()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_RepairCost()
    CMPrintText("Total Repair Cost: |cFFFC96"..tostring(GetRepairAllCost("player")).."|r Gold.")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_Location()
    CMPrintText("Current Location Is: |c66FF33"..GetPlayerLocationName("player").."|r.")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_WayShrine()
    CMPrintText("Current WayShrine Attunment Is: |c66FF33"..GetMapName().."|r.")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_Name()
    CMPrintText("Your Account Name Is: |c66FF33"..GetDisplayName("player").."|r.")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CHM_EKick()
    PlayEmote(108)
    return
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------