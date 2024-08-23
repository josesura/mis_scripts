#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  calculoPascua.py
#  
#  Copyright 2021 José Suárez Rancaño <jose@k2-debian>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  Copiado de 
# https://es.m.wikipedia.org/wiki/Anexo:Implementaciones_del_algoritmo_de_c%C3%A1lculo_de_la_fecha_de_Pascua#Algoritmo_en_Java


def main(args):
    return 0

#coding: latin-1

def Pascua(anno):
    # Constantes mágicas
    M = 24  
    N = 5
    
    #Cálculo de residuos
    a = anno % 19
    b = anno % 4
    c = anno % 7
    d = (19*a + M) % 30
    e = (2*b+4*c+6*d + N) % 7
    
    # Decidir entre los 2 casos:
    if d+e < 10  :
        dia = d+e+22
        mes = "marzo"
    else:
        dia = d+e-9
        mes = "abril"

    # Excepciones especiales (según artículo)
    if dia == 26  and mes == "abril":
        dia = 19
    if dia == 25 and mes == "abril" and d==28 and e == 6 and a >10:
        dia = 18
    
    return [dia, mes, anno]

print Pascua(2008)
