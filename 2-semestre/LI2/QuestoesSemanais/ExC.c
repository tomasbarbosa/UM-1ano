#include <stdio.h>

int main() {
    int a,b,c;

    if((scanf("%d",&a)==1) && (scanf("%d",&b)==1) && (scanf("%d",&c)==1)){
       if(a>b){
        int primeiroa = a;
        a=b;
        b=primeiroa;
       }
       if(a>c){
        int primeiroa = a;
        a=c;
        c=primeiroa;
       }
       if(b>c){
        int primeirob = b;
        b=c;
        c=primeirob;
       }
       printf("%d %d %d\n",a,b,c);
    }
    return 0;
}

