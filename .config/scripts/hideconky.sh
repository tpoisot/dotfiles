#! /bin/bash

connectedscreens=`xrandr | grep " HDMI2" | wc -l`

if test $connectedscreens = 1
then
   activescreen=`xrandr | grep "HDMI2" | cut -d' ' -f1`
else
   activescreen=`xrandr | grep "eDP1" | cut -d' ' -f1`
fi;


if xdotool search --onlyvisible --classname 'Conky' windowunmap;
then
   bspc config -m $activescreen left_padding 0;
else
   bspc config -m $activescreen left_padding 200;
   xdotool search --classname 'Conky' windowmap 
fi;
