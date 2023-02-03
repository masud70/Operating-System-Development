;
; Entring into the 32-bit procted mode
;

[org 0x7c00]            ; bootloader offset
    mov bp, 0x9000      ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print          ; This will be written after the BIOS messages

    call switch_to_pm   ; Entry point to switch to the PM
    jmp $               ; this will actually never be executed

%include "../Chapter-3/inc/print.asm"
%include "inc/gdt.asm"
%include "inc/protected-mode-print.asm"
%include "inc/switch.asm"

; Finally protected mode starts from here.
[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; bootsector
times 510-($-$$) db 0
dw 0xaa55