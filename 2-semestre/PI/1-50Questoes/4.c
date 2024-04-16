
int bitsUm(unsigned int n){
    int contador = 0;

    while(n){
        contador += (n % 2);
        n /= 2;
    }
    return contador;
}

