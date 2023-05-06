-- Import

local composer = require("composer")
local relayout = require("ColorUpAssets.libs.relayout")
local utilities = require("ColorUpAssets.classes.utilities")

-- Set variables
local highscoreList = {}
local X1 = 80
local X2 = 160
local Y_offset = 50

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
local function gotoMainMenu()
    utilities:playSound(_click) 
    composer.gotoScene("src.menu")
    print("scene:create -")
end

local function compare( a, b )
    return a > b  --results in descending order
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
    local _lblMessage = display.newText("Leaderboard", _CX, 70, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
    _lblMessage.fill = {51/255, 204/255, 204/255}
    _grpMain:insert(_lblMessage)

    --Highscores
    local currentHighscore = composer.getVariable("currentHighscore")

    --if currentHighscore doesnt exist, set it to 0
    if currentHighscore == nil then
        currentHighscore = 0
    end

    table.insert(highscoreList, currentHighscore)
    table.sort(highscoreList, compare)

    if #highscoreList > 1 then
        --display highscores in descending order
        for i=1, #highscoreList do
            --display the current index (i)
            local lblNum = display.newText(i, X1, 150 - (i-1)*Y_offset, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
            lblNum.fill = theme
            local lblPoint = display.newText(".", X1 + 5, 150 - (i-1)*Y_offset, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
            lblPoint.fill = theme

            --display the highscore
            local lblScore = display.newText(highscoreList[i], X2, 150 - (i-1)*Y_offset, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
            lblScore.fill = theme

            _grpMain:insert(lblNum)
            _grpMain:insert(lblPoint)
            _grpMain:insert(lblScore)
        end
    else
        local lblNum = display.newText(1, X1 + 50, _CY - 50, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
        lblNum.fill = theme
        local lblPoint = display.newText(".", X1 + 65, _CY - 50, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
        lblPoint.fill = theme

        local lblScore = display.newText(currentHighscore, X2 + 50, _CY - 50, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
        lblScore.fill = theme

        _grpMain:insert(lblNum)
        _grpMain:insert(lblPoint)
        _grpMain:insert(lblScore)
    end

    --Main menu
    local btnMainMenu = display.newRoundedRect(_grpMain, _CX, _CY+120, 240, 50,20)
    btnMainMenu.fill = theme
    btnMainMenu.alpha = 0.4;

    local lblMainMenu = display.newText("Main menu", _CX, _CY + 120, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
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

