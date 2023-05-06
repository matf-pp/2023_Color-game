-- Import

local composer = require("composer")
local relayout = require("ColorUpAssets.libs.relayout")
local utilities = require("ColorUpAssets.classes.utilities")

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
local _click = audio.loadStream("ColorUpAssets/assets/sounds/click.wav")


-- Local functions
local function gotoPlayAgain()
    utilities:playSound(_click) 
    composer.gotoScene("src.game2")
    print("scene:create -")
end

local function gotoMainMenu()
    utilities:playSound(_click) 
    composer.gotoScene("src.menu")
    print("scene:create -")
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
    local _lblMessage = display.newText("Wrong choice!", _CX, _CY - 100, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
    _lblMessage.fill = {1, 51/255, 51/255}
    _grpMain:insert(_lblMessage)

    --Score
    local _lblMessage = display.newText("Score = ", _CX - 20, _CY, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
    _lblMessage.fill = theme
    local score = composer.getVariable("score")
    score = math.log(score) / math.log(2) --treba logaritmovati sa osnovom 2 da bi se dobio pravi broj
    local _scoreStr = display.newText(score, _CX + 80, _CY, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
    _scoreStr.fill = theme
    _grpMain:insert(_lblMessage)
    _grpMain:insert(_scoreStr)

    --Play again
    local btnPlayAgain = display.newRoundedRect(_grpMain, _CX - 80, _CY + 100, 140, 60,20)
    btnPlayAgain.fill = theme
    btnPlayAgain.alpha = 0.4;
    _grpMain:insert(btnPlayAgain)

    local lblPlayAgain = display.newText("Play again", _CX - 80, _CY + 100, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    lblPlayAgain.fill = theme
    _grpMain:insert(lblPlayAgain)

    btnPlayAgain:addEventListener("tap", gotoPlayAgain)


    --Main menu
    local btnMainMenu = display.newRoundedRect(_grpMain, _CX + 80, _CY + 100, 140, 60,20)
    btnMainMenu.fill = theme
    btnMainMenu.alpha = 0.4;

    local lblMainMenu = display.newText("Main menu", _CX + 80, _CY + 100, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
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

