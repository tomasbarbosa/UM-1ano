#include <stdio.h>

void triangulov(int n) {
    int i,j;
    for(i=0;i<n;i++){
        for(j=0;j<n-i;j++)
            putchar(' ');
        for(j=0;j<2*i-1;j++){
            putchar('#');
        }
        putchar('\n');
    }
}

int main() {
    triangulov(4);
    return 0;
}


/*

  *     --i=0; 2 espaços; 1 cardinal
 ***    --i=1; 1 espaço; 3 cardinais
*****   --i=3; 0 espaços; 5 cardinais

*/