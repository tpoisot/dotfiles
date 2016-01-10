#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Various ls aliases
alias ls='ls --color=auto -F'     # use color
alias lsh='ls -lh'                # list sizes
alias lsa='lsh -A'                # and hidden files

# Various utilities
alias xr="xrdb ~/.Xresources"     # Reload X resources

# Move around
alias ..="cd .."
alias df="df -h"

# Vim
alias vin=vim
alias edit=vim

# Ranger, fast
alias r=ranger

# More sensical defaults
alias nano="nano -w"              # Nano -w
alias mkdir="mkdir -p -v"         # Recursively create dirs
alias ping="ping -c 3"            # Ping 3 times
alias tree="tree -Chs"            # Show file sizes in tree
alias unmount="umount"            # Because characters are cheap

# Grep
alias grep='grep --color=auto'

# PS1 -- ~ >>> 

set_prompt () {
   Last_Command=$? # Must come first!

   Black='\[\e[01;30m\]'
   Red='\[\e[01;31m\]'
   Green='\[\e[01;32m\]'
   Yellow='\[\e[01;33m\]'
   Blue='\[\e[01;34m\]'
   Purple='\[\e[01;35m\]'
   Cyan='\[\e[01;36m\]'
   White='\[\e[01;37m\]'

   Reset='\[\e[00m\]'

   Failure='x'
   Success='+'

   # Add a bright white exit status for the last command
   PS1="$Black["
   # If it was successful, print a green check mark. Otherwise, print
   # a red X.
   if [[ $Last_Command == 0 ]]; then
   PS1+="$Green$Success"
   else
   PS1+="$Red$Failure"
   fi
   PS1+="$Black]$Reset "
   # If root, just print the host in red. Otherwise, print the current user
   # and host in green.
   if [[ $EUID == 0 ]]; then
   PS1+="$Red\\u "
   else
   PS1+="$Purple\\u "
   fi
   # Print the working directory and prompt marker in blue, and reset
   # the text color to the default.
   PS1+="$Cyan\\W $Yellow\\\$$Reset "
}
PROMPT_COMMAND='set_prompt'

export BROWSER="vivaldi"

export PATH=$PATH:~/.gem/ruby/2.3.0/bin

eval `dircolors .dircolors`

# Get the hex color code
function getcolor() {
   xrdb -q | grep "color$1:" | cut -d: -f2 | tr -d '\t'
}
export -f getcolor
