void insere(int v[], int N, int x){
    while(N>0 && v[N-1] > x){
        v[N] = v[N-1];
        N--;
    }
    v[N] = x;
}