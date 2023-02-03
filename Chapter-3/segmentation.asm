;
; A simple boot sector program that demonstrates manipulation of data segments.
;

mov ah, 0x0e

mov al, [the_secret]
int 0x10
; This doesn't work already seen before.

; Load 0x7c0 to ds register which will add offset 0x7c0 * 16 = 0x7c00
mov bx, 0x7c0
mov ds, bx

mov al, [the_secret]
int 0x10
; this works fine.

mov al, [es:the_secret]
int 0x10
; As segment is mentioned as es which is currently 0x0000
; so this also doesn't work

; Load 0x7c0 to es register also
mov bx, 0x7c0
mov es, bx

mov al, [es:the_secret]
int 0x10
; This time it works fine.


jmp $

the_secret:
    db "X"

times 510 - ($-$$) db 0
dw 0xaa55