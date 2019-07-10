#!/bin/sh

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
sh ~/installer.sh ~/.vim/bundles
rm ~/installer.sh

curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh > ~/install.sh
bash ~/install.sh
#rm ~/install.sh

