; 
; A simple boot sector program that demonstrates addressing.
;

[ org 0x7c00 ]
mov ah, 0x0e

; attempt 1
mov al, "1"
int 0x10
mov al, the_secret
int 0x10
; As it tries to print the memory address, so it fails to print 'X'

; attempt 2
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10
; The bootsector places binary from 0x7c00 and 'org' instruction defines global offset 0x7c00
; So it tries to print the memory address of 'the_secret' + 0x7c00
; which is the correct approach and it finally prints 'X'.

; attempt 3
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10
; This time 0x7c00 is added twice and it fails to prints 'X'.

; attempt 4
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10
; It also works as it tries to print 'X' the actual memory
; location without any memory references.

jmp $

the_secret:
    db "X"

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55