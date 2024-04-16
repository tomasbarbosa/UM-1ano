#include <stdio.h> 

int main() {
int num;
int maior = 0;
int smaior = 0;

while(1){
    if(scanf("%d",&num) != 1) return 1;

    if(num == 0) break;

    if(num>maior){
        smaior = maior;
        maior = num;
    }
    if(num > smaior && num < maior){
        smaior = num;
    }
}
printf("O segundo maior número é o %d\n",smaior);

    return 0;
}