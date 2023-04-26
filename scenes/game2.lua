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


-- Local functions
local function SP2()
    local tablesGroup = display.newGroup()

    let randomColor = colors[math.random(1,table.getn(colors)-1)]

    local tableRect = display.newRect(tablesGroup, 0, i*100, 200, 80)
    tableRect:setFillColor(0.5, 0.5, 0.5)
    local tableText = display.newText(tablesGroup, randomColor, 0, i*100, native.systemFont, 36)
    tableText:setFillColor(1, 1, 1)

    tablesGroup.x = _CX - tablesGroup.width/2
    _grpMain:insert(tablesGroup)
end

local function DP2()
  local tablesGroup = display.newGroup()

  for i=1,#colors do
      local tableRect = display.newRect(tablesGroup, 0, i*100, 200, 80)
      tableRect:setFillColor(0.5, 0.5, 0.5)
      local tableText = display.newText(tablesGroup, colors[i], 0, i*100, native.systemFont, 36)
      tableText:setFillColor(1, 1, 1)
  end

  tablesGroup.x = _CX - tablesGroup.width/2
  _grpMain:insert(tablesGroup)
end

local function gotoSP2()
  SP2()
end

local function gotoDP2()
  DP2()
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

