char* strcpy(char* dest, char source[]){
    int n;
    for(n = 0; source[n];n++) dest[n] = source[n];
    dest[n] = '\0'
    return dest;
}