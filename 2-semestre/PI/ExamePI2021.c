#include <stdio.h>
#include <stdlib.h>
#include <string.h>


//1
int paresImpares (int v[], int N){
    int i, j,k, pares = 0;
    for(i = 0; i<N; i++){
        for(j = 0;j<N;j++){
            if(v[j] % 2 == 0){
                int temp;
                temp = v[i];
                v[i] = v[j];
                v[j] = temp;

            }
        }
    }
    for(k = 0; k<N;k++){
        while(v[k] % 2 == 0){
            pares++;
        }
    }
    return pares;
}

//2
typedef struct LInt_nodo {
int valor;
struct LInt_nodo *prox;
} *LInt;

void merge(LInt *r, LInt a, LInt b){
    if(a == NULL){
        *r = b;
        return;
    }
    if(b == NULL){
        *r = a;
        return;
    } 

    *r = a;
    while(a->prox != NULL){
        a = a->prox;
    }
    a->prox = b;
}


//3
void latino(int N, int m[N][N]){
    int i,j;
    for(i = 0; i<N;i++){
        for(j = 0; j<N;j++){
            m[i][j] = (i+j)%N + 1;
        }
    }
}

//4
typedef struct nodo {
int valor;
struct nodo *pai, *esq, *dir;
} *ABin;

ABin next(ABin a){
    int *p;
    if(a == NULL) return;
    

    if(a->dir != NULL){
        a = a->dir;

        while(a->esq != NULL){
            a = a->esq;
        }
        return a;
    }

    if(a->dir == NULL){
        while(a->pai->valor < a->valor){
            if(a->pai == NULL) return NULL;
            a = a->pai;
        }
        if(a->pai->valor > a->valor) return a->pai;
    }

}