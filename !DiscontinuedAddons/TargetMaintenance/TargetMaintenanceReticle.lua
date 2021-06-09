local Window = GetWindowManager()
TargetMaintenanceName = Window:CreateTopLevelWindow(nil)
TargetMaintenanceLevel = Window:CreateTopLevelWindow(nil)
TargetMaintenanceCaption = Window:CreateTopLevelWindow(nil)

TargetMaintenanceVRankIcon = Window:CreateTopLevelWindow(nil)
TargetMaintenanceRankIcon = Window:CreateTopLevelWindow(nil)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- PATCH 2.4.5 Added Champion System All Veteran Ranks/Poins ETC REMOVED
function TMReticleLoad()
    TargetMaintenanceName:ClearAnchors()  
    --TargetMaintenanceName:SetDimensions(15,15)
    TargetMaintenanceName.Text = Window:CreateControl(nil, TargetMaintenanceName, CT_LABEL)
    TargetMaintenanceName.Text:SetFont("ZoFontGameSmall")
    TargetMaintenanceName.Text:SetAnchorFill(TargetMaintenanceName)
    TargetMaintenanceName.Text:SetHorizontalAlignment(1)
    
    TargetMaintenanceLevel:ClearAnchors()  
   -- TargetMaintenanceLevel:SetDimensions(15,15)
    TargetMaintenanceLevel:SetAnchor(RIGHT, TargetMaintenanceName.Text, LEFT, 0, 0)
    TargetMaintenanceLevel.Text = Window:CreateControl(nil, TargetMaintenanceLevel, CT_LABEL)
    TargetMaintenanceLevel.Text:SetFont("ZoFontGameSmall")
    TargetMaintenanceLevel.Text:SetAnchorFill(TargetMaintenanceLevel)
    TargetMaintenanceLevel.Text:SetHorizontalAlignment(1)
    
    TargetMaintenanceCaption:ClearAnchors()  
    --TargetMaintenanceCaption:SetDimensions(15,15)
    TargetMaintenanceCaption:SetAnchor(TOP, TargetMaintenanceName, BOTTOM, 0, 1)
    TargetMaintenanceCaption.Text = Window:CreateControl(nil, TargetMaintenanceCaption, CT_LABEL)
    TargetMaintenanceCaption.Text:SetFont("ZoFontGameSmall")
    TargetMaintenanceCaption.Text:SetAnchorFill(TargetMaintenanceCaption)
    TargetMaintenanceCaption.Text:SetHorizontalAlignment(1)
    
    -- Old Veteran System Convered To Champion
    TargetMaintenanceVRankIcon:SetDimensions(20,20)
    TargetMaintenanceVRankIcon.Icon = Window:CreateControl(nil, TargetMaintenanceVRankIcon, CT_TEXTURE)
    TargetMaintenanceVRankIcon.Icon:SetTexture(GetChampionPointsIcon("reticleover"))                  -- Fix For Champion Point System
    --TargetMaintenanceVRankIcon.Icon:SetTexture("esoui\art\champion\champion_icon.dds")              ------------------------------ THIS IS BROKEN
    TargetMaintenanceVRankIcon.Icon:SetAnchorFill(TargetMaintenanceVRankIcon)
    
    TargetMaintenanceRankIcon:SetDimensions(32,32)
    TargetMaintenanceRankIcon.Icon = Window:CreateControl(nil, TargetMaintenanceRankIcon, CT_TEXTURE)
    TargetMaintenanceRankIcon.Icon:SetColor(1,1,0) 
    TargetMaintenanceRankIcon.Icon:SetAnchorFill(TargetMaintenanceRankIcon)
    TMHideReticleIcons()
    TMHideReticleVIcons()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMShowReticleFrame()
    if not TMSaved.Toggle then return end
    if not TMSaved.ReticleFrame then return end
    TargetMaintenanceName:SetHidden(false)
    TargetMaintenanceLevel:SetHidden(false)
    TargetMaintenanceCaption:SetHidden(false)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMHideReticleFrame()
    TargetMaintenanceName:SetHidden(true)
    TargetMaintenanceLevel:SetHidden(true)
    TargetMaintenanceCaption:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMShowReticleIcons()
    if not TMSaved.Toggle then return end
    if not TMSaved.ReticleFrame then return end
    --TargetMaintenanceVRankIcon:SetHidden(false)
    TargetMaintenanceRankIcon:SetHidden(false)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMHideReticleIcons()
    --TargetMaintenanceVRankIcon:SetHidden(true)
    TargetMaintenanceRankIcon:SetHidden(true)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMShowReticleVIcons()
    if not TMSaved.Toggle then return end
    if not TMSaved.ReticleFrame then return end
    TargetMaintenanceVRankIcon:SetHidden(false)
    --TargetMaintenanceRankIcon:SetHidden(false)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMHideReticleVIcons()
    TargetMaintenanceVRankIcon:SetHidden(true)
    --TargetMaintenanceRankIcon:SetHidden(true)
end

function TMReticleScale()
    RETICLE.reticleTexture:SetScale(TMSaved.RScale)
    RETICLE.stealthIcon.stealthEyeTexture:SetScale(TMSaved.RScale)
    RETICLE.stealthIcon.stealthText:SetScale(TMSaved.RScale)
end
