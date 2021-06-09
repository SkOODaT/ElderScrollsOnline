local AddName = "NPCReticleScan"
local Author = "Created By SkOODaT & Mitsarugi" 
local Version = "Version 100003.7"
local PanelHeader = "_SkOODaT"
local PanelTitle = "SkOODaTs AddOns"

--local PanelHeader = "Merchants_OptionsPanel"
--local PanelTitle = "Merchants"

local NPCReticleScan = {}
local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")
local NPCDetectRange = 1          -- How Far Away To Detect The NPC 15 Is Just A Bit Beyond Melee Range ***** Not Used ATM

local DebugMode = false

NPCRSDefaults = {
    data = {}
}

-- NPC Types According To Merchants Addon
NPCType = 
    { 
    ["Alchemist"] = "21",
    ["Armorer"] = "22",
    ["Blacksmith"] = "23",
    ["Clothier"] = "24",
    ["Grocer"] = "25",
    ["Leatherworker"] = "26",
    ["Merchant"] = "27",
    ["Mystic"] = "28",
    ["Pack Merchant"] = "29",
    ["Tailor"] = "30",
    ["Weaponsmith"] = "31",
    ["Woodworker"] = "32",
    ["Chef"] = "33",
    ["Brewer"] = "34",
    ["Enchanter"] = "35",
    ["Innkeeper"] = "36",
    ["Magus"] = "37",
    ["Banker"] = "38",
    ["Carpenter"] = "39",
    ["Armsman"] = "40",
    ["Stablemaster"] = "41",
    ["Magister"] = "42",
    }
    
function NPCRSSavedVariables()
    NPCRSSaved = 
    {
        ["npc"] = ZO_SavedVars:NewAccountWide("NPCReticleScanSavedVars", 1, "npc", NPCRSDefaults),
    }
end

function TargetChanged(Event, Unit)
    local Name = GetUnitName("reticleover")                                                             -- Get The Reticle Target
    local Blank = (Name == "" or Name == " ")                                                           -- Ignore Blank Targets
    local Caption = GetUnitCaption("reticleover")                                                       -- Get Unit Caption "BlackSmith" "Bank"
    local CBlank = (Caption == "" or Caption == " ")
    local Reaction = GetUnitReaction('reticleover')                                                     -- Get Unit Reaction For Checking Purposes 3 == NPC
    local targetX, targetY, targetH = GetMapPlayerPosition('reticleover')
    local selfX, selfY, selfH = GetMapPlayerPosition('player')
    local mapWidth, mapHeight = GetMapNumTiles()
    local mapType = GetMapType()
    local mapContentType = GetMapContentType()
    local mapSubzone = GetMapName()
    local targetInNPCRange = false
    local distance = -999
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    local Extra1 = "Inside Building"                                                                    -- Mitsarugi Extra Stuff
    local ExtraInfoInsideBuilding = false                                                               -- Mitsarugi Extra Stuff
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    if not IsCritter(Name) and not Blank then                                                           -- Check For Critters
        if DoesUnitExist('reticleover') then                                                            -- Make Sure Thier Is A Target
            if not IsUnitPlayer('reticleover') then                                                     -- Make Sure Unit Isnt A Player
                if Reaction == UNIT_REACTION_INTERACT or UNIT_REACTION_NPC_ALLY then                    -- Get Unit Reaction For Checking Purposes 5 == NPC
                    if Caption == nil then return end
                    if Caption and not CBlank then
                        ---------------------------------------------------------------------------------------------------------------------------------------------------
                        local Type = NPCType[Caption]
                        if Type == nil then d(Caption .. " Needs To Be Added To The NPCTypes Database For Merchants Addon") return end
                        for i = 1, #NPCRSSaved["npc"].data do
                                local item = NPCRSSaved["npc"].data[i]
                                if item[2] == (Name) then
                                   -- d("Found NPC " ..Name.. " " ..Caption.. " Of " ..Subzone.. " In The Saved Var File NOT ADDING")
                                    return 
                                end
                        end
                        --d(Caption)
                        ---------------------------------------------------------------------------------------------------------------------------------------------------
                        if targetX and targetY then
                            -- Default divisor for map types that haven't been calculated yet
                            local divisor = mapType * mapWidth
                            if mapContentType == MAP_CONTENT_NONE then
                                if mapType == MAPTYPE_SUBZONE then
                                    divisor = 14.5
                                    -- 5,5 (vulkhel) = 15
                                    -- 5,5 (skywatch) = 14
                                elseif mapType == MAPTYPE_ZONE then
                                    divisor = 2.9
                                    -- 3,3 (bleakrock) = 2.9
                                    -- 2,2 (stonefalls) = 2.9
                                    -- 2,2 (auridon) = 2.5
                                    -- 2,2 (harborage) = broken
                                end
                            elseif mapContentType == MAP_CONTENT_AVA then
                                if mapType == MAPTYPE_SUBZONE then
                                    divisor = 16
                                    -- 5,5 (eastern elsweyr) = 16?
                                elseif mapType == MAPTYPE_ZONE then
                                    divisor = 1.0
                                    -- 5,5 (cyrodiil) = 1.0
                                end
                            elseif mapContentType == MAP_CONTENT_DUNGEON then
                                if mapType == MAPTYPE_SUBZONE then
                                    divisor = 21
                                    -- 3,3 (elden hollow) = 21
                                elseif mapType == MAPTYPE_ZONE then
                                    divisor = 26
                                end
                            end
                            local dist = math.sqrt(math.pow((selfX - targetX) / divisor, 2) + math.pow((selfY - targetY) / divisor, 2))
                            distance = math.floor((dist * 10000) - 0.5)
                            -- Disable range functionality when a zone isn't working with range calculation
                            if distance > 200 then
                                distance = -999
                            end
                            if distance <= NPCDetectRange then
                                targetInNPCRange = true	
                            end
                        end
                        ---------------------------------------------------------------------------------------------------------------------------------------------------
                        if ExtraInfoInsideBuilding == false then
                            Log("npc", Round(targetX) .. ', ' .. Round(targetY) .. ', "' .. Name .. '", ' .. Type, Name, Caption, Type, mapSubzone, targetX, targetY)
                        else 
                            Log("npc", Round(targetX) .. ', ' .. Round(targetY) .. ', "' .. Name .. '", ' .. Type, Name, Caption, Type, mapSubzone, targetX, targetY, Extra1)
                        end
                            d("Added " .. Caption .. " " .. Name .. " in " .. mapSubzone .. " at " .. Round(targetX) .. ";" .. Round(targetY) .. " To The NPCReticleScan Database!")
                        if DebugMode == true then
                            d("Added " .. Caption .. " " .. Name .. " in " .. mapSubzone .. " at " .. Round(targetX) .. ";" .. Round(targetY) .. " To The NPCReticleScan Database!")
                        end
                        ---------------------------------------------------------------------------------------------------------------------------------------------------
                    end
                end
            end
            if DebugMode == true then
                d("PlayerLoc: " .. selfX .. " " .. selfY)
                d("TargetLoc: " ..targetX .. " " .. targetY)
            end
        end
    end
