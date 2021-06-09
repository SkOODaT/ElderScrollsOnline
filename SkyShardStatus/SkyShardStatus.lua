local AddName = "SkyShardStatus"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Window = GetWindowManager()
local SkyShardStatusIcon = Window:CreateTopLevelWindow(nil)                                                 
local SkyShardStatusIconBG = Window:CreateTopLevelWindow(nil)                                                 
local SkyShardStatusIcon1 = Window:CreateTopLevelWindow(nil)                                                  
local SkyShardStatusIcon2 = Window:CreateTopLevelWindow(nil)                                                 
local SkyShardStatusIcon3 = Window:CreateTopLevelWindow(nil)                                                  
local SkyShardStatusText = Window:CreateTopLevelWindow(nil)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SSSavedVariables()                                                                                                     -- Saved Vars
    SSSaved = ZO_SavedVars:New("SkyShardStatus_SavedVariables", 1, nil,
    { 
        Toggle = true,
        Scale = 0.60,
        X = -490,
        Y = -112,
        Point = 12,
        RPoint = 12,
        Lock = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SSSUpdate()
    SSSHide()                                                                                                                    -- Hide Everything To Start                    
    if not SSSaved.Toggle then return end
    if SkyShardStatusText.Text == nil then return end                                                                           -- If Text Is NIL return
    if ZO_GameMenu_InGame:IsHidden() == false or ZO_InteractWindow:IsHidden() == false or ZO_KeybindStripControl:IsHidden() == false then return end  -- Keep Hidden Eeven If Update In Menus
    SkyShardStatusText.Text:SetText(GetNumSkyShards().. "/3")                                                                   -- Set Text
    SkyShardStatusText:SetHidden(false)
    if GetNumSkyShards() == 0 then                                                                                              -- Skyshard Status
        SkyShardStatusIconBG:SetHidden(false)
        SkyShardStatusIcon1:SetHidden(true)
        SkyShardStatusIcon2:SetHidden(true)
        SkyShardStatusIcon3:SetHidden(true)
    elseif GetNumSkyShards() == 1 then
        SkyShardStatusIconBG:SetHidden(false)
        SkyShardStatusIcon1:SetHidden(false)
        SkyShardStatusIcon2:SetHidden(true)
        SkyShardStatusIcon3:SetHidden(true)
    elseif GetNumSkyShards() == 2 then
        SkyShardStatusIconBG:SetHidden(false)
        SkyShardStatusIcon1:SetHidden(false)
        SkyShardStatusIcon2:SetHidden(false)
        SkyShardStatusIcon3:SetHidden(true)
    elseif GetNumSkyShards() == 3 then
        SkyShardStatusIconBG:SetHidden(false)
        SkyShardStatusIcon1:SetHidden(false)
        SkyShardStatusIcon2:SetHidden(false)
        SkyShardStatusIcon3:SetHidden(false)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SSSFrames()
    if not SSSaved.Toggle then return end
    -- MainFrame
    SkyShardStatusIcon:SetDimensions(30,60)
    SkyShardStatusIcon:ClearAnchors()
    SkyShardStatusIcon:SetAnchor(SSSaved.Point,GuiRoot,nil,SSSaved.X,SSSaved.Y)       
    SkyShardStatusIcon:SetMouseEnabled(true)
    SkyShardStatusIcon:SetClampedToScreen(true)
    SkyShardStatusIcon:SetAlpha(0)
    SkyShardStatusIcon:SetScale(SSSaved.Scale)
    if SSSaved.Lock then
        SkyShardStatusIcon:SetMovable(false)
    else
        SkyShardStatusIcon:SetMovable(true)
    end
    -- Background
    SkyShardStatusIconBG:SetDimensions(30,60)
    SkyShardStatusIconBG:SetAnchor(CENTER,SkyShardStatusIcon,CENTER,0,0)
    SkyShardStatusIconBG.Icon = Window:CreateControl(nil, SkyShardStatusIconBG, CT_TEXTURE)
    SkyShardStatusIconBG.Icon:SetTexture("/esoui/art/progression/skyshard_base.dds")
    SkyShardStatusIconBG.Icon:SetAnchorFill(SkyShardStatusIconBG)
    SkyShardStatusIconBG:SetScale(SSSaved.Scale)
    SkyShardStatusIconBG:SetHidden(true)
    -- Icon 1
    SkyShardStatusIcon1:SetDimensions(30,60)
    SkyShardStatusIcon1:SetAnchor(CENTER,SkyShardStatusIconBG,CENTER,0,0)     
    SkyShardStatusIcon1.Icon = Window:CreateControl(nil, SkyShardStatusIcon1, CT_TEXTURE)
    SkyShardStatusIcon1.Icon:SetTexture("/esoui/art/progression/skyshard_1.dds")
    SkyShardStatusIcon1.Icon:SetAnchorFill(SkyShardStatusIcon1)
    SkyShardStatusIcon1:SetScale(SSSaved.Scale)
    SkyShardStatusIcon1:SetHidden(true)
    -- Icon 2
    SkyShardStatusIcon2:SetDimensions(30,60)
    SkyShardStatusIcon2:SetAnchor(CENTER,SkyShardStatusIconBG,CENTER,0,0)      
    SkyShardStatusIcon2.Icon = Window:CreateControl(nil, SkyShardStatusIcon2, CT_TEXTURE)
    SkyShardStatusIcon2.Icon:SetTexture("/esoui/art/progression/skyshard_2.dds")
    SkyShardStatusIcon2.Icon:SetAnchorFill(SkyShardStatusIcon2)
    SkyShardStatusIcon2:SetScale(SSSaved.Scale)
    SkyShardStatusIcon2:SetHidden(true)
    -- Icon 3
    SkyShardStatusIcon3:SetDimensions(30,60)
    SkyShardStatusIcon3:SetAnchor(CENTER,SkyShardStatusIconBG,CENTER,0,0)       
    SkyShardStatusIcon3.Icon = Window:CreateControl(nil, SkyShardStatusIcon3, CT_TEXTURE)
    SkyShardStatusIcon3.Icon:SetTexture("/esoui/art/progression/skyshard_3.dds")
    SkyShardStatusIcon3.Icon:SetAnchorFill(SkyShardStatusIcon3)
    SkyShardStatusIcon3:SetScale(SSSaved.Scale)
    SkyShardStatusIcon3:SetHidden(true)
    -- Text
    SkyShardStatusText:SetDimensions(75,15)
    SkyShardStatusText:SetAnchor(LEFT,SkyShardStatusIconBG,RIGHT,0,0)
    SkyShardStatusText.Text = Window:CreateControl(nil, SkyShardStatusText, CT_LABEL)
    SkyShardStatusText.Text:SetFont("ZoFontGameSmall")
    SkyShardStatusText.Text:SetAnchorFill(SkyShardStatusText)
    SkyShardStatusText:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SSSHide()                                                                                                       -- Hide Everything 
    SkyShardStatusText:SetHidden(true)
    SkyShardStatusIconBG:SetHidden(true)
    SkyShardStatusIcon1:SetHidden(true)
    SkyShardStatusIcon2:SetHidden(true)
    SkyShardStatusIcon3:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SSSShowHide()                                                                                                  -- Show/Hide Handlers
    ZO_PreHookHandler(ZO_GameMenu_InGame, 'OnShow', function()
        SSSHide()
    end)
    ZO_PreHookHandler(ZO_GameMenu_InGame, 'OnHide', function()
        SSSUpdate()
    end)
    ZO_PreHookHandler(ZO_InteractWindow, 'OnShow', function()
        SSSHide()
    end)
    ZO_PreHookHandler(ZO_InteractWindow, 'OnHide', function()
        SSSUpdate()
    end)
    ZO_PreHookHandler(ZO_KeybindStripControl, 'OnShow', function()
        SSSHide()
    end)
    ZO_PreHookHandler(ZO_KeybindStripControl, 'OnHide', function()
        SSSUpdate()
    end)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OnAddonLoaded(Event, AddonName)
    if AddonName ~= AddName then return end
    SSSavedVariables() 
    SSSFrames()
    SSSUpdate()
    SSSShowHide()
    EVENT_MANAGER:RegisterForEvent("SkyShardStatus_Player", EVENT_PLAYER_ACTIVATED,
    function()
    SSSLAM2Panel()                                                                                                          -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("SkyShardStatus_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("SkyShardStatus_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SSSUpdateVars()
    local validAnchor, point, relativeTo, relativePoint, offSetX, offSetY = SkyShardStatusIcon:GetAnchor()
    if(offSetX ~= SSSaved.X or offSetY ~= SSSaved.Y) then
       --d(string.format("Point: %d\nPrevious Anchor: %d, %d\nNew Anchor: %d, %d\n", point, SSSaved.X, SSSaved.Y, offSetX, offSetY))
        SSSaved.X = offSetX
        SSSaved.Y = offSetY
        SSSaved.Point = point
        if(relativePoint ~= nil) then
            SSSaved.RPoint = relativePoint
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("SkyShardStatus_OnLoad", EVENT_ADD_ON_LOADED, OnAddonLoaded)                                 -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("SkyShardStatus_Update", EVENT_SKILL_POINTS_CHANGED, SSSUpdate)
EVENT_MANAGER:RegisterForEvent("SkyShardStatus_Vars", EVENT_GLOBAL_MOUSE_DOWN, SSSUpdateVars)
EVENT_MANAGER:RegisterForEvent("SkyShardStatus_Vars", EVENT_GLOBAL_MOUSE_UP, SSSUpdateVars)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------