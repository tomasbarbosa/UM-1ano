#include <stdio.h>
#include <string.h>


int main(){

    char msg[1001]; // +1 por causa do /0 no final
    char ni[9]; // +1 por causa do /0 no final
    int tamanho_n = 0, tamanho_m = 0,n;
   
    if(scanf("%s",ni) != 1){
        return 1;
     }

    if(scanf("%s",msg)!=1){
       return 1;
    }


    tamanho_n = strlen(ni);
    tamanho_m = strlen(msg);

    for(int i = 0; i<tamanho_n;i++){
        n = (int)ni[i];
        for(int j = 0;j<tamanho_m;j+=tamanho_n){
            if(j+n - 49 >= tamanho_m){
                 break;
            }
            putchar(msg[n+j-49]);
        }
    }
    putchar('\n');




    return 0;
}


