void truncW(char t[], int n){
    int i = 0, letrasS = 0;
    while(t[i] != '\0'){
        if(t[i] == ' ' || t[i] == '\t' || t[i] == '\n'){
            letrasS = 0;
            i++;
        }
        else{
            letrasS++;
            if(letrasSeguidas > n){
                for(int j = i; t[j] != '\0'; j++){
                    t[j] = t[j+1];
                }
            }
            else i++;
        }
    }

}