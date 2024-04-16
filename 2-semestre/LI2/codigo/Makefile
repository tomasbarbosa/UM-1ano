CFLAGS=-Wall -Wextra -pedantic -O2 // criação de uma variavel (CFLAGS) que tem as flags de compilação

LIBS=-lm -lcurses 

jogo: main.o mapa.o // criação de um ramo de execução da makefile
	$(CC) $(CFLAGS) //main.o mapa.o -o $@ $^ $(LIBS)
	

/*
main.o: main.c
	gcc $(CFLAGS) main.c	
*/
	

clean:
	rm jogo *.o
