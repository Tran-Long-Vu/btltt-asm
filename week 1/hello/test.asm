; test app asm

section .data
    msg db "Hello world!", 0ah ; var 
    len equ $-msg

section .bss


section .text
    global main ; fucntion

main:
    
    
    ;call _write
    call _push
    call _end

    _write:      
        mov rsi, msg
        mov rdx, len       ; length of string to be printed

        mov rdi, 1          ; std output
        mov rax, 1         ; write mode
        syscall
        ret
    
    _push:
    mov al,[rsi] ; first char

    cmp al, 0x0; check null
    je _popdone

    ;push ax  ;
    jmp _next  ; loop:


    _next: 
        inc rsi
        jmp _push

    _popdone:
        xor rbx,rbx ; code zero
        pop rsi ; pop back into rsi
        cmp rbx, len
        jne _popdone ; if not =len, jump back
        ;pop rsi 
        ;ret
    _end:

        mov rax, 60 ; sys exit reg
        mov rdi, 0 ; exit successful with ouput 0
        
        syscall ; call kernel to end
