#!/bin/sh
# Ahora escribe los comandos. P. ej:
#
# Adding two values
((sum=25+35))

#Print the result
echo $sum

#!/bin/bash
: '
This script calculates
the square of 5.
'
((area=5*5))
echo $area

i=0

while [ $i -le 2 ]
do
echo Number: $i
((i++))
done
