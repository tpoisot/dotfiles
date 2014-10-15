#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin:$HOME/.cabal/bin:$HOME/Mathematica/scripts:$HOME/.julia/v0.3/Judo/bin

alias ls='ls --color=auto -lGFh'
alias grep='grep --color=auto'

alias edit='vim'

alias mutt='cd && mutt'
alias cabal='/home/tp/.cabal/bin/cabal'

unset SSH_ASKPASS

source $HOME/.schemes/pscolors
eval "$(dircolors $HOME/.schemes/dircolors)"

## hub is aliased to git
eval "$(hub alias -s)"

## git in bash
GIT_PROMPT_THEME=Flat
source /home/tp/.scripts/bash-git-prompt/gitprompt.sh

