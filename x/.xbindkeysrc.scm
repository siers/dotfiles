;(load-option 'synchronous-subprocess)
;(run-shell-command "rev < ~/.zshrc | head -n1")

(xbindkey '(Mod4 Shift e) "rofimoji -s medium-light")

;; ;; ;;

(xbindkey '(Mod4 Control Shift f)   "sudo /root/iptables.sh")
(xbindkey '(Mod4 Control Shift x)   "sleep 0.1; pkill xbindkeys; xbindkeys && (click && notify-send 'xbindkeys restarted') || alert")

(xbindkey '(Mod4 Return)            "term || urxvt")
(xbindkey '(Mod4 Shift Return)      "term in-tag")
(xbindkey '(Mod4 Control Return)    "term one || urxvt")
(xbindkey '(Mod4 Alt Return)        "term specific")

(xbindkey '(XF86Sleep)              "sudo pm-suspend")
(xbindkey '(Shift XF86Sleep)        "lock & sudo pm-suspend")

(xbindkey '(Control F4)             "xdotool click 1")
(xbindkey '(Mod4 z)                 "xcalib -a -i")
(xbindkey '(Mod4 Shift z)           "sleep 0.1; xset dpms force off")
(xbindkey '(XF86MonBrightnessUp)    "~/.nix-profile/bin/xbacklight -inc 7")
(xbindkey '(XF86MonBrightnessDown)  "~/.nix-profile/bin/xbacklight -dec 7")
(xbindkey '(Mod4 Shift t)           "synclient TouchpadOff=$(synclient | ruby -ne 'puts ($_.match(/\\d+/)[0].to_i ^ 1) if /TouchpadOff/ =~ $_'); alert 80")

(xbindkey '(Mod4 F12)               "lock; xset dpms force off")
(xbindkey '(Mod4 Shift F12)         "lock")
;(xbindkey '(Mod4 Control F12)       "sudo pm-suspend")

(xbindkey '(Mod4 Alt F12)           "lock --stealth")
(xbindkey '(Mod4 Alt Shift F12)     "touch /tmp/nolock; notify-send -t 1 ' '")

; window manager

(xbindkey '(Mod4 Shift c) "xdotool windowkill $(xdotool getactivewindow)")

; prtscr magic

(xbindkey '(Print)                  "prtscr")
(xbindkey '(Control Print)          "sleep 1; prtscr -s")
(xbindkey '(Shift Print)            "sleep 1; prtscr -sb 0")

; (xbindkey '(Shift Print)            "cloud-prtscr")
; (xbindkey '(Shift Control Print)    "sleep 1; cloud-prtscr -s")

; sound

(xbindkey '(XF86AudioLowerVolume)   "amixer set Master 3%-; click")
(xbindkey '(XF86AudioRaiseVolume)   "amixer set Master 3%+; click")
(xbindkey '(XF86AudioMute)          "amixer set Master toggle")

(xbindkey '(XF86AudioPlay)          "mpc toggle")
(xbindkey '(XF86AudioStop)          "mpc stop")
(xbindkey '(XF86AudioNext)          "mpc next")
(xbindkey '(XF86AudioPrev)          "mpc prev")

; /sound

(xbindkey '(Mod4 alt grave)         "oneliners")
(xbindkey '(Mod4 space)             "runner")
(xbindkey '(Mod4 control e)         "clip-pipe edit")
(xbindkey '(Mod4 shift e)           "clip-pipe sh")
(xbindkey '(Mod4 shift   grave)     "mapclip paste && alert || alert 0.4 c")
(xbindkey '(Mod4 F1)                "surf -- \"$(c -o)\"")
(xbindkey '(Mod4 shift n)           "dmenu <<< '' | xargs -d' ' -L1 sh -c 'play -n synth sin \"$(tr -cd a-zA-Z0-9 <<< \"${1:-A4}\")\" gain -10 trim 0 1 fade 0.1 0.8 0.1' 'sh'")

; all the keypad binds

(xbindkey '(Mod4 shift f)           "google-chrome-stable")
(xbindkey '(Shift KP_Home)          "chromium --incognito")
(xbindkey '(Control KP_Home)        "chromium hide random")
(xbindkey '(Shift Control KP_Home)  "chromium hide random proxy")
(xbindkey '(Alt KP_Home)            "chromium clean | xargs ok")

(xbindkey '(KP_Divide)              "echo G3 > /tmp/pitch; user-daemon-toggle la.service")
(xbindkey '(KP_Multiply)            "echo D4 > /tmp/pitch; user-daemon-toggle la.service")
(xbindkey '(KP_Subtract)            "echo A4 > /tmp/pitch; user-daemon-toggle la.service")
(xbindkey '(KP_Add)                 "echo E5 > /tmp/pitch; user-daemon-toggle la.service")
(xbindkey '(KP_Right)               "false && ~/code/ruby/util/apklust.rb")

(xbindkey '(KP_Enter)               "mpc toggle")
(xbindkey '(KP_Down)                "mpc prev")
(xbindkey '(KP_Next)                "mpc next")

(xbindkey '(KP_Left)                "amixer set Master 3%+")
(xbindkey '(KP_End)                 "amixer set Master toggle")
(xbindkey '(KP_Down)                "temporary-sound-off")
(xbindkey '(shift KP_End)           "amixer set Master off")
(xbindkey '(KP_Insert)              "amixer set Master 3%-")

; arbitrary, quick to change shell commands

(xbindkey '(Mod4       quotedbl)      "action")
(xbindkey '(Mod4 Shift quotedbl)      "action shift")
(xbindkey '(Mod4       bracketleft)   "action bracketleft")
(xbindkey '(Mod4       bracketright)  "action bracketright")
(xbindkey '(Mod4       minus)         "action minus")
(xbindkey '(Mod4       equal)         "action equal")
