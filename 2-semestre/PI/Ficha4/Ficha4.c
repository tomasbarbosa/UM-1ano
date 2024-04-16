
//necessário fazer um eVogal que verifica se é vogal
//1

int contaVogais(char *s){
    int r = 0;
    int i;
    int eVogal(char c);
    for(i = 0; s[i] != '\0'; i++){
        if(eVogal(s[i])) r++;

    }
    return r;
}

//2
/*
int retiraVogaisRep (char *s){
    char aux[strlen(s) +1]
    int i, j = 0; int count = 0;
    for(i = 0; s[i] != '\0'; i++){
        if (!eVogal(s[i]) || s[i] != s[i+1]){
            aux[j] = s[i];
        j++;
        aux[j = '\0'; ]
        }
        else count++;
    }

}
*/
int retiraRep(char *s){
    int count = 0;
    int i,j;
    for(i = 0; s[i] != '\0'; i++){
        if(eVogal(s[i]) && s[i+1] == s[i]){
            count++;
        }
        else{
            s[j] = s[i];
            j++;
        }
    }
    return count;
}

//3 

int duplicaVogais(char *s){
    
}










































