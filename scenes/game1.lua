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

--Boje
local colors = {"crvena","zelena", "plava","zuta", "ljubicasta", "braon", "narandzasta", "bela", "crna"}

local clrRed =    {1, 51/255, 51/255}       
local clrGreen =  {102/255, 204/255, 0}     
local clrBlue =   {0, 102/255, 204/255}      
local clrYellow = {1, 1, 51/255}
local clrPurple = {153/255, 51/255, 204/255}
local clrBrown =  {150/255, 75/255, 0}
local clrOrange = {1, 153/255, 51/255}
local clrWhite =  {1, 1, 1}
local clrBlack =  {0, 0, 0}

local colorsArray = {clrRed, clrGreen, clrBlue, clrYellow, clrPurple, clrBrown, clrOrange, clrWhite, clrBlack}


local _lblTapToStart = ""

-- Local functions

local SP1 = {}
local gotoSP1 = {}


function SP1()

  _lblTapToStart.alpha = 0

  local tablesGroup = display.newGroup()

  local randomNumber1 = math.random(1,table.getn(colors)-1)
  local randomColor = colors[randomNumber1]
  local randomNumber2 = math.random(1,table.getn(colorsArray)-1)

  local tableRect = display.newRect(tablesGroup, 0, 100, 250, 80)
  tableRect:setFillColor(0,0,0)
  local tableText = display.newText(tablesGroup, randomColor, 0, 100, native.systemFont, 36)
  local fillStr = colorsArray[randomNumber2]
  tableText:setFillColor(fillStr[1], fillStr[2], fillStr[3])

  tableRect:addEventListener("tap", SP1)

  tablesGroup.x = _CX
  tablesGroup.y = _CY - _CY/2;
  _grpMain:insert(tablesGroup)
end

local function gotoSP1()
  SP1()
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


    _lblTapToStart = display.newText("Tap to start", _CX, _CY, "assets/fonts/Galada.ttf", 46)
    _lblTapToStart.fill = theme
    _grpMain:insert(_lblTapToStart)
    _lblTapToStart.x = _CX
    _lblTapToStart.y = _CY


    _lblTapToStart:addEventListener("tap", gotoSP1)  --gotoSP1 nije spremljeno jos

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