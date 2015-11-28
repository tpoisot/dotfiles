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

# More sensical defaults
alias nano="nano -w"              # Nano -w
alias mkdir="mkdir -p -v"         # Recursively create dirs
alias ping="ping -c 3"            # Ping 3 times
alias tree="tree -Chs"            # Show file sizes in tree
alias unmount="umount"            # Because characters are cheap

# Grep
alias grep='grep --color=auto'

# PS1 -- ~ >>> 

export PS1="\[\033[38;5;3m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] >\[$(tput sgr0)\]\[\033[38;5;7m\]>\[$(tput sgr0)\]\[\033[38;5;8m\]>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

export BROWSER="vivaldi"

export PATH=$PATH:~/.gem/ruby/2.2.0/bin

eval `dircolors .dircolors`
