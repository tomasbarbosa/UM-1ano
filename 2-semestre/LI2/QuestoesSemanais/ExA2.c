#include <stdio.h>

int main() {
    int x = 0; int y = 0;int a; int n;
    if((scanf("%d",&n))==1){
        for(int i = 0;i<n;i++){
            if((scanf("%d",&a))==1){
                if((a % 4) == 0){
                    x+=1;
                }
                if((a % 4) == 3){
                    x-=1;
                }
                if((a % 4) == 2){
                    y+=1;
                }
                if((a % 4) == 1){
                    y-=1;
                }
            
            }
        }
    }
    
    printf("%d %d\n",x,y);

}


