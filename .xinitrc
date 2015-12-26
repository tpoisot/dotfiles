setxkbmap ca
xrdb .Xresources
xbindkeys
xset +fp /user/share/fonts/misc
xset +fp /user/share/fonts/local
xsetroot -solid "#$(xrdb -q | grep background | cut -d# -f2)" &
sxhkd &
urxvt &
export CONKY_WIDTH=$(grep 'maximum_width' ~/.config/conky/conky.conf | cut -d' ' -f6 | cut -d, -f1)
conky &
xdotool search --onlyvisible --classname 'Conky' windowunmap 
exec bspwm
