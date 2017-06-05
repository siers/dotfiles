#!/bin/sh

exec &> /var/tmp/xlog

cat ~/.fehbg | zsh  &
xset -b                 &
xset r rate 200 25      &

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
xrdb -merge ~/.Xresources

if [ "$(hostname)" == 'spiral' ]; then
    #xrandr -s 1600x900 || exit
    xrandr -s 3840x2160 || exit
fi

anamnesis --start                     &
autocutsel -fork                      &
autocutsel -selection PRIMARY -fork   &
unclutter -jitter 2 -noevents -idle 2 &
xsetroot -cursor_name left_prt        &
xdg-user-dirs-update                  &

xss-lock lock                         &
xbindkeys                             &
dunst                                 &
urxvtd                                &
udiskie                               &
term in-tag                           &

~/code/desktop/symbols/make

(
    sleep 3
    panel &
    #skype &
) &

#exec dbus-launch sh -c 'strace herbstluftwm 2> /tmp/herbitrace'
#exec dbus-launch strace herbstluftwm 2> /tmp/herbitrace
#exec dbus-launch openbox-session
exec dbus-launch herbstluftwm
