-- This allows to use "hs" command from the terminal.
require("hs.ipc")

hs.configdir = os.getenv('HOME') .. '/.hammerspoon'
package.path = hs.configdir .. '/?.lua;' .. hs.configdir .. '/?/init.lua;' .. hs.configdir .. '/Spoons/?.spoon/init.lua;' .. package.path

-- local PassChooser = hs.loadSpoon('PassChooser')
-- PassChooser:bindHotkeys({
--   show={{'cmd'}, 'p'},
-- })
-- PassChooser:init({
--   clearAfter=10,
-- })

local function openApp(app_name, new)
  new = new or false

  local s = 'open'
  if new then
    s = s .. ' -n'
  end
  s = s .. " -a '/Applications/" .. app_name .. ".app'"

  hs.execute(s)
end

local function closeNotifications()
  local s = [[
    tell application "System Events"
      tell process "NotificationCenter"
        set numwins to (count windows)
        repeat with i from numwins to 1 by -1
          try
            click button "Close" of window i
          end try
          try
            click button "Cancel" of window i
          end try
          try
            click button "Not Now" of window i
          end try
          try
            click button "Mark as Read" of window i
          end try
        end repeat
      end tell
    end tell
  ]]

  return hs.osascript.applescript(s)
end

local function focusFrontmost()
  local frontmostWindow = hs.window.frontmostWindow()
  frontmostWindow:focus()
end

local function setFrontmostWindowPosition(fn)
  local frontmostWindow = hs.window.frontmostWindow()
  local currentScreen = frontmostWindow:screen()
  local frame = currentScreen:frame()
  local nextFrame = currentScreen:localToAbsolute(
    fn(frame.w, frame.h, frame.x, frame.y)
  )
  frontmostWindow:setFrame(nextFrame)
end

-- Applications

-- Alacritty.
hs.hotkey.bind({'cmd', 'shift'}, 'return', function()
  openApp('Alacritty', true)
end)

-- Firefox.
hs.hotkey.bind({'cmd', 'shift'}, 'f', function()
  openApp('Google Chrome', true)
end)

-- Close notifications.
hs.hotkey.bind({'cmd'}, '/', function()
  closeNotifications()
end)

-- Clear clipboard.
hs.hotkey.bind({'cmd'}, '.', function()
  hs.pasteboard.setContents('')
  hs.alert.show('Clipboard cleared')
end)

-- Focus previously used window of the same app.
hs.hotkey.bind({'cmd'}, 0x32, function() -- 0x32 is grave accent
  local front_app = hs.application.frontmostApplication()

  local windows
  if front_app:name() == 'Alacritty' then
    local rest_apps = hs.fnutils.ifilter({hs.application.find('Alacritty')}, function(app)
      return app:pid() ~= front_app:pid()
    end)

    local apps = hs.fnutils.concat({front_app}, rest_apps)

    windows = hs.fnutils.imap(apps, function(app)
      return app:allWindows()[1]
    end)
  else
    windows = hs.fnutils.ifilter(front_app:visibleWindows(), function(window)
      return window:subrole() == 'AXStandardWindow'
    end)
  end

  if #windows > 1 then
    windows[2]:focus()
  end
end)

-- Toggle fullscreen.
hs.hotkey.bind({'cmd', 'ctrl'}, 'f', function()
  local frontmostWindow = hs.window.frontmostWindow()
  frontmostWindow:maximize()
end)

-- Move window to other screen.
-- hs.hotkey.bind({'cmd', 'ctrl'}, 'tab', function()
--   local frontmostWindow = hs.window.frontmostWindow()
--   local currentScreen = frontmostWindow:screen()
--   local allScreens = hs.screen.allScreens()
--   local nextScreen = hs.fnutils.find(allScreens, function(screen)
--     return screen:id() ~= currentScreen:id()
--   end)
--   if nextScreen then
--     frontmostWindow:moveToScreen(nextScreen)
--     frontmostWindow:maximize()
--   end
-- end)

-- Center window.
hs.hotkey.bind({'cmd', 'ctrl'}, 'c', function()
  local frontmostWindow = hs.window.frontmostWindow()
  frontmostWindow:setSize({ w=1024, h=768 })
  frontmostWindow:centerOnScreen()
end)

-- Fill left-half of screen.
hs.hotkey.bind({'cmd', 'alt'}, 'left', function()
  setFrontmostWindowPosition(function(w, h, x, y)
    return { w=w / 2, h=h, x=0, y=0 }
  end)
end)

-- Fill right-half of screen.
hs.hotkey.bind({'cmd', 'alt'}, 'right', function()
  setFrontmostWindowPosition(function(w, h, x, y)
    return { w=w / 2, h=h, x=w / 2, y=0 }
  end)
end)

-- Fill top-half of screen.
hs.hotkey.bind({'cmd', 'alt'}, 'up', function()
  setFrontmostWindowPosition(function(w, h, x, y)
    return { w=w, h=h / 2, x=0, y=0 }
  end)
end)

-- Fill bottom-half of screen.
hs.hotkey.bind({'cmd', 'alt'}, 'down', function()
  setFrontmostWindowPosition(function(w, h, x, y)
    return { w=w, h=h / 2, x=0, y=h / 2 }
  end)
end)

-- Minimize window.
-- hs.hotkey.bind({'cmd'}, 'h', function()
--   local frontmostWindow = hs.window.frontmostWindow()
--   frontmostWindow:minimize()
-- end)

-- Minimize everything aka go to the desktop.
-- hs.hotkey.bind({'cmd', 'ctrl'}, 'h', function()
--   local frontmostWindow = hs.window.frontmostWindow()
--   local currentScreeen = frontmostWindow:screen()

--   local allWindows = hs.window.allWindows()

--   for _, window in pairs(allWindows) do
--     if currentScreeen == window:screen() then
--       window:minimize()
--     end
--   end
-- end)

hs.window.animationDuration = 0

hs.console.darkMode(true)

--

-- wishlist:
-- alacritty tmux opener with https://www.hammerspoon.org/docs/hs.dialog.html
