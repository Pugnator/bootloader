ASM:=nasm
SRC=bootloader.asm
UUID:=baedbe8c-0eb7-461f-a0e8-58224747ac3f
EXEC:=bootloader.com
RAWIMAGE:=disk.img
IMAGESIZE:=1
VHD:=dos.vhd
KERNEL:=vmlinux

all: $(EXEC)
	
$(EXEC):
	$(ASM) -w+orphan-labels $(SRC) -O0 -fbin -o $(EXEC)
	dd if=/dev/zero of=$(RAWIMAGE) bs=512 count=$(IMAGESIZE)
	dd if=$(EXEC) of=$(RAWIMAGE) conv=notrunc
	#dd if=$(KERNEL) of=$(RAWIMAGE) oflag=append conv=notrunc
	VBoxManage convertfromraw $(RAWIMAGE) $(VHD) --format VHD --uuid $(UUID)

clean:
	rm -f *.o $(EXEC) $(RAWIMAGE) $(VHD)
