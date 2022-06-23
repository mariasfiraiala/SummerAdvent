.PHONY: all clean run build

all: main

challenge5-b.o: challenge5-b.asm
	nasm -f elf $^ -o $@

main.o: main.c
	gcc -c -g -m32 $^ -o $@

main: main.o  challenge5-b.o
	gcc -m32 -g $^ -o $@ -g
	rm *.o

clean:
	rm -f main