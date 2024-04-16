void merge(int r[], int a[], int b[], int na, int nb){
    int i = 0, j = 0;

while(i+j<na+nb){
    if(j == nb || a[i] < b[j]){
        r[i+j] = a[i];
        i++;
    }
    else{
        r[i+j] = b[j];
        j++;
    }
}
}