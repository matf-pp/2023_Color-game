-- Import

local composer = require("composer")
local relayout = require("ColorUpAssets.libs.relayout")
local utilities = require("ColorUpAssets.classes.utilities")
local transition2 = require("ColorUpAssets.transition2")
local gc = require("ColorUpAssets.classes.helper_gamecenter")

-- Set variables

local lblTitle
local Rect1
local background

local theme = utilities:checkBackground()
if utilities:checkBackground() == "white" then
    theme = {1,1,1}
else
    theme = {0,0,0}
end



--Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

--Scene
local scene = composer.newScene()

--Groups
local _grpMain
local _grpConfetti

--Sounds
local _click = audio.loadStream("ColorUpAssets/assets/sounds/click.wav")

--Colors
local colors = {
    {255/255, 51/255, 51/255},     -- Red
    {255/255, 153/255, 51/255},    -- Orange
    {255/255, 255/255, 51/255},    -- Yellow
    {102/255, 204/255, 0/255},     -- Green
    {0/255, 102/255, 204/255},     -- Blue
    {153/255, 51/255, 204/255},    -- Purple
    {255/255, 51/255, 255/255},    -- Magenta
    {51/255, 204/255, 204/255}     -- Cyan
  }


-- Local functions

local function gotoGame1()
    utilities:playSound(_click)  
    composer.gotoScene("src.game1")
    print("scene:create -")
    _grpMain = display.newGroup()
end

local function gotoGame2()
     utilities:playSound(_click) 
     composer.gotoScene("src.game2alt")
     print("scene:create -")
     _grpMain = display.newGroup()
 end

 local function gotoSettings()

    utilities:playSound(_click)
    composer.gotoScene( "src.settings" )

    if utilities:checkBackground() == "white" then
        composer.gotoScene( "src.settings2" )
    else
        composer.gotoScene( "src.settings" ) 
    end
end

 local function gotoEasterEgg()

    utilities:playSound(_click)  

    Rect1.fill = colors[math.random(1,table.getn(colors)-1)]
    lblTitle.fill = colors[math.random(1,table.getn(colors)-1)]

    if Rect1.fill.r == lblTitle.fill.r and Rect1.fill.g == lblTitle.fill.g and Rect1.fill.b == lblTitle.fill.b then
        for i = 1, 200 do
            local leaf = display.newRoundedRect(_CX, _CY, 10, 10, 2)
            leaf.alpha = 0.3
            leaf.rotation = math.random(0, 360)
            _grpConfetti:insert(leaf)
        
            local colors = {{1,0,0},{0,1,0},{0,0,1},{1,1,0},{1,0,1},{0,0,0},{1,1,1}}
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
end

local function gotoInstructions()
    utilities:playSound(_click) 
     composer.gotoScene("src.instructions")
     _grpMain = display.newGroup()

end

local function gotoLeaderboards()
    utilities:playSound(_click) 
    composer.gotoScene("src.leaderboards")
    _grpMain = display.newGroup()
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
    background.alpha = 0.9

    _grpConfetti = display.newGroup()
    _grpMain:insert(_grpConfetti)

    lblTitle = display.newText("Color Game", _CX, 60, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf",60)
    lblTitle.fill = theme
    _grpMain:insert(lblTitle)

    local btnPlay1 = display.newRoundedRect(_grpMain, _CX, _CY-90, 240, 50,20)
    btnPlay1.fill = theme
    btnPlay1.alpha = 0.4;

    local lblPlay1 = display.newText("Play - mode 1", _CX, _CY-90, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    lblPlay1.fill = theme
    _grpMain:insert(lblPlay1)

    btnPlay1:addEventListener("tap", gotoGame1)  

    local btnPlay2 = display.newRoundedRect(_grpMain, _CX, _CY-20, 240, 50,20)
    btnPlay2.fill = theme
    btnPlay2.alpha = 0.4;

    local lblPlay2 = display.newText("Play - mode 2", _CX, _CY-20, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    lblPlay2.fill = theme
    _grpMain:insert(lblPlay2)

    btnPlay2:addEventListener("tap", gotoGame2) 

    Rect1 = display.newRoundedRect(_grpMain, _CX, _CY+50, 240, 50,20)
    Rect1.fill = colors[math.random(1,table.getn(colors))]
    

    local lblIndex = display.newText("187/83/63", _CX, _CY+50, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    lblIndex.fill = theme
    _grpMain:insert(lblIndex)


    Rect1:addEventListener("tap", gotoEasterEgg)

    local lblInstructions = display.newText("Kako?", _CX-100, _H-60, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 35)
    lblInstructions.fill = theme
    _grpMain:insert(lblInstructions)
    lblInstructions:addEventListener("tap", gotoInstructions) 
    
    local lblSettings = display.newText("Podesavanja", _CX+80, _H-60, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 35)
    lblSettings.fill = theme
    _grpMain:insert(lblSettings)

    lblSettings:addEventListener("tap", gotoSettings) 

    local btnLeaderboards = display.newRoundedRect(_grpMain, _CX, _CY+120, 240, 50,20)
    btnLeaderboards.fill = theme
    btnLeaderboards.alpha = 0.4;

    local lblLeaderboards = display.newText("Leaderboard", _CX, _CY+120, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
    lblLeaderboards.fill = theme 
    _grpMain:insert(lblLeaderboards)

    lblLeaderboards:addEventListener("tap", gotoLeaderboards)
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

