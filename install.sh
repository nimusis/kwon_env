#!/bin/bash

kwonEnvDir=$HOME/".kwon_env"
filename=".kwon_env.zip"
bashfilename=$HOME/".bashrc"

if which unzip; then
	wget -O $filename "https://github.com/nimusis/kwon_env/archive/master.zip"
	unzip -j $filename -d $kwonEnvDir
	rm -f $filename
	rm -f $kwonEnvDir/install.sh
	rm -f $kwonEnvDir/README.md
else
	mkdir $kwonEnvDir
	curl -fLo $kwonEnvDir/bashrc https://raw.githubusercontent.com/nimusis/kwon_env/master/bashrc
	curl -fLo $kwonEnvDir/colors https://raw.githubusercontent.com/nimusis/kwon_env/master/colors
	curl -fLo $kwonEnvDir/vimrc https://raw.githubusercontent.com/nimusis/kwon_env/master/vimrc
fi

curl -fLo $kwonEnvDir/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if grep -q '.kwon_env' $HOME/.bashrc; then
	echo "kwon_env aliases already exist!"
else
	echo "" >> $HOME/.bashrc
	echo "#aliases for kwon_env" >> $HOME/.bashrc
	echo "alias kwon='source ~/.kwon_env/bashrc'" >> $HOME/.bashrc
	echo "" >> $HOME/.bashrc
fi

