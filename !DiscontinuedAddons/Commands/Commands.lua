local AddName = "Commands"
local Version = "Version 100004.1"
local Author = "Created By SkOODaT"
local PanelHeader = "_SkOODaT"
local PanelTitle = "SkOODaTs AddOns"

local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")

local DebugMode = false

Commands = {}

function Round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function Commands_handleDebug(objectToOutput)
    SLASH_COMMANDS["/script"]("d(" .. objectToOutput .. ")")
end

function Commands_handleExecute(code)
    SLASH_COMMANDS["/script"](code)
end

function Commands_GuildInvite(guildId, displayName)
    if guildId == nil then
        return
    end
    if displayName == nil then
        return
    end
    GuildInvite(guildId, displayName)
    return
end

function Commands_GuildLeave(guildId)
    if guildId == nil then
        return
    end
    GuildLeave(guildId)
    return
end

function Commands_GuildInvite1(text)
    Commands_GuildInvite(1, text)
    return
end

function Commands_GuildInvite2(text)
    Commands_GuildInvite(2, text)
    return
end

function Commands_GuildInvite3(text)
    Commands_GuildInvite(3, text)
    return
end

function Commands_GuildInvite4(text)
    Commands_GuildInvite(4, text)
    return
end

function Commands_GuildInvite5(text)
    Commands_GuildInvite(5, text)
    return
end

function Commands_GuildLeave1()
    Commands_GuildLeave(1)
    return
end

function Commands_GuildLeave2()
    Commands_GuildLeave(2)
    return
end

function Commands_GuildLeave3()
    Commands_GuildLeave(3)
    return
end

function Commands_GuildLeave4()
    Commands_GuildLeave(4)
    return
end

function Commands_GuildLeave5()
    Commands_GuildLeave(5)
    return
end

function Commands_Money()
    local cash = GetCurrentMoney()
    local bank = GetBankedMoney()
    d( "|cFF6633Cash: |c66FF33" .. tostring(cash) .. "|r" )
    d( "|cFF6633Bank: |c66FF33" .. tostring(bank) .. "|r" )
end

function Commands_Mail(text)
    if ( text ~= "" ) then
        d( "|c33FF66Sending Mail...|r" )
        local to, sub, body = text:match( "(%S+)%s*(%S+)%s*(.*)" )
        SendMail( to, sub, body)
    else
        d("|cFF6633Usage: /mail [to] [subject] [body]|r")
        d("|cFF6633	Send an in game mail to another player.|r")
    end
end

function Commands_Play()
		d( "|cFF6633Time Played: |c66FF33" .. tostring( Round( GetSecondsPlayed("player") / 86400, 2 ) ) .. " days.|r" )
	end

function Commands_Repair()
    d( "|c33FF66Attempting Repair...|r" )
    RepairAll()
end

function Commands_RepairCost()
    d( "|cFF6633Total Repair Cost: |c66FF33" .. tostring(GetRepairAllCost("player")) .. "|r" )
end

function Commands_Location()
    d( "|c66FF33" .. GetPlayerLocationName("player") .. "|r" )
end

function Commands_Name()
    d( "|c66FF33" .. GetDisplayName("player") .. "|r" )
end

function Commands_WayShrine()
    d( "|c66FF33Current WayShrine Attunment Is |r|cFFFFFF" .. GetMapName() .. "|r" )
end

function OnAddonLoaded(Event, AddonName)
   if AddonName == AddName then
        CCreateSettings()                                                               -- Start Settings Panel
        SLASH_COMMANDS["/leave"]    = GroupLeave                                        -- Register Slash Commands
        SLASH_COMMANDS["/disband"]  = GroupDisband
        SLASH_COMMANDS["/g1invite"] = Commands_GuildInvite1
        SLASH_COMMANDS["/g2invite"] = Commands_GuildInvite2
        SLASH_COMMANDS["/g3invite"] = Commands_GuildInvite3
        SLASH_COMMANDS["/g4invite"] = Commands_GuildInvite4
        SLASH_COMMANDS["/g5invite"] = Commands_GuildInvite5
        SLASH_COMMANDS["/g1quit"]   = Commands_GuildLeave1
        SLASH_COMMANDS["/g2quit"]   = Commands_GuildLeave2
        SLASH_COMMANDS["/g3quit"]   = Commands_GuildLeave3
        SLASH_COMMANDS["/g4quit"]   = Commands_GuildLeave4
        SLASH_COMMANDS["/g5quit"]   = Commands_GuildLeave5

        SLASH_COMMANDS["/money"]    = Commands_Money
        SLASH_COMMANDS["/mail"]     = Commands_Mail
        SLASH_COMMANDS["/play"]     = Commands_Play
        SLASH_COMMANDS["/repair"]   = Commands_Repair
        SLASH_COMMANDS["/repaircost"] = Commands_RepairCost
        SLASH_COMMANDS["/location"] = Commands_Location
        SLASH_COMMANDS["/whoami"]   = Commands_Name
        
        SLASH_COMMANDS["/way"]   = Commands_WayShrine
        
        SLASH_COMMANDS["/sc"]   = Commands_handleExecute
        SLASH_COMMANDS["/d"]   = Commands_handleDebug
   end
end

function CCreateSettings()
    local Panel = LAM:CreateControlPanel(PanelHeader, PanelTitle)                               -- Panel
    LAM:AddHeader(Panel, "Commands_General", "|cFFFFB0" ..AddName.. "|r")                       -- Panel Title
    
    if DebugMode == true then
        LAM:AddDescription(Panel, "Commands_Text_Debug1", "*************")
        LAM:AddDescription(Panel, "Commands_Text_Debug2", "Debug Mode On")
        LAM:AddDescription(Panel, "Commands_Text_Debug3", "*************")
    end
    
    LAM:AddDescription(Panel, "Commands_Text_Info", "Simple Addon For Slash Commands, /leave, /disband, /g1invite.. /g1quit.. /money, /mail, /play, /repair, /repaircost, /location, /whoami, /way, /d, /sc.")
    LAM:AddDescription(Panel, "Commands_Text_End", AddName .. " " .. Version .. " " .. Author)
end

EVENT_MANAGER:RegisterForEvent("Commands", EVENT_ADD_ON_LOADED, OnAddonLoaded)                  -- Load This Bitch
