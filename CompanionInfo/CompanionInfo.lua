-- TODO
-- Max Level Check If Needed~ Lv 20
-- Fix Weird Text/Companion States
-- Hide On More States?
-- Maybe Make Text Length Dynamic/Alt Styles?
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local AddName = "CompanionInfo"
local Version = 100035
----------------------------------
local Window = GetWindowManager()
local CompanionInfoText = Window:CreateTopLevelWindow(nil)
local CompanionInfoIcon = Window:CreateTopLevelWindow(nil)
----------------------------------
local GainedExperience = 0
----------------------------------
local ChangedRapport = 0
local PrevRapport = 0
local RAPOperator = ""
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesSetup()
    if not CISaved.Toggle then return end
    -- Make Text
    CompanionInfoText:ClearAnchors()  
    CompanionInfoText:SetDimensions(600,15)
    CompanionInfoText:SetAnchor(CISaved.Point,GuiRoot,nil,CISaved.X,CISaved.Y)
    CompanionInfoText.Text = Window:CreateControl("CompanionInfoText", CompanionInfoText, CT_LABEL)
    CompanionInfoText.Text:SetAnchorFill(CompanionInfoText)
    CompanionInfoText.Text:SetFont("ZoFontGame")
    -- Clamp Main Frame To Screen
    CompanionInfoText:SetClampedToScreen(true)
    -- Make Icon
    CompanionInfoIcon:ClearAnchors()
    CompanionInfoIcon:SetDimensions(25,25)
    CompanionInfoIcon:SetAnchor(RIGHT,CompanionInfoText,LEFT,0,3)     
    CompanionInfoIcon.Icon = Window:CreateControl("CompanionInfoIcon", CompanionInfoIcon, CT_TEXTURE)
    CompanionInfoIcon.Icon:SetAnchorFill(CompanionInfoIcon)
    -- Make Tooltip 
    CompanionInfoText:SetHandler("OnMouseEnter", CIFramesOnMouseEnter)
    CompanionInfoText:SetHandler("OnMouseExit", CIFramesOnMouseExit)
    -- Check Lock Status
    CILock()
    -- Hide Frame On Setup
    CIFramesHide()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesShow()
    if not CISaved.Toggle then return end
    CompanionInfoText:SetHidden(false)
    CompanionInfoIcon:SetHidden(false)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesHide()
    -- Reset Values To 0 On Setup/Deactivated Event And Addon Toggle
    GainedExperience = 0
    PrevRapport = 0
    ChangedRapport = 0
    CompanionInfoText:SetHidden(true)
    CompanionInfoIcon:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesNoZeroHide()
    -- No Zero Hide On Interaction Events And Temp Stuff
    CompanionInfoText:SetHidden(true)
    CompanionInfoIcon:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CICompantionInfo()
    -- Gather Companion Infos
    if not HasActiveCompanion() then return end
    local NameVar = GetActiveCompanionDefId()
    local Name = GetCompanionName(NameVar)
    -- Trim Garbage
    if Name:find("%^M$") then 
        Name = Name:gsub("%^M", "")
    elseif Name:find("%^F$") then
        Name = Name:gsub("%^F", "")
    end
    local Icon = ZO_COMPANION_MANAGER:GetActiveCompanionIcon()
    local Level, XP = GetActiveCompanionLevelInfo()
    local TotalXP = GetNumExperiencePointsInCompanionLevel(Level + 1) or 0
    local XPPercent = 0
    if not (TotalXP == 0) then XPPercent = zo_floor(XP / TotalXP * 100) end
    local RapLevel = GetActiveCompanionRapportLevel()
    local RapMin = GetMinimumRapport() 
    local RapValue = GetActiveCompanionRapport()
    local RapMax = GetMaximumRapport()
    local RapLevelString = GetString("SI_COMPANIONRAPPORTLEVEL", RapLevel)
    local RapLevelDesc = GetActiveCompanionRapportLevelDescription(GetActiveCompanionRapportLevel())
    local PassiveAbility = GetAbilityName(GetCompanionPassivePerkAbilityId(GetActiveCompanionDefId()))
    local PassiveAbilityDesc = GetAbilityDescription(GetCompanionPassivePerkAbilityId(GetActiveCompanionDefId()))
    -- Set Outfit To None If Nil
    local Outfit = "None"
    if ZO_OUTFIT_MANAGER:GetEquippedOutfitIndex(GAMEPLAY_ACTOR_CATEGORY_COMPANION) then
        Outfit = ZO_OUTFIT_MANAGER:GetEquippedOutfitIndex(GAMEPLAY_ACTOR_CATEGORY_COMPANION)
    end
    return Name, Icon, Level, XP, TotalXP, XPPercent, RapLevel, RapMin, RapValue, RapMax, RapLevelString, RapLevelDesc, PassiveAbility, PassiveAbilityDesc, Outfit
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesOnMouseEnter()
    -- Int Tooltip
    InitializeTooltip(InformationTooltip, CompanionInfoText, BOTTOM, 0, -5)
    -- Set Tooltip Info
    local TooltipText = ""
    local ExpierenceString = ""
    if Level < 20 then
        ExpierenceString = " ("..XP.."/"..TotalXP..") "..XPPercent.."%".." [+"..GainedExperience.."]"
    end
    if HasActiveCompanion() and not HasPendingCompanion() then
        Name, Icon, Level, XP, TotalXP, XPPercent, RapLevel, RapMin, RapValue, RapMax, RapLevelString, RapLevelDesc, PassiveAbility, PassiveAbilityDesc, Outfit = CICompantionInfo()
        TooltipText = "|c"..CISaved.TextColor..Name.." (Outfit "..Outfit..") |t16:16:"..Icon.."|t"..
                      "\nLv:"..Level..ExpierenceString..
                      "\nRap:"..RapLevel.." ("..PrevRapport..") ("..RapMin.."/"..RapValue.."/"..RapMax..")".." ["..RAPOperator..ChangedRapport.."]"..
                      "\n|c00FEF1"..RapLevelString.."|r: |c"..CISaved.TextColor..RapLevelDesc..
                      "\n|c34FE00"..PassiveAbility.."|r: |c"..CISaved.TextColor..PassiveAbilityDesc..
                      "|r"
    end
    -- Set Tooltip Text
    SetTooltipText(InformationTooltip, TooltipText)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesOnMouseExit()
    -- Clear Tooltip
    ClearTooltip(InformationTooltip)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesBuiltFrame()
    Name, Icon, Level, XP, TotalXP, XPPercent, RapLevel, RapMin, RapValue, RapMax, RapLevelString, RapLevelDesc, PassiveAbility, PassiveAbilityDesc, Outfit = CICompantionInfo()
    -- Built Frame Text
    local FrameIcon = ""
    local FrameName = ""
    local FrameLevel = ""
    local FrameExpierence = ""
    local FramePercent = ""
    local FrameGain = ""
    local FrameLevelRap = ""
    local FramePrevRap = ""
    local FrameChangedRap = ""
    local FrameCurrentRap = ""
    local FrameDescRap = ""
    -- Icon
    if CISaved.MainIcon then
        FrameIcon = Icon
    end
    -- Name
    if CISaved.MainName then
        -- Trim Names 
        if CISaved.MainNameShort then
            if Name:find("% Hallix$") then 
                Name = Name:gsub("% Hallix", "")
            elseif Name:find("% Elendis$") then
                Name = Name:gsub("% Elendis", "")
            end
        end
        FrameName = Name
    end
    -- Level
    if CISaved.MainName and CISaved.MainLevel then
        FrameLevel = " Lv:"..Level..""
    elseif CISaved.MainLevel then
        FrameLevel = "Lv:"..Level..""
    end
    -- Raw XP
    if CISaved.MainRawXP then 
        FrameExpierence = " ("..XP.."/"..TotalXP..")"
    end
    -- Percent XP
    if CISaved.MainPercentXP then
        FramePercent = " "..XPPercent.."%"
    end
    -- Gain XP
    if CISaved.MainGainXP then
        FrameGain = " [+"..GainedExperience.."]"
    end
    -- Rap Level
    if CISaved.MainLevelRap then
        FrameLevelRap = " Rap:"..RapLevel..""
    end
    -- Rap Previous
    if CISaved.MainPrevRap then
        FramePrevRap = " ("..PrevRapport..")"
    end
    -- Rap Changed
    if CISaved.MainChangedRap then
        FrameChangedRap = " ["..RAPOperator..ChangedRapport.."]"
    end
    -- Rap Changed
    if CISaved.MainCurrentRap then
        FrameCurrentRap = " ("..RapValue..")"
    end
    -- Rap Description
    if CISaved.MainDescRap then
        FrameDescRap = " "..RapLevelString
    end
    return FrameIcon, FrameName, FrameLevel, FrameExpierence, FramePercent, FrameGain, FrameLevelRap, FramePrevRap, FrameChangedRap, FrameCurrentRap, FrameDescRap
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesUpdate()
    if not CISaved.Toggle then return end
    if CompanionInfoText.Text == nil then return end
    local FrameText = ""
    if HasActiveCompanion() and not HasPendingCompanion() then
        FrameIcon, FrameName, FrameLevel, FrameExpierence, FramePercent, FrameGain, FrameLevelRap, FramePrevRap, FrameChangedRap, FrameCurrentRap, FrameDescRap = CIFramesBuiltFrame()
        -- Update Icon
        CompanionInfoIcon.Icon:SetTexture(FrameIcon)
        if not CISaved.MainIcon then
            CompanionInfoIcon:SetHidden(true)
        elseif GetInteractionType() == 14 then
            CompanionInfoIcon:SetHidden(true)
        else
            CompanionInfoIcon:SetHidden(false)
        end
        local ExpierenceString = ""
        if Level < 20 then
            ExpierenceString = FrameExpierence..FramePercent..FrameGain
        end
        FrameText = "|c"..CISaved.TextColor..FrameName..
                    FrameLevel..ExpierenceString..
                    FrameLevelRap..FramePrevRap..FrameChangedRap..FrameCurrentRap..FrameDescRap..
                    "|r"
    else
        -- No Zeroed Hide
        CIFramesNoZeroHide()
    end
    -- Set Frame Text
    CompanionInfoText.Text:SetText(FrameText)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesXPEvent(companionId, level, previousExperience, currentExperience)
    GainedExperience = currentExperience - previousExperience
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIFramesRapEvent(companionId, previousRapport, currentRapport)
    PrevRapport = previousRapport
    ChangedRapport = currentRapport - previousRapport
    if currentRapport > previousRapport then
        RAPOperator = "+"
    else
        RAPOperator = ""
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CompanionWarning(warningType, companionId)
    d("Companion Info Warning Event: "..warningType..""..companionId)
    if warningType == COMPANION_WARNING_TYPE_REMOVED_FOR_GROUP_PLAYER then
        d("[CompanionInfo Warning] Companion UnSummoned Due To Group Being Full.")
    elseif warningType == COMPANION_WARNING_TYPE_SUMMON_FAILED_LOW_RAPPORT then
        d("[CompanionInfo Warning] Companion Did NOT Summon Due To Low Rapport.")
    else
        d("[CompanionInfo Warning] Event Error Occured "..warningType)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CISavedVariables()
    CISaved = ZO_SavedVars:NewAccountWide(AddName.."_SavedVariables", Version, GetWorldName(), 
    { 
        Toggle = true,
        X = -378,
        Y = -3,
        Point = 9,
        RPoint = 9,
        Lock = false,
        MainIcon = true,
        MainName = true,
        MainNameShort = true,
        MainLevel = true,
        MainRawXP = true, 
        MainPercentXP = true,
        MainGainXP = true,
        MainLevelRap = true,
        MainPrevRap = true,
        MainChangedRap = true,
        MainCurrentRap = true,
        MainDescRap = true,
        TextColor = "FFFFFF",
        CompassHide = false,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CICompassHide()
    -- Hide/Show Companion Pin On Compass
    if CISaved.CompassHide == true then
        COMPASS.container:SetAlphaDropoffBehavior(MAP_PIN_TYPE_ACTIVE_COMPANION, 0, 0, 0, 0)
    else
        COMPASS.container:SetAlphaDropoffBehavior(MAP_PIN_TYPE_ACTIVE_COMPANION, 1, 1, 1, 1)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CIUpdatePosition()
    local validAnchor, point, relativeTo, relativePoint, offSetX, offSetY = CompanionInfoText:GetAnchor()
    if(offSetX ~= CISaved.X or offSetY ~= CISaved.Y) then
        --d(string.format("Point: %d\nPrevious Anchor: %d, %d\nNew Anchor: %d, %d\n", point, CISaved.X, CISaved.Y, offSetX, offSetY))
        CISaved.X = offSetX
        CISaved.Y = offSetY
        CISaved.Point = point
        if(relativePoint ~= nil) then
            CISaved.RPoint = relativePoint
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CILock()
    if CISaved.Lock then
        CompanionInfoText:SetMovable(false)
        CompanionInfoText:SetMouseEnabled(true)
    else
        CompanionInfoText:SetMovable(true)
        CompanionInfoText:SetMouseEnabled(true)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CompanionInfoOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    -- Load Saved Vars
    CISavedVariables()
    CICompassHide()
    -- Setup Frames
    CIFramesSetup()
    -- Make Settings Panel
    EVENT_MANAGER:RegisterForEvent(AddName.."_Player", EVENT_PLAYER_ACTIVATED,
    function()
        CILAM2Panel()
        -- Show If Companion OnLoad EVENT_PLAYER_ACTIVATED
        if HasActiveCompanion() then
            CIFramesShow()
            CIFramesUpdate()
        end
        -- Warning Event 
        EVENT_MANAGER:RegisterForEvent(AddName.."_Warning", EVENT_COMPANION_WARNING, CompanionWarning) -- Might Of Been Renamed To Below~
        EVENT_MANAGER:RegisterForEvent(AddName.."_Warning", EVENT_COMPANION_SUMMON_RESULT, CompanionWarning)
        -- Update Event 
        EVENT_MANAGER:RegisterForEvent(AddName.."_Update", EVENT_COMPANION_EXPERIENCE_GAIN, function(eventId, ...) CIFramesXPEvent(...) CIFramesUpdate() end)
        EVENT_MANAGER:RegisterForEvent(AddName.."_Update", EVENT_COMPANION_RAPPORT_UPDATE, function(eventId, ...) CIFramesRapEvent(...) CIFramesUpdate() end)
        --EVENT_MANAGER:RegisterForEvent(AddName.."_Update", EVENT_ACTIVE_COMPANION_STATE_CHANGED, CIFramesUpdate)
        EVENT_MANAGER:RegisterForEvent(AddName.."_Update", EVENT_OPEN_COMPANION_MENU, CIFramesUpdate)
        EVENT_MANAGER:RegisterForEvent(AddName.."_Update", EVENT_RETICLE_TARGET_CHANGED, CIFramesUpdate)
        -- Show Event
        EVENT_MANAGER:RegisterForEvent(AddName.."_Show", EVENT_COMPANION_ACTIVATED, function() CIFramesShow() CIFramesUpdate() end)
        EVENT_MANAGER:RegisterForEvent(AddName.."_Show", EVENT_CHATTER_END, function() CIFramesShow() CIFramesUpdate() end)
        -- Hide/Show Event
        EVENT_MANAGER:RegisterForEvent(AddName.."_Hide", EVENT_COMPANION_DEACTIVATED, function() CIFramesHide() end)
        EVENT_MANAGER:RegisterForEvent(AddName.."_Hide", EVENT_CHATTER_BEGIN, function() CIFramesNoZeroHide() end)
        -- Saved Vars Event
        EVENT_MANAGER:RegisterForEvent(AddName.."_Vars", EVENT_GLOBAL_MOUSE_DOWN, function() CIUpdatePosition() end)
        EVENT_MANAGER:RegisterForEvent(AddName.."_Vars", EVENT_GLOBAL_MOUSE_UP, function() CIUpdatePosition() end)
        -- Deregister Player Event No Longer Needed
        EVENT_MANAGER:UnregisterForEvent(AddName.."_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent(AddName.."_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Debug For Later
--[[function CIFramesState(event, newState, oldState)
    d("["..AddName.."] OLD State: "..oldState)
    d("["..AddName.."] NEW State: "..newState)
end

HasActiveCompanion()  HasPendingCompanion()  GetPendingCompanionDefId()  

EVENT_ACTIVE_COMPANION_STATE_CHANGED (CompanionState newState, CompanionState oldState) 
CompanionState
COMPANION_STATE_ACTIVE
COMPANION_STATE_INACTIVE
COMPANION_STATE_PENDING   IsOwnerOfCurrentHouse()
]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LoadUp Event
EVENT_MANAGER:RegisterForEvent(AddName.."_OnLoad", EVENT_ADD_ON_LOADED, CompanionInfoOnLoad)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
