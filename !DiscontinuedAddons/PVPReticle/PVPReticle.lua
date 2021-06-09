local AddName = "PVPReticle"
local Version = "100004.1"
local Author = "Created By SkOODaT"
local PanelHeader = "_SkOODaT"
local PanelTitle = "SkOODaTs AddOns"

local PVPReticle = {}
local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local PVPSaved
local DebugMode = false

function PVPRDefaultVariables()
    PVPRDefaults = 
    { 
        ["Toggle"] = true, 
        ["NameOn"] = true, 
        ["LevelOn"] = true,
        ["DifficultyOn"] = true,    
        ["CaptionOn"] = true 
    }                 
end

function PVPRSavedVariables()
        PVPSaved = ZO_SavedVars:New("PVPReticleSavedVars", 1, nil, PVPRDefaults)
end

function TargetChanged(Event, Unit)
    local NameString = ''
    local LevelString = ''
    local DifficultyString = ''
    local TargetLevel = GetUnitLevel('reticleover')
    local TargetVRank = GetUnitVeteranRank('reticleover')
        if PVPSaved.NameOn then
            NameString = Name
        end
        if PVPSaved.LevelOn then
            if TargetVRank and string.len(TargetVRank) > 0 and TargetVRank ~= 0 then
                LevelString = ' (V' .. tostring(TargetVRank) .. ')'
            elseif TargetLevel and string.len(TargetLevel) > 0 then
                LevelString = ' (' .. tostring(TargetLevel) .. ')'
            end
        end
        if PVPSaved.DifficultyOn then
            local TargetDifficulty = GetUnitDifficulty('reticleover')
            if TargetDifficulty > 1 then
                DifficultyString = " " .. string.rep("*", (TargetDifficulty - 1))
            end
        end
    PVPReticle1Name:SetHidden(true)
	PVPReticle2Caption:SetHidden(true)
    local Name = GetUnitName("reticleover")                                     -- Get The Reticle Target 
    local Alliance = GetUnitAlliance("reticleover")                             -- 1 = Aldmeri Dominion 2 = Ebonheart Pact 3 = Gaggerfall Covenant ~ Not Needed ATM
    local Reaction = GetUnitReaction("reticleover")                             -- Unit Reaction ~ Not Needed ATM
    local Blank = (Name == "" or Name == " ")                                   -- Ignore Blanks
    if PVPSaved.Toggle then
        if not IsCritter(Name) and not Blank then                               -- Check For Critters
            if DoesUnitExist("reticleover") then                                -- Does Unit Exist
                if IsUnitPlayer("reticleover") then                             -- Unit Is A Player
                    if IsUnitAttackable("reticleover") then                     -- Unit Is Attackable  
                        if PVPSaved.NameOn then
                            PVPReticle1Name:SetText(NameString.." "..levelString)
                            PVPReticle1Name:SetColor(1,0,0)                     -- Set Text PVP RED
                            PVPReticle1Name:SetHidden(false)
                        end
                        if PVPSaved.CaptionOn then
                            PVPReticle2Caption:SetText("PVP")
                            PVPReticle2Caption:SetColor(1,0,0)                  -- Set Text PVP RED
                            PVPReticle2Caption:SetHidden(false)
                        end
                    end
                end
                if DebugMode == true then
                    PVPReticle1Name:SetText(GetUnitName("reticleover").." ("..GetUnitLevel("reticleover")..")")
                    PVPReticle1Name:SetColor(1,0,0)                             -- Set Text PVP RED
                    PVPReticle1Name:SetHidden(false)
                    PVPReticle2Caption:SetText("PVP")
                    PVPReticle2Caption:SetColor(1,0,0)                          -- Set Text PVP RED
                    PVPReticle2Caption:SetHidden(false)
                end
            end
        end
    end
end

