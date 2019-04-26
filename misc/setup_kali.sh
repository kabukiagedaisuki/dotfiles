#!/bin/sh

# 日本語入力
echo -n "input japanese ... "
dpkg -l task-japanese task-japanese-desktop > /dev/null 2>&1
if [ $? -ne 0 ]; then
    sudo apt-get install task-japanese task-japanese-desktop
else
    echo "skip"
fi

# display size:1920x1080
echo -n "display size 1920x1080 ... "
if [ `xrandr | grep -c "connected primary 1920x1080"` -ne 1 ]; then
    xrandr --output VGA-1 --mode 1920x1080
else
    echo "skip"
fi

# visual studio code
echo -n "install vscode ... "
dpkg -l code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    wget -O code.deb 'https://go.microsoft.com/fwlink/?LinkID=760868'
    sudo dpkg -i code.deb
else
    echo "skip"
fi
