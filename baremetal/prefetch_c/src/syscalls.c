#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <sim.h>

// Implement the write system call
int _write(int file, char *ptr, int len) {
    for (int i = 0; i < len; i++) {
        // Implement your hardware specific output character function, e.g., UART
        sim_putchar(ptr[i]);
    }
    return len;
}

// Other system calls can be stubbed out
int _read(int file, char *ptr, int len) {
    return 0;
}

int _lseek(int file, int ptr, int dir) {
    return 0;
}

int _close(int file) {
    return -1;
}

int _fstat(int file, struct stat *st) {
    st->st_mode = S_IFCHR;
    return 0;
}

int _isatty(int file) {
    return 1;
}

void _exit(int status) {
    while (1) {
        // Enter an infinite loop to prevent further execution
    }
}

void _kill(int pid, int sig) {
    return;
}

int _getpid(void) {
    return 1;
}


static char *miaou = 0x90000000;

void * _sbrk(ptrdiff_t increment) {
    char *prev_heap_end = miaou;
    miaou += increment;

    // Implement any boundary checks if necessary, for example:
    // if (heap_end >= STACK_TOP) {
    //     errno = ENOMEM;
    //     return (void *) -1;
    // }

    return (void *) prev_heap_end;
}