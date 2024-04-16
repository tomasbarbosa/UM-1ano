int limpaEspacos(char t[]){
    int i;
    for(i = 0; t[i] != '\0';){
        if((t[i] == ' ' || t[i] == '\n' || t[i] == '\t') && t[i] == t[i+1]){
            for(int j = i; t[j] != '\0'; j++){
                t[j] = t[j+1];
            }
        }
        else i++;

    }
    return i;
}