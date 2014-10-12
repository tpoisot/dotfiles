#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin:$HOME/.cabal/bin:$HOME/Mathematica/scripts

alias ls='ls --color=auto -lGFh'
alias grep='grep --color=auto'

alias edit='vim'

alias mutt='cd && mutt'
alias cabal='/home/tp/.cabal/bin/cabal'

unset SSH_ASKPASS

source $HOME/.schemes/pscolors
eval "$(dircolors $HOME/.schemes/dircolors)"

# Needed for git status in the prompt
source /usr/share/git/git-prompt.sh 

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

export PS1='\[\e]0;\w\a\]\[\033[31m\][\[\033[0;33m\]\W\[\033[31m\]]\[\033[0;32m\]$(__git_ps1) \[\033[2;34m\]\$\[\033[00m\] '
