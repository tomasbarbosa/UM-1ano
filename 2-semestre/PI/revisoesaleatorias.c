#include <string.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct lligada {
int valor;
struct lligada *prox;
} *LInt;

//25
void remreps(LInt l){
    if(l == NULL) return NULL;

    LInt aux = l;
    LInt ant = NULL;
    while(aux->prox != NULL){
        if(aux->valor == aux->prox->valor){
            ant->prox = aux->prox;
        }
        else{
            ant = aux;
        }
        aux = aux->prox;
    }
    return l;
}

typedef struct nodo {
int valor;
struct nodo *esq, *dir;
} *ABin;

//36
int pruneAB(ABin *a, int l){
    int n;
if((*a) == NULL) return 0;

        if(l == 0){
            n = 1 + pruneAB(&((*a)->esq),0) + pruneAB(&((*a)->dir),0);
            free(*a);
            (*a) = NULL;
        }
        else
            n = pruneAB(&((*a)->esq),l-1) + pruneAB(&((*a)->dir),l-1);

    return n;
}

//11
int removeDups(LInt *l){
    int cont = 0;
    for(;(*l) != NULL;(*l)= &(*l)->prox){
        LInt ant = NULL; LInt aux = (*l)->prox;
        for(;aux;aux = ant->prox){
            if(aux->valor == (*l)->valor){
                ant-> prox = aux->prox;
                cont++;
                free(aux);
            }
            else ant = aux;
        }

    }
    return cont;
    }


//40
int dumpAbin(ABin a, int v[], int N){
    int e = 0;
    if(a != NULL && N>0){
        e = dumpAbin(a->esq,v,N);

        if(e<N){
            v[e] = a->valor;
            return 1 + e + dumpAbin(a->dir,v[e+1],N-e-1);
        }
        else return N;
    }
    return 0;
}


int dumpAbin(ABin a, int v[], int N){
    int e;
    if(a != NULL && N > 0){
        e = dumpAbin(a->esq,v,N);

        if(e<N){
            v[e] = a->valor;
            return 1 + e + dumpAbin(a->dir,v+e+1,N-e-1);

        }
        else return N;
    }
    else return 0;
}

int cloneRev (LInt l){
    if(l == NULL) return NULL;
    int len = length(l);
    LInt arr[len];
    for(int i = len; i>=0;i--){
      arr[i] = malloc(sizeof(struct lligada));
        arr[i]->valor=l->valor;
        if(i<len-1) arr[i]->prox = arr[i+1];
        else arr[i]->prox = NULL;
        l = l->prox;
    }
    return arr[0];
}

void merge(LInt *r, LInt a, LInt b){
    if(a == NULL) *r = b;
    else if(b == NULL) *r = a;
    else if(a->valor > b->valor){
        *r = a;
        a = a->prox;
        merge(&(*r)->prox,a,b);
    }
    else if(a->valor < b->valor){
        *r = b;
        b = b->prox;
        merge(&(*r)->prox,a,b);
    }
}

void freeL(LInt l){
    LInt aux = l;
    while(l != NULL){
        aux = l;
        l = l->prox;
        free(aux);
    }
}


LInt parte(LInt l){
    if(l == NULL || l->prox == NULL) return NULL;
    
    LInt res = l->prox;
    l->prox = l->prox->prox;
    res->prox = parte(l->prox);

    return res;
}

//6
int removeOneOrd(LInt *l, int x){
    LInt aux = *l;
    LInt ant = NULL;

    while(aux != NULL && aux->prox != x){
        ant = aux;
        aux = aux->prox;
    }
    if(aux == NULL) return 1;
    if(ant == NULL) *l = aux->prox;
    else
        ant->prox = aux->prox;
}

//16
LInt cloneL(LInt l){
    if(l == NULL) return NULL;
    LInt new = malloc(sizeof(struct lligada));
    new->valor = l->valor;
    new->prox = cloneL(l->prox);

    return new;
}