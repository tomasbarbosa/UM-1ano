#include <string.h>

int palindorome(char s[]){
    int pal = 0,cont = 0;
    int n = strlen(s) - 1;
    int i;


    for(i = 0; s[i] != '\0'; i++){
        if(s[i] == s[n-i]){
            cont++;
        }
    }
    if(cont == n+1){
        pal = 1;
    }
    return pal;
}