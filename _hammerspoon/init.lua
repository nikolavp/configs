-- remove that shit
hs.window.animationDuration = 0
require "string"
local hyper = {"ctrl", "alt", "cmd"}

hs.loadSpoon('WinWin')

clipboard = hs.loadSpoon('ClipboardTool')
clipboard:bindHotkeys({
    toggle_clipboard = {hyper, "v"}
})
clipboard.show_in_menubar = false
clipboard:start()

miromanager = hs.loadSpoon('MiroWindowsManager')
miromanager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "m"}
})

apps = {
    b = 'Google Chrome',
    p = 'Pycharm',
    g = 'Goland',
    v = 'Viber',
    m = 'Slack',
    t = 'iTerm',
    j = 'IntelliJ IDEA',
}

for k, v in pairs(apps) do
    hs.hotkey.bind('alt', k , function()
        hs.application.launchOrFocus(v)
        spoon.WinWin:centerCursor()
    end)
end

hs.hotkey.bind({'ctrl', 'alt'}, 'left', function()
    spoon.WinWin:moveToScreen('left')
    spoon.WinWin:moveAndResize('fullscreen')
    spoon.WinWin:centerCursor()
end)
hs.hotkey.bind({'ctrl', 'alt'}, 'right', function()
    spoon.WinWin:moveToScreen('right')
    spoon.WinWin:moveAndResize('fullscreen')
    spoon.WinWin:centerCursor()
end)

hs.hotkey.bind(hyper, 't', function()
    hs.execute('todo', true)
end)

function ssidChangedCallback()
    ssid = hs.wifi.currentNetwork()

    -- We just joined our home WiFi network
    if ssid == 'gini' or ssid == 'gini_5' then
        hs.alert.show('Detected home network (' .. ssid .. ') unmuting audio ')
        hs.audiodevice.defaultOutputDevice():setMuted(false)
        hs.audiodevice.defaultOutputDevice():setVolume(25)
    elseif ssid ~= nil then
        hs.alert.show('Detected non home (' .. ssid .. ') network muting audio')
        hs.audiodevice.defaultOutputDevice():setVolume(0)
    end

end
wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

-- Disable bluetooth when going to sleep. Taken from https://gist.github.com/ysimonson/fea48ee8a68ed2cbac12473e87134f58
-- This makes some bluetooth devices like headphones to be able to disconnect othrewise they stay connected
-- when the lid is closed

function checkBluetoothResult(rc, stderr, stderr)
    if rc ~= 0 then
        print(string.format("Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s", rc, stderr, stdout))
    end
end

function bluetooth(power)
    print("Setting bluetooth to " .. power)
    local t = hs.task.new("/usr/local/bin/blueutil", checkBluetoothResult, {"--power", power})
    t:start()
end

function f(event)
    if event == hs.caffeinate.watcher.systemWillSleep then
        bluetooth("off")
    elseif event == hs.caffeinate.watcher.screensDidWake then
        bluetooth("on")
    end
end

watcher = hs.caffeinate.watcher.new(f)
watcher:start()
-- End of bluetooth snippet

-- call this explicitly if we are starting up
ssidChangedCallback()

hs.alert.show("Config reloaded")

