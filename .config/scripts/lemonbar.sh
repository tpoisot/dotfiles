#! /usr/bin/bash

W() {
   FG=$(xrdb -q | grep fore | cut -d: -f2 | tr -d '\t')
   #echo -n "%{F$FG}%{U-}"
   echo -n "%{F#BBBBBB}%{U-}"
}

C() {
   COL=$(getcolor $1)
   # NOTE This effectively removes everything
   #echo -n "%{F$COL}"
   echo -n "%{F#FFFFFF}"
}

U() {
   COL=$(getcolor $1)
   #echo -n "%{U$COL+u}"
   echo -n "%{U#FFFFFF+u}"
}

Clock() {
   DATE=$(date "+%d/%m/%y")
   HOUR=$(date "+%k:%M")
   echo -e "$(W)\uf133 $(C 8)$DATE $(W)\uf017$(C 8) $HOUR"
}

Sep() {
    echo -e "$(W)            $(W) "
}

Email() {
   ALL=$(find ~/.mail/INBOX/cur -type f | wc -l | tr -d '\n')
   NEW=$(find ~/.mail/INBOX/new -type f | wc -l | tr -d '\n')
   DFT=$(find ~/.mail/Drafts/ -type f | wc -l | tr -d '\n')
   echo -e "\uf003 $(C 3)$ALL $(W)\uf0e0 $(C 4)$NEW$(W) \uf0f6 $(C 6)$DFT$(W)"
}

Wifi() {
   SSID=$(iwgetid -r)
   echo -e "\uf1eb $(C 1)$SSID$(W)"
}

Battery() {
   POW=$(acpi --battery | cut -d, -f2 | cut -d% -f1)
   # Status
   status=$(acpi --battery | cut -d' ' -f3 | sed 's/,//')
   message=""
   if test $status = "Discharging"
   then
      message=" $(C 8)$(acpi --battery | cut -d' ' -f5 | cut -d: -f1-2 | sed 's/:/h/')m left"
   fi
   if test $status = "Charging"
   then
      message=" $(C 8)$(acpi --battery | cut -d' ' -f5 | cut -d: -f1-2 | sed 's/:/h/')m to go"
   fi
   echo -e "\uf240$(C 5)$POW%$message$(W)"
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
         WLIST="$WLIST $(C 8)$(expr ${e:1:2} + 1)$(W)"
      elif [ "${e:0:1}" == "o" ]; then
         WLIST="$WLIST $(U 8)$(C 8)$(expr ${e:1:2} + 1)$(W)"
      fi
   done
   echo -n "$WLIST"
}

HDD() {
   # /
   HD="$(W)/"
   HD="$HD $(C 2)$(df -h / | tail -n 1 | awk '{print $5}')"
   # /home
   HD="$HD  $(W)~"
   HD="$HD $(C 2)$(df -h /home | tail -n 1 | awk '{print $5}')"
   echo -e "\uf0a0 $HD"
}

Sound() {
   SSTAT=$(amixer get Master | tail -n 1 | awk '{print $6}' | tr -d '\n' | tr -d '[]')
   SVOL=$(amixer get Master | tail -n 1 | awk '{print $4}' | tr -d '\n' | tr -d '[]')
   if test $SSTAT = "on"
   then
      SND="\uf028 "
      SND="$SND$(C 4)$SVOL"
   else
      SND="\uf026 "
      SND="$SND$(C 8)$SVOL"
   fi
   MSTAT=$(amixer get Mic | tail -n 1 | awk '{print $7}' | tr -d '\n' | tr -d '[]')
   MVOL=$(amixer get Mic | tail -n 1 | awk '{print $5}' | tr -d '\n' | tr -d '[]')
   if test $MSTAT = "on"
   then
       MIC="\uf130"
       SND="$SND  $(W)$MIC $(C 4)$MVOL"
   else
       MIC="\uf131"
       SND="$SND  $(W)$MIC $(C 8)$MVOL"
   fi
   echo -e "$SND"
}

Spotify () {
   isrunning=`pidof spotify | wc -l`
   if test $isrunning = 1
   then
      status=`dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'`
      ispaused=$(echo "$status" | grep "mpris:length" -a1 | tail -n1 | cut -d\t -f3 | cut -d' ' -f2)
      if test $ispaused = 0
      then
         echo -e "\uf1bc $(C 8)not playing"
      else
         artist=$(echo "$status" | grep "xesam:artist" -b2 | tail -n 1 | cut -d'"' -f2)
         title=$(echo "$status" | grep "xesam:title" -b1 | tail -n 1 | cut -d'"' -f2)
         echo -e "\uf1bc $(C 6)$title $(C 8)by $(C 14)$artist"
      fi
   else
      echo -e "\uf1bc $(C 8)closed"
   fi
}

while true; do
   # Clock, emails
   status="$(W)$(Clock)$(Sep)$(Email)"
   # Wifi
   if test $(iwgetid -r | wc -l) = 1
   then
      status="$status$(Sep)$(Wifi)"
   fi
   # Battery, HDD, Volume
   status="$status$(Sep)$(Battery)$(Sep)$(HDD)$(Sep)$(Sound)"
   # Spotify
   if test $(pidof spotify | wc -l) = 1
   then
      status="$status$(Sep)$(Spotify)"
   fi
   # Caps lock
   if test $(xset q | grep Caps | cut -d: -f3 | cut -d' ' -f4) = "on"
   then
      status="$status$(Sep) \uf023 $(C 1)Caps locked"
   fi
   # Backup running
   if test $(ps aux | grep "python2 /usr/bin/duplicity" | grep -v grep | head -n 1 | wc -l) = 1
   then
      status="$status$(Sep)\uf1c0 $(C 3)Backing up"
   fi
   # Workspace indicator
   status="$status%{r}$(Workspace)"
   echo -e "$status"
   sleep 1;
done