end

local function ExtraInfo1()                                                                     -- Mitsarugi Extra Stuff
    d("ExtraInfo = " ..ExtraInfoInsideBuilding)
end

function Round(num, idp)                                                                        -- Round To 2 Decimals WAY Easier
    return tonumber(string.format("%." .. (idp or 2) .. "f", num))
end

function Log(type, ...)                                                                         -- Logs Saved Variables To File
    local data = {}
    local dataStr = ""
    local sv
    if NPCRSSaved[type] == nil or NPCRSSaved[type].data == nil then
        d("Attempted to log unknown type to the database: " .. type)
        return
    else
        sv = NPCRSSaved[type].data
    end
    for i = 1, select("#", ...) do
        local value = select(i, ...)
        data[i] = value
        dataStr = dataStr .. tostring(value)
    end
    --d("Logged [" .. type .. "] data: " .. dataStr)
    if #sv == 0 then
        sv[1] = data
    else
        sv[#sv+1] = data
    end
end

-- Borrowed Critter Check THIS IS NOT COPYRIGHTED
function IsCritter(Name)                                                                            -- Function To Check If Critter
	if (GetUnitLevel("reticleover") ~= 1) then return false end                                     -- Critters Are Always Level 1
	local Critters = {  -- The List Of Critters
		"Butterfly", "Lizard", "Rat", "Snake", "Pony Guar", "Frog", "Squirrel", "Rabbit", "Deer", "Cat", "Pig", "Sheep", "Antelope", "Wasp", "Monkey", "Fleshflies", "Centipede", "Chicken", "Torchbug", "Spider", "Scorpion", "Goat", "Scrib", "Scuttler",
	}
	for I = 1, #Critters do                                                                         -- Is The Target A Critter?
		if (Name == Critters[I]) then return true end
	end
	return false                                                                                    -- Otherwise False
end

function OnAddonLoaded(Event, AddonName)
    if AddonName == AddName then
        NPCRSSavedVariables()
        NPCRSCreateSettings()
    end
	SLASH_COMMANDS["/npcscanei"] = ExtraInfo1                                                       -- Slash commands -- Mitsarugi Extra Stuff
end

function NPCRSCreateSettings()
    local Panel = LAM:CreateControlPanel(PanelHeader, PanelTitle)                                   -- Panel
    LAM:AddHeader(Panel, "NPCReticleScan_General", "|cFFFFB0" ..AddName.. "|r")                     -- Panel Title
    
    if DebugMode == true then
        LAM:AddDescription(Panel, "NPCReticleScan_Text_Debug1", "*************")
        LAM:AddDescription(Panel, "NPCReticleScan_Text_Debug2", "Debug Mode On")
        LAM:AddDescription(Panel, "NPCReticleScan_Text_Debug3", "*************")
    end
    
    LAM:AddDescription(Panel, "NPCReticleScan_Text_1", "Automatically Scans for NPCs selling items")
    LAM:AddDescription(Panel, "NPCReticleScan_Text_2", "generating a file that will help create a Database ")
	LAM:AddDescription(Panel, "NPCReticleScan_Text_3", "for the addon Merchants.")
	--LAM:AddDescription(Panel, "NPCReticleScan_Text_line1", "------------------------------------------------------------------------------------")
    
	LAM:AddDescription(Panel, "NPCReticleScan_Text_5", "Please share the generated file in the comment section on ESOUI.")
	LAM:AddDescription(Panel, "NPCReticleScan_Text_6", "('NPCReticleScan.lua' in the SavedVariables folder)")
    
	--LAM:AddDescription(Panel, "NPCReticleScan_Text_Line2", "------------------------------------------------------------------------------------")
    LAM:AddDescription(Panel, "NPCReticleScan_Text_End", AddName .. " " .. Version .. " " .. Author)
end

EVENT_MANAGER:RegisterForEvent("NPCReticleScan", EVENT_ADD_ON_LOADED, OnAddonLoaded)
EVENT_MANAGER:RegisterForEvent("NPCReticleScan", EVENT_RETICLE_TARGET_CHANGED, TargetChanged)