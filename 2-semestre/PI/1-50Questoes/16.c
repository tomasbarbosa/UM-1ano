int naoExiste(char s[], int n){
    for(int i = 0; i< n; i++){
        if(s[i] == s[n]){
            return 0;
        }
    }
    return 1;
}

int difConsecutivos(char s[]){
    int seq, max = 0;
    for(int i = 0; s[i] != '\0'; i++){
        seq = 0;
        for(int j = 0; s[i+j] != '\0' && naoExiste(s+i, j);j++){
            seq++;
        }
        if (seq > max)
        max = seq
    }
    return max;
}