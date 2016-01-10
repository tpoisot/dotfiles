setxkbmap ca
xrdb .Xresources
xbindkeys
xset +fp /user/share/fonts/misc
xset +fp /user/share/fonts/local
xsetroot -solid "#$(xrdb -q | grep background | cut -d# -f2)" &
sxhkd &
xterm &
exec bspwm
