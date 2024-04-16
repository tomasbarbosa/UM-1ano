int qDig(unsigned int n){
    int x=1;
    while(n>10){
        x++;
        n /= 10;
    }

return x;
}