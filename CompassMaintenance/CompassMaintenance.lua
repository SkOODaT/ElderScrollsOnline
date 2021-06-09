local AddName = "CompassMaintenance"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function COMSavedVariables()                                                                                            -- Saved Vars
    COMSaved = ZO_SavedVars:New("CompassMaintenance_SavedVariables", 1, nil, 
    { 
        Toggle = true,
        Scale = 1,
        Height = 30,
        Width = 300,
        TextScale = 1,
        X = -790,
        Y = 57,
        Point = 9,
        RPoint = 9,
        Lock = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function COMFramesUpdate()
    if COMSaved.Toggle then
        ZO_Compass:SetScale(COMSaved.Scale)
        ZO_Compass:SetDimensions(COMSaved.Width,COMSaved.Height)
        ZO_CompassCenterOverPinLabel:SetScale(COMSaved.TextScale)
        ZO_CompassFrameLeft:SetDimensions(10,COMSaved.Height)
        ZO_CompassFrameRight:SetDimensions(10,COMSaved.Height)
        ZO_CompassFrame:SetDimensions(COMSaved.Width,COMSaved.Height)
        
       -- ZO_CompassFrame:RefreshVisible() 
        --ZO_CompassFrame:SetHeight(height)
        --ZO_CompassFrameRight:SetHeight(height)
        --ZO_CompassFrameLeft:SetHeight(height)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function COMAdjustCompass()                                                                                            -- Default Compass Settings
    if not COMSaved.Toggle then
        COMDefaultCompass()
        return        
    end
    ZO_CompassFrame:ClearAnchors()
    ZO_CompassFrame:SetAnchor(COMSaved.Point,GuiRoot,nil,COMSaved.X,COMSaved.Y)                                     -- Compass Saved Position
    ZO_CompassFrame:SetClampedToScreen(true)                                                                        -- Prevent User From Draging Off Screen
    ZO_CompassFrame:SetDrawLayer(-1) 
    
    --ZO_TargetUnitFramereticleover:SetAnchor(0,GuiRoot,nil,200,200)
    --ZO_TargetUnitFramereticleoverLeftBracket
    --ZO_TargetUnitFramereticleoverBgContainerBgCenter:SetHidden(true) 
    
    if COMSaved.Lock then                                                                                           -- Is Lock Toggle On
        ZO_CompassFrame:SetMovable(false)                                                                           -- Lock Compass                    
        ZO_CompassFrame:SetMouseEnabled(false)                                                                      -- Disable Mouse
    else
        ZO_CompassFrame:SetMovable(true)                                                                            -- Unlock Compass
        ZO_CompassFrame:SetMouseEnabled(true)                                                                       -- Enable Mouse
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function COMDefaultCompass()                                                                                            -- Default Compass Settings
    ZO_CompassFrame:ClearAnchors()
    ZO_CompassFrame:SetAnchor(9,GuiRoot,nil,-630,40)
    ZO_CompassFrame:SetMovable(false)
    ZO_CompassFrame:SetMouseEnabled(false)
    ZO_CompassFrame:SetClampedToScreen(false)
    ZO_CompassFrame:SetScale(1)
    ZO_CompassCenterOverPinLabel:SetScale(1)
    ZO_CompassFrameLeft:SetDimensions(10,35)
    ZO_CompassFrameRight:SetDimensions(10,35)
    ZO_CompassFrame:SetDimensions(650,35)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function COMUpdateVars()                                                                                                -- Screen Position Update Function For Save Vars
    local validAnchor, point, relativeTo, relativePoint, offSetX, offSetY = ZO_CompassFrame:GetAnchor()
    if(offSetX ~= COMSaved.X or offSetY ~= COMSaved.Y) then
       --d(string.format("Point: %d\nPrevious Anchor: %d, %d\nNew Anchor: %d, %d\n", point, COMSaved.X, COMSaved.Y, offSetX, offSetY))
        COMSaved.X = offSetX
        COMSaved.Y = offSetY
        COMSaved.Point = point
        if(relativePoint ~= nil) then
            COMSaved.RPoint = relativePoint
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CompassMaintenanceOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    COMSavedVariables() 
    COMAdjustCompass()
    ZO_CompassFrame:SetHandler("OnUpdate", function()                                                                   -- Keep Compass OnUpdated!   Its A Bitch :S Tryed Many Other Ways Im Doing It On Update F-It
        COMFramesUpdate()
    end)    
    EVENT_MANAGER:RegisterForEvent("CompassMaintenance_Player", EVENT_PLAYER_ACTIVATED,
    function()
    CPMLAM2Panel() 
        EVENT_MANAGER:UnregisterForEvent("CompassMaintenance_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("CompassMaintenance_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("CompassMaintenance_OnLoad", EVENT_ADD_ON_LOADED, CompassMaintenanceOnLoad)                                       -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("CompassMaintenance_Vars", EVENT_GLOBAL_MOUSE_DOWN, COMUpdateVars)
EVENT_MANAGER:RegisterForEvent("CompassMaintenance_Vars", EVENT_GLOBAL_MOUSE_UP, COMUpdateVars)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------