#include <stdio.h>

int main() {
    int n; char r1,r2; int v1 = 0; int v2 = 0; int e = 0;
    if (scanf("%d",&n)==1){
        for(int i=0;i < n;i++){
            if(scanf(" %c %c",&r1,&r2)==2){
                
                    if(r1 == ('@') && r2 == ('*')){
                        e += 1;
                    }
                    if(r1 == ('|') && r2 == ('-')){
                        e += 1;
                    }
                    if(r1 == ('X') && r2 == ('+')){
                        e += 1;
                    }
                    if(r1 == ('@') && r2 == ('-')){
                        v2 += 1;
                    }
                    if(r1 == ('@') && r2 == ('+')){
                        v1 += 1;
                    }
                    if(r1 == ('|') && r2 == ('*')){
                        v1 += 1;
                    }
                    if(r1 == ('|') && r2 == ('+')){
                        v2 += 1;
                    }
                    if(r1 == ('X') && r2 == ('*')){
                        v2 += 1;
                    }
                    if(r1 == ('X') && r2 == ('-')){
                        v1 += 1;
                    }
                }
            }
         }
    printf("%d %d %d\n",v1,v2,e);
    return 0;
}