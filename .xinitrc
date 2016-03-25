eval $(ssh-agent)
setxkbmap ca
xrdb .Xresources
xbindkeys
xset +fp /usr/share/fonts/misc
xset +fp /usr/share/fonts/local
xsetroot -solid "#$(xrdb -q | grep background | cut -d# -f2)" &
feh --bg-fill --no-xinerama ~/.config/wallpaper.png &
compton --shadow-exclude '!focused' -c -i 0.95 &
exec bspwm
