-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- PATCH 2.4.5 Added Champion System All Veteran Ranks/Poins ETC REMOVED
function TargetMaintenanceTarget(Event, Unit)
    TMHideReticleFrame()
    TMHideReticleIcons()
    TMHideReticleVIcons()
    TMReticleWhite()
    if not DoesUnitExist("reticleover") then return end
    -------------------------------------------------
    local Name = FixString(GetUnitName("reticleover"))
    local Level = GetUnitLevel("reticleover")
    local PlayerLevel = GetUnitLevel("player")
    local VRank = GetUnitChampionPoints("reticleover")      -- Champion Fix From Vet
    local PlayerVRank = GetUnitChampionPoints("player")     -- Champion Fix From Vet
    -------------------------------------------------
    local r2, g2, b2 = GetConColor(Level, PlayerLevel)
    local r3, g3, b3 = GetConColor(VRank, PlayerVRank)
    local LcolorDef = ZO_ColorDef:New(GetConColor(Level, PlayerLevel))
    local LhexString = LcolorDef:ToHex()
    local VLcolorDef = ZO_ColorDef:New(GetConColor(VRank, PlayerVRank))
    local VLhexString = VLcolorDef:ToHex()
    -------------------------------------------------
    local Class = FixString(GetUnitClass("reticleover"))
    local CcolorDef = GetClassColor("reticleover")
    local ChexString = CcolorDef:ToHex()
    -------------------------------------------------
    local Race = FixString(GetUnitRace("reticleover"))
    local Title = FixString(GetUnitTitle("reticleover"))
    local Caption = FixString(GetUnitCaption("reticleover"))
    -------------------------------------------------
    local ANumber = GetUnitAlliance("reticleover")
    local Alliance = FixString(GetAllianceName(ANumber))
    local AcolorDef = GetAllianceColor(ANumber)
    local AhexString = AcolorDef:ToHex()
    -------------------------------------------------
    local Gendernum = GetUnitGender("reticleover")
    local Gender = {"|cF5A9F2Female|r", "|c819FF7Male|r"}
    local TargetDifficulty = GetUnitDifficulty("reticleover")
    -------------------------------------------------
    local Reaction = GetUnitReaction("reticleover")
    local r1, g1, b1 = GetUnitReactionColor("reticleover")
    local RcolorDef = ZO_ColorDef:New(GetUnitReactionColor("reticleover"))
    local RhexString = RcolorDef:ToHex()
    -------------------------------------------------    
    local NameString = ""                           -- Target Frame Strings
    local LevelString = ""
    local ClassString = ""
    local RaceString = ""
    local DifficultyString = ""
    local TitleString = ""
    local CaptionString = ""
    local AllianceString = ""
    local GenderString = ""
    -------------------------------------------------
    local RNameString = ""                          -- Reticle Frame Strings
    local RLevelString = ""
    local RClassString = ""
    local RRaceString = ""
    local RDifficultyString = ""
    local RTitleString = ""
    local RCaptionString = ""
    local RAllianceString = ""
    local RGenderString = ""
    -------------------------------------------------
    local Space = " "
    -------------------------------------------------
    local Blank = (Name == "" or Name == " ")
    local CBlank = (Caption == "" or Caption == " ")
    --------------------------------------------------------------------------
    -- Name Target 
    if TMSaved.TargetName then
        NameString = Name..Space
    else
        NameString = ""
    end
    -- Reticle Target
    if TMSaved.RPlayerName then
        if TMSaved.RReactionColorName then
            RNameString = "|c"..RhexString..Name.."|r"..Space
        else
            RNameString = "|cFFFFFF"..Name.."|r"..Space
        end
    else
        RNameString = ""
    end
    --------------------------------------------------------------------------
    -- Level Target
    if TMSaved.TargetLevel then
        if VRank and string.len(VRank) > 0 and VRank ~= 0 then
            LevelString = "C"..tostring(VRank) -- Champion Fix From Vet
        elseif Level and string.len(Level) > 0 then
            LevelString = ""..tostring(Level)
        end
    else
        LevelString = ""
    end
    -- Level Reticle
    if TMSaved.RPlayerLevel then
        if VRank and string.len(VRank) > 0 and VRank ~= 0 then
            RLevelString = "C"..tostring(VRank) -- Champion Fix From Vet
        elseif Level and string.len(Level) > 0 then
            RLevelString = ""..tostring(Level)
        end
    else
        RLevelString = ""
    end
    --------------------------------------------------------------------------
    -- Class Target
    if TMSaved.TargetClass then
        ClassString = "|c"..ChexString..Class.. "|r"
    else
        ClassString = ""
    end 
     -- Class Reticle
    if TMSaved.RPlayerClass then
        RClassString = "|c"..ChexString..Class.. "|r"
    else
        RClassString = ""
    end     
    --------------------------------------------------------------------------
    -- Race
    if TMSaved.TargetRace then
        RaceString = Space.."|cFFFF00"..Race.."|r"
    else
        RaceString = ""
    end 
    -- Race
    if TMSaved.RPlayerRace then
        RRaceString = Space.."|cFFFF00"..Race.."|r"
    else
        RRaceString = ""
    end 
    --------------------------------------------------------------------------
    -- Title
    if TMSaved.TargetTitle then
        TitleString = Space..Title
    else
        TitleString = ""
    end
    -- Title
    if TMSaved.RPlayerTitle then
        RTitleString = Space..Title
    else
        RTitleString = ""
    end
    --------------------------------------------------------------------------
    -- Caption
    if TMSaved.NPCCaption then
        CaptionString = Caption
    else
        CaptionString = ""
    end
    -- Caption
    if TMSaved.RNPCCaption then
        RCaptionString = Caption
    else
        RCaptionString = ""
    end
    --------------------------------------------------------------------------
    -- Alliance
    if TMSaved.TargetAlliance then
        AllianceString = "(|c"..AhexString..Alliance.. "|r)"
    else
        AllianceString = ""
    end
    -- Alliance
    if TMSaved.RPlayerAlliance then
        RAllianceString = "(|c"..AhexString..Alliance.. "|r)"
    else
        RAllianceString = ""
    end
    --------------------------------------------------------------------------
    -- Gender
    if TMSaved.TargetGender then
        if Gendernum>0 and Gendernum<3 then                                                                                                 -- Convert Numeric Gender Into A String
            GenderString = Space.."|cD89400"..Gender[Gendernum].."|r"
        end
    else
        GenderString = ""
    end
    -- Gender
    if TMSaved.RPlayerGender then
        if Gendernum>0 and Gendernum<3 then                                                                                                 -- Convert Numeric Gender Into A String
            RGenderString = Space.."|cD89400"..Gender[Gendernum].."|r"
        end
    else
        RGenderString = ""
    end
    --------------------------------------------------------------------------
    -- Difficulty Stars
    if TMSaved.DifficultyStars then
        if TargetDifficulty > 1 then
            DifficultyString = Space..string.rep("|cFF0000*|r", (TargetDifficulty - 1))
        end
    else
        DifficultyString = ""
    end
    -- Difficulty Stars
    if TMSaved.RDifficultyStars then
        if TargetDifficulty > 1 then
            RDifficultyString = Space..string.rep("|cFF0000*|r", (TargetDifficulty - 1))
        end
    else
        RDifficultyString = ""
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if TMSaved.Toggle then
        if Blank then TMTargetName = "" return end
        --if Level == 0 then return end
        if not DoesUnitExist("reticleover") then return end
        --------------------------------------------------------------------------
        if TMSaved.ReactionColorBar then
            ZO_TargetUnitFramereticleoverBarLeft:SetColor(r1, g1, b1, 1) 
            ZO_TargetUnitFramereticleoverBarRight:SetColor(r1, g1, b1, 1)
        else
            ZO_TargetUnitFramereticleoverBarLeft:SetColor(.8, 0, 0, 1) 
            ZO_TargetUnitFramereticleoverBarRight:SetColor(.8, 0, 0, 1)
        end
        -- Target Frame                                                                                       -- Must Apply Color On Entire Name Frame Otherwise It Causes Delay Converting When Displaying
        if TMSaved.ReactionColorName then
            ZO_TargetUnitFramereticleoverName:SetColor(r1, g1, b1, 1) 
            ZO_TargetUnitFramereticleoverCaption:SetColor(1, 1, 1, 1) 
        else
            ZO_TargetUnitFramereticleoverName:SetColor(1, 1, 1, 1)
            ZO_TargetUnitFramereticleoverCaption:SetColor(1, 1, 1, 1)
        end
        -- Reticle Frame
        if TMSaved.ReticleFrame then
            if TMSaved.RReactionColorName then
                if TMSaved.RImprovedLevel then 
                    TargetMaintenanceName.Text:SetColor(r1, g1, b1, 1)
                end
            else
                TargetMaintenanceName.Text:SetColor(1, 1, 1)
            end
        end
        -- Reticle Reaction Color
        if TMSaved.RReactionColorReticle then
            RETICLE.reticleTexture:SetColor(r1, g1, b1)
            RETICLE.stealthIcon.stealthEyeTexture:SetColor(r1, g1, b1)
            RETICLE.stealthIcon.stealthText:SetColor(r1, g1, b1)
        end
        -- Target Frame
        if TMSaved.DifficultyColorLevel then 
            if VRank and string.len(VRank) > 0 and VRank ~= 0 then
                ZO_TargetUnitFramereticleoverLevel:SetColor(r3, g3, b3)
            elseif Level and string.len(Level) > 0 then
                ZO_TargetUnitFramereticleoverLevel:SetColor(r2, g2, b2)
            end
        else
            ZO_TargetUnitFramereticleoverLevel:SetColor(1, 1, 1)   
        end
        -- Reticle Frame
        if TMSaved.ReticleFrame then
            if TMSaved.RDifficultyColorLevel then 
                if VRank and string.len(VRank) > 0 and VRank ~= 0 then
                    if TMSaved.RImprovedLevel then 
                        TargetMaintenanceLevel.Text:SetColor(r3, g3, b3)
                    else
                        TargetMaintenanceName.Text:SetColor(r3, g3, b3)
                    end
                elseif Level and string.len(Level) > 0 then
                    if TMSaved.RImprovedLevel then
                        TargetMaintenanceLevel.Text:SetColor(r2, g2, b2)
                    else
                        TargetMaintenanceName.Text:SetColor(r2, g2, b2)
                    end
                end
            else
                TargetMaintenanceLevel.Text:SetColor(1, 1, 1)
                TargetMaintenanceName.Text:SetColor(1, 1, 1)
            end
        end
        -- Info On Default Targets --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_DEFAULT then            -- Unsure If Needed??
            -- Target Frame 
            if TMSaved.ImprovedLevel then
                TMTargetName = NameString..DifficultyString
                if TMSaved.Tags then
                    TMTargetLevel = LevelString.." |cFFFFFFDEFAULT??|r"
                else
                    TMTargetLevel = LevelString
                end
            else
                if TMSaved.Tags then
                    TMTargetName = NameString..DifficultyString.." |cFFFFFFDEFAULT??|r"
                else
                    TMTargetName = NameString..DifficultyString
                end
            end
            -- Reticle Frame
            if TMSaved.RImprovedLevel then
                TMTargetRName = RNameString..RDifficultyString
                if TMSaved.RTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFDEFAULT??|r"
                else
                    TMTargetRLevel = RLevelString
                end
            else
                if TMSaved.RTags then
                    TMTargetRName = RNameString..RDifficultyString.." |cFFFFFFDEFAULT??|r"
                else
                    TMTargetRName = RNameString..RDifficultyString
                end
            end
            --TMTargetCaption = ""
            --TMTargetRCaption = ""
        end
        -- Info On Dead Targets --------------------------------------------------------------------------
        --[[if Reaction == UNIT_REACTION_DEAD then
            -- Target Frame 
            if TMSaved.ImprovedLevel then
                TMTargetName = NameString..DifficultyString
                if TMSaved.Tags and TMSaved.DeadTags then
                    TMTargetLevel = LevelString.." |cFFFFFFXDeadX|r"
                else
                    TMTargetLevel = LevelString
                end
            else
                if TMSaved.Tags and TMSaved.DeadTags then
                    TMTargetName = NameString..DifficultyString.." |cFFFFFFXDeadX|r"
                else
                    TMTargetName = NameString..DifficultyString
                end
            end
            -- Reticle Frame
            if TMSaved.RImprovedLevel then
                TMTargetRName = RNameString..RDifficultyString
                if TMSaved.RTags and TMSaved.RDeadTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFXDeadX|r"
                else
                    TMTargetRLevel = RLevelString
                end
            else
                if TMSaved.RTags and TMSaved.RDeadTags then
                    TMTargetRName = RNameString..RDifficultyString.." |cFFFFFFXDeadX|r"
                else
                    TMTargetRName = RNameString..RDifficultyString
                end
            end
            --TMTargetCaption = ""
            --TMTargetRCaption = ""
        end]]--
        -- Info On Hostile Targets --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_HOSTILE then
            -- Target Frame 
            if TMSaved.ImprovedLevel then
                TMTargetName = NameString..DifficultyString
                if TMSaved.Tags and TMSaved.HostileTags then
                    TMTargetLevel = LevelString.." |cFFFFFFHostile|r"
                else
                    TMTargetLevel = LevelString
                end
            else
                if TMSaved.Tags and TMSaved.HostileTags then
                    TMTargetName = NameString..DifficultyString.." |cFFFFFFHostile|r"
                else
                    TMTargetName = NameString..DifficultyString
                end
            end
            -- Reticle Frame
            if TMSaved.RImprovedLevel then
                TMTargetRName = RNameString..RDifficultyString
                if TMSaved.RTags and TMSaved.RHostileTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFHostile|r"
                else
                    TMTargetRLevel = RLevelString
                end
            else
                if TMSaved.RTags and TMSaved.RHostileTags then
                    TMTargetRName = RNameString..RDifficultyString.." |cFFFFFFHostile|r"
                else
                    TMTargetRName = RNameString..RDifficultyString
                end
            end
            if IsUnitPlayer("reticleover") and IsUnitAttackable("reticleover") then
                if TMSaved.TargetPVP then
                    TMTargetName = NameString..ClassString
                    TMTargetCaption = "|cFF0000PVP|r"
                end
                if TMSaved.RPlayerPVP then
                    TMTargetRName = RNameString..RClassString
                    TMTargetRCaption = "|cFF0000PVP|r"
                end
            else
                TMTargetCaption = ""
                TMTargetRCaption = ""
            end
            -- Veteran Icon
            if IsUnitChampion("reticleover") and TMSaved.RIcons then
                TMShowReticleVIcons()
            end
            -- Rank Icon
            local PVPRank = GetUnitAvARank("reticleover")
            if PVPRank > 1 and TMSaved.RIcons then
                TargetMaintenanceRankIcon.Icon:SetTexture(GetAvARankIcon(PVPRank))
                TMShowReticleIcons()
            end
            --TMTargetCaption = ""
            --TMTargetRCaption = ""
        end
        -- Info On Netural Tatgets --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_NEUTRAL then
            -- Target Frame 
            if TMSaved.ImprovedLevel then
                TMTargetName = NameString..DifficultyString
                if TMSaved.Tags and TMSaved.NeturalTags then
                    TMTargetLevel = LevelString.." |cFFFFFFNeutral|r"
                else
                    TMTargetLevel = LevelString
                end
            else
                if TMSaved.Tags and TMSaved.NeturalTags then
                    TMTargetName = NameString..DifficultyString.." |cFFFFFFNeutral|r"
                else
                    TMTargetName = NameString..DifficultyString
                end
            end
            -- Reticle Frame
            if TMSaved.RImprovedLevel then
                TMTargetRName = RNameString..RDifficultyString
                if TMSaved.RTags and TMSaved.RNeturalTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFNeutral|r"
                else
                    TMTargetRLevel = RLevelString
                end
            else
                if TMSaved.RTags and TMSaved.RNeturalTags then
                    TMTargetRName = RNameString..RDifficultyString.." |cFFFFFFNeutral|r"
                else
                    TMTargetRName = RNameString..RDifficultyString
                end
            end
            -- Veteran Icon
            if IsUnitChampion("reticleover") and TMSaved.RIcons then
                TMShowReticleVIcons()
            end
            -- Rank Icon
            local PVPRank = GetUnitAvARank("reticleover")
            if PVPRank > 1 and TMSaved.RIcons then
                TargetMaintenanceRankIcon.Icon:SetTexture(GetAvARankIcon(PVPRank))
                TMShowReticleIcons()
            end
            TMTargetCaption = ""
            TMTargetRCaption = ""
        end
        -- Info On Players --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_PLAYER_ALLY then 
            -- Target Frame        
            if TMSaved.TargetInfo then
                if TMSaved.ImprovedLevel then
                    TMTargetName = NameString..ClassString..GenderString..RaceString
                    if TMSaved.Tags and TMSaved.PCTags then
                        TMTargetLevel = LevelString.." |cFFFFFFPC|r"
                    else
                        TMTargetLevel = LevelString
                    end
                    TMTargetCaption = AllianceString..TitleString
                else
                    if TMSaved.Tags and TMSaved.PCTags then
                        TMTargetName = NameString..ClassString..GenderString..RaceString
                        TMTargetCaption = AllianceString..TitleString.." PC"
                    else
                        TMTargetName = NameString..ClassString..GenderString..RaceString
                        TMTargetCaption = AllianceString..TitleString
                    end
                    TMTargetLevel = LevelString
                end
            else
                TMTargetName = NameString
                if TMSaved.ImprovedLevel and TMSaved.Tags and TMSaved.PCTags then
                    TMTargetLevel = LevelString.." |cFFFFFFPC|r"
                else
                    TMTargetLevel = LevelString
                end
                TMTargetCaption = TitleString
            end
            -- Reticle Frame
            if TMSaved.RPlayerInfo then
                if TMSaved.RImprovedLevel then
                    TMTargetRName = RNameString..RClassString..RGenderString..RRaceString
                    if TMSaved.RTags and TMSaved.RPCTags then
                        TMTargetRLevel = RLevelString.." |cFFFFFFPC|r"
                    else
                        TMTargetRLevel = RLevelString
                    end
                    TMTargetRCaption = RAllianceString..RTitleString
                else
                    if TMSaved.RTags and TMSaved.RPCTags then
                        TMTargetRName = RNameString..RClassString..RGenderString..RRaceString
                        TMTargetRCaption = RAllianceString..RTitleString.." PC"
                    else
                        TMTargetRName = RNameString..RClassString..RGenderString..RRaceString
                        TMTargetRCaption = RAllianceString..RTitleString
                    end
                    TMTargetRLevel = RLevelString
                end
            else
                TMTargetRName = RNameString
                if TMSaved.RImprovedLevel and TMSaved.RTags and TMSaved.RPCTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFPC|r"
                else
                    TMTargetRLevel = RLevelString
                end
                TMTargetRCaption = RTitleString
            end
            -- Veteran Icon
            if IsUnitChampion("reticleover") and TMSaved.RIcons then
                TMShowReticleVIcons()
            end
            -- Rank Icon
            local PVPRank = GetUnitAvARank("reticleover")
            if PVPRank > 1 and TMSaved.RIcons then
                TargetMaintenanceRankIcon.Icon:SetTexture(GetAvARankIcon(PVPRank))
                TMShowReticleIcons()
            end
        end
        -- Info On NPC --------------------------------------------------------------------------
        if Reaction == UNIT_REACTION_FRIENDLY or Reaction == UNIT_REACTION_NPC_ALLY or Reaction == UNIT_REACTION_INTERACT then
            if not IsUnitPlayer("reticleover") and not TMIsCritter(Name) and not TMIsCollectableCritter(Name) and not TMIsPlayerPet(Name) then
                -- Target Frame
                if TMSaved.ImprovedLevel then
                    TMTargetName = NameString
                    if TMSaved.Tags and TMSaved.NPCTags then
                        TMTargetLevel = LevelString.." |cFFFFFFNPC|r"
                    else
                        TMTargetLevel = LevelString
                    end
                    TMTargetCaption = CaptionString
                else
                    if TMSaved.Tags and TMSaved.NPCTags then
                        TMTargetName = NameString
                        TMTargetLevel = LevelString
                        if Caption then
                            TMTargetCaption = CaptionString.." NPC"
                        else
                            TMTargetCaption = "NPC"
                        end
                    else
                        TMTargetName = NameString
                        TMTargetLevel = LevelString
                        TMTargetCaption = CaptionString
                    end
                end
                -- Reticle Frame
                if TMSaved.RImprovedLevel then
                    TMTargetRName = RNameString                    
                    if TMSaved.RTags and TMSaved.RNPCTags then
                        TMTargetRLevel = RLevelString.." |cFFFFFFNPC|r"
                    else
                        TMTargetRLevel = RLevelString
                    end
                    TMTargetRCaption = RCaptionString
                else
                    if TMSaved.RTags and TMSaved.RNPCTags then
                        TMTargetRName = RNameString
                        TMTargetRLevel = RLevelString
                        if Caption then
                            TMTargetRCaption = RCaptionString.." NPC"
                        else
                            TMTargetRCaption = "NPC"
                        end
                    else
                        TMTargetRName = RNameString
                        TMTargetRLevel = RLevelString
                        TMTargetRCaption = RCaptionString
                    end
                end
                -- Veteran Icon
                if IsUnitChampion("reticleover") and TMSaved.RIcons then
                    TMShowReticleVIcons()
                end
                -- Rank Icon
                local PVPRank = GetUnitAvARank("reticleover")
                if PVPRank > 1 and TMSaved.RIcons then
                    TargetMaintenanceRankIcon.Icon:SetTexture(GetAvARankIcon(PVPRank))
                    TMShowReticleIcons()
                end
            end
        end
        -- Info On Critters --------------------------------------------------------------------------
        if TMIsCritter(Name) then
            -- Target Frame
            if TMSaved.ImprovedLevel then
                TMTargetName = NameString
                if TMSaved.Tags and TMSaved.CritterTags then
                    TMTargetLevel = LevelString.." |cFFFFFFCritter|r"
                else
                    TMTargetLevel = LevelString
                end
                TMTargetCaption = ""
            else
                if TMSaved.Tags and TMSaved.CritterTags then
                    TMTargetName = NameString
                    TMTargetLevel = LevelString
                    TMTargetCaption = "Critter"
                else
                    TMTargetName = NameString
                    TMTargetLevel = LevelString
                    TMTargetCaption = ""
                end
            end
            -- Reticle Frame
            if TMSaved.RImprovedLevel then
                TMTargetRName = RNameString
                if TMSaved.RTags and TMSaved.RCritterTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFCritter|r"
                else
                    TMTargetRLevel = RLevelString
                end
                TMTargetRCaption = ""
            else
                if TMSaved.RTags and TMSaved.RCritterTags then
                    TMTargetRName = RNameString
                    TMTargetRLevel = RLevelString
                    TMTargetRCaption = "Critter"
                else
                    TMTargetRName = RNameString
                    TMTargetRLevel = RLevelString
                    TMTargetRCaption = ""
                end
            end
        end
        -- Info On Collectable Critter  --------------------------------------------------------------------------
        if TMIsCollectableCritter(Name) then
            -- Target Frame
            if TMSaved.ImprovedLevel then
                TMTargetName = NameString
                if TMSaved.Tags and TMSaved.CollectableTags then
                    TMTargetLevel = LevelString.." |cFFFFFFCollectable|r"
                else
                    TMTargetLevel = LevelString
                end
                TMTargetCaption = ""
            else
                if TMSaved.Tags and TMSaved.CollectableTags then
                    TMTargetName = NameString
                    TMTargetLevel = LevelString
                    TMTargetCaption = "Collectable"
                else
                    TMTargetName = NameString
                    TMTargetLevel = LevelString
                    TMTargetCaption = ""
                end
            end
            -- Reticle Frame
            if TMSaved.RImprovedLevel then
                TMTargetRName = RNameString
                if TMSaved.RTags and TMSaved.RCollectableTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFCollectable|r"
                else
                    TMTargetRLevel = RLevelString
                end
                TMTargetRCaption = ""
            else
                if TMSaved.RTags and TMSaved.RCollectableTags then
                    TMTargetRName = RNameString
                    TMTargetRLevel = RLevelString
                    TMTargetRCaption = "Collectable"
                else
                    TMTargetRName = RNameString
                    TMTargetRLevel = RLevelString
                    TMTargetRCaption = ""
                end
            end
        end
        -- Info On Pets  --------------------------------------------------------------------------
        if TMIsPlayerPet(Name) then
            -- Target Frame
            if TMSaved.ImprovedLevel then
                TMTargetName = NameString
                if TMSaved.Tags and TMSaved.PetTags then
                    TMTargetLevel = LevelString.." |cFFFFFFPet|r"
                else
                    TMTargetLevel = LevelString
                end
                TMTargetCaption = ""
            else
                if TMSaved.Tags and TMSaved.PetTags then
                    TMTargetName = NameString
                    TMTargetLevel = LevelString
                    TMTargetCaption = "Pet"
                else
                    TMTargetName = NameString
                    TMTargetLevel = LevelString
                    TMTargetCaption = ""
                end
            end
            -- Reticle Frame
            if TMSaved.RImprovedLevel then
                TMTargetRName = RNameString
                if TMSaved.RTags and TMSaved.RPetTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFPet|r"
                else
                    TMTargetRLevel = RLevelString
                end
                TMTargetRCaption = ""
            else
                if TMSaved.RTags and TMSaved.RPetTags then
                    TMTargetRName = RNameString
                    TMTargetRLevel = RLevelString
                    TMTargetRCaption = "Pet"
                else
                    TMTargetRName = RNameString
                    TMTargetRLevel = RLevelString
                    TMTargetRCaption = ""
                end
            end
        end
        -- DEAD TARGETS V1.2.3 Removed Dead Reaction WTF
        if IsUnitDead('reticleover') then
            if TMSaved.ImprovedLevel then
                TMTargetName = NameString..DifficultyString
                if TMSaved.Tags and TMSaved.DeadTags then
                    TMTargetLevel = LevelString.." |cFFFFFFDead|r"
                else
                    TMTargetLevel = LevelString
                end
            else
                if TMSaved.Tags and TMSaved.DeadTags then
                    TMTargetName = NameString..DifficultyString.." |cFFFFFFDead|r"
                else
                    TMTargetName = NameString..DifficultyString
                end
            end
            if TMSaved.RImprovedLevel then
                TMTargetRName = RNameString..RDifficultyString
                if TMSaved.RTags and TMSaved.RDeadTags then
                    TMTargetRLevel = RLevelString.." |cFFFFFFDead|r"
                else
                    TMTargetRLevel = RLevelString
                end
            else
                if TMSaved.RTags and TMSaved.RDeadTags then
                    TMTargetRName = RNameString..RDifficultyString.." |cFFFFFFDead|r"
                else
                    TMTargetRName = RNameString..RDifficultyString
                end
            end
        end
        TMShowReticleFrame()
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMReticleWhite()
    RETICLE.reticleTexture:SetColor(1, 1, 1)
    RETICLE.stealthIcon.stealthEyeTexture:SetColor(1, 1, 1)
    RETICLE.stealthIcon.stealthText:SetColor(1, 1, 1)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TargetMaintenanceOnHidden(Event)
   TMReticleWhite()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fix For Stealth Text Not Clearing, Think Its Caused By Stealth Text Coloring
