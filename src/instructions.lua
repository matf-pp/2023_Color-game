-- Import

local composer = require("composer")
local relayout = require("ColorUpAssets.libs.relayout")
local utilities = require("ColorUpAssets.classes.utilities")

-- Set variables

local background

--Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

local theme = utilities:checkBackground()
local slova = {0,0,0}
if utilities:checkBackground() == "white" then
    theme = {1,1,1}
    slova = {0,0,0}
else
    theme = {0,0,0}
    slova = {1,1,1}
end


--Scene
local scene = composer.newScene()

--Groups
local _grpMain

--Sounds
local _click = audio.loadStream("ColorUpAssets/assets/sounds/click.wav")


-- Local functions

local function gotoMenu()
    utilities:playSound(_click) 
     composer.gotoScene("src.menu") --src.game2 je ono sto treba da se uradi
     _grpMain = display.newGroup()

end




-- Scene events functions

function scene:create(event)
    print("scene:create - menu")
    _grpMain = display.newGroup()

    if utilities:checkBackground() == "white" then
        background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/black.png", _W, _H)
    else
        background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/white.png", _W, _H)
    end
    background.x = _CX
    background.y = _CY
    background.alpha = 0.9

    local rect = display.newRoundedRect(_grpMain, _CX, _CY-30, 300, 400,20)
    rect.fill = theme
    rect.alpha = 0.4;
    rect.strokeWidth = 4 
    rect.stroke = slova

    local lblPlay1 = display.newText("Kako igrati nasu igru? \n" ..
                                     "Mode 1: \n" ..
                                     "Na ekranu ce se pojaviti \n" ..
                                     "rec u nekoj odredjenoj \n" ..
                                     "boji. Vas zadatak je da \n" ..
                                     "kliknete rec kada se njeno \n" ..
                                     "znacenje i boja poklope.\n"..
                                     "Mode 2: \n" ..
                                     "Ovog puta, na ekranu cete \n"..
                                     "imati vise ponudjenih \n"..
                                     "odgovora. Sto brze izaberite\n"..
                                     "onaj pravi.", _CX, _CY-30, "ColorUpAssets/assets/fonts/OpenDyslexic-Regular.otf", 18)
    lblPlay1.fill = theme
    _grpMain:insert(lblPlay1)

    local lblBack = display.newText("Nazad", _CX+100, _H-80, "ColorUpAssets/assets/fonts/OpenDyslexic-Regular.otf", 26)
    lblBack.fill = theme
    _grpMain:insert(lblBack)
    lblBack:addEventListener("tap", gotoMenu)


    self.view:insert(_grpMain)
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

