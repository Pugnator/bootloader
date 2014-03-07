CPU 8086
USE16
[org 0]

SECTION .text
jmp 0x7c0:start
%include "macro.asm"
%include "helper.asm"

start:		
	push cs
	pop ds	
	set_video
	prints (booting_text)	
	prints (select_text)	
choose:
	readchar
	cmp KBD_KEY, '1'
	je shell
	cmp KBD_KEY, '2'
	je reset
	prints (input_error)	
	jmp choose
reset:
	call reboot
shell:
	prints (shell_welcome)
	prints (shell_msg)
	forever


booting_text db 'Started OK. v0.1a by Lavrenty Ivanov', 10, 13, 0
select_text db 'Choose what to do next:', 10, 13, '[1] Bring me to the shell', 10, 13, '[2] Reboot', 10, 13, 0
input_error db 'Input error, repeat',10,13,0
shell_welcome db 'Type "help" for command list',10,13, 0
shell_msg db '$>',0

times 510 - ($-$$) db 0
dw 0xaa55

