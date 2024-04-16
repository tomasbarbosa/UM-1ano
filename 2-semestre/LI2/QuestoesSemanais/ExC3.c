#include <stdio.h>

int main(){
int n,k,x;

if(scanf("%d",&n)!= 1)
    return 1;

int vfinal[n];

for(int i = 0; i<n; i++){
    if(scanf("%d",&k)!= 1)
    return 1;
    int maior = 0;
    int avisiveis = 0;

    for(int j = 0; j < k;j++){
        if(scanf(" %d",&x)!=1){
            return 1;
        }
        if(x>maior){
            maior = x;
            avisiveis += 1;
        }
    }
    vfinal[i] = avisiveis;
    
}
    for(int l = 0; l <n ; l++){
        printf("%d\n",vfinal[l]);
    }
    return 0;
}