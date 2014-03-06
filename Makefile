ASM:=nasm

SRC=bootloader.S

FLAGS+=

EXEC:=runme.com
RAWIMAGE:=disk.img
IMAGESIZE:=2880
VMDK:=dos.vmdk

all: $(EXEC)
	
$(EXEC):
	$(ASM) -O0 -f bin $(SRC) -o $(EXEC)
	dd if=/dev/zero of=$(RAWIMAGE) bs=512 count=$(IMAGESIZE)
	dd if=$(EXEC) of=$(RAWIMAGE) conv=notrunc
	VBoxManage internalcommands createrawvmdk \
	-filename $(VMDK) -rawdisk $(RAWIMAGE)

clean:
	rm -f *.o $(EXEC) $(RAWIMAGE) $(VMDK)
