#! /usr/bin/bash

# TODO get offset and font from xrdb

W() {
   FG=$(xrdb -q | grep fore | cut -d: -f2 | tr -d '\t')
   echo -n "%{F$FG}%{U-}"
}

C() {
   COL=$(getcolor $1)
   echo -n "%{F$COL}"
}

U() {
   COL=$(getcolor $1)
   echo -n "%{U$COL+u}"
}

Clock() {
   DATE=$(date "+%d/%m/%y %k:%M")
   echo -n "$DATE"
}

Sep() {
   echo -n "$(W)  $(C 7)-$(W)  "
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
   WLIST=""
   #for workspace in 0 1 2 3 4
   for e in $(bspc control --get-status | cut -d':' -f2-6 | tr ':' '\n')
   do
      if [ "${e:0:1}" == "O" ]; then
         WLIST="$WLIST $(C 4)$(U 8)$(expr ${e:1:2} + 1)$(W)"
      elif [ "${e:0:1}" == "F" ]; then
         WLIST="$WLIST $(C 4)$(expr ${e:1:2} + 1)$(W)"
      elif [ "${e:0:1}" == "f" ]; then
         WLIST="$WLIST $(C 15)$(expr ${e:1:2} + 1)$(W)"
      elif [ "${e:0:1}" == "o" ]; then
         WLIST="$WLIST $(U 8)$(C 15)$(expr ${e:1:2} + 1)$(W)"
      fi
   done
   echo -n "%{r}$WLIST  "
}

while true; do
   echo "$(W)$(Clock)$(Sep)$(Email)$(Sep)$(Wifi)$(Sep)$(Battery)$(Workspace)"
   sleep 1;
done
