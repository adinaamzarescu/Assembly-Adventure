CC=gcc
CFLAGS=-m32 -fno-pie -no-pie
ASM=nasm
ASMFLAGS=-f elf32
MAKEFLAGS=--silent


checker: checker.o task3.o
	$(CC) $(CFLAGS) -o checker $^
task3.o: task3.asm
	$(ASM) $(ASMFLAGS) $< -o $@
checker.o: checker.c

check:
	./check.sh

copy:
	if [ -f ../../task3.asm ]; then cp ../../task3.asm .; else cp ../task3.asm .; fi

clean: 
	rm checker *.o
