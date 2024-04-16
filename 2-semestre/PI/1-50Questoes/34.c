int elimRepOrd (int v[], int n){
    for(int i = 1; i<n;i++){
        if(v[i] == v[i-1]){
            for(int j = i; j < n; j++){
                v[j] = v[j+1];
            }
            i--;
            n--;
        }
    }
}