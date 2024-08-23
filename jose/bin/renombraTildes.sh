#!/bin/sh
# Renombrar documentos para sustituir blancos (_), tildes y Ñ

rename -e 's/\ /_/g' * 
rename -e 's/Á/a/g' *
rename -e 's/á/a/g' *
rename -e 's/É/e/g' *
rename -e 's/é/e/g' *
rename -e 's/Í/i/g' *
rename -e 's/í/i/g' *
rename -e 's/Ó/o/g' *
rename -e 's/ó/o/g' *
rename -e 's/Ú/u/g' *
rename -e 's/ú/u/g' *
rename -e 's/Ü/u/g' *
rename -e 's/ü/u/g' *
rename -e 's/Ñ/n/g' *
rename -e 's/ñ/n/g' *

