int existe(int x, int a[], int n){
    for(int i = 0; i < n; i++)
        if (a[i] == x) return 1;
    return 0;
}

int main(){
    int a[5] = {1,2,3,4,5};
    existe(4,a,5);
    return 0;
}