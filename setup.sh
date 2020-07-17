#!/bin/sh

cd ~/dotfiles
if [ $? -ne 0 ]; then
    echo "Failed: cd ~/dotfiles"
    exit 1
fi

echo "zsh plugin update"
zsh $HOME/.zplugin/bin/zplugin.zsh update

for file in `ls -a | egrep -v "\\.$|README.md|setup.sh|\.git|misc"`
do
    echo "re-symbolic link: $HOME/$file"
    rm $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

chsh -s /usr/bin/zsh

