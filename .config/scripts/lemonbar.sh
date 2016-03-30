#! /usr/bin/bash

tcol() { # Get the termite color
    grep "$1\s" ~/.config/termite/config | cut -d= -f2 | tr -d ' ' | tr -d '#' 
}

fcol() { # Foreground
    echo -n "%{F#$(tcol $1)}"
}

ucol() { # Foreground
    echo -n "%{U#$(tcol $1)}"
}

reset() { # Reset
    echo -n "$(fcol foreground)%{U-}"
}

icon() {
    echo -n "$(fcol color15)"
}

rsep() {
    echo -e "  $(fcol color7)$(reset)  "
}

lsep() {
    echo -e "  $(fcol color7)$(reset)  "
}

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
   echo -e "$(icon)\uf133 $(fcol color3)$DATE $(icon)\uf017$(fcol color11) $HOUR"
}

Sep() {
    echo -e "$(W)        $(W) "
}

Email() {
   ALL=$(find ~/.mail/INBOX/cur -type f | wc -l | tr -d '\n')
   NEW=$(find ~/.mail/INBOX/new -type f | wc -l | tr -d '\n')
   DFT=$(find ~/.mail/Drafts/ -type f | wc -l | tr -d '\n')
   echo -e "$(icon)\uf003 $(fcol color3)$ALL $(icon)\uf0e0 $(fcol color11)$NEW$(icon) \uf0f6 $(fcol color3)$DFT$(reset)"
}

Wifi() {
   SSID=$(iwgetid -r)
   echo -e "$(icon)\uf1eb $(fcol color2)$SSID$(reset)"
}

Battery() {
   POW=$(acpi --battery | cut -d, -f2 | cut -d% -f1)
   # Status
   status=$(acpi --battery | cut -d' ' -f3 | sed 's/,//')
   timeleft="$(fcol color4)$(acpi --battery | cut -d' ' -f5 | cut -d: -f1-2 | sed 's/:/h/')m"
   if test $status = "Discharging"
   then
       message=" $(fcol color9)▼ $timeleft"
   fi
   if test $status = "Charging"
   then
       message=" $(fcol color10)▲ $timeleft"
   fi
   echo -e "$(icon)\uf240$(fcol color12)$POW%$message$(D)"
}

Workspace() {
    empty="○"
    occupied="●"
    WSI=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
    WLIST=""
    #for workspace in 0 1 2 3 4
    #for e in $(bspc control --get-status | cut -d':' -f2-6 | tr ':' '\n')
    # List of desktops
    DESK=($(wmctrl -d | cut -d' ' -f1 | sort))

    # List of desktops with active windows
    OCCUPIED=($(wmctrl -l | cut -d' ' -f3 | sort | uniq))

    # Loop
    for i in $(eval echo "{1..${#DESK[@]}}")
    do
        CURRENTFORMAT="$(reset)"

        # Get the occupation status
        marker="$empty"
        for havew in ${OCCUPIED[@]}
        do
            if [[ $havew == $(expr $i - 1) ]]; then
                marker="$occupied"
            fi
        done
        
        # Get the current activity status
        ISACTIVE=$(wmctrl -d | sed "$i q;d" | cut -d' ' -f3)
        if [[ $ISACTIVE == *"*"* ]]; then
            CURRENTFORMAT+="$(fcol color1)"
        else
            CURRENTFORMAT+="$(fcol color7)"
        fi

        # Output
        echo -n " $CURRENTFORMAT$marker$(reset)"

    done
}

HDD() {
   # /
   HD="$(fcol color15)/"
   HD="$HD $(fcol color5)$(df -h / | tail -n 1 | awk '{print $5}')"
   # /home
   HD="$HD  $(fcol color15)~"
   HD="$HD $(fcol color13)$(df -h /home | tail -n 1 | awk '{print $5}')"
   echo -e "$(icon)\uf0a0 $HD$(reset)"
}

Sound() {
   SSTAT=$(amixer get Master | tail -n 1 | awk '{print $6}' | tr -d '\n' | tr -d '[]')
   SVOL=$(amixer get Master | tail -n 1 | awk '{print $4}' | tr -d '\n' | tr -d '[]')
   if test $SSTAT = "on"
   then
       SND="$(icon)\uf028 "
       SND="$SND$(fcol color14)$SVOL"
   else
       SND="$(icon)\uf026 "
       SND="$SND$(fcol color6)$SVOL"
   fi
   MSTAT=$(amixer get Mic | tail -n 1 | awk '{print $7}' | tr -d '\n' | tr -d '[]')
   MVOL=$(amixer get Mic | tail -n 1 | awk '{print $5}' | tr -d '\n' | tr -d '[]')
   if test $MSTAT = "on"
   then
       MIC="$(icon)\uf130"
       SND="$SND  $MIC $(fcol color14)$MVOL"
   else
       MIC="$(icon)\uf131"
       SND="$SND  $MIC $(fcol color6)$MVOL"
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
         echo -e "$(icon)\uf1bc $(fcol color5)$title $(icon)by $(fcol color13)$artist"
      fi
   else
       echo -e "$(icon)\uf1bc $(fcol color8)closed"
   fi
}

Cal(){
    next=$(gcalcli agenda --nocolor --nostarted | head -2 | tail -1)
    echo -e "$(icon)\uf274 $(fcol color7)$next"
}

while true; do
   # Clock, emails
   status="$(Email)"
   # Wifi
   if test $(iwgetid -r | wc -l) = 1
   then
      status="$status$(rsep)$(Wifi)"
   fi
   # Battery, HDD, Volume
   status="$status$(rsep)$(Battery)$(rsep)$(HDD)$(rsep)$(Sound)"
   # Spotify
   if test $(pidof spotify | wc -l) = 1
   then
      status="$status$(rsep)$(Spotify)"
   fi
   # Caps lock
   if test $(xset q | grep Caps | cut -d: -f3 | cut -d' ' -f4) = "on"
   then
       status="$status$(rsep) $(icon)\uf023 $(fcol color1)Caps locked"
   fi
   # Workspace indicator
   status="$status%{r}"
   status+="$(Workspace)"
   # Backup running
   if test $(ps aux | grep "python2 /usr/bin/duplicity" | grep -v grep | head -n 1 | wc -l) = 1
   then
       status+="$(lsep)$(icon)\uf1c0 $(fcol color1)Backing up"
   fi
   #status+="$(lsep)$(Cal)"
   status+="$(lsep)$(Clock)"
   echo -e " $status "
   sleep 1;
done
