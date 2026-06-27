#!/bin/sh
# bin/keepassxc-watch.sh
# this script looks for d-bus message that the screensaver/session is unlocked, then we unlock password manager
#
# KeepassXC watch for logout and unlock a database
#
dbus-monitor --session "type=signal,interface=org.gnome.ScreenSaver" | 
while read -r MSG
do
    LOCK_STAT=$(echo "$MSG" | grep boolean | awk '{print $2}')
    if [ "$LOCK_STAT" = "false" ]
    then
        keepassxc-unlock.sh
    fi
done

# dbus-monitor --session "type=signal,interface=org.gnome.ScreenSaver" | while read -r MSG; do LOCK_STAT=$(echo "$MSG" | grep boolean | awk '{print $2}'); if [ "$LOCK_STAT" = "false" ] then keepassxc-unlock.sh fi; done
# dbus-monitor --session "type=signal,interface=org.gnome.ScreenSaver" | while read -r MSG; do echo "MSG=$MSG"; LOCK_STAT=$(echo "$MSG" | grep boolean | awk '{print $2}'); echo "LOCK_STAT=$LOCK_STAT"; done
