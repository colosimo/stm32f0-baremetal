# 2017, Aurelio Colosimo, <aurelio@aureliocolosimo.it>
# MIT License

ELF = stm32f0-demo.elf
BIN = stm32f0-demo.bin

# Cross compiling configuration
CROSS_COMPILE = arm-none-eabi-
CC              = $(CROSS_COMPILE)gcc
AR              = $(CROSS_COMPILE)ar
LD              = $(CROSS_COMPILE)ld
OBJCOPY         = $(CROSS_COMPILE)objcopy
STRIP           = $(CROSS_COMPILE)strip

CFLAGS += -mthumb -Wall -Werror -Os -mcpu=cortex-m0 -ggdb -nostartfiles -ffreestanding

INCFLAGS += -Iinclude
OBJS += init.o
OBJS += kprint.o
OBJS += main.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $(INCFLAGS) -o $@ $<

$(ELF): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -Tstm32f0xx.ld -o $(ELF)

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $(ELF) $(BIN)

clean:
	rm -f $(OBJS) $(ELF) $(BIN)

flash: $(BIN)
	st-flash write $(BIN) 0x8000000

.PHONY: clean
