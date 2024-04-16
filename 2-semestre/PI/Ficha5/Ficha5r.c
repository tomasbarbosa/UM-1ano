typedef struct aluno {
int numero;
char nome[100];
int miniT [6];
float teste;
} Aluno;

//2
int procuraNum(int num, Aluno t[], int N){
    for(int i = 0; i<N;i++){
        if(num == t[i].numero){
            return i;
        }
    }
    return -1;
}

//3
void ordenaPorNum(Aluno t[], int N){
    for(int i = N; i>0;i--){
        for(int j = 1; j<i;j++){
            if(t[j].numero > t[j+1].numero){
                Aluno temp = t[j];
                t[j] = t[j+1];
                t[j+1] = temp;
            }
        }
    }
}

//4
void criaIndPorNum(Aluno t[], int N, int ind[]){
    int i, j,k;

    for(k = 0; k<N;k++){
        ind[k] = k;
    }

    for(i = N; i>0; i--){
        for(j = 1; j<i;j++){
            if(t[ind[j]].numero > t[ind[j+1]].numero){
                int temp = ind[j];
                ind[j] = ind[j+1];
                ind[j+1] = temp;
            }
        }
    }
}

//5
void imprimeTurma(int ind[], Aluno t[], int N){
    for(int i = 0; i<N;i++){
        Aluno a = t[ind[i]];
        printf("%d | %5s | %2d \n", a.numero, a.nome, nota(a));
    }
}