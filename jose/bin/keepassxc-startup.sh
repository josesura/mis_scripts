#!/bin/sh
# bin/keepassxc-startup.sh
# keepassxc has option to startup automatically, but we will take care of it on our own. Otherwise it might happen that we will try to unlock keepassxc before it’s’ up and running.
#
keepassxc&
sleep 1
keepassxc-unlock.sh
