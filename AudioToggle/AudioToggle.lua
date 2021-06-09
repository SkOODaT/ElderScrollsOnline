local AddName = "AudioToggle"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ATSavedVariables()
    ATSaved = ZO_SavedVars:New("AudioToggle_SavedVariables", 1, nil,
    { 
        Toggle = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ToggleMusic()
    if not ATSaved.Toggle then return end
	local Enabled = not GetSetting_Bool(SETTING_TYPE_AUDIO, AUDIO_SETTING_MUSIC_ENABLED);
	SetSetting(SETTING_TYPE_AUDIO, AUDIO_SETTING_MUSIC_ENABLED, tostring(Enabled), 1)
	if Enabled then
		CHAT_SYSTEM.containers[1].windows[1].buffer:AddMessage("Music Enabled")
	else
		CHAT_SYSTEM.containers[1].windows[1].buffer:AddMessage("Music Disabled")
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ToggleSound()
    if not ATSaved.Toggle then return end
	local Enabled = not GetSetting_Bool(SETTING_TYPE_AUDIO, AUDIO_SETTING_SOUND_ENABLED);
	SetSetting(SETTING_TYPE_AUDIO, AUDIO_SETTING_SOUND_ENABLED, tostring(Enabled), 1)
	if Enabled then
		CHAT_SYSTEM.containers[1].windows[1].buffer:AddMessage("Sounds Enabled")
	else
		CHAT_SYSTEM.containers[1].windows[1].buffer:AddMessage("Sounds Disabled")
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ToggleDialogue()
    if not ATSaved.Toggle then return end
	local Enabled = not GetSetting_Bool(SETTING_TYPE_AUDIO, AUDIO_SETTING_VO_ENABLED);
	SetSetting(SETTING_TYPE_AUDIO, AUDIO_SETTING_VO_ENABLED, tostring(Enabled), 1)
	if Enabled then
		CHAT_SYSTEM.containers[1].windows[1].buffer:AddMessage("Dialogue Enabled")
	else
		CHAT_SYSTEM.containers[1].windows[1].buffer:AddMessage("Dialogue Disabled")
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AudioToggleOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    ATSavedVariables()
    ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_MUSIC", "Toggle Music")
    ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_SOUND", "Toggle Sounds")
    ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_DIALOGUE", "Toggle Dialogue")
    EVENT_MANAGER:RegisterForEvent("AudioToggle_Player", EVENT_PLAYER_ACTIVATED,
    function()
    ATLAM2Panel()                                                                                       -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("AudioToggle_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("AudioToggle_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("AudioToggle_OnLoad", EVENT_ADD_ON_LOADED, AudioToggleOnLoad)               -- Load This Bitch
--------------------------------------------------------------------------------------------------------------------------------------------------------------------