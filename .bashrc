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
   feh --bg-fill --no-xinerama ~/.config/wallpaper.png 
}

# Move around
alias ..="cd .."
alias df="df -h"

# Vim -- because I can't type right
alias vin=vim
alias bim=vim
alias edit=vim

# Vivaldi
alias vivaldi=vivaldi-beta

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

    Black='\[\e[30m\]'
    Red='\[\e[31m\]'
    Green='\[\e[32m\]'
    Yellow='\[\e[33m\]'
    Blue='\[\e[34m\]'
    Purple='\[\e[35m\]'
    Cyan='\[\e[36m\]'
    White='\[\e[37m\]'

    LightBlack='\[\e[90m\]'
    LightRed='\[\e[91m\]'
    LightGreen='\[\e[92m\]'
    LightYellow='\[\e[93m\]'
    LightBlue='\[\e[94m\]'
    LightPurple='\[\e[95m\]'
    LightCyan='\[\e[96m\]'
    LightWhite='\[\e[97m\]'
    
    OnBlack='\[\e[40m\]'
    OnRed='\[\e[41m\]'
    OnGreen='\[\e[42m\]'
    OnYellow='\[\e[43m\]'
    OnBlue='\[\e[44m\]'
    OnPurple='\[\e[45m\]'
    OnCyan='\[\e[46m\]'
    OnWhite='\[\e[47m\]'
    
    OnLightBlack='\[\e[100m\]'
    OnLightRed='\[\e[101m\]'
    OnLightGreen='\[\e[102m\]'
    OnLightYellow='\[\e[103m\]'
    OnLightBlue='\[\e[104m\]'
    OnLightPurple='\[\e[105m\]'
    OnLightCyan='\[\e[106m\]'
    OnLightWhite='\[\e[107m\]'

    Reset='\[\e[00m\]'

    void=" " 
    prompt=" ▶ "
    git="" # Used when on a branch or commit
    suc="●"
    err="●"
    clean="0"
    commit="C"
    staged="S"
    new="N"
    dirty="D"

    # Add a bright white exit status for the last command
    PS1="$Reset"
    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    PS1+="$White["
    if [[ $Last_Command == 0 ]]; then
        PS1+="$Green$suc"
    else
        PS1+="$Red$err"
    fi
    PS1+="$White]"
    PS1+="$Reset$void"
    PS1+="$White[$Purple\\W$White]"
    # Depends if on git or not
    if test $(LANG=en_US git status 2> /dev/null | wc -l) = 0
    then
        PS1+=""
    else
        git_status=$(LANG=en_US git status 2> /dev/null)
        on_branch="On branch ([^${IFS}]*)"
        on_commit="HEAD detached at ([^${IFS}]*)"
        git_message=""
        have_added=0
        if [[ $git_status =~ "nothing to commit" ]]; then
            color="$LightGreen"
            message="$clean"
            git_message+="$color$message"
            have_added=1
        fi
        if [[ $git_status =~ "not staged for commit" ]]; then
            #if [[ $have_added == 1 ]]; then git_message+="$White$void"; fi
            #have_added=1
            color="$LightRed"
            message="$dirty"
            git_message+="$color$message"
        fi
        if [[ $git_status =~ "Untracked" ]]; then
            #if [[ $have_added == 1 ]]; then git_message+="$White$void"; fi
            #have_added=1
            color="$LightYellow"
            message="$new"
            git_message+="$color$message"
        fi
        if [[ $git_status =~ "to be committed" ]]; then
            #if [[ $have_added == 1 ]]; then git_message+="$White$void"; fi
            #have_added=1
            color="$LightCyan"
            message="$commit"
            git_message+="$color$message"
        fi
        if [[ $git_status =~ "Your branch is ahead of" ]]; then
            #if [[ $have_added == 1 ]]; then git_message+="$White$void"; fi
            #have_added=1
            color="$LightPurple"
            message="$staged"
            git_message+="$color$message"
        fi
        PS1+="$Reset$Cyan$void"
        if [[ $git_status =~ $on_branch ]]; then
            git_where=${BASH_REMATCH[1]}
            PS1+="$White[$LightBlack$git $Blue$git_where $git_message$White]" 
        elif [[ $git_status =~ $on_commit ]]; then
            git_where=${BASH_REMATCH[1]}
            PS1+="$White[$LightBlack$git $Blue$git_where $git_message$White]" 
        fi
    fi
    PS1+="$Reset$Yellow$prompt$Reset"
}
PROMPT_COMMAND='set_prompt'

export BROWSER="vivaldi-beta"

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

