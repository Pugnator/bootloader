
_reboot:
	int 16h
	int 19h

_printC:
	mov bp,sp
	mov ah, 0ah
	mov bx,0h
	int 10h
	mov sp,bp
	ret

_printS:
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

_cursor_off:
	mov dh,25
	mov dl,0h
	mov ah,2h
	int 10h
	ret

anykey:
	mov ah, 0h
	int 16h
	ret