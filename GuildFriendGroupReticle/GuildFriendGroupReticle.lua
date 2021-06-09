local AddName = "GuildFriendGroupReticle"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Window = GetWindowManager()
local GuildReticleIcon = Window:CreateTopLevelWindow(nil)                                                   -- Create Guild Icon
local GuildReticleText = Window:CreateTopLevelWindow(nil)                                                   -- Create Guild Text
local FriendReticleIcon = Window:CreateTopLevelWindow(nil)                                                  -- Create Friend Icon
local FriendReticleText = Window:CreateTopLevelWindow(nil)                                                  -- Create Friend Text
local GroupReticleIcon = Window:CreateTopLevelWindow(nil)                                                   -- Create Group Icon
local GroupReticleText = Window:CreateTopLevelWindow(nil)                                                   -- Create Group Text

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GFGSavedVariables()
    GFGSaved = ZO_SavedVars:New("GuildFriendGroupReticle_SavedVariables", 1, nil, 
    { 
        Toggle = true, 
        GuildText = true, 
        GNameOn = true, 
        PNameOn = true, 
        GuildIcon = true, 
        GuildColor = true, 
        FriendText = true, 
        FriendIcon = true, 
        FriendColor = true,
        FriendNonGuild = false,
        GroupText = true, 
        GroupIcon = true, 
        GroupColor = true,
        Debug = false,
        -- Grouping Features
        AcceptFriend = true, 
        AcceptGuild = true,
    })
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GFGCreateFrames()
    -- Guild Icon
    GuildReticleIcon:SetDimensions(32,32)
    GuildReticleIcon:SetAnchor(CENTER,GuiRoot,CENTER,80,40)
    GuildReticleIcon.Icon = Window:CreateControl(nil, GuildReticleIcon, CT_TEXTURE)
    GuildReticleIcon.Icon:SetTexture("/esoui/art/mainmenu/menubar_guilds_up.dds")
    GuildReticleIcon.Icon:SetAnchorFill(GuildReticleIcon) 
    -- Guild Text
    GuildReticleText:SetDimensions(32,32)
    GuildReticleText:SetAnchor(LEFT,GuildReticleIcon,RIGHT,0,0)
    GuildReticleText.Text = Window:CreateControl(nil, GuildReticleText, CT_LABEL)
    GuildReticleText.Text:SetFont("ZoFontGameSmall")
    GuildReticleText.Text:SetAnchorFill(GuildReticleText)
    -- Friend Icon
    FriendReticleIcon:SetDimensions(32,32)
    FriendReticleIcon:SetAnchor(CENTER,GuiRoot,CENTER,-80,40)
    FriendReticleIcon.Icon = Window:CreateControl(nil, FriendReticleIcon, CT_TEXTURE)
    FriendReticleIcon.Icon:SetTexture("/esoui/art/mainmenu/menubar_social_up.dds")
    FriendReticleIcon.Icon:SetAnchorFill(FriendReticleIcon) 
    -- Friend Text
    FriendReticleText:SetDimensions(32,32)
    FriendReticleText:SetAnchor(RIGHT,FriendReticleIcon,LEFT,0,0)
    FriendReticleText.Text = Window:CreateControl(nil, FriendReticleText, CT_LABEL)
    FriendReticleText.Text:SetFont("ZoFontGameSmall")
    FriendReticleText.Text:SetAnchorFill(FriendReticleText)
    -- Group Icon
    GroupReticleIcon:SetDimensions(32,32)
    GroupReticleIcon:SetAnchor(CENTER,GuiRoot,CENTER,0,40)
    GroupReticleIcon.Icon = Window:CreateControl(nil, GroupReticleIcon, CT_TEXTURE)
    GroupReticleIcon.Icon:SetTexture("/esoui/art/mainmenu/menubar_group_up.dds")
    GroupReticleIcon.Icon:SetAnchorFill(GroupReticleIcon) 
    -- Group Text
    GroupReticleText:SetDimensions(32,32)
    GroupReticleText:SetAnchor(TOP,GroupReticleIcon,BOTTOM,0,0)
    GroupReticleText.Text = Window:CreateControl(nil, GroupReticleText, CT_LABEL)
    GroupReticleText.Text:SetFont("ZoFontGameSmall")
    GroupReticleText.Text:SetAnchorFill(GroupReticleText)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GuildFriendGroupReticleHidden(Event, Unit)
    GFGHideFrames()                                                                                         -- Hide Everything
    RETICLE.reticleTexture:SetColor(1,1,1)
    RETICLE.stealthIcon.stealthEyeTexture:SetColor(1,1,1)
    RETICLE.stealthIcon.stealthText:SetColor(1,1,1,0)
	--RETICLE.stealthIcon.stealthText:SetHidden(true)
    --ZO_ReticleContainerReticle:SetColor(1,1,1)
    --ZO_ReticleContainerStealthEye:SetColor(1,1,1)
    --ZO_ReticleContainerStealthText:SetColor(1,1,1)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GuildFriendGroupReticleTarget(Event, Unit)
    GFGHideFrames()                                                                                         -- Hide Everything Start Fresh
    if not DoesUnitExist("reticleover") then return end
    if not GFGSaved.Toggle then return end                                                                  -- Check For Toggle On
	local Name = GetUnitName("reticleover")                                                                 -- Get Player Name Were Targeting
    local Friend = IsUnitFriend("reticleover")                                                              -- Is Unit Friend
    local GroupMember = IsUnitGrouped("reticleover")                                                        -- Person Your Looking At Is He In The Group?
    local Group = IsUnitGrouped("player")                                                                   -- Player In Group
    local Blank = (Name == "" or Name == " ")                                                               -- Ignore Blanks
    if GFGIsCritter(Name) or Blank then return end                                                          -- Check For Critters and ETC, Should Only Be A Real Player.
    -- Guild
	local GuildMember = 0                                                                                   -- Guild Member Var
	local GuildNumber = 0                                                                                   -- Guild Number Var
	local GuildInfo = ""                                                                                    -- Guild String
    for GuildID = 1, GetNumGuilds(), 1 do                                                                   -- Begin Guild Checking
        for MemberID = 1, GetNumGuildMembers(GuildID), 1 do
		    hasCharacter, rawCharacterName, zone, class, alliance, level, championPoints = GetGuildMemberCharacterInfo(GuildID, MemberID)
            --Var = {GetGuildMemberCharacterInfo(GuildID, MemberID)}
            if rawCharacterName == GetRawUnitName("reticleover") then
                GuildMember = 1		
                if GuildNumber == 0 then
                    GuildNumber = 1
                    if GFGSaved.PNameOn == true then  
                        GuildInfo = GetUnitName("reticleover")                                              -- Begining Of Strings Togeather
                    end
                    if GFGSaved.GNameOn == true then
                        GuildInfo = GuildInfo .. "\n" ..GetGuildName(GuildID)                               -- Add Strings Togeather
                    end
                else
                    GuildInfo = GuildInfo .. "\n" ..GetGuildName(GuildID)                                   -- Add Strings Togeather
                end
            end
        end
    end
    -- Guild
    if GuildMember == 1 then                                                                                -- If Player Is In Guild Show
        if GFGSaved.GuildText then
            local Size = GuildReticleText.Text:GetStringWidth(GuildInfo)
            GuildReticleText:SetDimensions(Size,50)
            GuildReticleText.Text:SetText(GuildInfo)
            GuildReticleText.Text:SetColor(0,1,1)                                                       -- Teal Colour For Guild
            GuildReticleText:SetHidden(false)
        end
        if GFGSaved.GuildColor then
            RETICLE.reticleTexture:SetColor(0,1,1)
            RETICLE.stealthIcon.stealthEyeTexture:SetColor(0,1,1)
            RETICLE.stealthIcon.stealthText:SetColor(0,1,1)
            --ZO_ReticleContainerReticle:SetColor(0,1,1)                                                  -- Light Blueish Guild Colour For Reticle
            --ZO_ReticleContainerStealthEye:SetColor(0,1,1)
            --ZO_ReticleContainerStealthText:SetColor(0,1,1)
        end
        if GFGSaved.GuildIcon then 
            GuildReticleIcon:SetHidden(false)                                                           -- Guild Icon Show
        end
    end
    -- Friend
    if Friend then                                                                                          -- If Player Is Friend Show
        if GFGSaved.FriendNonGuild then
            if GuildMember == 0 then                                                                        -- Option To Only Show For Non-Guild
                if GFGSaved.FriendText then
                    local Size = FriendReticleText.Text:GetStringWidth(Name)
                    FriendReticleText:SetDimensions(Size,20)
                    FriendReticleText.Text:SetText(Name)                                                -- Get Player Name To Display
                    FriendReticleText.Text:SetColor(.2,.2,1)                                            -- Blue Colour For Friends Text
                    FriendReticleText:SetHidden(false)
                end
                if GFGSaved.FriendColor then
                    --if DoesUnitExist("reticleover") then
                    --    if GetUnitStealthState("player") then
                    --        RETICLE.stealthIcon.stealthText:SetHidden(false)
                    --    else
                    --        RETICLE.stealthIcon.stealthText:SetHidden(true)
                    --    end
                    --end

                    RETICLE.reticleTexture:SetColor(.2,.2,1)
                    RETICLE.stealthIcon.stealthEyeTexture:SetColor(.2,.2,1)
                    RETICLE.stealthIcon.stealthText:SetColor(.2,.2,1)
                    --ZO_ReticleContainerReticle:SetColor(.2,.2,1)                                        -- Blue Colour For Friends
                    --ZO_ReticleContainerStealthEye:SetColor(.2,.2,1)        
                    --ZO_ReticleContainerStealthText:SetColor(.2,.2,1)
                end
                if GFGSaved.FriendIcon then 
                    FriendReticleIcon:SetHidden(false)                                                  -- Friend Icon Show
                end
            end
        else      
            if GFGSaved.FriendText then
                local Size = FriendReticleText.Text:GetStringWidth(Name)
                FriendReticleText:SetDimensions(Size,20)
                FriendReticleText.Text:SetText(Name)                                                    -- Get Player Name To Display
                FriendReticleText.Text:SetColor(.2,.2,1)                                                -- Blue Colour For Friends Text
                FriendReticleText:SetHidden(false)
            end
            if GFGSaved.FriendColor then 
                RETICLE.reticleTexture:SetColor(.2,.2,1)
                RETICLE.stealthIcon.stealthEyeTexture:SetColor(.2,.2,1)
                RETICLE.stealthIcon.stealthText:SetColor(.2,.2,1)            
                --ZO_ReticleContainerReticle:SetColor(.2,.2,1)                                            -- Blue Colour For Friends
                --ZO_ReticleContainerStealthEye:SetColor(.2,.2,1)        
                --ZO_ReticleContainerStealthText:SetColor(.2,.2,1)
            end
            if GFGSaved.FriendIcon then 
                FriendReticleIcon:SetHidden(false)                                                      -- Friend Icon Show
            end
        end
    end 
    -- Group
    if Group then                                                                                           -- Check To See If Player Is In A Group First          
        if GroupMember then
            if GFGSaved.GroupText then
                local Size = GroupReticleText.Text:GetStringWidth(Name)
                GroupReticleText:SetDimensions(Size,20)
                GroupReticleText.Text:SetText(Name)                                                     -- Get Player Name To Display
                GroupReticleText.Text:SetColor(0,1,0)                                                   -- Green Colour For Group Text
                GroupReticleText:SetHidden(false)
            end
            if GFGSaved.GroupColor then
                RETICLE.reticleTexture:SetColor(0,1,0)
                RETICLE.stealthIcon.stealthEyeTexture:SetColor(0,1,0)
                RETICLE.stealthIcon.stealthText:SetColor(0,1,0)
                --ZO_ReticleContainerReticle:SetColor(0,1,0)                                              -- Green Colour For Group
                --ZO_ReticleContainerStealthEye:SetColor(0,1,0)  
                --ZO_ReticleContainerStealthText:SetColor(0,1,0)
            end
            if GFGSaved.GroupIcon then 
                GroupReticleIcon:SetHidden(false)                                                       -- Group Icon Show
            end
        end            
    end
    GFGFrameDebug()                                                                                         -- Debug Function
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GFGFrameDebug()                                                                                    -- Debug function For Setup
    if not GFGSaved.Debug then return end
    local Name = GetUnitName("reticleover")
    --local playerDisplayName = HashString(GetDisplayName('player'))
    --local playerCharName = HashString( GetUnitName('player'))
    --d(playerDisplayName)
    --d(playerCharName)
    if GFGSaved.GuildText then
        local TEST = Name.."\nMerchants Alliance"
        local Size = GuildReticleText.Text:GetStringWidth(TEST)
        GuildReticleText:SetDimensions(Size,20)
        GuildReticleText.Text:SetText(TEST)                                                     
        GuildReticleText.Text:SetColor(0,1,1)                                                   
        GuildReticleText:SetHidden(false)
    end
    if GFGSaved.GuildIcon then 
        GuildReticleIcon:SetHidden(false)
    end
    if GFGSaved.FriendText then
        local Size = FriendReticleText.Text:GetStringWidth(Name)
        FriendReticleText:SetDimensions(Size,20)
        FriendReticleText.Text:SetText(Name)
        FriendReticleText.Text:SetColor(.2,.2,1)                                                
        FriendReticleText:SetHidden(false)
    end
    if GFGSaved.FriendIcon then 
        FriendReticleIcon:SetHidden(false)
    end
    if GFGSaved.GroupText then
        local Size = GroupReticleText.Text:GetStringWidth(Name)
        GroupReticleText:SetDimensions(Size,20)
        GroupReticleText.Text:SetText(Name)
        GroupReticleText.Text:SetColor(0,1,0)                                                   
        GroupReticleText:SetHidden(false)
    end
    if GFGSaved.GroupIcon then 
        GroupReticleIcon:SetHidden(false)
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GFGHideFrames()                                                                                        -- Hide Everything Function
    GuildReticleText:SetHidden(true)                                                                   
    GuildReticleIcon:SetHidden(true)                                                                    
    FriendReticleText:SetHidden(true)                                                                   
    FriendReticleIcon:SetHidden(true)                                                                   
    GroupReticleText:SetHidden(true)                                                                   
    GroupReticleIcon:SetHidden(true)                                                                   
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GFGIsCritter(Name)                                                                                        -- Function To Check If Critter
	if (GetUnitLevel("reticleover") ~= 1) then return false end                                                 -- Critters Are Always Level 1
	local Critters = {                                              
		"Butterfly", "Lizard", "Rat", "Snake", "Pony Guar", "Frog", "Squirrel", "Rabbit", "Deer", "Cat", "Pig", "Sheep", "Antelope", "Wasp", "Monkey", "Fleshflies", "Centipede", "Chicken", "Torchbug", "Spider", "Scorpion", "Goat", "Scrib", "Scuttler", -- The List Of Critters
	}
	for I = 1, #Critters do                                                                                     -- Is The Target A Critter?
		if (Name == Critters[I]) then return true end
	end
	return false                                                                                                -- Otherwise False
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GuildFriendGroupInvite(Event, Unit)
	if IsPlayerInGroup("player") then return end                                                        -- If Player Is Already In A Group Then Do Nothing
    if not GFGSaved.Toggle then return end
    -- Guild
    if GFGSaved.AcceptGuild then
        local FoundLoop = false
        for Guild = 1, 5 do
            local GID = GetGuildId(Guild)
            if GID > 0 then 
                for Member = 1, GetNumGuildMembers(GID) do                                              -- Cycle Guild Members
                    local hasCharacter, rawCharacterName, zone, class, alliance, level, championPoints = GetGuildMemberCharacterInfo(GID, Member)
                    --local _, GuildName = GetGuildMemberCharacterInfo(GID,Member) 			            -- Guild Members						
                    if GFGFound(rawCharacterName) == Unit then 
                        AcceptGroupInvite()                                                             -- ESO API Accept Invite                    
                        FoundLoop = true	
                        break                                                                           -- Invite Guild Member And Stop
                    end
                end
            end	
            if FoundLoop then break end
        end	
    end
    -- Friend
    if GFGSaved.AcceptFriend then
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
local GFGFound = function(GFGString)                                                                      -- Remove Misc Characters From Names                                                       
 	if GFGString then
		local POS = string.find(GFGString, "^", 1, true)                                                 
		if POS then
			GFGString = string.sub(GFGString, 1, POS-1)
		end
        return GFGString	
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GuildFriendGroupReticleOnLoad(Event, AddonName)
    if AddonName ~= AddName then return end
    GFGSavedVariables()
    GFGCreateFrames()
    GFGHideFrames()
    EVENT_MANAGER:RegisterForEvent("GuildFriendGroupReticle_Player", EVENT_PLAYER_ACTIVATED,
    function()
    GFGLAM2Panel()                                                                                              -- Start Settings Panel
        EVENT_MANAGER:UnregisterForEvent("GuildFriendGroupReticle_Player", EVENT_PLAYER_ACTIVATED)
    end)
    EVENT_MANAGER:UnregisterForEvent("GuildFriendGroupReticle_OnLoad", EVENT_ADD_ON_LOADED)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EVENT_MANAGER:RegisterForEvent("GuildFriendGroupReticle_OnLoad", EVENT_ADD_ON_LOADED, GuildFriendGroupReticleOnLoad)            -- Load This Bitch
EVENT_MANAGER:RegisterForEvent("GuildFriendGroupReticle_Target", EVENT_RETICLE_TARGET_CHANGED, GuildFriendGroupReticleTarget)   -- Target Change 
EVENT_MANAGER:RegisterForEvent("GuildFriendGroupReticle_Reticle", EVENT_RETICLE_HIDDEN_UPDATE, GuildFriendGroupReticleHidden)   -- Reticle Hidden Event
EVENT_MANAGER:RegisterForEvent("GuildFriendGroupReticle_Invite", EVENT_GROUP_INVITE_RECEIVED, GuildFriendGroupInvite)           -- Invite Event
--------------------------------------------------------------------------------------------------------------------------------------------------------------------