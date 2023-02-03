; 
; A simple boot sector program that demonstrates addressing.
;
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
; It tries to print the memory address of 'the_secret'
; which is the correct approach but the bootsector places
; binary from 0x7c00 and because of this it fails to print 'X'

; attempt 3
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10
; This is the correct approach in this situation and successfully prints 'X

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
