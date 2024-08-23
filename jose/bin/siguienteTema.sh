#!/bin/bash
# Dame las lecciones pendientes del curso de ciberkk ordenadas por tamaño
du $(for a in /comun/Cursos-Formaciones/Ciberseguridad/Aula_Virtual/0[2-7]*; do ls -t $a/*.pdf | head -1; done) | sort -g
