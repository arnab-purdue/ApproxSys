# Makefile for pgmDemo (May 1998 by Richard Zanibbi)
# use:   makefile -f makePGM
pgmDemo: PGM.o demopgm.o iroutines.o
	gcc -o pgmDemo PGM.o demopgm.o iroutines.o
PGM.o: PGM.c PGM.h
	gcc -c PGM.c
iroutines.o: iroutines.c iroutines.h PGM.h
	gcc -c iroutines.c
demopgm.o: demopgm.c demopgm.h PGM.h iroutines.h
	gcc -c demopgm.c


