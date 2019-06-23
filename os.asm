BITS 16

start:
        mov ax, 07C0h           ; Set up 4K stack space after this bootloader
        add ax, 288             ; (4096 + 512) / 16 bytes per paragraph
        mov ss, ax
        mov sp, 4096

        mov ax, 07C0h           ; Set data segment to where we're loaded
        mov ds, ax


        mov si, text_string     ; Put string position into SI
        call print_string       ; Call our string-printing routine

        jmp $                   ; Jump here - infinite loop!


        text_string db 'OS Bootloader for Prototyp Engineering v0.1', 0


print_string:                   ; Routine: output string in SI to screen
        mov ah, 0Eh             ; int 10h 'print char' BIOS function

.repeat:
        lodsb                   ; Get character from string
        cmp al, 0
        je .done                ; If char is zero, end of string
        int 10h                 ; Otherwise, print it
        jmp .repeat

.done:
        ret


        times 510-($-$$) db 0   ; fill the rest of the space of the bootloader with zero bytes 
        						; (bootloader must be 512 bytes so => 510 - the code below (0xAA55) - the code above
        dw 0xAA55               ; The standard PC boot signature, I don't really understand this part..
                                ; I guess it is just a header kind of ending