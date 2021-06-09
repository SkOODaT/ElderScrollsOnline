local AddName = "NamesReticle"
local Version = "Version 100004.1"
local Author = "Created By SkOODaT"
local PanelHeader = "_SkOODaT"
local PanelTitle = "SkOODaTs AddOns"

local NamesReticle = {}
local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local TIGender = { "Female" , "Male" }
local NameSaved

local DebugMode = false

function NRDefaultVariables()
    NRDefaults = 
    { 
        ["Toggle"] = true,
        ["NameOn"] = true, 
        ["LevelOn"] = true,
        ["DifficultyOn"] = true,
        ["ReactionColour"] = true,
        ["TargetInfo"] = true,
        ["MoreTargetInfo"] = true,
        ["PlayerCaption"] = true,
        ["Tags"] = true,
        ["ReticleOn"] = true,
        ["Reaction1"] = true, 
        ["Reaction2"] = true, 
        ["Reaction3"] = true,
        ["Reaction4"] = true,
        ["Reaction5"] = true,
        ["Reaction6"] = true,
        ["Reaction7"] = true,
        ["Reaction8"] = true,
        ["ReactionPVP"] = true
    }
end

function NRSavedVariables()
        NameSaved = ZO_SavedVars:New("NamesReticleSavedVars", 1, nil, NRDefaults)
end

