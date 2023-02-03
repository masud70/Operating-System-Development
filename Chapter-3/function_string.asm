; 
; A simple boot sector program that demonstrates functions and string.
;

[org 0x7c00]

mov bx, hello
call print
call print_nl

mov bx, name
call print
call print_nl

mov bx, goodbye
call print
call print_nl

mov dx, 0x12AB
call print_hex
call print_nl

jmp $

; Include functions/subroutines
%include 'inc/print.asm'

hello:
    db 'Hello World',0
name:
    db 'My name is Masud Mazumder',0
goodbye:
    db 'Goodbye World',0

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55