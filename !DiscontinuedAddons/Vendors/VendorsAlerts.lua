--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LMP = LibStub("LibMapPins-1.0")                                                                       -- Load LibMapPins
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsOnTarget(Event, Unit)
    if not DoesUnitExist('reticleover') then return end
    if not VendorSaved.Toggle then return end                                                               -- Saved Var Toggles
    if not VendorSaved.Alerts then return end                                                              -- Saved Var Toggles
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    local Name = GetUnitName("reticleover")                                                                 -- Get The Reticle Target
    local Blank = (Name == "" or Name == " ")                                                               -- Ignore Blank Targets
    local Caption = GetUnitCaption("reticleover")                                                           -- Get Unit Caption "BlackSmith" "Bank"
    local CBlank = (Caption == "" or Caption == " ")                                                    
    local Reaction = GetUnitReaction('reticleover')                                                         -- Get Unit Reaction For Checking
    --local TargetX, TargetY, TargetH = GetMapPlayerPosition('reticleover')                                 -- Get Target X And Y  --"interact"
    local MapSubzone = GetMapName()                                                                         -- Get MapSubzone
    local MapName = LMP:GetZoneAndSubzone(true)                                                             -- LMP: Get Zone and Subzone
    local SVData = VendorSavedAccount.Data[MapName]                                                         -- Saved Var File
    local Floor, Floors = GetMapFloorInfo()                                                                 -- Debugging ATM
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    if Name == nil or Blank then return end                                                                 -- If No Name Or Blank Name Return
    if Caption == nil or CBlank then return end                                                             -- If No Caption Or Blank Caption Return
    if VendorIsCritter(Name) then return end                                                                -- Check For Critters And Blank Names
    if IsUnitPlayer('reticleover') then return end                                                          -- Make Sure Unit Isnt A Player
    if not Reaction == UNIT_REACTION_INTERACT or not UNIT_REACTION_NPC_ALLY then return end                 -- Get Unit Reaction For Checking Purposes
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    if SVData ~= nil then                                                                                   -- Only If Thiers Data In Saved Var Already
        for _, Item in ipairs(SVData) do                                                                    -- Scan Through Saved Var File
            if Item[1] == Name and Item[3] == MapSubzone then                                               -- Check NPC Names And Map location For Boatswain (Boatswain Has Same Name But Different Location Sometimes :S)
                if VendorSaved.Debug then
                    CHAT_SYSTEM:AddMessage(zo_strformat("Found NPC |cFFFF00<<1>>|r |c00FF00<<2>>|r |cFFFFFFOf|r |c00FF00<<3>>|r |cFFFFFFIn The Saved Var File|r No Alert!", Name, Caption, MapSubzone))
                end
                return                                                                                      -- Return If Already Found In Saved Vars
            end
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------
    if VendorSaved.Debug then
        d(MapName, Name, Caption, MapSubzone)
    end
    ZO_Alert(1, 1, zo_strformat("Interact With Vendor:|cFFFF00<<1>>|r |c00FF00<<2>>|r In |c00FF00<<3>>|r.", Name, Caption, MapSubzone))
    PlaySound( 'Quest_StepFailed' )
    --------------------------------------------------------------------------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorIsCritter(Name)                                                                                        -- Function To Check If Critter
	if (GetUnitLevel("reticleover") ~= 1) then return false end                                                 -- Critters Are Always Level 1
	local Critters = {                                                                                          -- The List Of Critters
		"Butterfly", "Lizard", "Rat", "Snake", "Pony Guar", "Frog", "Squirrel", "Rabbit", "Deer", "Cat", "Pig", "Sheep", "Antelope", "Wasp", "Monkey", "Fleshflies", "Centipede", "Chicken", "Torchbug", "Spider", "Scorpion", "Goat", "Scrib", "Scuttler",
	}
	for I = 1, #Critters do                                                                                     -- Is The Target A Critter?
		if (Name == Critters[I]) then return true end
	end
	return false                                                                                                -- Otherwise False
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("Vendors_OnTarget", EVENT_RETICLE_TARGET_CHANGED, VendorsOnTarget)
