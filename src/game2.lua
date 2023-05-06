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
    theme = {1, 1, 1}
else
    theme = {0, 0, 0}
end

--Scene
local scene = composer.newScene()

--Groups
local _grpMain

--Sounds
local _click = audio.loadStream("ColorUpAssets/assets/sounds/click.wav")

--Colors
local colors = {"crvena", "zelena", "plava", "zuta", "ljubicasta", "braon", "narandzasta", "bela"}

local clrRed =    {1, 51/255, 51/255}       
local clrGreen =  {102/255, 204/255, 0}     
local clrBlue =   {0, 102/255, 204/255}      
local clrYellow = {1, 1, 51/255}
local clrPurple = {153/255, 51/255, 204/255}
local clrBrown =  {150/255, 75/255, 0}
local clrOrange = {1, 153/255, 51/255}
local clrWhite =  {1, 1, 1}
local clrBlack =  {0, 0, 0}

local colorsArray = {clrRed, clrGreen, clrBlue, clrYellow, clrPurple, clrBrown, clrOrange, clrWhite}

--Variables
local _lblTapToStart = ""
local start_time = system.getTimer()
local elapsed_time = 0
local total_time = 5  --in seconds
local progress_bar
local score = 0
math.randomseed(133)

-- Local functions
local function gotoTimeIsUp()
  utilities:playSound(_click) 
  progress_bar.width = 0
  composer.gotoScene("src.timeIsUpGame2")
  _grpMain = display.newGroup()
end

local function getTrueColorName(color)
  local name
  if(color == clrRed) then
    name = "crvena"
  elseif(color == clrGreen) then
    name = "zelena"
  elseif(color == clrBlue) then
    name = "plava"
  elseif(color == clrYellow) then
    name = "zuta"
  elseif(color == clrPurple) then
    name = "ljubicasta"
  elseif(color == clrBrown) then
    name = "braon"
  elseif(color == clrOrange) then
    name = "narandzasta"
  elseif(color == clrWhite) then
    name = "bela"
  elseif(color == clrBlack) then
    name = "crna"
  end

  return name
end

local function getRandomColors(t)
  if ( type(t) ~= "table" ) then
    print( "WARNING: getRandomColors function expects a table" )
    return nil, nil, nil, nil
  end

  local randomNumber1 = math.random(1, table.getn(t)-1)
  local randomColor1 = t[randomNumber1]
  table.remove(t, randomNumber1)

  local randomNumber2 = math.random(1, table.getn(t)-1)
  local randomColor2 = t[randomNumber2]
  table.remove(t, randomNumber2)

  local randomNumber3 = math.random(1, table.getn(t)-1)
  local randomColor3 = t[randomNumber3]
  table.remove(t, randomNumber3)

  return randomColor1, randomColor2, randomColor3
end

local function calculate_progress()   -- as a percentage
  return (system.getTimer() - start_time) / duration
end

local function update_progress_bar()
  local progress = elapsed_time / total_time -- calculate progress as a fraction between 0 and 1
  local max_width = 2*display.contentWidth + 200  -- set the maximum width of the progress bar
  local min_width = 0 -- set the minimum width of the progress bar

  -- calculate the current width of the progress bar as a function of the progress
  local current_width = max_width - (max_width - min_width) * progress

  -- update the width of the progress bar
  progress_bar.width = current_width
end

local function on_enter_frame()
  elapsed_time = os.time() - start_time -- calculate the elapsed time
  if elapsed_time >= total_time then
    -- the timer is finished
    print("Timer complete!")
    --omogucavamo deljenje podataka kroz scene/datoteke programa
    composer.setVariable("score", score) 
    Runtime:removeEventListener("enterFrame", on_enter_frame)
    progress_bar.width = 0 -- set the progress bar width to 0
    gotoTimeIsUp()
  else
    update_progress_bar()
  end
end

local function gotoWrongChoice()
  utilities:playSound(_click) 
  Runtime:removeEventListener("enterFrame", on_enter_frame)
  progress_bar.width = 0
  composer.gotoScene("src.wrongChoiceGame2")
  _grpMain = display.newGroup()
end

