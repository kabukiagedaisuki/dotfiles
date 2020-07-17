#!/bin/sh

echo "Right Contorol + HOME : menubar"

echo -n "VirtualBox GuestAddition install ... "
ls /opt/VBoxGuestAdditions*/src/vboxguest*/*.ko > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "skip"
  echo -n "  + version: "
  VBoxControl --version
  echo -n "  + status : "
  sudo rcvboxadd status
else
  sudo sh /media/cdrom0/VBoxLinuxAdditions.run
  cd /opt/VBoxGuestAdditions*/src/vboxguest*/
  sudo make
  sudo make install
  echo "need reboot !!"
fi


if [ -e "/media/sf_share/" ]; then
  sudo gpasswd --add shigeo vboxsf
else
  echo "SHARE FOLDER not found."
  echo ""
  echo "HOST OS todo"
  echo "- make share foldar."
  echo "   + foldar path: c:\Users\shigeo\VirtualBox VMs\share"
  echo "-  + foldar name: share"
  echo "-  + readonly   : false"
  echo "-  + auto mount : true"
  echo ""
  echo "desc: https://qiita.com/picato0511/items/61358822bcfbe671fff6"
fi
