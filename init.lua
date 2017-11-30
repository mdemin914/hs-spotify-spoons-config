package.path = package.path .. ";" .. "./luasocket/src/" .. "?.lua"

local logger = require "hs.logger"
logger.defaultLogLevel = 'warning'
local log = logger.new("init")

local screenlayout = require "extensions.screenlayout"
local spotifysong = require "extensions.spotifysong"

local modalmgr = hs.loadSpoon('ModalMgr')
local countDown = hs.loadSpoon('CountDown')
local hcalendar = hs.loadSpoon('HCalendar')
local clipShow = hs.loadSpoon('ClipShow')
-- local cc = hs.loadSpoon('CircleClock')
local ksheet = hs.loadSpoon('KSheet')
local clipHistory = hs.loadSpoon('TextClipboardHistory')

screenlayout.start()
clipHistory:start()
spotifysong.start()

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "R", function ()
  hs.notify.new({title="Hammerspoon", informativeText="Restoring Windows"}):send()
  screenlayout.restoreLayout()
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "S", function ()
  hs.notify.new({title="Hammerspoon", informativeText="Saving Windows"}):send()
  screenlayout.saveLayout()
end)
--
-- Spotify
--
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Z", function ()
  hs.spotify.previous()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "X", function ()
  hs.spotify.next()
end)
--
-- KSheet
--
local keySheetVisible = false

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function ()

  if (keySheetVisible) then
    ksheet:hide()
  else 
    ksheet:show()
  end

  keySheetVisible = not keySheetVisible

end)
--
-- TextClipboardHistory
-- 
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "V", function ()
  clipHistory:toggleClipboard()
end)

-- 
-- CountDown
--
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "T", function ()
  hs.notify.new({title="Hammerspoon", informativeText="Starting Timer!"}):send()
  countDown:startFor(1)
end)

-- 
-- ClipShow
--
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function ()
  clipShow:toggleShow()
end)

-- window hints app switcher
-- hs.hints.style = "vimperator"
hs.hotkey.bind({"cmd", "ctrl", "shift"}, "tab", function ()
  hs.hints.windowHints()
end)

hs.hotkey.bind({"alt"}, "tab", function ()
  hs.hints.windowHints()
end)

--
-- Monitor and reload config when required
--
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Q", function ()
  hs.notify.new({title="Hammerspoon", informativeText="Reload Config"}):send()
  hs.reload()
end)

function reload_config(files)
  hs.notify.new({title="Hammerspoon", informativeText="Reload Config"}):send()
  hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/init.lua", reload_config):start()
hs.notify.new({title="Hammerspoon", informativeText="Config Loaded"}):send()
--
-- /Monitor and reload config when required
--