#include <stdlib.h>
#include <stdio.h>



typedef struct slist {
int valor;
struct slist * prox;
} * LInt;


LInt newLInt (int x, LInt xs) {
LInt r = malloc (sizeof(struct slist));
if (r!=NULL) {
r->valor = x; r->prox = xs;
}
return r;
}

typedef LInt Stack;

typedef struct {
LInt inicio,fim;
} Queue;


//1
void initStack(Stack *s){
    *s = NULL;
}

//2
int sisEmpty(Stack s){
    if(s == NULL) return 1;
    return 0;
}

//3

int push(Stack *s, int x){
    LInt novo = newLInt(x, *s);

    if(novo == NULL){
        return 1;
    }
    else{
        *s = novo;
        return 0;
    }
    
}

int pop(Stack *s, int *x){
    if(SisEmpty(*s)) return 1;
    LInt aux;
    *x = s*->valor;
}
