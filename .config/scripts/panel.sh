#! /bin/bash

lemonbarrunning=`ps aux | grep -v grep | grep -v vim | grep lemonbar | wc -l`
connectedscreens=`xrandr | grep " HDMI2" | wc -l`

if test $connectedscreens = 1
then
   activescreen=`xrandr | grep "HDMI2" | cut -d' ' -f1`
else
   activescreen=`xrandr | grep "eDP1" | cut -d' ' -f1`
fi;

background=`xrdb -q | grep back | cut -f2 -d#`
foreground=`xrdb -q | grep fore | cut -f2 -d#`

if test $lemonbarrunning = 2
then
   bspc config -m $activescreen top_padding 0
   killall lemonbar
else
   bspc config -m $activescreen top_padding 13
   ~/.config/scripts/lemonbar.sh | lemonbar -f "Input:size=10" -B"#$background" -F"#$foreground" -o 4 -gx+14 & 
fi;

