#include <string.h>

void strrev(char s[]){
    int n = strlen(s);
    char rs[n];
    int i,j;

    for(i = 0; i<n;i++){
        rs[n-1-i] = s[i];

    }
    for(j = 0;j<n;j++){
        s[j] = rs[j];
    }
    
}