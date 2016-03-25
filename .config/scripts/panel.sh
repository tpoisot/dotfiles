#! /bin/bash

lemonbarrunning=`pidof lemonbar | wc -w`
connectedscreens=`xrandr | grep " HDMI2" | wc -l`

if test $connectedscreens = 1
then
   activescreen=`xrandr | grep "HDMI2" | cut -d' ' -f1`
else
   activescreen=`xrandr | grep "eDP1" | cut -d' ' -f1`
fi;

background=$(grep "background\s" ~/.config/termite/config | cut -d= -f2 | tr -d ' ' | tr -d '#')
foreground=$(grep "foreground\s" ~/.config/termite/config | cut -d= -f2 | tr -d ' ' | tr -d '#')

if test $lemonbarrunning = 1
then
   bspc config -m $activescreen bottom_padding 0
   bspc config -m $activescreen top_padding 0
   killall lemonbar
   for pid in $(ps -ef | grep "lemonbar.sh" | awk '{print $2}'); do kill -9 $pid; done
else
   bspc config -m $activescreen top_padding 27
   bspc config -m $activescreen bottom_padding 0
   ~/.config/scripts/lemonbar.sh | lemonbar -B"#$background" -F"#$foreground" -g1920x27+0+0 -u1 -f IosevkaNL-11 -f FontAwesome-11 -o 0 -d & 
fi;

