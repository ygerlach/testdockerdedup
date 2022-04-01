#include <stdio.h>
#include <unistd.h>

#include "mylib.h"

int main(int argc, char** argv) {
    printf("Running: %s \n", argv[0]);
    printInfo("test123");

    while(1) {
        sleep(1000);
    }

    return 0;
}