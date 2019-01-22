# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
stty erase ^H
#stty werase ^?

# define colors
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"

#export PS1="\u@\h:\w$ "
export PS1="$C_GREEN\u$C_DEFAULT@$C_CYAN\h:$C_YELLOW\w$C_DEFAULT$ "
eval `dircolors ~/.kwon_env/dircolors.custom -b`

tmux source ~/.kwon_env/tmux.conf

alias ls='ls --color=auto --show-control-chars'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -f'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

###############################
alias ta="tmux -2 attach -t "
alias tn="tmux -2 new -s "
alias tm="tmux -2 attach -t MAIN"
alias tl="tmux -2 ls"

###############################
alias vi='vim -u ~/.kwon_env/vimrc'
alias vim='vim -u ~/.kwon_env/vimrc'
###############################
