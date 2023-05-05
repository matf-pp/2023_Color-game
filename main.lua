display.setStatusBar(display.HiddenStatusBar)
native.setProperty("preferredScreenEdgesDeferringSystemGestures",true)


--Play
local gamecenter = require("classes.helper_gamecenter")
gamecenter:init()

-- Create composer
local composer = require("composer")
composer.recycleOnSceneChange = true
composer.gotoScene("scenes.menu")
