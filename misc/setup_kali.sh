#!/bin/sh

# task-japanese task-japanese-desktop
#   日本語入力
# code
#   visual studio code
# python系
#   virtualenv virtualenvwrapper
#
#PKGS="task-japanese task-japanese-desktop code virtualenv virtualenvwrapper tree exuberant-ctags fzf golang"
PKGS="task-japanese task-japanese-desktop virtualenv virtualenvwrapper tree exuberant-ctags fzf golang"
for pkg in $PKGS
do
  case $pkg in
    "code" )
      INSTALLED_CHECK="dpkg -l"
      INSTALL="wget -O code.deb 'https://go.microsoft.com/fwlink/?LinkID=760868 &&
               sudo dpkg -i code.deb"
      ;;
    "virtualenv" | "virtualenvwrapper")
      INSTALLED_CHECK="pip3 freeze | grep"
      INSTALL="sudo pip3 install"
      ;;
    * )
      INSTALLED_CHECK="dpkg -l"
      INSTALL="sudo apt-get install"
      ;;
  esac

  echo -n "install $pkg ... "
  $INSTALLED_CHECK $pkg > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo ""
    $INSTALL $pkg
  else
    echo "skip"
  fi
done

# display size:1920x1080
echo -n "display size 1920x1080 ... "
if [ `xrandr | grep -c "connected primary 1600x1200"` -ne 1 ]; then
  display=`xrandr | grep "connected primary" | awk '{print $1}'`
  xrandr --output $display --mode 1600x1200
else
  echo "skip"
fi

# python3 default
echo -n "python3 default ... "
/usr/bin/python --version | grep 'Python 3' > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "skip"
else
  sudo ln -fs /usr/bin/python3 /usr/bin/python
fi

# Rust
which cargo 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  curl https://sh.rustup.rs -sSf | sh
fi
RPKGS="lsd ripgrep"
for rpkg in $RPKGS
do
  echo -n "install $rpkg ... "
  cargo install --list | grep ^$rpkg 2>&1 > /dev/null
  if [ $? -ne 0 ]; then
    echo ""
    cargo install $rpkg
  else
    echo "skip"
  fi
done

# zinit (old:zplugin)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
