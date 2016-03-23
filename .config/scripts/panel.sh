#! /bin/bash

lemonbarrunning=`pidof lemonbar | wc -w`
connectedscreens=`xrandr | grep " HDMI2" | wc -l`

if test $connectedscreens = 1
then
   activescreen=`xrandr | grep "HDMI2" | cut -d' ' -f1`
else
   activescreen=`xrandr | grep "eDP1" | cut -d' ' -f1`
fi;

background=`xrdb -q | grep back | cut -f2 -d#`
foreground=`xrdb -q | grep fore | cut -f2 -d#`

# If compton is running, transparent bar
if test $(pidof compton | wc -l) = 1
then
   background="00$background"
fi
background="1d1f21"
foreground="FFFFFF" 

if test $lemonbarrunning = 1
then
   bspc config -m $activescreen bottom_padding 0
   bspc config -m $activescreen top_padding 0
   killall lemonbar
else
   bspc config -m $activescreen top_padding 27
   bspc config -m $activescreen bottom_padding 0
   ~/.config/scripts/lemonbar.sh | lemonbar -B"#$background" -F"#$foreground" -g1920x27+0+0 -u1 -f IosevkaNL-10 -f FontAwesome-11 -o 0 -d & 
   #~/.config/scripts/lemonbar.sh | lemonbar -B"#$background" -F"#$foreground" -g1920x19 -u1 -f IosevkaNL-10 -o 0 -b -d & 
fi;

