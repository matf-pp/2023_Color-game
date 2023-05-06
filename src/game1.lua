-- Import

local composer = require("composer")
local relayout = require("ColorUpAssets.libs.relayout")
local utilities = require("ColorUpAssets.classes.utilities")

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
local _click = audio.loadStream("ColorUpAssets/assets/sounds/click.wav")
local correct = audio.loadStream("ColorUpAssets/assets/sounds/correct.wav")
local wrong = audio.loadStream("ColorUpAssets/assets/sounds/wrong.mp3")
local music = audio.loadStream("ColorUpAssets/assets/sounds/gamesound.wav")
local timeisup = audio.loadStream("ColorUpAssets/assets/sounds/timeisup.mp3")

local _playing = false

--Colors
local colors = {"crvena","zelena", "plava","zuta", "ljubicasta", "braon", "narandzasta", "bela" }

local clrRed =    {1, 51/255, 51/255}       
local clrGreen =  {102/255, 204/255, 0}     
local clrBlue =   {0, 102/255, 204/255}      
local clrYellow = {1, 1, 51/255}
local clrPurple = {153/255, 51/255, 204/255}
local clrBrown =  {150/255, 75/255, 0}
local clrOrange = {252/255, 132/255, 3/255}
local clrWhite =  {1, 1, 1}

local colorsArray = {clrRed, clrGreen, clrBlue, clrYellow, clrPurple, clrBrown, clrOrange, clrWhite}

-- Set variables
local _lblTapToStart = ""
local start_time = system.getTimer()
local progress_bar

local Score
local Next
local numberStr
local number = 0
local randomNumber1
local randomNumber2
local randomColor
local tableText
local fillStr
local tablesGroup
local total_time = 30
local tableRect

-- Local functions

if utilities:checkMusic() == "On" then
  utilities:playMusic(music)
else
  audio.stop()
end

local function on_table_tap()
  --negativePoints()
  if((randomColor=="crvena" and fillStr==clrRed) or 
     (randomColor=="zelena" and fillStr==clrGreen) or
     (randomColor=="plava" and fillStr==clrBlue) or
     (randomColor=="zuta" and fillStr==clrYellow) or
     (randomColor=="ljubicasta" and fillStr==clrPurple) or
     (randomColor=="braon" and fillStr==clrBrown) or
     (randomColor=="narandzasta" and fillStr==clrOrange) or
     (randomColor=="bela" and fillStr==clrWhite) or
     (randomColor=="crna" and fillStr==clrBlack)) then
      utilities:playSound(correct)
    number = number + 1
     else
      utilities:playSound(wrong)
      number = number - 1
  end

  if number > 7 then
    local rnd = math.random(1,table.getn(colors)-1)
    local rndclr = colors[rnd]
    fillStr = colorsArray[math.random(1, table.getn(colorsArray)-1)]
    tableRect:setFillColor(fillStr[1], fillStr[2], fillStr[3])
  end

  if number > 3 then
    local rnd = math.random(1,table.getn(colors)-1)
    local rndclr = colors[rnd]
    fillStr = colorsArray[math.random(1, table.getn(colorsArray)-1)]
    progress_bar:setFillColor(fillStr[1], fillStr[2], fillStr[3])
  end
  numberStr.text = number
  tablesGroup:removeSelf()
end

local function gotoTimeIsUp()
  utilities:playSound(timeisup) 
  progress_bar.width = 0
  composer.gotoScene("src.timeIsUpGame1")
  _grpMain = display.newGroup()
end

local function begin_time()
  local start_time = os.time() -- record the start time

  
  local function on_enter_frame()
      local elapsed_time = os.time() - start_time -- calculate the elapsed time
      if elapsed_time >= total_time then
          -- the timer is finished
          progress_bar.width = 0 -- set the progress bar width to 0
          Runtime:removeEventListener("enterFrame", on_enter_frame)
          composer.setVariable("number", number)
          gotoTimeIsUp()
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
  if progress_bar.width == 0 then
    gotoTimeIsUp()
    progress_bar:removeSelf()
  end
  --if progress_bar.width == 0 then
  --  number = number - 2
  --  numberStr.text = number
  --end

  Runtime:addEventListener("enterFrame", on_enter_frame)
end

local function on_next()
  --begin_time()
  if((randomColor=="crvena" and fillStr==clrRed) or 
     (randomColor=="zelena" and fillStr==clrGreen) or
     (randomColor=="plava" and fillStr==clrBlue) or
     (randomColor=="zuta" and fillStr==clrYellow) or
     (randomColor=="ljubicasta" and fillStr==clrPurple) or
     (randomColor=="braon" and fillStr==clrBrown) or
     (randomColor=="narandzasta" and fillStr==clrOrange) or
     (randomColor=="bela" and fillStr==clrWhite) or
     (randomColor=="crna" and fillStr==clrBlack)) then
      utilities:playSound(wrong)
    number = number - 1
  end

  if number > 2 then
    local rnd = math.random(1,table.getn(colors)-1)
    local rndclr = colors[rnd]
    fillStr = colorsArray[math.random(1, table.getn(colorsArray)-1)]
    progress_bar:setFillColor(fillStr[1], fillStr[2], fillStr[3])
  end

  numberStr.text = number
  --tablesGroup:removeSelf()
  local randomIndex = math.random(1, table.getn(colors)-1)
  randomColor = colors[randomIndex]
  tableText.text = randomColor
  if math.random() < 0.5 then
    -- Use the same index for both variables
    fillStr = colorsArray[randomIndex]
  else
    -- Generate a separate index for the fill color
    fillStr = colorsArray[math.random(1, table.getn(colorsArray)-1)]
  end
  tableText:setFillColor(fillStr[1], fillStr[2], fillStr[3])
end

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

local ind = 1 --ovo omogucava da tajmer pocne samo jednom na pocetku i da se ne pokrece svaki put iznova 
function SP1()

  _lblTapToStart.alpha = 0

  tablesGroup = display.newGroup()

  if ind == 1 then 
   begin_time()
  end

  randomNumber1 = math.random(1,table.getn(colors)-1)
  randomColor = colors[randomNumber1]
  randomNumber2 = math.random(1,table.getn(colorsArray)-1)

  Score = display.newText(tablesGroup, "Score: ", -20, -80, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 45)
  Score.fill = theme
  numberStr = display.newText(tablesGroup, number, 70, -80, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf",45)
  numberStr.fill = theme

  local nextRect = display.newRect(tablesGroup, 0, 200, 150, 40)
  nextRect.fill = theme
  Next = display.newText(tablesGroup, "Next", 0, 200, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 50)
  Next:setFillColor(0.2, 0.3, 0.4)

  tableRect = display.newRect(tablesGroup, 0, 100, 250, 80)
  tableRect.fill = theme
  tableText = display.newText(tablesGroup, randomColor, 0, 100, native.systemFont, 36)
  fillStr = colorsArray[randomNumber2]
  tableText:setFillColor(fillStr[1], fillStr[2], fillStr[3])

  if progress_bar.width == 0 then
    tableRect:removeSelf()
    nextRect:removeSelf()
    tableText:removeSelf()
    Next:removeSelf()
    Score:removeSelf()
    numberStr:removeSelf()
  end

  ind = 2

  tableRect:addEventListener("tap", on_table_tap)
  tableRect:addEventListener("tap", SP1)
  nextRect:addEventListener("tap", on_next)

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


    _lblTapToStart = display.newText("Tap to start", _CX, _CY, "ColorUpAssets/assets/fonts/alphabetized cassette tapes.ttf", 46)
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