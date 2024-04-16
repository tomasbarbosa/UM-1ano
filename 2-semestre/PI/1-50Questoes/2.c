#include <stdio.h>

int main(){

   int n;
   int acc = 0;
   int numerodigitos = 0;

   while(1){

    if(scanf("%d",&n) != 1) return 1;

    if(n == 0){
        acc /= numerodigitos;
        break;
    }
    acc += n;
    numerodigitos ++;
    
   } 
   printf("A média é %d\n",acc);

   return 0;
}