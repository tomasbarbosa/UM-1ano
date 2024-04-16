int cardinalMSet(int N, int v[N]){
int i, elem = 0;
    for(i = 0; i<N; i++){
        elem += v[i];
    }
    return elem;
}