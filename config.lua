--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

local aspectRatio = display.pixelHeight / display.pixelWidth
local width = display.pixelWidth
local height = display.pixelHeight

application =
{
	content =
	{
		width = 320,
		height = 480, 
		scale = "letterbox",
		fps = 60,
		
		
		imageSuffix =
		{
			    ["@2x"] = 2,
		},
		
	},
}
