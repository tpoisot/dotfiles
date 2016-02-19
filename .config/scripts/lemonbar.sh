#! /usr/bin/bash

A() { # Active
    echo -n "%{F#F5F5F5}%{U-}"
}

I() { # Info
    echo -n "%{F#CCCCCC}%{U-}"
}

D() { # Dimmed
    echo -n "%{F#333333}%{U-}"
}

U() {
   echo -n "%{U#D5D5D5+u}"
}

Clock() {
   DATE=$(date "+%d/%m/%y")
   HOUR=$(date "+%k:%M")
   echo -e "$(D)\uf133 $(I)$DATE $(D)\uf017$(I) $HOUR"
}

Sep() {
    echo -e "$(W)        $(W) "
}

Email() {
   ALL=$(find ~/.mail/INBOX/cur -type f | wc -l | tr -d '\n')
   NEW=$(find ~/.mail/INBOX/new -type f | wc -l | tr -d '\n')
   DFT=$(find ~/.mail/Drafts/ -type f | wc -l | tr -d '\n')
   echo -e "$(D)\uf003 $(A)$ALL $(D)\uf0e0 $(A)$NEW$(D) \uf0f6 $(A)$DFT$(D)"
}

Wifi() {
   SSID=$(iwgetid -r)
   echo -e "$(D)\uf1eb $(A)$SSID$(D)"
}

Battery() {
   POW=$(acpi --battery | cut -d, -f2 | cut -d% -f1)
   # Status
   status=$(acpi --battery | cut -d' ' -f3 | sed 's/,//')
   message=""
   if test $status = "Discharging"
   then
      message=" $(I)$(acpi --battery | cut -d' ' -f5 | cut -d: -f1-2 | sed 's/:/h/')m left"
   fi
   if test $status = "Charging"
   then
      message=" $(I)$(acpi --battery | cut -d' ' -f5 | cut -d: -f1-2 | sed 's/:/h/')m to go"
   fi
   echo -e "$(D)\uf240$(A)$POW%$message$(D)"
}

Workspace() {
   WSI=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
   WLIST=""
   #for workspace in 0 1 2 3 4
   for e in $(bspc control --get-status | cut -d':' -f2-6 | tr ':' '\n')
   do
      if [ "${e:0:1}" == "O" ]; then
         WLIST="$WLIST $(A)$(U)$(expr ${e:1:2} + 1)$(D)"
      elif [ "${e:0:1}" == "F" ]; then
         WLIST="$WLIST $(A)$(expr ${e:1:2} + 1)$(D)"
      elif [ "${e:0:1}" == "f" ]; then
         WLIST="$WLIST $(D)$(expr ${e:1:2} + 1)$(D)"
      elif [ "${e:0:1}" == "o" ]; then
          WLIST="$WLIST $(D)$(U)$(expr ${e:1:2} + 1)$(D)"
      fi
   done
   echo -n "$WLIST"
}

HDD() {
   # /
   HD="$(A)/"
   HD="$HD $(I)$(df -h / | tail -n 1 | awk '{print $5}')"
   # /home
   HD="$HD  $(A)~"
   HD="$HD $(I)$(df -h /home | tail -n 1 | awk '{print $5}')"
   echo -e "$(D)\uf0a0 $HD"
}

Sound() {
   SSTAT=$(amixer get Master | tail -n 1 | awk '{print $6}' | tr -d '\n' | tr -d '[]')
   SVOL=$(amixer get Master | tail -n 1 | awk '{print $4}' | tr -d '\n' | tr -d '[]')
   if test $SSTAT = "on"
   then
       SND="$(D)\uf028 "
       SND="$SND$(A)$SVOL"
   else
       SND="$(D)\uf026 "
       SND="$SND$(I)$SVOL"
   fi
   MSTAT=$(amixer get Mic | tail -n 1 | awk '{print $7}' | tr -d '\n' | tr -d '[]')
   MVOL=$(amixer get Mic | tail -n 1 | awk '{print $5}' | tr -d '\n' | tr -d '[]')
   if test $MSTAT = "on"
   then
       MIC="$(D)\uf130"
       SND="$SND  $MIC $(A)$MVOL"
   else
       MIC="$(D)\uf131"
       SND="$SND  $MIC $(I)$MVOL"
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
          echo -e "$(D)\uf1bc $(I)not playing"
      else
         artist=$(echo "$status" | grep "xesam:artist" -b2 | tail -n 1 | cut -d'"' -f2)
         title=$(echo "$status" | grep "xesam:title" -b1 | tail -n 1 | cut -d'"' -f2)
         echo -e "$(D)\uf1bc $(A)$title $(I)by $(A)$artist"
      fi
   else
       echo -e "$(D)\uf1bc $(I)closed"
   fi
}

while true; do
   # Clock, emails
   status="$(D)$(Clock)$(Sep)$(Email)"
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
       status="$status$(Sep) $(D)\uf023 $(A)Caps locked"
   fi
   # Backup running
   if test $(ps aux | grep "python2 /usr/bin/duplicity" | grep -v grep | head -n 1 | wc -l) = 1
   then
       status="$status$(Sep)$(D)\uf1c0 $(A)Backing up"
   fi
   # Workspace indicator
   status="$status%{r}$(Workspace)"
   echo -e "$status"
   sleep 1;
done
