local AddName = "ClearChat"
local Version = "Version 100004.1"
local Author = "Created By SkOODaT"
local PanelHeader = "_SkOODaT"
local PanelTitle = "SkOODaTs AddOns"

ClearChat = {}
local LAM = LibStub:GetLibrary("LibAddonMenu-1.0")

local DebugMode = false

function OnAddonLoaded(Event, AddonName)
   if AddonName == AddName then
        CCCreateSettings()                                                          --Start Settings Panel
   end
end

SLASH_COMMANDS[ "/clr" ] =
		function( _param )
			if( _param == "all" ) then
				for i = 1, GetNumChatContainerTabs( 1 ), 1 do
					_G[ "ZO_ChatWindowTemplate" .. i .. "Buffer" ]:Clear()
				end
			else
				for i = 1, GetNumChatContainerTabs( 1 ), 1 do
					if( _G[ "ZO_ChatWindowTabTemplate" .. i ]:GetDrawLevel() == 2 ) then
						_G[ "ZO_ChatWindowTemplate" .. i .. "Buffer" ]:Clear()
					end
				end
			end
		end
        
function CCCreateSettings()
    local Panel = LAM:CreateControlPanel(PanelHeader, PanelTitle)                               -- Panel
    LAM:AddHeader(Panel, "ClearChat_General", "|cFFFFB0" ..AddName.. "|r")                      -- Panel Title
    
    if DebugMode == true then
        LAM:AddDescription(Panel, "ClearChat_Text_Debug1", "*************")
        LAM:AddDescription(Panel, "ClearChat_Text_Debug2", "Debug Mode On")
        LAM:AddDescription(Panel, "ClearChat_Text_Debug3", "*************")
    end
    
    LAM:AddDescription(Panel, "ClearChat_Text_Info", "Simple Addon To Clear chat With /clr or /clr all.")
    --LAM:AddDescription(Panel, "ClearChat_Text_Line1", "------------------------------------------------------------------------------------")
    --LAM:AddDescription(Panel, "ClearChat_Text_Line2", "------------------------------------------------------------------------------------")
    LAM:AddDescription(Panel, "ClearChat_Text_End", AddName .. " " .. Version .. " " .. Author)
end

EVENT_MANAGER:RegisterForEvent("ClearChat", EVENT_ADD_ON_LOADED, OnAddonLoaded)                -- Load This Bitch