#include <stdio.h>

volatile
#include "mylibarr.h"

void printInfo(const char* ptr) {
    // load mem
    for(volatile int i = 0; i < 1024*1024*100; ++i) {
        volatile unsigned char c = randomdata_img[i];
    }

    printf("MyLib::printInfo( %s )\n", ptr);
}