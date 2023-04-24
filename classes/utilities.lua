-- Import

-- iz nekog razloga nece da ucita GGData, ali hoce relayout na isti nacin u menu.lua

--[[local GGData = require("ColorUpAssets.libs.GGData")

-- Create class, set variables

local utilities = {}
local db = GGdata:new("db")

-- Init db

if not db.sounds then       --if this doesn't exist, create it
    db:set("sounds", "On")
    db:save()
end

-- Sounds

function utilities:playSound(sound)
    if db.sounds == "On" then
        audio.stop(2)
        audio.play(sound, {channel = 2})
    end
end


-- Return

return utilities
]]