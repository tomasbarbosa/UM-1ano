

int contaPal(char s[]){
int i;
int contp = 0;
int inWord = 0;

for(i = 0;s[i]; i++){
    if(s[i] == ' ' || s[i] == '\n' || s[i] == '\t') {
        if(inWord) contp ++;
        inWord = 0;
    }
    else inWord = 1;
    
}

return contp + inWord;
}