local AddName = "CurrentCoin"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Window = GetWindowManager()
local CurrentCoinText = Window:CreateTopLevelWindow(nil)
local CurrentCoinIcon = Window:CreateTopLevelWindow(nil)                                                 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CCSavedVariables()
    CCSaved = ZO_SavedVars:New("CurrentCoin_SavedVariables", 1, nil, 
    { 
        Toggle = true,
        X = -378,
        Y = -3,
        Point = 9,
        RPoint = 9,
        Lock = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CCFramesUpdate()
    CCFramesHide()
    if not CCSaved.Toggle then return end
    -- Text
    CurrentCoinText:ClearAnchors()  
    CurrentCoinText:SetDimensions(50,15)
    CurrentCoinText:SetAnchor(CCSaved.Point,GuiRoot,nil,CCSaved.X,CCSaved.Y)
    CurrentCoinText.Text = Window:CreateControl(nil, CurrentCoinText, CT_LABEL)
    CurrentCoinText.Text:SetFont("ZoFontGame")
    CurrentCoinText.Text:SetAnchorFill(CurrentCoinText)
    CurrentCoinText:SetClampedToScreen(true)
    -- Icon
    CurrentCoinIcon:ClearAnchors()
    CurrentCoinIcon:SetDimensions(25,25)
    CurrentCoinIcon:SetAnchor(RIGHT,CurrentCoinText,LEFT,0,0)     
    CurrentCoinIcon.Icon = Window:CreateControl(nil, CurrentCoinIcon, CT_TEXTURE)
    CurrentCoinIcon.Icon:SetTexture("/esoui/art/guild/guildhistory_indexicon_guildstore_up.dds")
    CurrentCoinIcon.Icon:SetAnchorFill(CurrentCoinIcon)
    -- Lock
    if CCSaved.lock then
        CurrentCoinText:SetMovable(false)
        CurrentCoinText:SetMouseEnabled(false)
    else
        CurrentCoinText:SetMovable(true)
        CurrentCoinText:SetMouseEnabled(true)
    end
    CCUpdateText()
    CCFramesShow()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CCUpdateText()
    if CurrentCoinText.Text == nil then return end 
    CurrentCoinText.Text:SetText("|cFFFC96" ..GetCurrentMoney().. "|r")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CCFramesShow()
    if not CCSaved.Toggle then return end
    CurrentCoinText:SetHidden(false)
    CurrentCoinIcon:SetHidden(false)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CCFramesHide()
    CurrentCoinText:SetHidden(true)
    CurrentCoinIcon:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CCUpdateVars()
    local validAnchor, point, relativeTo, relativePoint, offSetX, offSetY = CurrentCoinText:GetAnchor()
    if(offSetX ~= CCSaved.X or offSetY ~= CCSaved.Y) then
        --d(string.format("Point: %d\nPrevious Anchor: %d, %d\nNew Anchor: %d, %d\n", point, CCSaved.X, CCSaved.Y, offSetX, offSetY))
        CCSaved.X = offSetX
        CCSaved.Y = offSetY
        CCSaved.Point = point
        if(relativePoint ~= nil) then
            CCSaved.RPoint = relativePoint
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CurrentCoinOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    CCSavedVariables() 
    CCFramesUpdate()
    EVENT_MANAGER:RegisterForEvent("CurrentCoin_Player", EVENT_PLAYER_ACTIVATED,
    function()
    CCLAM2Panel()                                                                                           -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("CurrentCoin_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("CurrentCoin_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("CurrentCoin_OnLoad", EVENT_ADD_ON_LOADED, CurrentCoinOnLoad)                      -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("CurrentCoin_Update", EVENT_MONEY_UPDATE, CCUpdateText)                  -- Bank Gold Event
EVENT_MANAGER:RegisterForEvent("CurrentCoin_Vars", EVENT_GLOBAL_MOUSE_DOWN, CCUpdateVars)
EVENT_MANAGER:RegisterForEvent("CurrentCoin_Vars", EVENT_GLOBAL_MOUSE_UP, CCUpdateVars)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------