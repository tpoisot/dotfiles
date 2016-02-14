eval $(ssh-agent)
compton &
setxkbmap ca
xrdb .Xresources
xbindkeys
xset +fp /usr/share/fonts/misc
xset +fp /usr/share/fonts/local
xsetroot -solid "#$(xrdb -q | grep background | cut -d# -f2)" &
feh --bg-fill --no-xinerama ~/.config/wallpaper.png &
sxhkd &
exec bspwm
