#include <string.h>

int sufPref(char s1[], char s2[]){

    int cont =0;
    int i, n2 = 0;

    for(i = 0; s1[i] != '\0'; i++){
        if(s1[i] == s2[n2]){
            n2++;
            cont++;
        }
        else{
            cont = 0;
            n2 = 0;
        }

    }


     
    return cont;
}