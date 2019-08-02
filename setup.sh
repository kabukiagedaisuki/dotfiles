#!/bin/sh

cd ~/Documents/dotfiles
if [ $? -ne 0 ]; then
    echo "Failed: cd ~/Documents/dotfiles"
    exit 1
fi

echo "git submodule update"
git submodule foreach git pull origin master

for file in `ls -a | egrep -v "\\.$|README.md|setup.sh|\.git|misc"`
do
    echo "re-symbolic link: $HOME/$file"
    rm $HOME/$file
    ln -s $HOME/Documents/dotfiles/$file $HOME/$file
done

