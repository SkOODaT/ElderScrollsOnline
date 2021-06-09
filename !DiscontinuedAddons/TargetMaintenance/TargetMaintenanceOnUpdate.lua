--------------------------------------------------------------------------------------------------------------------------------------------------------------------
TMTargetName = ""                                                                                                           -- Default Name Text Var
TMTargetlevel = ""                                                                                                          -- Default Level Text Var
TMTargetCaption = ""                                                                                                        -- Default Caption Text Var            
TMTargetRName = ""                                                                                                           
TMTargetRlevel = ""                                                                                                          
TMTargetRCaption = "" 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMStartUpOnUpdate()                                                                            -- Hijacks ESO Defaults OnUpdate XML ....LUA EventUpdate Caused Weird Jumps + Other Issues Level Is Defined Too As Its Force Shown As An Anchor
    local timelastrun = 0
    ZO_TargetUnitFramereticleoverTextArea:SetHandler("OnUpdate", function(self, timerun)
        if (timerun - timelastrun) >= 0.001 then                                                                                 -- Change 1 to however long you wish your delay to be (1, 2, 0.5, 0.1, etc)
            timelastrun = timerun
            TMOnUpdate()
        end
    end)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PATCH 2.4.5 Added Champion System All Veteran Ranks/Poins ETC REMOVED
