#!/bin/sh

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
sh ~/installer.sh ~/.vim/bundles
rm ~/installer.sh

# svn export https://github.com/ryanoasis/nerd-fonts/trunk/font-patcher
# chmod 744 font-patcher
svn export https://github.com/ryanoasis/nerd-fonts/trunk/patched-fonts/FiraCode/Retina/complete
# ./font-patcher 'complete/Fira Code Retina Nerd Font Complete.ttf' --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols --weather --material
sudo cp -p 'complete/Fira Code Retina Nerd Font Complete.ttf' /usr/local/share/fonts
sudo fc-cache -fv
echo "vim commanline-mode execute, :call dein#recache_runtimepath()"

