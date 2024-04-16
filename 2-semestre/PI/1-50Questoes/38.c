void somasAc (int v[], int Ac[], int N){
    int acc = 0;
    int i;
    for(i = 0; i<N; i++){
        acc += v[i];
        Ac[i] = acc;
    }
}