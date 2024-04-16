#include <stdio.h>
#include <stdlib.h>

struct celula {
char *palavra;
int ocorr;
struct celula * prox;
};
typedef struct celula *Palavras;
//1

void libertaLista (Palavras l, Palavras aux){
    while(l != NULL){
        aux = l -> prox;
    free(l -> palavra);
    free(l);
    l = aux;
    }
}
//2
int quantasP (Palavras l, int np, Palavras aux){
    np = 0;
    while(l!=NULL){
        aux = l -> prox;
        np++;
        l = aux;
    }
    return np;
}
//3
void listaPal(Palavras l, Palavras aux){
    while(l != NULL){
        aux = l -> prox;
        printf("%s %d\n",l->palavra,l->ocorr);
        l = aux;
}
}
//4
char* ultima (Palavras l, Palavras aux){
    if(l == NULL){
        return 1;
    }
    while(l-> prox != NULL){
        aux = l -> prox;
        l = aux;
    }
    return(l->palavra);
}
//5
Palavras acrescentaInicio (Palavras l, char* p){
    Palavras aux;
    malloc(sizeof(struct celula));
    aux -> ocorr = 1;
    aux -> prox = l;
    char* aux;
    strcpy(aux,p);
    
    return(aux);
}
//6 não tenho a certeza se está certo
Palavras acrescentaFim (Palavras l, char* p){
Palavras new = malloc(sizeof(Palavras));
Palavras aux;
    if(new == NULL) return 1;
    new-> palavra = p;
    new-> ocorr = 1;
    while(l != NULL){
        aux = l -> prox;
        l = aux;
    }
    l = new;
    return(l);
}
//7
Palavras acrescenta (Palavras l, char* p){

}
//8 não tenho a certeza se etá certo
struct celula* maisFreq (Palavras l){
    Palavras aux;
    Palavras mFreq;
    int maisOc = 0;
    while(l != NULL){
        aux = l -> prox;
        if((l-> ocorr) > maisOc ){
            mFreq -> palavra = l-> palavra;
            mFreq -> ocorr = l -> ocorr;
            maisOc = l-> ocorr ;
        }
        l = aux;
    }
    return(mFreq);
}

