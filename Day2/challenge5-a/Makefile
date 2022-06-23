.PHONY: all clean run build

all: main

challenge5-a.o: challenge5-a.asm
	nasm -f elf $^ -o $@

main.o: main.c
	gcc -c -g -m32 $^ -o $@

main: main.o  challenge5-a.o
	gcc -m32 -g $^ -o $@
	rm *.o

clean:
	rm -f main