#!/bin/sh
# bin/keepassxc-lock.sh
# we just send a message through d-bus to lock db
#
dbus-send --print-reply --dest=org.keepassxc.KeePassXC.MainWindow /keepassxc org.keepassxc.KeePassXC.MainWindow.lockAllDatabases
