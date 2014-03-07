[bits 16]
[org 0]

jmp 0x7c0:start
%include "macro.asm"
%include "helper.asm"

start:		
	push cs
	pop ds	
	set_video
	printS(booting_text)		
	forever

booting_text db "Booting...", 10, 13, 0

times 510 - ($-$$) db 0xFF
dw 0xaa55

