NASM = nasm
AFILES = challenge2.asm
OBJS = $(AFILES:.asm=.o)
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = challenge2

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $< -g

clean:
	rm -f *.o $(BINARIES) *.s
	rm -f *~
