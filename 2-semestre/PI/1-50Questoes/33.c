int elimRep(int v[], int n){
    int i,j,k;

    for(i = 0; i<n; i++){

        for(j = 0; j<i;j++){
            if(v[i] == v[j]){
                for(k = i;k<n;k++){
                    v[k] = v[k+1];
                }
                i--;
                n--;

            }
        }
    }
    return n;
}