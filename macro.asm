%define kernel_offset 0x008000
%define kernel_start 0x01000000

%imacro printS 1
	mov al,3h
	mov ah,0h
	int 10h
	mov si, %1
	call _printS
%endmacro

%imacro printC 1
	mov al, %1
	call _printC
%endmacro

%imacro set_video 0
	mov al, 3
	mov ah, 0
	int 10h	
%endmacro

%imacro forever 0
%%loop:
	jmp %%loop
%endmacro