#include <stdio.h>
#include <string.h>
/*

1.

a)
int main () {
int x [15] = {1, 2, 3, 4, 5,
6, 7, 8, 9,10,
11,12,13,14,15};
int *y, *z, i;
y = x;
z = x+3;
for (i=0; i<5; i++) {
printf ("%d %d %d\n",
x[i], *y, *z);
y = y+1; z = z+2;
}

output :
1 1 4
2 2 6
3 3 8
4 4 10
5 5 12



b)
int main () {
int i, j, *a, *b;
i=3; j=5;
a = b = 42;
a = &i; b = &j;
i++;
j = i + *b;
b = a;
j = j + *b;
printf ("%d\n", j);
return 0;
}

dica, fazer um desenho com os 4 endereços separados de 4 a 4
output :  13


*/

//2

void swapM(int *x, int *y){
    int grd;
    grd = *x;
    *x = *y;
    *y = grd;
}



//3

void swap (int v[], int i, int j){
    int g = v[i];
    v[i] = v[j];
    v[j] = g;

}

//4

int soma(int v[], int N){
    int s = 0;
    for(int i = 0; i<N; i++){
        s += v[i];
    }
    printf("%d\n",s);
return 0;
}

//5
/*
minha versão, no tutor está certo mas não da print
void inverteArray(int v[], int N){
    for(int i=0;i<N;i++){
        if(i == N) break;
        else{
        swap(v,i,N);
        N -= 1;
        }
    }
    
}
*/

void inverteArray(int v[], int N){
    int i,j;
    for(i = 0; j = N; i!=j){
        swap(v,i,j);
        //swapM(v+i,v+j);

    }
}

int maximum(int v[], int N, int *m){
    int i = 0;
    if(N == 0) return 1;
    else{
        for(i=1; i<N;i++){
            if(v[i]> *m){
                *m = v[i];
                return 0;
            }
        }
    }
}





int main() {

}