set -x

## unused, I guess

exec &> /tmp/x

. ~/.config/zsh/env

xset -b            &
xset r rate 200 25 &

if [ "$(hostname)" == 'spiral' ]; then
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    xrdb -merge ~/.Xresources

    #xrandr -s 1600x900 || exit
    xrandr -s 3840x2160 || exit
fi

# set any first output as --primary
xrandr --output "$(xrandr | grep ' connected' | awk ' {if (!(NR-1)) print $1}')" --primary

autocutsel -fork                      &
autocutsel -selection PRIMARY -fork   &
unclutter -jitter 2 -noevents -idle 2 &
xsetroot -cursor_name left_prt        &

xss-lock lock    &
xbindkeys        &
dunst            &
urxvtd           &
#udiskie          &
libinput-gestures &

~/code/desktop/symbols/make &

exec herbstluftwm
