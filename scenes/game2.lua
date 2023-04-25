
-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
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



-- Scene events functions

function scene:create(event)
    print("scene:create - menu")
    _grpMain = display.newGroup()

    self.view:insert(_grpMain)

    local btnPlay1 = display.newRoundedRect(_grpMain, _CX, _CY-100, 280, 80,20)
    btnPlay1.fill = {1,1,1}
    btnPlay1.alpha = 0.4;

    local lblPlay1 = display.newText("Single player", _CX, _CY-97, "ColorUpAssets/assets/fonts/Galada.ttf", 50)
    lblPlay1.fill = {0,0,0}
    _grpMain:insert(lblPlay1)

  --  btnPlay1:addEventListener("tap", gotoSP2)  --gotoSP2 nije spremljeno jos

    local btnPlay2 = display.newRoundedRect(_grpMain, _CX, _CY, 280, 80,20)
    btnPlay2.fill = {1,1,1}
    btnPlay2.alpha = 0.4;

    local lblPlay2 = display.newText("Dual player", _CX, _CY+3, "ColorUpAssets/assets/fonts/Galada.ttf", 50)
    lblPlay2.fill = {0,0,0}
    _grpMain:insert(lblPlay2)

  --  btnPlay2:addEventListener("tap", gotoDP2)  --gotoDP2 nije spremljeno jos
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

