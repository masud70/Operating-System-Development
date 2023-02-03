;
; Function for printing a string received in bx and ended with a character '0'.
;
print:
    ; First push all the registers into the stack
    pusha

    start:
        mov al, [bx]
        ; Check for the end of a string and goto done
        cmp al, 0 
        je done

        ; Print a character
        mov ah, 0x0e
        int 0x10

        ; increment pointer and do next loop
        add bx, 1
        jmp start

    done:
        popa
        ret


;
; Function for printing a new line.
;
print_nl:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10
    
    popa
    ret

;
; Function for printing hex values receiving in dx.
;
print_hex:
    pusha
    mov cx, 0

    start1:
        cmp cx, 4
        je done1

        ror dx, 12
        mov ax, dx
        and ax, 0x000f
        add al, 0x30
        cmp al, 0x39
        jle display
        add al, 7
    
    display:
        mov ah, 0x0e
        int 0x10

        inc cx
        jmp start1
    
    done1:
        popa
        ret
