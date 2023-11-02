
#include <stdio.h>
#include <stdlib.h>

/* Constantes */
const int NUM_TORRES = 3;

/* Variables globales */
int *torres;
int moveCount = 0; /* Variable para contar los movimientos */

void moverDiscos(int, int, int, int);

int main() {
    int num_discos;

    printf("\n### Hanoi grafico recursivo\n");
    printf("Introduce el número de discos: ");
    scanf("%d", &num_discos);

    torres = (int *)malloc((NUM_TORRES * num_discos + 5) * sizeof(int)); // Reservar memoria para las torres

    for (int i = 0; i < NUM_TORRES; i++)
        for (int j = 0; j <= num_discos; j++) torres[num_discos * i + j] = 0; // Inicializar las torres

    moverDiscos(num_discos, 0, 1, 2);

    printf("\nSe completaron %d movimientos.\n", moveCount);
    
    // Liberar la memoria reservada
    free(torres);

    return 0;
}

void moverDiscos(int n, int origen, int auxiliar, int destino) {
    if (n == 1) {
        printf("Mover el disco 1 desde la torre %d a la torre %d\n", origen, destino);
        moveCount++;
    } else {
        moverDiscos(n - 1, origen, destino, auxiliar);
        printf("Mover el disco %d desde la torre %d a la torre %d\n", n, origen, destino);
        moveCount++;
        moverDiscos(n - 1, auxiliar, origen, destino);
    }
}
