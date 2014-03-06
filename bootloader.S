[bits 16]
[org 0]


section .text

jmp 0x7c0:start

print:
	mov bp,sp
cont:
	lodsb
	or al,al
	jz dne
	mov ah, 0eh
	mov bx,0h
	int 10h
	jmp cont
dne:
	mov sp,bp
	ret

start:
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov al,3h
	mov ah,0h
	int 10h	; Set 80x25 video mode
	mov si, booting_text
	call print
	mov dh,25	;Turn off the cursor
	mov dl,0h
	mov ah,2h
	int 10h
	mov ah, 0h
	int 16h

section .data
booting_text db "Booting the system...", 10,13,0

times 510 - ($-$$) db 0
dw 0xaa55
