#!/bin/bash

KWON_CONFIG_HOME=$HOME/".kwon_env"
ZSH="$KWON_CONFIG_HOME/oh-my-zsh"

################## 설치에 필요한 유틸 확인 ##################
function checkRequirement () {
	if [ -z "$(command -v $1)" ]; then
		echo "'$1' is not installed";
		exit 1;
	fi
}

checkRequirement "zsh"
checkRequirement "git"
checkRequirement "curl"
checkRequirement "vim"

################## 필요 파일 설치 ##################
mkdir -p $KWON_CONFIG_HOME/bin
# oh-my-zsh 설치
ZSH="$KWON_CONFIG_HOME/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --skip-chsh --unattended --keep-zshrc

# oh-my-zsh 플러그인 설치
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting

# fzf 설치
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --no-bash --no-zsh --no-fish

# oh-my-tmux 설치
curl -fLo $KWON_CONFIG_HOME/tmux/tmux.conf --create-dirs https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf
#curl -fLo $KWON_CONFIG_HOME/tmux/tmux.conf.local --create-dirs https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf.local

# 정근님 vim 플러그인 설치
curl -fLo $KWON_CONFIG_HOME/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

################## 내 설정파일 다운로드 ##################
curl -fLo $KWON_CONFIG_HOME/vimrc --create-dirs https://raw.githubusercontent.com/nimusis/kwon_env/master/vimrc
curl -fLo $KWON_CONFIG_HOME/zshrc --create-dirs https://raw.githubusercontent.com/nimusis/kwon_env/master/zshrc
curl -fLo $KWON_CONFIG_HOME/tmux/tmux.conf.local --create-dirs https://raw.githubusercontent.com/nimusis/kwon_env/master/tmux.conf.local

# vimrc 에 추가되어있는 설정 파일 다운로드
vim -es -u $KWON_CONFIG_HOME/vimrc -i NONE -c "PlugInstall" -c "qa"

# zsh 마지막 라인에 추가
ZSHRC_PATH=$HOME/.zshrc
if grep -q 'source ~/.kwon_env/zshrc' $ZSHRC_PATH; then
	echo "kwon_env aliases already exist!"
else
	echo "" >> $ZSHRC_PATH
	echo "source ~/.kwon_env/zshrc" >> $ZSHRC_PATH
	echo "" >> $ZSHRC_PATH
fi
