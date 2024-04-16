#include <stdio.h>
//1

int multInt1(int n, float m){
    float r = 0;
    int i = 0;
    while(i<n){
        r += m;
        i++;
    }
    return r;
}

//2

int multInt2(int n, float m){
    float r = 0;

    while (n != 1){
        if(n%2 != 0){
            r+=m;
        }
        n = n/2;
        m = m*2;
    }
    printf("%If\n",r);
    return r;
}

int main(){
multInt2(81,423);
    return 0;
}

//3
int mdc(int a, int b){
    int menor,i,mdc;
    if(a<=b) menor = a;
    else menor = b;
    for(i=menor;i>=1; i--){
        if(a%i == 0) && b%i == 0) mdc = i;
    }
    return mdc;
}

/*
incompleta
int mdc1(int a, int b){
if(a < b){
    for(; a > 0; a--){
        if(b % a == 0){
            return a;
        }
    }
}
else{
    for(; b > 0; b--){
        if(a % b == 0){
            return b;
        }
    }
}
}
*/

//4

int mdc2(int a, int b){
    int i = 0;
    while(a*b != 0){
        if(a>b) a -=b;
        if(a<b) b -=a;
        if(a==b) break;
        i++;
        
    }
    if(a>=b) return a;
    else return b;
}

//5

int mdc2mod(int a, int b){
    int i = 0;
    while(a>0 && b>0){
        if(a>b) a % b;
        if(a<b) b % a;
        if(a==b) break;
        i++;
        
    }
    if(a>=b) return a;
    else return b;
}

//6

//a
int fib1(int n){
int x;
    if(n<2) x = 1;
    while(n>=2){
       x = fib1(n-1) + fib1(n-2);
    }
    return x;
}

//b
int fib2(int n){
    int x,y;
    if(n<2) x = 1;
    while(n>=2){
        x= fib2(n-1);
        y= fib2(n-2);

    }
    return (x+y);
}


