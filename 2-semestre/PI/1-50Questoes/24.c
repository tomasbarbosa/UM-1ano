int remRep(char x[]){
    int i,j;
    for(int i = 0; x[i] != '\0';){
        if(x[i] == x[i+1]){
            for(j = i; x[j] != '\0'; j++){
                x[j] = x[j+1];
            }
        }
        else i++;
    }
    return i;
}