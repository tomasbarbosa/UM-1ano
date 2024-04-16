#include <string.h>

int maiorSufixo (char s1[], char s2[]){

int cont = 0;

    int n1 =  strlen(s1);
    int n2 = strlen(s2);

    while(s1[--n1] == s2[--n2]) cont ++;

    return cont;
}