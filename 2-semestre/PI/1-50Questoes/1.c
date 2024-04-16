#include <stdio.h>

//1

int main(){


int n;
int maior = 0;

while(1){
    if(scanf("%d",&n) != 1) return 1;

    if(n==0) break;

    if (n > maior) maior = n;
}
printf("O maior número é o %d\n",maior);
return 0;
}