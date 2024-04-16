#include <stdio.h>

void trianguloh(int n) {
    int i,j;
    for(i=1;i<n;i++) {
        for(j=0;j<i;j++){
            putchar('#');
        }
        putchar('\n');
    }
    for(;i>0;i--){
        for(j=0;j<i;j++)
        putchar('#');
    putchar('\n');
    }
}


int main() {
triangulo (4);
return 0;
}