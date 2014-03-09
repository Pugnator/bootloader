%ifndef MACRO_ASM
%define MACRO_ASM

%define CUR_ROW dh
%define CUR_COL dl
%define KBD_KEY al
%define SERVICE ah
col db 0

%imacro printS 1	
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

%imacro readchar 0	
	mov ah, 0
	int 16h
%endmacro

%imacro echo 0		
	mov bh, 0
	mov ah, 03h
	int 10h	
	mov [col], CUR_COL
%%loop:
	readchar
	cmp KBD_KEY, 0dh
	je	%%exit
	printc KBD_KEY
	mov cl, [col]
	inc cl
	mov [col], cl
	mov CUR_COL, [col]
	mov SERVICE, 2h
	int 10h
	jmp %%loop
%%exit:
%endmacro

%endif