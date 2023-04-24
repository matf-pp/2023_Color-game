--drugari ovo je skelet za vas deo

-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
--local utilities = require("classes.utilities") --jer utilities ne rade

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

    print("scene:create - game")  -- ovo se ispisuje u konzoli
    _grpMain = display.newGroup()

    local lblSettings = display.newText("izvolte luka", _CX, _H - 40, "ColorUpAssets/assets/fonts/Galada.ttf", 26)
    lblSettings.fill = {1,1,1}
    _grpMain:insert(lblSettings)

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

