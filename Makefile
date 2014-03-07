ASM:=nasm
SRC=bootloader.asm
EXEC:=bootloader.com
RAWIMAGE:=disk.img
IMAGESIZE:=1
VMDK:=dos.vmdk
KERNEL:=vmlinux

all: $(EXEC)
	
$(EXEC):
	$(ASM) $(SRC) -O0 -fbin -o $(EXEC)
	dd if=/dev/zero of=$(RAWIMAGE) bs=1440k count=$(IMAGESIZE)
	dd if=$(EXEC) of=$(RAWIMAGE) conv=notrunc
	#dd if=$(KERNEL) of=$(RAWIMAGE) oflag=append conv=notrunc
	#VBoxManage internalcommands createrawvmdk -filename $(VMDK) -rawdisk $(RAWIMAGE)

clean:
	rm -f *.o $(EXEC) $(RAWIMAGE) $(VMDK)
