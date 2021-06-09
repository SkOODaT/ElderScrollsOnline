--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local LMP = LibStub("LibMapPins-1.0")                                                                   -- Load LibMapPins
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local PinType1 = "Vendors"
local PinType2 = "Custom"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local PinTypeId1, PinTypeId2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Level Examples: Points of interest 50, quests 110, group members 130, wayshrine 140, player 160.
VendorsPinLayoutData  = {
   level = 160,
   tint = ZO_ColorDef:New(0,1,0,1),
   texture = "/esoui/art/collections/active_icon.dds",  -- "/esoui/art/mappins/compassvendor.dds",
   size = 25,
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
VendorsZoomPinLayoutData  = {
   level = 160,
   tint = ZO_ColorDef:New(0,1,0,1),
   texture = "/esoui/art/collections/active_icon.dds", -- "/esoui/art/mappins/compassvendor.dds",
   size = 5,
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
CustomPinLayoutData  = {
   level = 160,
   tint = ZO_ColorDef:New(1,0,0,1),
   texture = "/esoui/art/collections/active_icon.dds", -- "/esoui/art/mappins/compassvendor.dds",
   size = 25,
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
CustomZoomPinLayoutData  = {
   level = 160,
   tint = ZO_ColorDef:New(1,0,0,1),
   texture = "/esoui/art/collections/active_icon.dds", -- "/esoui/art/mappins/compassvendor.dds",
   size = 5,
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function GetInfoFromTag(Pin)
	local _, PinTag = Pin:GetPinTypeAndTag()
	local VName = PinTag[1]
    local VType = PinTag[2]  
    local VNote = PinTag[5]    
    return VName, VType, VNote
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
VendorsPinTooltipCreator = {
	creator = function(Pin)
		local VName, VType, VNote = GetInfoFromTag(Pin)
        local LocX, LocY = Pin:GetNormalizedPosition()
        if not VName then return end                                                                -- Only Show On Data
        InformationTooltip:AddLine("|cFFFF00-"..VName.."-|r")                                       -- NPC Name
        if not VType then return end 
        if VType:find(GetString(PIN_GUILDTRADER)) then                                              -- Guild Trader Fix For Now To Remove Guild Names On Map Pins Since They Dont Get Updated (Just Need To Know Where They Are Anyway)
            VType = "Guild Trader"
            InformationTooltip:AddLine("|c00FF00"..VType.."|r") 
        else
            InformationTooltip:AddLine("|c00FF00"..VType.."|r")   
        end
        -- NPC Type
        InformationTooltip:AddLine(zo_strformat("<<1>>x<<2>>", ("%05.02f"):format(LocX*100), ("%05.02f"):format(LocY*100)))  -- X,Y POS
        --InformationTooltip:AddLine("EsoUI/Art/Miscellaneous/horizontalDivider.dds")
	end,
	tooltip = 1,
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
CustomPinTooltipCreator = {
	creator = function(Pin)
		local VName, VType, VNote = GetInfoFromTag(Pin)
        local LocX, LocY = Pin:GetNormalizedPosition()
        if not VName then return end                                                   -- Only Show On Data
        InformationTooltip:AddLine("|cFFFF00-"..VName.."-|r")                          -- NPC Name
        if not VType then return end 
        InformationTooltip:AddLine("|cFF0000"..VType.."|r")                            -- NPC Type
        if not VNote then return end 
        InformationTooltip:AddLine("|cFFFF00"..VNote.."|r")                            -- NPC Note
        InformationTooltip:AddLine(zo_strformat("<<1>>x<<2>>", ("%05.02f"):format(LocX*100), ("%05.02f"):format(LocY*100)))  -- X,Y POS
        --InformationTooltip:AddLine("EsoUI/Art/Miscellaneous/horizontalDivider.dds")
	end,
	tooltip = 1,
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsPinTypeAddCallback()
    if not VendorSaved.Toggle then return end
    if (not LMP:IsEnabled(PinType1)) or (GetMapType() > MAPTYPE_ZONE) then return end
    local Zone, Subzone = LMP:GetZoneAndSubzone()
    local Pins = VendorSavedAccount.Data[Zone.."/"..Subzone]
    if Pins == nil then return end
    for _, PinData in ipairs(Pins) do                                                                
        -- PVE VENDORS
        if VendorSaved.Alchemist and PinData[2] == GetString(PIN_ALCHEMIST) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Armorer and PinData[2] == GetString(PIN_ARMORER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Armsman and PinData[2] == GetString(PIN_ARMSMAN) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Banker and PinData[2] == GetString(PIN_BANKER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Blacksmith and PinData[2] == GetString(PIN_BLACKSMITH) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Boatswain and PinData[2] == GetString(PIN_BOATSWAIN) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Brewer and PinData[2] == GetString(PIN_BREWER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Carpenter and PinData[2] == GetString(PIN_CARPENTER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Chef and PinData[2] == GetString(PIN_CHEF) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Clothier and PinData[2] == GetString(PIN_CLOTHIER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Enchanter and PinData[2] == GetString(PIN_ENCHANTER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Grocer and PinData[2] == GetString(PIN_GROCER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.HallSteward and PinData[2] == GetString(PIN_HALLSTEWARD) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Innkeeper and PinData[2] == GetString(PIN_INNKEEPER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Leatherworker and PinData[2] == GetString(PIN_LEATHERWORKER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Magister and PinData[2] == GetString(PIN_MAGISTER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Magus and PinData[2] == GetString(PIN_MAGUS) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Merchant and PinData[2] == GetString(PIN_MERCHANT) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Mystic and PinData[2] == GetString(PIN_MYSTIC) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.PackMerchant and PinData[2] == GetString(PIN_PACKMERCHANT) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Stablemaster and PinData[2] == GetString(PIN_STABLEMASTER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Tailor and PinData[2] == GetString(PIN_TAILOR) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Weaponsmith and PinData[2] == GetString(PIN_WEAPONSMITH) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.Woodworker and PinData[2] == GetString(PIN_WOODWORKER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        -- PVP VENDORS
        elseif VendorSaved.MercenaryMerchant and PinData[2] == GetString(PIN_MERCENARYMERCHANT) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])    
        elseif VendorSaved.SiegeMerchant and PinData[2] == GetString(PIN_SIEGEMERCHANT) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        elseif VendorSaved.EliteGearVendor and PinData[2] == GetString(PIN_ELITEGEARVENDOR) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        -- GUILD VENDORS
        elseif VendorSaved.GuildTrader and (PinData[2]):find(GetString(PIN_GUILDTRADER)) then    ------- Special For Guild Traders Ignore Guild Name Any " Guild Trader " Gets Pinned
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        -- UNDAUNTED QUARTERMASTER
        elseif VendorSaved.UndauntedQuartermaster and PinData[2] == GetString(PIN_UNDAUNTEDQUARTERMASTER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        -- PROFITEER
        elseif VendorSaved.Profiteer and PinData[2] == GetString(PIN_PROFITEER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        -- FENCE
        elseif VendorSaved.Fence and PinData[2] == GetString(PIN_FENCE) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        -- MONEYLENDER
        elseif VendorSaved.Moneylender and PinData[2] == GetString(PIN_MONEYLENDER) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        -- THE GOLDEN
        elseif VendorSaved.TheGolden and PinData[2] == GetString(PIN_THEGOLDEN) then
            LMP:CreatePin(PinType1, PinData, PinData[4], PinData[5])
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CustomPinTypeAddCallback()
    if not VendorSaved.Toggle then return end
    if (not LMP:IsEnabled(PinType2)) or (GetMapType() > MAPTYPE_ZONE) then return end
    local Zone, Subzone = LMP:GetZoneAndSubzone()
    local Pins = CustomVendorPinData[Zone .. "/" .. Subzone]
    if Pins == nil then return end
    for _, PinData in ipairs(Pins) do
        if VendorSaved.CustomVendor then
            LMP:CreatePin(PinType2, PinData, PinData[3], PinData[4])
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
VendorsPinTypeOnResizeCallback = function(pinManager, mapWidth, mapHeight)
    local visibleWidth, visibleHeight = ZO_WorldMapScroll:GetDimensions()
    local currentZoom = mapWidth / visibleWidth
    if currentZoom < 1.5 then
        LMP:SetLayoutData(PinType1, VendorsPinLayoutData)
        LMP:RefreshPins(PinType1)
        LMP:SetLayoutData(PinType2, CustomPinLayoutData)
        LMP:RefreshPins(PinType2)
    else
        LMP:SetLayoutData(PinType1, VendorsZoomPinLayoutData)
        LMP:RefreshPins(PinType1)
        LMP:SetLayoutData(PinType2, CustomZoomPinLayoutData)
        LMP:RefreshPins(PinType2)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function VendorsLoadPins()
    PinTypeId1 = LMP:AddPinType(PinType1, VendorsPinTypeAddCallback, VendorsPinTypeOnResizeCallback, VendorsPinLayoutData, VendorsPinTooltipCreator)
    PinTypeId2 = LMP:AddPinType(PinType2, CustomPinTypeAddCallback, VendorsPinTypeOnResizeCallback, CustomPinLayoutData, CustomPinTooltipCreator)
    LMP:AddPinFilter(PinTypeId1, "Vendors", false, VendorSaved, "VendorFilter")
    LMP:AddPinFilter(PinTypeId2, "Vendors (Custom)", false, VendorSaved, "CustomFilter")
    
    if ZrMM_RegisterCustomPin then
      ZrMM_RegisterCustomPin(PinType1, "Vendors")
      ZrMM_RegisterCustomPin(PinType2, "Vendors (Custom)")
   end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
