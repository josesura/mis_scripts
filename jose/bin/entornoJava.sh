#!/bin/sh 
# Variables de entorno para usar diferentes versiones de java
# Argumento: Version de Java: 5, 6, 8, 11, TIJ4 (para compilar con ant
# lo de Bruce Eckel, que necesita java5 y más cosas en el CLASSPATH)
#
# Para Java 5 y 6 sólo funcionan los ant anteriores a 1.10
 
# Guardo PATH en OLD_PATH, sólo si no lo tengo
uso()
{
	printf "%s\n" "Uso . $0 Version de java: 5, 6, 8, 11, 17 | o TIJ4"
	printf "%s\n" "TIJ4 es para compilar las clases del libro TIJ4, en $CLASSES_TIJ4"
	printf "%s\n" "11 es para restaurar las variables del sistema"
}

printf "%s\n" "Recuerda poner . delante: \". $0\""

if [ $# -eq 0 ]; then
	uso
	return 1
fi

if [ -z $OLD_PATH ]; then
	export OLD_PATH=$PATH
else 
	printf "%s\n" "ya tengo '$OLD_PATH':$OLD_PATH;"
fi

# HOMES
unset ANT_HOME
case $1 in 
    5 | TIJ4)
	    printf "%s\n" "Java 5"
    	export JAVA_HOME=/opt/java/jdk1.5.0_22
        ;;
    6)
	    printf "%s\n" "Java 6"
        export JAVA_HOME=/opt/java/jdk1.6.0_45   
        ;;
    8)
	    printf "%s\n" "Java 8"
        export JAVA_HOME=/opt/java/java8
        ;;
    17)
	    printf "%s\n" "Java 17"
        export JAVA_HOME=/opt/java/java17
        ;;
    *)
	    printf "%s\n" "Java del sistema"
        unset JAVA_HOME
        ;;
esac

case $1 in 
    5 | TIJ4 | 6 )
            export ANT_HOME=/opt/apache/apache-ant-1.9.16
            export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
            ;;
    8 | 17 )
            export PATH=$JAVA_HOME/bin:$PATH:/opt/gradle/gradle-7.3.1/bin
            ;;
    *)
            export PATH=$OLD_PATH
            unset OLD_PATH
            ;;
esac

# CLASSPATH
if [ "$1" = "TIJ4" ]; then 
    CLASSES_TIJ4=~jose/Documentos/Cursos-Formaciones/TIDoc/Bruce_Eckel/TIJ4-code-master/examples
    export MIS_LIB=/opt/java/librerias/TIJ4-ejemplos
    export CLASSPATH=.:..:$CLASSES_TIJ4
    export CLASSPATH=$CLASSPATH:$MIS_LIB/javassist.jar
    export CLASSPATH=$CLASSPATH:$MIS_LIB/xom-1.2.4.jar
    export CLASSPATH=$CLASSPATH:$MIS_LIB/javaws.jar
    export CLASSPATH=$CLASSPATH:$MIS_LIB/org.eclipse.swt.gtk.linux.x86_64_3.6.2.v3659b.jar
else 
    printf "%s\n" "no pongo classpath"
    unset CLASSPATH
fi


