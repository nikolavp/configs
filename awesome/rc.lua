-- Standard awesome library
awful = require("awful")
require("awful.autofocus")
awful.rules = require("awful.rules")
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
require("naughty")



require("revelation")

vicious = require("vicious")

-- Code for debugging errors
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = 'Oops, there were errors during startup!',
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        if in_error then return end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = 'Oops, an error happened!',
            text = err
        })
        in_error = false
    end)
end


local home = os.getenv("HOME")


--Don't add ugly notifications at startup...
local exec = function (s)
  awful.util.spawn(s, false)
end


terminal = "urxvtc"

local menubar = require("menubar")
menubar.utils.terminal = terminal

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(home .. "/.config/awesome/zenburn.lua")

local pomodoro = require("pomodoro")
pomodoro.init()

-- This is used later as the default terminal and editor to run.
filemanager_app = os.getenv("FILE_MANAGER_APP") or "thunar"
video_app = os.getenv("VIDEO_APP") or "mplayer"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
menu_items = require('menugen').build_menu()

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

first_screen = screen.count()
Tags = {
    {screen = first_screen, name = "www", applications = {"Firefox", "Chromium", "Konqueror", "Google-chrome"}, layout = layouts[7]},
    {screen = first_screen, name = "email", applications = { "Kontact", "Kmail", "Evolution", "Thunderbird"}, layout = layouts[7]},
    {screen = first_screen, name = "im", applications = { "Skype", "Kopete", "Empathy" }, layout = layouts[7]},
}
-- This will handle 2 screens. When more come, write it with a loop.
other_screen = 1
Tags = awful.util.table.join(
    Tags,
    {
        {screen = other_screen, name = "gvim", applications = { "Gvim", "Kate", "Gedit", "KWrite" }, layout = layouts[7]},
        {screen = other_screen, name = "terms", applications = { "URxvt", "XTerm", "Konsole" }, layout = layouts[7]},
        {screen = other_screen, name = "dev", applications = {"Eclipse", "jetbrains-idea-ce" }, layout = layouts[0]},
        {screen = other_screen, name = "tasks", applications = { "Konversation", "Xchat"}, layout = layouts[7]},
    }
)


-- {{{ Menu
-- Create a laucher widget and a main menu
awesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}
table.insert(menu_items, { "awesome", awesomemenu, beautiful.awesome_icon })
table.insert(menu_items, { "open terminal", terminal })


mainmenu = awful.menu({ items = menu_items, width = 150})

launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget

-- {{{ Reusable separator
separator = wibox.widget.imagebox()
separator:set_image(beautiful.widget_sep)
-- }}}

-- {{{ Date and time
dateicon = wibox.widget.imagebox()
dateicon:set_image(beautiful.widget_date)
-- Initialize widget
datewidget = wibox.widget.textbox()
-- Register widget
vicious.register(datewidget, vicious.widgets.date, "%R", 61)
-- Register buttons
datewidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec("pylendar.py") end)
))
-- }}}


-- {{{ Network usage
dnicon = wibox.widget.imagebox()
upicon = wibox.widget.imagebox()
dnicon:set_image(beautiful.widget_net)
upicon:set_image(beautiful.widget_netup)
-- Initialize widget
netwidget = wibox.widget.textbox()
-- Register widget
vicious.register(netwidget, vicious.widgets.net, '<span color="'
  .. beautiful.fg_netdn_widget ..'">${eth0 down_kb}</span> <span color="'
  .. beautiful.fg_netup_widget ..'">${eth0 up_kb}</span>', 3)
-- }}}

-- {{{ Memory usage
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
-- Initialize widget
membar = awful.widget.progressbar()
-- Pogressbar properties
membar:set_vertical(true):set_ticks(true)
membar:set_height(12):set_width(8):set_ticks_size(2)
membar:set_background_color(beautiful.fg_off_widget)
-- membar:set_gradient_colors({ beautiful.fg_widget,
--    beautiful.fg_center_widget, beautiful.fg_end_widget
-- }) -- Register widget
vicious.register(membar, vicious.widgets.mem, "$1", 13)
-- }}}

-- {{{ CPU usage and temperature
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
-- Initialize widgets
cpugraph  = awful.widget.graph()
tzswidget = wibox.widget.textbox()
-- Graph properties
cpugraph:set_width(40):set_height(14)
cpugraph:set_background_color(beautiful.fg_off_widget)
-- cpugraph:set_gradient_angle(0):set_gradient_colors({
--    beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
-- }) -- Register widgets
vicious.register(cpugraph,  vicious.widgets.cpu,      "$1")
vicious.register(tzswidget, vicious.widgets.thermal, " $1C", 19, "thermal_zone0")
-- }}}