-- Borrowed Critter Check THIS IS NOT COPYRIGHTED
function IsCritter(Name)                                                        -- Function To Check If Critter
	if (GetUnitLevel("reticleover") ~= 1) then return false end                 -- Critters Are Always Level 1
	local Critters = {                                                          -- The List Of Critters
		"Butterfly", "Lizard", "Rat", "Snake", "Pony Guar", "Frog", "Squirrel", "Rabbit", "Deer", "Cat", "Pig", "Sheep", "Antelope", "Wasp", "Monkey", "Fleshflies", "Centipede", "Chicken", "Torchbug", "Spider", "Scorpion", "Goat", "Scrib", "Scuttler",
	}
	for I = 1, #Critters do                                                     -- Is The Target A Critter?
		if (Name == Critters[I]) then return true end
	end
	return false                                                                -- Otherwise False
end

function OnAddonLoaded(Event, AddonName)
    if AddonName == AddName then
        PVPRDefaultVariables()
        PVPRSavedVariables()                                                      -- Load Saved Vars
        PVPRCreateSettings()                                                      -- Start Settings Panel
        PVPReticle1Name:SetHidden(true)
        PVPReticle2Caption:SetHidden(true)
    end
end

function PVPRCreateSettings()
    local Panel = LAM:CreateControlPanel(PanelHeader, PanelTitle)               -- Panel
    LAM:AddHeader(Panel, "PVPReticle_General", "|cFFFFB0" ..AddName.. "|r")     -- Panel Title
    
    if DebugMode == true then
        LAM:AddDescription(Panel, "PVPReticle_Text_Debug1", "*************")
        LAM:AddDescription(Panel, "PVPReticle_Text_Debug2", "Debug Mode On")
        LAM:AddDescription(Panel, "PVPReticle_Text_Debug3", "*************")
    end
    
    LAM:AddDescription(Panel, "PVPReticle_Text_Info", "Simple Addon To Show PVP Players On The Reticle.")
    --LAM:AddDescription(Panel, "PVPReticle_Text_Line1", "------------------------------------------------------------------------------------")
    
    LAM:AddCheckbox(Panel, "PVPReticle_Option_Toggle", "PVPReticle On/Off", "Toggle Overall Addon PVPReticle Easily On/Off.", function() return PVPSaved.Toggle end, function() PVPSaved.Toggle = not PVPSaved.Toggle end )
    LAM:AddCheckbox(Panel, "PVPReticle_Option_Names", "Names On/Off", "Toggle Names On/Off.", function() return PVPSaved.NameOn end, function() PVPSaved.NameOn = not PVPSaved.NameOn end )
    LAM:AddCheckbox(Panel, "PVPReticle_Option_Levels", "Levels/Vlevels On/Off", "Toggle Levels/Vlevels On/Off.", function() return PVPSaved.LevelOn end, function() PVPSaved.LevelOn = not PVPSaved.LevelOn end )
    LAM:AddCheckbox(Panel, "PVPReticle_Option_Diff", "Difficulty Stars On/Off", "Toggle Difficulty Stars On/Off.", function() return PVPSaved.DifficultyOn end, function() PVPSaved.DifficultyOn = not PVPSaved.DifficultyOn end )
    LAM:AddCheckbox(Panel, "PVPReticle_Option_Caption", "PVPReticle PVP Caption On/Off", "PVP Caption On/Off.", function() return PVPSaved.CaptionOn end, function() PVPSaved.CaptionOn = not PVPSaved.CaptionOn end )
    
    --LAM:AddDescription(Panel, "PVPReticle_Text_Line2", "------------------------------------------------------------------------------------")
    LAM:AddDescription(Panel, "PVPReticle_Text_End", AddName .. " " .. Version .. " " .. Author)

end

EVENT_MANAGER:RegisterForEvent("PVPReticle", EVENT_ADD_ON_LOADED, OnAddonLoaded)    -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("PVPReticle", EVENT_RETICLE_TARGET_CHANGED, TargetChanged)
EVENT_MANAGER:RegisterForEvent("PVPReticle", EVENT_RETICLE_TARGET_PLAYER_CHANGED, TargetChanged) -- 100004 NEW API