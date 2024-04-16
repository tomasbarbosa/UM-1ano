#include <stdio.h> 
#include <string.h>
#define MAX_NLINHAS 5000
#define MAX_HORAS 24

int main(){
    int npessoas,nlinhas,agente,chegada,partida;
    int resultadoagentes[MAX_HORAS][MAX_NLINHAS + 1] = {0}; // o resultado final vai ter o resultado 0, depois em baixo caso o agente tenha estado entre aquela hora então o valor vai alterar para 1 para depois dar printf


    if(scanf("%d",&npessoas)!=1) return 1;

    if(scanf("%d",&nlinhas)!=1) return 1;

    for(int i=0;i<nlinhas;i++){ // para cada linha

        if(scanf("%d %d %d",&agente,&chegada,&partida)!= 3) return 3; // faz scanf da primeira linha

        if(agente == 0) break; // o agente tem que ser maior que 0, logo para o ciclo e vai para o próximo

        for(int x = chegada; x <= partida; x++){
            resultadoagentes[x][agente] = 1;  // vai preencher o intervalo de hora que o agente teve com 1 (substitui o 0)
        }

    }

    for(int y = 0; y<MAX_HORAS;y++){ // para cada linha
        int nagentes = 0;
        int resfa[MAX_NLINHAS];

        for(int z = 1; z <= MAX_NLINHAS;z++){ // para cada agente do array do resultadoagentes
            if(resultadoagentes[y][z]){ // = resultadoagentes[y][z] == 1, ou seja, se é verdade
                resfa[nagentes] = z;
                nagentes++;
            }
        }
        if (nagentes > 1) {
            printf("%d", y);
            for(int w = 0; w < nagentes; w++){  // print dos agentes por ordem
                printf(" %d",resfa[w]);
            }
            printf("\n");
        }


    }
    return 0;
}
