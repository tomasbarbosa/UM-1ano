#include <stdio.h>

//exercício 3

//3.1


/* --versão do stor
void linha(int n){
    int i;
    i=1;
    while (i<=n){
        putchar('#');
        count++;
    }i+= 1;
}
return count;


void quadrado(int n){
    int i;
    i=0;
    while(i<n){
        linha(n);
        i++;
        putchar('\n');
    }

 }
 putchar ('\n');


int main(){
    printf ("Ex 3.1:\n");
    quadrado(5);
    return 0;
}
*/
void quadrado(int n) {
    for (int i = 0; i<n; i++){
        for(int i=0;i<n;i++){
            putchar ('#');
        
        }
        putchar ('\n');
    }
}
// EX 3.2
void xadrez(int n){
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            if (j % 2 == 0){
            putchar ('_');
            }
            else putchar ('#');
        }
        putchar ('\n');
    }   
}
/*da maneira do stor
void linhapar(int n) {
    int i;
    i = 0;
    while(i<n){
        if(i%2 == 0) //resto da divisão inteira
            putchar('#')
        else {putchar ('_');}
        i++;
    }
}
*/



int main(){
    printf("Ex 3.1: \n");
    quadrado(5);

    printf ("\nEx 3.2:\n");
    xadrez(5);

    printf ("\nEx 3.3\n");


    return 0;
}

//3.3 num ficheiro isolado