local function SP2()
  local tablesGroup = display.newGroup()
  _lblTapToStart.alpha = 0

  start_time = os.time() -- record the start time

  Runtime:addEventListener("enterFrame", on_enter_frame)

  --nasumicno izaberi boju
  local randomNumber1 = math.random(1,table.getn(colors)-1)
  local randomColor = colors[randomNumber1]
  local randomNumber2 = math.random(1,table.getn(colorsArray)-1)

  --podaci o pozicijama labela
  local X_main_color = 0
  local Y_main_color = 0

  local X_option_1_3 = -80
  local X_option_2_4 = 80
  local Y_option_1_2 = 150
  local Y_option_3_4 = 250

  local color_width = 140
  local color_height = 60

  local cornerRadius = 5

  --prikazi boju koju korisnik treba izabrati medju ponudjenim
  local rectMainColor = display.newRoundedRect(tablesGroup, X_main_color, Y_main_color, color_width, color_height, cornerRadius)
  rectMainColor.fill = theme
  local textMainColor = display.newText(tablesGroup, randomColor, X_main_color, Y_main_color, native.systemFont, 24)
  local trueColor = colorsArray[randomNumber2]
  textMainColor:setFillColor(trueColor[1], trueColor[2], trueColor[3])


  --pravimo kopiju niza boja iz koje cemo ukloniti glavnu boju kako je ne bi kasnije izabrali dva puta
  local colorsCopy = table.copy(colors)
  local trueColorName = getTrueColorName(trueColor)
  local index = table.indexOf(colorsCopy, trueColorName)
  table.remove(colorsCopy, index)

  --izaberi 3 nasumicne boje iz pomocnog niza, i svaki put izbaci odabranu boju (kako se ne bi ponovila)
  local randomColor1, randomColor2, randomColor3 = getRandomColors(colorsCopy)

  --dodaj ove 4 opcije u novu tabelu i nasumicno izvuci 4 opcije (da ne bi neke od opcija bile fiksne)
  local colorsOptions = {randomColor1, randomColor2, randomColor3, trueColorName}
  local randomColor1, randomColor2, randomColor3 = getRandomColors(colorsOptions)
  local randomColor4 = colorsOptions[1]


  --prikazi cetiri ponudjene boje od kojih je jedna tacna
  local function showOptions(number)
    local X_pos, Y_pos, randomColorNum

    if(number == 1) then
      X_pos = X_option_1_3
      Y_pos = Y_option_1_2
      randomColorNum = randomColor1
    elseif(number == 2) then
      X_pos = X_option_2_4
      Y_pos = Y_option_1_2
      randomColorNum = randomColor2
    elseif(number == 3) then
      X_pos = X_option_1_3
      Y_pos = Y_option_3_4
      randomColorNum = randomColor3
    elseif(number == 4) then
      X_pos = X_option_2_4
      Y_pos = Y_option_3_4
      randomColorNum = randomColor4
    end

    local rectOption = display.newRoundedRect(tablesGroup, X_pos, Y_pos, color_width, color_height, cornerRadius)
    rectOption.fill = theme
    rectOption.alpha = 0.9
    local textOption = display.newText(tablesGroup, randomColorNum, X_pos, Y_pos, native.systemFont, 24)
    textOption:setFillColor(0.5, 0.5, 0.5)

    return rectOption
  end

  local rectOption1 = showOptions(1)
  local rectOption2 = showOptions(2)
  local rectOption3 = showOptions(3)
  local rectOption4 = showOptions(4)

  local rectOptions = {rectOption1, rectOption2, rectOption3, rectOption4}
  local randomColors = {randomColor1, randomColor2, randomColor3, randomColor4}

  --Proveri koja boja od opcija sadrzi tacnu boju
  for i = 1, #randomColors do
    if(trueColorName == randomColors[i]) then
      score = score + 1
      rectOptions[i]:addEventListener("tap", SP2)
      break
    end
  end

  --Izabrana je pogresna boja
  for i = 1, #randomColors do
    if(trueColorName ~= randomColors[i]) then
      --omogucavamo deljenje podataka kroz scene/datoteke programa
      composer.setVariable("score", score) 
      rectOptions[i]:addEventListener("tap", gotoWrongChoice)
    end
  end

  progress_bar.x = 0   --ovo je da bi sredina timer-bara bila na levoj ivici
  progress_bar.y = _CY + 200

  tablesGroup.x = _CX
  tablesGroup.y = _CY - _CY/2

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

  --reset the values
  score = 0

  if utilities:checkBackground() == "white" then
    background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/black.png", _W, _H)
  else
    background = display.newImageRect(_grpMain, "ColorUpAssets/assets/images/white.png", _W, _H)
  end

  background.x = _CX
  background.y = _CY

  _lblTapToStart = display.newText("Tap to start", _CX, _CY, "ColorUpAssets/assets/fonts/Galada.ttf", 46)
  _lblTapToStart.fill = theme
  _grpMain:insert(_lblTapToStart)
  _lblTapToStart.x = _CX
  _lblTapToStart.y = _CY

  progress_bar = display.newRect(display.contentCenterX, display.contentCenterY, 2*display.contentWidth, 20)
  progress_bar:setFillColor(0.2, 0.3, 0.5) -- set the color of the progress bar
  progress_bar.x = _CX
  progress_bar.y = _CY + _CY/2

  _lblTapToStart:addEventListener("tap", gotoSP2)  
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