function TMStealthDisguiseCheck()
    if GetUnitStealthState('player') == STEALTH_STATE_NONE or GetUnitDisguiseState('player') == DISGUISE_STATE_NONE then   --or GetUnitDisguiseState('player') == DISGUISE_STATE_DISGUISED
        RETICLE.stealthIcon.stealthText:SetHidden(true)
    end  
    if GetUnitDisguiseState('player') == DISGUISE_STATE_DISGUISED then
        RETICLE.stealthIcon.stealthText:SetText("Disguised")
    end    
end

-- Fix The i.e ^n:m Useless Info On Names Or Items  ~ By Adalan 
function FixString(sString)
	return zo_strformat(SI_TOOLTIP_ITEM_NAME, sString)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("TargetMaintenance_Target", EVENT_RETICLE_TARGET_CHANGED, TargetMaintenanceTarget)
EVENT_MANAGER:RegisterForEvent("TargetMaintenance_Target", EVENT_UNIT_DEATH_STATE_CHANGED, TargetMaintenanceTarget)
EVENT_MANAGER:RegisterForEvent("TargetMaintenance_Target", EVENT_PLAYER_COMBAT_STATE, TargetMaintenanceTarget)
EVENT_MANAGER:RegisterForEvent("TargetMaintenance_Target", EVENT_RETICLE_TARGET_PLAYER_CHANGED, TargetMaintenanceTarget)
EVENT_MANAGER:RegisterForEvent("TargetMaintenance_Target", EVENT_RETICLE_HIDDEN_UPDATE, TargetMaintenanceOnHidden)
EVENT_MANAGER:RegisterForEvent("TargetMaintenance_Target", EVENT_STEALTH_STATE_CHANGED, TMStealthDisguiseCheck)
EVENT_MANAGER:RegisterForEvent("TargetMaintenance_Target", EVENT_DISGUISE_STATE_CHANGED, TMStealthDisguiseCheck)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------