eval $(ssh-agent)
setxkbmap ca
xrdb .Xresources
xbindkeys
xset +fp /usr/share/fonts/misc
xset +fp /usr/share/fonts/local
feh --bg-fill --no-xinerama ~/.config/wallpaper.png &
compton --shadow-exclude '!focused' -c -i 0.95 -b -G -C&
exec bspwm
