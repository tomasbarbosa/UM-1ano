#include <stdio.h>
#include <string.h>


int main(){ 
    int n;
    


    if(scanf("%d",&n) != 1) return 1; // numero de linhas 

   int sequencias[n][100]; // para guardar as sequencias todas juntas
   int numk[n]; // para guardar o nº de elementos da sequencia todos juntos
   int numi[n]; // para guardar o gliche inicial de cada sequencia todos juntos
   
   

    for(int j = 0; j<n; j++){

        if(scanf("%d",&numk[j]) != 1) return 1;  // array onde vai guardar todos os k's

    
        if(scanf("%d",&numi[j]) != 1) return 1; // array onde vai guardar todos os i's

        for(int x = 0; x<numk[j];x++){
            if(scanf("%d",&sequencias[j][x]) != 1) return 1; // array onde vai guardar todas as sequencias
        }
    }

    for(int y = 0; y < n; y++){
        
        int seqgerada[numk[y]]; // guardar cada sequencia tendo como comprimento o k dado
        seqgerada[0] = numi[y]; // o primeiro elemento é o i
        int eciclo = 0; // verifica se em cada sequencia é ciclo
        int size = 1; 

        for(int w = 0;w<numk[y]+1;w++){
            int e = sequencias[y][(seqgerada[w])-1]; //nas sequencias ele vai buscar o elemento (y,o da sequencia gerada)da matriz 

            if(e == 0) break;

            for(int z = 0; z<size;z++){
                if(seqgerada[z] == e){
                    eciclo = 1;
                    break;
                }
            }
            if(eciclo==1) break;

            size++;
            seqgerada[w+1] = e;
        }
        
        
            for (int v = 0; v < size  ; v++) {
            if(v==size-1) printf("%d", seqgerada[v]);
            else printf("%d ", seqgerada[v]);
        }

        if (eciclo == 1) {
            printf(" CICLO INFERNAL\n");
        } else {
            printf("\n");
        }

    }

    return 0;
}