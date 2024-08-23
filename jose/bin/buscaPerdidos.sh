#!/bin/bash 
# buscaPerdidos.sh
# Copiar dotfiles a las carpetas correnpondientes en esta ubicacion para 
# backup de usuarios

for a in `cat ~jose/borradoAccidental.txt`; do
	if [ ! -a $a ]; then echo No existe $a; fi
done

if [ 0==1 ]; then
	if [[$a == 'lost+found']]; then echo Esta no: $a; 
	else 
		echo Esta si: $a
		for f in `ls -A /home/$a | grep ^[.]`; do
			echo copiando /home/$a/$f ...
			cp -a /home/$a/$f $a/
		done
	fi
fi
