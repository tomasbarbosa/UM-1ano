#include <stdio.h>
#include <string.h>

int main() {

int n,clinha,nalternado,vogais,consoantes;
char linha[1000];

if(scanf("%d",&n)!=1){ // da scan ao primeiro numero do input
    return 1;
}

int vf[n];

for(int i=0;i<n;i++){
    if(scanf(" %[^\n]s", linha)!= 1) return 1;          //o scan é para ler a linha toda
   
    clinha = strlen(linha);
    nalternado = 0;
    vogais = 0;
    consoantes = 0;
     
        for(int j = 0; j < clinha; j++){
            if(linha[j] == ' '){
                if(vogais < 2 && consoantes <2)
                nalternado++;
                
                vogais = 0;
                consoantes = 0;
            }
            else if(consoantes >= 2 || vogais >= 2){
                continue;
            } 
            else if(linha[j] == 'A' ||linha[j] == 'E' ||linha[j] == 'I' ||linha[j] == 'O' ||linha[j] == 'U' ||linha[j] == 'Y'){
                vogais++;
                consoantes = 0;
            }
            else{
                consoantes++;
                vogais = 0;
            }

        }



        if(vogais < 2 && consoantes <2)
                nalternado++;
    
        vf[i] = nalternado;
}

for(int l = 0; l<n;l++)
    printf("%d\n",vf[l]);

return 0;
}


/*
vogais - AEIOUY

as vogais e as consoantes tem de estar
alternadas



*/