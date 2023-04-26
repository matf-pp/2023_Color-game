--
-- Import

local composer = require("composer")
local relayout = require("ColorUpAssets.libs.relayout")
local utilities = require("classes.utilities")


--
-- Set variables

-- Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY 

-- Scene
local scene = composer.newScene()

-- Groups
local _grpMain

-- Sounds
local _click = audio.loadStream("ColorUpAssets/assets/sounds/loop1.mp3")

-- Buttons
local _lblSoundsButton
local _lblMusicButton


--
-- Local functions

local function gotoMenu()

    utilities:playSound(_sndClick)

    composer.gotoScene("scenes.menu")
end

local function toggleSounds()

    utilities:toggleSounds()

    _lblSoundsButton.text = utilities:checkSounds()
end

local function toggleMusic()

    utilities:toggleMusic()

    _lblMusicButton.text = utilities:checkMusic()

    if utilities:checkMusic() == "On" then
        local music = audio.loadStream("assets/sounds/loop1.mp3")
        utilities:playMusic(music)
    else
        audio.stop()
    end
end


--
-- Scene events functions

function scene:create( event )

    print("scene:create - settings")

    _grpMain = display.newGroup()

    self.view:insert(_grpMain)

    --

    -- Background
    local background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/white-crumpled-paper-texture-background_64749-1843.png", _W, _H)
    background.x = _CX
    background.y = _CY

    -- Title
    local title = display.newText("Settings", _CX, 100, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    title.fill = {0,0,0}
    _grpMain:insert(title)

    -- Sound title and button
    local lblSoundsTitle = display.newText("Sounds", _CX - 80, _CY - 50, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 35)
    lblSoundsTitle.fill = {0,0,0}
    _grpMain:insert(lblSoundsTitle)

    _lblSoundsButton = display.newText(utilities:checkSounds(), _CX - 80, _CY, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 45)
    _lblSoundsButton.fill = {0,0,0}
    _grpMain:insert(_lblSoundsButton)

    _lblSoundsButton:addEventListener("tap", toggleSounds)

    -- Music title and button
    local lblMusicTitle = display.newText("Music", _CX + 80, _CY - 50, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 35)
    lblMusicTitle.fill = {0,0,0}
    _grpMain:insert(lblMusicTitle)

    _lblMusicButton = display.newText(utilities:checkMusic(), _CX + 80, _CY, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 45)
    _lblMusicButton.fill = {0,0,0}
    _grpMain:insert(_lblMusicButton)

    _lblMusicButton:addEventListener("tap", toggleMusic)

    -- Close button
    local lblBack = display.newText("Back", _CX+100, _H-80, "ColorUpAssets/assets/fonts/OpenDyslexic-Regular.otf", 26)
    lblBack.fill = {0,0,0}
    _grpMain:insert(lblBack)
    lblBack:addEventListener("tap", gotoMenu)
end

function scene:show( event )

    if ( event.phase == "will" ) then
    elseif ( event.phase == "did" ) then
    end
end

function scene:hide( event )

    if ( event.phase == "will" ) then
    elseif ( event.phase == "did" ) then
    end
end

function scene:destroy( event )

    if ( event.phase == "will" ) then
    elseif ( event.phase == "did" ) then
    end
end


--
-- Scene event listeners

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene