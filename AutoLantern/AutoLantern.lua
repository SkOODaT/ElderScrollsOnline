local AddName = "AutoLantern"
local Memento = 341 -- Almalexia's Enchanted Lantern
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AutoLanternTargetEvent()
    AutoLanternRunBuff()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AutoLanternRunBuff()
    local LANTERN_ACTIVE = false
    for i = 1, GetNumBuffs("player") do
        local BuffName, timeStarted, timeEnding, buffSlot, stackCount, textureName, iconFilename, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer = GetUnitBuffInfo("player", i)
        if BuffName == "Light of the Tribunal" then
            LANTERN_ACTIVE = true
            --d('Buff Found')
            return
        else
            LANTERN_ACTIVE = false
        end
    end
    if ALSaved.Toggle and not LANTERN_ACTIVE and not IsUnitInCombat("player") and not IsInteracting() and not IsMounted("player") then
        UseCollectible(Memento)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AutoLanternToggle()
    if ALSaved.Toggle then
        ALSaved.Toggle = false
        d("Auto Lantern Off")
    else
        ALSaved.Toggle = true
        d("Auto Lantern on")
    end
    AutoLanternRunBuff()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AutoLanternBuffEvent(eventcode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, sourceType)
    if ALSaved.Toggle then
        if unitTag == "player" then
            if not IsUnitInCombat("player") and not IsInteracting() and not IsMounted("player") then
                --if effectName == "Light of the Tribunal" and changeType == 1 then
                --  d("Buff Active")
                --else
                if effectName == "Light of the Tribunal" and changeType == 2 then
                    --d("use Item")
                    zo_callLater(function () UseCollectible(Memento) end, 3000)
                --elseif not effectName == "Light of the Tribunal" then
                --  d("Start Item")
                --  UseCollectible(Memento)
                end
            end
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ALSavedVariables()
    ALSaved = ZO_SavedVars:NewAccountWide("AutoLantern_SavedVariables", 100035, nil,
    {
        Toggle = true,
        Reticle = false,
    }, GetWorldName())
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AutoLanternOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    ALSavedVariables()
    local name, _, _, _, unlocked = GetCollectibleInfo(Memento) -- Almalexia's Enchanted Lantern
    if (unlocked) then
        ZO_CreateStringId("SI_BINDING_NAME_AENCHANTEDLANTERN", zo_strformat(SI_COLLECTIBLE_NAME_FORMATTER, name))
    end
    EVENT_MANAGER:RegisterForEvent("AutoLantern_Player", EVENT_PLAYER_ACTIVATED,
    function()
    ALLAM2Panel()
        EVENT_MANAGER:UnregisterForEvent("AutoLantern_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("AutoLantern_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("AutoLantern_OnLoad", EVENT_ADD_ON_LOADED, AutoLanternOnLoad)
EVENT_MANAGER:RegisterForEvent("AutoLantern_Buff", EVENT_EFFECT_CHANGED, AutoLanternBuffEvent)
EVENT_MANAGER:RegisterForEvent("AutoLantern_Target", EVENT_RETICLE_TARGET_CHANGED, function() if ALSaved.Reticle then AutoLanternTargetEvent() end end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------