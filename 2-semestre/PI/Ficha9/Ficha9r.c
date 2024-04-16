#include <stdlib.h>

typedef struct nodo {
int valor;
struct nodo *esq, *dir;
} * ABin;

ABin newABin (int r, ABin e, ABin d) {
    ABin a = malloc (sizeof(struct nodo));
    if (a != NULL){
        a -> valor = r; a -> esq =  e; a->dir = d;
    }
    return a;
}

//1

//a
int max(int a, int b){
    if(a <= b) return b;
    else return a;
}
int altura(ABin a){
    if(a == NULL) return 0;
    return 1 + max(altura(a->esq), altura(a->dir));
}

//b 
int nFolhas(ABin a){
    int folhas;
    if(a == NULL) return 0;
    else folhas = 1 + (nFolhas(a->esq) + (nFolhas(a->dir)));
    return folhas;
}

//c
ABin maisEsquerda(ABin a){
    if(a == NULL) return a;
    while(a->esq != NULL){
        a = a->esq;
    }
    return a;
}

//d
void imprimeNivel(ABin a, int l){
    if(l == 0){
        printf("%d\n", a->valor);
    }
    imprimeNivel(a->esq,l-1);
    imprimeNivel(a->dir,l-1);
}

//e
int procuraE(ABin a, int x){
    if(a == NULL) return 0;
    if(a->valor == x) return 1;
    else return (procuraE(a->esq, x) || (procuraE(a->dir,x)));

}

//2

//f
struct nodo *procura(ABin a, int x){
    if(a == NULL) return NULL;
    if(a->valor == x) return a;

    if(a->valor > x)
        a = procura(a->dir,x);
    else
        a = procura(a->esq,x);
}

//g
int nivel(ABin a, int x){
int nivel = 0;
while(a != NULL){
    if(a->valor == x) return nivel;
    nivel ++;

    if(a->valor > x) a = a->dir;
    else a = a->esq;
}
    return -1;
}

//h
void imprimeAte(ABin a, int x){
    int aux = x;
    while(a != NULL){
        if(a->valor > aux) a = a->esq;
        else{
            printf("%d\n",a->valor);
            aux = a->valor;
        }
    }
}