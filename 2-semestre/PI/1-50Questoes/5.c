#include <stdio.h>

int trailingZ (unsigned int n){
   int contador = 0;
while(n % 2 == 0){
   contador ++;
   n /= 2;
}
printf("%d\n",contador);
return 0;
}

int main(){

trailingZ(12);

    
return 0;
}