function TargetChanged(Event, Unit)
    NameReticle1Name:SetHidden(true)
	NameReticle2Level:SetHidden(true)
    NameReticle3Caption:SetHidden(true)
    local Name = GetUnitName("reticleover")                                     -- Get The Reticle Target 
    local Blank = (Name == "" or Name == " ")                                   -- Ignore Blanks
    local Caption = GetUnitCaption("reticleover")
    local CBlank = (Caption == "" or Caption == " ")
    local PlayerLevel = GetUnitLevel("player")
    local Level = GetUnitLevel("reticleover")
    local VRank = GetUnitVeteranRank('reticleover')
    local TargetDifficulty = GetUnitDifficulty('reticleover')
    local Race = GetUnitRace("reticleover")
    local Class = GetUnitClass("reticleover")
    local Title = GetUnitTitle("reticleover")
    local Alliance = GetUnitAlliance("reticleover")                             -- 1 = Aldmeri Dominion 2 = Ebonheart Pact 3 = Gaggerfall Covenant ~ Not Needed ATM
    local Reaction = GetUnitReaction("reticleover")                             -- Unit Reaction
    local Gendernum = GetUnitGender("reticleover")
    local Gender = "Genderless"
    local r, g, b = GetUnitReactionColor("reticleover")
    local r2, g2, b2 = GetConColor(Level, PlayerLevel)
    local NameString = ''
    local LevelString = ''
    local DifficultyString = ''
    if NameSaved.NameOn then
        NameString = Name
    end
    if NameSaved.LevelOn then
        if VRank and string.len(VRank) > 0 and VRank ~= 0 then
            LevelString = ' (V' .. tostring(VRank) .. ')'
        elseif Level and string.len(Level) > 0 then
            LevelString = ' (' .. tostring(Level) .. ')'
        end
    end
    if NameSaved.DifficultyOn then
        if TargetDifficulty > 1 then
            DifficultyString = " " .. string.rep("|cFF0000*|r", (TargetDifficulty - 1))
        end
    end
    if Gendernum>0 and Gendernum<3 then                              -- Convert numeric gender into a string
        Gender = TIGender[Gendernum]
    end
    if NameSaved.Toggle then
        if not Blank then                               
            if DoesUnitExist("reticleover") then
                if NameSaved.ReticleOn then
                    ZO_ReticleContainerReticle:SetColor(r, g, b)
                    ZO_ReticleContainerStealthEye:SetColor(r, g, b)
                    ZO_ReticleContainerStealthText:SetColor(r, g, b)
                end
                if NameSaved.Reaction1 and Reaction == UNIT_REACTION_DEAD then                                           -- UNIT_REACTION_DEAD 
                    NameReticle1Name:SetText(NameString)
                    if NameSaved.ReactionColour then
                        NameReticle1Name:SetColor(r, g, b)
                    else
                        NameReticle1Name:SetColor(1, 1, 1)    
                    end    
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                          
                    NameReticle2Level:SetHidden(false)
                end 
                if NameSaved.Reaction2 and Reaction == UNIT_REACTION_DEFAULT then                                           -- UNIT_REACTION_DEFAULT 
                    NameReticle1Name:SetText(NameString)
                    if NameSaved.ReactionColour then
                        NameReticle1Name:SetColor(r, g, b)
                    else
                        NameReticle1Name:SetColor(1, 1, 1)
                    end                             
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                          
                    NameReticle2Level:SetHidden(false)
                end 
                if NameSaved.Reaction3 and Reaction == UNIT_REACTION_FRIENDLY then                                           -- UNIT_REACTION_FRIENDLY
                    NameReticle1Name:SetText(NameString)
                    if NameSaved.ReactionColour then
                        NameReticle1Name:SetColor(r, g, b)
                    else
                        NameReticle1Name:SetColor(1, 1, 1)
                    end                             
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                         
                    NameReticle2Level:SetHidden(false)
                end 
                if NameSaved.Reaction4 and Reaction == UNIT_REACTION_HOSTILE then                                           --  UNIT_REACTION_HOSTILE 
                    NameReticle1Name:SetText(NameString .. DifficultyString)
                    if NameSaved.ReactionColour then
                        NameReticle1Name:SetColor(r, g, b)
                    else
                        NameReticle1Name:SetColor(1, 1, 1)
                    end                             
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                         
                    NameReticle2Level:SetHidden(false)
                end   
                if NameSaved.Reaction5 and Reaction == UNIT_REACTION_INTERACT then                                           -- UNIT_REACTION_INTERACT
                    NameReticle1Name:SetText(NameString)
                    if NameSaved.ReactionColour then
                        NameReticle1Name:SetColor(r, g, b)
                    else
                        NameReticle1Name:SetColor(1, 1, 1)
                    end                            
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                         
                    NameReticle2Level:SetHidden(false)
                end
                if NameSaved.Reaction6 and Reaction == UNIT_REACTION_NEUTRAL then                                           -- UNIT_REACTION_NEUTRAL
                    NameReticle1Name:SetText(NameString .. DifficultyString)
                    if NameSaved.ReactionColour then
                        NameReticle1Name:SetColor(r, g, b)
                    else
                        NameReticle1Name:SetColor(1, 1, 1)
                    end                            
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                          
                    NameReticle2Level:SetHidden(false)
                end 
                if NameSaved.Reaction7 and Reaction == UNIT_REACTION_NPC_ALLY  then                                           -- UNIT_REACTION_NPC_ALLY 
                    NameReticle1Name:SetText(NameString)
                    if NameSaved.ReactionColour then
                        NameReticle1Name:SetColor(r, g, b)
                    else
                        NameReticle1Name:SetColor(1, 1, 1)
                    end                            
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                          
                    NameReticle2Level:SetHidden(false)
                end
                if NameSaved.Reaction8 and Reaction == UNIT_REACTION_PLAYER_ALLY then                                           -- UNIT_REACTION_PLAYER_ALLY 
                    local ClassString
                    if NameSaved.TargetInfo then
                        ClassString = " |c00D8CD" ..  Class  .. "|r"
                    else
                        ClassString = ""
                    end
                    local RaceString
                    if NameSaved.MoreTargetInfo then
                        RaceString = " |cD89400(" .. Race  .. " " .. Gender .. ")|r"
                    else
                        RaceString = ""
                    end
                    NameReticle1Name:SetText(NameString .. ClassString .. RaceString)
                    if NameSaved.ReactionColour then
                        NameReticle1Name:SetColor(r, g, b)
                    else
                        NameReticle1Name:SetColor(1, 1, 1)
                    end                            
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                         
                    NameReticle2Level:SetHidden(false)
                    if NameSaved.PlayerCaption then
                        NameReticle3Caption:SetText(Title)
                        NameReticle3Caption:SetHidden(false)
                    end
                end
                if NameSaved.Reaction9 and IsUnitPlayer("reticleover") and IsUnitAttackable("reticleover") then                 -- Unit Is Attackable PVP Player 
                    NameReticle1Name:SetText(NameString)
                    NameReticle1Name:SetColor(1,0,0)                           
                    NameReticle1Name:SetHidden(false)
                    NameReticle2Level:SetText(LevelString)
                    NameReticle2Level:SetColor(r2, g2, b2)                          
                    NameReticle2Level:SetHidden(false)
                end
                if NameSaved.Tags then
                    if IsCritter(Name) then
                        NameReticle1Name:SetText(NameString .. " |cFFFFFF(Critter)|r")
                        if NameSaved.ReactionColour then
                            NameReticle1Name:SetColor(r, g, b)
                        else
                            NameReticle1Name:SetColor(1, 1, 1)
                        end                            
                        NameReticle1Name:SetHidden(false)
                        NameReticle2Level:SetText(LevelString)
                        NameReticle2Level:SetColor(r2, g2, b2)                          
                        NameReticle2Level:SetHidden(false)
                    end
                    if IsCollectibleCritter(Name) then
                        NameReticle1Name:SetText(NameString .. " |cFFFFFF(Collectable)|r")
                        if NameSaved.ReactionColour then
                            NameReticle1Name:SetColor(r, g, b)
                        else
                            NameReticle1Name:SetColor(1, 1, 1)
                        end                           
                        NameReticle1Name:SetHidden(false)
                        NameReticle2Level:SetText(LevelString)
                        NameReticle2Level:SetColor(r2, g2, b2)                          
                        NameReticle2Level:SetHidden(false)
                    end
                    if IsPlayerPet(Name) then
                        NameReticle1Name:SetText(NameString .. " |cFFFFFF(Pet)|r")
                        if NameSaved.ReactionColour then
                            NameReticle1Name:SetColor(r, g, b)
                        else
                            NameReticle1Name:SetColor(1, 1, 1)
                        end                           
                        NameReticle1Name:SetHidden(false)
                        NameReticle2Level:SetText(LevelString)
                        NameReticle2Level:SetColor(r2, g2, b2)                          
                        NameReticle2Level:SetHidden(false)
                    end
                end
                if DebugMode == true then
                    d(Reaction)
                end
            end
        else
            ZO_ReticleContainerReticle:SetColor(1, 1, 1)
            ZO_ReticleContainerStealthEye:SetColor(1, 1, 1)
            ZO_ReticleContainerStealthText:SetColor(1, 1, 1)
        end
    else
        NameReticle1Name:SetColor(1, 1, 1)
    end
