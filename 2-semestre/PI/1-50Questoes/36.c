int comuns(int a[], int na, int b[], int nb){
    int contCom = 0;
    int j,i;

    for(i=0;i<na;i++){
        for(j=0;j<nb;j++){
            if(a[i]==b[j]){
                contCom++;
                break;

            }
        }
    }
    return contCom;
}