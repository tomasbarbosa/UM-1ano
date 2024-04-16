#include <stdio.h>




int main() {
    int numsold = 1;
    int maximo = 0;
    for(int i = 1; i<6; i++){
        int a;
        if (scanf("%d",&a)==1){
            if(a > maximo){
            maximo = a;
            numsold = i;
        }   
        }

    }
    printf("%d\n",numsold);
    return 0;
}