end

              --[[ if NameSaved.Caption then
                    NameReticle2Level:SetText("Name")
                    NameReticle2Level:SetColor(1,0,0)                  -- Set Text Name RED
                    NameReticle2Level:SetHidden(false)
                end]]--
                
-- Borrowed Critter Check THIS IS NOT COPYRIGHTED
function IsCritter(Name)                                                        -- Function To Check If Critter
	if (GetUnitLevel("reticleover") ~= 1) then return false end                 -- Critters Are Always Level 1
	local Critters = {                                                          -- The List Of Critters
		"Butterfly", "Lizard", "Rat", "Snake", "Pony Guar", "Frog", "Squirrel", "Rabbit", "Deer", "Cat", "Pig", "Sheep", "Antelope", "Wasp", "Monkey", "Centipede", "Chicken", "Torchbug", "Spider", "Scorpion", "Goat", "Scrib", "Scuttler",
	}
	for I = 1, #Critters do                                                     -- Is The Target A Critter?
		if (Name == Critters[I]) then return true end
	end
	return false                                                                -- Otherwise False
end

function IsCollectibleCritter(Name)                                                        
	if (GetUnitLevel("reticleover") ~= 1) then return false end                
	local CCritters = {                                                         
		"Butterfly", "Wasp", "Fleshflies",
	}
	for I = 1, #CCritters do                                                    
		if (Name == CCritters[I]) then return true end
	end
	return false                                                               
end

function IsPlayerPet(Name) 
local PReaction = GetUnitReaction("reticleover")                                                        
	local Pets = {                                                         
		"Familiar", "Volatile Familiar", "Clannfear", "Unstable Clannfear", "Summon Winged Twilight", "Restoring Twilight",
	}
    if PReaction == UNIT_REACTION_HOSTILE then return end
	for I = 1, #Pets do                                                    
		if (Name == Pets[I]) then return true end
	end
	return false                                                               
end

function OnAddonLoaded(Event, AddonName)
    if AddonName == AddName then
        NRDefaultVariables()
        NRSavedVariables()                                                      -- Load Saved Vars
        NRCreateSettings()                                                      -- Start Settings Panel
        NameReticle1Name:SetHidden(true)
        NameReticle2Level:SetHidden(true)
        NameReticle3Caption:SetHidden(true)
    end
end

