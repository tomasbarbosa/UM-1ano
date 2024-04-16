#include <stdio.h>

int main(){
    int c,a,n; int u =0;
    if ((scanf("%d",&c)) == 1){
        if ((scanf("%d",&a)) == 1){
            if ((scanf("%d",&n)) == 1){
                for(int i = 0;i < n; i++){
                    if ((scanf("%d",&u))==1){
                        if(c > 0 && c < a){
                            if(u == 1){
                            c += 1;
                            }
                            if(u == -1){
                            c -= 1;
                            }
                        }
                        if(c==0){
                            if(u == 1){
                            c += 1;
                            }
                        }
                    
                        if(c==a){
                            if(u == -1){
                            c -= 1;
                            }
                        }
                    }
                }
            }
        }
    }
    printf("%d\n",c);
    return 0;
}
    




