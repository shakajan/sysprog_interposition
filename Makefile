CC=gcc
CFLAGS=-Wall

compile:
	$(CC) $(CFLAGS) -DCOMPILETIME -c -o malloc_compile.o mymalloc.c
	$(CC) $(CFLAGS) -I. -o intc int.c malloc_compile.o
	./intc
# by including option `-I.`, #include <malloc.h> is resolved as malloc.h in the . directory.

link:
	$(CC) $(CFLAGS) -DLINKTIME -c -o malloc_link.o mymalloc.c
	$(CC) $(CFLAGS) -c int.c
	$(CC) $(CFLAGS) -Wl,--wrap,malloc -Wl,--wrap,free -o intl int.o malloc_link.o
	./intl
# by not including optino `-I.`, #include <malloc.h> is resolved as malloc.h in base `include` directory.
# by including option `-Wl,--wrap,malloc`, malloc() is resolved as __wrap_malloc(),
#  and __real_malloc() is resolved as malloc().

run:
	$(CC) $(CFLAGS) -DRUNTIME -shared -fpic -o malloc_run.so mymalloc.c -ldl
	$(CC) $(CFLAGS) -o intr int.c
	LD_PRELOAD="./malloc_run.so" ./intr

clean:
	rm -f *.o *.so intc intl intr

