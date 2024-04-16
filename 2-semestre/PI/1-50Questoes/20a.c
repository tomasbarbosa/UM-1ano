int contaPal (char s[]){
    int n = 0;
    int i;
    for(i = 0; s[i] != '\0'; i++){
        if((s[i] != ' ' && s[i] != '\n' && s[i] != '\t') && (s[i+1] == ' ' || s[i+1] == '\0' || s[i] == '\n' || s[i] == '\t'))
            n++;
    }

    return n;
}
