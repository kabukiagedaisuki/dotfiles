#!/bin/sh

# task-japanese task-japanese-desktop
#   日本語入力
# code
#   visual studio code
# python系
#   virtualenv virtualenvwrapper
#
PKGS="task-japanese task-japanese-desktop code virtualenv virtualenvwrapper tree exuberant-ctags"
for pkg in $PKGS
do
  case $pkg in
    "code" )
      INSTALLED_CHECK="dpkg -l"
      INSTALL="wget -O code.deb 'https://go.microsoft.com/fwlink/?LinkID=760868 &&
               sudo dpkg -i code.deb"
      ;;
    "virtualenv" | "virtualenvwrapper")
      INSTALLED_CHECK="pip3 freeze | grep $pkg"
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
if [ `xrandr | grep -c "connected primary 1920x1080"` -ne 1 ]; then
  xrandr --output VGA-1 --mode 1920x1080
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

# VirtualBox GuestAddition
echo -n "VirtualBox GuestAddition install ... "
ls /opt/VBoxGuestAdditions*/src/vboxguest*/*.ko > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "skip"
else
  cd /opt/VBoxGuestAdditions*/src/vboxguest*/
  sudo make
  sudo make install
  echo "need reboot !!"
fi
