; 
; A simple boot sector program that demonstrates the stack.
;

mov ah , 0x0e

; Set the base of the stack a little above where BIOS
mov bp , 0x8000

; loads our boot sector - so it won ’t overwrite us.
mov sp , bp 

; Push values to the stack
push 'M'
push 'A'
push 'S'
push 'U'
push 'D'

; Pop and print the values
pop bx
mov al , bl
int 0x10

pop bx
mov al , bl
int 0x10

pop bx
mov al , bl
int 0x10

pop bx
mov al , bl
int 0x10

; To prove our stack grows downwards from bp ,
; fetch the char at 0 x8000 - 0x2
mov al , [0x7ffe]
int 0x10

jmp $

; Padding and magic BIOS number.
times 510-($-$$) db 0
dw 0xaa55