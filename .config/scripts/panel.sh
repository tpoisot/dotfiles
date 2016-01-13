#! /bin/bash

lemonbarrunning=`pidof lemonbar | wc -w`
connectedscreens=`xrandr | grep " HDMI2" | wc -l`
xftfont=`xrdb -q | grep faceName | sed 's/*.faceName://g' | tr -d '\t' | sed 's/xft://g'`

if test $connectedscreens = 1
then
   activescreen=`xrandr | grep "HDMI2" | cut -d' ' -f1`
else
   activescreen=`xrandr | grep "eDP1" | cut -d' ' -f1`
fi;

background=`xrdb -q | grep back | cut -f2 -d#`
foreground=`xrdb -q | grep fore | cut -f2 -d#`

if test $lemonbarrunning = 1
then
   bspc config -m $activescreen top_padding 0
   killall lemonbar
else
   bspc config -m $activescreen top_padding 13
   ~/.config/scripts/lemonbar.sh | lemonbar -f "$xftfont" -B"#$background" -F"#$foreground" -g1889x17+14+6 -u1 & 
fi;

