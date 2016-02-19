#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# This is not the 1970s anymore, so ^S and ^Q can go ^F themselves
if [ -t 0 ];
then
   stty sane
   stty stop ''
   stty start ''
   stty werase ''
fi

# Various ls aliases
alias ls='ls --color=auto -F'     # use color
alias lsh='ls -lh'                # list sizes
alias lsa='lsh -A'                # and hidden files

# Various utilities
#alias xr="xrdb ~/.Xresources"     # Reload X resources
xr() {
   xrdb ~/.Xresources
   xsetroot -solid "#$(xrdb -q | grep background | cut -d# -f2)"
   feh --bg-fill --no-xinerama ~/.config/wallpaper.png 
}

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

    Black='\[\e[00;30m\]'
    Red='\[\e[00;31m\]'
    Green='\[\e[00;32m\]'
    Yellow='\[\e[00;33m\]'
    Blue='\[\e[00;34m\]'
    Purple='\[\e[00;35m\]'
    Cyan='\[\e[00;36m\]'
    White='\[\e[00;37m\]'

    BoldRed='\[\e[01;31m\]'
    BoldGreen='\[\e[01;32m\]'
    BoldYellow='\[\e[01;33m\]'
    BoldBlue='\[\e[01;34m\]'
    BoldPurple='\[\e[01;35m\]'
    BoldCyan='\[\e[01;36m\]'

    Reset='\[\e[00m\]'

    Failure=''
    Success=''

    # Add a bright white exit status for the last command
    PS1=""
    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $Last_Command == 0 ]]; then
        PS1+="$BoldGreen$Success"
    else
        PS1+="$BoldRed$Failure"
    fi
    PS1+="$Reset"
    PS1+=" $Blue\\W$Reset"
    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.
    if [[ $EUID == 0 ]]; then
        PS1+="$Red ROOT "
    else
        git_status=$(LANG=en_US git status 2> /dev/null)
        on_branch="On branch ([^${IFS}]*)"
        on_commit="HEAD detached at ([^${IFS}]*)"
        git_message=""
        have_added=0
        if [[ $git_status =~ "nothing to commit" ]]; then
            color="$Green"
            message="clean"
            git_message+="$color$message"
            have_added=1
        fi
        if [[ $git_status =~ "not staged for commit" ]]; then
            if [[ $have_added == 1 ]]; then git_message+="$White/"; fi
            have_added=1
            color="$Red"
            message="dirty"
            git_message+="$color$message"
        fi
        if [[ $git_status =~ "Untracked" ]]; then
            if [[ $have_added == 1 ]]; then git_message+="$White/"; fi
            have_added=1
            color="$Yellow"
            message="new"
            git_message+="$color$message"
        fi
        if [[ $git_status =~ "to be committed" ]]; then
            if [[ $have_added == 1 ]]; then git_message+="$White/"; fi
            have_added=1
            color="$Cyan"
            message="commit"
            git_message+="$color$message"
        fi
        if [[ $git_status =~ "Your branch is ahead of" ]]; then
            if [[ $have_added == 1 ]]; then git_message+="$White/"; fi
            have_added=1
            color="$Purple"
            message="staged"
            git_message+="$color$message"
        fi
        if [[ $git_status =~ $on_branch ]]; then
            git_where=${BASH_REMATCH[1]}
            PS1+="$Magenta  $Black$git_where$White  $git_message" 
        elif [[ $git_status =~ $on_commit ]]; then
            git_where=${BASH_REMATCH[1]}
            PS1+="$Magenta  $Black$git_where$White  $git_message" 
        fi
    fi
    # Print the working directory and prompt marker in blue, and reset
    # the text color to the default.
    PS1+=" $Yellow> $Reset"
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

# dmenu
#alias dmenu_run='dmenu_run -nb "#$(xrdb -q | grep background | cut -d# -f2)" -nf "$(getcolor 0)" -sb "#04fe31"'

# Julia
JULIA_INPUT_COLOR=blue
JULIA_ANSWER_COLOR=normal
export JULIA_ANSWER_COLOR
export JULIA_INPUT_COLOR
