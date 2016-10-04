#!/bin/sh

exec &> /var/tmp/xlog

cat $HOME/.fehbg | zsh  &
xset -b                 &
xset r rate 200 25      &

if [ "$(hostname)" == 'spiral' ]; then
    #xrandr -s 1600x900 || exit
    xrandr -s 3840x2160 || exit
    xrdb -merge ~/.Xresources
fi

autocutsel -fork                      &
autocutsel -selection PRIMARY -fork   &
unclutter -jitter 2 -noevents -idle 2 &
xsetroot -cursor_name left_prt        &
xdg-user-dirs-update                  &

xbindkeys                             &
dunst                                 &
urxvtd                                &
udiskie                               &
term in-tag                           &

make -C $HOME/code/desktop/symbols &> /dev/null  &

(
    sleep 3
    panel &
    #skype &
    on-tag status term in-tag &
) &

#exec dbus-launch sh -c 'strace herbstluftwm 2> /tmp/herbitrace'
#exec dbus-launch strace herbstluftwm 2> /tmp/herbitrace
#exec dbus-launch openbox-session
exec dbus-launch herbstluftwm
