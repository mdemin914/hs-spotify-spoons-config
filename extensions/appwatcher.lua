module = {}

local currentApp
local previousApp

function handleAppEvent(name, eventType, app)
  if (eventType == hs.application.watcher.activated)
  then
    previousApp = currentApp
    currentApp = app
  end
end

function module.activate() 
  if previousApp ~= nil
  then
    previousApp:activate()    
  end
end

function module.start() 
  local appWatcher = hs.application.watcher.new(handleAppEvent)
  appWatcher:start()
end

return module