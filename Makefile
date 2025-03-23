# Compiler and flags
CROSS_CC = i686-elf-gcc
CROSS_AS = nasm
QEMU = qemu-system-x86_64

# Directories
BOOT_DIR = boot
KERNEL_DIR = kernel
BUILD_DIR = build
INCLUDE_DIR = include

# Flags
CFLAGS = -ffreestanding -O2 -Wall -Wextra -I$(INCLUDE_DIR)
LDFLAGS = -ffreestanding -O2 -nostdlib
ASFLAGS = -f elf32

# Source files (to be added as we create them)
BOOT_SRC = $(wildcard $(BOOT_DIR)/*.asm)
KERNEL_SRC = $(wildcard $(KERNEL_DIR)/*.c)

# Object files
BOOT_OBJ = $(BOOT_SRC:.asm=.o)
KERNEL_OBJ = $(KERNEL_SRC:.c=.o)

# Final binary
OS_IMAGE = $(BUILD_DIR)/os.bin
ISO_IMAGE = $(BUILD_DIR)/os.iso

.PHONY: all clean run iso

all: $(OS_IMAGE)

$(OS_IMAGE): $(BOOT_OBJ) $(KERNEL_OBJ)
	@mkdir -p $(BUILD_DIR)
	$(CROSS_CC) -T linker.ld -o $@ $(LDFLAGS) $^ -lgcc

%.o: %.c
	$(CROSS_CC) $(CFLAGS) -c $< -o $@

%.o: %.asm
	$(CROSS_AS) $(ASFLAGS) $< -o $@

iso: $(OS_IMAGE)
	@mkdir -p $(BUILD_DIR)/isodir/boot/grub
	cp $(OS_IMAGE) $(BUILD_DIR)/isodir/boot/
	cp grub.cfg $(BUILD_DIR)/isodir/boot/grub/
	grub-mkrescue -o $(ISO_IMAGE) $(BUILD_DIR)/isodir

run: $(ISO_IMAGE)
	$(QEMU) -cdrom $(ISO_IMAGE)

clean:
	rm -rf $(BUILD_DIR)/*
	rm -f $(BOOT_OBJ) $(KERNEL_OBJ)

# Debug target
debug: $(ISO_IMAGE)
	$(QEMU) -cdrom $(ISO_IMAGE) -s -S 