display.setStatusBar(display.HiddenStatusBar)
native.setProperty("preferredScreenEdgesDeferringSystemGestures",true)


-- Create composer
local composer = require("composer")
composer.recycleOnSceneChange = true
composer.gotoScene("scenes.menu")