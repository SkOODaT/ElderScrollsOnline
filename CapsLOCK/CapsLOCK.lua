local AddName = "CapsLOCK"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Window = GetWindowManager()
local CapsLOCKText = Window:CreateTopLevelWindow(nil)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CLSavedVariables()
    CLSaved = ZO_SavedVars:New("CapsLOCK_SavedVariables", 1, nil, 
    { 
        Toggle = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CLUpdate()
    CLHideFrame()
    if not IsCapsLockOn() then return end
    if not CLSaved.Toggle then return end
    CapsLOCKText:ClearAnchors()  
    CapsLOCKText:SetDimensions(250,15)
    CapsLOCKText:SetAnchor(BOTTOM, ZO_ChatWindow, TOPLEFT, 130, -20)
    CapsLOCKText.Text = Window:CreateControl(nil, CapsLOCKText, CT_LABEL)
    CapsLOCKText.Text:SetFont("ZoFontGameMedium")
    CapsLOCKText.Text:SetAnchorFill(CapsLOCKText)
    CapsLOCKText.Text:SetText("|cFF0000-- CAPS LOCK IS ON! --|r")
    CLShowFrame()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CLShowFrame()
    if not CLSaved.Toggle then return end
    CapsLOCKText:SetHidden(false)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CLHideFrame()
    CapsLOCKText:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CapsLOCKOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    CLSavedVariables()
    CLUpdate()
    EVENT_MANAGER:RegisterForEvent("CapsLOCK_Player", EVENT_PLAYER_ACTIVATED,
    function()
    CLLAM2Panel()                                                                                           -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("CapsLOCK_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("CapsLOCK_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("CapsLOCK_OnLoad", EVENT_ADD_ON_LOADED, CapsLOCKOnLoad)                      -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("CapsLOCK_Update", EVENT_CAPS_LOCK_STATE_CHANGED, CLUpdate)                  -- Caps lock Event WTF lol
--------------------------------------------------------------------------------------------------------------------------------------------------------------------