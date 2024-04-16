#include <stdio.h>
#include <string.h>
// esta ficha3 está corrigida!!
//1 

/*a
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
*/

/*b
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

output : 13
*/

//2
void swapM(int *x, int *y){
    int aux = *x;
    *x = *y;
    *y = aux;
}

//3
void swap(int v[], int i, int j){
    int g = v[i];
    v[i] = v[j];
    v[j] = v[i];
}

//4
int soma(int v[], int N){
    int i, somas = 0;
    for(i = 0; i<N;i++){
        somas += v[i];
    }
    return somas;
}

//5
void inverteArray(int v[], int N){
    int i,j;
    for(i = 0;j=N;i++ && N--){
        if(i==N) break;
        else{
        swap(v,i,j);
        }
    }
}

//6
int maximum(int v[], int N, int *m){
    if(N < 0) return 1;
    for(int i = 0;i<N;i++){
        if(v[i] > *m)
            *m = v[i];
    }
    return 0;
}

//7
void quadrados(int q[], int N){
    q[0] = 0;
    for(int i = 1; i< N-1;i++ ){
        q[i] = q[i-1] + (2 * (i-1)+1);
    }
}