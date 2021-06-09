local AddName = "BankCoin"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Window = GetWindowManager()
local BankCoinText = Window:CreateTopLevelWindow(nil)
local BankCoinIcon = Window:CreateTopLevelWindow(nil)                                                 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BCSavedVariables()
    BCSaved = ZO_SavedVars:New("BankCoin_SavedVariables", 1, nil, 
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
function BCFramesUpdate()
    BCFramesHide()
    if not BCSaved.Toggle then return end
    -- Text
    BankCoinText:ClearAnchors()  
    BankCoinText:SetDimensions(50,15)
    BankCoinText:SetAnchor(BCSaved.Point,GuiRoot,nil,BCSaved.X,BCSaved.Y)
    BankCoinText.Text = Window:CreateControl(nil, BankCoinText, CT_LABEL)
    BankCoinText.Text:SetFont("ZoFontGame")
    BankCoinText.Text:SetAnchorFill(BankCoinText)
    BankCoinText:SetClampedToScreen(true)
    -- Icon
    BankCoinIcon:ClearAnchors()
    BankCoinIcon:SetDimensions(25,25)
    BankCoinIcon:SetAnchor(RIGHT,BankCoinText,LEFT,0,0)     
    BankCoinIcon.Icon = Window:CreateControl(nil, BankCoinIcon, CT_TEXTURE)
    BankCoinIcon.Icon:SetTexture("/esoui/art/guild/guildhistory_indexicon_guildstore_up.dds")
    BankCoinIcon.Icon:SetAnchorFill(BankCoinIcon)
    -- Lock
    if BCSaved.lock then
        BankCoinText:SetMovable(false)
        BankCoinText:SetMouseEnabled(false)
    else
        BankCoinText:SetMovable(true)
        BankCoinText:SetMouseEnabled(true)
    end
    BCUpdateText()
    BCFramesShow()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BCUpdateText()
    if BankCoinText.Text == nil then return end 
    BankCoinText.Text:SetText("|cFFFC96" ..GetBankedMoney().. "|r")
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BCFramesShow()
    if not BCSaved.Toggle then return end
    BankCoinText:SetHidden(false)
    BankCoinIcon:SetHidden(false)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BCFramesHide()
    BankCoinText:SetHidden(true)
    BankCoinIcon:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BCUpdateVars()
    local validAnchor, point, relativeTo, relativePoint, offSetX, offSetY = BankCoinText:GetAnchor()
    if(offSetX ~= BCSaved.X or offSetY ~= BCSaved.Y) then
        --d(string.format("Point: %d\nPrevious Anchor: %d, %d\nNew Anchor: %d, %d\n", point, BCSaved.X, BCSaved.Y, offSetX, offSetY))
        BCSaved.X = offSetX
        BCSaved.Y = offSetY
        BCSaved.Point = point
        if(relativePoint ~= nil) then
            BCSaved.RPoint = relativePoint
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BankCoinOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    BCSavedVariables() 
    BCFramesUpdate()
    EVENT_MANAGER:RegisterForEvent("BankCoin_Player", EVENT_PLAYER_ACTIVATED,
    function()
    BCLAM2Panel()                                                                                           -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("BankCoin_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("BankCoin_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("BankCoin_OnLoad", EVENT_ADD_ON_LOADED, BankCoinOnLoad)                      -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("BankCoin_Update", EVENT_BANKED_MONEY_UPDATE, BCUpdateText)                  -- Bank Gold Event
EVENT_MANAGER:RegisterForEvent("BankCoin_Vars", EVENT_GLOBAL_MOUSE_DOWN, BCUpdateVars)
EVENT_MANAGER:RegisterForEvent("BankCoin_Vars", EVENT_GLOBAL_MOUSE_UP, BCUpdateVars)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------