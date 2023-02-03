;
; A simple boot sector program that reads data from disk drives.
;

[org 0x7c00]

; Set stack
mov bp, 0x8000
mov sp, bp

mov bx, 0x9000
mov dh, 2 ; to read 2 sectors
; the BIOS sets 'dl' for our boot disk number

call start_loading
call load_disc
call end_loading

; If loading is successful, then we retrieve some data
; to verify loaded data.
mov dx, [0x9000] ; first loaded word
call print_hex
call print_nl

mov dx, [0x9000 + 512] ; first loaded word from second loaded sector
call print_hex
call print_nl

jmp $


start_loading:
    pusha
    mov bx, START_MSG
    call print
    call print_nl
    popa
    ret

end_loading:
    pusha
    mov bx, END_MSG
    call print
    call print_nl
    popa
    ret

%include "inc/print.asm"
%include "inc/disc_loader.asm"

START_MSG: db 'Disc loading started',0
END_MSG: db 'Disc loading ended successfully',0

; Magic number
times 510 - ($-$$) db 0
dw 0xaa55

; Initialize 2nd and 3rd sectors with some predefined data to verify loading.
times 256 dw 0x1234
times 256 dw 0xABCD

