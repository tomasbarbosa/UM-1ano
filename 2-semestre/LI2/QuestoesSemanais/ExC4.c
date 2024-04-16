#include <stdio.h>
#include <string.h>

int main(){

char conjunto[1000];
int n,x,d = 1;

if(scanf("%d",&n)!= 1) return 1;

int vf[n];

for(int i=0;i<n;i++){
    if(scanf("%d",&x)!= 1) return 1;

    if(scanf("%s",conjunto)!=1) return 1;

int cconjunto = strlen(conjunto);

    for(int j=0;j<=cconjunto-x;j++){
         d = 1;
        for(int k=j;k<j+x && d!=-1;k++){
            for(int l=k+1;l<j+x && d!=-1;l++){
                if(conjunto[k] == conjunto[l]){
                    d =-1;
                }
            }

        }
        if(d==1){
            vf[i] = j;
        break;
        }
    }
    if (d==-1) vf[i] = d;
    
}
for(int m = 0;m<n;m++){
    printf("%d\n",vf[m]);
}

return 0;
}