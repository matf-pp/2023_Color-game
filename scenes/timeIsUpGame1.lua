-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")
local transition2 = require("transition2")

local gc = require("classes.helper_gamecenter")

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
local _grpConfetti
local _grpContent

--Sounds
local _click = audio.loadStream("ColorUpAssets/assets/sounds/click.wav")
local timeisup = audio.loadStream("ColorUpAssets/assets/sounds/timeisup.mp3")
local fanfare = audio.loadStream("ColorUpAssets/assets/sounds/fanfare.mp3")

-- Local functions
local function gotoPlayAgain()
    utilities:playSound(_click) 
    composer.gotoScene("scenes.game1")
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

    utilities:playSound(timeisup)



    self.view:insert(_grpMain)

    -- --resetujemo progress bar na 0
    -- local progress_bar = composer.getVariable("progress_bar")
    -- progress_bar.width = 0

    _grpConfetti = display.newGroup()
    _grpMain:insert(_grpConfetti)

    _grpContent = display.newGroup()
    _grpMain:insert(_grpContent)


    if utilities:checkBackground() == "white" then
      background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/black.png", _W, _H)
    else
        background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/white.png", _W, _H)
    end

    background.x = _CX
    background.y = _CY

    --Message
    local _lblMessage = display.newText("Vreme je isteklo!", _CX, _CY - 100, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 45)
    _lblMessage.fill = {1, 51/255, 51/255}
    _grpMain:insert(_lblMessage)

    --
    local score = composer.getVariable("number")
    utilities:setTmpScore(score)

    local isHighscore = utilities:setHighscore(utilities:getTmpScore())

    local lblScore = display.newText("Score: " .. utilities:getTmpScore(), _CX, _CY - 35, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 35)
    lblScore.fill = theme
    _grpMain:insert(lblScore)

    local lblCurrentHighscore = display.newText("Highscore: " .. utilities:getHighscore(), _CX, _CY - 5, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 30)
    lblCurrentHighscore.fill = theme
    _grpMain:insert(lblCurrentHighscore)

    --

    if isHighscore then
        utilities:playSound(fanfare)
        local lblHighscore = display.newText("HIGHSCORE!", _CX, _CY - 200, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
        lblHighscore.fill = theme
        _grpMain:insert(lblHighscore)

        transition.to(lblHighscore, {time=200, xScale=1.5, yScale=1.5})
        transition.to(lblHighscore, {time=200, xScale=1, yScale=1, delay=200})
        transition.to(lblHighscore, {time=200, xScale=1.5, yScale=1.5, delay=400})
        transition.to(lblHighscore, {time=200, xScale=1, yScale=1, delay=600})
        transition.to(lblHighscore, {time=200, xScale=1.5, yScale=1.5, delay=800})
        transition.to(lblHighscore, {time=200, xScale=1, yScale=1, delay=1000})


        for i = 1, 200 do
            local leaf = display.newRoundedRect(_CX, _CY, 10, 10, 2)
            leaf.alpha = 0
            leaf.rotation = math.random(0, 360)
            _grpMain:insert(leaf)
           
            local colors = {
                { 209/255, 42/255, 95/255 },
                { 122/255, 184/255, 79/255 },
                { 77/255, 157/255, 191/255 },
                { 201/255, 201/255, 85/255 }
            }
            leaf:setFillColor(unpack(colors[math.random(1,#colors)]))
    
            transition.to(leaf, {math.random(300, 1860), y=leaf.y - math.random(100, 200), x=math.random(_CX - 150, _CX + 150), alpha=1, transition=easing.inOutQuad, onComplete=function()
                transition2.fallingLeaf(leaf, {
                    delay = 0,
                    speed = 0.25,
                    verticalIntensity = 0.7,
                    horizontalIntensity = 0.5,
                    rotationIntensity = 0.25,
                    horizontalDirection = "random",
                    randomness = 0.75,
                    zRotateParams = {
                        shadingDarknessIntensity = 0.5,
                        shadingBrightnessIntensity = 0.25,
                    },
                    cancelWhen = function()
                        return (not leaf.y) or (leaf.y > display.contentHeight + 100)
                    end,
                    onComplete = function(target)
                        target:removeSelf()
                    end,
                })
            end})
        end
    end

    --

    -- Send score to game center
    gc:submitScore(utilities:getTmpScore()) 


    --Score
    --[[local _lblMessage = display.newText("Score = ", _CX - 10, _CY, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 46)
    _lblMessage.fill = theme
    local score = composer.getVariable("number")
    utilities:setTmpScore(score)
    --score = math.log(score) / math.log(2) --treba logaritmovati sa osnovom 2 da bi se dobio pravi broj
    local _scoreStr = display.newText(score, _CX + 90, _CY, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 46)
    _scoreStr.fill = theme
    _grpMain:insert(_lblMessage)
    _grpMain:insert(_scoreStr)]]

    --Play again
    local btnPlayAgain = display.newRoundedRect(_grpMain, _CX - 80, _CY + 130, 140, 60,20)
    btnPlayAgain.fill = theme
    btnPlayAgain.alpha = 0.4;
    _grpMain:insert(btnPlayAgain)

    local lblPlayAgain = display.newText("Play again", _CX - 80, _CY + 130, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    lblPlayAgain.fill = theme
    _grpMain:insert(lblPlayAgain)

    btnPlayAgain:addEventListener("tap", gotoPlayAgain)

    --Leaderbords
    local lblLeaderboards = display.newText("Leaderboards", _CX, _H - 40, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 26)
    lblLeaderboards.fill = theme
    _grpMain:insert(lblLeaderboards)

    lblLeaderboards:addEventListener("tap", function()
        gc:openLeaderboard()
    end)


    --Main menu
    local btnMainMenu = display.newRoundedRect(_grpMain, _CX + 80, _CY + 130, 140, 60,20)
    btnMainMenu.fill = theme
    btnMainMenu.alpha = 0.4;

    local lblMainMenu = display.newText("Main menu", _CX + 80, _CY + 130, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
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

