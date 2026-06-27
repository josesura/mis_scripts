#!/bin/sh
#
# Guarda el perfil por defecto de firefox para cuando "accidentalmente" desaparezca algo, como pestañas
# El otro perfil existe en el listado de perfiles, por lo que se podría usar en su defecto
rsync -ah --delete --progress .mozilla/firefox/69w14zxg.default-esr/ .mozilla/firefox/69w14zxg.default-esr-copia
