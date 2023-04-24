display.setStatusBar(display.HiddenStatusBar)
native.setProperty("preferredScreenEdgesDeferringSystemGestures",true)

local Rect1 = display.newRect(50,50,50,50)
Rect1:setFillColor(math.random(),math.random(),math.random())

Rect1.x = 40
Rect1.y = 40

-- Create composer
local composer = require("composer")
composer.recycleOnSceneChange = true
composer.gotoScene("scenes.menu")