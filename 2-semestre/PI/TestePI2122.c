#include <stdlib.h>
#include <string.h>

//1
void bsort(int a[], int n){
    int i,j;
    for(i = n; i> 0; i--){
        for(j = 1; j<i;j++){
            if(a[j-1] > a[j]){
                int temp = a[j];
                a[j] = a[j-1];
                a[j-1] = temp;
            }
        }
    }
}
int nesimo(int a[], int N, int i){
    bsort(a,N);
    return a[i-1];
}

//2
typedef struct LInt_nodo {
int valor;
struct LInt_nodo *prox;
} *LInt;

LInt removeMaiores(LInt l, int x){
LInt aux = l, ant = NULL;
    while(aux != NULL){
        if(aux->valor > x){
            if(ant == NULL){
                l = l->prox;
            }
            else{
                ant->prox = aux->prox;
            }
        }
        else{
            ant= aux;
        }
        aux = aux->prox;
    }
    return l;
}


//3
typedef struct ABin_nodo {
int valor;
struct ABin_nodo *esq, *dir;
} *ABin;

LInt caminho(ABin a, int x){
    if(a == NULL) return NULL;

    LInt novo = malloc(sizeof(struct LInt_nodo));
    novo->valor = a->valor;
    novo->prox = NULL;
    if(a->valor > x){
        novo->prox = caminho(a->esq,x);
        if(novo->prox == NULL) return NULL; // é necessário colocar porque supostamente a árvore não ve se o próximo é NULL
    }

    if(a->valor < x){
        novo->prox = caminho(a->dir,x);
        if(novo->prox == NULL) return NULL;
    }
    if(a->valor == x){
        return novo;
    }
    return NULL;
}

//ou (sem recursividade)

LInt caminho(ABin a, int x){
    if (a == NULL) return NULL;

    LInt ant = NULL, caminho = NULL;
    while(a != NULL){
        LInt novo = malloc(sizeof(struct LInt_nodo));
       novo->valor = a->valor;
       novo->prox = NULL;
        if(ant == NULL){
            ant = novo;
            caminho = novo;
        }
        else{
            ant->prox = novo; // ambas são usadas para ligar os novos;
            ant = novo;
        }
        if(x > a->valor) a = a->dir;
        else if(x < a->valor) a = a->esq;
        else return caminho;
    }
    return NULL;
}

//4
void inc(char s[]){
    int l = strlen(s),i;
    for(i = l-1; i>= 0 && s[i] == '9'; i--){
        s[i] = '0';
    }
    if(i == -1){
        s[0] = '1'; s[l] = '0';s[l+1] = '\0';
    }
    else
    s[i] = '0';

}

//5
int sacos(int p[], int N, int C){
int i,j,sacos = 0;
bsort(p,N);
for(i = 0; i< N;i++){
    if(p[i] == C){
        sacos++;
        for(j = i; j<N-1;j++){
            p[j] = p[j+1];
        }
        N--;
        i--;
    }
}


}
