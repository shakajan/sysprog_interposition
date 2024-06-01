#ifdef COMPILETIME
#include <stdio.h>
#include <malloc.h>

void *mymalloc(size_t size)
{
    void *ptr = malloc(size);
    printf("malloc(%d): %p\n", (int) size, ptr);
    return ptr;
}

void myfree(void* ptr)
{
    free(ptr);
    printf("free(%p)\n", ptr);
}

#endif
#ifdef LINKTIME

#include <stdio.h>
#include <stdlib.h>

void *__real_malloc(size_t size);
void __real_free(void* ptr);

void *__wrap_malloc(size_t size)
{
    void *ptr = __real_malloc(size);
    printf("malloc(%d): %p\n", (int) size, ptr);
    return ptr;
}

void __wrap_free(void* ptr)
{
    __real_free(ptr);
    printf("free(%p)\n", ptr);
}

#endif
#ifdef RUNTIME
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <unistd.h>
#include <string.h>

void *malloc(size_t size)
{
    void *(*mallocp) (size_t size) = NULL;

    mallocp = dlsym(RTLD_NEXT, "malloc");
    if(!mallocp) {
        fputs(dlerror(), stderr);
        exit(1);
    }
    
    void *ptr = mallocp(size);
    char str_buf[256] = {0};

    sprintf(str_buf, "malloc(%d): %p\n", (int) size, ptr);
    write(1, str_buf, strlen(str_buf));

    return ptr;
}

void free(void* ptr)
{
    void (*freep) (void* ptr) = NULL;

    freep = dlsym(RTLD_NEXT, "free");
    if(!freep) {
        fputs(dlerror(), stderr);
        exit(1);
    }
    
    freep(ptr);

    char str_buf[256] = {0};
    sprintf(str_buf, "free(%p)\n", ptr);
    write(1, str_buf, strlen(str_buf));
}

#endif
