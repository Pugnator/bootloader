%ifndef HELPER_ASM 
%define HELPER_ASM 
reboot:
	int 16h
	int 19h

_printC:
	push bp	
	mov cx, 1
	mov ah, 0ah
	mov bx,0h
	int 10h
	pop bp
	ret

_printS:	
	push bp
cont:
	lodsb
	or al,al
	jz dne
	mov ah, 0eh
	mov bx,0h
	int 10h
	jmp cont
dne:
	pop bp	
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

ldsec:
	push bp

	pop bp
	ret

%endif