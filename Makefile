CC=gcc
CFLAGS=-Wall

compile:
	$(CC) $(CFLAGS) -DCOMPILETIME -c -o malloc_compile.o mymalloc.c
	$(CC) $(CFLAGS) -I. -o intc int.c malloc_compile.o
	./intc

link:
	$(CC) $(CFLAGS) -DLINKTIME -c -o malloc_link.o mymalloc.c
	$(CC) $(CFLAGS) -c int.c
	$(CC) $(CFLAGS) -Wl,--wrap,malloc -Wl,--wrap,free -o intl int.o malloc_link.o
	./intl

run:
	$(CC) $(CFLAGS) -DRUNTIME -shared -fpic -o malloc_run.so mymalloc.c -ldl
	$(CC) $(CFLAGS) -o intr int.c
	LD_PRELOAD="./malloc_run.so" ./intr

clean:
	rm -f *.o *.so intc intl intr

