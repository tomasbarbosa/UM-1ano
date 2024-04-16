int maiorPrefixo(char s1[], char s2[]){
    int mp = 0,i;
    for(i = 0; s1[i] != '\0' && s2[i] != '\0';i++){
        if(s1[i] == s2[i]) mp++;
        else break;
    }
    return mp;

}