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

local function gotoMenu()
    utilities:playSound(_click) 
     composer.gotoScene("scenes.menu") --scenes.game2 je ono sto treba da se uradi
     _grpMain = display.newGroup()

end




-- Scene events functions

function scene:create(event)
    print("scene:create - menu")
    _grpMain = display.newGroup()

    local background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/white-crumpled-paper-texture-background_64749-1843.png", _W, _H)
    background.x = _CX
    background.y = _CY
    background.alpha = 0.9

    local rect = display.newRoundedRect(_grpMain, _CX, _CY-30, 300, 400,20)
    rect.fill = {1,1,1}
    rect.alpha = 0.4;
    rect.strokeWidth = 4 
    rect.stroke = {0, 0, 0}

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
    lblPlay1.fill = {0,0,0}
    _grpMain:insert(lblPlay1)

    local lblBack = display.newText("Back", _CX+100, _H-80, "ColorUpAssets/assets/fonts/OpenDyslexic-Regular.otf", 26)
    lblBack.fill = {0,0,0}
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

