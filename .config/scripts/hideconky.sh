#! /bin/bash

if xdotool search --onlyvisible --classname 'Conky' windowunmap;
then
   bspc config -m DP1 right_padding 0;
else
   bspc config -m DP1 right_padding 148;
   xdotool search --classname 'Conky' windowmap 
fi;
