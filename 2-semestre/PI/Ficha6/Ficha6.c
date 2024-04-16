#include <stdio.h>
#include <stdlib.h>


#define Max 10
//1

struct staticStack{
    int sp; // stack pointer (apontador da stack)
    int values [Max];
};
typedef struct staticStack *SStack;

//a

void SinitStack (SStack s){
s->sp = 0;
}

//b
int SisEmpty (SStack s){
    if(s->sp == 0){
        return 1;
    }
    else
    return 0;
}

//c
int Spush (SStack s, int x){
    if(s-> sp == Max){
        return 1;
    }
        s -> values[(s -> sp)] = x;
        s -> sp++;

    return 0;
}

//d
int Spop (SStack s, int *x){
    if(s->sp == 0) return 1; // if(isEmpty(s)) return 1;
    *x = s -> values[(s ->sp-1)];
    s-> sp--;
    return 0;
}

int Stop (SStack s, int *x){
    if(s->sp == 0) return 1; 
    *x = s -> values[(s->sp-1)];
return 0;
}

//2

struct staticQueue {
    int front;
    int length;
    int values [Max];
};
typedef struct staticQueue *SQueue;

//a

void SinitQueue (SQueue q){
    q -> length = 0;
}

//b
int SisEmptyQ (SQueue q){
    if(q -> length == 0) return 1;
    else return 0;
}

//c
int SenQueue (SQueue q, int x){
    if(q -> length == 0) return 1;
    q -> values[q->length-1] = x;
    q -> length++;
    return 0;
}

//d
int prox(int i){ // calcular a próxima posição do prox
    /*if(i<Max -1)
        return i+1; não é neessário ter isto
        */
    return(i+1)%Max;
}
int Sdequeue (SQueue q, int *x){

}


