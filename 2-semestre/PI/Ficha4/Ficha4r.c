#include <string.h>

//1
int eVogal(char c){
    if(c == 'a' || c == 'A' || c == 'e' || c == 'E' || c == 'i' || c == 'I' || c == 'o' || c == 'O' || c == 'u' || c == 'U')
    return 1;
    else
    return 0;
}
int contaVogais(char *s){
    int i;
    int cont = 0;
    for(i = 0; s[i] != '\0'; i++){
        if(eVogal(s[i])) cont++;
    }
    return cont;
}

//2
int retiraVogaisRep(char *s){
    int cont = 0;
    int i,j = 0;
    for(i = 0; s[i] != '/0';i++){
        if(eVogal(s[i]) && s[i] == s[i+1]){
            cont++;
        }
        else{
            s[j] = s[i];
            j++;
        }
    }
    return cont;
}

//3
int duplicaVogais(char *s){
    int cont = 0;
    int i,j = strlen(s);
    for(i = 0; s[i] != '/0';i++){
        if(eVogal(s[i])){
            for(j; j>i;j--){
                s[j] = s[j-1];
            }
            s[i+1] = s[i];
            cont++;
            i++;

        }
    }
}