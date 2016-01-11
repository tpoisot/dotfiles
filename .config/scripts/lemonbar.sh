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
   echo -n "$(W)  $(C 7)::$(W)  "
}

Email() {
   ALL=$(find ~/.mail/INBOX/cur -type f | wc -l | tr -d '\n')
   NEW=$(find ~/.mail/INBOX/new -type f | wc -l | tr -d '\n')
   DFT=$(find ~/.mail/Drafts/ -type f | wc -l | tr -d '\n')
   echo -n "$(C 3)$ALL$(W) I  $(C 4)$NEW$(W) N  $(C 6)$DFT$(W) D"
}

Wifi() {
   SSID=$(iwgetid -r)
   echo -n "$(W)W $(C 1)$SSID$(W)"
}

Battery() {
   BAT=$(acpi --battery | cut -d, -f2)
   echo -n "$(W)P$(C 5)$BAT$(W)"
}

Workspace() {
   WSI=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
   WLIST=""
   #for workspace in 0 1 2 3 4
   for e in $(bspc control --get-status | cut -d':' -f2-6 | tr ':' '\n')
   do
      if [ "${e:0:1}" == "O" ]; then
         WLIST="$WLIST $(C 2)$(U 10)$(expr ${e:1:2} + 1)$(W)"
      elif [ "${e:0:1}" == "F" ]; then
         WLIST="$WLIST $(C 2)$(expr ${e:1:2} + 1)$(W)"
      elif [ "${e:0:1}" == "f" ]; then
         WLIST="$WLIST $(C 15)$(expr ${e:1:2} + 1)$(W)"
      elif [ "${e:0:1}" == "o" ]; then
         WLIST="$WLIST $(U 10)$(C 15)$(expr ${e:1:2} + 1)$(W)"
      fi
   done
   echo -n "%{r}$WLIST  "
}

HDD() {
   # /
   HD="$(W)/"
   HD="$HD $(C 2)$(df -h / | tail -n 1 | awk '{print $5}')"
   # /home
   HD="$HD  $(W)~"
   HD="$HD $(C 2)$(df -h /home | tail -n 1 | awk '{print $5}')"
   echo -n "$HD"
}

Sound() {
   SND="$(W)V "
   SSTAT=$(amixer get Master | tail -n 1 | awk '{print $6}' | tr -d '\n' | tr -d '[]')
   SVOL=$(amixer get Master | tail -n 1 | awk '{print $4}' | tr -d '\n' | tr -d '[]')
   if test $SSTAT = "on"
   then
      SND="$SND$(C 4)$SVOL"
   else
      SND="$SND$(C 7)$SVOL"
   fi
   MSTAT=$(amixer get Mic | tail -n 1 | awk '{print $7}' | tr -d '\n' | tr -d '[]')
   MVOL=$(amixer get Mic | tail -n 1 | awk '{print $5}' | tr -d '\n' | tr -d '[]')
   if test $MSTAT = "on"
   then
      SND="$SND  $(W)M $(C 4)$MVOL"
   else
      SND="$SND  $(W)M $(C 7)$MVOL"
   fi
   echo -n "$SND"
}

# Spotify
# dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'

while true; do
   echo "$(W)$(Clock)$(Sep)$(Email)$(Sep)$(Wifi)$(Sep)$(Battery)$(Sep)$(HDD)$(Sep)$(Sound)$(Workspace)"
   sleep 1;
done