function NRCreateSettings()
    local Panel = LAM:CreateControlPanel(PanelHeader, PanelTitle)                   -- Panel
    LAM:AddHeader(Panel, "NamesReticle_General", "|cFFFFB0" ..AddName.. "|r")                           -- Panel Title
    
    if DebugMode == true then
        LAM:AddDescription(Panel, "NamesReticle_Text_Debug1", "*************")
        LAM:AddDescription(Panel, "NamesReticle_Text_Debug2", "Debug Mode On")
        LAM:AddDescription(Panel, "NamesReticle_Text_Debug3", "*************")
    end
    
    LAM:AddDescription(Panel, "NamesReticle_Text_Info", "Simple Addon To Show Names of Players With Hostility Colouring On The Reticle.")
    --LAM:AddDescription(Panel, "NamesReticle_Text_Line1", "------------------------------------------------------------------------------------")
    
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Toggle", "NamesReticle On/Off", "Toggle Overall Addon NamesReticle Easily On/Off.", function() return NameSaved.Toggle end, function() NameSaved.Toggle = not NameSaved.Toggle end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Names", "Names On/Off", "Toggle Names On/Off.", function() return NameSaved.NameOn end, function() NameSaved.NameOn = not NameSaved.NameOn end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Levels", "Levels/Vlevels On/Off", "Toggle Levels/Vlevels On/Off.", function() return NameSaved.LevelOn end, function() NameSaved.LevelOn = not NameSaved.LevelOn end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Diff", "Difficulty Stars (*) On/Off", "Toggle Difficulty Stars (*) On/Off.", function() return NameSaved.DifficultyOn end, function() NameSaved.DifficultyOn = not NameSaved.DifficultyOn end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_ReactionColour", "Reaction Colours On/Off", "Toggle Reaction Colours On/Off.", function() return NameSaved.ReactionColour end, function() NameSaved.ReactionColour = not NameSaved.ReactionColour end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_TargetInfo", "Target Info On/Off", "Toggle Target Info On/Off. (Class)", function() return NameSaved.TargetInfo end, function() NameSaved.TargetInfo = not NameSaved.TargetInfo end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_MoreTargetInfo", "More Target Info On/Off", "Toggle More Target Info On/Off. (Race + Gender)", function() return NameSaved.MoreTargetInfo end, function() NameSaved.MoreTargetInfo = not NameSaved.MoreTargetInfo end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_PlayerCaption", "PlayerCaption On/Off", "PlayerCaption On/Off. (Title)", function() return NameSaved.PlayerCaption end, function() NameSaved.PlayerCaption = not NameSaved.PlayerCaption end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Pet", "Critter/Collect And Pet Tags On/Off", "Toggle Critter/Collect And Pet Tags On/Off.", function() return NameSaved.Tags end, function() NameSaved.Tags = not NameSaved.Tags end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Reticle", "Reticle Reaction Colour On/Off", "Toggle Reticle Reaction Colour On/Off.", function() return NameSaved.ReticleOn end, function() NameSaved.ReticleOn = not NameSaved.ReticleOn end )
    --LAM:AddDescription(Panel, "NamesReticle_Text_Line2", "------------------------------------------------------------------------------------")
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Dead", "DEAD On/Off", "UNIT_REACTION_DEAD On/Off.", function() return NameSaved.Reaction1 end, function() NameSaved.Reaction1 = not NameSaved.Reaction1 end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Default", "DEFAULT On/Off", "UNIT_REACTION_DEFAULT On/Off.", function() return NameSaved.Reaction2 end, function() NameSaved.Reaction2 = not NameSaved.Reaction2 end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Friendly", "FRIENDLY On/Off", "UNIT_REACTION_FRIENDLY On/Off.", function() return NameSaved.Reaction3 end, function() NameSaved.Reaction3 = not NameSaved.Reaction3 end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Hostile", "HOSTILE On/Off", "UNIT_REACTION_HOSTILE On/Off.", function() return NameSaved.Reaction4 end, function() NameSaved.Reaction4 = not NameSaved.Reaction4 end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Interact", "INTERACT On/Off", "UNIT_REACTION_INTERACT On/Off.", function() return NameSaved.Reaction5 end, function() NameSaved.Reaction5 = not NameSaved.Reaction5 end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_Netural", "NEUTRAL On/Off", "UNIT_REACTION_NEUTRAL On/Off.", function() return NameSaved.Reaction6 end, function() NameSaved.Reaction6 = not NameSaved.Reaction6 end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_NPC", "NPC ALLY On/Off", "UNIT_REACTION_NPC_ALLY On/Off.", function() return NameSaved.Reaction7 end, function() NameSaved.Reaction7 = not NameSaved.Reaction7 end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_PlayerAlly", "PLAYER ALLY On/Off", "UNIT_REACTION_PLAYER_ALLY On/Off.", function() return NameSaved.Reaction8 end, function() NameSaved.Reaction8 = not NameSaved.Reaction8 end )
    LAM:AddCheckbox(Panel, "NamesReticle_Option_PVP", "PVP On/Off", "IsUnitPlayer(reticleover) and IsUnitAttackable(reticleover) On/Off.", function() return NameSaved.Reaction9 end, function() NameSaved.Reaction9 = not NameSaved.Reaction9 end )
    
    --LAM:AddDescription(Panel, "NamesReticle_Text_Line3", "------------------------------------------------------------------------------------")
    LAM:AddDescription(Panel, "NamesReticle_Text_End", AddName .. " " .. Version .. " " .. Author)
end

EVENT_MANAGER:RegisterForEvent("NamesReticle", EVENT_ADD_ON_LOADED, OnAddonLoaded)  -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("NamesReticle", EVENT_RETICLE_TARGET_CHANGED, TargetChanged)
