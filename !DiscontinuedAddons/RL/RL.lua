local AddName = "RL"
local Version = "Version 100004.1"
local Author = "Created By SkOODaT"
local PanelHeader = "_SkOODaT"
local PanelTitle = "SkOODaTs AddOns"

local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")

local DebugMode = false

RL = {}

SLASH_COMMANDS["/rl"] = function() ReloadUI("ingame") end
SLASH_COMMANDS["/reload"] = function() ReloadUI("ingame") end

ZO_CreateStringId("SI_BINDING_NAME_RLOAD_UI", "Reload UI")

function OnAddonLoaded(Event, AddonName)
   if AddonName == AddName then
        RLCreateSettings()                                                      --Start Settings Panel
   end
end

function RLCreateSettings()
    local Panel = LAM:CreateControlPanel(PanelHeader, PanelTitle)                       -- Panel
    LAM:AddHeader(Panel, "RL_General", "|cFFFFB0" ..AddName.. "|r")                                        -- Panel Title
    
    if DebugMode == true then
        LAM:AddDescription(Panel, "RL_Text_Debug1", "*************")
        LAM:AddDescription(Panel, "RL_Text_Debug2", "Debug Mode On")
        LAM:AddDescription(Panel, "RL_Text_Debug3", "*************")
    end
    
    LAM:AddDescription(Panel, "RL_Text_Info", "Simple Addon ReloadUI With /rl or /reload Or Key Binding.")
    LAM:AddDescription(Panel, "RL_Text_End", AddName .. " " .. Version .. " " .. Author)
end

EVENT_MANAGER:RegisterForEvent("RL", EVENT_ADD_ON_LOADED, OnAddonLoaded)                -- Load This Bitch