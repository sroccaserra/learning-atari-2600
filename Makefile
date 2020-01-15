ASM_FILES = $(wildcard *.asm)
BIN_FILES = $(ASM_FILES:.asm=.bin)

all: $(BIN_FILES)

%.bin: %.asm
	dasm $< -o$@ -Iinclude -f3

clean:
	rm *.bin
