local LAM = LibAddonMenu2
local LMP = LibMediaProvider

if (not LAM) then return end
if (not LMP) then return end

local tsort = table.sort
local tinsert = table.insert

local PawksicklesConfig = {
    _name = '_pawksickles',
    _headers = setmetatable({}, {__mode = 'kv'})
}

local CBM = CALLBACK_MANAGER

local THINSHADOW          = 'soft-shadow-thin'
local THICKSHADOW         = 'soft-shadow-thick'
local SHADOW              = 'shadow'
local THINOUTLINE         = 'thin-outline'
local THICKOUTLINE        = 'thick-outline'
local OUTLINE             = 'outline'
local NONE                = 'none'

local defaults = {

    -- KEYBOARD
    -- Window Headers
    ZoFontWinH1 = {face = 'OpenSans - Bold', size = 30, decoration = OUTLINE, name = 'WindowHeaders'},
    -- Menu Headers
    ZoFontWinH2 = {face = 'OpenSans - Bold', size = 24, decoration = OUTLINE, name = 'MenuHeaders'},
    -- Settings Menu
    ZoFontWinH3 = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = 'SettingMenu'},
    -- Menu Fonts And Chat Status Numbers
    ZoFontWinH4 = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = 'MenuFonts/ChatStatus'},
    -- Tooltips
    ZoFontWinH5 = {face = 'OpenSans - Bold', size = 16, decoration = OUTLINE, name = 'Tooltips'},

    -- ??
    ZoFontWinH3SoftShadowThin = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},

    -- ??
    ZoFontWinT1 = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},
    -- Affected Info Panel
    ZoFontWinT2 = {face = 'OpenSans - Bold', size = 16, decoration = OUTLINE, name = 'InfoPanel'},

    -- Affected Member Lists/ Addon Dropdowns
    ZoFontGame = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = 'MenuLists/Dropdowns'},
    -- Tooltips
    ZoFontGameMedium = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = 'Tooltips'},
    -- Game Numbers
    ZoFontGameBold = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = 'GameNumbers'},
    -- ??
    ZoFontGameOutline = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},
    -- Target Information Frame
    ZoFontGameShadow = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = 'TargetInformation'},

    -- ??
    ZoFontKeyboard28ThickOutline = {face = 'OpenSans - Bold', size = 28, decoration = OUTLINE, name = '?'},
    -- ??
    ZoFontKeyboard24ThickOutline = {face = 'OpenSans - Bold', size = 24, decoration = OUTLINE, name = '?'},
    -- ??
    ZoFontKeyboard18ThickOutline = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},

    -- Slider Numbers
    ZoFontGameSmall = {face = 'OpenSans - Bold', size = 13, decoration = OUTLINE, name = 'SliderNumbers'},
    -- ??
    ZoFontGameLarge = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},
    ZoFontGameLargeBold = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},
    ZoFontGameLargeBoldShadow = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},

    -- Addon Menu And Stats
    ZoFontHeader  = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = 'Stats/AddonsMenu'},
    ZoFontHeader2  = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},
    ZoFontHeader3  = {face = 'OpenSans - Bold', size = 24, decoration = OUTLINE, name = '?'},
    ZoFontHeader4  = {face = 'OpenSans - Bold', size = 26, decoration = OUTLINE, name = '?'},

    ZoFontHeaderNoShadow  = {face = 'OpenSans - Bold', size = 18, decoration = NONE, name = '?'},

    ZoFontCallout  = {face = 'OpenSans - Bold', size = 36, decoration = OUTLINE, name = '?'},
    ZoFontCallout2  = {face = 'OpenSans - Bold', size = 48, decoration = OUTLINE, name = '?'},
    ZoFontCallout3  = {face = 'OpenSans - Bold', size = 54, decoration = OUTLINE, name = '?'},

    ZoFontEdit  = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},
    ZoFontEdit20NoShadow  = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},

    ZoFontChat  = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},
    ZoFontEditChat  = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},

    -- ??
    ZoFontWindowTitle  = {face = 'OpenSans - Bold', size = 30, decoration = OUTLINE, name = '?'},
    -- ??
    ZoFontWindowSubtitle  = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},

    -- ??
    ZoFontTooltipTitle  = {face = 'OpenSans - Bold', size = 22, decoration = NONE, name = '?'},
    -- ??
    ZoFontTooltipSubtitle  = {face = 'OpenSans - Bold', size = 18, decoration = NONE, name = '?'},

    ZoFontAnnounce  = {face = 'OpenSans - Bold', size = 28, decoration = OUTLINE, name = '?'},
    ZoFontAnnounceMessage  = {face = 'OpenSans - Bold', size = 24, decoration = OUTLINE, name = '?'},
    ZoFontAnnounceMedium  = {face = 'OpenSans - Bold', size = 24, decoration = OUTLINE, name = '?'},
    ZoFontAnnounceLarge  = {face = 'OpenSans - Bold', size = 36, decoration = OUTLINE, name = '?'},

    ZoFontAnnounceNoShadow  = {face = 'OpenSans - Bold', size = 36, decoration = NONE, name = '?'},

    ZoFontCenterScreenAnnounceLarge  = {face = 'OpenSans - Bold', size = 40, decoration = OUTLINE, name = '?'},
    ZoFontCenterScreenAnnounceSmall  = {face = 'OpenSans - Bold', size = 30, decoration = OUTLINE, name = '?'},

    ZoFontAlert  = {face = 'OpenSans - Bold', size = 24, decoration = OUTLINE, name = '?'},

    ZoFontConversationName  = {face = 'OpenSans - Bold', size = 28, decoration = OUTLINE, name = '?'},
    ZoFontConversationText  = {face = 'OpenSans - Bold', size = 24, decoration = OUTLINE, name = '?'},
    ZoFontConversationOption  = {face = 'OpenSans - Bold', size = 22, decoration = OUTLINE, name = '?'},
    ZoFontConversationQuestReward  = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},

    -- KeybindingFont
    ZoFontKeybindStripKey  = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = 'KeybindFont'},
    -- Keybinding Description
    ZoFontKeybindStripDescription  = {face = 'OpenSans - Bold', size = 25, decoration = OUTLINE, name = 'KeybindDescription'},
    -- DialogKeybind Description
    ZoFontDialogKeybindDescription  = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = 'KeybindDialog'},

    ZoInteractionPrompt  = {face = 'OpenSans - Bold', size = 24, decoration = OUTLINE, name = '?'},

    ZoFontCreditsHeader  = {face = 'OpenSans - Bold', size = 24, decoration = NONE, name = '?'},
    ZoFontCreditsText  = {face = 'OpenSans - Bold', size = 18, decoration = NONE, name = '?'},

    -- Subtitles?
    ZoFontSubtitleText  = {face = 'OpenSans - Bold', size = 28, decoration = OUTLINE, name = 'Subtitles?'},

    ZoMarketAnnouncementKeyboardDescriptionFont  = {face = 'OpenSans - Bold', size = 22, decoration = OUTLINE, name = '?'},
    ZoMarketAnnouncementCalloutFont  = {face = 'OpenSans - Bold', size = 32, decoration = OUTLINE, name = '?'},


    ZoFontBookPaper  = {face = 'OpenSans - Bold', size = 20, decoration = NONE, name = 'BookPaper'},
    ZoFontBookSkin  = {face = 'OpenSans - Bold', size = 20, decoration = NONE, name = 'BookSkin'},
    ZoFontBookRubbing  = {face = 'OpenSans - Bold', size = 20, decoration = NONE, name = 'BookRubbing'},
    ZoFontBookLetter  = {face = 'OpenSans - Bold', size = 20, decoration = NONE, name = 'BookLetter'},
    ZoFontBookNote  = {face = 'OpenSans - Bold', size = 22, decoration = NONE, name = 'BookNote'},
    ZoFontBookScroll  = {face = 'OpenSans - Bold', size = 26, decoration = NONE, name = 'BookScroll'},
    ZoFontBookTablet  = {face = 'OpenSans - Bold', size = 30, decoration = OUTLINE, name = 'BookTablet'},
    ZoFontBookMetal  = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = 'BookMetal'},

    ZoFontBookPaperTitle  = {face = 'OpenSans - Bold', size = 30, decoration = NONE, name = 'PaperTitle'},
    ZoFontBookSkinTitle  = {face = 'OpenSans - Bold', size = 30, decoration = NONE, name = 'SkinTitle'},
    ZoFontBookRubbingTitle  = {face = 'OpenSans - Bold', size = 30, decoration = NONE, name = 'RubbingTitle'},
    ZoFontBookLetterTitle  = {face = 'OpenSans - Bold', size = 30, decoration = NONE, name = 'LetterTitle'},
    ZoFontBookNoteTitle  = {face = 'OpenSans - Bold', size = 32, decoration = NONE, name = 'NoteTitle'},
    ZoFontBookScrollTitle  = {face = 'OpenSans - Bold', size = 34, decoration = NONE, name = 'ScrollTitle'},
    ZoFontBookTabletTitle  = {face = 'OpenSans - Bold', size = 48, decoration = OUTLINE, name = 'TabletTitle '},
    ZoFontBookMetalTitle  = {face = 'OpenSans - Bold', size = 30, decoration = OUTLINE, name = 'MetalTitle'},

    -- GAMEPAD
    ZoFontGamepad61 = {face = 'OpenSans - Bold', size = 61, decoration = OUTLINE, name = '?'},
    ZoFontGamepad54 = {face = 'OpenSans - Bold', size = 54, decoration = OUTLINE, name = '?'},
    ZoFontGamepad45 = {face = 'OpenSans - Bold', size = 45, decoration = OUTLINE, name = '?'},
    ZoFontGamepad42 = {face = 'OpenSans - Bold', size = 42, decoration = OUTLINE, name = '?'},
    ZoFontGamepad36 = {face = 'OpenSans - Bold', size = 36, decoration = OUTLINE, name = '?'},
    ZoFontGamepad34 = {face = 'OpenSans - Bold', size = 34, decoration = OUTLINE, name = '?'},
    ZoFontGamepad27 = {face = 'OpenSans - Bold', size = 27, decoration = OUTLINE, name = '?'},
    ZoFontGamepad25 = {face = 'OpenSans - Bold', size = 25, decoration = OUTLINE, name = '?'},
    ZoFontGamepad22 = {face = 'OpenSans - Bold', size = 22, decoration = OUTLINE, name = '?'},
    ZoFontGamepad20 = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},
    ZoFontGamepad18 = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},

    ZoFontGamepad27NoShadow = {face = 'OpenSans - Bold', size = 27, decoration = NONE, name = '?'},
    ZoFontGamepad42NoShadow = {face = 'OpenSans - Bold', size = 42, decoration = NONE, name = '?'},

    ZoFontGamepad36ThickOutline = {face = 'OpenSans - Bold', size = 36, decoration = NONE, name = '?'},

    ZoFontGamepadCondensed61 = {face = 'OpenSans - Bold', size = 61, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed54 = {face = 'OpenSans - Bold', size = 54, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed45 = {face = 'OpenSans - Bold', size = 45, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed42 = {face = 'OpenSans - Bold', size = 42, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed36 = {face = 'OpenSans - Bold', size = 36, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed34 = {face = 'OpenSans - Bold', size = 34, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed27 = {face = 'OpenSans - Bold', size = 27, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed25 = {face = 'OpenSans - Bold', size = 25, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed22 = {face = 'OpenSans - Bold', size = 22, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed20 = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},
    ZoFontGamepadCondensed18 = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},

    ZoFontGamepadBold61 = {face = 'OpenSans - Bold', size = 61, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold54 = {face = 'OpenSans - Bold', size = 54, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold45 = {face = 'OpenSans - Bold', size = 45, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold42 = {face = 'OpenSans - Bold', size = 42, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold36 = {face = 'OpenSans - Bold', size = 36, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold34 = {face = 'OpenSans - Bold', size = 34, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold27 = {face = 'OpenSans - Bold', size = 27, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold25 = {face = 'OpenSans - Bold', size = 25, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold22 = {face = 'OpenSans - Bold', size = 22, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold20 = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBold18 = {face = 'OpenSans - Bold', size = 18, decoration = OUTLINE, name = '?'},

    ZoFontGamepadChat = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},
    ZoFontGamepadEditChat = {face = 'OpenSans - Bold', size = 20, decoration = OUTLINE, name = '?'},

    ZoFontGamepadBookPaper  = {face = 'OpenSans - Bold', size = 20, decoration = NONE, name = '?'},
    ZoFontGamepadBookSkin  = {face = 'OpenSans - Bold', size = 20, decoration = NONE, name = '?'},
    ZoFontGamepadBookRubbing  = {face = 'OpenSans - Bold', size = 20, decoration = NONE, name = '?'},
    ZoFontGamepadBookLetter  = {face = 'OpenSans - Bold', size = 20, decoration = NONE, name = '?'},
    ZoFontGamepadBookNote  = {face = 'OpenSans - Bold', size = 22, decoration = NONE, name = '?'},
    ZoFontGamepadBookScroll  = {face = 'OpenSans - Bold', size = 26, decoration = NONE, name = '?'},
    ZoFontGamepadBookTablet  = {face = 'OpenSans - Bold', size = 30, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBookMetal  = {face = 'OpenSans - Bold', size = 30, decoration = OUTLINE, name = '?'},

    ZoFontGamepadBookPaperTitle  = {face = 'OpenSans - Bold', size = 30, decoration = NONE, name = '?'},
    ZoFontGamepadBookSkinTitle  = {face = 'OpenSans - Bold', size = 30, decoration = NONE, name = '?'},
    ZoFontGamepadBookRubbingTitle  = {face = 'OpenSans - Bold', size = 30, decoration = NONE, name = '?'},
    ZoFontGamepadBookLetterTitle  = {face = 'OpenSans - Bold', size = 30, decoration = NONE, name = '?'},
    ZoFontGamepadBookNoteTitle  = {face = 'OpenSans - Bold', size = 32, decoration = NONE, name = '?'},
    ZoFontGamepadBookScrollTitle  = {face = 'OpenSans - Bold', size = 34, decoration = NONE, name = '?'},
    ZoFontGamepadBookTabletTitle  = {face = 'OpenSans - Bold', size = 48, decoration = OUTLINE, name = '?'},
    ZoFontGamepadBookMetalTitle  = {face = 'OpenSans - Bold', size = 40, decoration = OUTLINE, name = '?'},

    ZoFontGamepadHeaderDataValue = {face = 'OpenSans - Bold', size = 42, decoration = OUTLINE, name = '?'},

    ZoMarketGamepadCalloutFont = {face = 'OpenSans - Bold', size = 42, decoration = OUTLINE, name = '?'},
}

local logical = {}
local decorations = {
                        'none', 
                        'outline', 
                        'thin-outline', 
                        'thick-outline', 
                        'soft-shadow-thin', 
                        'soft-shadow-thick', 
                        'shadow'
                    }

function PawksicklesConfig:FormatFont(fontEntry)
    local str = '%s|%d'
    if (fontEntry.decoration ~= NONE) then
        str = str ..'|%s'
    end

    fontEntry.face = string.gsub(fontEntry.face, '^Futura Std Condensed', 'EsoUI/Common/Fonts/ESO_FWNTLGUDC70-DB.ttf', 1)

    return string.format(str, LMP:Fetch('font', fontEntry.face), fontEntry.size or 10, fontEntry.decoration, fontEntry.name)
end

function PawksicklesConfig:OnLoaded()
    self.db = ZO_SavedVars:NewAccountWide('PAWKSICKLES_DB', 1.0, nil, defaults)

    for k in pairs(defaults) do
        tinsert(logical, k)
    end

    tsort(logical)

    self.config_panel = LAM:RegisterAddonPanel(self._name, {
        type = panel,
        name = 'Pawksickles',
        displayName = ZO_HIGHLIGHT_TEXT:Colorize('Pawksickles'),
        author = "SkOODaT, Garkin, Pawkette",
        version = "2",
        slashCommand = "/pawksickles",
        registerForRefresh = true,
        registerForDefaults = true,
    })

    self:BeginAddingOptions()

    local UpdateHeaders
    UpdateHeaders = function(panel)
        if panel == self.config_panel then
            for i, gameFont in ipairs(logical) do
                local newFont = self:FormatFont(self.db[gameFont])
                self._headers[gameFont] = _G[self._name ..'_header_'.. i].header
                self._headers[gameFont]:SetFont(newFont)
            end
            CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", UpdateHeaders)
        end
    end
    CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", UpdateHeaders)
end

function PawksicklesConfig:BeginAddingOptions()
    local optionsData = {}

    for i, gameFont in ipairs(logical) do
        if (self.db[gameFont]) then
            CBM:FireCallbacks('PAWKSICKLES_FONT_CHANGED', gameFont, self:FormatFont(self.db[gameFont]))
            tinsert(optionsData, {
                type = 'header',
                name = defaults[gameFont].name..' ['..gameFont..']',
                reference = self._name ..'_header_'.. i,
                })
            tinsert(optionsData, {
                type = 'dropdown',
                name = 'Font:',
                choices = LMP:List('font'),
                getFunc = function() return self.db[gameFont].face end,
                setFunc = function(selection)  self:FontDropdownChanged(gameFont, selection) end,
                default = defaults[gameFont].face,
                })
            tinsert(optionsData, {
                type = 'slider',
                name = 'Size:',
                min = 5,
                max = 50,
                getFunc = function() return self.db[gameFont].size end,
                setFunc = function(size) self:SliderChanged(gameFont, size) end,
                default = defaults[gameFont].size,
                })
            tinsert(optionsData, {
                type = 'dropdown',
                name = 'Decoration:',
                choices = decorations,
                getFunc = function() return self.db[gameFont].decoration end,
                setFunc = function(selection) self:DecorationDropdownChanged(gameFont, selection) end,
                default = defaults[gameFont].decoration,
                })
        end
    end

    LAM:RegisterOptionControls(self._name, optionsData)
end

function PawksicklesConfig:FontDropdownChanged(gameFont, fontFace)
    self.db[gameFont].face = fontFace
    local newFont = self:FormatFont(self.db[gameFont])
    if (self._headers[gameFont]) then
        self._headers[gameFont]:SetFont(newFont)
    end

    CBM:FireCallbacks('PAWKSICKLES_FONT_CHANGED', gameFont, newFont)
end

function PawksicklesConfig:SliderChanged(gameFont, size)
    self.db[gameFont].size = size
    local newFont = self:FormatFont(self.db[gameFont])
    if (self._headers[gameFont]) then
        self._headers[gameFont]:SetFont(newFont)
    end

    CBM:FireCallbacks('PAWKSICKLES_FONT_CHANGED', gameFont, newFont)
end

function PawksicklesConfig:DecorationDropdownChanged(gameFont, decoration)
    self.db[gameFont].decoration = decoration
    local newFont = self:FormatFont(self.db[gameFont])
    if (self._headers[gameFont]) then
        self._headers[gameFont]:SetFont(newFont)
    end

    CBM:FireCallbacks('PAWKSICKLES_FONT_CHANGED', gameFont, newFont)
end

CBM:RegisterCallback('PAWKSICKLES_LOADED', function(...) PawksicklesConfig:OnLoaded(...) end)