#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

// Função que verifica se duas strings são anagramas
bool isAnagram(char *s1, char *s2) {
    int *freq = (int *) calloc(26, sizeof(int)); // Frequência de cada letra nas duas strings
    if (!freq) return false; // Verifica se a alocação deu certo

    int cs1 = strlen(s1);
    int cs2 = strlen(s2);

    // Conta as letras em s1
    for (int i = 0; i < cs1; i++) {
        if (s1[i] >= 'A' && s1[i] <= 'Z') freq[s1[i] - 'A']++;
    }

    // Conta as letras em s2 e subtrai da frequência de s1
    for (int i = 0; i < cs2; i++) {
        if (s2[i] >= 'A' && s2[i] <= 'Z') freq[s2[i] - 'A']--;
    }

    // Se todas as frequências forem zero, as strings são anagramas
    for (int i = 0; i < 26; i++) {
        if (freq[i] != 0) {
            free(freq); // Libera a memória alocada
            return false;
        }
    }

    free(freq); // Libera a memória alocada
    return true;
}

int main() {
    int n; // Número de casos

    if (scanf("%d", &n) != 1) return 1;

    for (int i = 0; i < n; i++) {
        int klinhas; // Número de linhas com nomes

        if (scanf("%d", &klinhas) != 1) return 1;

        char **nomes = (char **) malloc(klinhas * sizeof(char *)); // Array onde vai ficar guardado o nome de cada vilão
        if (!nomes) return 1; // Verifica se a alocação deu certo

        getchar(); // Consome o caractere '\n' após a leitura de klinhas

        for (int j = 0; j < klinhas; j++) {
            nomes[j] = (char *) malloc(100 * sizeof(char)); // Aloca espaço para a string na posição j
            if (!nomes[j]) return 1; // Verifica se a alocação deu certo
            if (fgets(nomes[j], 100, stdin) == NULL) return 1;
            if (nomes[j][0] != '\n') {
                nomes[j][strlen(nomes
