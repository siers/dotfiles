;(load-option 'synchronous-subprocess)
;(run-shell-command "rev < ~/.zshrc | head -n1")

;; ;; ;;

(xbindkey '(Mod4 Control Shift f)   "sudo /root/iptables.sh")
(xbindkey '(Mod4 Control Shift x)   "sleep 0.5; pkill xbindkeys; xbindkeys; notify-send success:\\ $?")

(xbindkey '(Mod4 Return)            "term || urxvt")
(xbindkey '(Mod4 Shift Return)      "term in-tag")
(xbindkey '(Mod4 Control Return)    "term one || urxvt")
(xbindkey '(Mod4 Alt Return)        "alert")

(xbindkey '(KP_Home)                    "chromium")
(xbindkey '(Shift KP_Home)              "chromium hide")
(xbindkey '(Control KP_Home)            "chromium hide random")
(xbindkey '(Shift Control KP_Home)      "chromium hide random proxy")
(xbindkey '(Alt KP_Home)                "chromium clean | xargs ok")

(xbindkey '(XF86Sleep)              "sudo pm-suspend")
(xbindkey '(Shift XF86Sleep)        "lock & sudo pm-suspend")

(xbindkey '(Control F4)             "xdotool click 1")
(xbindkey '(Mod4 z)                 "xcalib -a -i")
(xbindkey '(XF86MonBrightnessUp)    "xbacklight + 5")
(xbindkey '(XF86MonBrightnessDown)  "xbacklight - 5")

(xbindkey '(Mod4 F12)               "lock; xset dpms force off")
(xbindkey '(Mod4 Shift F12)         "lock")
(xbindkey '(Mod4 Control F12)       "sudo pm-suspend")

(xbindkey '(Mod4 Alt F12)           "lock --stealth")
(xbindkey '(Mod4 Alt Shift F12)     "touch /tmp/nolock; notify-send -t 1 ' '")

; window manager

(xbindkey '(Mod4 Shift c) "xdotool windowkill $(xdotool getactivewindow)")

; prtscr magic

(xbindkey '(Print)                  "prtscr")
(xbindkey '(Control Print)          "sleep 1; prtscr -s")

(xbindkey '(Alt Print)              "prtscr    | xargs -I% share % $(mktemp -up . prtscr/XXX.png)")
(xbindkey '(Alt Control Print)      "prtscr -s | xargs -I% share % $(mktemp -up . prtscr/XXX.png)")

(xbindkey '(Shift Print)            "cloud-prtscr")
(xbindkey '(Shift Control Print)    "sleep 1; cloud-prtscr -s")

; sound

(xbindkey '(XF86AudioLowerVolume)   "amixer set Master 3%-; click")
(xbindkey '(XF86AudioRaiseVolume)   "amixer set Master 3%+; click")
(xbindkey '(XF86AudioMute)          "amixer set Master toggle")

(xbindkey '(KP_Divide)              "echo G3 > /tmp/pitch; user-daemon-toggle la.service")
(xbindkey '(KP_Multiply)            "echo D4 > /tmp/pitch; user-daemon-toggle la.service")
(xbindkey '(KP_Subtract)            "echo A4 > /tmp/pitch; user-daemon-toggle la.service")
(xbindkey '(KP_Add)                 "echo E5 > /tmp/pitch; user-daemon-toggle la.service")
;(xbindkey '(KP_Begin)               "false && sw-audio-outputs | sh")
(xbindkey '(KP_Right)               "false && ~/code/ruby/util/apklust.rb")

(xbindkey '(KP_Enter)               "mpc toggle")
(xbindkey '(KP_Down)                "mpc prev")
(xbindkey '(KP_Next)                "mpc next")

(xbindkey '(KP_Left)                "amixer set Master 3%+")
(xbindkey '(KP_End)                 "amixer set Master toggle")
(xbindkey '(KP_Down)                "temporary-sound-off")
(xbindkey '(shift KP_End)           "amixer set Master off")
(xbindkey '(KP_Insert)              "amixer set Master 3%-")

(xbindkey '(XF86AudioPlay)          "mpc toggle")
(xbindkey '(XF86AudioStop)          "mpc stop")
(xbindkey '(XF86AudioNext)          "mpc next")
(xbindkey '(XF86AudioPrev)          "mpc prev")

; /sound

(xbindkey '(Mod4 alt     grave)     "oneliners")
(xbindkey '(Mod4         space)     "runner")
(xbindkey '(Mod4 shift   space)     "chromium-runner")
(xbindkey '(Mod4 control space)     "clip-pipe vipe")
(xbindkey '(Mod4 alt     space)     "clip-pipe sh")
(xbindkey '(Mod4 shift   grave)     "mapclip paste && alert || alert 0.4 c")
(xbindkey '(Mod4 F1)                "surf -- \"$(c -o)\"")

; arbitrary, quick to change shell commands

(xbindkey '(Mod4       quotedbl)      "action")
(xbindkey '(Mod4 Shift quotedbl)      "action shift")
(xbindkey '(Mod4       bracketleft)   "action bracketleft")
(xbindkey '(Mod4       bracketright)  "action bracketright")
(xbindkey '(Mod4       minus)         "action minus")
(xbindkey '(Mod4       equal)         "action equal")
