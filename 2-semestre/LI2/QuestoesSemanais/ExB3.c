#include <stdio.h>
#include <string.h>

int main(){

    int n,num_c;
    int posi = 5;
    char linha[21];
    

    if(scanf("%d",&n)!=1)
    return 1;

int resultado[n];
    for(int i = 0;i<n;i++){
        if(scanf("%s",linha)!=1)
        return 1;
    
    
    
    num_c = strlen(linha);

    for(int j = 0; j<= num_c;j++ ){
        if(linha[j] == 'C'){
            if(posi == 7 || posi == 8 || posi == 9) posi=posi;
            else posi += 3;
        }
        if(linha[j] == 'B'){
            if(posi == 1 || posi == 2 || posi == 3) posi=posi;
            else posi -= 3;
        }
        if(linha[j] == 'E'){
            if(posi == 1 || posi == 4 || posi == 7) posi=posi;
            else posi -= 1;
        }
        if(linha[j] == 'D'){
            if(posi == 3 || posi == 6 || posi == 9) posi=posi;
            else posi += 1;
        }
    }
    resultado[i] = posi;
    }
    for(int k = 0;k<n;k++){
        printf("%d",resultado[k]);
    }

putchar('\n');
    return 0;
}