#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {  // struct de cozinheiro, aonde vai ter as informações sobre os cozinheiros
    char nome[100];
    int peso;
    int altura;
} Cozinheiro;

int comparar(const void *a, const void *b) {
    int pesoideal = 90;
    Cozinheiro *fstCozinheiro = (Cozinheiro *) a;
    Cozinheiro *sndCozinheiro = (Cozinheiro *) b;

    // Compara pelo peso mais próximo de 90
    int pesoProxA = abs(fstCozinheiro->peso - pesoideal);
    int pesoProxB = abs(sndCozinheiro->peso - pesoideal);

    if (pesoProxA!= pesoProxB) {
        return pesoProxA - pesoProxB;
    }

    // Se os pesos forem iguais, compara pela altura
    if (fstCozinheiro->altura != sndCozinheiro->altura) {
        return sndCozinheiro->altura - fstCozinheiro->altura;
    }

    // Se a altura for igual, compara pelo nome
    return strcmp(fstCozinheiro->nome, sndCozinheiro->nome);
}

int main() {
    int n;
    if(scanf("%d", &n) != 1) return 1;

    Cozinheiro cozinheiros[n];

    for (int i = 0; i < n; i++) {
        if(scanf("%s %d %d", cozinheiros[i].nome, &cozinheiros[i].peso, &cozinheiros[i].altura) != 3) return 3;
    }

    qsort(cozinheiros, n, sizeof(Cozinheiro), comparar); // aula de PI

    for (int i = 0; i < n; i++) {
        printf("%s %d %d\n", cozinheiros[i].nome, cozinheiros[i].peso, cozinheiros[i].altura);
    }

    return 0;
}