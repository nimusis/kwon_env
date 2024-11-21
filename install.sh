#!/bin/bash

XDG_CONFIG_HOME=$HOME/".kwon_env"
ZSH="$XDG_CONFIG_HOME/oh-my-zsh"

RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
NO_COLOR='\033[0m'

################## Functions ##################
function checkRequirement () {
  if [ -z "$(command -v $1)" ]; then
    echo -e "${RED_COLOR}$1${NO_COLOR}\t : not installed";
    exit 1;
  else
    echo -e "${GREEN_COLOR}$1${NO_COLOR}\t : $($1 --version | head -1)" | sed -r -n "s/^([^ ]+).*[ vV]([0-9]+\.[^ ]+).*/\1 : \2/p"
  fi
}

function print () {
  echo -e "${GREEN_COLOR}$1${NO_COLOR}";
}

print "== 필수 파일 설치 확인"
checkRequirement "zsh"
checkRequirement "git"
checkRequirement "curl"
checkRequirement "vim"

mkdir -p $XDG_CONFIG_HOME/bin

################## 필요 파일 설치 ##################
print "== oh-my-zsh 설치"
# oh-my-zsh 설치
ZSH="$XDG_CONFIG_HOME/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --skip-chsh --unattended --keep-zshrc

# oh-my-zsh 플러그인 설치
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting

# fzf 설치
if [ -z "$(command -v fzf)" ]; then
  print "== fzf 설치"
  git clone --depth 1 https://github.com/junegunn/fzf.git $XDG_CONFIG_HOME/fzf && $XDG_CONFIG_HOME/fzf/install --all --no-bash --no-zsh --no-fish --xdg
else
  print "== fzf 설치 되어있음"
fi

print "== tmux 설정 정보 적용"
# oh-my-tmux 설치
curl -fLo $XDG_CONFIG_HOME/tmux/tmux.conf --create-dirs https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf
#curl -fLo $XDG_CONFIG_HOME/tmux/tmux.conf.local --create-dirs https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf.local

################## 내 설정파일 다운로드 ##################
print "== kwon_env 설정 정보 적용"
curl -fLo $XDG_CONFIG_HOME/vimrc --create-dirs https://raw.githubusercontent.com/nimusis/kwon_env/master/vimrc
curl -fLo $XDG_CONFIG_HOME/zshrc --create-dirs https://raw.githubusercontent.com/nimusis/kwon_env/master/zshrc
curl -fLo $XDG_CONFIG_HOME/tmux/tmux.conf.local --create-dirs https://raw.githubusercontent.com/nimusis/kwon_env/master/tmux.conf.local

# 정근님 vim 플러그인 설치
curl -fLo $XDG_CONFIG_HOME/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

print "== zshrc 설정 적용"
# zsh 마지막 라인에 추가
ZSHRC_PATH=$HOME/.zshrc
if grep -q 'source ~/.kwon_env/zshrc' $ZSHRC_PATH; then
  echo "kwon_env aliases already exist!"
else
  echo "" >> $ZSHRC_PATH
  echo "source ~/.kwon_env/zshrc" >> $ZSHRC_PATH
  echo "" >> $ZSHRC_PATH
fi

print "== 필요 유틸리티 적용"
if [ -z "$(command -v bat)" ]; then
  if [ "$(command -v batcat)" ]; then
    print "  * batcat 설치되어있음"
    ln -s /usr/bin/batcat ~/.kwon_env/bin/bat
  else
    print "  * bat 설치"
    V=$(curl --silent "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Eo '"tag_name": "v(.*)"' | sed -E 's/.*"([^"]+)".*/\1/')
    curl -sL "https://github.com/sharkdp/bat/releases/download/$V/bat-$V-x86_64-unknown-linux-musl.tar.gz" -o - |tar -xvzf - -C ~/.kwon_env/bin  --strip-components 1 bat-$V-x86_64-unknown-linux-musl/bat
    unset V
  fi
else
  print "  * bat 설치되어있음"
fi

if [ -z "$(command -v rg)" ]; then
  print "  * ripgrep 설치"
  V=$(curl --silent "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Eo '"tag_name": "(.*)"' | sed -E 's/.*"([^"]+)".*/\1/')
  curl -sL "https://github.com/BurntSushi/ripgrep/releases/download/$V/ripgrep-$V-x86_64-unknown-linux-musl.tar.gz" -o - |tar -xvzf - -C ~/.kwon_env/bin  --strip-components 1 ripgrep-$V-x86_64-unknown-linux-musl/rg
  unset V
else
  print "  * ripgrep 설치되어있음"
fi

if [ -z "$(command -v tmux)" ]; then
  print "  * tmux 수동 설치 권고"
else
  V=$(tmux -V | sed -r "s/.*[ vV]([0-9]+\.[^ ]+).*/\1/")
  print "  * tmux 설치되어있음. $V"
  unset V
fi

if [ -z "$(command -v tmuxinator)" ]; then
  print "  * tmuxinator 수동 설치 권고"
else
  V=$(tmuxinator -v | sed -r "s/.*[ vV]([0-9]+\.[^ ]+).*/\1/")
  print "  * tmuxinator 설치되어있음. $V"
  unset V
fi

if [ -z "$(command -v gitui)" ]; then
  print "  * gitui 설치"
  V=$(curl --silent "https://api.github.com/repos/extrawurst/gitui/releases/latest" | grep -Eo '"tag_name": "(.*)"' | sed -E 's/.*"([^"]+)".*/\1/')
  curl -sL "https://github.com/extrawurst/gitui/releases/download/$V/gitui-linux-x86_64.tar.gz" -o - |tar -xvzf - -C ~/.kwon_env/bin
  unset V
else
  print "  * gitui 설치되어있음"
fi

print "== vim 플러그인 설치"
# vimrc 에 추가되어있는 설정 파일 다운로드
vim -es -u $XDG_CONFIG_HOME/vimrc -i NONE -c "PlugInstall" -c "qa"
print "== 끝"
