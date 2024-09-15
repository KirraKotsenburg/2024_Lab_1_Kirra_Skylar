CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp

# all dependent on firmware.elf
all: firmware.elf

hello.txt:
	echo "hello world!" > hello.txt

main.i: main.c
	$(CPP) main.c > main.i

# Remove build artifacts
clean:
	rm -f main.i hello.txt second.o main.o main.s firmware.elf

.PHONY: clean all

CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as

main.s: main.i
	$(CC) -S main.i

# Implicit rule
%.o: %.s
	$(AS) $< -o $@

# Linker Set up
LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld
SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

firmware.elf: $(OBJS)
	$(LD) -o $@ $^