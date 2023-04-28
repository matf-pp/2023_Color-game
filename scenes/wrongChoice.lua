-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")

-- Set variables

--Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

local background


local theme = utilities:checkBackground()
if utilities:checkBackground() == "white" then
    theme = {1,1,1}
else
    theme = {0,0,0}
end




--Scene
local scene = composer.newScene()

--Groups
local _grpMain

--Sounds
local _click = audio.loadStream("assets/sounds/click.wav")


-- Local functions
local function gotoPlayAgain()
    utilities:playSound(_click) 
    composer.gotoScene("scenes.game2")
    print("scene:create -")
   -- _grpMain = display.newGroup()
end

local function gotoMainMenu()
    utilities:playSound(_click) 
    composer.gotoScene("scenes.menu")
    print("scene:create -")
   -- _grpMain = display.newGroup()
end


-- Scene events functions

function scene:create(event)
    print("scene:create - menu")
    _grpMain = display.newGroup()

    self.view:insert(_grpMain)

    if utilities:checkBackground() == "white" then
      background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/black.png", _W, _H)
    else
        background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/white.png", _W, _H)
    end

    background.x = _CX
    background.y = _CY

    --Message
    local _lblMessage = display.newText("Wrong choice!", _CX, _CY, "assets/fonts/Galada.ttf", 46)
    _lblMessage.fill = theme
    _grpMain:insert(_lblMessage)
    _lblMessage.x = _CX
    _lblMessage.y = _CY

    --Play again
    local btnPlayAgain = display.newRoundedRect(_grpMain, _CX, _CY-100, 240, 50,20)
    btnPlayAgain.fill = theme
    btnPlayAgain.alpha = 0.4;
    _grpMain:insert(btnPlayAgain)

    local lblPlayAgain = display.newText("Mode 1", _CX, _CY-100, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    lblPlayAgain.fill = theme
    _grpMain:insert(lblPlayAgain)

    btnPlayAgain:addEventListener("tap", gotoPlayAgain)


    --Main menu
    local btnMainMenu = display.newRoundedRect(_grpMain, _CX, _CY, 240, 50,20)
    btnMainMenu.fill = theme
    btnMainMenu.alpha = 0.4;

    local lblMainMenu = display.newText("Mode 2", _CX, _CY+3, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    lblMainMenu.fill = theme
    _grpMain:insert(lblMainMenu)

    btnMainMenu:addEventListener("tap", gotoMainMenu)


end

function scene:show(event)
    if(event.phase == "will") then
    elseif(event.phase == "did") then 
    end
end

function scene:hide(event)
    if(event.phase == "will") then
    elseif(event.phase == "did") then 
    end
end

function scene:destroy(event)
    if(event.phase == "will") then
    elseif(event.phase == "did") then 
    end
end
    

--Scene event listeners

scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)
    
return scene

