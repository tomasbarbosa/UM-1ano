int contaVogais (char s[]){
    int cont = 0,i;

    for(i = 0; s[i] != '\0';i++){
        if(s[i] == 'a' || s[i] == 'A' || s[i] == 'e' || s[i] == 'E' || s[i] == 'i' || s[i] == 'I' || s[i] == 'o' || s[i] == 'O' || s[i] == 'u' || s[i] == 'U'){
            cont++;
        }
    }
    return cont;
}