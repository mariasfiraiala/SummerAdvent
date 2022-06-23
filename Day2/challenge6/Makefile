.PHONY: all clean run build

all: main

challenge6.o: challenge6.asm
	nasm -f elf $^ -o $@

main.o: main.c
	gcc -c -g -m32 $^ -o $@

main: main.o  challenge6.o
	gcc -m32 -g $^ -o $@
	rm *.o

clean:
	rm -f main