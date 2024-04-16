#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct aluno{
    int numero;
    char nome[100];
    int miniT [6];
    float teste;
};
typedef struct aluno Aluno;

//1
int nota (Aluno a){
    float notaF = 0;
    float miniT = 0;
    int i;
    for(i = 0;i < 6; i++){
        miniT += a.miniT[i];
    }
    miniT = miniT * 10/6;

    notaF = 0.8 * a.teste + 0.2 * miniT;

    if(notaF < 9.5 || miniT < 5)
        notaF = 0;

return round(notaF);    
}

//2
int procuraNum(int num, Aluno t[], int N){
    int i;  
    for(i = 0; i<N;i++){
        if(num == t[i].numero) return i;

    }
    return -1;

}

//3
void ordenaPorNum(Aluno t [], int N){
    int i,j;
    Aluno temp;
//bubble sort
    for(i = 0; i<N-1;i++){
        for(j= i+1;j<N;j++){
            if(t[i].numero > t[j].numero){
                temp = t[i];
                t[i] = t[j];
                t[j] = temp;
            }
        }
    }
}


//4
void criaIndPorNum(Aluno t[], int N, int ind[]){
    int i, j,k;
    int x;
    for(k = 0; k<N;k++){
        ind[k] = k;
    }
    for(i = 0; i<N-1;i++){
        for(j= i+1;j<N;j++){
            if(t[ind[i]].numero > t[ind[j]].numero){
                x = ind[i];
                ind[i] = ind[j];
                ind[j] = x;
            }
        }
    }
}

//5
void imprimeTurma(int ind[], Aluno t[], int N){
    for(int i = 0; i<N;i++){
        int indT = ind[i];
        Aluno a = t[indT];
        printf("%d | %5s | %2d \n", a.numero, a.nome, nota(a));
    }
}

//6


//7
void ordenaPorNome(Aluno t [], int N, int ind[]){
    if(N <= 1) return;

    ordenaPorNome(t, N-1, ind);

    int i;
    for(i = N-2; i >= 0; i--){
        if(strcmp(t[ind[i]].nome, t[ind[i+1]].nome) < 0){
            int temp = ind[i];
            ind[i] = ind[i+1];
            ind[i+1] = temp;
        }
    }
}

void criaIndPorNome(Aluno t[], int N, int ind[]){
    for(int i = 0; i< N; i++)
        ind[i] = i;
        ordenaPorNome(t,N, ind);
}