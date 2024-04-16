int minInd(int v[], int n){
    int min = n;
    int i;
    int indice;
    for(i=0;i<n;i++){
        if(v[i] < min){
            min = v[i];
            indice = i;

        }
    }
    return indice;
}