#!/bin/sh

if [ `ps axuww | grep -v grep | grep -c "ssh-add"` -eq 0 ]; then
  eval `ssh-agent`
  ssh-add
fi
