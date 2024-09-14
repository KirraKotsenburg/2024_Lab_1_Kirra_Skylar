hello.txt:
	echo "hello world!" > hello.txt

PICO_TOOLCHAIN_PATH?=~/.pico-sdk/toolchain/13_2_Rel1
CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp

main.i: main.c
	$(CPP) main.c > main.i

# This detects the operating system and uses the appropriate command based on that
clean:
# Remove build artifacts
	ifeq ($(OS),Windows_NT)
		del /Q main.i hello.txt
	else
		rm -f main.i hello.txt
	endif


.PHONY: clean

