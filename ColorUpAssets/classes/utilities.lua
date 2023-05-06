-- Import

local GGData = require("ColorUpAssets.libs.GGData")

-- Create class, set variables

local utilities = {}
local db = GGData:new("db")

-- Init db

if not db.sounds then       --if this doesn't exist, create it
    db:set("sounds", "On")
    db:save()
end

if not db.music then
    db:set("music", "On")
    db:save()
end

if not db.background then
    db:set("background","black")
    db:save()
end

if not db.highscore then
    db:set("highscore", 0)
    db:save()
end

if not db.tmpscore then
    db:set("tmpscore", 0)
    db:save()
end

if not db.highscoreList then
    db:set("highscoreList", {})
    db:save()
end


-- Sounds

function utilities:playSound(sound)
    if db.sounds == "On" then
        audio.stop(2)
        audio.play(sound, {channel = 2})
    end
end

function utilities:checkSounds()

    return db.sounds
end


function utilities:toggleSounds()

    if db.sounds == "On" then
        db:set("sounds", "Off")
    else
        db:set("sounds", "On")
    end

    db:save()
end

function utilities:checkMusic()

    return db.music
end

function utilities:playMusic(music)

    if db.music == "On" then
        audio.play(music, { loops=-1, channel=1})
        audio.setVolume(0.6, {channel=1})
    end
end

function utilities:toggleMusic()

    if db.music == "On" then
        db:set("music", "Off")
    else
        db:set("music", "On")
    end

    db:save()
end


function utilities:checkBackground()

    return db.background
end

function utilities:changeBackground()

    if db.background == "white" then
        db:set("background","black")
    else
        db:set("background","white")
    end

    db:save()
end


function utilities:getHighscore()

    return db.highscore
end

function utilities:setHighscore(score)

    if db.tmpscore > db.highscore then
        db:set("highscore", db.tmpscore)
        db:save()

        return true
    else
        return false
    end
end

function utilities:getTmpScore()

    return db.tmpscore
end

function utilities:setTmpScore(score)

    db:set("tmpscore", score)
    db:save()
end

function utilities:getHighscoreList()
    
    return db.highscoreList

end

function utilities:setHighscoreList(currentHighscoreList)

    db:set("highscoreList", currentHighscoreList)
    db:save()

end


-- Return

return utilities
