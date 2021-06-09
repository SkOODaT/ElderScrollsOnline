local AddName = "MageLight"
local Version = "Version 100004.1"
local Author = "Created By SkOODaT"
local PanelHeader = "_SkOODaT"
local PanelTitle = "SkOODaTs AddOns"

local MageLight = {}
local MageLight_Ace = {}
LibStub("AceTimer-3.0"):Embed(MageLight_Ace)
local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local OUTPUT = "NEED MAGE/INNER LIGHT!"
local Timer = 1                                                                         -- How Long Between Alerts You Can Change This Default Is 1 Sec
local IsMLOut = 0
local IsMLOnBar = 0
local MLSaved

local DebugMode = false

function MLDefaultVariables()
    MLDefaults = 
    { 
        ["Toggle"] = true, 
        ["Chat"] = true,
        ["Alert"] = false,        
        ["Sound"] = true, 
        ["PSBT"] = false 
    }
end

function MLSavedVariables()
        MLSaved = ZO_SavedVars:New("MageLightSavedVars", 1, nil, MLDefaults)
end

local MLLoadTimer = MageLight_Ace:ScheduleRepeatingTimer(                             -- AceTimer 3.0 Awesomeness Wrap Entire Function Better Then OnTarget Call
function(Event, Unit)
    local Name = GetUnitName("player")
    local Reaction = GetUnitReaction("reticleover")
    if IsUnitDead("player") then return end
	for i = 1, GetNumBuffs("player") do
		local BuffName = GetUnitBuffInfo("player", i)
        if BuffName == "Mage Light" or BuffName == "Inner Light" then -- ALL Lights 
            IsMLOut = 1
            return                                                                                          -- If ML Is Found END no More Searching (Took Me Hours To figure This Fix Out :S Newbe)
        else 
            IsMLOut = 0
        end
        if DebugMode == true then
            d(BuffName)
        end
    end
    for s = 1, 7 do
        local Ability = GetSlotName(s)
        if Ability == "Mage Light" or Ability == "Inner Light" then
            IsMLOnBar = 1
            break
        else
            IsMLOnBar = 0
        end
    end
    --d(IsMLOnBar) 
    if DoesUnitExist("reticleover") then    
        if MLSaved.Toggle then
            if IsMLOut == 0 and IsMLOnBar == 1 then
                if Reaction == UNIT_REACTION_HOSTILE or IsUnitPlayer("reticleover") and IsUnitAttackable("reticleover") then   -- NPC Hostile Reaction Or PVP Players
                    if MLSaved.Chat then
                        ZO_ChatWindowTemplate1Buffer:AddMessage(OUTPUT)                   -- Chat Warning
                        if DebugMode == true then
                            d(OUTPUT)                                                      
                        end
                    end
                    if MLSaved.Alert then
                     ZO_Alert(1, 1, OUTPUT)                                                -- ZO Alert Frame
                    end
                    if MLSaved.PSBT then
                        PSBT:NewEvent( PSBT_AREAS.NOTIFICATION, true, nil, OUTPUT)    -- PSBT Warning
                    end
                    if MLSaved.Sound then
                        PlaySound( 'Quest_StepFailed' )                                                     --Sound Warning
                    end
                    if DebugMode == true then
                        d(OUTPUT)
                    end
                end
            end
        end
    end 
end, 
Timer) 

function OnAddonLoaded(EventCode, AddonName)
    if AddonName == AddName then
        if GetUnitClass("player") == "Sorcerer" then                                                         -- Get Player Class And If Sorcerer Start And Create Options
            MLDefaultVariables()
            MLSavedVariables()
            MLCreateSettings()
        end
    end
end

function MLCreateSettings()
    local Panel = LAM:CreateControlPanel(PanelHeader, PanelTitle)                                           -- Panel
    LAM:AddHeader(Panel, "MageLight_General", "|cFFFFB0" ..AddName.. "|r")                                  -- Panel Title
    
    if DebugMode == true then
        LAM:AddDescription(Panel, "MageLight_Text_Debug1", "*************")
        LAM:AddDescription(Panel, "MageLight_Text_Debug2", "Debug Mode On")
        LAM:AddDescription(Panel, "MageLight_Text_Debug3", "*************")
    end
    
    LAM:AddDescription(Panel, "MageLight_Text_Info", "Simple Addon To Notifiy You If Your Mage/Inner Light Has Dissapeared As It Does VERY Often.")
    --LAM:AddDescription(Panel, "MageLight_Text_Line1", "------------------------------------------------------------------------------------")
    
    LAM:AddCheckbox(Panel, "MageLight_Option_Toggle", "MageLight On/Off", "Toggle Overall Addon MageLight Easily On/Off.", function() return MLSaved.Toggle end, function() MLSaved.Toggle = not MLSaved.Toggle end )
    LAM:AddCheckbox(Panel, "MageLight_Option_Chat", "Chat Output On/Off", "Toggle Chat Output Easily On/Off.", function() return MLSaved.Chat end, function() MLSaved.Chat = not MLSaved.Chat end )
    LAM:AddCheckbox(Panel, "MageLight_Option_Alert", "Alert Output On/Off", "Toggle Alert Output On/Off.", function() return MLSaved.Alert end, function() MLSaved.Alert = not MLSaved.Alert end )
    LAM:AddCheckbox(Panel, "MageLight_Option_PSBT", "PSBT Notifications On/Off", "Toggle PSBT Notifications On/Off. (Only Use If PSBT Is Installed)", function() return MLSaved.PSBT end, function() MLSaved.PSBT = not MLSaved.PSBT end )
    LAM:AddCheckbox(Panel, "MageLight_Option_Sound", "Sound Notifications On/Off", "Toggle Sound Notifications On/Off.", function() return MLSaved.Sound end, function() MLSaved.Sound = not MLSaved.Sound end )
    
    --LAM:AddDescription(Panel, "MageLight_Text_Line2", "------------------------------------------------------------------------------------")
    LAM:AddDescription(Panel, "MageLight_Text_End", AddName .. " " .. Version .. " " .. Author)
end

EVENT_MANAGER:RegisterForEvent("MageLight", EVENT_ADD_ON_LOADED, OnAddonLoaded)                   -- Load This Bitch