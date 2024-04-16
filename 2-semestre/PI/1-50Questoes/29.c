int retiraNeg(int v[], int N){
    for(int i = 0; i < N; i++){
        if(v[i] < 0){
            for(int j = i; j < N; j++){
                v[j] = v[j+1];
            }
            i--;
            N--;
        }
    }
    return N;
}