-- {{{ Battery state
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_bat)
-- Initialize widget
batwidget = wibox.widget.textbox()
-- Register widget
vicious.register(batwidget, vicious.widgets.bat, "$1$2%", 61, "BAT0")
-- }}}


-- Create a wibox for each screen and add it
mywibox = {}
promptbox = {}
layoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    promptbox[s] = awful.widget.prompt({})
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({  screen = s,
        fg = beautiful.fg_normal, height = 18,
        bg = beautiful.bg_normal, position = "top",
        border_color = beautiful.border_focus,
        border_width = beautiful.border_width
    })
    -- Add widgets to the wibox - order matters
   -- mywibox[s].widgets = {
   -- }

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(launcher)
    left_layout:add(mytaglist[s])
    left_layout:add(promptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(separator)
    right_layout:add(pomodoro.icon_widget)
    right_layout:add(datewidget)
    right_layout:add(dateicon)
    right_layout:add(separator)
    right_layout:add(upicon)
    right_layout:add(netwidget)
    right_layout:add(dnicon)
    right_layout:add(separator)
    right_layout:add(membar)
    right_layout:add(memicon)
    right_layout:add(separator)
    right_layout:add(batwidget)
    right_layout:add(baticon)
    right_layout:add(separator)
    right_layout:add(tzswidget)
    right_layout:add(cpugraph)
    right_layout:add(cpuicon)
    right_layout:add(separator)
    right_layout:add(layoutbox[s])


    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({modkey}, "e", revelation),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            -- awful.client.focus.history.previous()
            -- Alt + Tab like in other wms
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end),

    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    -- This is from  old school window managers
    awful.key({ modkey },            "F2",     function () promptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  promptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    awful.key({ modkey }, "p", function() menubar.show() end)
)

function fullscreens(c)
    awful.client.floating.toggle(c)
    if awful.client.floating.get(c) then
        local clientX = screen[1].workarea.x
        local clientY = screen[1].workarea.y
        local clientWidth = 0
        -- look at http://www.rpm.org/api/4.4.2.2/llimits_8h-source.html
        local clientHeight = 2147483640
        for s = 1, screen.count() do
            clientHeight = math.min(clientHeight, screen[s].workarea.height)
            clientWidth = clientWidth + screen[s].workarea.width
        end
        local t = c:geometry({x = clientX, y = clientY, width = clientWidth, height = clientHeight})
    else
        --apply the rules to this client so he can return to the right tag if there is a rule for that.
        awful.rules.apply(c)
    end
    -- focus our client
    client.focus = c
end

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift" }, "f",        fullscreens),

    awful.key({ modkey,}, "F4",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
--keynumber = 0
--for s = 1, screen.count() do
--   keynumber = math.min(9, math.max(#tags[s], keynumber));
--end
keynumber = math.min(9, #Tags)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        if Tags[i].tag then
                            awful.tag.viewonly(Tags[i].tag)
                        end
                        local current_screen = mouse.screen
                        tag_screen = Tags[i].screen
                        if current_screen ~= tag_screen then
                            newX = screen[tag_screen].geometry.x + 200
                            newY = screen[tag_screen].geometry.y + 200
                            mouse.coords({x=newX, y=newY})
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if Tags[i].tag then
                          awful.tag.viewtoggle(Tags[i].tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and Tags[i].tag then
                          awful.client.movetotag(Tags[i].tag)
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and Tags[i].tag then
                          awful.client.toggletag(Tags[i].tag)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

-- {{{ Rules

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
                     focus = true,
                     -- go to this window at startup
                     switchtotag = true,
                     size_hints_honor = false,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { name = "Screenkey", skip_taskbar = false },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "Gimp" },
      properties = { floating = true } },
}
-- }}}

function setTags(applications, tagDestination)
    for i, v in pairs(applications) do
        table.insert(awful.rules.rules, {rule = {class = v}, properties = {tag = tagDestination} })
    end
end

for i, v in pairs(Tags) do
    result = awful.tag({i .. "=" .. v.name}, v.screen, v.layout)[1]
    Tags[i]["tag"] = result
    setTags(v.applications, result)
end


table.insert(awful.rules.rules, {rule = {name = 'mutt'}, properties = {tag = Tags[2]['tag']} })
table.insert(awful.rules.rules, {rule = {name = 'taskwarrior'}, properties = {tag = Tags[7]['tag']} })

-- }}}
