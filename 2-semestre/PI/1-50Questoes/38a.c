void somasAc(int v[] , int Ac[], int N){
    int somas = 0, i;
    for(i = 0; i<N; i++){
        somas += v[i];

        Ac[i] = somas;
    }

}