[bits 32]
[extern mainF]   ; Define calling point. Must have same name as kernel.c 'main' function
call mainF       ; Calls the C function. The linker will know where it is placed in memory
jmp $