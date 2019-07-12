;print string using interrupts, works on macOS
;note that system interrupts in other OSes differ so it won't work on DOS or Linux
;
;code by Yuriy Georgiev (MiSSiNG in ByTES/TRSi)

SECTION .data

msg: db "a test string for to be printed!",10,0
msgLn: equ $-msg ;this $-msg means: <current memory offset> - msg (in bytes)

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

