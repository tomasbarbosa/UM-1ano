#include <stdlib.h>
typedef struct nodo{
    int valor;
    struct nodo *esq, *dir;
}*ABin;


//1
ABin removeMenor(ABin *a){
    ABin res;
    if(*a == NULL) return NULL;
    while((*a)->esq != NULL){
       a = &((*a)->esq);
    }
        res = *a;
        *a = (*a)->dir;

    return res;

}


//2
void removeRaiz(ABin *a){
    if(*a != NULL){
        ABin menor = removeMenor(&(*a)->dir);
        menor ->esq = (*a)->esq;
        menor->dir = (*a)->dir;
        free(*a);
        *a = menor;
    }
}

//3
int removeElem(ABin *a, int x){
    
}