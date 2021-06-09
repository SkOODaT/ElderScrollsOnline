local AddName = "AutoAccept"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AASavedVariables()                                                                        -- Saved Vars
    AASaved = ZO_SavedVars:New("AutoAcceptSavedVars", 1, nil, 
    { 
        Toggle = true,
        Friend = true, 
        Guild = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AutoAcceptInvite(Event, Unit)
    if not AASaved.Toggle then return end
	if IsPlayerInGroup("player") then return end                                                        -- If Player Is Already In A Group Then Do Nothing
    if AASaved.Guild then
        local FoundLoop = false
        for Guild = 1, 5 do
            local GID = GetGuildId(Guild)
            if GID > 0 then 
                for Member = 1, GetNumGuildMembers(GID) do                                              -- Cycle Guild Members
                    local _, GuildName = GetGuildMemberCharacterInfo(GID,Member) 			            -- Guild Members						
                    if AAFound(GuildName) == Unit then 
                        AcceptGroupInvite()                                                             -- ESO API Accept Invite                    
                        FoundLoop = true	
                        break                                                                           -- Invite Guild Member And Stop
                    end
                end
            end	
            if FoundLoop then break end
        end	
    end
    if AASaved.Friend then
        for Friend = 1, GetNumFriends() do                                                              -- Cycle Friends
            local _, FriendName = GetFriendCharacterInfo(Friend) 	                                    -- Friends Name
            if AAFound(FriendName) == Unit then                                                         
                AcceptGroupInvite()                                                                     -- ESO API Accept Invite 
                break                                                                                   -- Invite Friend And Stop
            end
        end
    end	
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local AAFound = function(AAString)                                                                      -- Remove Misc Characters From Names                                                       
 	if AAString then
		local POS = string.find(AAString, "^", 1, true)                                                 
		if POS then
			AAString = string.sub(AAString, 1, POS-1)
		end
        return AAString	
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AutoAcceptOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    AASavedVariables()
    EVENT_MANAGER:RegisterForEvent("AutoAccept_Player", EVENT_PLAYER_ACTIVATED,
    function()
    AALAM2Panel()                                                                                       -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("AutoAccept_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("AutoAccept_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("AutoAccept_OnLoad", EVENT_ADD_ON_LOADED, AutoAcceptOnLoad)                   -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("AutoAccept_Invite", EVENT_GROUP_INVITE_RECEIVED, AutoAcceptInvite)           -- Invite Event
--------------------------------------------------------------------------------------------------------------------------------------------------------------------