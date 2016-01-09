#! /usr/bin/bash

# ./.config/scripts/lemonbar.sh | lemonbar -f "Input:size=11" -o 4 -g x+13
# TODO get offset and font from xrdb

W() {
   FG=$(xrdb -q | grep fore | cut -d: -f2 | tr -d '\t')
   echo -n "%{F$FG}"
}

C() {
   COL=$(getcolor $1)
   echo -n "%{F$COL}"
}

Clock() {
   DATE=$(date "+%a %b %d, %T")
   echo -n "$DATE"
}

Sep() {
   echo -n "$(W)  $(C 8)-$(W)  "
}

Email() {
   ALL=$(find ~/.mail/INBOX/cur -type f | wc -l | tr -d '\n')
   NEW=$(find ~/.mail/INBOX/new -type f | wc -l | tr -d '\n')
   DFT=$(find ~/.mail/Drafts/ -type f | wc -l | tr -d '\n')
   echo -n "$(C 3)$ALL$(W) inbox  $(C 4)$NEW$(W) new  $(C 6)$DFT$(W) drafts"
}

Wifi() {
   SSID=$(iwgetid -r)
   echo -n "$(W)SSID $(C 1)$SSID$(W)"
}

Battery() {
   BAT=$(acpi --battery | cut -d, -f2)
   echo -n "$(W)Batt. $(C 5)$BAT$(W)"
}

Workspace() {
   WSI=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
   WLIST="  "
   for workspace in 0 1 2 3 4
   do
      if test $WSI = $workspace
      then
         WLIST="$WLIST$(C 2)$(expr $workspace + 1)$(W) "
      else
         WLIST="$WLIST$(C 8)$(expr $workspace + 1)$(W) "
      fi;
   done
   echo -n "%{r}$WLIST  "
}

while true; do
   echo "$(W)$(Clock)$(Sep)$(Email)$(Sep)$(Wifi)$(Sep)$(Battery)$(Workspace)"
   sleep 1;
done
