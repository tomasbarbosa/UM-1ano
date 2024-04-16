


char* strcat(char s1[], char s2[]){
    int n1,n2;
    for(n1 = 0; s1[n1];n1++);
    for(n2 = 0; s2[n2];n2++){
        s1[n1 + n2] = s2[n2];
    }
    s1[n1+n2] = '\0';
    return s1;

}