local kName         = 'Pawksickles'
local Pawksickles   = {}
local EventMgr      = GetEventManager()
local CBM           = CALLBACK_MANAGER
local LMP           = LibMediaProvider

if (not LMP) then return end

function Pawksickles:OnLoaded(event, addon)
    if (addon ~= kName) then
        return
    end
    LMP:Register('font', 'Diogenes',                      [[Pawksickles/fonts/Diogenes.ttf]]                )
    LMP:Register('font', 'OpenSans - Bold',               [[Pawksickles/fonts/OpenSans-Bold.ttf]]           )
    LMP:Register('font', 'OpenSans - BoldItalic',         [[Pawksickles/fonts/OpenSans-BoldItalicd.ttf]]    )
    LMP:Register('font', 'OpenSans - Semibold',           [[Pawksickles/fonts/OpenSans-Semibold.ttf]]       )
    LMP:Register('font', 'OpenSans - SemiboldItalic',     [[Pawksickles/fonts/OpenSans-SemiboldItalic.ttf]] )
    LMP:Register('font', 'Roboto - Bold',                 [[Pawksickles/fonts/Roboto-Bold.ttf]]             )
    LMP:Register('font', 'Roboto - BoldItalic',           [[Pawksickles/fonts/Roboto-BoldItalic.ttf]]       )

    CBM:RegisterCallback('PAWKSICKLES_FONT_CHANGED', function(...) self:SetFont(...) end)
    CBM:FireCallbacks('PAWKSICKLES_LOADED')
end

function Pawksickles:SetFont(object, font)
    if _G[object] ~= nil then
        _G[object]:SetFont(font)
    end
end

EventMgr:RegisterForEvent('Pawksickles', EVENT_ADD_ON_LOADED, function(...) Pawksickles:OnLoaded(...) end)