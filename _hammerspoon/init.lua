-- remove that shit
hs.window.animationDuration = 0
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
    m = 'uChat',
    t = 'iTerm',
    n = 'Notes'
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
    else
        hs.alert.show('Detected non home (' .. ssid .. ') network muting audio')
        hs.audiodevice.defaultOutputDevice():setVolume(0)
    end

end
wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

-- call this explicitly if we are starting up
ssidChangedCallback()

hs.alert.show("Config reloaded")

