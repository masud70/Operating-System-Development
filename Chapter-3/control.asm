; 
; A simple boot sector program that demonstrates the control statements (i.e. If else).
;

; C version
;
; if(bx == 0xA){
;     printf('Y');
; }else{
;     printf('N');
; }

mov ah , 0x0e

; Move a value to compare with
mov bx, 0xA

; Compare and jump accordingly
cmp bx, 0xB
je if
jmp else

; If block
if:
    mov al, 'Y'
    int 0x10
    jmp exit

; Else block
else:
    mov al, 'N'
    int 0x10
    jmp exit

exit:


jmp $

; Padding and magic BIOS number.
times 510-($-$$) db 0
dw 0xaa55