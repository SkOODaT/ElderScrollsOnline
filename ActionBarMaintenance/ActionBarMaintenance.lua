local AddName = "ActionBarMaintenance"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ABSavedVariables()
    ABSaved = ZO_SavedVars:New("ActionBarMaintenance_SavedVariables", 1, nil,
    { 
        Toggle = true,
        Scale = 0.80,
        BGHide = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ABFramesUpdate()
    if ABSaved.Toggle then
        if ABSaved.BGHide then
            ZO_ActionBar1KeybindBG:SetHidden(true)
        else
            ZO_ActionBar1KeybindBG:SetHidden(false)
        end
        ZO_ActionBar1:SetScale(ABSaved.Scale)
		CompanionUltimateButtonDecoration:SetAnchor(CENTER, CompanionUltimateButton, CENTER, 0, 0)    -- Fix For 100035 Companions
        ActionButton8Decoration:SetAnchor(CENTER, ActionButton8, CENTER, 0, 0)   -- Fix For 100005 Scaling Issues
    else
        ZO_ActionBar1:SetScale(1)
        ZO_ActionBar1KeybindBG:SetHidden(false)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ActionBarMaintenanceOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    ABSavedVariables()
    ABFramesUpdate()
    EVENT_MANAGER:RegisterForEvent("ActionBarMaintenance_Player", EVENT_PLAYER_ACTIVATED,
    function()
        ABMLAM2Panel()
        EVENT_MANAGER:UnregisterForEvent("ActionBarMaintenance_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("ActionBarMaintenance_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("ActionBarMaintenance_OnLoad", EVENT_ADD_ON_LOADED, ActionBarMaintenanceOnLoad)                    -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("ActionBarMaintenance_Update", EVENT_GLOBAL_MOUSE_DOWN, ABFramesUpdate)                          -- Temp Fix For Skills Menu BG Reappearing
--------------------------------------------------------------------------------------------------------------------------------------------------------------------