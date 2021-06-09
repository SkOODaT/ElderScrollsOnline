local AddName = "SorcererMaintenance"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local EVTimer1 = 1000 
local EVTimer2 = 1000
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Pet Output
local UFOUTPUT = "SUMMON/RESUMMON YOUR FAMILIAR!"
local UCOUTPUT = "SUMMON/RESUMMON YOUR CLANNFEAR!"
local SWTOUTPUT = "SUMMON/RESUMMON YOUR WINGED TWILIGHT!"
-- Magelight Output
local MLOUTPUT = "NEED MAGE/INNER/RADIANT LIGHT!"
-- Local Pet Vars
local IsPetOut = false
local UF = false    
local UC = false 
local SWT = false
-- Magelight Vars
local IsMLOut = false
local IsMLOnBar = false
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SOMSavedVariables()
    SOMSaved = ZO_SavedVars:New("SorcererMaintenance_SavedVariables", 1, nil,
    { 
        Toggle = true,
        -- Pet
        PetToggle = true, 
        PetChat = false,
        PetAlert = true,        
        PetSound = true, 
        PetPSBT = false,
        -- Mage Light
        MLToggle = true, 
        MLChat = false,
        MLAlert = true,        
        MLSound = true, 
        MLPSBT = false 
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SorcererMaintenanceTarget()                                                                    -- Register OnUpdate Only For Attackable Targets
    if DoesUnitExist("reticleover") and IsUnitAttackable("reticleover") and IsUnitInCombat("player") then 
        if not SOMSaved.Toggle then return end
        --[[if SOMSaved.PetToggle then
            SOMPetCheck()
        end
        if SOMSaved.MLToggle then
            SOMMLCheck()
        end]]--
        EVENT_MANAGER:RegisterForUpdate("SorcererMaintenance_PetUpdate", EVTimer1, SOMPetCheck)
        EVENT_MANAGER:RegisterForUpdate("SorcererMaintenance_MLUpdate", EVTimer2, SOMMLCheck)
    else
        EVENT_MANAGER:UnregisterForUpdate("SorcererMaintenance_PetUpdate", SOMPetCheck) 
        EVENT_MANAGER:UnregisterForUpdate("SorcererMaintenance_MLUpdate", SOMMLCheck)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SOMPetCheck()
    local Name = GetUnitName("player")
    local Reaction = GetUnitReaction("reticleover")
    if not DoesUnitExist("reticleover") then return end
    if not IsUnitAttackable("reticleover") then return end
    if not SOMSaved.Toggle then return end
    if not SOMSaved.PetToggle then return end
    if IsUnitDead("player") then return end
    -- Get Pet Buffs
	for i = 1, GetNumBuffs("player") do
		local BuffName = GetUnitBuffInfo("player", i)
        if BuffName == "Summon Unstable Familiar" or BuffName == "Summon Volatile Familiar" or BuffName == "Summon Unstable Clannfear" or BuffName == "Summon Winged Twilight" or BuffName == "Summon Restoring Twilight" then -- ALL PETS 
            IsPetOut = true
            return                                                                                          
        else 
            IsPetOut = false
        end
    end
    -- Get Abilities Sloted
    for s = 1, 7 do
        local Ability = GetSlotName(s)
        if Ability == "Summon Unstable Familiar" or Ability == "Summon Volatile Familiar" then
            UF = true
            break
        elseif Ability == "Summon Unstable Clannfear" then
            UC = true
            break
        elseif Ability == "Summon Winged Twilight" or Ability == "Summon Restoring Twilight" then
            SWT = true
            break
        else
            UF = false    
            UC = false 
            SWT = false     
        end
    end
    -- Play Alert
    if IsPetOut == false and UF == true or UC == true or SWT == true then
        if Reaction == UNIT_REACTION_HOSTILE or UNIT_REACTION_NEUTRAL or IsUnitPlayer("reticleover") and IsUnitAttackable("reticleover") then   -- NPC Hostile Reaction Or PVP Players
            if SOMSaved.PetChat then
                --ZO_ChatWindowTemplate1Buffer:AddMessage(OUTPUT)                                                                               -- Chat Warning
                if UF == true then
                    ZO_ChatWindowTemplate1Buffer:AddMessage(UFOUTPUT)
                elseif UC == true then
                    ZO_ChatWindowTemplate1Buffer:AddMessage(UCOUTPUT)
                elseif SWT == true then
                    ZO_ChatWindowTemplate1Buffer:AddMessage(SWTOUTPUT)
                end
            end
            if SOMSaved.PetAlert then
                --ZO_Alert(1, 1, OUTPUT)                                                                                                        -- ZO Alert Frame
                if UF == true then
                    ZO_Alert(1, 1, UFOUTPUT)
                elseif UC == true then
                    ZO_Alert(1, 1, UCOUTPUT)
                elseif SWT == true then
                    ZO_Alert(1, 1, SWTOUTPUT)
                end
            end
            if SOMSaved.PetPSBT then
                --PSBT:NewEvent( PSBT_AREAS.NOTIFICATION, true, nil, OUTPUT)                                                                    -- PSBT Warning
                if UF == true then
                    PSBT:NewEvent( PSBT_AREAS.NOTIFICATION, true, nil, UFOUTPUT)
                elseif UC == true then
                    PSBT:NewEvent( PSBT_AREAS.NOTIFICATION, true, nil, UCOUTPUT)
                elseif SWT == true then
                    PSBT:NewEvent( PSBT_AREAS.NOTIFICATION, true, nil, SWTOUTPUT)
                end
            end
            if SOMSaved.PetSound then
                PlaySound( 'Quest_StepFailed' )                                                                                                 --Sound Warning
            end
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SOMMLCheck()
    local Name = GetUnitName("player")
    local Reaction = GetUnitReaction("reticleover")
    if not DoesUnitExist("reticleover") then return end
    if not IsUnitAttackable("reticleover") then return end
    if not SOMSaved.Toggle then return end
    if not SOMSaved.MLToggle then return end
    if IsUnitDead("player") then return end
    -- Get Pet Buffs
	for i = 1, GetNumBuffs("player") do
		local BuffName = GetUnitBuffInfo("player", i)
        --ZO_ChatWindowTemplate1Buffer:AddMessage(BuffName) 
        if BuffName == "Magelight" or BuffName == "Inner Light" or BuffName == "Radiant Magelight" then                                                                            -- ALL Lights 
            IsMLOut = true
            return                                                                                                                              -- If ML Is Found END no More Searching (Took Me Hours To figure This Fix Out :S Newbe)
        else
            IsMLOut = false
        end
    end
    -- Get Abilities Sloted
    for s = 1, 7 do
        local Ability = GetSlotName(s)
        --ZO_ChatWindowTemplate1Buffer:AddMessage(Ability) 
        if Ability == "Magelight" or Ability == "Inner Light" or Ability == "Radiant Magelight" then
            IsMLOnBar = true
            break
        else
            IsMLOnBar = false
        end
    end
    -- Play Alert
    if IsMLOut == false and IsMLOnBar == true then
        if Reaction == UNIT_REACTION_HOSTILE or UNIT_REACTION_NEUTRAL or IsUnitPlayer("reticleover") and IsUnitAttackable("reticleover") then   -- NPC Hostile Reaction Or PVP Players
            if SOMSaved.MLChat then
                ZO_ChatWindowTemplate1Buffer:AddMessage(MLOUTPUT)                                                                               -- Chat Warning
            end
            if SOMSaved.MLAlert then
                ZO_Alert(1, 1, MLOUTPUT)                                                                                                        -- ZO Alert Frame
            end
            if SOMSaved.MLPSBT then
                PSBT:NewEvent( PSBT_AREAS.NOTIFICATION, true, nil, MLOUTPUT)                                                                    -- PSBT Warning
            end
            if SOMSaved.MLSound then
                PlaySound( 'Quest_StepFailed' )                                                                                                 -- Sound Warning
            end
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SorcererMaintenanceOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    if not GetUnitClass("player") == "Sorcerer" then return end                                                                                 -- Get Player Class And If Sorcerer Start And Create Options
    SOMSavedVariables()
    EVENT_MANAGER:RegisterForEvent("SorcererMaintenance_Player", EVENT_PLAYER_ACTIVATED,
    function()
    SOMLAM2Panel()                                                                                                                              -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("SorcererMaintenance_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("SorcererMaintenance_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("SorcererMaintenance_OnLoad", EVENT_ADD_ON_LOADED, SorcererMaintenanceOnLoad)                                    -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("SorcererMaintenance_Target", EVENT_RETICLE_TARGET_CHANGED, SorcererMaintenanceTarget)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------