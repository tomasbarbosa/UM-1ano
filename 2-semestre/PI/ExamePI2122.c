#include <stdlib.h>
#include <string.h>

//1
int pesquisa(int a[], int N, int x){
    int l = 0, u = N-1,m;
    while(l <= u){
        m = (l+u)/2;
        if(a[m] == x) return 1;
        if(a[m] < x) l = m+1;
        else u = m-1;
    }
    return 0;
}

//2
typedef struct LInt_nodo {
int valor;
struct LInt_nodo *prox;
} *LInt;

void roda(LInt *l){
    if(*l == NULL || (*l)->prox == NULL) return;
    LInt aux = *l, ant = NULL;
    while(aux->prox != NULL){
        ant = aux;
        aux = aux ->prox;
    }
    aux->prox = *l;
    ant->prox = NULL;
    *l = aux;
    
}

//3
typedef struct ABin_nodo {
int valor;
struct ABin_nodo *esq, *dir;
} *ABin;

int apaga(ABin a, int n){
    if(a == NULL) return 0;

    if(n<=0) return 0;

    int nApag = 1;

    if(a->esq != NULL) nApag += apaga(a->esq,n-1);

    if(a->dir != NULL) nApag += apaga(a->esq, n-1);

    free(a);

    return nApag;
}

//4
void checksum(char s[]){
    int soma = 0;
    int len = strlen(s);
    int par = 1;
    for(int i = len-1; i>= 0; i--){
        if(par){
            int num = 2 *(s[i] - '0');
            while(num > 0){
                soma += (num % 10);
                par = 0;
                num /= 10;
            }
        }
        else{
            soma += (s[i] - '0');
            par = 1;
        }
    }
    s[len] = 10 - (soma % 10) + 48;
    s[len + 1] = '\0';
}