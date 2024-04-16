#include <stdio.h>

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
int max(int a, int b){
    if(a>=b) return a;
    else return b;
}
//a
int altura(ABin a){
    if(a == NULL) return 0;
    return 1 + max(altura(a->esq), altura(a->dir));
}

//b
int nFolhas(ABin a){
    int folhas;
    if(a == NULL) return 0;
    else{
        folhas = 1 + nFolhas(a->esq) + nFolhas(a->dir);
    }
    return folhas;
}

//c
ABin maisEsquerda (ABin a){
    if(a == NULL) return a; //se estiver vazia
    if(a->esq == NULL) return a;
    return maisEsquerda(a->esq);
}

//d
void imprimeNivel(ABin a, int l){
    if(l == 0){
        printf("%d\n", a->valor);
    }
    imprimeNivel(a->esq, l-1);
    imprimeNivel(a->dir,l-1);
}

//e
int procuraE(ABin a, int x){
    if(a == NULL) return 0;
    if(a-> valor == x) return 1;
    else return (procuraE(a->esq,x) || procuraE(a->dir,x));
}

//2

//f
struct nodo * procura(ABin a, int x){
    if(a == NULL || a->valor == x) return a;
    if(a->valor > x)
        return a->esq;
    else 
        return a->dir;
}
//g
int nivel(ABin a, int x){
    int contador = 0;
    while(a != NULL || a-> valor != x){
        contador++;
    }
    if(a==NULL) return -1;
    return contador;
}