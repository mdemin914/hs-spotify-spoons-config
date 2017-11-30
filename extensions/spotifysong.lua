local module = {}

local spotify = require "hs.spotify"
local menubar = require "hs.menubar"
local logger = require "hs.logger"
local log = logger.new('scrlayout')
local timer = require "hs.timer"

function module.showSong()
  
  local track = spotify.getCurrentTrack()
  local artist = spotify.getCurrentArtist()

  module.menubar:setTitle(track .. ' - ' .. artist)    

  timer.doEvery(5, module.setMenuBarTitle)

end

function module.setMenuBarTitle() 

  local tempTrack = spotify.getCurrentTrack()
  local tempArtist = spotify.getCurrentArtist()
  module.menubar:setTitle(tempTrack .. ' - ' .. tempArtist)    

end

function module.start()

  local menubar = menubar.new()
  module.menubar = menubar
  module.showSong()

end

function wait(seconds)
  local start = os.time()
  repeat until os.time() > start + seconds
end

return module

