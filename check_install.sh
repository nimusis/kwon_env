#!/bin/bash

RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
NO_COLOR='\033[0m'

function checkInstall () {
        if [ -z "$(command -v $1)" ]; then
                echo -e "${RED_COLOR}$1${NO_COLOR}\t : not installed";
        else
                echo -e "${GREEN_COLOR}$1${NO_COLOR}\t : $($1 $2 | head -1)" | sed -r -n "s/^([^ ]+).*[ vV]([0-9]+\.[^ ]+).*/\1 : \2/p"
        fi  
}

checkInstall "zsh" "--version"
checkInstall "vim" "--version"
checkInstall "git" "--version"
checkInstall "python2" "--version"
checkInstall "python3" "--version"
checkInstall "tmux" "-V"
checkInstall "tmuxinator" "-v"
checkInstall "bat" "--version"
checkInstall "batcat" "--version"
checkInstall "fzf" "--version"
checkInstall "rg" "--version"
checkInstall "tree" "--version"