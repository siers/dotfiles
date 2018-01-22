#!/usr/bin/env bash

date >> /tmp/x
espeak xinitrc

cat ~/.fehbg | zsh      &
xset -b                 &
xset r rate 200 25      &

if [ "$(hostname)" == 'spiral' ]; then
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    xrdb -merge ~/.Xresources

    #xrandr -s 1600x900 || exit
    xrandr -s 3840x2160 || exit
fi

#anamnesis --start                     &
autocutsel -fork                      &
autocutsel -selection PRIMARY -fork   &
unclutter -jitter 2 -noevents -idle 2 &
#xdg-user-dirs-update                  &
xsetroot -cursor_name left_prt        &

xss-lock lock                         &
xbindkeys                             &
dunst                                 &
urxvtd                                &
udiskie                               &
term in-tag                           &

~/code/desktop/symbols/make

#exec dbus-launch openbox-session
#exec dbus-launch herbstluftwm
exec dbus-launch i3
