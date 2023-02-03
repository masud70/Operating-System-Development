;
; Function to load dh sectors from disc.
;

load_disc:
    pusha
    ; Store dx (dh) for further use.
    push dx

    mov ah, 0x02 ; select read subroutine
    mov al, dh   ; number of sectors to read

    ; Set addressing scheme (CHS) to respective registers.
    mov ch, 0x00 ; select cylinder
    mov dh, 0x00 ; select head
    mov cl, 0x02 ; select sector

    ; Execute loading and loaded data will be stored [es:bx] address.
    int 0x13
    jc disk_error ; if error (carry bit = 1)

    ; Check if required sectors are loaded successfully.
    pop dx
    cmp al, dh
    jne sectors_error

    popa
    ret


disk_error:
    mov bx, DISK_ERROR_MSG
    call print
    call print_nl

    ; Print the error code set by BIOS
    mov dh, ah
    call print_hex
    jmp exit_loop

sectors_error:
    mov bx, SECTORS_ERROR_MSG
    call print

exit_loop:
    jmp $

DISK_ERROR_MSG: db "Disk read error", 0
SECTORS_ERROR_MSG: db "Incorrect number of sectors read by BIOS", 0