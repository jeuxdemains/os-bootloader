SECTION .data

msg: db "a test string!",10,0
msgLn: equ $-msg

SECTION .text

global start

start:
	mov ecx, 3

printmsg:
	push 0fh 	;str len
	push msg 	;str addr
	push 01h 	;a pring function
	mov eax, 4
	sub esp, 4
	int 80h		;sys call
	add esp, 16
	loop printmsg

quit:
	;quit to the system
	push 00h
	mov eax, 1
	sub esp, 12
	int 80h

