#!/bin/dash 
# conv_ffmpeg.sh convierte formato multimedia de archivos de un directorio a otro 
# formato en nuevo directorio con el programa ffmpeg
# BASE=$(basename $1)
# EXT="${BASE##*.}"
# NOMBRE="${BASE%*.*}"
# echo BASE: $BASE
# echo NOMBRE: $NOMBRE
# echo EXT: $EXT
# El fichero sería $NOMBRE.$EXT
DIR1=.
DIR2=.
EXT1=flac
EXT2=ogg

if [ $# -eq 0 ]; then
	echo conv_ffmpeg.sh Sin args. DIR1=$DIR1 '|' DIR2=$DIR2 '|' EXT1=$EXT1 '|' EXT2=$EXT2
elif [ $# -eq 1 ]; then
	EXT1=$1
	echo conv_ffmpeg.sh DIR1="$DIR1" '|' DIR2="$DIR2" '|' EXT1="$EXT1" '|' EXT2="$EXT2"
elif [ $# -eq 2 ]; then
	EXT1=$1
	EXT2=$2
	echo conv_ffmpeg.sh DIR1="$DIR1" '|' "DIR2=$DIR2" '|' EXT1="$EXT1" '|' EXT2="$EXT2"
fi
#exit

#printf "%s\n" "DE: $DIR1/*.$EXT1 --> $DIR2/*.$EXT2"
# test
if ! true; then
for a in "$DIR1"/*."$EXT1"
do 
	[ -e "$a" ] || break  # handle the case of no files
	b="$DIR2"/$(basename "$a")
	c=${b%*.*}.$EXT2
	printf "%s\n" "DE: $a --> $c"
done
fi

if true ; then
for a in "$DIR1"/*."$EXT1"
do 
	[ -e "$a" ] || break  # handle the case of no files
	b="$DIR2"/$(basename "$a")
	c=${b%*.*}.$EXT2
	printf "%s\n" "DE: $a --> $c"
	ffmpeg -i "$a" "$c"
done
fi


