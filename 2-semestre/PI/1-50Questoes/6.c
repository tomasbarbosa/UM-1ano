int qDig (unsigned int n){
    int r = 0;
    while((n / 10) > 1){
        r++;
        n /= 10;
    }
    if(n < 10){
    r++;
    }
    return r;
}