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

-- Local functions
local function SP2()
  local tablesGroup = display.newGroup()

  --nasumicno izaberi boju
  local randomNumber1 = math.random(1,table.getn(colors)-1)
  local randomColor = colors[randomNumber1]
  local randomNumber2 = math.random(1,table.getn(colorsArray)-1)

  --promeni boju pozadine
  -- local background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/Gray-background.jpeg", _W, _H)
  -- background.x = _CX
  -- background.y = _CY
  -- background.alpha = 0.9

  --prikazi boju koju korisnik treba izabrati medju ponudjenim
  local tableRect = display.newRect(tablesGroup, 150, 40, 180, 80)
  tableRect:setFillColor(0.5, 0.5, 0.5)
  local tableText = display.newText(tablesGroup, colors[7], 150, 40, native.systemFont, 24)
  local fillStr = colorsArray[randomNumber2]
  tableText:setFillColor(fillStr[1], fillStr[2], fillStr[3])


  --prikazi cetiri ponudjene boje od kojih je jedna tacna
  --1
  local tableRect = display.newRect(tablesGroup, 50, 300, 120, 80)
  tableRect:setFillColor(0.5, 0.5, 0.5)
  local tableText = display.newText(tablesGroup, colors[1], 50, 300, native.systemFont, 24)
  tableText:setFillColor(1, 1, 1)

  --2 fiksiramo pravu boju na drugo mesto, pri cemu postoji mogucnost da je neka od ostalih opcija pokupi
  local tableRect = display.newRect(tablesGroup, 210, 300, 120, 80)
  tableRect:setFillColor(0.5, 0.5, 0.5)
  local tableText = display.newText(tablesGroup, randomColor, 210, 300, native.systemFont, 24)
  tableText:setFillColor(1, 1, 1)

  --3
  local tableRect = display.newRect(tablesGroup, 50, 400, 120, 80)
  tableRect:setFillColor(0.5, 0.5, 0.5)
  local tableText = display.newText(tablesGroup, colors[3], 50, 400, native.systemFont, 24)
  tableText:setFillColor(1, 1, 1)

  --4
  local tableRect = display.newRect(tablesGroup, 210, 400, 120, 80)
  tableRect:setFillColor(0.5, 0.5, 0.5)
  local tableText = display.newText(tablesGroup, colors[4], 210, 400, native.systemFont, 24)
  tableText:setFillColor(1, 1, 1)

  tablesGroup.x = _CX - tablesGroup.width/2
  _grpMain:insert(tablesGroup)
end

local function gotoSP2()
  SP2()
end


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

    btnPlay1:addEventListener("tap", gotoSP2)
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

