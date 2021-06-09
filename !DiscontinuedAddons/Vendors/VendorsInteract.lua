--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LMP = LibStub("LibMapPins-1.0")                                                                       -- Load LibMapPins
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsOnInteract(Event, Unit)
    if not DoesUnitExist("interact") then return end
    if not VendorSaved.Toggle then return end                                                               -- Saved Var Toggles
    if not VendorSaved.Recorder then return end                                                              -- Saved Var Toggles
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    local Name = GetUnitName("interact")                                                                    -- Get The Reticle Target
    local Blank = (Name == "" or Name == " ")                                                               -- Ignore Blank Targets
    local Caption = GetUnitCaption("interact")                                                              -- Get Unit Caption "BlackSmith" "Bank"
    local CBlank = (Caption == "" or Caption == " ")                                                    
    local Reaction = GetUnitReaction("interact")                                                            -- Get Unit Reaction For Checking
    local PlayerX, PlayerY, PlayerH = GetMapPlayerPosition('player')                                        -- Get Target X And Y  V1.2.3 FUCKED THIS NOW ITS PLAYER ON INTERACT
    local MapSubzone = GetMapName()                                                                         -- Get MapSubzone
    local MapName = LMP:GetZoneAndSubzone(true)                                                             -- LMP: Get Zone and Subzone
    local SVData = VendorSavedAccount.Data[MapName]                                                         -- Saved Var File
    local Floor, Floors = GetMapFloorInfo()                                                                 -- Debugging ATM
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    if(SetMapToPlayerLocation() == SET_MAP_RESULT_MAP_CHANGED) then
        CALLBACK_MANAGER:FireCallbacks("OnWorldMapChanged")
    end
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    if Name == nil or Blank then return end                                                                 -- If No Name Or Blank Name Return
    if Caption == nil or CBlank then return end                                                             -- If No Caption Or Blank Caption Return
    if VendorIsCritter(Name) then return end                                                                -- Check For Critters And Blank Names
    if IsUnitPlayer("interact") then return end                                                             -- Make Sure Unit Isnt A Player
    if not Reaction == UNIT_REACTION_INTERACT or not UNIT_REACTION_NPC_ALLY then return end                 -- Get Unit Reaction For Checking Purposes
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    if SVData ~= nil then                                                                                   -- Only If Thiers Data In Saved Var Already
        for _, Item in ipairs(SVData) do                                                                    -- Scan Through Saved Var File
            if Item[1] == Name and Item[3] == MapSubzone then
                if VendorSaved.Debug then
                    CHAT_SYSTEM:AddMessage(zo_strformat("Found NPC |cFFFF00<<1>>|r |c00FF00<<2>>|r |cFFFFFFOf|r |c00FF00<<3>>|r |cFFFFFFIn The Saved Var File|r NOT ADDING!", Name, Caption, MapSubzone))
                end
                return                                                                                      -- Return If Already Found In Saved Vars
            end
        end
    end
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    if VendorSaved.VendorOutput then
        ZO_ChatWindowTemplate1Buffer:AddMessage(zo_strformat("New Vendor Added: |cFFFF00<<1>>|r |c00FF00<<2>>|r In |c00FF00<<3>>|r At |c00FF00<<4>>•<<5>>|r.", Name, Caption, MapSubzone, ("%05.02f"):format(zo_round(PlayerX * 10000)/100), ("%05.02f"):format(zo_round(PlayerY * 10000)/100)))
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------
    if VendorSaved.Debug then
        d(MapName, Name, Caption, MapSubzone, PlayerX, PlayerY)
    end
    VendorsSaveData(MapName, Name, Caption, MapSubzone, PlayerX, PlayerY)                                       -- SAVE DATA
    VendorsZrMMRefresh()                                                                                        -- For ZrMM To Apply Pins Right Away
    --------------------------------------------------------------------------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorIsCritter(Name)                                                                                        -- Function To Check If Critter
	if (GetUnitLevel("interact") ~= 1) then return false end                                                 -- Critters Are Always Level 1
	local Critters = {                                                                                          -- The List Of Critters
		"Butterfly", "Lizard", "Rat", "Snake", "Pony Guar", "Frog", "Squirrel", "Rabbit", "Deer", "Cat", "Pig", "Sheep", "Antelope", "Wasp", "Monkey", "Fleshflies", "Centipede", "Chicken", "Torchbug", "Spider", "Scorpion", "Goat", "Scrib", "Scuttler",
	}
	for I = 1, #Critters do                                                                                     -- Is The Target A Critter?
		if (Name == Critters[I]) then return true end
	end
	return false                                                                                                -- Otherwise False
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsZrMMRefresh()
    if not VendorSaved.ZrMM then return end
    ZO_WorldMap_UpdateMap()                                                                                  -- For ZrMM Apply Pins On Toggle
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("Vendors_OnInteract", EVENT_OPEN_STORE, VendorsOnInteract)
EVENT_MANAGER:RegisterForEvent("Vendors_OnInteract", EVENT_CLOSE_STORE, VendorsOnInteract)
EVENT_MANAGER:RegisterForEvent("Vendors_OnInteract", EVENT_CHATTER_BEGIN, VendorsOnInteract)
EVENT_MANAGER:RegisterForEvent("Vendors_OnInteract", EVENT_CHATTER_END, VendorsOnInteract) 