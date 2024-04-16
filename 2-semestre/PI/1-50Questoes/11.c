#include <stdio.h>
#include <string.h>

void strrev(char s[]){
    int n = strlen(s);
    char srev[n];
    int i,a;

    for(i = 0;i<n;i++){
        srev[n-1-i] = s[i];
    
    }
    srev[i +1] = '\0';
    for(a = 0; a<n; a++){
        printf("%c",srev[a]);
    }
    putchar('\n');
}


int main(){
    strrev("atum");
    return 0;
}