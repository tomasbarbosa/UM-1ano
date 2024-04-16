#include <stdio.h>

int main() {
    int a,b,c;

    if ((scanf("%d",&a)==1) && (scanf("%d",&b)==1) && (scanf("%d",&c)==1)){
        if (((a>=b) && (b>=c)) || ((a<=b) && (b<=c))){
            printf("OK\n");
        }
        else{
            printf("NAO\n");
        }
    }
    return 0;
}