int menosFreq ( int v[], int N){
    int i, j,freq, elem = v[0], min = N;
    for(i = 0; i < N; i++){
        freq = 0;
        
        for(j = i; v[j] == v[i]; j++, freq++);

        if(freq < min){
            min = freq;
            elem = v[i];
        }
    }
    return elem;
}