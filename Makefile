main: simulate.c
	gcc -c -fPIC simulate.c -o simulate.o
	gcc simulate.o -shared -o libsimulate.so
	rm simulate.o
