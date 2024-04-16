int crescente(int a[], int i, int j){
    int k, cresc = 1
    for(k = i; k<j && cresc == 1; k++){
        if(a[k] > a[k+1])
            cresc = 0;
    }
    return cresc;
}