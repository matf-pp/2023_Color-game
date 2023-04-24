-- Import

local composer = require("composer")
local relayout = require("ColorUpAssets.libs.relayout")
local utilities = require("classes.utilities")

-- Set variables

--Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

--Scene
local scene = composer.newScene()

--Groups
local _grpMain

--Sounds
local _click = audio.loadStream("assets/sounds/click.wav")


-- Local functions

local function gotoGame1()
   -- utilities:playSound(_click) -- ovo nece da radi jer nece da ucita GGData u utilities.lua
    --composer.gotoScene("scenes.game")
    _grpMain = display.newGroup()

    local lblTitle = display.newText("ColorUp", _CX, 100, "ColorUpAssets/assets/fonts/Galada.ttf",76)
    lblTitle.fill = {1,1,1}
    _grpMain:insert(lblTitle)
end



-- Scene events functions

function scene:create(event)
    print("scene:create - menu")
    _grpMain = display.newGroup()

    self.view:insert(_grpMain)

    local background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/background.png", _W, _H)
    background.x = _CX
    background.y = _CY

    local lblTitle = display.newText("ColorUp", _CX, 100, "ColorUpAssets/assets/fonts/Galada.ttf",76)
    lblTitle.fill = {1,1,1}
    _grpMain:insert(lblTitle)

    local btnPlay1 = display.newRoundedRect(_grpMain, _CX, _CY, 220, 80,20)
    btnPlay1.fill = {1,1,1}
    btnPlay1.alpha = 0.4;

    local lblPlay1 = display.newText("Play - mode 1", _CX, _CY + 4, "ColorUpAssets/assets/fonts/Galada.ttf", 50)
    lblPlay1.fill = {0,0,0}
    _grpMain:insert(lblPlay1)

    btnPlay1:addEventListener("tap", gotoGame1)

    local btnPlay2 = display.newRoundedRect(_grpMain, _CX, _CY, 220, 80,20)
    btnPlay2.fill = {1,1,1}
    btnPlay2.alpha = 0.4;

    local lblPlay2 = display.newText("Play - mode 2", _CX, _H - 80, "ColorUpAssets/assets/fonts/Galada.ttf", 50)
    lblPlay2.fill = {0,0,0}
    _grpMain:insert(lblPlay2)

    btnPlay2:addEventListener("tap", gotoGame2)
    
    local lblSettings = display.newText("Settings", _CX, _H - 40, "ColorUpAssets/assets/fonts/Galada.ttf", 26)
    lblSettings.fill = {1,1,1}
    _grpMain:insert(lblSettings)

    --lblSettings:addEventListener("tap", gotoSettings)

    local lblLeaderBoards = display.newText("Leaderboards", _CX, _H - 100, "ColorUpAssets/assets/fonts/Galada.ttf",26)
    lblLeaderBoards.fill = {1,1,1}
    _grpMain:insert(lblLeaderBoards)

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

