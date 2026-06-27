#!/bin/sh
# bin/keepassxc-unlock.sh
# Get password using secret-tool and unlock keepassxc
# script gets a db password from secret-tool and using d-bus we speak to keepassxc to unlock db
# Para que esto funcione hay que guardar antes la contraseña en el almacén
# secret-tool store --label="KeePass 'Claves internet'" keepass 'Claves internet'
#
tmp_passwd=$(secret-tool lookup keepass 'Claves internet')
database='/home/jose/Documentos/Sec/Datos-Acceso.kdbx'
keyfile=''
dbus-send --print-reply --dest=org.keepassxc.KeePassXC.MainWindow /keepassxc org.keepassxc.KeePassXC.MainWindow.openDatabase \
string:"$database" string:"$tmp_passwd" string:"$keyfile"
