;(load-option 'synchronous-subprocess)
;(run-shell-command "rev < ~/.zshrc | head -n1")

; restart
(xbindkey '(Mod4 Control Shift x)   "sleep 0.1; pkill xbindkeys; xbindkeys && (click && notify-send 'xbindkeys restarted') || alert")

; terminals
(xbindkey '(Mod4 Return)            "term || urxvt")
(xbindkey '(Mod4 Shift Return)      "term in-tag")
(xbindkey '(Mod4 Control Return)    "term one || urxvt")
(xbindkey '(Mod4 Alt Return)        "term specific")

; locking
(xbindkey '(Mod4 F12)               "lock; xset dpms force off")
(xbindkey '(Mod4 Shift F12)         "lock")
(xbindkey '(Mod4 Alt F12)           "lock --stealth")

; prtscr magic
(xbindkey '(Print)                  "prtscr")
(xbindkey '(Control Print)          "sleep 1; prtscr -s")
(xbindkey '(Shift Print)            "sleep 1; prtscr -sb 0")
(xbindkey '(Control Shift Print)    "prtscr -i $(xdotool getactivewindow)")

; frequently used
(xbindkey '(Control F4)             "xdotool click 1")
(xbindkey '(Mod4 z)                 "xcalib -a -i")
(xbindkey '(Mod4 Shift e)           "rofimoji -s medium-light")
(xbindkey '(Mod4 Shift z)           "sleep 0.1; xset dpms force off")
(xbindkey '(Mod4 Shift c)           "xdotool windowkill $(xdotool getactivewindow)")
(xbindkey '(Control space)          "dunstctl close")
(xbindkey '(Control shift space)    "dunstctl close-all")
(xbindkey '(Control grave)          "dunstctl history-pop")

(xbindkey '(XF86MonBrightnessUp)    "light -T 2")
(xbindkey '(XF86MonBrightnessDown)  "light -T 0.5")
(xbindkey '(Shift XF86MonBrightnessUp)    "light -S 100")
(xbindkey '(Shift XF86MonBrightnessDown)  "light -S 0.05")

(xbindkey '(Mod4 alt grave)         "oneliners")
(xbindkey '(Mod4 space)             "runner")
(xbindkey '(Mod4 shift   grave)     "mapclip paste && alert || alert 0.4 c")
(xbindkey '(Mod4 control e)         "clip-pipe edit")
(xbindkey '(Mod4 control shift e)   "clip-pipe sh")
(xbindkey '(Mod4 alt p)             "passmenu")

; sound
(xbindkey '(XF86AudioLowerVolume)   "amixer set Master 3%-; click")
(xbindkey '(XF86AudioRaiseVolume)   "amixer set Master 3%+; click")
(xbindkey '(XF86AudioMute)          "amixer set Master toggle")
; (xbindkey '(XF86AudioPause)         "xdotool key control+shift+9")
(xbindkey '(XF86AudioPlay)          "xdotool key control+shift+9")
(xbindkey '(Mod4 shift n)           "dmenu <<< '' | xargs -d' ' -L1 sh -c 'play -n synth sin \"$(tr -cd a-zA-Z0-9 <<< \"${1:-A4}\")\" gain -10 trim 0 1 fade 0.1 0.8 0.1' 'sh'") ; plays a note sequence

(xbindkey '(KP_Left)                "amixer set Master 3%+")
(xbindkey '(KP_End)                 "amixer set Master toggle")
(xbindkey '(KP_Down)                "temporary-sound-off")
(xbindkey '(shift KP_End)           "amixer set Master off")
(xbindkey '(KP_Insert)              "amixer set Master 3%-")

; all the keypad binds
(xbindkey '(Mod4 shift f)           "chrome-session")
(xbindkey '(Shift KP_Home)          "chromium --incognito")
(xbindkey '(Control KP_Home)        "chromium hide random")
(xbindkey '(Shift Control KP_Home)  "chromium hide random proxy")
(xbindkey '(Alt KP_Home)            "chromium clean | xargs ok")

; arbitrary, quick to change shell commands
(xbindkey '(Mod4       quotedbl)      "action")
(xbindkey '(Mod4 Shift quotedbl)      "action shift")
(xbindkey '(Mod4       bracketleft)   "action bracketleft")
(xbindkey '(Mod4       bracketright)  "action bracketright")
(xbindkey '(Mod4       minus)         "action minus")
(xbindkey '(Mod4       equal)         "action equal")

; ancient
(xbindkey '(Mod4 Shift t)           "synclient TouchpadOff=$(synclient | ruby -ne 'puts ($_.match(/\\d+/)[0].to_i ^ 1) if /TouchpadOff/ =~ $_'); alert 80")

; idasen table
(xbindkey '(Mod4 Alt "8") "pkill idasen && sleep 0.8; idasen sit")
(xbindkey '(Mod4 Alt "9") "pkill idasen && sleep 0.8; idasen standl")
(xbindkey '(Mod4 Alt "0") "pkill idasen && sleep 0.8; idasen standh")
