#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  calculoPascua.py
#  
#  Copyright 2021  Copiado de 
# https://es.m.wikipedia.org/wiki/Anexo:Implementaciones_del_algoritmo_de_c%C3%A1lculo_de_la_fecha_de_Pascua#Algoritmo_en_Java


def main(args):
    return 0

import sys

# Magic constants
# Años M N
# 1583-1699 22 2
# 1700-1799 23 3
# 1800-1899 23 4
# 1900-2099 24 5
# 2100-2199 24 6
# 2200-2299 25 0

def easter(year):
	# Calculation of the Magic constants
	if (year>=1583 and year<1700):
		M=22
		N=2
	if (year>=1700 and year<1800):
		M=23
		N=3
	if (year>=1800 and year<1900):
		M=23
		N=4
	if (year>=1900 and year<2100):
		M=24
		N=5
	if (year>=2100 and year<2200):
		M=24
		N=6
	if (year>=2200 and year<2300):
		M=25
		N=0

	# Calculating variables
	a = year%19
	b = year%4
	c = year%7
	d = (19*a + M)%30
	e = (2*b + 4*c + 6*d + N)%7

	date=()

	if (d+e<10):
		date = ('marzo', d+e+22)
	else:
		date = ('abril', d+e+-9)

	# Calculating Exceptions
	if (date[0]=='abril') and ((date[1]==25 and d==28 and e==6 and a>10) or (date[1]==26)):
			date = (date[0], date[1]-7)

	return date

if __name__ == '__main__':
	year = int(sys.argv[1])
	date = easter(year)
	print('El %d, Pascua es el %d de %s' % (year, date[1], date[0]))
