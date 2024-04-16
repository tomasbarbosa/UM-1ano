int maxCresc (int v[], int N){
    int contador = 1, maxseq = 0;
    int i;

    for(i = 0; i<N;i++){
        if(v[i] <= v[i+1]){
            contador++;
        }
        else{
            if(contador > maxseq){
                maxseq = contador;
            }
            contador = 1;
        }
    }
    return maxseq;
}