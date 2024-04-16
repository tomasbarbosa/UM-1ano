char charMaisfreq(char s[]){
int cont = 0;max = 0;
char maxFreqChar;


for(int i = 0; s[i] != '\0'; i++){
    cont = 0;

    for(int j = 0; s[j] != '\0'; j++){
        if(s[j] == s[i])
        cont++;

    }
    if(cont > max){
        max = cont;
        maxFreqChar = s[i];
    }
    
}
return maxFreqChar;
}