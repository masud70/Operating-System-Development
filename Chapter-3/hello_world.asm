;
; A simple boot sector that prints a message to the screen using a BIOS routine.
;

mov ah , 0x0e

mov al , 'H'
int 0x10
mov al , 'e'
int 0x10
mov al , 'l'
int 0x10
mov al , 'l'
int 0x10
mov al , 'o'
int 0x10

mov al , 'W'
int 0x10
mov al , 'o'
int 0x10
mov al , 'r'
int 0x10
mov al , 'l'
int 0x10
mov al , 'd'
int 0x10

jmp $

times 510 -($-$$) db 0 ; Pad the boot sector out with zeros
dw 0xaa55 ; Magic number