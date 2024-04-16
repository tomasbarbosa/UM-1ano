int naoExiste(char s[], int n){
    for(int i = 0; i<n;i++){
        if(s[i] == s[n]) return 0;
    }
    return 1;
}

int difConsecutivos(char s[]){
    int i, j, cont = 0, seq;
    for(i = 0; s[i] != '\0'; i++){
        seq = 0;
        for(j = 0; s[i+j] != '\0' && naoExiste(s+i,j); j++){
            seq++;
        }
        if(seq > max){
            max = seq;
        }
    }
    return max;
}