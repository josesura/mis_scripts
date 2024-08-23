#!/bin/sh -e
# copiaGlori.sh

# Donde encontrar las cosas
RAIZ_COPIA=/media/jose/ToshExt4

rsync -av --delete glori@devk:/home/glori $RAIZ_COPIA/devk/home/ --exclude=.cache
