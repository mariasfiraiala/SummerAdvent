NASM = nasm
AFILES = challenge3-b.asm
OBJS = $(AFILES:.asm=.o)
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = challenge3-b

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $< -g

clean:
	rm -f *.o $(BINARIES) *.s
	rm -f *~
