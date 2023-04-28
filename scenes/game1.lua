-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")

-- Set variables

--Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY
local background
local duration = 5

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
local start_time = system.getTimer()
local progress_bar

local Score
local numberStr
local number = 0
local randomNumber1
local randomNumber2
local randomColor
local fillStr
local tablesGroup

local function on_table_tap()
  if((randomColor=="crvena" and fillStr==clrRed) or 
     (randomColor=="zelena" and fillStr==clrGreen) or
     (randomColor=="plava" and fillStr==clrBlue) or
     (randomColor=="zuta" and fillStr==clrYellow) or
     (randomColor=="ljubicasta" and fillStr==clrPurple) or
     (randomColor=="braon" and fillStr==clrBrown) or
     (randomColor=="narandzasta" and fillStr==clrOrange) or
     (randomColor=="bela" and fillStr==clrWhite) or
     (randomColor=="crna" and fillStr==clrBlack)) then
    number = number + 1
  end
  numberStr.text = number
  tablesGroup:removeSelf()
end

-- Local functions

local SP1 = {}
local gotoSP1 = {}

local function calculate_progress()   -- as a percentage
  return (system.getTimer() - start_time) -- duration
end

local function update_progress_bar(time_passed, total_time)
  local progress = time_passed / total_time
  progress_bar.width = progress * 2*display.contentWidth
  progress_bar.x = 0
end

function SP1()

  _lblTapToStart.alpha = 0

  tablesGroup = display.newGroup()

  local start_time = os.time() -- record the start time
  local total_time = 5 -- set the total time for the timer in seconds
  local elapsed_time = 0 -- initialize the elapsed time to zero

  local function on_enter_frame()
      local elapsed_time = os.time() - start_time -- calculate the elapsed time
      if elapsed_time >= total_time then
          -- the timer is finished
          print("Timer complete!")
          progress_bar.width = 0 -- set the progress bar width to 0
          Runtime:removeEventListener("enterFrame", on_enter_frame)
      else
          local progress = elapsed_time / total_time -- calculate progress as a fraction between 0 and 1
          local max_width = 2*display.contentWidth -- set the maximum width of the progress bar
          local min_width = 0 -- set the minimum width of the progress bar

          -- calculate the current width of the progress bar as a function of the progress
          local current_width = max_width - (max_width - min_width) * progress

          -- update the width of the progress bar
          progress_bar.width = current_width
      end
  end

  Runtime:addEventListener("enterFrame", on_enter_frame)

  randomNumber1 = math.random(1,table.getn(colors)-1)
  randomColor = colors[randomNumber1]
  randomNumber2 = math.random(1,table.getn(colorsArray)-1)

  Score = display.newText(tablesGroup, "Score: ", 0, -100, native.systemFont, 30)
  Score:setFillColor(0, 0, 0)
  numberStr = display.newText(tablesGroup, number, 70, -100, native.systemFont, 30)
  numberStr:setFillColor(0, 0, 0)

  local tableRect = display.newRect(tablesGroup, 0, 100, 250, 80)
  tableRect.fill = theme
  local tableText = display.newText(tablesGroup, randomColor, 0, 100, native.systemFont, 36)
  fillStr = colorsArray[randomNumber2]
  tableText:setFillColor(fillStr[1], fillStr[2], fillStr[3])

  tableRect:addEventListener("tap", on_table_tap)
  tableRect:addEventListener("tap", SP1)

  progress_bar.x = 0   --ovo je da bi sredina timer-bara bila na levoj ivici
  progress_bar.y = _CY + _CY/2

  tablesGroup.x = _CX
  tablesGroup.y = _CY - _CY/2
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

    progress_bar = display.newRect(display.contentCenterX, display.contentCenterY, 2*display.contentWidth, 20)
    progress_bar:setFillColor(0.2, 0.3, 0.5) -- set the color of the progress bar
    progress_bar.x = _CX
    progress_bar.y = _CY + _CY/2


    _lblTapToStart:addEventListener("tap", gotoSP1)  

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