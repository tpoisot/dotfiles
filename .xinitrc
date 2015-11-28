setxkbmap ca
xrdb .Xresources
xbindkeys
compton -CGb
xset +fp /user/share/fonts/misc
xset +fp /user/share/fonts/local
feh --bg-scale ~/.config/wallpaper.png &
sxhkd &
urxvt &
exec bspwm

