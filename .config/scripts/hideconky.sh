#! /bin/bash

connectedscreens=`xrandr | grep " connected" | wc -l`

if test $connectedscreens = 1
then
   activescreen=`xrandr | grep " connected" | cut -d' ' -f1`
else
   activescreen=`xrandr | grep primary | cut -d' ' -f1`
fi;


if xdotool search --onlyvisible --classname 'Conky' windowunmap;
then
   bspc config -m $activescreen right_padding 0;
else
   bspc config -m $activescreen right_padding 200;
   xdotool search --classname 'Conky' windowmap 
fi;
