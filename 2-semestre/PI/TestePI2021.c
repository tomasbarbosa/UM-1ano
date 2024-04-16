#include <stdlib.h>
#include <string.h>

//1
int sumhtpo (int n) {
int sum = 0;
int *v;

while (n != 1) {
    v[sum] = n;
    sum++;
    if(n%2 == 0) n = n/2; 
    else n = 1+(3*n);
}
if(sum < 99) return -1;

    for(int i = sum; i> 0;i--){ // coloca por ordem crescente
        for(int j = 0; j<i;j++){
            if(v[j] > v[j+1]){
                int temp = v[j];
                v[j] = v[j+1];
                v[j+1] = v[j];
            }
        }
    }
    return v[0];
}

//2
int moda(int v[], int N, int *m){
    int freq;
    int maxFreq = 0;
    int moda = 0;
    int multiModal = 0;
    for(int i = 0; i < N; i++){
        freq = 0;
        for(int j = i; j < N; j++){
            if(v[j] == v[i])
                freq++;
        }
        if(freq > maxFreq){
            maxFreq = freq;
            moda = v[i];
            multiModal = 0;
        }
        if(freq == maxFreq && moda != v[i])
            multiModal=1;
    }

    if(N == 0 || multiModal)
        return 0;
    
    *m = moda;
    return maxFreq;
}

//3
int procura(LInt *l, int x){
    if((*l) == NULL) return 0;

    LInt aux = *l; LInt ant = NULL;
        while(aux != NULL && aux->valor != x){
            ant = aux;
            aux = aux->prox;
        }
        if(ant == NULL) return 1;

        ant->prox = aux->prox;
        aux->prox = (*l);
        (*l) = aux;
        return 1;
    }

//4
int freeAB(ABin a){
    if(a == NULL) return 0;

    int nodos = 1;

    nodos += freeAB(a->dir);
    nodos += freeAB(a->esq);

    free(a);

    return nodos;
}

//5

typedef struct nodo {
int valor;
struct nodo *pai, *esq, *dir;
} *ABin;


void caminho(ABin a){
    if(a->pai == NULL) return;

    caminho(a->pai);

    if(a->pai->esq->valor == a->valor){
        printf("dir\n");
    }
    else
        printf("esq\n");
}

