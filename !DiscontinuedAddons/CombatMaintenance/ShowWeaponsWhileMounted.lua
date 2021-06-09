SWWM = {}
SWWM.Name = "ShowWeaponsWhileMounted"
SWWM.Version = "1.05"

-- Constants can be adjusted to own needs --------------------------
SWWM.Delay1 = 5  -- Delay in seconds for refreshing character when mounted already at login
SWWM.Delay2 = 15 -- Delay for refreshing character again after login (just in case first refresh was too early)
SWWM.Delay3 = 5  -- Delay for refreshing character again when mounting (in case first refresh was too early because character just logged in)
-- -----------------------------------------------------------------

SWWM.D1 = SWWM.Delay1 * 1000
SWWM.D2 = SWWM.Delay2 * 1000
SWWM.D3 = SWWM.Delay3 * 1000


local function RefreshCharacter()
  local HelmetStatus = GetSetting(SETTING_TYPE_IN_WORLD, IN_WORLD_UI_SETTING_HIDE_HELM)
  SetSetting(SETTING_TYPE_IN_WORLD, IN_WORLD_UI_SETTING_HIDE_HELM, 1 - HelmetStatus)
  SetSetting(SETTING_TYPE_IN_WORLD, IN_WORLD_UI_SETTING_HIDE_HELM, HelmetStatus)
end

local function OnMountStatusChange(eventID, mounting)
  if mounting then
    RefreshCharacter()
    zo_callLater(RefreshCharacter, SWWM.D3)
  end
end

local function OnZoneChange(eventID)
  if IsMounted() then
    zo_callLater(RefreshCharacter, SWWM.D1)
    zo_callLater(RefreshCharacter, SWWM.D2)
  end
end

EVENT_MANAGER:RegisterForEvent(SWWM.Name, EVENT_PLAYER_ACTIVATED, OnZoneChange)
EVENT_MANAGER:RegisterForEvent(SWWM.Name, EVENT_MOUNTED_STATE_CHANGED, OnMountStatusChange)
