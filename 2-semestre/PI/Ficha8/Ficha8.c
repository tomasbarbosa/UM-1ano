#include <stdlib.h>
#include <stdio.h>

typedef struct slist{
    int valor;
    struct slist * prox;
} * LInt;

typedef LInt Stack;

typedef struct{
    LInt inicio,fim;
} Queue;

LInt newLInt (int x, LInt xs){
    LInt r = malloc(sizeof(struct slist));
    if(r!=NULL){
        r -> valor = x; r -> prox = xs;
    }
    return r;

}

// Através da implementação de Stacks

//1
//a
void initStack(Stack *s){
    *s = NULL;
}
//b
int SisEmpty (Stack s){
    return(s==NULL);
}
//c
int push (Stack *s, int x){
    // através da função dada em cima
    LInt aux = newInt(x, *s);
    if(aux == NULL){
        return 1;
    }
    *s = aux;
    return 0;
    /*
    Stack aux = malloc(sizeof(struct slist));
    if(aux==NULL)
        return 1;

    aux -> valor = x;
    aux -> prox = *s;
    return 0;
    */
}
//d
int pop (Stack *s, int  *x){
    if(SisEmpty(*s)) return 1;
    LInt aux;
    *x = (*s) -> valor;
    aux = (*s) -> valor;
    free(*s);
    *s = aux;
    return 0;
}
//e
int top (Stack s, int *x){

}


//Queue

void initQueue(Queue *q){
    q -> inicio = NULL;
    (*q).fim = NULL;
}

int QisEmpty(Queue q){
    return(q.inicio == NULL);
}

void enqueue (Queue *q, int x){
    LInt aux = newLInt(x,NULL);
    if(QisEmpty(*q)){
        q -> inicio = aux;
        q -> fim = aux->prox;
    }
    else{
        q -> fim -> prox = aux;
        q -> fim = aux;
    }
    return 0;
}