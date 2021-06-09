local AddName = "NPCReticle"
local Version = "Version 100004.1"
local Author = "Created By SkOODaT"
local PanelHeader = "_SkOODaT"
local PanelTitle = "SkOODaTs AddOns" 

local NPCReticle = {}
local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local NPCSaved
local DebugMode = false

function NPCRDefaultVariables()
    NPCRDefaults = 
    { 
        ["Toggle"] = true, 
        ["Name"] = false, 
        ["Caption"] = true 
    }   
end

function NPCRSavedVariables()
        NPCSaved = ZO_SavedVars:New("NPCReticleSavedVars", 1, nil, NPCRDefaults)
end

function TargetChanged(Event, Unit)
    NPCReticle1Name:SetHidden(true)
	NPCReticle2Caption:SetHidden(true)
    local Name = GetUnitName("reticleover")                                         -- Get The Reticle Target
    local Blank = (Name == "" or Name == " ")                                       -- Ignore Blanks
    local Level = GetUnitLevel("reticleover")
    local Caption = GetUnitCaption("reticleover")
    local CBlank = (Caption == "" or Caption == " ")
    local Reaction = GetUnitReaction("reticleover")
    if NPCSaved.Toggle then
        if Caption == nil then return end
        if Caption and not CBlank then
            if not IsCritter(Name) and not Blank then                               -- Check For Critters
                if DoesUnitExist("reticleover") then
                    if not IsUnitPlayer("reticleover") then
                        if Reaction == UNIT_REACTION_INTERACT or UNIT_REACTION_NPC_ALLY then                       -- 5 = UNIT_REACTION_INTERACT and 7 =UNIT_REACTION_NPC_ALLY  
                            if NPCSaved.Name then
                                NPCReticle1Name:SetText(Name .. " (" .. Level .. ")")
                                NPCReticle1Name:SetHidden(false)
                            end
                            if NPCSaved.Caption then
                                NPCReticle2Caption:SetText(Caption)
                                NPCReticle2Caption:SetHidden(false)
                            end
                        end
                    end
                end
            end
        end
        if DebugMode == true then
            NPCReticle1Name:SetText(GetUnitName("reticleover") .. " (" .. GetUnitLevel("reticleover").. ")")
            NPCReticle1Name:SetHidden(false)
            NPCReticle2Caption:SetText(Caption)
            NPCReticle2Caption:SetHidden(false)
        end
    end
end

-- Borrowed Critter Check THIS IS NOT COPYRIGHTED
function IsCritter(Name)                                                            -- Function To Check If Critter
	if (GetUnitLevel("reticleover") ~= 1) then return false end                     -- Critters Are Always Level 1
	local Critters = {                                                              -- The List Of Critters
		"Butterfly", "Lizard", "Rat", "Snake", "Pony Guar", "Frog", "Squirrel", "Rabbit", "Deer", "Cat", "Pig", "Sheep", "Antelope", "Wasp", "Monkey", "Fleshflies", "Centipede", "Chicken", "Torchbug", "Spider", "Scorpion", "Goat", "Scrib", "Scuttler",
	}
	for I = 1, #Critters do                                                         -- Is The Target A Critter?
		if (Name == Critters[I]) then return true end
	end
	return false                                                                    -- Otherwise False
end

function OnAddonLoaded(Event, AddonName)
    if AddonName == AddName then
        NPCRDefaultVariables()
        NPCRSavedVariables()                                                          -- Load Saved Vars
        NPCRCreateSettings()                                                          -- Start Settings Panel
        NPCReticle1Name:SetHidden(true)
        NPCReticle2Caption:SetHidden(true)
    end
end

function NPCRCreateSettings()
    local Panel = LAM:CreateControlPanel(PanelHeader, PanelTitle)                   -- Panel
    LAM:AddHeader(Panel, "NPCReticle_General", "|cFFFFB0" ..AddName.. "|r")                            -- Panel Title
    
    if DebugMode == true then
        LAM:AddDescription(Panel, "NPCReticle_Text_Debug1", "*************")
        LAM:AddDescription(Panel, "NPCReticle_Text_Debug2", "Debug Mode On")
        LAM:AddDescription(Panel, "NPCReticle_Text_Debug3", "*************")
    end
    
    LAM:AddDescription(Panel, "NPCReticle_Text_Info", "Simple Addon To Show Name And Caption Of NPCs On The Reticle.")
    --LAM:AddDescription(Panel, "NPCReticle_Text_Line1", "------------------------------------------------------------------------------------")
    
    LAM:AddCheckbox(Panel, "NPCReticle_Option_Toggle", "NPCReticle On/Off", "Toggle Overall Addon NPCReticle Easily On/Off.", function() return NPCSaved.Toggle end, function() NPCSaved.Toggle = not NPCSaved.Toggle end )
    LAM:AddCheckbox(Panel, "NPCReticle_Option_Names", "NPCReticle Names On/Off", "NPC Names On/Off.", function() return NPCSaved.Name end, function() NPCSaved.Name = not NPCSaved.Name end )
    LAM:AddCheckbox(Panel, "NPCReticle_Option_Captions", "NPCReticle Captions On/Off", "NPC Captions On/Off.", function() return NPCSaved.Caption end, function() NPCSaved.Caption = not NPCSaved.Caption end )
    
    --LAM:AddDescription(Panel, "NPCReticle_Text_Line2", "------------------------------------------------------------------------------------")
    LAM:AddDescription(Panel, "NPCReticle_Text_End", AddName .. " " .. Version .. " " .. Author)
end

EVENT_MANAGER:RegisterForEvent("NPCReticle", EVENT_ADD_ON_LOADED, OnAddonLoaded)    -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("NPCReticle", EVENT_RETICLE_TARGET_CHANGED, TargetChanged)