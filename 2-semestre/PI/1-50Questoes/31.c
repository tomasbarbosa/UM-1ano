int maisFreq(int v[], int N){
    int i, j, freq, elem, max = 0;
    for(i = 0; i< N; i++){
        freq = 0;

        for(j = i; v[j] == v[i] ; j++,freq++);

        if(freq > max){
            max = freq;
            elem = v[i];
        }
        i = j-1;
    }
    return elem;
}