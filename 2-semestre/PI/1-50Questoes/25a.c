int limpaEspacos(char t[]){
    int i,j;
    for(i = 0; t[i] != '\0';i++){
        if((t[i] == ' ' || t[i] == '\n' || t[i] == '\t') && t[i] == t[i+1]){
            for(j = i; t[j] != '\0'; j++){
                t[j] = t[j+1];
            }
            i--;
        }
        
    }
    return i;
}