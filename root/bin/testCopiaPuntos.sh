#!/bin/bash
# Copiar dotfiles a las carpetas correnpondientes en esta ubicacion para 
# backup de usuarios

for a in `ls -A /home`; do
	if [ [$a == 'lost+found'] ]; then echo Esta no: $a; 
	else 
		echo Esta si: $a
		for f in `ls -A /home/$a | grep ^[.]`; do
			echo copiando /home/$a/$f ...
			cp -a /home/$a/$f $a/
		done
	fi
done
