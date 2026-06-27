#!/bin/sh
BUSCO="^h"

echo "ls | grep $BUSCO"
ELEMENTOS="$(ls | grep $BUSCO)"
echo "ELEMENTOS=$ELEMENTOS;"

echo "echo \$ELEMENTOS | wc -l"
CUENTA="$(echo $ELEMENTOS | wc -l)"
echo "CUENTA=$CUENTA"
