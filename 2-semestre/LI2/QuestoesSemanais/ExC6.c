#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// Define a struct que representa um pedido
typedef struct {
    int numPedido;
    char diff;
    int preco;
} Pedido;

// Função que compara dois pedidos para a ordenação
// Retorna < 0 se p1 < p2, 0 se p1 == p2, > 0 se p1 > p2
int compare(const void *a, const void *b) {
    Pedido *p1 = (Pedido *) a;
    Pedido *p2 = (Pedido *) b;

    // Compara o preço dos pedidos
    if (p1->preco != p2->preco) {
        return p2->preco - p1->preco;
    } else {
        // Se os preços forem iguais, compara as letras
        return p1->diff - p2->diff;
    }
}

int main() {
    int numeroPedidos;
    if(scanf("%d", &numeroPedidos) != 1) return 1;

    // Define um array de pedidos com tamanho máximo de 1000 elementos
    Pedido pedidos[1000];

    // Lê os dados de cada pedido do input
    for (int i = 0; i < numeroPedidos; i++) {
        if(scanf("%d %c %d", &pedidos[i].numPedido, &pedidos[i].diff, &pedidos[i].preco) != 3) return 3;
    }

    // Ordena o array de pedidos usando a função compare
    qsort(pedidos, numeroPedidos, sizeof(Pedido), compare);

    // Imprime os dados de cada pedido ordenado
    for (int i = 0; i < numeroPedidos; i++) {
        printf("%d %c %d\n", pedidos[i].numPedido, pedidos[i].diff, pedidos[i].preco);
    }

    return 0;
}