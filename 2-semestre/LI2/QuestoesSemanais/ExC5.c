#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINHAS 40
#define MAX_CARACTERES 1000
#define MAX_PALAVRAS 20

int main() {
    int nlinhas;
    char nomesSemRep[MAX_LINHAS][MAX_PALAVRAS]; // nomes armazenados sem repetições
    int contParaCada[MAX_LINHAS] = {0}; // contagem de cada nome, começam todos no 0
    int comp = 0; // nº de palavras unicas armazenadas em nomes
    int menorOc = 0;

    if (scanf("%d\n", &nlinhas) != 1) return 1;

    for (int i = 0; i < nlinhas; i++) {
        char linha[MAX_CARACTERES]; // linha
        if (fgets(linha, MAX_CARACTERES, stdin) == NULL) {
            return 1; // necessário usar esta função em vez do scanf por causa dos espaços
        }

        linha[strcspn(linha, "\n")] = '\0'; // vai substituir o \n de cada linha por \0

        char* cNome = strtok(linha, " "); // cada nome é separada quando o ' ' aparece

        while (cNome != NULL) { 

            if (comp == 0) {
                strcpy(nomesSemRep[comp], cNome);
                contParaCada[comp] += 1;
                comp++;
            } else {
                int j = 0;
                while (j < comp) {
                    if (strcmp(nomesSemRep[j], cNome) == 0) {
                        contParaCada[j] += 1;
                        break;
                    } 
                    else{
                        if(j == comp - 1){
                        strcpy(nomesSemRep[comp], cNome);
                        contParaCada[comp] += 1;
                        comp++;
                        break;
                        }
                    }
                    j++;
                }
            }
            cNome = strtok(NULL, " ");
        }
    }

    for (int j = 1; j < comp; j++) {
        if (contParaCada[j] < contParaCada[menorOc]) {
            menorOc = j;
        }
    }

    printf("%s\n", nomesSemRep[menorOc]);

    return 0;
}