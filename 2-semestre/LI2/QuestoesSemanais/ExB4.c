#include <stdio.h>
#include <string.h>

int main(){

    int n;
    char v[1000];
    

    if(scanf("%d",&n)!= 1)return 1;

    char vf[n];

    for(int i=0;i<n;i++){
        if (scanf("%s",v)!=1) return 1;
        int length = strlen(v);
        for(int j = 0; j<length;j++){
            for(int k = j+1; k<length;k++){
                if(v[j] == v[k]){
                    vf[i] = v[j];
                }
            }
        }
        
    }
    for(int l = 0; l <n ; l++){
        printf("%c",vf[l]);
    }
    putchar('\n');
    return 0;
}