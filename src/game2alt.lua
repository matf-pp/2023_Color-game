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

local function checkAnswer()
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

-- Local functions

-- Define a shuffle function that randomly shuffles the elements of a table
    local function shuffle(t)
        local n = #t
        while n > 1 do
          local k = math.random(n)
          t[n], t[k] = t[k], t[n]
          n = n - 1
        end
      end

local function colorValue(color)

    local value 
    if(color == "crvena") then 
        value = clrRed
    elseif(color == "zelena") then 
        value = clrGreen 
    elseif(color == "plava") then 
        value = clrBlue 
    elseif(color == "zuta") then 
        value = clrYellow 
    elseif(color == "ljubicasta") then 
        value = clrPurple 
    elseif(color == "braon") then
        value = clrBrown
    elseif(color == "narandzasta") then 
        value = clrOrange 
    elseif(color == "bela") then 
        value = clrWhite
    end

    return value

end

local function gotoTimeIsUp()
  utilities:playSound(_click) 
  progress_bar.width = 0
  composer.gotoScene("src.timeIsUpGame2")
  _grpMain = display.newGroup()
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

local colorsCopy = colors;

shuffle(colorsCopy)
local randomColor1, randomColor2, randomColor3, randomColor4 = unpack(colorsCopy,1,4)

local chosenColors = {}
for i=1,4 do
    table.insert(chosenColors,colorsCopy[i])
end

--izabrane su zuta,plava,zelena,crvena
--glavna rec ce biti rec zuta napisana plavom bojom
--medju ponudjenim ce biti reci zuta plava zelena crvena
--dakle samo nam treba vrednost plave boje, koja se zove randomColor2 

local trueColorValue = colorValue(randomColor2)

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
  local textMainColor = display.newText(tablesGroup, randomColor1, X_main_color, Y_main_color, native.systemFont, 24)
  textMainColor:setFillColor(trueColorValue[1], trueColorValue[2], trueColorValue[3])

  --ponovo promesaj izabrane boje
  shuffle(chosenColors)


  --pozicije labela

  local rectOption1 = display.newRoundedRect(tablesGroup, X_option_1_3, Y_option_1_2, color_width, color_height, cornerRadius)
  rectOption1.fill = theme
  rectOption1.alpha = 0.9
  local textOption = display.newText(tablesGroup, chosenColors[1], X_option_1_3, Y_option_1_2, native.systemFont, 24)
  textOption:setFillColor(0.5, 0.5, 0.5)
  rectOption1:addEventListener("tap", function()
    utilities:playSound(_click)
    if (chosenColors[1] == randomColor2) then
        score = score + 1
        tablesGroup:removeSelf()
        SP2()
        Runtime:removeEventListener("enterFrame", on_enter_frame)
    else
      tablesGroup:removeSelf()
      Runtime:removeEventListener("enterFrame", on_enter_frame)
      progress_bar.width = 0
      composer.setVariable("score", score) 
      composer.gotoScene("src.wrongChoiceGame2")
    end
end)

  local rectOption2 = display.newRoundedRect(tablesGroup, X_option_2_4, Y_option_1_2, color_width, color_height, cornerRadius)
  rectOption2.fill = theme
  rectOption2.alpha = 0.9
  local textOption = display.newText(tablesGroup, chosenColors[2], X_option_2_4, Y_option_1_2, native.systemFont, 24)
  textOption:setFillColor(0.5, 0.5, 0.5)
  rectOption2:addEventListener("tap", function()
    utilities:playSound(_click)
    if (chosenColors[2] == randomColor2) then
        score = score + 1
        tablesGroup:removeSelf()
        SP2()
        Runtime:removeEventListener("enterFrame", on_enter_frame)
    else
        tablesGroup:removeSelf()
        Runtime:removeEventListener("enterFrame", on_enter_frame)
        progress_bar.width = 0
        composer.setVariable("score", score) 
        composer.gotoScene("src.wrongChoiceGame2")
    end
end)

  local rectOption3 = display.newRoundedRect(tablesGroup, X_option_1_3, Y_option_3_4, color_width, color_height, cornerRadius)
  rectOption3.fill = theme
  rectOption3.alpha = 0.9
  local textOption = display.newText(tablesGroup, chosenColors[3], X_option_1_3, Y_option_3_4, native.systemFont, 24)
  textOption:setFillColor(0.5, 0.5, 0.5)
  rectOption3:addEventListener("tap", function()
    utilities:playSound(_click)
    if (chosenColors[3] == randomColor2) then
        score = score + 1
        tablesGroup:removeSelf()
        SP2()
        Runtime:removeEventListener("enterFrame", on_enter_frame)
    else
      tablesGroup:removeSelf()
      Runtime:removeEventListener("enterFrame", on_enter_frame)
      progress_bar.width = 0
      composer.setVariable("score", score) 
      composer.gotoScene("src.wrongChoiceGame2")
    end
end)

  local rectOption4 = display.newRoundedRect(tablesGroup, X_option_2_4, Y_option_3_4, color_width, color_height, cornerRadius)
  rectOption4.fill = theme
  rectOption4.alpha = 0.9
  local textOption = display.newText(tablesGroup, chosenColors[4], X_option_2_4, Y_option_3_4, native.systemFont, 24)
  textOption:setFillColor(0.5, 0.5, 0.5)
  rectOption4:addEventListener("tap", function()
    utilities:playSound(_click)
    if (chosenColors[4] == randomColor2) then
        score = score + 1
        tablesGroup:removeSelf()
        SP2()
        Runtime:removeEventListener("enterFrame", on_enter_frame)
    else
      tablesGroup:removeSelf()
      Runtime:removeEventListener("enterFrame", on_enter_frame)
      progress_bar.width = 0
      composer.setVariable("score", score) 
      composer.gotoScene("src.wrongChoiceGame2")
    end
end)

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

  --composer.setVariable("score", score)

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