function TMOnUpdate()                                                                                                       
    local Name = GetUnitName("reticleover")
    local Reaction = GetUnitReaction("reticleover")
    --------------------------------------------------------------------------
    if not DoesUnitExist("reticleover") then return end
    --------------------------------------------------------------------------
    if TMSaved.Toggle then
        if TMSaved.TargetFrame then
            -- Scaleing --------------------------------------------------------------------------
            ZO_TargetUnitFramereticleoverName:SetFont("ZoFontConversationName")                                                               -- Scale Text
            ZO_TargetUnitFramereticleoverCaption:SetFont("ZoFontConversationName")                                                         
            ZO_TargetUnitFramereticleoverLevel:SetFont("ZoFontConversationName")
            
            ZO_TargetUnitFramereticleoverName:SetScale(TMSaved.TextScale)                                                               -- Scale Text
            ZO_TargetUnitFramereticleoverCaption:SetScale(TMSaved.TextScale)                                                         
            ZO_TargetUnitFramereticleoverLevel:SetScale(TMSaved.TextScale)        
            ZO_TargetUnitFramereticleoverChampionIcon:SetScale(TMSaved.IconScale)                                                        -- Scale Icons  
            ZO_TargetUnitFramereticleoverRankIcon:SetScale(TMSaved.IconScale)
            if not TMSaved.TIcons then
                ZO_TargetUnitFramereticleoverChampionIcon:SetHidden(true)                                                        -- Scale Icons  
                ZO_TargetUnitFramereticleoverRankIcon:SetHidden(true)
            end
            -- Improved Level Display --------------------------------------------------------------------------
            local unitFrame = ZO_UnitFrames_GetUnitFrame("reticleover")                                                                 -- Get Unit Frame Function Appearently
            local textArea = GetControl(unitFrame.frame, "TextArea")                                                                    -- ZO_TargetUnitFramereticleoverTextArea
            if TMSaved.ImprovedLevel then
                unitFrame.levelLabel:ClearAnchors()                                                                                     -- Clear All Anchors
                unitFrame.nameLabel:ClearAnchors()
                unitFrame.championIcon:ClearAnchors()    
                unitFrame.rankIcon:ClearAnchors()
                unitFrame.captionLabel:ClearAnchors()
                unitFrame.levelLabel:SetAnchor(TOP, textArea, TOP, 0, 5)                                                                -- Setup Anchors For Improved Level... Level On Top
                unitFrame.nameLabel:SetAnchor(TOP, unitFrame.levelLabel, BOTTOM, 0, 0)
                unitFrame.captionLabel:SetAnchor(TOP, unitFrame.nameLabel, BOTTOM, 0, 0)
                unitFrame.championIcon:SetAnchor(RIGHT, unitFrame.nameLabel, LEFT, -5, 0)
                unitFrame.rankIcon:SetAnchor(LEFT, unitFrame.nameLabel, RIGHT, 0, 0)
                unitFrame.levelLabel:SetHidden(false)
                unitFrame.captionLabel:SetHidden(false)
            elseif not TMSaved.TargetLevel then
                unitFrame.nameLabel:ClearAnchors()
                unitFrame.nameLabel:SetAnchor(TOP, textArea, TOP, 0, 5)
            else
                unitFrame.levelLabel:ClearAnchors()                                                                                      -- Clear All Anchors
                unitFrame.nameLabel:ClearAnchors()
                unitFrame.championIcon:ClearAnchors()
                unitFrame.rankIcon:ClearAnchors()
                unitFrame.captionLabel:ClearAnchors()
                if Reaction == UNIT_REACTION_FRIENDLY or Reaction == UNIT_REACTION_NPC_ALLY or Reaction == UNIT_REACTION_INTERACT then                  -- Determan If Its A NPC or Pet
                    if not IsUnitPlayer("reticleover")and not TMIsCritter(Name) and not TMIsCollectableCritter(Name) and not TMIsPlayerPet(Name) then  -- if not pet
                        if TMSaved.NPCLevel then                                                -- If NPC Enabled                                       -- NPC Anchors
                            unitFrame.levelLabel:SetHidden(false)
                            unitFrame.levelLabel:SetAnchor(TOPLEFT, textArea, TOPLEFT, 0, 0)
                            unitFrame.nameLabel:SetAnchor(LEFT, unitFrame.levelLabel, RIGHT, 5, 0)
                        else
                            unitFrame.nameLabel:SetAnchor(TOP, textArea, TOP, 0, 0)   
                        end
                    else
                        if TMIsCritter(Name) and TMSaved.CritterLevel then                --If Pet and Pet Enabled                                         -- Pet Anchors
                            unitFrame.levelLabel:SetHidden(false)
                            unitFrame.levelLabel:SetAnchor(TOPLEFT, textArea, TOPLEFT, 0, 0)
                            unitFrame.nameLabel:SetAnchor(LEFT, unitFrame.levelLabel, RIGHT, 5, 0)
                        elseif TMIsCollectableCritter(Name) and TMSaved.CollectableLevel then                --If Pet and Pet Enabled                                         -- Pet Anchors
                            unitFrame.levelLabel:SetHidden(false)
                            unitFrame.levelLabel:SetAnchor(TOPLEFT, textArea, TOPLEFT, 0, 0)
                            unitFrame.nameLabel:SetAnchor(LEFT, unitFrame.levelLabel, RIGHT, 5, 0)
                        elseif TMIsPlayerPet(Name) and TMSaved.PetLevel then                --If Pet and Pet Enabled                                         -- Pet Anchors
                            unitFrame.levelLabel:SetHidden(false)
                            unitFrame.levelLabel:SetAnchor(TOPLEFT, textArea, TOPLEFT, 0, 0)
                            unitFrame.nameLabel:SetAnchor(LEFT, unitFrame.levelLabel, RIGHT, 5, 0)
                        else
                            unitFrame.nameLabel:SetAnchor(TOP, textArea, TOP, 0, 0)
                        end
                    end
                else
                    unitFrame.levelLabel:SetAnchor(TOPLEFT, textArea, TOPLEFT, 0, 0)
                    unitFrame.nameLabel:SetAnchor(LEFT, unitFrame.levelLabel, RIGHT, 5, 0)
                end
                unitFrame.captionLabel:SetHidden(false)
                unitFrame.championIcon:SetAnchor(RIGHT, unitFrame.levelLabel, LEFT, 0, 1)
                unitFrame.rankIcon:SetAnchor(LEFT, unitFrame.nameLabel, RIGHT, 0, 1)
                unitFrame.captionLabel:SetAnchor(TOP, textArea, BOTTOM, 0, 1)
            end
        end
        if TMSaved.ReticleFrame then
            TargetMaintenanceName:SetScale(TMSaved.RTextScale)
            TargetMaintenanceLevel:SetScale(TMSaved.RTextScale)
            TargetMaintenanceCaption:SetScale(TMSaved.RTextScale)
            TargetMaintenanceVRankIcon:SetScale(TMSaved.RIconScale)
            TargetMaintenanceRankIcon:SetScale(TMSaved.RIconScale)
        end
        if TMSaved.RImprovedLevel then 
            TargetMaintenanceLevel:ClearAnchors()
            TargetMaintenanceName:ClearAnchors()        
            TargetMaintenanceLevel:SetAnchor(BOTTOM, TargetMaintenanceName.Text, TOP, 0, -1)
            TargetMaintenanceName:SetAnchor(CENTER, ZO_ReticleContainer, CENTER, 0, -75)
            TargetMaintenanceVRankIcon:SetAnchor(CENTER,ZO_ReticleContainer,CENTER,-45,-95)
            TargetMaintenanceRankIcon:SetAnchor(CENTER,ZO_ReticleContainer,CENTER,45,-95)
        else
            TargetMaintenanceName:ClearAnchors()
            TargetMaintenanceLevel:ClearAnchors()
            TargetMaintenanceName:SetAnchor(CENTER, ZO_ReticleContainer, CENTER, 0, -75)
            TargetMaintenanceLevel:SetAnchor(RIGHT, TargetMaintenanceName.Text, LEFT, 0, -1)
            TargetMaintenanceVRankIcon:SetAnchor(CENTER,ZO_ReticleContainer,CENTER,-45,-95)
            TargetMaintenanceRankIcon:SetAnchor(CENTER,ZO_ReticleContainer,CENTER,45,-95)
        end
        -- Show On Default Targets --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_DEFAULT then                   -- Unsure If Needed??
            -- TargetFrame ---------------------------------------------------------------
            if TMSaved.TargetFrame then
                ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
            end
            -- ReticleFrame ---------------------------------------------------------------
            if TMSaved.ReticleFrame then
                 if TMSaved.RImprovedLevel then
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRName)
                    local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                    TargetMaintenanceLevel:SetDimensions(LSize,15)
                    TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                else
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceLevel.Text:SetText("")
                end
                local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                TargetMaintenanceCaption:SetDimensions(CSize,15)
                TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
            end
        end
        -- Show On Hostile Targets --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_HOSTILE then
            -- TargetFrame ---------------------------------------------------------------
            if TMSaved.TargetFrame then
                ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
            end
            -- ReticleFrame ---------------------------------------------------------------
            if TMSaved.ReticleFrame then
                 if TMSaved.RImprovedLevel then
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRName)
                    local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                    TargetMaintenanceLevel:SetDimensions(LSize,15)
                    TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                else
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceLevel.Text:SetText("")
                end
                local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                TargetMaintenanceCaption:SetDimensions(CSize,15)
                TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
            end
        end
        -- Show On Netural Tatgets --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_NEUTRAL then
            if TMSaved.TargetFrame then
                ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
                if IsUnitChampion("reticleover") then
                    ZO_TargetUnitFramereticleoverChampionIcon:SetHidden(false)
                end
            end
            -- ReticleFrame ---------------------------------------------------------------
            if TMSaved.ReticleFrame then
                if TMSaved.RImprovedLevel then
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRName)
                    local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                    TargetMaintenanceLevel:SetDimensions(LSize,15)
                    TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                else
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceLevel.Text:SetText("")
                end
                local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                TargetMaintenanceCaption:SetDimensions(CSize,15)
                TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
            end
        end
        -- Show On Players --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_PLAYER_ALLY then
            -- Target Frame ---------------------------------------------------------------
            if TMSaved.TargetFrame then
                ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
            end
            -- Reticle Frame ---------------------------------------------------------------
            if TMSaved.ReticleFrame then
                if TMSaved.RImprovedLevel then
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRName)
                    local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                    TargetMaintenanceLevel:SetDimensions(LSize,15)
                    TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                else
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceLevel.Text:SetText("")
                end
                local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                TargetMaintenanceCaption:SetDimensions(CSize,15)
                TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
            end
        end
        -- Show On NPCs --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_FRIENDLY or Reaction == UNIT_REACTION_NPC_ALLY or Reaction == UNIT_REACTION_INTERACT then
            if not IsUnitPlayer("reticleover") and not TMIsCritter(Name) and not TMIsCollectableCritter(Name) and not TMIsPlayerPet(Name) then
                -- Target Frame ---------------------------------------------------------------
                if TMSaved.TargetFrame then
                    ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                    if TMSaved.ImprovedLevel then
                        ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                    end
                    if TMSaved.NPCLevel then
                        ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                    end
                    ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
                    if IsUnitChampion("reticleover") then
                        ZO_TargetUnitFramereticleoverChampionIcon:SetHidden(false)
                    end
                end
                -- Reticle Frame ---------------------------------------------------------------
                if TMSaved.ReticleFrame then
                    if TMSaved.RImprovedLevel then
                        local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                        TargetMaintenanceName:SetDimensions(NSize+40,15)-------------------------------------------------Scale Fix?
                        TargetMaintenanceName.Text:SetText(TMTargetRName)
                        local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                        TargetMaintenanceLevel:SetDimensions(LSize,15)
                        TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                    else
                        local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                        TargetMaintenanceName:SetDimensions(NSize,15)
                        TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                        TargetMaintenanceLevel.Text:SetText("")
                    end
                    local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                    TargetMaintenanceCaption:SetDimensions(CSize+20,15)
                    TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
                end
            end
        end
        -- Show On Critters --------------------------------------------------------------------------
        if TMIsCritter(Name) then
            -- Target Frame ---------------------------------------------------------------
            if TMSaved.TargetFrame then
                ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
            end
            -- ReticleFrame ---------------------------------------------------------------
            if TMSaved.ReticleFrame then
                 if TMSaved.RImprovedLevel then
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRName)
                    local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                    TargetMaintenanceLevel:SetDimensions(LSize,15)
                    TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                else
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceLevel.Text:SetText("")
                end
                local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                TargetMaintenanceCaption:SetDimensions(CSize,15)
                TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
            end
        end
        -- Show On Collectable --------------------------------------------------------------------------
        if TMIsCollectableCritter(Name) then
            -- Target Frame ---------------------------------------------------------------
            if TMSaved.TargetFrame then
                ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
            end
            -- ReticleFrame ---------------------------------------------------------------
            if TMSaved.ReticleFrame then
                if TMSaved.RImprovedLevel then
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRName)
                    local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                    TargetMaintenanceLevel:SetDimensions(LSize,15)
                    TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                else
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceLevel.Text:SetText("")
                end
                local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                TargetMaintenanceCaption:SetDimensions(CSize,15)
                TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
            end
        end
        -- Show On Pets --------------------------------------------------------------------------
        if TMIsPlayerPet(Name) then
            -- Target Frame ---------------------------------------------------------------
            if TMSaved.TargetFrame then
                ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                if TMSaved.ImprovedLevel then
                    ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                end
                if TMSaved.PetLevel then
                    ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                end
                ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
            end
            -- ReticleFrame ---------------------------------------------------------------
            if TMSaved.ReticleFrame then
                if TMSaved.RImprovedLevel then
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRName)
                    local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                    TargetMaintenanceLevel:SetDimensions(LSize,15)
                    TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                else
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceLevel.Text:SetText("")
                end
                local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                TargetMaintenanceCaption:SetDimensions(CSize,15)
                TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
            end
        end
        -- Show On Dead Targets --------------------------------------------------------------------------
        --if Reaction == UNIT_REACTION_DEAD then
        if IsUnitDead('reticleover') then
            -- TargetFrame ---------------------------------------------------------------
            if TMSaved.TargetFrame then
                ZO_TargetUnitFramereticleoverName:SetText(TMTargetName)
                ZO_TargetUnitFramereticleoverLevel:SetText(TMTargetLevel)
                ZO_TargetUnitFramereticleoverCaption:SetText(TMTargetCaption)
            end
            -- ReticleFrame ---------------------------------------------------------------
            if TMSaved.ReticleFrame then
                 if TMSaved.RImprovedLevel then
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRName)
                    local LSize = TargetMaintenanceLevel.Text:GetStringWidth(TMTargetRLevel)
                    TargetMaintenanceLevel:SetDimensions(LSize+5,15)
                    TargetMaintenanceLevel.Text:SetText(TMTargetRLevel)
                else
                    local NSize = TargetMaintenanceName.Text:GetStringWidth(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceName:SetDimensions(NSize,15)
                    TargetMaintenanceName.Text:SetText(TMTargetRLevel.." "..TMTargetRName)
                    TargetMaintenanceLevel.Text:SetText("")
                end
                local CSize = TargetMaintenanceCaption.Text:GetStringWidth(TMTargetRCaption)
                TargetMaintenanceCaption:SetDimensions(CSize,15)
                TargetMaintenanceCaption.Text:SetText(TMTargetRCaption)
            end
        end        
    else
        -- Default Anchors --------------------------------------------------------------------------                               As Close To Default As I Could Get ESO UNIT FRAME Is FUCKING STUPID
        local unitFrame = ZO_UnitFrames_GetUnitFrame("reticleover")
        local textArea = GetControl(unitFrame.frame, "TextArea")
        unitFrame.levelLabel:ClearAnchors()
        unitFrame.nameLabel:ClearAnchors()
        unitFrame.championIcon:ClearAnchors()
        unitFrame.rankIcon:ClearAnchors()
        unitFrame.captionLabel:ClearAnchors()
        if Reaction == UNIT_REACTION_FRIENDLY or Reaction == UNIT_REACTION_NPC_ALLY or Reaction == UNIT_REACTION_INTERACT then
            if not IsUnitPlayer("reticleover") and not TMIsCritter(Name) and not TMIsCollectableCritter(Name) then
                unitFrame.nameLabel:SetAnchor(TOP, textArea, TOP, 0, 0)
            end
        else
            unitFrame.levelLabel:SetAnchor(TOPLEFT, textArea, TOPLEFT, 0, 0)
            unitFrame.nameLabel:SetAnchor(LEFT, unitFrame.levelLabel, RIGHT, 5, 0)
        end
        unitFrame.championIcon:SetAnchor(RIGHT, unitFrame.levelLabel, LEFT, 0, 1)
        unitFrame.rankIcon:SetAnchor(LEFT, unitFrame.nameLabel, RIGHT, 0, 1)
        unitFrame.captionLabel:SetAnchor(TOP, textArea, BOTTOM, 0, 1)
        -- Default Fonts
        ZO_TargetUnitFramereticleoverName:SetFont("ZoFontGameShadow")                                                                              
        ZO_TargetUnitFramereticleoverCaption:SetFont("ZoFontGameShadow")
        ZO_TargetUnitFramereticleoverLevel:SetFont("ZoFontGameShadow")
        -- Remove Name Raction Colouring 
        ZO_TargetUnitFramereticleoverName:SetColor(1, 1, 1, 1)
        ZO_TargetUnitFramereticleoverLevel:SetColor(1, 1, 1, 1)
        ZO_TargetUnitFramereticleoverBarLeft:SetColor(.8, 0, 0, 1) 
        ZO_TargetUnitFramereticleoverBarRight:SetColor(.8, 0, 0, 1)
    end
    if not TMSaved.TargetFrame then
        -- Default Anchors --------------------------------------------------------------------------                               As Close To Default As I Could Get ESO UNIT FRAME Is FUCKING STUPID
        local unitFrame = ZO_UnitFrames_GetUnitFrame("reticleover")
        local textArea = GetControl(unitFrame.frame, "TextArea")
        unitFrame.levelLabel:ClearAnchors()
        unitFrame.nameLabel:ClearAnchors()
        unitFrame.championIcon:ClearAnchors()
        unitFrame.rankIcon:ClearAnchors()
        unitFrame.captionLabel:ClearAnchors()
        if Reaction == UNIT_REACTION_FRIENDLY or Reaction == UNIT_REACTION_NPC_ALLY or Reaction == UNIT_REACTION_INTERACT then
            if not IsUnitPlayer("reticleover") and not TMIsCritter(Name) and not TMIsCollectableCritter(Name) then
                unitFrame.nameLabel:SetAnchor(TOP, textArea, TOP, 0, 0)
            end
        else
            unitFrame.levelLabel:SetAnchor(TOPLEFT, textArea, TOPLEFT, 0, 0)
            unitFrame.nameLabel:SetAnchor(LEFT, unitFrame.levelLabel, RIGHT, 5, 0)
        end
        unitFrame.championIcon:SetAnchor(RIGHT, unitFrame.levelLabel, LEFT, 0, 1)
        unitFrame.rankIcon:SetAnchor(LEFT, unitFrame.nameLabel, RIGHT, 0, 1)
        unitFrame.captionLabel:SetAnchor(TOP, textArea, BOTTOM, 0, 1)
        -- Default Fonts
        ZO_TargetUnitFramereticleoverName:SetFont("ZoFontGameShadow")                                                                              
        ZO_TargetUnitFramereticleoverCaption:SetFont("ZoFontGameShadow")
        ZO_TargetUnitFramereticleoverLevel:SetFont("ZoFontGameShadow")
        -- Remove Name Raction Colouring 
        ZO_TargetUnitFramereticleoverName:SetColor(1, 1, 1, 1)
        ZO_TargetUnitFramereticleoverLevel:SetColor(1, 1, 1, 1)
        ZO_TargetUnitFramereticleoverBarLeft:SetColor(.8, 0, 0, 1) 
        ZO_TargetUnitFramereticleoverBarRight:SetColor(.8, 0, 0, 1)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
