int comunsOrd(int a[], int na, int b[], int nb){
    int valoresCom = 0;
    int i=0,j=0;
    while(i<na && j<nb){
        if(a[i] == b[j]){
            valoresCom++;
            i++;
            j++;
        }
        else if (a[i] > b[j]){
            j++;
        }
        else
        i++;
    }
    return valoresCom;
}