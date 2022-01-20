#include <stdio.h>
#include <stdlib.h>

int main(){
    int size = 10, i;
    int *stack = malloc(10 * sizeof(int));
    int *sp = stack + size; 
    
    *(--sp) = 10;
    *(--sp) = 9;

    for(i = 0; i<size; i++){
        printf("0x%x :  %d\n", stack+i, *(stack + i));
    }
}