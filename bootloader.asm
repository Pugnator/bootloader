; ==================================================================
; START OF BOOTLOADER
; ==================================================================


CPU 8086
USE16

[org 7C00h]

section .text
jmp short start
%include "macro.asm"
%include "helper.asm"

start:		
	push cs
	pop ds	
	set_video
	prints (booting_text)	
	prints (select_text)		
select:
	readchar
	cmp KBD_KEY, '1'
	je shell
	cmp KBD_KEY, '2'
	je ldkrn
	cmp KBD_KEY, '3'
	je reset
	prints (input_error)	
	jmp select
ldkrn:
	call load_kernel
	jmp done
reset:
	call reboot
shell:
	prints (shell_welcome)
	prints (shell_msg)
done:	
	jmp $

booting_text db 'Started OK. v0.1a by Lavrenty Ivanov', 10, 13, 0
select_text db 'Choose what to do next:', 10, 13, '[1] Bring me to the shell', 10, 13, '[2] Load Linux kernel', 10, 13, '[3] Reboot', 10, 13, 0
input_error db 'Input error, repeat',10,13,0
shell_welcome db 'Type "help" for command list',10,13, 0
shell_msg db '$>',0
help_msg db "Available commands: HELP, REBOOT", 10, 13, 0
kernel_load_error_msg db "Error reading the disk", 10, 13, 0	
times 510 - ($-$$) db 0
dw 0xaa55

